Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342AC63885D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiKYLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKYLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:12:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EF6250;
        Fri, 25 Nov 2022 03:12:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBD06239D;
        Fri, 25 Nov 2022 11:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79789C433C1;
        Fri, 25 Nov 2022 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669374750;
        bh=9m4EnFNBor1yYAqAkFO0UeDEFHKaL2TeZP/4Uo5mhNo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Bqj0rO5YaVmUQNQSLSZW1fAQS+Be7JfSGoa1HBPYViNzyB6kBt0w78mlgnBO05/S+
         cdWrpDrLe1gzhgnzdKULCfSN1bRX9Xt07Ml2iAf8y3sT3SbdL59mV9Zt0MzxK3BwmK
         oeIYX1jPLpg80Z4Kcm08Xs79OUrg29e4wbZtQEbOeB7+rsZu4JNI0D8j0LkQ8x5P3O
         KOA0tQ1xLEGNvjynuALT6dVv4vx/QlnnG56/bWkmEYOi2L5IjzMQOkEoCvZJViPvBV
         AkItiGpv+1Qha2KYEkr59ysMgt9n7kaVne93AmPFiCHWVL8Fy8/tn/dxSMd7NcW62u
         kAXdfajM7SjMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] wifi: ath10k: Store WLAN firmware version in SMEM
 image
 table
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221117180534.2267-1-quic_youghand@quicinc.com>
References: <20221117180534.2267-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        <rameshn@qti.qualcomm.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166937474408.28196.4056251112151371854.kvalo@kernel.org>
Date:   Fri, 25 Nov 2022 11:12:28 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

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
> This change is applicable only for SNOC/QMI based targets.
> 
> Example:
> cat /sys/kernel/debug/qcom_socinfo/cnss/name
> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4d79f6f34bbb wifi: ath10k: Store WLAN firmware version in SMEM image table

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221117180534.2267-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

