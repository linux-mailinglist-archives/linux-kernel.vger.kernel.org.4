Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6A6C3DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCUWtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCUWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:49:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EB19C49
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:49:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13so16961346pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1679438981;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bphvEfMSl5avwhfXJT15aKIJis5gqq3QZ/zSLwV7oM=;
        b=5Z9OtPiHsgOCytxq8aipGasjfx3iRy0mfHaVBZPnOUvMCszycDsXvonQ8kQyodP4/L
         ECqdYMKy5wC08CVXBVlpR//wm9q3Td6hRetBkJ2y96o+niLp5e9mUr1ENenKWlytMRe4
         RIKruTLDFb9A0OVtwZiTBvb+l02hkCOTMWPycvGcIvj8wqSNxWsIonpvST3ggbmYHkMH
         yOFVaDPtlT6D2NYYLh1v+vG4Hcyy8ET4ro1UuEoGEDbSUvJmXy6wBJy/5M11v1HfW9Ei
         biQR0mxjRoNeMH67NWCFV0K+e/aOLsWTUwN6jqWnaK5z5AeUbdihZd8F6NWa9uy95WH/
         HHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438981;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bphvEfMSl5avwhfXJT15aKIJis5gqq3QZ/zSLwV7oM=;
        b=XaCbHYpz8gCjkkqCSIcDJuYWp93JBkL1pLzhACzMU6czDGyvR5puQUUrbXHzFd8ug1
         C7RZ8MHSVA+1B9k0wjpUzj45UQpC0Y8mSYT0q8Dg1YhVhiHCZJnCQddKBlrpebH8IIgS
         2WLVnKJq/DPD/wFqWqPo6X00X2WAVSuqPVo9qUMf5Ota/2ViKKO2RgBiH6zNxwCRL4GP
         ryafIt+TZTSHdG8nMh3DO2HFba+jsbrgt1OVNgNk3Y7eCclR4bL4ydMAf9dBtYuFuAf2
         keKP32z7Josr01bzGEmjt6w7MS5cWm9d79kTALqKPDpVlyIM1DDR7k+YfbKxskRiR5+y
         t94w==
X-Gm-Message-State: AO0yUKVpVz7FBf6Pns3/G0Jp6ABTTbL6D3qSYIjdkT648anF1ABkH+i+
        V+SC5BvLlJ/93XKipiG6PpNjcQ==
X-Google-Smtp-Source: AK7set+mUTGkFgE2itKnrOD55dCbBCqULX8O3ptlcVutoVPy7M0q3dEkR5UkxDe6P+toJl+Ro2Jeeg==
X-Received: by 2002:a17:902:e5c3:b0:1a0:6d9e:3c78 with SMTP id u3-20020a170902e5c300b001a06d9e3c78mr740192plf.53.1679438980575;
        Tue, 21 Mar 2023 15:49:40 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902b60e00b001a1c6048fc8sm5736379pls.63.2023.03.21.15.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:49:40 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:49:40 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Mar 2023 15:48:41 PDT (-0700)
Subject:     Re: [PATCH 1/2] binfmt_elf_fdpic: support 64-bit systems
In-Reply-To: <20230228135126.1686427-2-gerg@kernel.org>
CC:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gerg@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     gerg@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org
Message-ID: <mhng-fec49316-5da9-4cab-af79-6115f13668c1@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 05:51:25 PST (-0800), gerg@kernel.org wrote:
> The binfmt_flat_fdpic code has a number of 32-bit specific data
> structures associated with it. Extend it to be able to support and
> be used on 64-bit systems as well.
>
> The new code defines a number of key 64-bit variants of the core
> elf-fdpic data structures - along side the existing 32-bit sized ones.
> A common set of generic named structures are defined to be either
> the 32-bit or 64-bit ones as required at compile time. This is a
> similar technique to that used in the ELF binfmt loader.
>
> For example:
>
>   elf_fdpic_loadseg is either elf32_fdpic_loadseg or elf64_fdpic_loadseg
>   elf_fdpic_loadmap is either elf32_fdpic_loadmap or elf64_fdpic_loadmap
>
> the choice based on ELFCLASS32 or ELFCLASS64.
>
> Signed-off-by: Greg Ungerer <gerg@kernel.org>
> ---
>  fs/binfmt_elf_fdpic.c          | 38 +++++++++++++++++-----------------
>  include/linux/elf-fdpic.h      | 14 ++++++++++++-
>  include/uapi/linux/elf-fdpic.h | 15 ++++++++++++++
>  3 files changed, 47 insertions(+), 20 deletions(-)

