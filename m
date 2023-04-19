Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3486E7190
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjDSD13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDSD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:27:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341D7EC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:27:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2466f65d7e0so1926363a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681874831; x=1684466831;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNPYSUMahgAyXZXRtPSa/FHx7hsSNLc7er8SypYXEE0=;
        b=V4DT7iyyMQk9hHL1OmZVid6pnWukKrSwK6E8gzwjCU/tnzzCMf5eYYpN6aMHJsNMHx
         pNXolNAOD7N2oJOK5tkA2uSndkcdl6gbHb4CfeTnSTV3ehy4LBLViRQcgoxYDStlrnR8
         xCv8UEBC66+JGz4EYv8PSulabzkaXPKWV5MKou2vj//nyIdoqIvtu/7GVmYmH8i6etVj
         A9qJmmWXHcDq8eJ0hG/o1Yobx7PRkfAjfeZ2I44RoY3RwFJ1U4mVOqiVvEOPqis7zwTb
         Z7WmwM01SW94AxWdaO82OtygctICR8cYj0hQaNUnhUG/VKY854W8eQYBeE8LwRlG11Kx
         mL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681874831; x=1684466831;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNPYSUMahgAyXZXRtPSa/FHx7hsSNLc7er8SypYXEE0=;
        b=SXUFXRvr/KIwg6rrz/SmcnDjBQmeFPTJd3Wl4Fu4lmnW0DC4fwo/WbRFbALdlz6ROk
         WpiuV2zK+7r8MfHMEHskZ/BB7kFpKh4bKoWUx5woa3Bq/JlApUGxvDoYXnH+6WGB+DTw
         nV/Uc6Pheb2XMnkbgRr4WQvWOwRrWr6UmL2LKYQow/zQxwq8fQSoDOVit9/Ecz53OKs9
         Um9XdVlBZKQu/bxqWz2v5NC3vzRnRD00EQUlIJOpgQZIrtAnQNOqK0J64d0UBvLtOkW8
         zt+d7JaY1oIT5BZskjtB6hyq9jYURgLoG4c8CpgSd+e6y+lZyWoZX1MExA1RkOYuGOc3
         OU4A==
X-Gm-Message-State: AAQBX9fJa+h8RlPH418MGeyaQXb2sBsBrM6XC/7BQne7pJ67JpJmnSQB
        IAMCevSMAD57vidDE7qJ1Z2XMg==
X-Google-Smtp-Source: AKy350bO5eCRO2oTDoKnVbIgbWmrg60BOMhAdOU8Eo/INK0dKi0uDVZTOyfy49E1Gf0PrPF7ZTYe2g==
X-Received: by 2002:a17:90b:392:b0:247:601c:20fa with SMTP id ga18-20020a17090b039200b00247601c20famr1484491pjb.5.1681874831418;
        Tue, 18 Apr 2023 20:27:11 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id m23-20020a170902bb9700b001a66e6bb66esm10328642pls.162.2023.04.18.20.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:27:10 -0700 (PDT)
Date:   Tue, 18 Apr 2023 20:27:10 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Apr 2023 20:27:06 PDT (-0700)
Subject:     Re: [PATCH 1/2] binfmt_elf_fdpic: support 64-bit systems
In-Reply-To: <ab995c62-e537-a57e-062e-28aea2a4e6e5@kernel.org>
CC:     viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     gerg@kernel.org
Message-ID: <mhng-1c4cae76-4390-420e-8668-374aa8a967ff@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 06:48:55 PDT (-0700), gerg@kernel.org wrote:
>
> On 22/3/23 08:49, Palmer Dabbelt wrote:
>> On Tue, 28 Feb 2023 05:51:25 PST (-0800), gerg@kernel.org wrote:
>>> The binfmt_flat_fdpic code has a number of 32-bit specific data
>>> structures associated with it. Extend it to be able to support and
>>> be used on 64-bit systems as well.
>>>
>>> The new code defines a number of key 64-bit variants of the core
>>> elf-fdpic data structures - along side the existing 32-bit sized ones.
>>> A common set of generic named structures are defined to be either
>>> the 32-bit or 64-bit ones as required at compile time. This is a
>>> similar technique to that used in the ELF binfmt loader.
>>>
>>> For example:
>>>
>>>   elf_fdpic_loadseg is either elf32_fdpic_loadseg or elf64_fdpic_loadseg
>>>   elf_fdpic_loadmap is either elf32_fdpic_loadmap or elf64_fdpic_loadmap
>>>
>>> the choice based on ELFCLASS32 or ELFCLASS64.
>>>
>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>> ---
>>>  fs/binfmt_elf_fdpic.c          | 38 +++++++++++++++++-----------------
>>>  include/linux/elf-fdpic.h      | 14 ++++++++++++-
>>>  include/uapi/linux/elf-fdpic.h | 15 ++++++++++++++
>>>  3 files changed, 47 insertions(+), 20 deletions(-)
>>
>> Adding some of the binfmt/fs folks, who weren't directly on the mail. It's looking like we're generally OK with this in RISC-V land, though there's still no userspace posted.  I don't think there's any rush here and it might be prudent to wait for userspace to start going through a bit of a review, but figured I'd at least poke everyone to see if there's any thoughts.
>>
>> I'm fine either way, so
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> if that helps any.  Also happy to take this through the RISC-V tree along with the other if that's easier, but again no rush.
>
> Just following up. I haven't seen any feedback on this - did I miss any?

