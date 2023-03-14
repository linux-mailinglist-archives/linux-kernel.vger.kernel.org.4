Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E466B8FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCNKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCNKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:20:34 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784A0DBD6;
        Tue, 14 Mar 2023 03:20:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id A504F40770A1;
        Tue, 14 Mar 2023 10:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A504F40770A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789084;
        bh=Ko+TCPxtXTmgiAPFvItJlt84hA2vloKjJve+WXAcKzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMjiBY/dKe3Wcd5V3LA9NtvkEhRRANayM8UQ+q4R0AzTvxpnV7UI62HOVBIqridRY
         nqKbmoC8Yd18+gXZCEOAoO9/7/iCCPtzI54Wk2cwogqszRm7ocuZGNeAr4lsHMhjab
         CMw3F8+tDwXg6PUwGv0XhYCupqxt+5CXAY/nX9Mc=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 19/27] x86/build: Cleanup tools/build.c
Date:   Tue, 14 Mar 2023 13:13:46 +0300
Message-Id: <60e16b48dda87091c10ba7e509920150e3064c9f.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use newer C standard. Since kernel requires C99 compiler now,
we can make use of the new features to make the core more readable.

Use mmap() for reading files also to make things simpler.

Replace most magic numbers with defines and use PE structure
definitions instead of raw offsets.

Should have no functional changes. This is done in preparation for the
following patches that make generated PE header more spec compliant.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/tools/build.c | 348 +++++++++++++++++++++++-------------
 1 file changed, 219 insertions(+), 129 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index bd247692b701..73e88d30ebce 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -35,11 +35,14 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <tools/le_byteshift.h>
+#include <linux/pe.h>
 
 typedef unsigned char  u8;
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
+#define round_up(x, n) (((x) + (n) - 1) & ~((n) - 1))
+
 #define DEFAULT_MAJOR_ROOT 0
 #define DEFAULT_MINOR_ROOT 0
 #define DEFAULT_ROOT_DEV (DEFAULT_MAJOR_ROOT << 8 | DEFAULT_MINOR_ROOT)
@@ -48,8 +51,13 @@ typedef unsigned int   u32;
 #define SETUP_SECT_MIN 5
 #define SETUP_SECT_MAX 64
 
+#define PARAGRAPH_SIZE 16
+#define SECTOR_SIZE 512
+#define FILE_ALIGNMENT 512
+#define SECTION_ALIGNMENT 4096
+
 /* This must be large enough to hold the entire setup */
-u8 buf[SETUP_SECT_MAX*512];
+u8 buf[SETUP_SECT_MAX*SECTOR_SIZE];
 
 #define PECOFF_RELOC_RESERVE 0x20
 
@@ -59,6 +67,40 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
+#define RELOC_SECTION_SIZE 10
+
+/* PE header has different format depending on the architecture */
+#ifdef CONFIG_X86_64
+typedef struct pe32plus_opt_hdr pe_opt_hdr;
+#else
+typedef struct pe32_opt_hdr pe_opt_hdr;
+#endif
+
+static inline struct pe_hdr *get_pe_header(u8 *buf)
+{
+	u32 pe_offset = get_unaligned_le32(buf+MZ_HEADER_PEADDR_OFFSET);
+	return (struct pe_hdr *)(buf + pe_offset);
+}
+
+static inline pe_opt_hdr *get_pe_opt_header(u8 *buf)
+{
+	return (pe_opt_hdr *)(get_pe_header(buf) + 1);
+}
+
+static inline struct section_header *get_sections(u8 *buf)
+{
+	pe_opt_hdr *hdr = get_pe_opt_header(buf);
+	u32 n_data_dirs = get_unaligned_le32(&hdr->data_dirs);
+	u8 *sections = (u8 *)(hdr + 1) + n_data_dirs*sizeof(struct data_dirent);
+	return  (struct section_header *)sections;
+}
+
+static inline struct data_directory *get_data_dirs(u8 *buf)
+{
+	pe_opt_hdr *hdr = get_pe_opt_header(buf);
+	return (struct data_directory *)(hdr + 1);
+}
+
 static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
@@ -152,40 +194,86 @@ static void usage(void)
 	die("Usage: build setup system zoffset.h image");
 }
 
