Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CD63EF95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiLALia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLALi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:38:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CFC1D335
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:38:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b2so3511000eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RmSe80HfKK7FckDSEcPQpoVUBo07goAUQO5ufP8u+m8=;
        b=gto4jEQ8rmQKpmOUaItlz1cLcGWBm97vuDDJShfFQGtq6ux/d2J517vmppUvppK1Hd
         qvD18tM9yHEh/h1ZhFLK6Hfi8r+63OeBX3sow55Iqwy7WBBNrel9LaXpIXMbAxYiGQXj
         fLGvSq7YHKE0xhVwtfXZZAN0oREYSqDD7SgKt7k5Hu3EtzTdr6KdWwO6YhPc3hNSp8Bv
         BXByjyqfZOc2CnjvFEZfcTTknnXZNt9MdxG4YdLNwwy24fCTMGmBnMiW9Ewe/fLq/KMa
         AcPP4jMk7ZklXk+7taX/4TfxhkP3gLEYAE1dt5P6pophujeaDdKEI6w1LEE7Fo2Z1PKu
         3Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmSe80HfKK7FckDSEcPQpoVUBo07goAUQO5ufP8u+m8=;
        b=x3bmvWIugp8ow3Kq3n5GOdiREa1Y8wkBjhD72ctH22qH6iLvx3JR2gDzZTMgAkck2r
         EIZ7Drd10puosoakecRSoEivr7Zcm1q1gbCMRL8hkyOv+C5D+hQOe0g8AUERtpAXgDci
         ba8X4zlML/t3PDyp6ddlFi/PcccM+d/SZrJhB9lmfxinnTNBQ+2BLci1A3N8IhNetyGF
         bmkN/SVNWEf5IYj8ovnagTP2hCgyHaD8vGzzDfOuQ1alD2NLKcBAwalY3oO4I2VBAUoY
         Gze/rAEPyzjWDtYEjs+OXwsEZNTZ3u8X0lUdqfzfaUSU7vi+DcFDu6NGt5srwsTji/JY
         U7fQ==
X-Gm-Message-State: ANoB5pmzK1QKqVLw7PbczOIDHkezaJ7S2eaAbMDWtzwDLvv6ruetF9Bh
        HY9tS8iOlajZhoXaOZB3NpgdpQ==
X-Google-Smtp-Source: AA0mqf7txX1rh2Brl7EAEXMEplhAfLo8/oa9Ruzkyri1NSVBhprWiTA/sHJhLhSoiGiC8woxCpicMQ==
X-Received: by 2002:a17:906:3109:b0:7a0:b505:cae5 with SMTP id 9-20020a170906310900b007a0b505cae5mr56576723ejx.648.1669894705512;
        Thu, 01 Dec 2022 03:38:25 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007b27fc3a1ffsm1670182ejm.121.2022.12.01.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:38:25 -0800 (PST)
Date:   Thu, 1 Dec 2022 12:38:24 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Message-ID: <20221201113824.hcjijn3z45g2vohv@kamzik>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-3-conor@kernel.org>
 <20221201090041.525op4sateq5wq4y@kamzik>
 <46873028.fMDQidcC6G@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46873028.fMDQidcC6G@diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:47:04AM +0100, Heiko Stübner wrote:
> Am Donnerstag, 1. Dezember 2022, 10:00:41 CET schrieb Andrew Jones:
> > On Wed, Nov 30, 2022 at 11:41:25PM +0000, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > Ordering between each and every list of extensions is wildly
> > > inconsistent. Per discussion on the lists pick the following policy:
> > > 
> > > - The array defining order in /proc/cpuinfo follows a narrow
> > >   interpretation of the ISA specifications, described in a comment
> > >   immediately presiding it.
> > > 
> > > - All other lists of extensions are sorted alphabetically.
> > > 
> > > This will hopefully allow for easier review & future additions, and
> > > reduce conflicts between patchsets as the number of extensions grows.
> > > 
> > > Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
> > > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > I could not decide between adding an alphabetical comment to each
> > > alphabetical site or not. I did it anyway. Scream if you hate it!
> > > 
> > > I also moved a static branch thingy in this version, but that should not
> > > matter, right? riightt?
> > 
> > riiighttt. And it goes away with [1] anyway.
> > 
> > [1] https://lore.kernel.org/all/20221006070818.3616-1-jszhang@kernel.org/
> 
> I'm not sure what became of that series since mid october, though noting
> that tightly coupling the patching to extensions alone might cause issues [2]
> which some of the "features" like fast-unaligned access, that are not directly
> bound to a isa-extension but to an implementation detail
> 
> [2] https://lore.kernel.org/all/1991071.yIU609i1g2@phil/

Jisheng said he'd send a refresh soon. Hopefully your comments will be
taken into consideration. It seems like we need both the concepts of
cpufeatures and extensions. Where many times a cpufeature directly maps
to an extension, but not always. Or, we could shoehorn the non-extension
cpufeatures into the extension framework by calling them "derived
extensions" or something.

> 
> 
> > 
> > > ---
> > >  arch/riscv/include/asm/hwcap.h | 12 +++++++-----
> > >  arch/riscv/kernel/cpu.c        |  4 ++--
> > >  arch/riscv/kernel/cpufeature.c |  6 ++++--
> > >  3 files changed, 13 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > index b22525290073..ce522aad641a 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -51,14 +51,15 @@ extern unsigned long elf_hwcap;
> > >   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > >   * extensions while all the multi-letter extensions should define the next
> > >   * available logical extension id.
> > > + * Entries are sorted alphabetically.
> > >   */
> > >  enum riscv_isa_ext_id {
> > >  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> > > +	RISCV_ISA_EXT_SSTC,
> > > +	RISCV_ISA_EXT_SVINVAL,
> > >  	RISCV_ISA_EXT_SVPBMT,
> > >  	RISCV_ISA_EXT_ZICBOM,
> > >  	RISCV_ISA_EXT_ZIHINTPAUSE,
> > > -	RISCV_ISA_EXT_SSTC,
> > > -	RISCV_ISA_EXT_SVINVAL,
> > >  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> > >  };
> > 
> > Unrelated to this patch, but every time I look at this enum I want to post
> > the diff below, but I haven't bothered, because this enum also goes away
> > with [1].
> > 
> > @@ -59,8 +59,9 @@ enum riscv_isa_ext_id {
> >         RISCV_ISA_EXT_ZIHINTPAUSE,
> >         RISCV_ISA_EXT_SSTC,
> >         RISCV_ISA_EXT_SVINVAL,
> > -       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> > +       RISCV_ISA_EXT_ID_MAX
> >  };
> > +static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
> 
> that sounds like a very reasonable idea ... what's keeping you? :-)

Posted :-)

Thanks,
drew
