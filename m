Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041A874FF13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjGLGMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGLGMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:12:35 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2903910C2;
        Tue, 11 Jul 2023 23:12:34 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aed4f.dynamic.kabel-deutschland.de [95.90.237.79])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 147F861E5FE01;
        Wed, 12 Jul 2023 08:11:42 +0200 (CEST)
Message-ID: <0cb29d27-a76f-47f2-86c3-f39ba25e8bc2@molgen.mpg.de>
Date:   Wed, 12 Jul 2023 08:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] Bluetooth: btmtk: Fix null pointer when processing
 coredump
Content-Language: en-US
To:     Chris Lu <chris.lu@mediatek.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Aaron Hou <aaron.hou@mediatek.com>,
        Steve Lee <steve.lee@mediatek.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230712051857.13812-1-chris.lu@mediatek.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230712051857.13812-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chris,


Am 12.07.23 um 07:18 schrieb Chris Lu:
> There may be a potential null pointer risk if offset value is
> less than 0 when doing memcmp in btmtk_process_coredump().
> Checking offset is valid before doing memcmp.

Use imperative mood: Check offset …

> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2: fix typo
> v3: fix bot checking error
> ---
>   drivers/bluetooth/btmtk.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 786f775196ae..0f290430ae0e 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -370,7 +370,7 @@ EXPORT_SYMBOL_GPL(btmtk_register_coredump);
>   int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
>   {
>   	struct btmediatek_data *data = hci_get_priv(hdev);
> -	int err;
> +	int err, offset;
>   
>   	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
>   		return 0;
> @@ -392,15 +392,15 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
>   		if (err < 0)
>   			break;
>   		data->cd_info.cnt++;
> +		offset = skb->len - sizeof(MTK_COREDUMP_END);

For `sizeof()` shouldn’t you use `size_t`? But that is unsigned of 
course. Maybe ssize_t then?

>   
>   		/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
> -		if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
> -		    skb->len > sizeof(MTK_COREDUMP_END) &&
> -		    !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
> -			    MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
> -			bt_dev_info(hdev, "Mediatek coredump end");
> -			hci_devcd_complete(hdev);
> -		}
> +		if (data->cd_info.cnt > MTK_COREDUMP_NUM && offset > 0)

Why not keep it like before, and just add the condition `skb->len < 
sizeof(MTK_COREDUMP_END)`? The compiler is probably going to optimize so 
the value is not calculated twice.


Kind regards,

Paul


> +			if (!memcmp((char *)&skb->data[offset], MTK_COREDUMP_END,
> +				    sizeof(MTK_COREDUMP_END) - 1)) {
> +				bt_dev_info(hdev, "Mediatek coredump end");
> +				hci_devcd_complete(hdev);
> +			}
>   
>   		break;
>   	}
