Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8317318EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbjFOMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345129AbjFOMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:25:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F05AA2702
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:24:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.22])
        by gateway (Coremail) with SMTP id _____8Cx+entAotkoY0FAA--.11910S3;
        Thu, 15 Jun 2023 20:24:13 +0800 (CST)
Received: from [10.180.13.22] (unknown [10.180.13.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPMrsAotknPobAA--.4953S3;
        Thu, 15 Jun 2023 20:24:12 +0800 (CST)
Message-ID: <ecd99175-d9da-cecd-d165-e9bd3452f7cb@loongson.cn>
Date:   Thu, 15 Jun 2023 20:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] ASoC: Add support for Loongson I2S controller
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
References: <20230614122140.3402749-1-mengyingkun@loongson.cn>
 <89022514-9f99-4fdc-9eba-d428ad0bcbb6@sirena.org.uk>
Content-Language: en-US
From:   Yingkun Meng <mengyingkun@loongson.cn>
In-Reply-To: <89022514-9f99-4fdc-9eba-d428ad0bcbb6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxPMrsAotknPobAA--.4953S3
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQADDGSJrgIcngABsM
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF4kCF45trW8Xw15Gr4rJFc_yoW3WFXE93
        429F18C3yDWFy8Wr95Kr4kXryY9F9ru345Ga1ftrykJa4S9r93Xas7Cr929asIvFs2gFnI
        vr1qgF48Za4xuosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/15 19:30, Mark Brown wrote:
> On Wed, Jun 14, 2023 at 08:21:40PM +0800, YingKun Meng wrote:
>> From: Yingkun Meng <mengyingkun@loongson.cn>
>>
>> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
>> it is a PCI device with two private DMA controllers, one for playback,
>> the other for capture.
>>
>> The driver supports the use of DTS or ACPI to describe device resources.
> One minor thing which can be done as an incremental patch:
>
>> +/*
>> + * DMA registers descriptor.
>> + */
>> +struct loongson_dma_desc {
>> +	u32 order;		/* Next descriptor address register */
> This probably needs a __packed to ensure the layout doesn't get changed
> by the compiler (eg, with struct randomisation options).

OK, got it.

Thanks,

Yingkun

