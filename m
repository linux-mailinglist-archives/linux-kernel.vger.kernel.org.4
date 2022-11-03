Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A6617AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiKCKYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKCKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:24:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCC14BCB3;
        Thu,  3 Nov 2022 03:24:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E771FB;
        Thu,  3 Nov 2022 03:24:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66E773F5A1;
        Thu,  3 Nov 2022 03:24:46 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:24:44 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, cristian.marussi@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        quic_avajid@quicinc.com, Souvik.Chakravarty@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 2/2] firmware: arm_scmi: Add SCMI QTI Memlat vendor protocol
Message-ID: <20221103102444.c5ngcxupohwdzntf@bogus>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-3-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667451512-9655-3-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:28:32AM +0530, Sibi Sankar wrote:
> Add support for the SCMI QTI memlat (memory latency) vendor protocol.
> The QTI memlat vendor protocol takes in several tuneables including the
> IPM ratio (Instructions Per Miss), bus bandwidth requirements and PMU
> maps to enable frequency scaling of various buses (L3/LLCC/DDR) performed
> by the memory latency governor running on the CPUSS Control Processor.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig              |  10 +
>  drivers/firmware/arm_scmi/Makefile             |   1 +
>  drivers/firmware/arm_scmi/qcom_memlat_vendor.c | 269 +++++++++++++++++++++++++
>  include/linux/scmi_protocol.h                  |  36 ++++
>  4 files changed, 316 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/qcom_memlat_vendor.c
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index a14f65444b35..814a3fc37dc1 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -136,6 +136,16 @@ config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
>  
>  endif #ARM_SCMI_PROTOCOL
>  
> +config QTI_SCMI_MEMLAT_PROTOCOL
> +	tristate "Qualcomm Technologies, Inc. SCMI MEMLAT vendor Protocol"
> +	depends on ARM_SCMI_PROTOCOL && QCOM_CPUCP_MBOX

If you have set the transport correctly, there should be no need for any
such dependency.

> +	help
> +	  The SCMI QTI memlat vendor protocol adds support for the frequency
> +	  scaling of buses (L3/LLCC/DDR) by the QTI HW memlat governor running
> +	  on the CPUSS Control Processor (CPUCP).
> +
> +	  Say Y here if you want to build this driver.
> +

I don't think it is scalable to have a config option for each vendor+protocol
Kconfig. IMO just one config for all qcom vendor protocol please.

--
Regards,
Sudeep
