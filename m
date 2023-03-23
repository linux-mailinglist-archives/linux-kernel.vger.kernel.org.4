Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFCB6C68BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCWMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCWMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:46:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF1AA274B2;
        Thu, 23 Mar 2023 05:46:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cxf80cShxks1IQAA--.24571S3;
        Thu, 23 Mar 2023 20:46:20 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxlrwbShxkRlgKAA--.1929S3;
        Thu, 23 Mar 2023 20:46:20 +0800 (CST)
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
 <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
 <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
 <9917d619-1104-4040-bb6f-c564fcf72806@sirena.org.uk>
 <5c281b1a-b6a7-c62e-6247-5d82ebd5e0d6@loongson.cn>
 <f7811b40-80a3-4985-b92d-1df3e28a0935@sirena.org.uk>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <2337f45f-c513-1b10-ccfc-766363c5fd02@loongson.cn>
Date:   Thu, 23 Mar 2023 20:46:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f7811b40-80a3-4985-b92d-1df3e28a0935@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxlrwbShxkRlgKAA--.1929S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUKr47Kr4DGF4DtFyDAwb_yoW8XF4rpF
        W0qw17WryDJr1Fyw4DKr4DWF90kr1fJw43AFWktF4DAryDXry2qr4jgrs29Fy3AF4xJF1Y
        qry8WrWruF15ArUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/21 下午8:08, Mark Brown 写道:
> On Tue, Mar 21, 2023 at 10:54:32AM +0800, zhuyinbo wrote:
>> 在 2023/3/20 下午8:52, Mark Brown 写道:
>>> No, that doesn't help if setup() reconfigures the controller while it's
>>> doing a transfer.  The issue is that the controller might be put into
>>> the wrong mode or run at the wrong speed.
>> sorry, I don't got that why cpu still can call setup's critical region when
>> cpu call transfer_one to  transfer spi data.
>> when I added a spin_lock for setup and transfer_one then setup and
>> transfer_one's critical region cann't be called
>> simultaneously as I know, because the their lock was same lock.
> Think what happens if the two SPI devices have different configurations
> - for example, a different SPI mode.  The register state won't be
> corrupted but the devices will still end up seeing misconfigured SPI
> transfers.

I think add following change and that issue what you said will can be 
fixed,   in addition, the spin_lock

was also not needed.   Do you think so?

@@ -101,8 +101,10 @@ static int loongson_spi_setup(struct spi_device *spi)
         if (spi->chip_select >= spi->master->num_chipselect)
                 return -EINVAL;

+       loongson_spi->hz = 0;
+       loongson_spi->mode &= SPI_NO_CS;
+
         spin_lock(&loongson_spi->lock);
-       loongson_spi_update_state(loongson_spi, spi, NULL);
         loongson_spi_set_cs(spi, 1);


