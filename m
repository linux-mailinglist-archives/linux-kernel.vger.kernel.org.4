Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CAC5FC0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJLGwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:52:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257A8053C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:51:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z3so22188272edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6Gfe2DXR3j95IDhPMundYuLswZnG5sQhGBSuBr4Vek=;
        b=Jf6svROqedy5cpY/qryRgnx9jnAZOVLWSIj4Xg+GRTFySlVlgHiA5HR/JeDyVvcPqb
         tviuMMvus/zDBUeusc9xKLA/+w8j26g5+RDf22sJyTKnXSEHS9g6vYDwlg9vC9MCNXT7
         QS7CtqDwRCirURa6HukWyMzfQMJjPhy1bGt2rThsPY0N+Uth9KN0lzZWa9eYnrqVOq6A
         Auz5mkl9xxOjEIDQsEV3XsJ+2QV0SudA0i345DOaO/CLmlf0LPUYmU6A6TodK9xJXbPn
         jrpux7xmrzjkDRy1Y8D02+HNe67/LJdg9aSRjNx7HccSLShrJJEmVI/5s4UIPDGOEYm0
         xuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Gfe2DXR3j95IDhPMundYuLswZnG5sQhGBSuBr4Vek=;
        b=lcyc1g9TH70R0Rjjy+YRS0Am80hfiyVRFWGNbU3GGNvo8kbPntwyd1trHNn1jrt0JT
         yd99aOg7FMUjRqqSATJtpslkMQolrkMUf2BgXbtqcwLhj5Z517r+NOdf8FTfo0umQVI+
         g3pyebWrW4kXJTL9ItmZZK5M8+DfUJb+hbojuRymPTNIiuEPoimRUUTMf+gf9KjaNx5t
         h4wXLy2xyqPoj0XhxLrfU8MfT1j6TYr1+e8GlvRtt7dI5JwISQKFq0GnhgYSljOCNsob
         DVaP1c6beCZVrpfnoJu+asUr+SA0YquTI2anpP9R2CJh+F+9GSrsRf6fj3/ZmhLNKdJU
         ZGhA==
X-Gm-Message-State: ACrzQf09c7t6KfdogX8DlgEEMYuDRr17OxSryOAOWWn6GAEiOLcHgczY
        AiiqI8j7tZG7giarsVa7Wv5W7PmdOaOK2w==
X-Google-Smtp-Source: AMsMyM4CI+l6phb/FvF7SGDs/PI5uqDhsyvLFsqzZ5G740D/TcSk8oYG1OsFypZWgJBI60fm4mbA/w==
X-Received: by 2002:a05:6402:27c6:b0:45c:1f1a:6b85 with SMTP id c6-20020a05640227c600b0045c1f1a6b85mr12818463ede.316.1665557516147;
        Tue, 11 Oct 2022 23:51:56 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id k1-20020aa7d2c1000000b00457a92f8ad6sm10507382edr.28.2022.10.11.23.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 23:51:55 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:51:54 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221012065154.p6mn35sy7fynkwdi@kamzik>
References: <20221011175031.1782748-1-ajones@ventanamicro.com>
 <Y0WvX9Mp0kuohNdq@zn.tnic>
 <20221011181715.dpayrpjueha7kxoj@kamzik>
 <CAAH8bW8Gz66aT4bBbxsrM4iYmpx-DDv8j_M48R+WOuSTravSgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW8Gz66aT4bBbxsrM4iYmpx-DDv8j_M48R+WOuSTravSgQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:02:26PM -0700, Yury Norov wrote:
> On Tue, Oct 11, 2022 at 11:17 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Tue, Oct 11, 2022 at 08:01:03PM +0200, Borislav Petkov wrote:
> > > On Tue, Oct 11, 2022 at 07:50:31PM +0200, Andrew Jones wrote:
> > > > Upcoming cpumask changes will start issuing warnings[*] when cpu
> > >
> > > What upcoming changes?
> > >
> > > This needs a concrete pointer to a commit or so.
> >
> > Hi Boris,
> >
> > Sorry, I should have pointed this out. The upcoming change is
> >
> > linux-next/master commit a314123c8bdb ("cpumask: fix checking valid cpu
> > range")
> >
> > And also an ongoing discussion here
> > https://lore.kernel.org/lkml/20221011170949.upxk3tcfcwnkytwm@kamzik/
> >
> > I'm hoping that Yury will pick these patches up and integrate
> > them at the front of his series when introducing the warnings.
> > I wasn't sure how to call that out other than with the generic
> > "upcoming change".
> >
> > >
> > > > indices equal to nr_cpu_ids are passed to cpumask_next* functions.
> > >
> > > How do those indices get passed here? I think you need to explain how
> > > exactly this happens.
> 
> The cpumask_check() fix is already in master. Because of some mess in

Ah, it's already in master. I should have checked that...

> cpumask, cpumask_check() was broken for quite a long time, and didn't
> bark when passed with an out-of-range CPU.
> 
> I fixed some false-positives and sent those fixes together with a314123c8bdb.
> Now, I expect that people will see warnings generated by correct
> cpumask_check().
> This is actually the first sign.
> 
> Andrew, can you please answer Borislav's question:

I answered in the discussion[1], but I'll send a v2 of this patch,
properly based on master, with a proper pointer to commit 78e5a3399421
("cpumask: fix checking valid cpu range"), and also with a condensed
analysis for justification in the commit message.

Thanks,
drew

> 
> > > How do those indices get passed here? I think you need to explain how
> > > exactly this happens.
> 
> It might be either an expected behaviour, and then there should be a great
> explanation on how and why things work in the subsystem.
> 
> Or it might be an error in the caller. In that case, the caller must be fixed.
> 
> Thanks,
> Yury
