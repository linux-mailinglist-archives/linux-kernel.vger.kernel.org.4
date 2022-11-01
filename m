Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15FE6144C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKAGrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAGry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:47:54 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD536321
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:47:52 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id y16so18842105wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th1kFY+Sqvur+A/pginKjwsSKvx2FILrHBMDlifjofc=;
        b=cXwi9VPvOI3D1kuhLAYhEkmjkNMX2lssMc5qioAEe1Fr9L+LVEQuj1VWevwowfpFr2
         VcrbXTiItfaZ4mwXH0+0Hc1jRy8YzDPbBfl0E+HmyZiWQTDXonOeei5LMjtzzkQtQVVZ
         4FDMd58bCChGEDGFM4MNd/BXuDjRry+GRVMT6eIccN6b1AvCxHfnoq0g2fsM8olAlNWB
         lrtuqzfVNUbpBDrUzQTvSTniLTMzblyfSwD6y3vw2yWMkWDcPsduI1zPr67sq1wsh+ys
         CsbxzI5AnsLHh9P7103YdyaBDDmeZE3KSGAXdnhh2UXMzOZcfDx+JZJiXy8iP2gPF/Q7
         ZqZQ==
X-Gm-Message-State: ACrzQf2cTY8F903ZU6t4WFHCu2fLtMsphJZb6YOVovrJtn3RzlrrhPvI
        eVWiBwHLaxQ92aj7AYjXYMg=
X-Google-Smtp-Source: AMsMyM7jSf43CsPOWmM6YmuxTW8Xps5aWJAB4vbgzKR+5fIRXHVBfTzFgX1ztNGQVCbh9ocdM2uk1A==
X-Received: by 2002:a05:6000:1203:b0:236:9aac:8d00 with SMTP id e3-20020a056000120300b002369aac8d00mr10104030wrx.221.1667285271250;
        Mon, 31 Oct 2022 23:47:51 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003c6c5a5a651sm9327321wmk.28.2022.10.31.23.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 23:47:50 -0700 (PDT)
Message-ID: <0fcbedf6-3eb5-75cd-cdd9-24582f70cc64@kernel.org>
Date:   Tue, 1 Nov 2022 07:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221031151047.167288-1-alexandr.lobakin@intel.com>
 <20221031151047.167288-2-alexandr.lobakin@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] x86/boot: robustify calling startup_{32,64}() from
 the decompressor code
In-Reply-To: <20221031151047.167288-2-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 10. 22, 16:10, Alexander Lobakin wrote:
> After commit ce697ccee1a8 ("kbuild: remove head-y syntax"), I
> started digging whether x86 is ready from removing this old cruft.
> Removing its objects from the list makes the kernel unbootable.
> This applies only to bzImage, vmlinux still works correctly.
> The reason is that with no strict object order determined by the
> linker arguments, not the linker script, startup_64 can be placed
> not right at the beginning of the kernel.
> Here's vmlinux.map's beginning before removing:
> 
> ffffffff81000000         vmlinux.o:(.head.text)
> ffffffff81000000                 startup_64
> ffffffff81000070                 secondary_startup_64
> ffffffff81000075                 secondary_startup_64_no_verify
> ffffffff81000160                 verify_cpu
> 
> and after:
> 
> ffffffff81000000         vmlinux.o:(.head.text)
> ffffffff81000000                 pvh_start_xen
> ffffffff81000080                 startup_64
> ffffffff810000f0                 secondary_startup_64
> ffffffff810000f5                 secondary_startup_64_no_verify
> 
> Not a problem itself, but the self-extractor code has the address of
> that function hardcoded the beginning, not looking onto the ELF
> header, which always contains the address of startup_{32,64}().
> 
> So, instead of doing an "act of blind faith", just take the address
> from the ELF header and extract a relative offset to the entry
> point. The decompressor function already returns a pointer to the
> beginning of the kernel to the Asm code, which then jumps to it,
> so add that offset to the return value.
> This doesn't change anything for now, but allows to resign from the
> "head object list" for x86 and makes sure valid Kbuild or any other
> improvements won't break anything here in general.

Oh yeah! I wouldn't think that implementing this would be _that_ easy.

The next natural step would be to eliminate the whole head section. But 
that would need a bit more work as not all jumps are rip-relative, 
apparently...

Few comments below, so no Reviewed-by yet.

Tested-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
...
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -277,7 +277,7 @@ static inline void handle_relocations(void *output, unsigned long output_len,
>   { }
>   #endif
>   
> -static void parse_elf(void *output)
> +static size_t parse_elf(void *output)
>   {
>   #ifdef CONFIG_X86_64
>   	Elf64_Ehdr ehdr;
> @@ -287,6 +287,7 @@ static void parse_elf(void *output)
>   	Elf32_Phdr *phdrs, *phdr;
>   #endif
>   	void *dest;
> +	size_t off;
>   	int i;
>   
>   	memcpy(&ehdr, output, sizeof(ehdr));
> @@ -295,16 +296,19 @@ static void parse_elf(void *output)
>   	   ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
>   	   ehdr.e_ident[EI_MAG3] != ELFMAG3) {
>   		error("Kernel is not a valid ELF file");
> -		return;
> +		return 0;

error() is noreturn, so you can remove these returns. They don't make 
sense anyway. Likely in a separate patch.

>   	}
>   
>   	debug_putstr("Parsing ELF... ");
>   
>   	phdrs = malloc(sizeof(*phdrs) * ehdr.e_phnum);
> -	if (!phdrs)
> +	if (!phdrs) {
>   		error("Failed to allocate space for phdrs");
> +		return 0;
> +	}
>   
>   	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
> +	off = ehdr.e_entry - phdrs->p_paddr;
>   
>   	for (i = 0; i < ehdr.e_phnum; i++) {
>   		phdr = &phdrs[i];
> @@ -328,6 +332,7 @@ static void parse_elf(void *output)
>   	}
>   
>   	free(phdrs);
> +	return off;

You should add a \n before the return.

>   }
>   
>   /*
> @@ -356,6 +361,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>   	const unsigned long kernel_total_size = VO__end - VO__text;
>   	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
>   	unsigned long needed_size;
> +	size_t off;
>   
>   	/* Retain x86 boot parameters pointer passed from startup_32/64. */
>   	boot_params = rmode;
> @@ -456,14 +462,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>   	debug_putstr("\nDecompressing Linux... ");
>   	__decompress(input_data, input_len, NULL, NULL, output, output_len,
>   			NULL, error);
> -	parse_elf(output);
> +	off = parse_elf(output);

Perhaps add:
   debug_putaddr(off);
here?

>   	handle_relocations(output, output_len, virt_addr);
>   	debug_putstr("done.\nBooting the kernel.\n");

>   
>   	/* Disable exception handling before booting the kernel */
>   	cleanup_exception_handling();
>   
> -	return output;
> +	return output + off;
>   }
>   
>   void fortify_panic(const char *name)

thanks,
-- 
js
suse labs

