Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10285638C16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKYO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKYO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:26:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E022AC72
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:26:34 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h193so4073520pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pr9EPBHz4BamKgB8yWADZkXZ2+tlYR/qk7DwwWPntys=;
        b=I22Ui3Ws2mdvy3i8n4OvfE7B4UBhCYea7j3aLWfiqH6e04pBvYdBesUghp62dWLwlP
         nUvmU/k0g1An/0OlJ34HaFJQiRBzF0H4W6T/bVUx1zm9Bl2bgWzoL3GpF4JfgONWkVbE
         EwQpaRMKtu1ensgpA7mEiE9oiRjstNpI6/teS/2EmsCih9G1zkFWu57x03IKOctYmO6b
         8uIFnuHSjhfW3vcW332yGJfmlCNj0hM2e3UlZ2FvRnUWb5xA0fGO9KsZPNX63gbTbsLc
         Avx33IJSJQXBDcMj1TDY9VR9YSk/OF8WhfUPLTuG21X7mpO1vVjJj47paR3SHE3BHjTr
         ROiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr9EPBHz4BamKgB8yWADZkXZ2+tlYR/qk7DwwWPntys=;
        b=Gggftb+jGqH38KJhHmj/iy8rvgSSUs/SZR8ICAjwMW+f45q8DlZyM3Xe5ScQcLjBp8
         dR69+3sGXGGcCKVLulk7wSLP8/ykiOo8DEZU3MxPrPK2RfxfvX9lYmtHl5WbllKDijD3
         By30ai6oPPrd0h8iAkQcwFKzXj8XsDxfl89CgsDXaiD76vdrXrTlGlfn1rg63s7ufyv3
         XiK6IaU75EezgwTfYxxawAMFyZZ7UhKMB25kRHubYfV0Bs8BGXygJsoAvTUgxpdBZLFs
         5lDHnLVCAsJmr5Nsd+/wPzR6n9S2DLrNPoSGWhZ2kV4z9jHKSVN7W/FOVCK8n4e6huhf
         vCeg==
X-Gm-Message-State: ANoB5plKqM+lPmxGn1CnlfM3NDJIX5wK1GMjIVA/PKi569IYgeAOgQ71
        vh9/YaAvFU7sK4sNCW5R5KD1
X-Google-Smtp-Source: AA0mqf49zCazD+UtCRa4BNYXgoE42BG1LqZ3W0LypZAXCz7fviyny0CBtnZkM2HGDAm3DL59CDuHnQ==
X-Received: by 2002:a63:1e62:0:b0:46b:3acb:77b2 with SMTP id p34-20020a631e62000000b0046b3acb77b2mr15395586pgm.560.1669386393687;
        Fri, 25 Nov 2022 06:26:33 -0800 (PST)
Received: from thinkpad ([117.202.190.212])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b00186ffe62502sm3448694plc.254.2022.11.25.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:26:32 -0800 (PST)
Date:   Fri, 25 Nov 2022 19:56:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20221125142625.GA9892@thinkpad>
References: <20221124142501.29314-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124142501.29314-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 03:25:01PM +0100, Johan Hovold wrote:
> The devices on the SC8280XP PCIe buses are cache coherent and must be
> marked as such to avoid data corruption.
> 
> A coherent device can, for example, end up snooping stale data from the
> caches instead of using data written by the CPU through the
> non-cacheable mapping which is used for consistent DMA buffers for
> non-coherent devices.
> 

Also, the device may write into the L2 cache (or whatever cache that is
accessible) if there is an entry and the CPU may invalidate it before reading
from the DMA buffer. This will end up in a data loss.

> Note that this is much more likely to happen since commit c44094eee32f
> ("arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()")
> that was added in 6.1 and which removed the cache invalidation when
> setting up the non-cacheable mapping.
> 
> Marking the PCIe devices as coherent specifically fixes the intermittent
> NVMe probe failures observed on the Thinkpad X13s, which was due to
> corruption of the submission and completion queues. This was typically
> observed as corruption of the admin submission queue (with well-formed
> completion):
> 
> 	could not locate request for tag 0x0
> 	nvme nvme0: invalid id 0 completed on queue 0
> 
> or corruption of the admin or I/O completion queues (malformed
> completion):
> 
> 	could not locate request for tag 0x45f
> 	nvme nvme0: invalid id 25695 completed on queue 25965
> 
> presumably as these queues are small enough to not be allocated using
> CMA which in turn make them more likely to be cached (e.g. due to
> accesses to nearby pages through the cacheable linear map). Increasing
> the buffer sizes to two pages to force CMA allocation also appears to
> make the problem go away.
> 

I don't think the problem will go away if the allocation happens from CMA
region. It may just decrease the chances of cache hit but it could always
happen due to the existence of linear mapping with cacheable attribute.

> Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Anyway, this is a really good find!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 27f5c2f82338..7748cd29276d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -854,6 +854,8 @@ pcie4: pcie@1c00000 {
>  				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
>  			bus-range = <0x00 0xff>;
>  
> +			dma-coherent;
> +
>  			linux,pci-domain = <6>;
>  			num-lanes = <1>;
>  
> @@ -951,6 +953,8 @@ pcie3b: pcie@1c08000 {
>  				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
>  			bus-range = <0x00 0xff>;
>  
> +			dma-coherent;
> +
>  			linux,pci-domain = <5>;
>  			num-lanes = <2>;
>  
> @@ -1046,6 +1050,8 @@ pcie3a: pcie@1c10000 {
>  				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
>  			bus-range = <0x00 0xff>;
>  
> +			dma-coherent;
> +
>  			linux,pci-domain = <4>;
>  			num-lanes = <4>;
>  
> @@ -1144,6 +1150,8 @@ pcie2b: pcie@1c18000 {
>  				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
>  			bus-range = <0x00 0xff>;
>  
> +			dma-coherent;
> +
>  			linux,pci-domain = <3>;
>  			num-lanes = <2>;
>  
> @@ -1239,6 +1247,8 @@ pcie2a: pcie@1c20000 {
>  				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
>  			bus-range = <0x00 0xff>;
>  
> +			dma-coherent;
> +
>  			linux,pci-domain = <2>;
>  			num-lanes = <4>;
>  
> -- 
> 2.37.4
> 

-- 
மணிவண்ணன் சதாசிவம்
