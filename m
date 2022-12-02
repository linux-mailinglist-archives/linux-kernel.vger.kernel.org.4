Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE4640BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiLBROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLBROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:14:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B158C461D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:14:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g10so5180526plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4uN/3QFi8U1HGcJEDQxrHZlZaj2vYk4vsDWe2Gzo9A=;
        b=gw3Bk31An4CPLvLHcrZwgA3ulM0t1laovibt4xreGiXJhi5SsmanZ26daeps6erfOt
         p3gTz6tRRQrR2LTY2iZmAAkZVp8HkVlofw2GcG4byuSLWxr60XEXRzFyCtr5BLoVtguN
         yTN1J/nYyRkxp8ln0yuBXvroFp6aDsYoKkJIyhpBlzeyY2lTntw/p1DGsWc/s7bX8VpE
         WFCBv1+lriReT36Jxcet8ZLVI4/gMda0ZOpGdU0HhnVE7ddgEp9tyw4iLuStdVzvN5ez
         H9l6NUiN9Nign9PrdfDQzyXh+v4Xzbm+rhSfERgJoiIWr+UVeCBiYyma0tQ2sfr+9EVL
         UiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4uN/3QFi8U1HGcJEDQxrHZlZaj2vYk4vsDWe2Gzo9A=;
        b=DuZQblzSb8F/7w5sFqTMKg+POY8qSPYfqFvmy2pZXcyQjrlYI2oTI1o3LVNqBN2c71
         npos95fSew/VYvw4FqlDriYmGMWp1PGtcviR2NnzXrV+nqE5FR4inrUYQywla8pkraje
         d71YaHuUXua1ZnKgdUWuBzXk9bfM3+GRqYTNZQpvsAFI2PVf86XoOgKgfbpowUL7GVAW
         XHamAMFB9HO5cXkRZ/99+YAaZhaw8gRXPTgNHDhjiC547YOmqITvCCHmfuuHXLYPT+3+
         /tIQDXaHzxOPpbea3AXDYdpV4YTMUHtRBmmMzu5tljTpooZimdehB1tVRbk/kniIqbWN
         GmpQ==
X-Gm-Message-State: ANoB5pnXXsvJxfrJaO8k8uABu7PfiYgyyPFf1uQWqOtNezDmqISV2yCe
        SepvAGfuynwmygpVqsowVgQu
X-Google-Smtp-Source: AA0mqf4ci+QJTB8JEwIUkumxLgkarjQyEKIS9UcJ/kSPVAkdJMVAO4Pxlnx9DArniUhgy93AEUn1Mw==
X-Received: by 2002:a17:90b:30c6:b0:219:11ae:265f with SMTP id hi6-20020a17090b30c600b0021911ae265fmr37795485pjb.194.1670001285029;
        Fri, 02 Dec 2022 09:14:45 -0800 (PST)
Received: from thinkpad ([27.111.75.154])
        by smtp.gmail.com with ESMTPSA id jf1-20020a170903268100b00186b7443082sm5811742plb.195.2022.12.02.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:14:43 -0800 (PST)
Date:   Fri, 2 Dec 2022 22:44:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Will Deacon <will@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221202171437.GH5356@thinkpad>
References: <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
 <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
 <Y4ojXyXMX2p+RVBR@kroah.com>
 <395ad6ef-eb54-ec7e-e131-714f23c84d7a@leemhuis.info>
 <Y4oos/xXL+tLT7E7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4oos/xXL+tLT7E7@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:32:51PM +0100, Greg KH wrote:
> On Fri, Dec 02, 2022 at 05:27:24PM +0100, Thorsten Leemhuis wrote:
> > 
> > 
> > On 02.12.22 17:10, Greg KH wrote:
> > > On Fri, Dec 02, 2022 at 11:34:30AM +0100, Thorsten Leemhuis wrote:
> > >> On 02.12.22 11:03, Will Deacon wrote:
> > >>> On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> > >>>> On 02.12.22 09:26, Amit Pundir wrote:
> > >>>>> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >>>>>>
> > >>>>>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> > >>>>>>> Has any progress been made to fix this regression? It afaics is not a
> > >>>>>>> release critical issue, but well, it still would be nice to get this
> > >>>>>>> fixed before 6.1 is released.
> > >>>>>>
> > >>>>>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> > >>>>>> that exposed the driver bug. It doesn't fix the actual bug, it only
> > >>>>>> makes it less likely to happen.
> > >>>>>>
> > >>>>>> I like the original commit removing the cache invalidation as it shows
> > >>>>>> drivers not behaving properly
> > >>>>
> > >>>> Yeah, I understand that, but I guess it's my job to ask at this point:
> > >>>> "is continuing to live with the old behavior for one or two more cycles"
> > >>>> that much of a problem"?
> > >>>
> > >>> That wouldn't be a problem. The problem is that I haven't see any efforts
> > >>> from the Qualcomm side to actually fix the drivers [...]
> > >>
> > >> Thx for sharing the details. I can fully understand your pain. But well,
> > >> in the end it looks to me like this commit it intentionally breaking
> > >> something that used to work -- which to my understanding of the "no
> > >> regression rule" is not okay, even if things only worked by chance and
> > >> not flawless.
> > > 
> > > "no regressions" for userspace code, this is broken, out-of-tree driver
> > > code, right?
> > 
> > If so: apologies. But that's not the impression I got, as Amit wrote "I
> > can reproduce this crash on vanilla v6.1-rc1 as well with no out-of-tree
> > drivers." here:
> > https://lore.kernel.org/linux-arm-kernel/CAMi1Hd3H2k1J8hJ6e-Miy5+nVDNzv6qQ3nN-9929B0GbHJkXEg@mail.gmail.com/
> 
> Ah, I missed that.
> 
> Ok, what in-tree drivers are having problems being buggy?  I can't seem
> to figure that out from that report at all.  Does anyone know?
> 

It is the Qualcomm Q6V5_MSS remoteproc driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_q6v5_mss.c

Qualcomm is working on the fix but the patches are not ready yet. So if we can
get this patch reverted in the meantime, that would be helpful.

Thanks,
Mani

> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
