Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223356319CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKUGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUGmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:42:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C16EAF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:42:28 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b29so10462022pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ka6Q0Zy6QrfcwL/CSvIzpjvnD4BQcyLVYFcLJW2zm44=;
        b=eNAoMx9XYSD3E6TlqY/LO/eSe6DOJcSXrUsT2o3LX4RdBXicRWFCc+ECtGK8SsDC1X
         VTsgWPxoc30xplkGVv1b7y3+pkV7YUtn0zAcD5K/0LwThmy2aoomAPeK+y8UbPt7Axms
         Ug5VwOfkOb4YhyLAzewvgsAilQSOERs6Pr6tnfHR/CQ8blUy63w4uHO+adl9VXd+0l+m
         x2JoaaU0KR0xXZ/AHvUoe9UM3qM9KB/gV9KYQUbjjb+KaFjt7B4kvj5ow3v+iWHxzQPh
         E0kFS1P/FMAd07AMV1hSAVve3yRanQo34vG0NU++2Hfmzs/rOdVk2SsysmCBF+mno6V3
         N9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka6Q0Zy6QrfcwL/CSvIzpjvnD4BQcyLVYFcLJW2zm44=;
        b=xN9M/EIiJbpEWxNb5hImFIDWcr0Co2N1Z4VKkbMkDKn7sU8g//D+K6BSHVDCxziDXV
         o0lVy0Mr4OcUJmYZHW3uazkpJgI1duZ/iMcqLfj6+/C6BcRGjlOjmvMrkCmNlRpU7FvF
         dra4tX0VH6EgDQGCi9AiQX0DouzpVpk8TR32vXBTK+LqiqetxWmc90bRqODYCCfzDT59
         9jVXRMxM6H6MFUwLEvQxQokhoDDh62NOikYxww/A5Oi3QAE4Pm2V6vIVApE6BY/Ap9EQ
         nPfgkX3CTs5rXD8OBzp4e2oYaXesxqNeNqmaRg98AFydNzXfvkOE9s4xfMgasmFy4hzZ
         1Oyg==
X-Gm-Message-State: ANoB5pmmoJajsDDsfhJg/UWM9GYSp/tD4z9lhczEU1NHNwNbHWr84GVy
        hxFgSHIngVfnH7m67fDVYYZQ
X-Google-Smtp-Source: AA0mqf6SOw1bsMBSVvaKIDjRLtE0EG36yQRvgTWvQZmk5KxiBImOnTVz2U4HWOVmlCqxSJmqBWrIVw==
X-Received: by 2002:aa7:81d8:0:b0:561:c694:80b with SMTP id c24-20020aa781d8000000b00561c694080bmr18994198pfn.47.1669012948034;
        Sun, 20 Nov 2022 22:42:28 -0800 (PST)
Received: from thinkpad ([59.92.99.222])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016c9e5f291bsm8914094plh.111.2022.11.20.22.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 22:42:27 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:12:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, amit.pundir@linaro.org,
        andersson@kernel.org, quic_sibis@quicinc.com,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221121064224.GB11945@thinkpad>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
 <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad>
 <20221118123349.GC3697@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118123349.GC3697@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 12:33:49PM +0000, Will Deacon wrote:
> On Fri, Nov 18, 2022 at 04:24:02PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Nov 14, 2022 at 05:38:00PM +0000, Catalin Marinas wrote:
> > > On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
> > > > On 2022-11-14 14:11, Will Deacon wrote:
> > > > > On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
> > > > > > This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> > > > > > 
> > > > > > As reported by Amit [1], dropping cache invalidation from
> > > > > > arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> > > > > > (most probably on other Qcom platforms too). The reason is, Qcom
> > > > > > qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> > > > > > for validation. The modem has a secure block (XPU) that will trigger a
> > > > > > whole system crash if the shared memory is accessed by the CPU while modem
> > > > > > is poking at it.
> > > > > > 
> > > > > > To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
> > > > > > with no kernel mapping, vmap's it, copies the firmware metadata and
> > > > > > unvmap's it. Finally the address is then shared with modem for metadata
> > > > > > validation [2].
> > > > > > 
> > > > > > Now because of the removal of cache invalidation from
> > > > > > arch_dma_prep_coherent(), there will be cache lines associated with this
> > > > > > memory even after sharing with modem. So when the CPU accesses it, the XPU
> > > > > > violation gets triggered.
> > > > > 
> > > > > This last past is a non-sequitur: the buffer is no longer mapped on the CPU
> > > > > side, so how would the CPU access it?
> > > > 
> > > > Right, for the previous change to have made a difference the offending part
> > > > of this buffer must be present in some cache somewhere *before* the DMA
> > > > buffer allocation completes.
> > > > 
> > > > Clearly that driver is completely broken though. If the DMA allocation came
> > > > from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
> > > > shenanigans wouldn't work, so if it backed by struct pages then the whole
> > > > dance is still pointless because *a cacheable linear mapping exists*, and
> > > > it's just relying on the reduced chance that anything's going to re-fetch
> > > > the linear map address after those pages have been allocated, exactly as I
> > > > called out previously[1].
> > > 
> > > So I guess a DMA pool that's not mapped in the linear map, together with
> > > memremap() instead of vmap(), would work around the issue. But the
> > > driver needs fixing, not the arch code.
> > > 
> > 
> > Okay, thanks for the hint. Can you share how to allocate the dma-pool that's
> > not part of the kernel's linear map? I looked into it but couldn't find a way.
> 
> The no-map property should take care of this iirc
> 

Yeah, we have been using it in other places of the same driver. But as per
Sibi, we used dynamic allocation for metadata validation since there was no
memory reserved statically for that.

But if we do not have a way to allocate a dynamic memory that is not part of
kernel's linear map, then we may have to resort to using an existing reserved
memory.

Thanks,
Mani

> Will

-- 
மணிவண்ணன் சதாசிவம்
