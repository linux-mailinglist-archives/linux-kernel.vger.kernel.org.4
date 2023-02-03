Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE3688DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjBCDZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBCDZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:25:55 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCF4066EC4;
        Thu,  2 Feb 2023 19:25:50 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8DxzOq9ftxj5xsNAA--.26158S3;
        Fri, 03 Feb 2023 11:25:49 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax97y4ftxj4j0oAA--.12781S3;
        Fri, 03 Feb 2023 11:25:46 +0800 (CST)
Message-ID: <83297fd0-37f8-2b1c-bc16-d7cfcf5bd697@loongson.cn>
Date:   Fri, 3 Feb 2023 11:25:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <57805e19-285a-76d3-16e3-09a3eb7a9540@189.cn>
 <20220209085215.65qbdsgwtnvujdng@houat>
 <8e7f7946-b9e5-7c4d-f5c9-e091bf5f814b@flygoat.com>
 <20220209140432.ekqszxbtitmacpk5@houat>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20220209140432.ekqszxbtitmacpk5@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax97y4ftxj4j0oAA--.12781S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ww4UGrW5tFyrCw1xGFykKrg_yoW8AFWkpF
        W3tF1agF4kAF1Fka4vyw47Z34xuw4fJay5Arn8G345ZF98Wrya9r4Utw409ay29rs5Cw1Y
        vFZ0qa48KF1Dua7anT9S1TB71UUUU1DqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/9 22:04, Maxime Ripard wrote:
> On Wed, Feb 09, 2022 at 11:56:48AM +0000, Jiaxun Yang wrote:
>>
>> 在 2022/2/9 8:52, Maxime Ripard 写道:
>>> On Thu, Feb 03, 2022 at 11:47:16PM +0800, Sui Jingfeng wrote:
>> [...]
>>> DT isn't really a solution either. Let's take the distribution
>>> perspective there. Suppose you're a Fedora or Debian developer, and want
>>> to make a single kernel image, and ship a DT to the user for their board
>>> without any modification. How is either the Kconfig solution or DT flags
>>> solution any good there? It doesn't help them at all.
>> We are working in another way. As we can tell model of the board by strings
>> passed from the firmware, we just built-in all poosible DTs into the kernel
>> and then tell which DT to load at boot time. So we can ensure users has
>> smmoth experience.
> It's not really for you to say though. Once your driver is in a release,
> distros are going to use it. That's the whole point of you asking us to
> merge it.
>
> Maxime

Hi, Dear Maxime

There are still some LS3a5000+ls7a2000 and LS3a5000+ls7a1000 boards at 
china market.

ls7a2000 has loongson display controller + loongson self-made GPU 
integrated. Without

a display driver, integrated graphics of the board can not be used with 
upstream kernel.

A few ordinary player and user space developer blaming  me, they need a 
basic usable

graphic environment  badly. Do you have spare time to review my patch 
again,

The DC is lack of document  even though in Chinese because the hardware 
engineer don't supply one.

But I will provide more information required during code review as far 
as i can tell.


https://patchwork.kernel.org/project/dri-devel/patch/20230201170403.167665-1-15330273260@189.cn/ 



Thanks for your kindness and your valuable  time .

