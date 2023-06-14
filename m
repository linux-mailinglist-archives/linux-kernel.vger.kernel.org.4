Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF9572FC44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjFNLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjFNLTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:19:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B142959;
        Wed, 14 Jun 2023 04:18:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B290C6606EFD;
        Wed, 14 Jun 2023 12:18:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686741531;
        bh=mk2/pYLZgRMBhvKuJCtJgo6lcTKdBXdHOm/hXqC0BjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iUAS0uxPuy2foVhRuBpIM5v7NFPSfDtuBUlldSsGIwybe918agelnbtPIrgEiAH22
         xvU8SGWTLtOx3WpQ1VMgdK8PntWdp3RvRD6XRrNLqG3Uoe4bNgwp4jDJ0I3dBK06qV
         85KOE3NEAeQJsKNQDgPshrc8PsBmrXeKy3fTlzjJsWRdkPyAVtw9kTaO+Xu9vSfoXQ
         9BnGMGdn2T3Y9M5HbGMRVHqmBchCOoxzp0yX8FzuZdUAyzRepzeuxG6g7ZLKP3JA4Y
         C1ZHCGRBCEsDC1mIi6uZKoUFas9QRCoEPD8fMIYBLmMZ9sfTx1jzoLmmz7WDdTeSW+
         qagE+vpSxDP9Q==
Message-ID: <d9e3009b-1fd0-e81b-715e-d93c9343b55c@collabora.com>
Date:   Wed, 14 Jun 2023 13:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] wifi: mt76: mt7921e: Perform FLR to recovery the device
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, nbd@nbd.name,
        lorenzo@kernel.org, ryder.lee@mediatek.com
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230614063252.1650824-1-kai.heng.feng@canonical.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614063252.1650824-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/06/23 08:32, Kai-Heng Feng ha scritto:
> When "Pre-boot WiFi" is enabled in BIOS, the mt7921e device may not
> work:
> mt7921e 0000:02:00.0: ASIC revision: 79220010
> mt7921e 0000:02:00.0: Message 00000010 (seq 1) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 2) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 3) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 4) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 5) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 6) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 7) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 8) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 9) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: Message 00000010 (seq 10) timeout
> mt7921e 0000:02:00.0: Failed to get patch semaphore
> mt7921e 0000:02:00.0: hardware init failed
> 
> After some trials and errors, it shows that PCI function level reset can
> recover the device back to a functional state.
> 
> So perform FLR at probe routine to workaround the issue.

Is there any way to check if the device was enabled before booting Linux?

I'm thinking of something like

if (device_is_already_enabled)
	ret = pci_reset_function_locked(....)

Regards,
Angelo

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index ddb1fa4ee01d..9671fbe35a8e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -262,6 +262,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>   	int ret;
>   	u16 cmd;
>   
> +	ret = pci_reset_function_locked(pdev);
> +	if (ret)
> +		pci_info(pdev, "Unable to perform FLR\n");
> +
>   	ret = pcim_enable_device(pdev);
>   	if (ret)
>   		return ret;


