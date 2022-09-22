Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47A45E5FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIVKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIVKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:31:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41DBD691D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:31:17 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32tdOSxj5w0gAA--.48410S3;
        Thu, 22 Sep 2022 18:30:54 +0800 (CST)
Subject: Re: [PATCH v3 1/3] LoongArch: Add kexec support
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
 <1663210426-15446-2-git-send-email-tangyouling@loongson.cn>
 <bfe4fed8b1da17561214cf9f2cf5acdf0e74d0ea.camel@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <75a059e8-108f-93f5-5d4e-01b09224f419@loongson.cn>
Date:   Thu, 22 Sep 2022 18:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <bfe4fed8b1da17561214cf9f2cf5acdf0e74d0ea.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx32tdOSxj5w0gAA--.48410S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW3JryfAF4UWw48tF48Crg_yoWDKrbE9w
        47Wrn5GF1fXrsrtan8Kr13tF98t3y0vF1YgryIv3y5A348tw48W39IywnYyF1kXrWkAanx
        Ars8ZrZYyw1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-xYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUgHanUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 09/22/2022 06:00 PM, Xi Ruoyao wrote:
> On Thu, 2022-09-15 at 10:53 +0800, Youling Tang wrote:
>> +int machine_kexec_prepare(struct kimage *kimage)
>> +{
>> +       int i;
>> +       void *dtb = (void *)KEXEC_BLOB_ADDR;
>> +
>> +       kexec_image_info(kimage);
>> +
>> +       /* Find the Flattened Device Tree */
>> +       for (i = 0; i < kimage->nr_segments; i++) {
>> +               if (!fdt_check_header(kimage->segment[i].buf)) {
>
> Hi Youling,
>
> When I build Huacai's tree
> (https://github.com/loongson/linux/commits/loongarch-next), there is a
> strange error linking vmlinux:
>
> ld: arch/loongarch/kernel/machine_kexec.o: in function `machine_kexec_prepare':
> /home/xry111/git-repos/linux/arch/loongarch/kernel/machine_kexec.c:70: undefined reference to `fdt_check_header'
>
> Not sure why...

This is because of the problem after efistub removes the fdt
modification, I will reimplement kexec/kdump. This build error can be
avoided by turning off CONFIG_KEXEC temporarily, tomorrow I will submit
a new kexec/kdump implementation.

Thanks,
Youling.
>

