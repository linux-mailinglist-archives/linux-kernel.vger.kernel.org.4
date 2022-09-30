Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB15F06D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiI3Isg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiI3Is3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:48:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E41E458F;
        Fri, 30 Sep 2022 01:48:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C77C66022C7;
        Fri, 30 Sep 2022 09:48:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664527706;
        bh=wsKfSJrwiuKBEua7WnzhXWyeBCqlNxfAGcDYOglaauI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fmo7+zM31CXYHFt2Ogbexh0ZdseiYh04XEFwEGq69ByT2cPNe9ImKgQEut7CEovCO
         q8U9mFhttpC9Q5tEVX2huPEdLXaHyMMf7K9Nb/Rqf1p2VOCQ1bxkWD0JTc/tgLiDiw
         PDLnODzXOhhsViquydywBacYIa10kepPVMDtSFjnmT228EXhn67KkvxSNVWqE6LI1X
         0T0s8lv6AuDmzUeBsLr3i5Oa7PBNwHDb657kmXAPw9j344NiqEpJ2tdN4bCxsR5qdc
         ZIkzdn2VpWsARVWOtDWXKANPYFyfexrND8sBjERN3WwCzuw/pnzgxjWiq/9GSPlxwd
         IjSegHSqxNraw==
Message-ID: <58a119b4-78a7-8254-b986-e1dd6b515e23@collabora.com>
Date:   Fri, 30 Sep 2022 10:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout
 instead of open coding
Content-Language: en-US
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ab8958da839ecadc0ebff9f0a221ef49a2e5a4cc.1664497281.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ab8958da839ecadc0ebff9f0a221ef49a2e5a4cc.1664497281.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 02:23, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Use readx_poll_timeout instead of open coding to poll the hardware reset
> status until it is done.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> The patch is built and tested on the top of the patches
> [v6,1/3] Bluetooth: Add support for hci devcoredump
> [v6,2/3] Bluetooth: btusb: Add btusb devcoredump support
> [v6,3/3] Bluetooth: btintel: Add Intel devcoredump support
> which are contributed from Manish Mandlik
> 
> v2: use 20ms as the unit to poll according to the requirement of
>      readx_poll_timeout
> ---
>   drivers/bluetooth/btusb.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4eb79e88f1d9..9ef0dc648573 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2361,8 +2361,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
>   #define MTK_EP_RST_OPT		0x74011890
>   #define MTK_EP_RST_IN_OUT_OPT	0x00010001
>   #define MTK_BT_RST_DONE		0x00000100
> -#define MTK_BT_RESET_WAIT_MS	100
> -#define MTK_BT_RESET_NUM_TRIES	10
>   
>   static void btusb_mtk_wmt_recv(struct urb *urb)
>   {
> @@ -2733,6 +2731,16 @@ static int btusb_mtk_id_get(struct btusb_data *data, u32 reg, u32 *id)
>   	return btusb_mtk_reg_read(data, reg, id);
>   }
>   
> +static u32 btusb_mtk_reset_done(struct hci_dev *hdev)

I'm sorry for not noticing that in v1, but...

...If you call this function "btusb_mtk_reset_done"...

> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	u32 val = 0;
> +
> +	btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
> +
> +	return val;

...you shouldn't return the value of the entire MTK_BT_MISC register,
otherwise you should call this "btusb_mtk_read_bt_misc_reg".

I think that here, you should do

	return val & MTK_BT_RST_DONE;

and then, for the readx_poll_timeout, you simply check if this function
returned 1, like:

	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val, val,
				 20000, 1000000);

> +}
> +
>   static int btusb_mtk_setup(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -2922,7 +2930,7 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
>   	u32 val;
> -	int err, retry = 0;
> +	int err;
>   
>   	/* It's MediaTek specific bluetooth reset mechanism via USB */
>   	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> @@ -2953,18 +2961,14 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
>   	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
>   	btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
>   
> -	/* Poll the register until reset is completed */
> -	do {
> -		btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
> -		if (val & MTK_BT_RST_DONE) {
> -			bt_dev_dbg(hdev, "Bluetooth Reset Successfully");
> -			break;
> -		}
> +	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
> +				 val & MTK_BT_RST_DONE,
> +				 20000, 1000000);
> +	if (err < 0)
> +		bt_dev_err(hdev, "Reset timeout");
>   
> -		bt_dev_dbg(hdev, "Polling Bluetooth Reset CR");
> -		retry++;
> -		msleep(MTK_BT_RESET_WAIT_MS);
> -	} while (retry < MTK_BT_RESET_NUM_TRIES);
> +	if (val & MTK_BT_RST_DONE)

You're already checking `if (err < 0)`, so this check is redundant.
If the polling didn't return a timeout, the register value contains
MTK_BT_RST_DONE for sure, so you can safely remove this check.

> +		bt_dev_dbg(hdev, "Bluetooth Reset Successfully");
>   

Regards,
Angelo


