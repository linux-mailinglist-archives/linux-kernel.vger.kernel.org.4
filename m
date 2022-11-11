Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633B6261CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiKKTSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiKKTSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:18:32 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0132F10AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:18:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l2so4914731pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ChXkypL1e79YaYLPf83g3bjdsqV/sxHQLvykh23QYA=;
        b=DAS3NipRPRw26P0va1WcanhzdwWh5amO10iU1dvB6rrpcu8+m0+2A6pHX9OIKXuFuG
         WAZ9jtgTKKjGfP5Oh7m5enagd/UuErjBkh9klq2l4fVHQql9paBjCZLTAdeUT6O0472l
         nusGWSNAS/ViE9GMgNVg7sCENqdvOnWhOUAxuLtnyvmjqHx372FjFhGHpwGzQKRwbIlk
         s9PgN4gqyowNr2LoJC0wvr5czma8vQ+/2/Ugwc7hrL7wJHrw46jKhAf7plnlP2RcY9ou
         SF9zaIKz9rqnBcuWYldDz2+QXoTvT55YTW+EBsuHS2XKsr/3Qy8T7vrBQ7lvQ42nJ4Zu
         wgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ChXkypL1e79YaYLPf83g3bjdsqV/sxHQLvykh23QYA=;
        b=dv4WmH1N0j8dlTvGmsE4GBzU5X/iVzQYqeNhKO1u8OGWi6Ss74iPdwuDtxuh2PA5MX
         EjTUbxTE6/ocsJYPiLplCXWJbLV3YCqHRT7NAvdy7Cy9IB6Iss/21BuR2SbwjfOy4409
         okMTkgPutBKC9rAmiIJZvfqCrNCENnecjDwSlVKrHG7eEm9SoOPY0ii17TnsGhOTGOWf
         N0CaBADm7ugoouY1X+cwEV9Sa2kKtOOzNzo57gAXJ8DeAkl3YehWypZIB9WMIYyGbWzy
         E1CH1aMhHcKrQhng9aeuEDAy5D8h/M83vSyHw8/99IVGhZV9emNuVaS2U/8nPqpNwNZT
         u9aQ==
X-Gm-Message-State: ANoB5pkVWD55tcaggKmOhOCwDcapBVQOW0l3ikLsD849cJ2wknkI5ekb
        q5kvksfNQocMkqPbO3c5goY1
X-Google-Smtp-Source: AA0mqf5Lsp1U9iBz6LlSw42FkLd8r7T5udXAuimhhls365tGSbWD2BM/gETXIk79VCBXGr7/qFpVCg==
X-Received: by 2002:a17:90a:d791:b0:213:f465:14e7 with SMTP id z17-20020a17090ad79100b00213f46514e7mr3348799pju.194.1668194307391;
        Fri, 11 Nov 2022 11:18:27 -0800 (PST)
Received: from thinkpad ([117.202.188.198])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0017f48a9e2d6sm2028327plr.292.2022.11.11.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:18:25 -0800 (PST)
Date:   Sat, 12 Nov 2022 00:48:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
Message-ID: <20221111191820.GC5393@thinkpad>
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
 <Y0aq8y5mEZi14lJ/@arm.com>
 <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
 <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
 <Y24uvyDJU3CL1jOi@arm.com>
 <20221111173952.GB5393@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111173952.GB5393@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:10:01PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 11, 2022 at 11:15:11AM +0000, Catalin Marinas wrote:
> > On Tue, Nov 08, 2022 at 10:58:16PM +0530, Amit Pundir wrote:
> > > On Tue, 25 Oct 2022 at 18:08, Amit Pundir <amit.pundir@linaro.org> wrote:
> > > > On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
> > > > > > On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > > Will Deacon (2):
> > > > > > >       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
> > > > > >
> > > > > > This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
> > > > > > relevant crash in the attached log and device silently reboots into
> > > > > > USB crash dump mode. The crash is fairly reproducible on db845c. I
> > > > > > could trigger it twice in 5 reboots and it always crash at the same
> > > > > > point during the boot process. Reverting this patch fixes the crash.
> > > > > >
> > > > > > I'm happy to test run any debug patche(s), that would help narrow
> > > > > > down this breakage.
> > [...]
> > > > Further narrowed down the breakage to the userspace daemon rmtfs
> > > > https://github.com/andersson/rmtfs. Is there anything specific in the
> > > > userspace code that I should be paying attention to?
> > 
> > Since you don't see anything in the logs like a crash and the system
> > restarts, I suspect it's some deadlock and that's triggering the
> > watchdog. We have an erratum (826319) but that's for Cortex-A53. IIUC
> > SDM845 has Kryo 3xx series which based on some random google searches is
> > derived from A75/A55. Unfortunately the MIDR_EL1 register doesn't match
> > the Arm Ltd numbering, so I have no idea what CPUs these are by looking
> > at the boot log.
> > 
> > I wouldn't be surprised if you hit a similar bug, though I couldn't find
> > anything close in the A55 errata notice.
> > 
> > While we could revert commit c44094eee32f ("arm64: dma: Drop cache
> > invalidation from arch_dma_prep_coherent()"), if you hit a real hardware
> > issue it may trigger in other scenario where we only do cache cleaning
> > (without invalidate), like arch_sync_dma_for_device(). So I'd rather get
> > to the bottom of this and potentially enable the workaround for this
> > chipset.
> > 
> > You could give it a quick try to by adding the MIDR ranges for SDM845 to
> > struct midr_range workaround_clean_cache[].
> > 
> 
> I gave it a shot and indeed it fixes the crash on DB845.
> 
> > After that I suggest you raise it with Qualcomm to investigate. Normally
> > we ask for an erratum number to enable a workaround and it's only
> > Qualcomm that can provide one here.
> > 
> 
> I will check with Qualcomm folks and update.
> 

I digged a little further and found that the crash was due to the secure
processor (XPU) violation. It happens because, CPU tried acccessing the memory
after sharing it with the modem for firmware metadata validation.

Sibi tried fixing this problem earlier by using a hack in the remoteproc driver
[1], but I guess that got negated due to c44094eee32f?

This is a common issue for other Qcom remoteproc drivers as well where CPU
shares a chunk of memory with the modem. There is one more hack in place where
the a chunk of memory is reserved and the driver will do memremap/copy the
data/memunmap using it and share it with modem.

But is there a better solution overall that you could advise?

Thanks,
Mani

[1] https://lore.kernel.org/lkml/1652248625-990-1-git-send-email-quic_sibis@quicinc.com/

> Thanks,
> Mani
> 
> > -- 
> > Catalin
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
