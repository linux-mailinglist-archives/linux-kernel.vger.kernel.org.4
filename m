Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD186638CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiKYOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKYOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:45:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB233F044;
        Fri, 25 Nov 2022 06:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37CDD624C5;
        Fri, 25 Nov 2022 14:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8978BC433D6;
        Fri, 25 Nov 2022 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669387464;
        bh=MuAwpha+qj7ypes7vfXT4oKy6o8DH33QwZ2K7CESjKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtMjx0KGVzlDUNKm+iMxXswVni2hxX+w+hhhpGHCT+Cq9vtG2la0i8kZdrgDcrKre
         l7YNHyUJopFpdtCU/SylE/gHjsuBb+Y+37fMtJioOR+i1itWiCp2OR2HKNqZoJgYlQ
         Moww0jEGsfFQQWAiQUcA5XkaMB7TIpgjN2kwWZJs8BkfEDkXlSAywj1wBxzGsT7nHU
         J/p97AVBmXrTL49HkwK6b12SxQWq3QNdel2QZbgqxXD5QU01m0WZl/ah0L9u5SdVWX
         xPqTeZGTQef9M5ffcumt42YtbCt+VrPmEb7n8pWuIJRhwE5IPB1pKwxtgN48H03SH3
         9s2eEDi3UAp/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyZvr-0005Sz-98; Fri, 25 Nov 2022 15:44:00 +0100
Date:   Fri, 25 Nov 2022 15:43:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <Y4DUr7tVqnFT5HV9@hovoldconsulting.com>
References: <20221124142501.29314-1-johan+linaro@kernel.org>
 <20221125142625.GA9892@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125142625.GA9892@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:56:25PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 24, 2022 at 03:25:01PM +0100, Johan Hovold wrote:
> > The devices on the SC8280XP PCIe buses are cache coherent and must be
> > marked as such to avoid data corruption.
> > 
> > A coherent device can, for example, end up snooping stale data from the
> > caches instead of using data written by the CPU through the
> > non-cacheable mapping which is used for consistent DMA buffers for
> > non-coherent devices.
> > 
> 
> Also, the device may write into the L2 cache (or whatever cache that is
> accessible) if there is an entry and the CPU may invalidate it before reading
> from the DMA buffer. This will end up in a data loss.

I mentioned the above as an example, but clearly it can affect also the
other direction (e.g. as described below).

> > Note that this is much more likely to happen since commit c44094eee32f
> > ("arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()")
> > that was added in 6.1 and which removed the cache invalidation when
> > setting up the non-cacheable mapping.
> > 
> > Marking the PCIe devices as coherent specifically fixes the intermittent
> > NVMe probe failures observed on the Thinkpad X13s, which was due to
> > corruption of the submission and completion queues. This was typically
> > observed as corruption of the admin submission queue (with well-formed
> > completion):
> > 
> > 	could not locate request for tag 0x0
> > 	nvme nvme0: invalid id 0 completed on queue 0
> > 
> > or corruption of the admin or I/O completion queues (malformed
> > completion):
> > 
> > 	could not locate request for tag 0x45f
> > 	nvme nvme0: invalid id 25695 completed on queue 25965
> > 
> > presumably as these queues are small enough to not be allocated using
> > CMA which in turn make them more likely to be cached (e.g. due to
> > accesses to nearby pages through the cacheable linear map). Increasing
> > the buffer sizes to two pages to force CMA allocation also appears to
> > make the problem go away.
> > 
> 
> I don't think the problem will go away if the allocation happens from CMA
> region. It may just decrease the chances of cache hit but it could always
> happen due to the existence of linear mapping with cacheable attribute.

I never claimed it would fix the problem, I explicitly wrote that it
made it less likely to occur (to the point where my reproducer no longer
triggers).

Johan
