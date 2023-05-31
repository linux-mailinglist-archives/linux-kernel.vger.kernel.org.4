Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7C7184CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjEaOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjEaOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:23:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFCA121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:22:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx6fEuWHdkQ_wCAA--.6721S3;
        Wed, 31 May 2023 22:22:38 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxt7kuWHdkPn+CAA--.15949S3;
        Wed, 31 May 2023 22:22:38 +0800 (CST)
Message-ID: <d0791062-b6a4-aff0-10ae-a76d096ac9cc@loongson.cn>
Date:   Wed, 31 May 2023 22:22:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/6] drm/etnaviv: allow usperspace create cached
 coherent bo
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
References: <ZHZHTi4AzPLbcU3+@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <ZHZHTi4AzPLbcU3+@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dxt7kuWHdkPn+CAA--.15949S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4c8EcI0E
        c7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jr
        v_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU7vtCUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Thanks a lot, will be fixed at next version.


On 2023/5/31 02:58, Bjorn Helgaas wrote:
> s/usperspace/userspace/ (in subject)
>
> On Wed, May 31, 2023 at 12:06:43AM +0800, Sui Jingfeng wrote:
>> cached system RAM is coherent on loongson CPUs, and the GPU and DC allways
>> snoop the CPU's cache. write-combine caching property is not suitiable for
>> us.
> s/allways/always/
> s/suitiable/suitable/

-- 
Jingfeng