+static void *map_file(const char *path, size_t *psize)
+{
+	struct stat statbuf;
+	size_t size;
+	void *addr;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		die("Unable to open `%s': %m", path);
+	if (fstat(fd, &statbuf))
+		die("Unable to stat `%s': %m", path);
+
+	size = statbuf.st_size;
+	/*
+	 * Map one byte more, to allow adding null-terminator
+	 * for text files.
+	 */
+	addr = mmap(NULL, size + 1, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (addr == MAP_FAILED)
+		die("Unable to mmap '%s': %m", path);
+
+	close(fd);
+
+	*psize = size;
+	return addr;
+}
+
+static void unmap_file(void *addr, size_t size)
+{
+	munmap(addr, size + 1);
+}
+
+static void *map_output_file(const char *path, size_t size)
+{
+	void *addr;
+	int fd;
+
+	fd = open(path, O_RDWR | O_CREAT, 0660);
+	if (fd < 0)
+		die("Unable to create `%s': %m", path);
+
+	if (ftruncate(fd, size))
+		die("Unable to resize `%s': %m", path);
+
+	addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED)
+		die("Unable to mmap '%s': %m", path);
+
+	return addr;
+}
+
 #ifdef CONFIG_EFI_STUB
 
 static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
 {
-	unsigned int pe_header;
 	unsigned short num_sections;
-	u8 *section;
+	struct section_header *section;
 
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-	num_sections = get_unaligned_le16(&buf[pe_header + 6]);
-
-#ifdef CONFIG_X86_32
-	section = &buf[pe_header + 0xa8];
-#else
-	section = &buf[pe_header + 0xb8];
-#endif
+	struct pe_hdr *hdr = get_pe_header(buf);
+	num_sections = get_unaligned_le16(&hdr->sections);
+	section = get_sections(buf);
 
 	while (num_sections > 0) {
-		if (strncmp((char*)section, section_name, 8) == 0) {
+		if (strncmp(section->name, section_name, 8) == 0) {
 			/* section header size field */
-			put_unaligned_le32(size, section + 0x8);
+			put_unaligned_le32(size, &section->virtual_size);
 
 			/* section header vma field */
-			put_unaligned_le32(vma, section + 0xc);
+			put_unaligned_le32(vma, &section->virtual_address);
 
 			/* section header 'size of initialised data' field */
-			put_unaligned_le32(datasz, section + 0x10);
+			put_unaligned_le32(datasz, &section->raw_data_size);
 
 			/* section header 'file offset' field */
-			put_unaligned_le32(offset, section + 0x14);
+			put_unaligned_le32(offset, &section->data_addr);
 
 			break;
 		}
-		section += 0x28;
+		section++;
 		num_sections--;
 	}
 }
@@ -197,7 +285,7 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
 
 static void update_pecoff_setup_and_reloc(unsigned int size)
 {
-	u32 setup_offset = 0x200;
+	u32 setup_offset = SECTOR_SIZE;
 	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
 #ifdef CONFIG_EFI_MIXED
 	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
@@ -211,8 +299,8 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 	 * Modify .reloc section contents with a single entry. The
 	 * relocation is applied to offset 10 of the relocation section.
 	 */
-	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
-	put_unaligned_le32(10, &buf[reloc_offset + 4]);
+	put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, &buf[reloc_offset]);
+	put_unaligned_le32(RELOC_SECTION_SIZE, &buf[reloc_offset + 4]);
 
 #ifdef CONFIG_EFI_MIXED
 	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
@@ -224,19 +312,17 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 	 */
 	buf[compat_offset] = 0x1;
 	buf[compat_offset + 1] = 0x8;
-	put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
+	put_unaligned_le16(IMAGE_FILE_MACHINE_I386, &buf[compat_offset + 2]);
 	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
+static unsigned int update_pecoff_sections(unsigned int text_start, unsigned int text_sz,
 			       unsigned int init_sz)
 {
-	unsigned int pe_header;
-	unsigned int text_sz = file_sz - text_start;
+	unsigned int file_sz = text_start + text_sz;
 	unsigned int bss_sz = init_sz - file_sz;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
+	pe_opt_hdr *hdr = get_pe_opt_header(buf);
 
 	/*
 	 * The PE/COFF loader may load the image at an address which is
@@ -254,28 +340,30 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
 	 */
-	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
+	put_unaligned_le32(file_sz - SECTOR_SIZE + bss_sz, &hdr->text_size);
 
 	/* Size of image */
-	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
+	put_unaligned_le32(init_sz, &hdr->image_size);
 
 	/*
 	 * Address of entry point for PE/COFF executable
 	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
+	put_unaligned_le32(text_start + efi_pe_entry, &hdr->entry_point);
 
 	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
 					    text_sz, text_start);
+
+	return text_start + file_sz;
 }
 
 static int reserve_pecoff_reloc_section(int c)
 {
-	/* Reserve 0x20 bytes for .reloc section */
+	/* Reserve space for .reloc section */
 	memset(buf+c, 0, PECOFF_RELOC_RESERVE);
 	return PECOFF_RELOC_RESERVE;
 }
 
-static void efi_stub_defaults(void)
+static void efi_stub_update_defaults(void)
 {
 	/* Defaults for old kernel */
 #ifdef CONFIG_X86_32
@@ -298,7 +386,7 @@ static void efi_stub_entry_update(void)
 
 #ifdef CONFIG_EFI_MIXED
 	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
+		die("32-bit and 64-bit EFI entry points do not match");
 #endif
 #endif
 	put_unaligned_le32(addr, &buf[0x264]);
@@ -310,7 +398,7 @@ static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz,
 				      unsigned int init_sz) {}
-static inline void efi_stub_defaults(void) {}
+static inline void efi_stub_update_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
@@ -321,7 +409,7 @@ static inline int reserve_pecoff_reloc_section(int c)
 
 static int reserve_pecoff_compat_section(int c)
 {
-	/* Reserve 0x20 bytes for .compat section */
+	/* Reserve space for .compat section */
 	memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
 	return PECOFF_COMPAT_RESERVE;
 }
@@ -338,20 +426,15 @@ static int reserve_pecoff_compat_section(int c)
 
 static void parse_zoffset(char *fname)
 {
-	FILE *file;
-	char *p;
-	int c;
+	size_t size;
+	char *data, *p;
 
-	file = fopen(fname, "r");
-	if (!file)
-		die("Unable to open `%s': %m", fname);
-	c = fread(buf, 1, sizeof(buf) - 1, file);
-	if (ferror(file))
-		die("read-error on `zoffset.h'");
-	fclose(file);
-	buf[c] = 0;
+	data = map_file(fname, &size);
+
+	/* We can do that, since we mapped one byte more */
+	data[size] = 0;
 
-	p = (char *)buf;
+	p = (char *)data;
 
 	while (p && *p) {
 		PARSE_ZOFS(p, efi32_stub_entry);
@@ -367,82 +450,99 @@ static void parse_zoffset(char *fname)
 		while (p && (*p == '\r' || *p == '\n'))
 			p++;
 	}
+
+	unmap_file(data, size);
 }
 
-int main(int argc, char ** argv)
+static unsigned int read_setup(char *path)
 {
-	unsigned int i, sz, setup_sectors, init_sz;
-	int c;
-	u32 sys_size;
-	struct stat sb;
-	FILE *file, *dest;
-	int fd;
-	void *kernel;
-	u32 crc = 0xffffffffUL;
-
-	efi_stub_defaults();
-
-	if (argc != 5)
-		usage();
-	parse_zoffset(argv[3]);
-
-	dest = fopen(argv[4], "w");
-	if (!dest)
-		die("Unable to write `%s': %m", argv[4]);
+	FILE *file;
+	unsigned int setup_size, file_size;
 
 	/* Copy the setup code */
-	file = fopen(argv[1], "r");
+	file = fopen(path, "r");
 	if (!file)
-		die("Unable to open `%s': %m", argv[1]);
-	c = fread(buf, 1, sizeof(buf), file);
+		die("Unable to open `%s': %m", path);
+
+	file_size = fread(buf, 1, sizeof(buf), file);
 	if (ferror(file))
 		die("read-error on `setup'");
-	if (c < 1024)
+
+	if (file_size < 2 * SECTOR_SIZE)
 		die("The setup must be at least 1024 bytes");
-	if (get_unaligned_le16(&buf[510]) != 0xAA55)
+
+	if (get_unaligned_le16(&buf[SECTOR_SIZE - 2]) != 0xAA55)
 		die("Boot block hasn't got boot flag (0xAA55)");
+
 	fclose(file);
 
-	c += reserve_pecoff_compat_section(c);
-	c += reserve_pecoff_reloc_section(c);
+	/* Reserve space for PE sections */
+	file_size += reserve_pecoff_compat_section(file_size);
+	file_size += reserve_pecoff_reloc_section(file_size);
 
 	/* Pad unused space with zeros */
-	setup_sectors = (c + 511) / 512;
-	if (setup_sectors < SETUP_SECT_MIN)
-		setup_sectors = SETUP_SECT_MIN;
-	i = setup_sectors*512;
-	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup_and_reloc(i);
+	setup_size = round_up(file_size, SECTOR_SIZE);
+
+	if (setup_size < SETUP_SECT_MIN * SECTOR_SIZE)
+		setup_size = SETUP_SECT_MIN * SECTOR_SIZE;
+
+	/*
+	 * Global buffer is already initialised
+	 * to 0, but just in case, zero out padding.
+	 */
+
+	memset(buf + file_size, 0, setup_size - file_size);
+
+	return setup_size;
+}
+
+int main(int argc, char **argv)
+{
+	size_t kern_file_size;
+	unsigned int setup_size;
+	unsigned int setup_sectors;
+	unsigned int init_size;
+	unsigned int total_size;
+	unsigned int kern_size;
+	void *kernel;
+	u32 crc = 0xffffffffUL;
+	u8 *output;
+
+	if (argc != 5)
+		usage();
+
+	efi_stub_update_defaults();
+	parse_zoffset(argv[3]);
+
+	setup_size = read_setup(argv[1]);
+
+	setup_sectors = setup_size/SECTOR_SIZE;
 
 	/* Set the default root device */
 	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
 
-	/* Open and stat the kernel file */
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0)
-		die("Unable to open `%s': %m", argv[2]);
-	if (fstat(fd, &sb))
-		die("Unable to stat `%s': %m", argv[2]);
-	sz = sb.st_size;
-	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
-	if (kernel == MAP_FAILED)
-		die("Unable to mmap '%s': %m", argv[2]);
-	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
-	sys_size = (sz + 15 + 4) / 16;
+	/* Map kernel file to memory */
+	kernel = map_file(argv[2], &kern_file_size);
+
 #ifdef CONFIG_EFI_STUB
-	/*
-	 * COFF requires minimum 32-byte alignment of sections, and
-	 * adding a signature is problematic without that alignment.
-	 */
-	sys_size = (sys_size + 1) & ~1;
+	/* PE specification require 512-byte minimum section file alignment */
+	kern_size = round_up(kern_file_size + 4, FILE_ALIGNMENT);
+	update_pecoff_setup_and_reloc(setup_size);
+#else
+	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
+	kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
-	put_unaligned_le32(sys_size, &buf[0x1f4]);
+	buf[0x1f1] = setup_sectors - 1;
+	put_unaligned_le32(kern_size/PARAGRAPH_SIZE, &buf[0x1f4]);
+
+	/* Update kernel_info offset. */
+	put_unaligned_le32(kernel_info, &buf[0x268]);
+
+	init_size = get_unaligned_le32(&buf[0x260]);
 
-	init_sz = get_unaligned_le32(&buf[0x260]);
 #ifdef CONFIG_EFI_STUB
 	/*
 	 * The decompression buffer will start at ImageBase. When relocating
@@ -458,45 +558,35 @@ int main(int argc, char ** argv)
 	 * For future-proofing, increase init_sz if necessary.
 	 */
 
-	if (init_sz - _end < i + _ehead) {
-		init_sz = (i + _ehead + _end + 4095) & ~4095;
-		put_unaligned_le32(init_sz, &buf[0x260]);
+	if (init_size - _end < setup_size + _ehead) {
+		init_size = round_up(setup_size + _ehead + _end, SECTION_ALIGNMENT);
+		put_unaligned_le32(init_size, &buf[0x260]);
 	}
-#endif
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
 
-	efi_stub_entry_update();
+	total_size = update_pecoff_sections(setup_size, kern_size, init_size);
 
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
-
-	crc = partial_crc32(buf, i, crc);
-	if (fwrite(buf, 1, i, dest) != i)
-		die("Writing setup failed");
+	efi_stub_entry_update();
+#else
+	(void)init_size;
+	total_size = setup_size + kern_size;
+#endif
 
-	/* Copy the kernel code */
-	crc = partial_crc32(kernel, sz, crc);
-	if (fwrite(kernel, 1, sz, dest) != sz)
-		die("Writing kernel failed");
+	output = map_output_file(argv[4], total_size);
 
-	/* Add padding leaving 4 bytes for the checksum */
-	while (sz++ < (sys_size*16) - 4) {
-		crc = partial_crc32_one('\0', crc);
-		if (fwrite("\0", 1, 1, dest) != 1)
-			die("Writing padding failed");
-	}
+	memcpy(output, buf, setup_size);
+	memcpy(output + setup_size, kernel, kern_file_size);
+	memset(output + setup_size + kern_file_size, 0, kern_size - kern_file_size);
 
-	/* Write the CRC */
-	put_unaligned_le32(crc, buf);
-	if (fwrite(buf, 1, 4, dest) != 4)
-		die("Writing CRC failed");
+	/* Calculate and write kernel checksum. */
+	crc = partial_crc32(output, total_size - 4, crc);
+	put_unaligned_le32(crc, &output[total_size - 4]);
 
-	/* Catch any delayed write failures */
-	if (fclose(dest))
-		die("Writing image failed");
+	/* Catch any delayed write failures. */
+	if (munmap(output, total_size) < 0)
+		die("Writing kernel failed");
 
-	close(fd);
+	unmap_file(kernel, kern_file_size);
 
-	/* Everything is OK */
+	/* Everything is OK. */
 	return 0;
 }
-- 
2.39.2

