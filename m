Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57506663C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjAJJIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjAJJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:08:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90BB193CB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:08:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bn26so11019060wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPQWPSxoU9g+tHgANim1El1aIeSrs5lAIlGeJQ/iAUo=;
        b=baYRSU5TlZzYpwDw5/drH/W3znMW4SbvOg52qV2Sc3I6HGnQ5I7xeozyLAW5+7g/1w
         pvzmye02CKflawpFq82kjjkZIakLJ6VGCrh+wmK4eASSHR/9f2K80I5tmxBhWW2Csg2g
         tVhXu5QPfc6B0iPu+o9Az+uQvMvQIXNIJB3aIKP/02zOwCMlRNXXfbRqlbogHHAuRc+E
         NeVNiH/Nm7qQvStnt9C2sxdq5GOpJAiOEBWUkP1mvjKP1Tbohh22QJYv7g2GuMvglWcz
         AJ98jwehQW2fvz+ZdTa2c4MuJ+viE9/34dTaiqZLoGy85O2+rq/8v/cpE6KBl01xytGu
         BoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPQWPSxoU9g+tHgANim1El1aIeSrs5lAIlGeJQ/iAUo=;
        b=s6LjIeoO+zRpwQ7/JK3HCFYU27DKmb9oz9dCII8qB/hbyI1W4SmVLgvE7JWZTxMQSk
         d6poNi/ixdvYAk0WcBey5ZTyIOq2DGMxOWlXBpOZ42t0MEeI1vOJoHYAqBHd1FVxkqRk
         B6CefLci1rSNbRcbY9oYRce1qT3XCIjMZUk6Fw85EfrwLFsrznheZ+stL27bkwB/zOj6
         cFgKQv8U+8So9bqxQnIqoh8/TFda9MlCX7hevYpbMjmPw6w5EUvCHWpFCtDg6+nqmoxh
         1JpqTRo9VpiPDPd6znlFAbZVa3I8ZueKak2cWT8Zv2bJrFbdjDyjAEeAWgxVgtvGSPDM
         N09Q==
X-Gm-Message-State: AFqh2kqgCL04zgmbAxtc4iVwdqGkalb1ourPEkdMf3L4N/Hefhi6wxQT
        XHP6Ny7PiSxTd1TlEY106EWd8g==
X-Google-Smtp-Source: AMrXdXv/jicjrV3wBiaQqng88Wp6io2VWNESvO+szaZxEwhtwb3SVnTmq/1/MT6KhAFr4tB32vK46Q==
X-Received: by 2002:adf:ec85:0:b0:291:4088:a634 with SMTP id z5-20020adfec85000000b002914088a634mr25299420wrn.40.1673341696365;
        Tue, 10 Jan 2023 01:08:16 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b0028f9132e9ddsm10583427wra.39.2023.01.10.01.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:08:15 -0800 (PST)
Date:   Tue, 10 Jan 2023 10:08:15 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230110090815.fskdrmnbaig4yelz@orel>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel>
 <6638291f6a3c463994919ba0a875472c@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6638291f6a3c463994919ba0a875472c@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:37:01AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Tuesday, 10 January, 2023 3:36 AM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>;
> > Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
> > hibernation/suspend-to-disk
> > 
> > On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:
> > > Low level Arch functions were created to support hibernation.
> > > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > > cpu state onto the stack, then calling swsusp_save() to save the memory
> > > image.
> > >
> > > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > > functions are implemented to prevent kernel crash when resume,
> > > the kernel built version is saved into the hibernation image header
> > > to making sure only the same kernel is restore when resume.
> > 
> > Why does it crash with the generic version check?
> The kernel could have different device driver enabled and the device drivers would find itself running in a different address space if restore with different kernel version.

That part I understood, but I was wondering why the generic check which
compares kernel version and more wasn't sufficient. I answered my own
question though. Extra data needs to be stored to the header (hartid,
satp, etc.), so we need an arch-specific hibernation header. However we
*still* need the version for the version check, so some of the generic
check is reproduced in the arch-specific header. Please update the commit
message with this more detailed explanation.

...
> > > +extern int in_suspend;
> > 
> > This declaration could be in arch/riscv/kernel/hibernate.c
> Can't declare it to the .c file because checkpatch will report error if we do so.

Error or warning? It makes more sense to me to be where it needs to be,
but it doesn't matter too much either way.

...
> > > +	/* The below code will restore the hibernated image. */
> > > +	ld	a1, HIBERN_PBE_ADDR(s4)
> > > +	ld	a0, HIBERN_PBE_ORIG(s4)
> > > +
> > > +	lui     a4, 0x1
> > > +	add     a4, a4, a0
> > > +copy:	ld      a5, 0(a1)
> > 
> > copy label should get its own line and how about changing it,
> ok
> > loop, and done to local symbol names, e.g. .Lcopy?
> I think better to use two local symbol names, i.e .Lcopy and .Ldone

Two? You currently have three labels which all serve purposes.

BTW, maybe unrolling the copy loop a bit as arm64 does with its copy_page
macro would be a good idea.

...
> > > +		sleep_cpu = -EINVAL;
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +#ifdef CONFIG_SMP
> > 
> > The #ifdef shouldn't be necessary.
> We need the #ifdef CONFIG_SMP is because the bringup_hibernate_cpu() is defined under the guardian of ifdef CONFIG_SMP.
> One will face compile error if the CONFIG_SMP was disabled for a single cpu testing.

Ah, you're right. It's interesting that arm64 doesn't appear to guard that
call.

Thanks,
drew
