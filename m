Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F50600F50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJQMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJQMjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:39:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5511B793;
        Mon, 17 Oct 2022 05:39:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A1D2341EA7;
        Mon, 17 Oct 2022 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666010345; bh=BKhVOrgoZ2ys1+3AyuhmxIKrpqUiYWfceV4pZCQN++M=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=JlFkb41oCJANAqSSHTz1e1vrPoItfndKMP/qkmVLuCZqKZiKER4AIw0fQC1ap+GW6
         0zqVPKFHkIYejoUWpMpSQDTmNgpb7QiajLevccF0GtUSTcrcVg4a2e69PPG9dJ/3B9
         dKAR1MdBjnU+s30Q3DZQFFwt+/JCLPxuD/u3YY6apr9yArBmUhQKfxlQbHgVkipt97
         337BUFaCUybrpewaNIsBRUOQlqGteXD9AHreQloS9TVrClaYMSzX21kETSQj6x8pQo
         iduuX7jAqwNcvldsEtfpGDZbklsVk7xiFajQdZ7yrrJjrz0Og5e2xQCjBF51+MTaPw
         31PDU+GMdh7HA==
Message-ID: <3eb9cc12-db75-8042-4106-fa6521c684a7@marcan.st>
Date:   Mon, 17 Oct 2022 21:38:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Ian Lin <ian.lin@infineon.com>, alep@cypress.com
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20220922104140.11889-1-ian.lin@infineon.com>
 <20220922104140.11889-3-ian.lin@infineon.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/4] brcmfmac: Support 89459 pcie
In-Reply-To: <20220922104140.11889-3-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/09/2022 19.41, Ian Lin wrote:
> From: Alexander Prutskov <alep@cypress.com>
> 
> Adds support of 89459 chip pcie device and save restore support.
> 
> Signed-off-by: Alexander Prutskov <alep@cypress.com>
> Signed-off-by: Joseph chuang <jiac@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
[...]

Can you explain how the CYW89459 is related to the BCM4355 family? I
have a patch [1] to add support for the BCM4355 variant present in some
Apple laptops which I was hoping to submit again for 6.2, and this patch
conflicts with it.

[1] https://lore.kernel.org/lkml/20220104072658.69756-19-marcan@marcan.st/

>  BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
>  BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
>  BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
> +BRCMF_FW_DEF(4355, "brcmfmac89459-pcie");
>  
>  /* firmware config files */
>  MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> @@ -90,6 +91,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>  	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>  	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
>  	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378B1), /* revision ID 3 */
> +	BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
>  };

Is the CYW89459 just a rebrand of the BCM4355, or just a subset? If it
is a rebrand, it's okay if we call our Apple firmware
brcmfmac89459-pcie* (note that we use per-board firmware names, so it
wouldn't conflict with a generic one). However, if CYW89459 only refers
to specific variants, I think the firmware should be named after the
overall bcm4355 family.

I'm guessing you intend to ship firmware for this. Would that firmware
work for all 4355 variants, or only the CYW one? If only the CYW one, is
it possible to differentiate between them based on PCI revision ID? Note
that our 4355 has revision ID 12, and Apple specifically calls it 4355C1
(different chip revisions have different firmware builds, which is why I
named our firmware brcmfmac4355c1-pcie). If the CYW variant uses other
revision IDs that do not overlap, maybe we should have different
firmware entries for them with different masks.

>  
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 1003f123ec25..f4939cf62767 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -56,6 +56,7 @@
>  #define CY_CC_43012_CHIP_ID		43012
>  #define CY_CC_43439_CHIP_ID		43439
>  #define CY_CC_43752_CHIP_ID		43752
> +#define CY_CC_89459_CHIP_ID		0x4355

This seems suspicious. If the chip ID is 4355 and applies to non-Cypress
products, unlike the other constants in this list, this constant should
probably be named after BCM4355, not the Cypress part number.

>  
>  /* USB Device IDs */
>  #define BRCM_USB_43143_DEVICE_ID	0xbd1e
> @@ -90,7 +91,8 @@
>  #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
>  #define BRCM_PCIE_4371_DEVICE_ID	0x440d
>  #define BRCM_PCIE_4378_DEVICE_ID	0x4425
> -
> +#define CY_PCIE_89459_DEVICE_ID         0x4415
> +#define CY_PCIE_89459_RAW_DEVICE_ID     0x4355

Note that the PCI device ID for our 4355 is 0x43dc. Other sources call
this "BCM4355 D11AC", which is distinct from 0x4355 ("BCM43237 D11N")
and 0x4415 ("BCM43596 D11AC").

- Hector
