Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3C741BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjF1W3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF1W3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:29:20 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998C213D;
        Wed, 28 Jun 2023 15:29:18 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb11.dynamic.kabel-deutschland.de [95.90.235.17])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A7C8E61E5FE03;
        Thu, 29 Jun 2023 00:28:16 +0200 (CEST)
Message-ID: <20b61d77-7397-e3ba-3215-232f49eb8c07@molgen.mpg.de>
Date:   Thu, 29 Jun 2023 00:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] Bluetooth: btmtk: add printing firmware information
To:     Sean Wang <sean.wang@mediatek.com>,
        Chris Lu <chris.lu@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, jenhao.yang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        mmandlik@google.com, abhishekpandit@chromium.org,
        mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1c40a12b51ccd6ee2ee002276f5b1ba92c377100.1687990098.git.objelf@gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1c40a12b51ccd6ee2ee002276f5b1ba92c377100.1687990098.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean, dear Chris,


Thank you for your patch.

Am 29.06.23 um 00:20 schrieb sean.wang@mediatek.com:
> From: Chris Lu <chris.lu@mediatek.com>
> 
> Add printing firmware information part when driver loading firmware that
> user can get mediatek bluetooth information.

Maybe use the commit message summary/title below:

Bluetooth: btmtk: Log hw/sw version and fw build time

Maybe also paste one log message example to the commit message.

> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
> v3: resend again with the latest tree
> ---
>   drivers/bluetooth/btmtk.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 9482401d97fa..8490d59502a5 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -57,6 +57,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>   			      wmt_cmd_sync_func_t wmt_cmd_sync)
>   {
>   	struct btmtk_hci_wmt_params wmt_params;
> +	struct btmtk_patch_header *hdr;
>   	struct btmtk_global_desc *globaldesc = NULL;
>   	struct btmtk_section_map *sectionmap;
>   	const struct firmware *fw;
> @@ -75,9 +76,13 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>   
>   	fw_ptr = fw->data;
>   	fw_bin_ptr = fw_ptr;
> +	hdr = (struct btmtk_patch_header *)fw_ptr;
>   	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
>   	section_num = le32_to_cpu(globaldesc->section_num);
>   
> +	bt_dev_info(hdev, "HW/SW Version: 0x%04x%04x, Build Time: %s",

Why not print 0x%04x/0x%04x, that means with a slash?

> +		    le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr->datetime);
> +
>   	for (i = 0; i < section_num; i++) {
>   		first_block = 1;
>   		fw_ptr = fw_bin_ptr;


Kind regards,

Paul
