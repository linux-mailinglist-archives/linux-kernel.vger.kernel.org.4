Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4883D6E4023
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDQGv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDQGvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:51:24 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1983C25
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:51:20 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 599DB5FD11;
        Mon, 17 Apr 2023 09:51:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681714277;
        bh=R3OgBzGfrSGuO8fG2ax+w0XsYo1vAK4vtps7ptMYepI=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=mNvyBMLC4CbCtc4mIpmlg8BXK9Zdb6NVkVRpTHktraJVXX6+WW5Hpc4DcoQxq05UY
         L4humK7lrD2nlZq8360E0Cm/eTesTS66z3pLeR/+GmGakGaAv/4LdG8/iMsp5gQCQW
         j+y/dVHt/WAyRCnBU9KD6dV1f9OQ6fVn2PwPxk8yn0k7BEq9TWht5tYBdAfBZW/uhZ
         mi95N60MX9KmZpvLSjq3TdTmRZq7Gl8bUYLoDyp9EXPh3G8NYWJXQNW8wiGL8mlPL1
         Eqxn3l6A/TdTzTyyGbOGaH60DurP6Ivva+sOknms53Xfc5ASuc3BvjfXdF2g5hit82
         HHpsQgqhcHOmA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 17 Apr 2023 09:51:15 +0300 (MSK)
