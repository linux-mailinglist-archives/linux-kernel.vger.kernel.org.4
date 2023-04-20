Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE66E8E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjDTJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjDTJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:32:00 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C780EC;
        Thu, 20 Apr 2023 02:31:55 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:56974.1250087080
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 4E51C1002B4;
        Thu, 20 Apr 2023 17:31:51 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-tj646 with ESMTP id db2361bde83742feb3b08477f980b596 for geert@linux-m68k.org;
        Thu, 20 Apr 2023 17:31:54 CST
X-Transaction-ID: db2361bde83742feb3b08477f980b596
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <3e80d3b3-6c9a-33e6-a768-645be1c68404@189.cn>
Date:   Thu, 20 Apr 2023 17:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] drm/fbdev-generic: prohibit potential out-of-bounds
 access
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230420030500.1578756-1-suijingfeng@loongson.cn>
 <CAMuHMdUZoBZEM73fo8-PitSae8wgv-m6sez3nA8J3RFMAtOyOQ@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CAMuHMdUZoBZEM73fo8-PitSae8wgv-m6sez3nA8J3RFMAtOyOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/20 17:04, Geert Uytterhoeven wrote:
> Hi Sui,
>
> On Thu, Apr 20, 2023 at 5:09 AM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> The fbdev test of IGT may write after EOF, which lead to out-of-bound
>> access for drm drivers hire fbdev-generic. For example, run fbdev test
>> on a x86+ast2400 platform, with 1680x1050 resolution, will cause the
>> linux kernel hang with the following call trace:
>>
>>    Oops: 0000 [#1] PREEMPT SMP PTI
>>    [IGT] fbdev: starting subtest eof
>>    Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
>>    [IGT] fbdev: starting subtest nullptr
>>
>>    RIP: 0010:memcpy_erms+0xa/0x20
>>    RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
>>    RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
>>    RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
>>    RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
>>    R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
>>    R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
>>    FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
>>    Call Trace:
>>     <TASK>
>>     ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
>>     drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
>>     process_one_work+0x21f/0x430
>>     worker_thread+0x4e/0x3c0
>>     ? __pfx_worker_thread+0x10/0x10
>>     kthread+0xf4/0x120
>>     ? __pfx_kthread+0x10/0x10
>>     ret_from_fork+0x2c/0x50
>>     </TASK>
>>    CR2: ffffa17d40e0b000
>>    ---[ end trace 0000000000000000 ]---
>>
>> The is because damage rectangles computed by
>> drm_fb_helper_memory_range_to_clip() function does not guaranteed to be
>> bound in the screen's active display area. Possible reasons are:
>>
>> 1) Buffers are allocated in the granularity of page size, for mmap system
>>     call support. The shadow screen buffer consumed by fbdev emulation may
>>     also choosed be page size aligned.
>>
>> 2) The DIV_ROUND_UP() used in drm_fb_helper_memory_range_to_clip()
>>     will introduce off-by-one error.
>>
>> For example, on a 16KB page size system, in order to store a 1920x1080
>> XRGB framebuffer, we need allocate 507 pages. Unfortunately, the size
>> 1920*1080*4 can not be divided exactly by 16KB.
>>
>>   1920 * 1080 * 4 = 8294400 bytes
>>   506 * 16 * 1024 = 8290304 bytes
>>   507 * 16 * 1024 = 8306688 bytes
>>
>>   line_length = 1920*4 = 7680 bytes
>>
>>   507 * 16 * 1024 / 7680 = 1081.6
>>
>>   off / line_length = 507 * 16 * 1024 / 7680 = 1081
>>   DIV_ROUND_UP(507 * 16 * 1024, 7680) will yeild 1082
>>
>> memcpy_toio() typically issue the copy line by line, when copy the last
>> line, out-of-bound access will be happen. Because:
>>
>>   1082 * line_length = 1082 * 7680 = 8309760, and 8309760 > 8306688
>>
>> Note that userspace may stil write to the invisiable area if a larger
>> buffer than width x stride is exposed. But it is not a big issue as
>> long as there still have memory resolve the access if not drafting so
>> far.
>>
>>   - Also limit the y1 (Daniel)
>>   - keep fix patch it to minimal (Daniel)
>>   - screen_size is page size aligned because of it need mmap (Thomas)
>>   - Adding fixes tag (Thomas)
>>
>> Fixes: aa15c677cc34 ("drm/fb-helper: Fix vertical damage clipping")
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Thanks for the update!  This v5 is completely different from the v3
> I tested before, so keeping my Tested-by is not really appropriate...
Indeed, I will be carefully next time.
> I have retested fbtest with shmob-drm on Armadillo-800-EVA
> (800x480@RG16, i.e. 187.5 pages), and fortunately this version still
> works fine, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Thanks a lot.
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
