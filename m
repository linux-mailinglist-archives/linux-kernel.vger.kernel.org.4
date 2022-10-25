Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF1760CE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiJYOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiJYOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:14:08 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D99E2CB;
        Tue, 25 Oct 2022 07:14:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id AC68240737BA;
        Tue, 25 Oct 2022 14:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AC68240737BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707244;
        bh=z+gOXrqLY5wLcDwB2/ZR83ShFGZaZN4795+hsrSRPkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZwV5eS4gbvQSxNqh7akhSsG2vKEiakIZDTPIBMMSqVoYeUq2imUsijUTvZtFuWOC
         D0khM3sd6ocZn4hOuSOlXaNzG2AcrnHmu5THbP8wTyr99a2EIpOmz2zn4B/paT58Ln
         FAXrvBj1L9z21SJB6uxVP8D/PjO77mxdF/E/41fM=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 19/23] x86/build: Cleanup tools/build.c
Date:   Tue, 25 Oct 2022 17:12:57 +0300
Message-Id: <6686e70ad67071fe2144d429ffd4dd3c8b09f439.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
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

Replace most magic numbers with defines.

Should have no functional changes. This is done in preparation for the
next changes that makes generated PE header more spec compliant.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/tools/build.c | 387 +++++++++++++++++++++++-------------
 1 file changed, 245 insertions(+), 142 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a3725ad46c5a..9202645fec72 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -25,20 +25,21 @@
  * Substantially overhauled by H. Peter Anvin, April 2007
  */
 
+#include <fcntl.h>
+#include <stdarg.h>
+#include <stdint.h>
 #include <stdio.h>
-#include <string.h>
 #include <stdlib.h>
-#include <stdarg.h>
-#include <sys/types.h>
+#include <string.h>
+#include <sys/mman.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include <fcntl.h>
-#include <sys/mman.h>
+
 #include <tools/le_byteshift.h>
+#include <linux/pe.h>
 
-typedef unsigned char  u8;
-typedef unsigned short u16;
-typedef unsigned int   u32;
+#define round_up(x, n) (((x) + (n) - 1) & ~((n) - 1))
 
 #define DEFAULT_MAJOR_ROOT 0
 #define DEFAULT_MINOR_ROOT 0
@@ -48,8 +49,13 @@ typedef unsigned int   u32;
 #define SETUP_SECT_MIN 5
 #define SETUP_SECT_MAX 64
 
+#define PARAGRAPH_SIZE 16
+#define SECTOR_SIZE 512
+#define FILE_ALIGNMENT 512
+#define SECTION_ALIGNMENT 4096
+
 /* This must be large enough to hold the entire setup */
-u8 buf[SETUP_SECT_MAX*512];
+uint8_t buf[SETUP_SECT_MAX*SECTOR_SIZE];
 
 #define PECOFF_RELOC_RESERVE 0x20
 
@@ -59,6 +65,52 @@ u8 buf[SETUP_SECT_MAX*512];
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
+static inline struct pe_hdr *get_pe_header(uint8_t *buf)
+{
+	uint32_t pe_offset = get_unaligned_le32(buf+MZ_HEADER_PEADDR_OFFSET);
+	return (struct pe_hdr *)(buf + pe_offset);
+}
+
+static inline pe_opt_hdr *get_pe_opt_header(uint8_t *buf)
+{
+	return (pe_opt_hdr *)(get_pe_header(buf) + 1);
+}
+
+static inline struct section_header *get_sections(uint8_t *buf)
+{
+	pe_opt_hdr *hdr = get_pe_opt_header(buf);
+	uint32_t n_data_dirs = get_unaligned_le32(&hdr->data_dirs);
+	uint8_t *sections = (uint8_t *)(hdr + 1) + n_data_dirs*sizeof(struct data_dirent);
+	return  (struct section_header *)sections;
+}
+
+static inline struct data_directory *get_data_dirs(uint8_t *buf)
+{
+	pe_opt_hdr *hdr = get_pe_opt_header(buf);
+	return (struct data_directory *)(hdr + 1);
+}
+
+#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
+#define SCN_RW (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE | IMAGE_SCN_ALIGN_4096BYTES)
+#define SCN_RX (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_ALIGN_4096BYTES)
+#define SCN_RO (IMAGE_SCN_MEM_READ | IMAGE_SCN_ALIGN_4096BYTES)
+#else
+/* With memory protection disabled all sections are RWX */
+#define SCN_RW (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE | \
+		IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_ALIGN_4096BYTES)
+#define SCN_RX SCN_RW
+#define SCN_RO SCN_RW
+#endif
+
 static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