Message-ID: <ac6d67ce-54e3-83f4-fef4-fb93bdef2515@sberdevices.ru>
Date:   Mon, 17 Apr 2023 09:47:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/5] mtd: rawnand: meson: fix NAND access for
 read/write
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-2-AVKrasnov@sberdevices.ru>
 <889cf54e-584c-9bee-2106-633155897324@amlogic.com>
 <3f247cbe-2798-4871-82a5-5124142fdcc5@sberdevices.ru>
 <4f552f57-c31e-985c-82be-081dff38d377@sberdevices.ru>
 <dc690524-51d5-7bb9-a106-fa153c4e6250@amlogic.com>
 <68f3bea8-4b79-db48-172f-712dcabce65b@sberdevices.ru>
 <d3d5cf52-cf1e-31d1-46c5-d1df06c61fb3@amlogic.com>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <d3d5cf52-cf1e-31d1-46c5-d1df06c61fb3@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/17 04:41:00 #21117793
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2023 08:57, Liang Yang wrote:
> Hi Arseniy,
> 
> On 2023/4/13 13:10, Arseniy Krasnov wrote:
>> [ EXTERNAL EMAIL ]
>>
>>
>>
>> On 12.04.2023 16:30, Liang Yang wrote:
>>> Hi,
>>>
>>> On 2023/4/12 20:03, Arseniy Krasnov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>>
>>>>
>>>> On 12.04.2023 13:24, Arseniy Krasnov wrote:
>>>>>
>>>>>
>>>>> On 12.04.2023 12:37, Liang Yang wrote:
>>>>>> Hi Arseniy,
>>>>>>
>>>>>> Thanks for pointing out this problem. also comment inline.
>>>>>>
>>>>>> On 2023/4/12 14:16, Arseniy Krasnov wrote:
>>>>>>> [ EXTERNAL EMAIL ]
>>>>>>>
>>>>>>> This fixes read/write functionality. New command sequences were ported
>>>>>>> from old vendor's driver. Without this patch driver works unstable. This
>>>>>>> change is tested with 'nanddump'/'nandwrite' utilities and mounting
>>>>>>> JFFS2 filesystem on AXG family (A113X SoC).
>>>>>>>
>>>>>>> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>> ---
>>>>>>>     drivers/mtd/nand/raw/meson_nand.c | 116 ++++++++++++++++++++++++++----
>>>>>>>     1 file changed, 101 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>> index 074e14225c06..256c37c76526 100644
>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>     #define NFC_CMD_IDLE        (0xc << 14)
>>>>>>>     #define NFC_CMD_CLE        (0x5 << 14)
>>>>>>>     #define NFC_CMD_ALE        (0x6 << 14)
>>>>>>> +#define NFC_CMD_DRD        (0x8 << 14)
>>>>>>>     #define NFC_CMD_ADL        ((0 << 16) | (3 << 20))
>>>>>>>     #define NFC_CMD_ADH        ((1 << 16) | (3 << 20))
>>>>>>>     #define NFC_CMD_AIL        ((2 << 16) | (3 << 20))
>>>>>>> @@ -84,6 +85,7 @@
>>>>>>>       #define DMA_BUSY_TIMEOUT    0x100000
>>>>>>>     #define CMD_FIFO_EMPTY_TIMEOUT    1000
>>>>>>> +#define DEVICE_READY_TIMEOUT    1000
>>>>>>>       #define MAX_CE_NUM        2
>>>>>>>     @@ -255,8 +257,26 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
>>>>>>>         }
>>>>>>>     }
>>>>>>>     +static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>> +                     unsigned int timeout_ms)
>>>>>>> +{
>>>>>>> +    u32 cmd_size = 0;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    /* wait cmd fifo is empty */
>>>>>>> +    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>> +                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>> +                     10, timeout_ms * 1000);
>>>>>>> +    if (ret)
>>>>>>> +        dev_err(nfc->dev, "wait for empty CMD FIFO timed out\n");
>>>>>>> +
>>>>>>> +    return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>>     static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
>>>>>>>     {
>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 0);
>>>>>>> +
>>>>>>>         writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
>>>>>>>                nfc->reg_base + NFC_REG_CMD);
>>>>>>>     }
>>>>>>> @@ -308,23 +328,9 @@ static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
>>>>>>>          */
>>>>>>>         meson_nfc_cmd_idle(nfc, 0);
>>>>>>>         meson_nfc_cmd_idle(nfc, 0);
>>>>>>> +    meson_nfc_wait_cmd_finish(nfc, 1000);
>>>>>>>     }
>>>>>>>     -static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
>>>>>>> -                     unsigned int timeout_ms)
>>>>>>> -{
>>>>>>> -    u32 cmd_size = 0;
>>>>>>> -    int ret;
>>>>>>> -
>>>>>>> -    /* wait cmd fifo is empty */
>>>>>>> -    ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
>>>>>>> -                     !NFC_CMD_GET_SIZE(cmd_size),
>>>>>>> -                     10, timeout_ms * 1000);
>>>>>>> -    if (ret)
>>>>>>> -        dev_err(nfc->dev, "wait for empty CMD FIFO time out\n");
>>>>>>> -
>>>>>>> -    return ret;
>>>>>>> -}
>>>>>>>       static int meson_nfc_wait_dma_finish(struct meson_nfc *nfc)
>>>>>>>     {
>>>>>>> @@ -631,6 +637,48 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>>     +static uint8_t meson_nfc_read_byte(struct nand_chip *nand)
>>>>>>> +{
>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>> +
>>>>>>> +    writel(NFC_CMD_DRD, nfc->reg_base + NFC_REG_CMD);
>>>>>>> +    meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>> +
>>>>>>> +    return readl(nfc->reg_base + NFC_REG_BUF);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int meson_nfc_wait_dev_ready(struct nand_chip *nand)
>>>>>>> +{
>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>> +    unsigned long cnt = 0;
>>>>>>> +
>>>>>>> +    meson_nfc_drain_cmd(nfc);
>>>>>>> +
>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_STATUS, nfc->reg_base + NFC_REG_CMD);
>>>>>>> +
>>>>>>> +    /* 10 ms. */
>>>>>>> +    while (cnt < DEVICE_READY_TIMEOUT) {
>>>>>>> +        uint8_t status;
>>>>>>> +
>>>>>>> +        status = meson_nfc_read_byte(nand);
>>>>>>> +
>>>>>>> +        if (status & NAND_STATUS_READY)
>>>>>>> +            break;
>>>>>>> +
>>>>>>> +        usleep_range(10, 11);
>>>>>>> +        cnt++;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (cnt == DEVICE_READY_TIMEOUT) {
>>>>>>> +        dev_err(nfc->dev, "device ready timeout\n");
>>>>>>> +        return -ETIMEDOUT;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>     static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>                         int page, int raw)
>>>>>>>     {
>>>>>>> @@ -643,6 +691,10 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>         u32 cmd;
>>>>>>>         int ret;
>>>>>>>     +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>>         meson_nfc_select_chip(nand, nand->cur_cs);
>>>>>>>           data_len =  mtd->writesize + mtd->oobsize;
>>>>>>> @@ -667,12 +719,20 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
>>>>>>>                          NFC_CMD_SCRAMBLER_DISABLE);
>>>>>>>         }
>>>>>>>     +    ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>>         cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>         meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
>>>>>>>           meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
>>>>>>>     +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>>         return ret;
>>>>>>>     }
>>>>>>>     @@ -720,6 +780,21 @@ static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
>>>>>>>         } while (!ret);
>>>>>>>     }
>>>>>>>     +static inline int meson_nfc_send_read(struct nand_chip *nand)
>>>>>>> +{
>>>>>>> +    struct meson_nfc *nfc = nand_get_controller_data(nand);
>>>>>>> +    u32 cs = nfc->param.chip_select;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>> +    writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>
>>>>>> it already calls meson_nfc_queue_rb() in meson_nfc_rw_cmd_prepare_and_execute(). Could you implements this in meson_nfc_queue_rb()? and we can use the irq method.
>>>>>> also without Ready/Busy pin, the meson_nfc_queue_rb() should change like below:
>>>>>>       ......
>>>>>>       #define NFC_CMD_RB_INT    ((0xb << 10) | BIT(18))
>>>>
>>>> Sorry, I can see this define as (and it is used in the driver):
>>>> #define NFC_CMD_RB_INT          BIT(14)
>>>>
>>>> in drivers/mtd/nand/raw/meson_nand.c
>>>>
>>>> Which one is correct ?
>>>
>>> we need to modify the define 'NFC_CMD_RB_INT' as ((0xb << 10) | BIT(18)).
>>>
>>
>> Ok, NFC_CMD_RB_INT - it is "Ready/Busy_Interrupt" ? You suppose that currently it is
>> defined incorrectly, so irq waiting does not work?
> 
> Previous defined BIT(14) is for having the external Ready/Busy pin of the NAND device connected to the controller. the new define is for reading status by sending read status(70H) command and read status from the data bus(checking the IO6). the both can work on AXG soc.
> when the controller RB command is sent, the controller automatically checks the level of external Ready/Busy pin or the data bus(IO6) periodicity. and generate the irq signal if status is ready.
> 
>>
>> Thanks, Arseniy
>>
>>>>
>>>> Thanks, Arseniy
>>>>
>>>>>>
>>>>>>       meson_nfc_cmd_idle(nfc, 0);
>>>>>>       cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>>>>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>       meson_nfc_cmd_idle(nfc, 5);
>>>>>>       cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>>>>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>
>>>>>>       ret = wait_for_completion_timeout(&nfc->completion,
>>>>>>                         msecs_to_jiffies(timeout_ms));
>>>>>>       if (ret == 0)
>>>>>>           ret = -1;
>>>>>>
>>>>>>       writel(cs | NFC_CMD_CLE | NAND_CMD_READ0, nfc->reg_base + NFC_REG_CMD);
>>>>>>       ......
>>>>>>

Hello Liang!

I've got small questions to clarify Your comment. You suggest two thing IIUC:

1) Send NAND_CMD_READ0 from 'meson_nfc_queue_rb()'. This means that extra argument is needed to
'meson_nfc_queue_rb()' which shows that read operation is going to be performed. We can't send
NAND_CMD_READ0 for write operation?

