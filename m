Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8117617B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKCLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiKCLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:02:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E640B7EB;
        Thu,  3 Nov 2022 04:02:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D90F1FB;
        Thu,  3 Nov 2022 04:02:50 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46DE73F5A1;
        Thu,  3 Nov 2022 04:02:42 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:02:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, jassisinghbrar@gmail.com,
        manivannan.sadhasivam@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        Gaurav Kohli <gkohli@codeaurora.org>
Subject: Re: [PATCH 2/2] mailbox: Add support for QTI CPUCP mailbox controller
Message-ID: <20221103110239.lkb7a5a4fpk2ggrs@bogus>
References: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com>
 <1663135386-26270-3-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663135386-26270-3-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 11:33:06AM +0530, Sibi Sankar wrote:
> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
> this driver enables communication between AP and CPUCP by acting as
> a doorbell between them.
> 
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> [sibis: moved to mailbox and misc. cleanups]
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

[...]

> +
> +	ret = devm_request_irq(&pdev->dev, cpucp->irq, qcom_cpucp_mbox_irq_fn,
> +			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, "qcom_cpucp_mbox", cpucp);

1. Do you plan to use this mailbox during noirq phase of system suspend ?
   If not why do you have IRQF_NO_SUSPEND ? If yes, how will it be used ?
2. Why are you setting IRQF_TRIGGER_HIGH here ? Won't platform_get_irq()
   take care of that ? Otherwise how would you use this driver on the
   platform that need say IRQF_TRIGGER_LOW ?

-- 
Regards,
Sudeep
