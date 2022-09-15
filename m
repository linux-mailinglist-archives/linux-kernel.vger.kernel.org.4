Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC15BA055
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIORV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIORVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6600084EC8;
        Thu, 15 Sep 2022 10:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE33A6183D;
        Thu, 15 Sep 2022 17:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EEEC433D7;
        Thu, 15 Sep 2022 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663262481;
        bh=8Z9OF3dpMMKqRQV+noqKTBcpxIWR9RZt2S0c7B86zec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2j2DA9Rg0AJZ7EyJN24tGi8kvSQEIvnfIs/Sh6cbG4+Iwsv+qhKVSCt98ZEKxXlT
         mgxQoHfU8WyEt9p0y6f+KxFnssKbqo3VmJ9/0SVsRKxP9Xw2k/8ZUBbNdqM3icrD+f
         SHKVjQTtkrodN1ISrvpGVAfQzCE0BM+16y1CVLMWJ4eqcERUWkKNfUek5TGJfiEoyR
         wIL6mO2sOreUNUNoqwKMO6TXYpMVmX6pTsB+IPCIUpp0ZXwkQI1MLMJ/lcWriDJ8ku
         ezMgxTnhGlpIgrt3DU5tqH5Wpg1BW83fkDKpD5n3BSN/S5qEV738uW9abE68bc6bD0
         xwqRw2/dOJgLg==
Date:   Thu, 15 Sep 2022 12:21:18 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Hiren Gohel <quic_vhiren@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] usb: phy: qusb: Use scm call to update value in register
Message-ID: <20220915172118.q2bsjlfcau33z6pa@builder.lan>
References: <1663249627-21151-1-git-send-email-quic_vhiren@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663249627-21151-1-git-send-email-quic_vhiren@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 07:17:07PM +0530, Hiren Gohel wrote:
> Registers used by vendors to control any functionality could be
> implemented by making the register secured. In such cases the
> register cannot be updated with a new value since the normal
> write ops will fail.
> 
> Hence, use the scm_call to do a secure write to the register.
> 

This looks reasonable, but we need a caller of this API in order to
merge this patch.

> Signed-off-by: Hiren Gohel <quic_vhiren@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c | 19 +++++++++++++++++++
>  drivers/firmware/qcom_scm.h |  1 +
>  include/linux/qcom_scm.h    |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54..7131df8 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -400,6 +400,25 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>  }
>  EXPORT_SYMBOL(qcom_scm_set_remote_state);
>  
> +void qcom_scm_phy_update_scm_level_shifter(u32 val)

That second "scm" doesn't seem necessary.

> +{
> +	int ret;
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_BOOT,
> +		.cmd = QCOM_SCM_QUSB2PHY_LVL_SHIFTER_CMD_ID,
> +		.owner = ARM_SMCCC_OWNER_SIP
> +	};
> +
> +	desc.args[0] = val;
> +	desc.args[1] = 0;
> +	desc.arginfo = QCOM_SCM_ARGS(2);
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, NULL);

Would it not make sense to return this error to the caller?

Regards,
Bjorn

> +	if (ret)
> +		pr_err("Failed to update scm level shifter=0x%x\n", ret);
> +}
> +EXPORT_SYMBOL(qcom_scm_phy_update_scm_level_shifter);
> +
>  static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  {
>  	struct qcom_scm_desc desc = {
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> index 0d51eef..0a8c25b 100644
> --- a/drivers/firmware/qcom_scm.h
> +++ b/drivers/firmware/qcom_scm.h
> @@ -81,6 +81,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>  #define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
>  #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
>  #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
> +#define QCOM_SCM_QUSB2PHY_LVL_SHIFTER_CMD_ID	0x1B
>  #define QCOM_SCM_BOOT_MAX_CPUS		4
>  #define QCOM_SCM_BOOT_MC_FLAG_AARCH64	BIT(0)
>  #define QCOM_SCM_BOOT_MC_FLAG_COLDBOOT	BIT(1)
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f8335644..3e5cbe9 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  extern int qcom_scm_lmh_profile_change(u32 profile_id);
>  extern bool qcom_scm_lmh_dcvsh_available(void);
>  
> +extern void qcom_scm_phy_update_scm_level_shifter(u32 val);
> +
>  #endif
> -- 
> 2.7.4
> 
