Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6952566CF11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjAPSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjAPSok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:44:40 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38418233D9;
        Mon, 16 Jan 2023 10:41:30 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15027746720so29678954fac.13;
        Mon, 16 Jan 2023 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOLcm+d+am0Hc4aHoaJqQx+DXnQN9GGYD1N1+IoiMlI=;
        b=Wy+rG8aAshXGgePvASDE2S1C6i3esFszMuEe0/0W1Up+qB0hF9Oyx7L0o8YRKfwTMq
         pSTXyS8ameWdAR7u0qsS0vycOiF+Ygwu0hn15gSfwEdj7B0JoWHgw3xXdvVjePV9ZNdb
         YpGd7BBulrNstrIRtQF7dyXGyZEsaKBaXomb1kvAR5623CBCcMRxxy53O6m5JJGgc36d
         w0AfzYekdzRa6BFugkOuBkMdw9cOCNxd7WtkMGGgbjWiyZevAHGR5ZRkLLD7YWbGr1V/
         SW1wpMEp14MQwSUEUc9zHj38N/Ij/Ic5yVYlLW9ZhcemHeWSKnTpUl3CGyL4zIUKQVeL
         2KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOLcm+d+am0Hc4aHoaJqQx+DXnQN9GGYD1N1+IoiMlI=;
        b=YN3f+XWgnqxF9l8L7lfuS2a+AgNuGboknqWH8I4rfVhggO83piciEL0hB4ES59KGxS
         hdHCkGbNI0Ug8VAOCJssxUDH/uY8WeY/9F7Om5LTPqEWsWss1By0LCDWpytVazv7Uow/
         dn5WmtJTqSf4KRCqzm38F3qqcztZU7xMXNAl8fFYq/fadKy/J3RSjiCmabtdP2jo9Kag
         8QF9KDD1RJJb/5No2esdpxTaqjjNGk9/mDHH9x2y9fypEGUtjPTKDLsZinfyJlzwXfBg
         nBmdgTgmq/PhTSjq0lxgvN7zqQHOY9HDxDtbrnf/u+QZVeXZ046VUw+TSfoC592xXBiq
         ZFaA==
X-Gm-Message-State: AFqh2kolzwlGeMSvuGCgBxVLue9XuSxG1vSABOE6D9vUtiqB3DwSTCPd
        Ib2a/ys5gztkgE+MZrsg1zIPvM8QaEM=
X-Google-Smtp-Source: AMrXdXuD9OB9RXmAOwC0ttqHTDE2YldvYD4lbLfCpTjMEcvyclR4lALoi+TcL7wWqiNEDd9QmaZpMg==
X-Received: by 2002:a05:6870:b4ab:b0:150:a0c9:21f with SMTP id y43-20020a056870b4ab00b00150a0c9021fmr12418378oap.35.1673894489285;
        Mon, 16 Jan 2023 10:41:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k12-20020a056870818c00b0013b0b19100fsm15146201oae.32.2023.01.16.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:41:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 Jan 2023 10:41:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: Build regressions/improvements in v6.2-rc4
Message-ID: <20230116184127.GA1721129@roeck-us.net>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
 <20230116122924.116745-1-geert@linux-m68k.org>
 <46ba7912-3df6-dff9-792-49f4eaadefec@linux-m68k.org>
 <Y8V94PKtaWO3yRS4@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8V94PKtaWO3yRS4@osiris>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 05:40:00PM +0100, Heiko Carstens wrote:
> On Mon, Jan 16, 2023 at 01:36:34PM +0100, Geert Uytterhoeven wrote:
> > On Mon, 16 Jan 2023, Geert Uytterhoeven wrote:
> > > JFYI, when comparing v6.2-rc4[1] to v6.2-rc3-8-g1fe4fd6f5cad346e[3], the summaries are:
> > >  - build errors: +1/-5
> > 
> >   + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]:  => 57:33
> > 
> > s390x-gcc11/s390-allmodconfig
> > 
> > /kisskb/src/arch/s390/kernel/setup.c: In function 'setup_lowcore_dat_on':
> > /kisskb/src/include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]
> >    57 | #define __underlying_memcpy     __builtin_memcpy
> >       |                                 ^
> > /kisskb/src/include/linux/fortify-string.h:578:9: note: in expansion of macro '__underlying_memcpy'
> >   578 |         __underlying_##op(p, q, __fortify_size);                        \
> >       |         ^~~~~~~~~~~~~
> > /kisskb/src/include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
> >   623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >       |                          ^~~~~~~~~~~~~~~~~~~~
> > /kisskb/src/arch/s390/kernel/setup.c:526:9: note: in expansion of macro 'memcpy'
> >   526 |         memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
> >       |         ^~~~~~
> > 
> > Looks like this was "'__builtin_memcpy' offset [0, 127] is out of the bounds
> > [0, 0]" before.
> 
> Thanks for reporting. Of course this doesn't happen with gcc-12, and
> this code will be rewritten with the next merge window anyway.
> But to workaround this with gcc-11, we could go with the below:
> 

This is because of

#define S390_lowcore (*((struct lowcore *) 0))

and is fixed with something like

#define S390_lowcore (*((struct lowcore *) absolute_pointer(0)))

See commit f6b5f1a56987 ("compiler.h: Introduce absolute_pointer macro").
The problem is only seen with gcc 11.2. I don't see it with 11.3 or 12.2.

Guenter

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 2b6091349daa..696c9e007a36 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -508,6 +508,7 @@ static void __init setup_lowcore_dat_on(void)
>  {
>  	struct lowcore *abs_lc;
>  	unsigned long flags;
> +	int i;
>  
>  	__ctl_clear_bit(0, 28);
>  	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
> @@ -523,8 +524,8 @@ static void __init setup_lowcore_dat_on(void)
>  	abs_lc = get_abs_lowcore(&flags);
>  	abs_lc->restart_flags = RESTART_FLAG_CTLREGS;
>  	abs_lc->program_new_psw = S390_lowcore.program_new_psw;
> -	memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
> -	       sizeof(abs_lc->cregs_save_area));
> +	for (i = 0; i < 16; i++)
> +		abs_lc->cregs_save_area[i] = S390_lowcore.cregs_save_area[i];
>  	put_abs_lowcore(abs_lc, flags);
>  }
>  
