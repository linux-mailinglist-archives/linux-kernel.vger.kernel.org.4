Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F56404C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiLBKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiLBKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:35:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6AC4CDE;
        Fri,  2 Dec 2022 02:35:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07166222D;
        Fri,  2 Dec 2022 10:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A634BC433D6;
        Fri,  2 Dec 2022 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669977328;
        bh=gy4BSJ76mh0HAcCurbowxB8Nozc4FwfIp6+iriE3IcY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TFDHsTSV63ZHWA+a23ObzI3TB0iF2nAR6DIY2CdrxIJTyxBhG+TFfoj7+khPxCPvY
         UTRIh1CnqeQ5OwxFjKirUvSvBj16lRSy8mnH/wBZm5gtY6NCFzNev6X1Et37H9ygoB
         SIyfjs4qfBeyYEhUF2mhzkHu7TyJCWM9XlSlZOMDFDaf88Y+Uq1Mm7m5XoT5X3bHWA
         77f94e64K13ROczPc16BVrhrM9zcv+zYNsWQZZTPDNVSyl8Fqcac9bXQyDRIRQ6qHj
         5aqo66RA7JeW+ydCYQEH4o6BjhriwIAVk3raDG29rZN8SpHBzP26b+IwMIM9nkJq14
         4mT7XHDsPOTzw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mpubbise@quicinc.com,
        rameshn@qti.qualcomm.com
Subject: Re: [PATCH v4] wifi: ath10k: Store WLAN firmware version in SMEM image table
References: <20221117180534.2267-1-quic_youghand@quicinc.com>
        <Y4YsyaIW+CPdHWv3@dev-arch.thelio-3990X> <87sfi13tya.fsf@kernel.org>
Date:   Fri, 02 Dec 2022 12:35:24 +0200
In-Reply-To: <87sfi13tya.fsf@kernel.org> (Kalle Valo's message of "Wed, 30 Nov
        2022 07:14:05 +0200")
Message-ID: <877cza3xg3.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Nathan Chancellor <nathan@kernel.org> writes:
>
>> On Thu, Nov 17, 2022 at 11:35:34PM +0530, Youghandhar Chintala wrote:
>>
>>> In a SoC based solution, it would be useful to know the versions of the
>>> various binary firmware blobs the system is running on. On a QCOM based
>>> SoC, this info can be obtained from socinfo debugfs infrastructure. For
>>> this to work, respective subsystem drivers have to export the firmware
>>> version information to an SMEM based version information table.
>>> 
>>> Having firmware version information at one place will help quickly
>>> figure out the firmware versions of various subsystems on the device
>>> instead of going through builds/logs in an event of a system crash.
>>> 
>>> Fill WLAN firmware version information in SMEM version table to be
>>> printed as part of socinfo debugfs infrastructure on a Qualcomm based
>>> SoC.
>>> 
>>> This change is applicable only for SNOC/QMI based targets.
>>> 
>>> Example:
>>> cat /sys/kernel/debug/qcom_socinfo/cnss/name
>>> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>> 
>>> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>> 
>>> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
>>> ---
>>> Changes from v3:
>>>  - Changed patch title
>>>  - Changed naming conventions
>>>  - Removed MAX_BUILD_ID_LEN usuage
>>>  - Added condition to call API
>>>  - Changed depends on QCOM_SMEM to select QCOM_SMEM
>>
>> You cannot blindly select user configurable symbols that have
>> dependencies, otherwise you end up with Kconfig warnings. I see the
>> following warning in -next when CONFIG_HWSPINLOCK is disabled:
>>
>>   WARNING: unmet direct dependencies detected for QCOM_SMEM
>>     Depends on [n]: (ARCH_QCOM [=y] || COMPILE_TEST [=n]) && HWSPINLOCK [=n]
>>     Selected by [m]:
>>     - ATH10K_SNOC [=m] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && ATH10K [=m] && (ARCH_QCOM [=y] || COMPILE_TEST [=n])
>>
>> That should likely be changed back to 'depends on'. The reason the other
>> QCOM symbols are selected is because they are not user-selectable, so
>> they have to be selected by the configurations that need them.
>
> Thanks, I didn't realise this. I'll send a patch changing it to 'depends
> on'.

Here's the patch:

https://patchwork.kernel.org/project/linux-wireless/patch/20221202103027.25974-1-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
