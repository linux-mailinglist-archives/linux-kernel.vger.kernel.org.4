Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF882638CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKYOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKYOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:53:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C8628738
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:53:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so3196883pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEL6Kbr+HdwY+UWUkv0USE/Ww2DAfRqHJN30xRQuHfE=;
        b=HPoo/A6uH3qT91Mz1+v25Mzk5kNO0o9889sZJX0Uro3IG6jlAkYFS3DjVSmSIvjaWN
         mUHa4LQx5fE6NmB4Hgo1XTqHT+gla/K47bmNyybaVV7PBYz7mS7ieGF67qMR8VAC8SK8
         /e/oJE39ih8FfwTvb5DYDBm9lPMkUqpeCLnEda+82BRkYR84Os9W7/fGrCgT8xt2MbA4
         /V8tMAa4L55AA36SrrxT2Dj+UX65pZqod2HCTDHxQZWavBQjzEsOay+SkAvKt6r01zeG
         ngp02iYwXPDJFd/6E4Jl7Hom2+3gwKtvrC90FUNUV/vH2kGnsbD2qQ1xjyyYaA0IdSAY
         ASTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEL6Kbr+HdwY+UWUkv0USE/Ww2DAfRqHJN30xRQuHfE=;
        b=yN+MNFNi9awJfSQdO9IxZxuGvwMC4GZyETpM4QKGU+l7INECepG4AOj5Q9SwO5Bm8n
         X4GUY1j1r+mgQ3HxADa+yP52bhR4uGKe4zTHCgNTiKTTa525xo4dHeTlOy23IUQBUWD5
         /uKtlVDzMFuDR7PEr2Nx1WXeEmCmDBBHnRfI5j0+wPWrYNcueeJ9jVb/UAwNhpf4KapU
         HGVUaus1reIm3wrbVdk5BdKgD8FfyJM6BQEbqrTy7AG7aJF8xy90Dhb75APE5jJs30J2
         2Ia2sFljQ2h/4Nk24T25+WlbwSLRF9dVUwANB2/nt2QCXLjnsoaJaN3tk9JNLRurBeFW
         6oWw==
X-Gm-Message-State: ANoB5pma9r0981dlOjwNJpcff2iq9aojoZQYYqX52qK5WX2DPw0hafDc
        D88/28ePTvSKgYxwsfE2PDg4
X-Google-Smtp-Source: AA0mqf7HjBLKze1SBILKxPgmoDtboSFCsmzP286bDV9AxMFHqsThNG+9U+uA0jo2ztDAw52O07U33A==
X-Received: by 2002:a17:90a:2f23:b0:218:72e0:307b with SMTP id s32-20020a17090a2f2300b0021872e0307bmr40753662pjd.183.1669388025066;
        Fri, 25 Nov 2022 06:53:45 -0800 (PST)
Received: from thinkpad ([117.202.190.212])
        by smtp.gmail.com with ESMTPSA id 15-20020a630f4f000000b0047702d44861sm2659303pgp.18.2022.11.25.06.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:53:44 -0800 (PST)
Date:   Fri, 25 Nov 2022 20:23:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency
Message-ID: <20221125145336.GB9892@thinkpad>
References: <20221124142501.29314-1-johan+linaro@kernel.org>
 <20221125142625.GA9892@thinkpad>
 <Y4DUr7tVqnFT5HV9@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4DUr7tVqnFT5HV9@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 03:43:59PM +0100, Johan Hovold wrote:
> On Fri, Nov 25, 2022 at 07:56:25PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 24, 2022 at 03:25:01PM +0100, Johan Hovold wrote:
> > > The devices on the SC8280XP PCIe buses are cache coherent and must be
> > > marked as such to avoid data corruption.
> > > 
> > > A coherent device can, for example, end up snooping stale data from the
> > > caches instead of using data written by the CPU through the
> > > non-cacheable mapping which is used for consistent DMA buffers for
> > > non-coherent devices.
> > > 
> > 
> > Also, the device may write into the L2 cache (or whatever cache that is
> > accessible) if there is an entry and the CPU may invalidate it before reading
> > from the DMA buffer. This will end up in a data loss.
> 
> I mentioned the above as an example, but clearly it can affect also the
> other direction (e.g. as described below).
> 
> > > Note that this is much more likely to happen since commit c44094eee32f
> > > ("arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()")
> > > that was added in 6.1 and which removed the cache invalidation when
> > > setting up the non-cacheable mapping.
> > > 
> > > Marking the PCIe devices as coherent specifically fixes the intermittent
> > > NVMe probe failures observed on the Thinkpad X13s, which was due to
> > > corruption of the submission and completion queues. This was typically
> > > observed as corruption of the admin submission queue (with well-formed
> > > completion):
> > > 
> > > 	could not locate request for tag 0x0
> > > 	nvme nvme0: invalid id 0 completed on queue 0
> > > 
> > > or corruption of the admin or I/O completion queues (malformed
> > > completion):
> > > 
> > > 	could not locate request for tag 0x45f
> > > 	nvme nvme0: invalid id 25695 completed on queue 25965
> > > 
> > > presumably as these queues are small enough to not be allocated using
> > > CMA which in turn make them more likely to be cached (e.g. due to
> > > accesses to nearby pages through the cacheable linear map). Increasing
> > > the buffer sizes to two pages to force CMA allocation also appears to
> > > make the problem go away.
> > > 
> > 
> > I don't think the problem will go away if the allocation happens from CMA
> > region. It may just decrease the chances of cache hit but it could always
> > happen due to the existence of linear mapping with cacheable attribute.
> 
> I never claimed it would fix the problem, I explicitly wrote that it
> made it less likely to occur (to the point where my reproducer no longer
> triggers).
> 

> Increasing the buffer sizes to two pages to force CMA allocation also appears
> to make the problem go away.

The "go away" part sounded like a claim to me and hence I added the statement.
But no worries :)

Thanks,
Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
