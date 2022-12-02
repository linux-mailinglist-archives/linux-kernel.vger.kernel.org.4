Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3A640552
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiLBKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiLBKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:54:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CCCD3793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:54:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b11so4585670pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=87xJ37nY6S8gWCE8fBJ5L7O3V8ksDd+rlKQ9M8Zl788=;
        b=uUHv3AJ7VaCpRzS1HBAjRlglZSkNl0PxQgPX6vJPHIwbKyFm/frG6lqLOVK6s7TRv/
         0NouhTV4G31CjYEPZch3UibLYVMEW5m0FfDfV3GaaLXug/bmyOb0CzpvpDzc2vJzDjLr
         zlwiiRcPGtLYgc5eY7LMHskyOr6a5uqRU8W+282dAvSPxPFX+rH8HozAedTbgTBwgiFU
         crH2tyK6qkw/Wq+ngaN+z7BVS0qso4UoDc4PJMBvkgNSTOXuvQ4JlbVy66VgabXcXvhD
         jyMev/cykbECybYt2nbwZplNbh9hR+oF1roOkNjO7f/IF+Nc9oOF+7Mwrqy23BK7LLuD
         x5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87xJ37nY6S8gWCE8fBJ5L7O3V8ksDd+rlKQ9M8Zl788=;
        b=YSIcISIeQXV6Bng2D8mhDxFWZw/X5u1vzTBupgzg56Y4ORFCbrcf8ZEKbidhlhsjIj
         ZKpfiTFU72R36+eHANRU+s1nD9A4cr0L2NH+5c3Zwdycw8Q7+z9T+3ycCfaTrL7MyGUf
         AqLRQ8/qQjkRbqgdLs79EhAPY2gXimmcMn1ZN0YZyJzPoGGSY9Lrp8RVilJwL6RUX7fP
         Jj6wCXjSeMNSZl4fjP03KwFdI53Bypr9dTeHApYEl2lPewvZAN+OeeyJP6u2yf0xqr7G
         lFHTfblbJ6+9QUw8PnGydORTdYFUJ7bZSRBERKhgx/PSOP7j/kBShuZpQhANjK8dJ9pb
         JbaA==
X-Gm-Message-State: ANoB5pkb3QN4kwSOTXNFfygPBR/gtdDnKBP1qERCfuwOE38BISPmA4es
        3WrAHIhL1apFZQbM7D4dnw3i
X-Google-Smtp-Source: AA0mqf7QTy9EvaVhH/QvvAaAlAR4rnIOPV5LVSxdoViAUPyb844tJpq+NtFQcLI6bRfQBzfoDPipIQ==
X-Received: by 2002:a17:90b:2801:b0:200:2069:7702 with SMTP id qb1-20020a17090b280100b0020020697702mr76236667pjb.239.1669978451512;
        Fri, 02 Dec 2022 02:54:11 -0800 (PST)
Received: from thinkpad ([27.111.75.154])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0017f59ebafe7sm5246857plg.212.2022.12.02.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:54:10 -0800 (PST)
Date:   Fri, 2 Dec 2022 16:24:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221202105403.GG5356@thinkpad>
References: <20221118105402.GA184726@thinkpad>
 <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
 <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202100357.GB29396@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 10:03:58AM +0000, Will Deacon wrote:
> On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
> > On 02.12.22 09:26, Amit Pundir wrote:
> > > On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >>
> > >> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> > >>> Has any progress been made to fix this regression? It afaics is not a
> > >>> release critical issue, but well, it still would be nice to get this
> > >>> fixed before 6.1 is released.
> > >>
> > >> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
> > >> that exposed the driver bug. It doesn't fix the actual bug, it only
> > >> makes it less likely to happen.
> > >>
> > >> I like the original commit removing the cache invalidation as it shows
> > >> drivers not behaving properly
> > 
> > Yeah, I understand that, but I guess it's my job to ask at this point:
> > "is continuing to live with the old behavior for one or two more cycles"
> > that much of a problem"?
> 
> That wouldn't be a problem. The problem is that I haven't see any efforts
> from the Qualcomm side to actually fix the drivers so what makes you think
> the issue will be addressed in one or two more cycles? On the other hand, if
> there were patches out there trying to fix the drivers and we just needed to
> revert this change to buy them some time, then that would obviously be the
> right thing to do.
> 

There are efforts going on to fix the driver from Qualcomm. It's just that the
patches are not available yet. The delay is mainly due to the internal
communication that should happen between the internal teams.

The fix would be use a separate no-map carveout for the usecase.

But it'd be good to revert this patch untill those patches get merged.

Thanks,
Mani

> > >> but, as a workaround, we could add a
> > >> command line option to force back the old behaviour (defaulting to the
> > >> new one) until the driver is fixed.
> > 
> > Well, sometimes that approach is fine to fix a regression, but I'm not
> > sure this is one of those situations, as this...
> > 
> > > We use DB845c extensively for mainline and android-mainline[1] testing
> > > with AOSP, and it is broken for weeks now. So be it a temporary
> > > workaround or a proper driver fix in place, we'd really appreciate a
> > > quick fix here.
> > 
> > ...doesn't sound like we are not talking about some odd corner case
> > here. But in the end that would be up to Linus to decide.
> 
> The issue is that these drivers are abusing the DMA API to manage buffers
> which are being transferred to trustzone. Even with the revert, this is
> broken (the CPU can speculate from the kernel's cacheable linear mapping
> of memory), it just appears to be less likely with the CPUs on this SoC.
> So we end up in a situation where the kernel is flakey on these devices
> but with even less incentive for the drivers to be fixed.
> 
> As well as broken drivers, the patch has also identified broken device-tree
> files where DMA-coherent devices weher incorrectly being treated as
> non-coherent:
> 
> https://lore.kernel.org/linux-arm-kernel/20221124142501.29314-1-johan+linaro@kernel.org/
> 
> so I do think it's something that's worth having as the default behaviour.
> 
> > I'll point him to this thread once more in my weekly report anyway.
> > Maybe I'll even suggest to revert this change, not sure yet.
> 
> As I said above, I think the revert makes sense if the drivers are actually
> being fixed, but I'm not seeing any movement at all on that front.
> 
> Will

-- 
மணிவண்ணன் சதாசிவம்
