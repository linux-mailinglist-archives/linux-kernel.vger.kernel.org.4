Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B6627F79
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiKNM7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiKNM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:59:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730C52610C;
        Mon, 14 Nov 2022 04:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DBB6117F;
        Mon, 14 Nov 2022 12:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BDEC433D7;
        Mon, 14 Nov 2022 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430777;
        bh=Bqo8VHEKOh4b2/t4IKtYamnmb4QITdYQ/EJfORddcJk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ciRd/Wku/AsQYh4opphPAa7JXWu1GgVorWniVQ5/xseSsNCWOywBbKqe6RMF+ZPFt
         G4XLEvA51Th350+mE1g8JFpdBaJXwUGEt01zv2OcHVQQgsMNeyw8bIyyEyxHE9MgK8
         x7mNGyK+z7+4rb+YiMtLx8krXVUDApP2wfoflnXYB/htCwTaNkLzxeBd7g4PtJcgMH
         Ojkt0QuIKGoatmlSquzA742Q6lIzXRaB2+gj18z+4/LAOdUm10WWBHSXboOWk2arW0
         Bvn6RNUvNce4bquYp1QfM/8t7WzgBzoLL3FElrcoqN6pGlw5u7joVgbfghgHP0jszW
         6SoZY3rPqi1Ig==
From:   Kalle Valo <kvalo@kernel.org>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] wifi: ath10k: Add WLAN firmware image version info into smem
References: <20221111114235.10287-1-quic_youghand@quicinc.com>
Date:   Mon, 14 Nov 2022 14:59:31 +0200
In-Reply-To: <20221111114235.10287-1-quic_youghand@quicinc.com> (Youghandhar
        Chintala's message of "Fri, 11 Nov 2022 17:12:35 +0530")
Message-ID: <87edu5bsjw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> writes:

> In a SoC based solution, it would be useful to know the versions of the
> various binary firmware blobs the system is running on. On a QCOM based
> SoC, this info can be obtained from socinfo debugfs infrastructure. For
> this to work, respective subsystem drivers have to export the firmware
> version information to an SMEM based version information table.
>
> Having firmware version information at one place will help quickly
> figure out the firmware versions of various subsystems on the device
> instead of going through builds/logs in an event of a system crash.
>
> Fill WLAN firmware version information in SMEM version table to be
> printed as part of socinfo debugfs infrastructure on a Qualcomm based
> SoC.
>
> This change is applicable only for WCN399X targets.
>
> Example:
> cat /sys/kernel/debug/qcom_socinfo/cnss/name
> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>
> Reported-by: kernel test robot <lkp@intel.com>
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> ---
> Changes from v2:
>  - Removed blank line between trailers
>  - Changed memcpy to strscpy
>  - Removed version_string_size
>  - Added new condition fw_build_id against max length
>  - Added depends on QCOM_SMEM for ath10k_snoc
> ---
>  drivers/net/wireless/ath/ath10k/Kconfig |  1 +
>  drivers/net/wireless/ath/ath10k/qmi.c   | 34 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index ca007b800f75..e6ea884cafc1 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -44,6 +44,7 @@ config ATH10K_SNOC
>  	tristate "Qualcomm ath10k SNOC support"
>  	depends on ATH10K
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on QCOM_SMEM
>  	select QCOM_SCM
>  	select QCOM_QMI_HELPERS

Is there a reason why you used "depends on"? Other QCOM dependencies
used "select", so I'm wondering if QCOM_SMEM should also use select?

Please also use ath10k list for ath10k patches, not ath11k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