If you did then I did too.  I'm not really sure what to do here: it 
looks fine to me, but it's not really my area so I'd prefer to have 
someone who understands this stuff a bit better chime in.

It looks like some Arm patches recently went in through that tree, 
though, so maybe that's how things are supposed to go here?

>
> Regards
> Greg
>
>
>>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>>> index a05eafcacfb27..2eea6dd429fd6 100644
>>> --- a/fs/binfmt_elf_fdpic.c
>>> +++ b/fs/binfmt_elf_fdpic.c
>>> @@ -138,7 +138,7 @@ static int is_constdisp(struct elfhdr *hdr)
>>>  static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
>>>                   struct file *file)
>>>  {
>>> -    struct elf32_phdr *phdr;
>>> +    struct elf_phdr *phdr;
>>>      unsigned long size;
>>>      int retval, loop;
>>>      loff_t pos = params->hdr.e_phoff;
>>> @@ -560,8 +560,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>>>      sp &= ~7UL;
>>>
>>>      /* stack the load map(s) */
>>> -    len = sizeof(struct elf32_fdpic_loadmap);
>>> -    len += sizeof(struct elf32_fdpic_loadseg) * exec_params->loadmap->nsegs;
>>> +    len = sizeof(struct elf_fdpic_loadmap);
>>> +    len += sizeof(struct elf_fdpic_loadseg) * exec_params->loadmap->nsegs;
>>>      sp = (sp - len) & ~7UL;
>>>      exec_params->map_addr = sp;
>>>
>>> @@ -571,8 +571,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>>>      current->mm->context.exec_fdpic_loadmap = (unsigned long) sp;
>>>
>>>      if (interp_params->loadmap) {
>>> -        len = sizeof(struct elf32_fdpic_loadmap);
>>> -        len += sizeof(struct elf32_fdpic_loadseg) *
>>> +        len = sizeof(struct elf_fdpic_loadmap);
>>> +        len += sizeof(struct elf_fdpic_loadseg) *
>>>              interp_params->loadmap->nsegs;
>>>          sp = (sp - len) & ~7UL;
>>>          interp_params->map_addr = sp;
>>> @@ -740,12 +740,12 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>>>                    struct mm_struct *mm,
>>>                    const char *what)
>>>  {
>>> -    struct elf32_fdpic_loadmap *loadmap;
>>> +    struct elf_fdpic_loadmap *loadmap;
>>>  #ifdef CONFIG_MMU
>>> -    struct elf32_fdpic_loadseg *mseg;
>>> +    struct elf_fdpic_loadseg *mseg;
>>>  #endif
>>> -    struct elf32_fdpic_loadseg *seg;
>>> -    struct elf32_phdr *phdr;
>>> +    struct elf_fdpic_loadseg *seg;
>>> +    struct elf_phdr *phdr;
>>>      unsigned long load_addr, stop;
>>>      unsigned nloads, tmp;
>>>      size_t size;
>>> @@ -767,7 +767,7 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>>>
>>>      params->loadmap = loadmap;
>>>
>>> -    loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
>>> +    loadmap->version = ELF_FDPIC_LOADMAP_VERSION;
>>>      loadmap->nsegs = nloads;
>>>
>>>      load_addr = params->load_addr;
>>> @@ -843,8 +843,8 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>>>              if (phdr->p_vaddr >= seg->p_vaddr &&
>>>                  phdr->p_vaddr + phdr->p_memsz <=
>>>                  seg->p_vaddr + seg->p_memsz) {
>>> -                Elf32_Dyn __user *dyn;
>>> -                Elf32_Sword d_tag;
>>> +                Elf_Dyn __user *dyn;
>>> +                Elf_Sword d_tag;
>>>
>>>                  params->dynamic_addr =
>>>                      (phdr->p_vaddr - seg->p_vaddr) +
>>> @@ -854,11 +854,11 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>>>                   * one item, and that the last item is a NULL
>>>                   * entry */
>>>                  if (phdr->p_memsz == 0 ||
>>> -                    phdr->p_memsz % sizeof(Elf32_Dyn) != 0)
>>> +                    phdr->p_memsz % sizeof(Elf_Dyn) != 0)
>>>                      goto dynamic_error;
>>>
>>> -                tmp = phdr->p_memsz / sizeof(Elf32_Dyn);
>>> -                dyn = (Elf32_Dyn __user *)params->dynamic_addr;
>>> +                tmp = phdr->p_memsz / sizeof(Elf_Dyn);
>>> +                dyn = (Elf_Dyn __user *)params->dynamic_addr;
>>>                  if (get_user(d_tag, &dyn[tmp - 1].d_tag) ||
>>>                      d_tag != 0)
>>>                      goto dynamic_error;
>>> @@ -927,8 +927,8 @@ static int elf_fdpic_map_file_constdisp_on_uclinux(
>>>      struct file *file,
>>>      struct mm_struct *mm)
>>>  {
>>> -    struct elf32_fdpic_loadseg *seg;
>>> -    struct elf32_phdr *phdr;
>>> +    struct elf_fdpic_loadseg *seg;
>>> +    struct elf_phdr *phdr;
>>>      unsigned long load_addr, base = ULONG_MAX, top = 0, maddr = 0;
>>>      int loop, ret;
>>>
>>> @@ -1011,8 +1011,8 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>>                           struct file *file,
>>>                           struct mm_struct *mm)
>>>  {
>>> -    struct elf32_fdpic_loadseg *seg;
>>> -    struct elf32_phdr *phdr;
>>> +    struct elf_fdpic_loadseg *seg;
>>> +    struct elf_phdr *phdr;
>>>      unsigned long load_addr, delta_vaddr;
>>>      int loop, dvset;
>>>
>>> diff --git a/include/linux/elf-fdpic.h b/include/linux/elf-fdpic.h
>>> index 3bea95a1af537..e533f45131945 100644
>>> --- a/include/linux/elf-fdpic.h
>>> +++ b/include/linux/elf-fdpic.h
>>> @@ -10,13 +10,25 @@
>>>
>>>  #include <uapi/linux/elf-fdpic.h>
>>>
>>> +#if ELF_CLASS == ELFCLASS32
>>> +#define Elf_Sword            Elf32_Sword
>>> +#define elf_fdpic_loadseg        elf32_fdpic_loadseg
>>> +#define elf_fdpic_loadmap        elf32_fdpic_loadmap
>>> +#define ELF_FDPIC_LOADMAP_VERSION    ELF32_FDPIC_LOADMAP_VERSION
>>> +#else
>>> +#define Elf_Sword            Elf64_Sxword
>>> +#define elf_fdpic_loadmap        elf64_fdpic_loadmap
>>> +#define elf_fdpic_loadseg        elf64_fdpic_loadseg
>>> +#define ELF_FDPIC_LOADMAP_VERSION    ELF64_FDPIC_LOADMAP_VERSION
>>> +#endif
>>> +
>>>  /*
>>>   * binfmt binary parameters structure
>>>   */
>>>  struct elf_fdpic_params {
>>>      struct elfhdr            hdr;        /* ref copy of ELF header */
>>>      struct elf_phdr            *phdrs;        /* ref copy of PT_PHDR table */
>>> -    struct elf32_fdpic_loadmap    *loadmap;    /* loadmap to be passed to userspace */
>>> +    struct elf_fdpic_loadmap    *loadmap;    /* loadmap to be passed to userspace */
>>>      unsigned long            elfhdr_addr;    /* mapped ELF header user address */
>>>      unsigned long            ph_addr;    /* mapped PT_PHDR user address */
>>>      unsigned long            map_addr;    /* mapped loadmap user address */
>>> diff --git a/include/uapi/linux/elf-fdpic.h b/include/uapi/linux/elf-fdpic.h
>>> index 4fcc6cfebe185..ec23f08711292 100644
>>> --- a/include/uapi/linux/elf-fdpic.h
>>> +++ b/include/uapi/linux/elf-fdpic.h
>>> @@ -32,4 +32,19 @@ struct elf32_fdpic_loadmap {
>>>
>>>  #define ELF32_FDPIC_LOADMAP_VERSION    0x0000
>>>
>>> +/* segment mappings for ELF FDPIC libraries/executables/interpreters */
>>> +struct elf64_fdpic_loadseg {
>>> +    Elf64_Addr    addr;        /* core address to which mapped */
>>> +    Elf64_Addr    p_vaddr;    /* VMA recorded in file */
>>> +    Elf64_Word    p_memsz;    /* allocation size recorded in file */
>>> +};
>>> +
>>> +struct elf64_fdpic_loadmap {
>>> +    Elf64_Half    version;    /* version of these structures, just in case... */
>>> +    Elf64_Half    nsegs;        /* number of segments */
>>> +    struct elf64_fdpic_loadseg segs[];
>>> +};
>>> +
>>> +#define ELF64_FDPIC_LOADMAP_VERSION    0x0000
>>> +
>>>  #endif /* _UAPI_LINUX_ELF_FDPIC_H */
>>
