Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91649643FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiLFJYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiLFJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:23:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36E20F41
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:21:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b11so13860543pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37i4PLhbvOixYkzJrk3nfK3Vs02mt4pjFCyGYhE/6yw=;
        b=bd2kgLbTRBfKMhrHPs+EtDK3iSVQ7Hb/AsOw0eqpX1g6kfVd33s1+fpQx4UJ/GC0VT
         nHsQEPkielwsNM2G9ZWPwYoXqOkZD+E9lrXmZcZ/rLVPO6ksAV9k5nQ3jaLUbx6fzI0T
         PLmRlDChnPWj0wkjBVGYiFKYevIpoflU2f2k3CphvcQS0e1HyxPI4MLoBcYAGf5N4ait
         4fQyfD7mj4DREW20VMbftjq+/Ab2uXyYtoI084nuzdLQTkMgtFE9AtFxmumazHTWr0Bi
         AtBuU+/n8TnQvQgVI4RRk2y4h0GPKzmaOw/D7VuHFd3nBPuemFI0TEOU+7Fr6F4TaiLj
         qVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37i4PLhbvOixYkzJrk3nfK3Vs02mt4pjFCyGYhE/6yw=;
        b=NgfrXUp8lTYkC6VTKBUhzT7oRjv8HQL86aW5XrhwZQJO9AmTgKLkLSh5a5VXeDXiQH
         ZLEmZ8NXpifN8v2KJzIqTdeMWnZB2I/fOPS1pX/9Jo6T6pOaxTlUUihpF24Eaj+acvks
         l/vRWpZu4LtPnBZ6mOSxDTP8lKAdSk7Ld6eiSdsbpgmVHxoHbdHIX7IyKJqLthBDshws
         7+aPMHEkMhFNQ4Wg2mWrvZ5gMtaQw6qFzjEilhklRJUCCrqiBVxwRiAsaqEBW+A/3PvZ
         CvI5MVb9+2IXbf9gH/gTaqK6usHlT6MMefHpTsrWYTbJHQGntFNVaRokvdIXakVYMgls
         Jclw==
X-Gm-Message-State: ANoB5pmu9tOV0110z3UpsC09Wl+sVNs9eFY6VWS6jn7zu1h93RhJmjpU
        qTxuboA+Ix5DRwvisDqBw4D/
X-Google-Smtp-Source: AA0mqf450XD3p4pvvnhWO0oR2aiyvMsnhY2p+vYqQxKwKPZhZQ+tB+itI0bN2tbzOP7VC0mY1kON9w==
X-Received: by 2002:a17:90b:3011:b0:219:5f5a:7192 with SMTP id hg17-20020a17090b301100b002195f5a7192mr33374737pjb.144.1670318518914;
        Tue, 06 Dec 2022 01:21:58 -0800 (PST)
Received: from thinkpad ([59.92.103.18])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001869f2120a4sm12053483pli.94.2022.12.06.01.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:21:57 -0800 (PST)
Date:   Tue, 6 Dec 2022 14:51:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221206092152.GD15486@thinkpad>
References: <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
 <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
 <Y4ojXyXMX2p+RVBR@kroah.com>
 <395ad6ef-eb54-ec7e-e131-714f23c84d7a@leemhuis.info>
 <Y4oos/xXL+tLT7E7@kroah.com>
 <20221202171437.GH5356@thinkpad>
 <20221205142402.GA31783@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221205142402.GA31783@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:24:03PM +0000, Will Deacon wrote:
> On Fri, Dec 02, 2022 at 10:44:37PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Dec 02, 2022 at 05:32:51PM +0100, Greg KH wrote:
> > > On Fri, Dec 02, 2022 at 05:27:24PM +0100, Thorsten Leemhuis wrote:
> > > > On 02.12.22 17:10, Greg KH wrote:
> > > > > On Fri, Dec 02, 2022 at 11:34:30AM +0100, Thorsten Leemhuis wrote:
> > > > >> On 02.12.22 11:03, Will Deacon wrote:
> > > > >>> On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> > > > >>>> On 02.12.22 09:26, Amit Pundir wrote:
> > > > >>>>> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > >>>>>>
> > > > >>>>>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> > > > >>>>>>> Has any progress been made to fix this regression? It afaics is not a
> > > > >>>>>>> release critical issue, but well, it still would be nice to get this
> > > > >>>>>>> fixed before 6.1 is released.
> > > > >>>>>>
> > > > >>>>>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> > > > >>>>>> that exposed the driver bug. It doesn't fix the actual bug, it only
> > > > >>>>>> makes it less likely to happen.
> > > > >>>>>>
> > > > >>>>>> I like the original commit removing the cache invalidation as it shows
> > > > >>>>>> drivers not behaving properly
> > > > >>>>
> > > > >>>> Yeah, I understand that, but I guess it's my job to ask at this point:
> > > > >>>> "is continuing to live with the old behavior for one or two more cycles"
> > > > >>>> that much of a problem"?
> > > > >>>
> > > > >>> That wouldn't be a problem. The problem is that I haven't see any efforts
> > > > >>> from the Qualcomm side to actually fix the drivers [...]
> > > > >>
> > > > >> Thx for sharing the details. I can fully understand your pain. But well,
> > > > >> in the end it looks to me like this commit it intentionally breaking
> > > > >> something that used to work -- which to my understanding of the "no
> > > > >> regression rule" is not okay, even if things only worked by chance and
> > > > >> not flawless.
> > > > > 
> > > > > "no regressions" for userspace code, this is broken, out-of-tree driver
> > > > > code, right?
> > > > 
> > > > If so: apologies. But that's not the impression I got, as Amit wrote "I
> > > > can reproduce this crash on vanilla v6.1-rc1 as well with no out-of-tree
> > > > drivers." here:
> > > > https://lore.kernel.org/linux-arm-kernel/CAMi1Hd3H2k1J8hJ6e-Miy5+nVDNzv6qQ3nN-9929B0GbHJkXEg@mail.gmail.com/
> > > 
> > > Ah, I missed that.
> > > 
> > > Ok, what in-tree drivers are having problems being buggy?  I can't seem
> > > to figure that out from that report at all.  Does anyone know?
> > > 
> > 
> > It is the Qualcomm Q6V5_MSS remoteproc driver:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_q6v5_mss.c
> > 
> > Qualcomm is working on the fix but the patches are not ready yet. So if we can
> > get this patch reverted in the meantime, that would be helpful.
> 
> It's good to hear that you're working to fix this, even if it's happening
> behind closed doors. Do you have a rough idea how soon you'll be able to
> post the remoteproc driver fixes? That would help us to figure out when
> to bring back the change if we were to revert it.
> 

Sibi is the one working on the fix. I believe he should be able to post the
patches within this week.

Thanks,
Mani

> Cheers,
> 
> Will

-- 
மணிவண்ணன் சதாசிவம்