@@ -70,7 +122,7 @@ static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
-static const u32 crctab32[] = {
+static const uint32_t crctab32[] = {
 	0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419,
 	0x706af48f, 0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4,
 	0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07,
@@ -125,12 +177,12 @@ static const u32 crctab32[] = {
 	0x2d02ef8d
 };
 
-static u32 partial_crc32_one(u8 c, u32 crc)
+static uint32_t partial_crc32_one(uint8_t c, uint32_t crc)
 {
 	return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
 }
 
-static u32 partial_crc32(const u8 *s, int len, u32 crc)
+static uint32_t partial_crc32(const uint8_t *s, int len, uint32_t crc)
 {
 	while (len--)
 		crc = partial_crc32_one(*s++, crc);
@@ -152,57 +204,106 @@ static void usage(void)
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
 
-static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
+static void update_pecoff_section_header_fields(char *section_name, uint32_t vma,
+						uint32_t size, uint32_t datasz,
+						uint32_t offset)
 {
 	unsigned int pe_header;
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
 
-static void update_pecoff_section_header(char *section_name, u32 offset, u32 size)
+static void update_pecoff_section_header(char *section_name, uint32_t offset, uint32_t size)
 {
 	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
 }
 
 static void update_pecoff_setup_and_reloc(unsigned int size)
 {
-	u32 setup_offset = 0x200;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
+	uint32_t setup_offset = SECTOR_SIZE;
+	uint32_t reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
 #ifdef CONFIG_EFI_MIXED
-	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
+	uint32_t compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
 #endif
-	u32 setup_size = reloc_offset - setup_offset;
+	uint32_t setup_size = reloc_offset - setup_offset;
 
 	update_pecoff_section_header(".setup", setup_offset, setup_size);
 	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
@@ -211,8 +312,8 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 	 * Modify .reloc section contents with a single entry. The
 	 * relocation is applied to offset 10 of the relocation section.
 	 */
-	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
-	put_unaligned_le32(10, &buf[reloc_offset + 4]);
+	put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE, &buf[reloc_offset]);
+	put_unaligned_le32(RELOC_SECTION_SIZE, &buf[reloc_offset + 4]);
 
 #ifdef CONFIG_EFI_MIXED
 	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
@@ -224,19 +325,17 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
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
@@ -254,18 +353,20 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
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
@@ -275,7 +376,7 @@ static int reserve_pecoff_reloc_section(int c)
 	return PECOFF_RELOC_RESERVE;
 }
 
-static void efi_stub_defaults(void)
+static void efi_stub_update_defaults(void)
 {
 	/* Defaults for old kernel */
 #ifdef CONFIG_X86_32
@@ -297,7 +398,7 @@ static void efi_stub_entry_update(void)
 
 #ifdef CONFIG_EFI_MIXED
 	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
+		die("32-bit and 64-bit EFI entry points do not match");
 #endif
 	put_unaligned_le32(addr, &buf[0x264]);
 }
@@ -308,7 +409,7 @@ static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz,
 				      unsigned int init_sz) {}
-static inline void efi_stub_defaults(void) {}
+static inline void efi_stub_update_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
@@ -336,20 +437,15 @@ static int reserve_pecoff_compat_section(int c)
 
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
 
-	p = (char *)buf;
+	/* We can do that, since we mapped one byte more */
+	data[size] = 0;
+
+	p = (char *)data;
 
 	while (p && *p) {
 		PARSE_ZOFS(p, efi32_stub_entry);
@@ -365,82 +461,99 @@ static void parse_zoffset(char *fname)
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
+	uint32_t crc = 0xffffffffUL;
+	uint8_t *output;
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
+	kern_size = round_up(kern_file_size + 4, SECTOR_SIZE);
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
@@ -456,45 +569,35 @@ int main(int argc, char ** argv)
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
-
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
+	total_size = update_pecoff_sections(setup_size, kern_size, init_size);
 
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
2.37.4