Adding some of the binfmt/fs folks, who weren't directly on the mail.  
It's looking like we're generally OK with this in RISC-V land, though 
there's still no userspace posted.  I don't think there's any rush here 
and it might be prudent to wait for userspace to start going through a 
bit of a review, but figured I'd at least poke everyone to see if 
there's any thoughts.

I'm fine either way, so 

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if that helps any.  Also happy to take this through the RISC-V tree 
along with the other if that's easier, but again no rush.

>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index a05eafcacfb27..2eea6dd429fd6 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -138,7 +138,7 @@ static int is_constdisp(struct elfhdr *hdr)
>  static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
>  				 struct file *file)
>  {
> -	struct elf32_phdr *phdr;
> +	struct elf_phdr *phdr;
>  	unsigned long size;
>  	int retval, loop;
>  	loff_t pos = params->hdr.e_phoff;
> @@ -560,8 +560,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	sp &= ~7UL;
>
>  	/* stack the load map(s) */
> -	len = sizeof(struct elf32_fdpic_loadmap);
> -	len += sizeof(struct elf32_fdpic_loadseg) * exec_params->loadmap->nsegs;
> +	len = sizeof(struct elf_fdpic_loadmap);
> +	len += sizeof(struct elf_fdpic_loadseg) * exec_params->loadmap->nsegs;
>  	sp = (sp - len) & ~7UL;
>  	exec_params->map_addr = sp;
>
> @@ -571,8 +571,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	current->mm->context.exec_fdpic_loadmap = (unsigned long) sp;
>
>  	if (interp_params->loadmap) {
> -		len = sizeof(struct elf32_fdpic_loadmap);
> -		len += sizeof(struct elf32_fdpic_loadseg) *
> +		len = sizeof(struct elf_fdpic_loadmap);
> +		len += sizeof(struct elf_fdpic_loadseg) *
>  			interp_params->loadmap->nsegs;
>  		sp = (sp - len) & ~7UL;
>  		interp_params->map_addr = sp;
> @@ -740,12 +740,12 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>  			      struct mm_struct *mm,
>  			      const char *what)
>  {
> -	struct elf32_fdpic_loadmap *loadmap;
> +	struct elf_fdpic_loadmap *loadmap;
>  #ifdef CONFIG_MMU
> -	struct elf32_fdpic_loadseg *mseg;
> +	struct elf_fdpic_loadseg *mseg;
>  #endif
> -	struct elf32_fdpic_loadseg *seg;
> -	struct elf32_phdr *phdr;
> +	struct elf_fdpic_loadseg *seg;
> +	struct elf_phdr *phdr;
>  	unsigned long load_addr, stop;
>  	unsigned nloads, tmp;
>  	size_t size;
> @@ -767,7 +767,7 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>
>  	params->loadmap = loadmap;
>
> -	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
> +	loadmap->version = ELF_FDPIC_LOADMAP_VERSION;
>  	loadmap->nsegs = nloads;
>
>  	load_addr = params->load_addr;
> @@ -843,8 +843,8 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>  			if (phdr->p_vaddr >= seg->p_vaddr &&
>  			    phdr->p_vaddr + phdr->p_memsz <=
>  			    seg->p_vaddr + seg->p_memsz) {
> -				Elf32_Dyn __user *dyn;
> -				Elf32_Sword d_tag;
> +				Elf_Dyn __user *dyn;
> +				Elf_Sword d_tag;
>
>  				params->dynamic_addr =
>  					(phdr->p_vaddr - seg->p_vaddr) +
> @@ -854,11 +854,11 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>  				 * one item, and that the last item is a NULL
>  				 * entry */
>  				if (phdr->p_memsz == 0 ||
> -				    phdr->p_memsz % sizeof(Elf32_Dyn) != 0)
> +				    phdr->p_memsz % sizeof(Elf_Dyn) != 0)
>  					goto dynamic_error;
>
> -				tmp = phdr->p_memsz / sizeof(Elf32_Dyn);
> -				dyn = (Elf32_Dyn __user *)params->dynamic_addr;
> +				tmp = phdr->p_memsz / sizeof(Elf_Dyn);
> +				dyn = (Elf_Dyn __user *)params->dynamic_addr;
>  				if (get_user(d_tag, &dyn[tmp - 1].d_tag) ||
>  				    d_tag != 0)
>  					goto dynamic_error;
> @@ -927,8 +927,8 @@ static int elf_fdpic_map_file_constdisp_on_uclinux(
>  	struct file *file,
>  	struct mm_struct *mm)
>  {
> -	struct elf32_fdpic_loadseg *seg;
> -	struct elf32_phdr *phdr;
> +	struct elf_fdpic_loadseg *seg;
> +	struct elf_phdr *phdr;
>  	unsigned long load_addr, base = ULONG_MAX, top = 0, maddr = 0;
>  	int loop, ret;
>
> @@ -1011,8 +1011,8 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>  					     struct file *file,
>  					     struct mm_struct *mm)
>  {
> -	struct elf32_fdpic_loadseg *seg;
> -	struct elf32_phdr *phdr;
> +	struct elf_fdpic_loadseg *seg;
> +	struct elf_phdr *phdr;
>  	unsigned long load_addr, delta_vaddr;
>  	int loop, dvset;
>
> diff --git a/include/linux/elf-fdpic.h b/include/linux/elf-fdpic.h
> index 3bea95a1af537..e533f45131945 100644
> --- a/include/linux/elf-fdpic.h
> +++ b/include/linux/elf-fdpic.h
> @@ -10,13 +10,25 @@
>
>  #include <uapi/linux/elf-fdpic.h>
>
> +#if ELF_CLASS == ELFCLASS32
> +#define Elf_Sword			Elf32_Sword
> +#define elf_fdpic_loadseg		elf32_fdpic_loadseg
> +#define elf_fdpic_loadmap		elf32_fdpic_loadmap
> +#define ELF_FDPIC_LOADMAP_VERSION	ELF32_FDPIC_LOADMAP_VERSION
> +#else
> +#define Elf_Sword			Elf64_Sxword
> +#define elf_fdpic_loadmap		elf64_fdpic_loadmap
> +#define elf_fdpic_loadseg		elf64_fdpic_loadseg
> +#define ELF_FDPIC_LOADMAP_VERSION	ELF64_FDPIC_LOADMAP_VERSION
> +#endif
> +
>  /*
>   * binfmt binary parameters structure
>   */
>  struct elf_fdpic_params {
>  	struct elfhdr			hdr;		/* ref copy of ELF header */
>  	struct elf_phdr			*phdrs;		/* ref copy of PT_PHDR table */
> -	struct elf32_fdpic_loadmap	*loadmap;	/* loadmap to be passed to userspace */
> +	struct elf_fdpic_loadmap	*loadmap;	/* loadmap to be passed to userspace */
>  	unsigned long			elfhdr_addr;	/* mapped ELF header user address */
>  	unsigned long			ph_addr;	/* mapped PT_PHDR user address */
>  	unsigned long			map_addr;	/* mapped loadmap user address */
> diff --git a/include/uapi/linux/elf-fdpic.h b/include/uapi/linux/elf-fdpic.h
> index 4fcc6cfebe185..ec23f08711292 100644
> --- a/include/uapi/linux/elf-fdpic.h
> +++ b/include/uapi/linux/elf-fdpic.h
> @@ -32,4 +32,19 @@ struct elf32_fdpic_loadmap {
>
>  #define ELF32_FDPIC_LOADMAP_VERSION	0x0000
>
> +/* segment mappings for ELF FDPIC libraries/executables/interpreters */
> +struct elf64_fdpic_loadseg {
> +	Elf64_Addr	addr;		/* core address to which mapped */
> +	Elf64_Addr	p_vaddr;	/* VMA recorded in file */
> +	Elf64_Word	p_memsz;	/* allocation size recorded in file */
> +};
> +
> +struct elf64_fdpic_loadmap {
> +	Elf64_Half	version;	/* version of these structures, just in case... */
> +	Elf64_Half	nsegs;		/* number of segments */
> +	struct elf64_fdpic_loadseg segs[];
> +};
> +
> +#define ELF64_FDPIC_LOADMAP_VERSION	0x0000
> +
>  #endif /* _UAPI_LINUX_ELF_FDPIC_H */