2) About code and define above, I tried to replace current body of 'meson_nfc_queue_rb()', but it
didn't work. May be I did it wrong, because what to do with 'meson_nfc_wait_dev_ready()' and it's
call sites? It must be removed? Could You please explain Your idea in more details? I'm asking You
because I don't have doc for this NAND controller, so it is very difficult to me to add valid
logic to this driver without any references

May be I can send v2 patchset for review without this change, as v2 already includes udpate for OOB
handling which is I think more critical?

Thanks, Arseniy

>>>>>
>>>>>       Thanks for reply! I'll try this code! One more question about OOB processing in this
>>>>> driver (as You are author of it):
>>>>>
>>>>>      OOB size is 64 bytes, but for example if I have 1K ECC, 2 bytes user bytes and 14
>>>>>      bytes for ECC code for each 1K. In this case I have access to only 32 bytes of OOB:
>>>>>      2 x (2 user bytes + 14 ECC bytes). Correct me if i'm wrong, but rest of OOB (next
>>>>>      32 bytes) become unavailable (in both raw and ECC modes) ?
>>>>>
>>>>> Thanks, Arseniy
>>>>>
>>>>>>>     static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>                        int page, int raw)
>>>>>>>     {
>>>>>>> @@ -734,10 +809,18 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>         data_len =  mtd->writesize + mtd->oobsize;
>>>>>>>         info_len = nand->ecc.steps * PER_INFO_BYTE;
>>>>>>>     +    ret = meson_nfc_wait_dev_ready(nand);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>>         ret = meson_nfc_rw_cmd_prepare_and_execute(nand, page, DIRREAD);
>>>>>>>         if (ret)
>>>>>>>             return ret;
>>>>>>>     +    ret = meson_nfc_send_read(nand);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>>         ret = meson_nfc_dma_buffer_setup(nand, meson_chip->data_buf,
>>>>>>>                          data_len, meson_chip->info_buf,
>>>>>>>                          info_len, DMA_FROM_DEVICE);
>>>>>>> @@ -754,6 +837,9 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
>>>>>>>         }
>>>>>>>           ret = meson_nfc_wait_dma_finish(nfc);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>>         meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
>>>>>>>           meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_FROM_DEVICE);
>>>>>>
>>>>
>>>
>>
> 
