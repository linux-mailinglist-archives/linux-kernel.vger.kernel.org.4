Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34334750305
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjGLJZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGLJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:25:50 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DEBE5F;
        Wed, 12 Jul 2023 02:25:48 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 472E361E5FE03;
        Wed, 12 Jul 2023 11:25:21 +0200 (CEST)
Message-ID: <b8a27d63-c214-0af6-7ad0-b82402208e3b@molgen.mpg.de>
Date:   Wed, 12 Jul 2023 11:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] Bluetooth: btmtk: Fix null pointer when processing
 coredump
To:     =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20230712051857.13812-1-chris.lu@mediatek.com>
 <0cb29d27-a76f-47f2-86c3-f39ba25e8bc2@molgen.mpg.de>
 <d8f82d97496c73c01521dbbce5455ad23521036c.camel@mediatek.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d8f82d97496c73c01521dbbce5455ad23521036c.camel@mediatek.com>
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


Am 12.07.23 um 10:53 schrieb Chris Lu (陸稚泓):
> On Wed, 2023-07-12 at 08:11 +0200, Paul Menzel wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.

(It’d be nice if you removed such (automatically added) phrases from 
your reply.)

> Thanks for your review and feedback to Mediatek's Bluetooth driver
> code.

Thank you for your reply.

>> Am 12.07.23 um 07:18 schrieb Chris Lu:
>>> There may be a potential null pointer risk if offset value is
>>> less than 0 when doing memcmp in btmtk_process_coredump().
>>> Checking offset is valid before doing memcmp.
>>
>> Use imperative mood: Check offset …
>>
>>> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
>>> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>> v2: fix typo
>>> v3: fix bot checking error
>>> ---
>>>    drivers/bluetooth/btmtk.c | 16 ++++++++--------
>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
>>> index 786f775196ae..0f290430ae0e 100644
>>> --- a/drivers/bluetooth/btmtk.c
>>> +++ b/drivers/bluetooth/btmtk.c
>>> @@ -370,7 +370,7 @@ EXPORT_SYMBOL_GPL(btmtk_register_coredump);
>>>    int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
>>>    {
>>>    struct btmediatek_data *data = hci_get_priv(hdev);
>>> -int err;
>>> +int err, offset;
>>>    
>>>    if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
>>>    return 0;
>>> @@ -392,15 +392,15 @@ int btmtk_process_coredump(struct hci_dev
>> *hdev, struct sk_buff *skb)
>>>    if (err < 0)
>>>    break;
>>>    data->cd_info.cnt++;
>>> +offset = skb->len - sizeof(MTK_COREDUMP_END);
>>
>> For `sizeof()` shouldn’t you use `size_t`? But that is unsigned of
>> course. Maybe ssize_t then?
>
> yes, it's better to use ssize_t or size_t, I'll change declaratins of
> offset from int to ssize_t.
> 
>>>    
>>>    /* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
>>> -if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
>>> -    skb->len > sizeof(MTK_COREDUMP_END) &&
>>> -    !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
>>> -    MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
>>> -bt_dev_info(hdev, "Mediatek coredump end");
>>> -hci_devcd_complete(hdev);
>>> -}
>>> +if (data->cd_info.cnt > MTK_COREDUMP_NUM && offset > 0)
>>
>> Why not keep it like before, and just add the condition `skb->len <
>> sizeof(MTK_COREDUMP_END)`? The compiler is probably going to optimize
>> so the value is not calculated twice.

> The reason why I send this patch is when I backport devcoredump feature
> to specific project with older kernel version, the compiler might not
> so optimized that it would cause kernel panic when run into memcmp.
> As a result, make sure `skb->len > sizeof(MTK_COREDUMP_END) ` before
> doing memcmp part can avoid null pointer issue.
> Besides, only in condition 'data->cd_info.cnt > MTK_COREDUMP_NUM &&
> offset > 0' need to do memcmp to check the end of coredump. Driver do
> noting with condition `skb->len < sizeof(MTK_COREDUMP_END) ` that
> additional condiction is not really necessary.

Just to avoid misunderstandings, my point, to add the comparison and get 
rid of the variable `offset`.


Kind regards,

Paul


>>> +if (!memcmp((char *)&skb->data[offset], MTK_COREDUMP_END,
>>> +    sizeof(MTK_COREDUMP_END) - 1)) {
>>> +bt_dev_info(hdev, "Mediatek coredump end");
>>> +hci_devcd_complete(hdev);
>>> +}
>>>    
>>>    break;
>>>    }
