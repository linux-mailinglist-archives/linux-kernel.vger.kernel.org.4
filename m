Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7474159A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjF1Prs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:47:48 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:57262 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjF1Prl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:47:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6DC36134E;
        Wed, 28 Jun 2023 15:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB56C433C8;
        Wed, 28 Jun 2023 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687967260;
        bh=q4sj1d/zHjtV55wTmjMuAvgaAJrxbBFYlstGJuAK4tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfUNIFe7ech+WxtpaZnwbblUi4t+4Pe2nw9tCVBxD/U1v7/M/8uEJoEqSrkLCFRqC
         fdqc02/XoevaQX4+77uSIJvjvOxIx7sQDfskQpiFjlIjb0Aw/OxlXfNCZtNuIyHEJ0
         iQHZU7++nxQ4ZF05z3YNWCnfLdbgxLOEettVU5tA=
Date:   Wed, 28 Jun 2023 17:47:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 03/21] soc: qcom: Add qcom_minidump_smem module
Message-ID: <2023062823-rimmed-payback-db87@gregkh>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-4-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687955688-20809-4-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:30PM +0530, Mukesh Ojha wrote:
> Add qcom_minidump_smem module in a preparation to remove smem
> based minidump specific code from driver/remoteproc/qcom_common.c
> and provide needed exported API, this abstract minidump specific
> data layout from qualcomm's remoteproc driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig              |   8 ++
>  drivers/soc/qcom/qcom_minidump_smem.c | 147 ++++++++++++++++++++++++++++++++++
>  include/soc/qcom/qcom_minidump.h      |  24 ++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_minidump_smem.c
>  create mode 100644 include/soc/qcom/qcom_minidump.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..982310b5a1cb 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -279,4 +279,12 @@ config QCOM_INLINE_CRYPTO_ENGINE
>  	tristate
>  	select QCOM_SCM
>  
> +config QCOM_MINIDUMP_SMEM
> +	tristate "QCOM Minidump SMEM (as backend) Support"
> +	depends on ARCH_QCOM
> +	depends on QCOM_SMEM
> +	help
> +	  Enablement of core minidump feature is controlled from boot firmware
> +	  side, and this config allow linux to query minidump segments associated
> +	  with the remote processor and check its validity.

I can not understand this help text, sorry.  Also, what is the module
name?

And why is this only with ARCH_QCOM?  Why are we doing ARCH_PLATFORM
symbols still?  why is that a thing for a generic cpu type?

And don't you want build coverage?  Why not allow that?

thanks,

greg k-h
