Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1758694D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBMQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBMQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85619694
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676306713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/wwCIDmg4gbiaNdQ7ncCIBMm2IT8uUjnYU/fITcod04=;
        b=MCrPYv6jKLhHWr4pZtxc1/7KR44DFoYpr2VLEYAmTwOgv7btONvVUsTPPfHRsWwkmONPYh
        aqrCnAsns5nNn24L/1P1L/O2TgGIpZ3HzTpCIwzEKekpqCFkFyeUQpupKg3DDNJkobKBDJ
        XqI4EnCruWUKEVML7Oa6U+yEP2Iptw0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-JcSLNgvgN8CwFVGnGBYbEw-1; Mon, 13 Feb 2023 11:45:12 -0500
X-MC-Unique: JcSLNgvgN8CwFVGnGBYbEw-1
Received: by mail-vk1-f198.google.com with SMTP id x186-20020a1f63c3000000b00401b344772cso185672vkb.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wwCIDmg4gbiaNdQ7ncCIBMm2IT8uUjnYU/fITcod04=;
        b=XMTw2VD2mMJIXdPc1V3guyYFFbPVW1qREJmMa7M2tcjbe0Q0LEHSkoXE+iZlIkcKTN
         onV3r01LvRCYbq5OJQrsOn0wBN/aKr7WGyStGire+ai+usvcrDwXQBVyvBw1WPsUon7J
         Lw8wDujbdmK88AWRyxlKmig5BNrPy0Xxu31yLvaSP10QVvk7kNJK/eKicG7j+VURn0Gj
         XQGyWJOjoszuuNJei6EXoOVb0NMRkFRakORqTrvo05rIZVWQDV140qvojQPx0OfRUCCN
         9IF8jYu0qusC00Anz2NamMcv1sRg6vAr6Z3mzehTqg61A0BUgbXVSHNlnWYLyrQBK/0A
         82Hw==
X-Gm-Message-State: AO0yUKUdlnIDWtWA8l4BiLmWYnGJi0mrdmW6h5OtEGis2nEokv4Pr+Vk
        XC1yEB23A1eEcMPiH4GEtXJygD92/YDbseA/ygFzYIKPP/Mi3n63edd0Y9TvZGUIdPRQ0t/WlCp
        gXMLfUTrRtuwnrb/KLIegB1Q+3oqpMq3rxK9O/87HRumYvtJyCkLl5A==
X-Received: by 2002:a1f:1fce:0:b0:3e8:66ce:a639 with SMTP id f197-20020a1f1fce000000b003e866cea639mr4430595vkf.2.1676306711651;
        Mon, 13 Feb 2023 08:45:11 -0800 (PST)
X-Google-Smtp-Source: AK7set+ECI0j8UHCgnPq8BUm9yVEWERse9lHvI7TCEUo+uQnL5QG/1s7KQZjD4S3ShbwZNOCFJIQJabZD8GLGnekubg=
X-Received: by 2002:a1f:1fce:0:b0:3e8:66ce:a639 with SMTP id
 f197-20020a1f1fce000000b003e866cea639mr4430578vkf.2.1676306711395; Mon, 13
 Feb 2023 08:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20230212063813.27622-1-marcan@marcan.st> <20230212063813.27622-5-marcan@marcan.st>
In-Reply-To: <20230212063813.27622-5-marcan@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 16:44:55 +0000
Message-ID: <CAOgh=FwvbrNT4nSCtctCLLwRa7r2KrRe6BHQ-Q-tb9OjVwCb-A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] brcmfmac: pcie: Perform correct BCM4364 firmware selection
To:     Hector Martin <marcan@marcan.st>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Prutskov <alep@cypress.com>,
        Ian Lin <ian.lin@infineon.com>,
        Joseph chuang <jiac@cypress.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Aditya Garg <gargaditya08@live.com>,
        Jonas Gorski <jonas.gorski@gmail.com>, asahi@lists.linux.dev,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2023 at 06:46, Hector Martin <marcan@marcan.st> wrote:
