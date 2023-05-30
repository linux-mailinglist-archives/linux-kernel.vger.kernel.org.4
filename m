Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D61715579
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjE3GWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3GWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:22:50 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468EBF;
        Mon, 29 May 2023 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XSDebSB19oA+MAG3fUqSU9st5hGlMUaKZomFXQkj8bQ=; b=YMImdWrUu2aDReyNZtLXpB54Kk
        v1V1iaz9LXAL6jIDg7iIP2MLG6I9EZxMEqmxSHtwXqtEgm79oPgihC51IsJTPgi0wEH7jjFbZXMmK
        KymQMz9B3RcEYtx41OSunnc5/SVEFBLvAtf//HXRk37oVPNR+2w054Neu4fha0KDNBT4=;
Received: from p200300da7708b3c00512399822b48468.dip0.t-ipconnect.de ([2003:da:7708:b3c0:512:3998:22b4:8468] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1q3skY-00GyzG-PZ; Tue, 30 May 2023 08:22:30 +0200
Message-ID: <1502188c-c527-3038-2163-5ca4f51ed735@nbd.name>
Date:   Tue, 30 May 2023 08:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
To:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        kvalo@kernel.org, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Mario.Limonciello@amd.com, Lijo.Lazar@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
References: <20230530024227.2139632-1-evan.quan@amd.com>
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 0/9] Support Wifi RFI interference mitigation feature
In-Reply-To: <20230530024227.2139632-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.23 04:42, Evan Quan wrote:
> Due to electrical and mechanical constraints in certain platform designs there may
> be likely interference of relatively high-powered harmonics of the (G-)DDR memory
> clocks with local radio module frequency bands used by Wifi 6/6e/7. To mitigate
> possible RFI interference producers can advertise the frequencies in use and
> consumers can use this information to avoid using these frequencies for
> sensitive features.
> 
> The whole patch set is based on 6.4-rc3. With some brief introductions as below:
> Patch1:     Core ACPI interfaces needed to support WBRF feature.
> Patch2 - 4: Enable WBRF support for some Mediatek and Qualcomm wifi drivers.
> Patch5 - 9: Enable WBRF support for AMD graphics driver.
> 
> Anson Tsao (1):
>    wifi: ath11k: Add support to the Qualcomm ath11k for ACPI WBRF
> 
> Evan Quan (6):
>    wifi: ath12k: Add support to the Qualcomm ath12k for ACPI WBRF
>    drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
>    drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
>    drm/amd/pm: add flood detection for wbrf events
>    drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
>    drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
> 
> Mario Limonciello (2):
>    drivers/acpi: Add support for Wifi band RF mitigations
>    mt76: Add support to the Mediatek MT7921 for ACPI WBRF
Wouldn't it make more sense to put this in mac80211 or cfg80211 instead 
of duplicating the logic in different drivers?

- Felix

