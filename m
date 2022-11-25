Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B8638E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKYQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKYQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:13:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1CE4A068
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:13:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so226603pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=omkfYj5oSFznmhb4u7tTnm1L0UB6hbil0tTrnKAmbbQ=;
        b=UVM/rdjI4mHTUwuipq6e8V8IXrz00fsx19LNP7sVM2DA0dNjo1y3ZFkO3fpp/7qI7j
         yxKiFMnYUNPM8qM3WN7rkkpDf5T1DNSbkEmrrBnGnd4vzVrW+UJbBnQkV+UrC5vjSGqU
         wvshkoa4/zp3luUfvhOQl+HX+ya4mJGjwMnpHeCInzHkABi8prxuST1Ghy75lH00Yai1
         nZb9Soqdkbi8qz61c9ONA36vR6Q8yrIfzP+b6y3c+bX+EmygSjgUurvzeD56O6/vcpDn
         VniojYtd7XFx1zyQX4aPNvl9/zdyqesrZtW8emvTwLJ83ggAB/m+r9hSNyc66Daiekt8
         /GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omkfYj5oSFznmhb4u7tTnm1L0UB6hbil0tTrnKAmbbQ=;
        b=72b4Zuc93aTN+wcFVP/mCVZoHwJO/WIAqQb+BTLQBSBVgJ03gSmoauJIX75w5m74RX
         rbY5to6zGFfdku6mtGWo3nqs5dC/cch2GJVRwYzaCGssEXbYaLlajWkFSWgcuhUCBtMt
         uzYXp4vd0ZBkNN9VDCrycBuynfaSoARJPMH99uvuAvG0PDilZfQ/MDUhZkLoRWrIaAOk
         /cRnjYMdPVUayIuhxIK2bbWnqmTuHkr2A2Z8gyOP3dOFrK9QrxfJFIM8iNNpwFEy24Ub
         oYnRu5T35MBiTtfromw4KHQGgvazJ5vOU4Tbx1yyMTc4pK3H/rV8jLiJjao7kCNyHMes
         O6/w==
X-Gm-Message-State: ANoB5pm+z21LxUBss1c4b6uw0N73SALa/JFAPaLCuwKtYOwxzWSBvLMv
        a+GLCI15dxl2pdxtn3miq+72Tw==
X-Google-Smtp-Source: AA0mqf4BWYCFMMBqJb39R/fs9p2KTxW97AyFVcaznIZxF+QlxSZYD4kq9+zCoFYEvLsJNZCnN9ifCw==
X-Received: by 2002:a17:902:e5c5:b0:185:4625:2a1f with SMTP id u5-20020a170902e5c500b0018546252a1fmr19117381plf.24.1669392831056;
        Fri, 25 Nov 2022 08:13:51 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:fd14:ad8b:6b7b:c61])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0017c19d7c89bsm3577384plg.269.2022.11.25.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:13:50 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:13:47 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bill.mills@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem
 device node
Message-ID: <20221125161347.GA764010@p14s>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
 <20221114233940.2096237-3-tanmay.shah@amd.com>
 <90fbb273-510b-279f-1582-8336136c5a0c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90fbb273-510b-279f-1582-8336136c5a0c@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:22:47AM +0100, Michal Simek wrote:
> 
> 
> On 11/15/22 00:39, Tanmay Shah wrote:
> > RPU subsystem can be configured in cluster-mode or split mode.
> > Also each r5 core has separate power domains.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v11:
> >    - None
> > 
> > Changes in v10:
> >    - Rename node name to remoteproc
> > 
> > Changes in v9:
> >    - remove unused labels
> > 
> > Changes in v8:
> >    - None
> > 
> > Changes in v7:
> >    - None
> > 
> > Changes in v6:
> >    - None
> > 
> > Changes in v5:
> >    - Remove optional reg property from r5fss node
> >    - Move r5fss node out of axi node
> > 
> > Changes in v4:
> >    - Add reserved memory region node and use it in RPU subsystem node
> > 
> > Changes in v3:
> >    - Fix checkpatch.pl style warning
> > 
> >   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 33 ++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > index a549265e55f6..c0f60833c0ae 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > @@ -100,6 +100,22 @@ opp03 {
> >   		};
> >   	};
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		rproc_0_fw_image: memory@3ed00000 {
> > +			no-map;
> > +			reg = <0x0 0x3ed00000 0x0 0x40000>;
> > +		};
> > +
> > +		rproc_1_fw_image: memory@3ef00000 {
> > +			no-map;
> > +			reg = <0x0 0x3ef00000 0x0 0x40000>;
> > +		};
> > +	};
> > +
> >   	zynqmp_ipi: zynqmp_ipi {
> >   		compatible = "xlnx,zynqmp-ipi-mailbox";
> >   		interrupt-parent = <&gic>;
> > @@ -203,6 +219,23 @@ fpga_full: fpga-full {
> >   		ranges;
> >   	};
> > +	remoteproc {
> > +		compatible = "xlnx,zynqmp-r5fss";
> > +		xlnx,cluster-mode = <1>;
> > +
> > +		r5f-0 {
> > +			compatible = "xlnx,zynqmp-r5f";
> > +			power-domains = <&zynqmp_firmware PD_RPU_0>;
> > +			memory-region = <&rproc_0_fw_image>;
> > +		};
> > +
> > +		r5f-1 {
> > +			compatible = "xlnx,zynqmp-r5f";
> > +			power-domains = <&zynqmp_firmware PD_RPU_1>;
> > +			memory-region = <&rproc_1_fw_image>;
> > +		};
> > +	};
> > +
> >   	amba: axi {
> >   		compatible = "simple-bus";
> >   		#address-cells = <2>;
> 
> Matthieu: If you want to take this via your tree here is mine.
> 
> Acked-by: Michal Simek <michal.simek@amd.com>

I have applied the whole set.

Thanks,
Mathieu

> 
> In another case I will queue it for next release when dt binding is applied.
> 
> Thanks,
> Michal