>
> This chip exists in two revisions (B2=r3 and B3=r4) on different
> platforms, and was added without regard to doing proper firmware
> selection or differentiating between them. Fix this to have proper
> per-revision firmwares and support Apple NVRAM selection.
>
> Revision B2 is present on at least these Apple T2 Macs:
>
> kauai:    MacBook Pro 15" (Touch/2018-2019)
> maui:     MacBook Pro 13" (Touch/2018-2019)
> lanai:    Mac mini (Late 2018)
> ekans:    iMac Pro 27" (5K, Late 2017)
>
> And these non-T2 Macs:
>
> nihau:    iMac 27" (5K, 2019)
>
> Revision B3 is present on at least these Apple T2 Macs:
>
> bali:     MacBook Pro 16" (2019)
> trinidad: MacBook Pro 13" (2020, 4 TB3)
> borneo:   MacBook Pro 16" (2019, 5600M)
> kahana:   Mac Pro (2019)
> kahana:   Mac Pro (2019, Rack)
> hanauma:  iMac 27" (5K, 2020)
> kure:     iMac 27" (5K, 2020, 5700/XT)
>
> Also fix the firmware interface for 4364, from BCA to WCC.
>
> Fixes: 24f0bd136264 ("brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index d54394885af7..f320b6ce8bff 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -57,7 +57,8 @@ BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-pcie");
>  BRCMF_FW_CLM_DEF(43570, "brcmfmac43570-pcie");
>  BRCMF_FW_DEF(4358, "brcmfmac4358-pcie");
>  BRCMF_FW_DEF(4359, "brcmfmac4359-pcie");
> -BRCMF_FW_DEF(4364, "brcmfmac4364-pcie");
> +BRCMF_FW_CLM_DEF(4364B2, "brcmfmac4364b2-pcie");
> +BRCMF_FW_CLM_DEF(4364B3, "brcmfmac4364b3-pcie");
>  BRCMF_FW_DEF(4365B, "brcmfmac4365b-pcie");
>  BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
>  BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
> @@ -88,7 +89,8 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>         BRCMF_FW_ENTRY(BRCM_CC_43570_CHIP_ID, 0xFFFFFFFF, 43570),
>         BRCMF_FW_ENTRY(BRCM_CC_4358_CHIP_ID, 0xFFFFFFFF, 4358),
>         BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
> -       BRCMF_FW_ENTRY(BRCM_CC_4364_CHIP_ID, 0xFFFFFFFF, 4364),
> +       BRCMF_FW_ENTRY(BRCM_CC_4364_CHIP_ID, 0x0000000F, 4364B2), /* 3 */
> +       BRCMF_FW_ENTRY(BRCM_CC_4364_CHIP_ID, 0xFFFFFFF0, 4364B3), /* 4 */
>         BRCMF_FW_ENTRY(BRCM_CC_4365_CHIP_ID, 0x0000000F, 4365B),
>         BRCMF_FW_ENTRY(BRCM_CC_4365_CHIP_ID, 0xFFFFFFF0, 4365C),
>         BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0x0000000F, 4366B),
> @@ -2003,6 +2005,11 @@ static int brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
>                 base = 0x8c0;
>                 words = 0xb2;
>                 break;
> +       case BRCM_CC_4364_CHIP_ID:
> +               coreid = BCMA_CORE_CHIPCOMMON;
> +               base = 0x8c0;
> +               words = 0x1a0;
> +               break;
>         case BRCM_CC_4377_CHIP_ID:
>         case BRCM_CC_4378_CHIP_ID:
>                 coreid = BCMA_CORE_GCI;
> @@ -2611,7 +2618,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_2G_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_5G_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_RAW_DEVICE_ID, WCC),
> -       BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID, BCA),
> +       BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_DEVICE_ID, BCA),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_2G_DEVICE_ID, BCA),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_5G_DEVICE_ID, BCA),
> --
> 2.35.1
>
>

