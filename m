Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34872E870
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbjFMQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbjFMQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:21:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99794199E;
        Tue, 13 Jun 2023 09:21:02 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxzOprl4hkqrUEAA--.10083S3;
        Wed, 14 Jun 2023 00:20:59 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMpql4hkF3QZAA--.63775S3;
        Wed, 14 Jun 2023 00:20:58 +0800 (CST)
Message-ID: <14e56806-833b-c01b-ee74-8f16f48df2fc@loongson.cn>
Date:   Wed, 14 Jun 2023 00:20:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
To:     WANG Xuerui <kernel@xen0n.name>, Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Liu Peibao <liupeibao@loongson.cn>, linux-media@vger.kernel.org
References: <20230520105718.325819-1-15330273260@189.cn>
 <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTMpql4hkF3QZAA--.63775S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyUtrW3WrWfJr48GF4fCrX_yoW8tw1xpF
        WfKFWIkrykJrn5Ar1DZr15Za48ZrZYya45Wa9Yv3Wjqrn8CryjgryIq3s0gryxCrs3XF1a
        vF4UGw17ua1DXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUd529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/21 20:21, WANG Xuerui wrote:
>> +
>> +static int __init loongson_module_init(void)
>> +{
>> +    struct pci_dev *pdev = NULL;
>> +
>> +    if (video_firmware_drivers_only())
>> +        return -ENODEV;
>> +
>> +    /* Multiple video card workaround */
>> +    while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev))) {
>> +        if (pdev->vendor != PCI_VENDOR_ID_LOONGSON) {
>> +            pr_info("Discrete graphic card detected, abort\n");
>
> Why is it that the iGPU cannot be used together with a dGPU? I can't 
> see why this is technically the case so some more explanations could 
> be beneficial to other readers and LoongArch devs.


We will remote this workaround at next version. we find some way to keep 
multiple GPU driver co-exixt in the system. The reason we choose to 
workaround is because it  is both easy and effective to solve bugs.


After the dGPU is mounted on the motherboard,

1) the integrate register don't receive write or read access anymore.  
sometime cause its can't receive vblank interrupt, causing vblank 
timeout etc.

Have something to do with the PCI driver layer and/or PCI/vgaarb layer.


2) For ls7a1000, both the display controller and gpu is special,

     when dGPU is mounted, we are multiple gpu system.

     we should made the vgaarb works correct , this is relay on firmware 
and efi  support to be complete.

    In the past, our system don't support firmware framebuffer even.

3) It need us we implement PRIME, for cross driver buffer sharing.

      loongson display don't has scatter-gather able DMA. Can't access 
non physical contiguous GTT buffer.

     We can only expect

    1) the CPU do the copy.

    2) DC driver export dumb buffer, and GPU driver import this buffer, 
and resolve the tiled buffer to the linear.

    3) shared buffer has to pinned at GTT


4) Using space X server also has bug for parser the PCI device on 
complex patch.


5) Even on X86, there are motherboard vendor choose to black the iGPU 
when the dGPU is mounted.

It perhaps better black the iGPU at firmware layer.

But our firmware engineer don't know about this for a very long time.


But as its already as is, we will try to improve this at the next version.

-- 
Jingfeng

