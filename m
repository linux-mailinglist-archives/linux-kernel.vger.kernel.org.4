Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36156F437F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjEBMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjEBMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:15:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81B9B;
        Tue,  2 May 2023 05:15:55 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q9f8p2tH7z6J6nt;
        Tue,  2 May 2023 20:12:26 +0800 (CST)
Received: from [10.45.146.102] (10.45.146.102) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 14:15:52 +0200
Message-ID: <e05b416d-a298-cf71-0c04-a1fe6b993bf7@huawei.com>
Date:   Tue, 2 May 2023 14:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce
 buffers
Content-Language: en-US
To:     Mike Lothian <mike@fireburn.co.uk>,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Muchun Song <muchun.song@linux.dev>,
        Ondrej Zary <linux@zary.sk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <CAHbf0-HwQhFsYW8cp0t9660877b9tTxZBego7VSfx0ayAwKePQ@mail.gmail.com>
 <20230428110735.4348511d@meshulam.tesarici.cz>
 <CAHbf0-HnctoNN3AQoCeCfd-d7ppKBhWJHD+EbfmbfeTkbS1jqg@mail.gmail.com>
From:   Petr Tesarik <petr.tesarik.ext@huawei.com>
In-Reply-To: <CAHbf0-HnctoNN3AQoCeCfd-d7ppKBhWJHD+EbfmbfeTkbS1jqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.45.146.102]
X-ClientProxiedBy: frapeml500008.china.huawei.com (7.182.85.71) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 5/1/2023 12:29 PM, Mike Lothian wrote:
> Hi
> 
> I've not had any issues since using this, but I imagine most people
> won't know how to set swiotlb=dynamic if they start seeing this (when
> it lands)
> 
> Any clue as to why this broke last cycle?

IIRC the kernel messages indicate high swiotlb utilization. The most
likely cause is that either the wifi driver is using more DMA buffers at
once, or another device driver is now using swiotlb; it could also be a
driver for a device that was previously not supported.

If you're adventurous, you can use ftrace to capture the backtraces of
swiotlb_tbl_map_single. This would reveal the other driver. Debugging
increased DMA buffer usage by your wifi driver may be more difficult,
because that's a dynamic process, which may change dramatically if you
add some sort of tracing into the picture... As always, YMMV.

Petr T

> Mike
> 
> On Fri, 28 Apr 2023 at 10:07, Petr Tesařík <petr@tesarici.cz> wrote:
>>
>> On Fri, 28 Apr 2023 09:53:38 +0100
>> Mike Lothian <mike@fireburn.co.uk> wrote:
>>
>>> On Wed, 19 Apr 2023 at 11:05, Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>>>>
>>>> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>>>>
>>>> The goal of my work is to provide more flexibility in the sizing of
>>>> SWIOTLB.
>>>>
>>>> The software IO TLB was designed with these assumptions:
>>>>
>>>> 1. It would not be used much, especially on 64-bit systems.
>>>> 2. A small fixed memory area (64 MiB by default) is sufficient to
>>>>    handle the few cases which require a bounce buffer.
>>>> 3. 64 MiB is little enough that it has no impact on the rest of the
>>>>    system.
>>>>
>>>> First, if SEV is active, all DMA must be done through shared
>>>> unencrypted pages, and SWIOTLB is used to make this happen without
>>>> changing device drivers. The software IO TLB size is increased to
>>>> 6% of total memory in sev_setup_arch(), but that is more of an
>>>> approximation. The actual requirements may vary depending on the
>>>> amount of I/O and which drivers are used. These factors may not be
>>>> know at boot time, i.e. when SWIOTLB is allocated.
>>>>
>>>> Second, other colleagues have noticed that they can reliably get
>>>> rid of occasional OOM kills on an Arm embedded device by reducing
>>>> the SWIOTLB size. This can be achieved with a kernel parameter, but
>>>> determining the right value puts additional burden on pre-release
>>>> testing, which could be avoided if SWIOTLB is allocated small and
>>>> grows only when necessary.
>>>>
>>>> Changes from v1-devel-v7:
>>>> - Add comments to acquire/release barriers
>>>> - Fix whitespace issues reported by checkpatch.pl
>>>>
>>>> Changes from v1-devel-v6:
>>>> - Provide long description of functions
>>>> - Fix kernel-doc (Returns: to Return:)
>>>> - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
>>>>
>>>> Changes from RFC:
>>>> - Track dynamic buffers per device instead of per swiotlb
>>>> - Use a linked list instead of a maple tree
>>>> - Move initialization of swiotlb fields of struct device to a
>>>>   helper function
>>>> - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
>>>> - Introduce per-device flag if dynamic buffers are in use
>>>> - Add one more user of DMA_ATTR_MAY_SLEEP
>>>> - Add kernel-doc comments for new (and some old) code
>>>> - Properly escape '*' in dma-attributes.rst
>>>>
>>>> Petr Tesarik (7):
>>>>   swiotlb: Use a helper to initialize swiotlb fields in struct device
>>>>   swiotlb: Move code around in preparation for dynamic bounce buffers
>>>>   dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
>>>>   swiotlb: Dynamically allocated bounce buffers
>>>>   swiotlb: Add a boot option to enable dynamic bounce buffers
>>>>   drm: Use DMA_ATTR_MAY_SLEEP from process context
>>>>   swiotlb: per-device flag if there are dynamically allocated buffers
>>>>
>>>>  .../admin-guide/kernel-parameters.txt         |   6 +-
>>>>  Documentation/core-api/dma-attributes.rst     |  10 +
>>>>  drivers/base/core.c                           |   4 +-
>>>>  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +-
>>>>  drivers/gpu/drm/drm_prime.c                   |   2 +-
>>>>  include/linux/device.h                        |  12 +
>>>>  include/linux/dma-mapping.h                   |   6 +
>>>>  include/linux/swiotlb.h                       |  54 ++-
>>>>  kernel/dma/swiotlb.c                          | 382 ++++++++++++++++--
>>>>  9 files changed, 443 insertions(+), 35 deletions(-)
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>
>>> Hi
>>>
>>> Is this a potential fix for
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217310 where I'm manually
>>> setting bigger buffers to keep my wifi working?
>>
>> Yes. With these patches applied, your system should run just fine with
>> swiotlb=dynamic. However, keep in mind that this implementation adds a
>> bit of overhead. In short, it trades a bit of performance for not
>> having to figure out the optimal swiotlb size at boot time.
>>
>> Petr T

