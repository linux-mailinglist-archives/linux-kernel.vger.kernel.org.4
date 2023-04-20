Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297296E902D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjDTK14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjDTK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:27:20 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 607D51724;
        Thu, 20 Apr 2023 03:26:12 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:58840.974464883
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id F176E1001A9;
        Thu, 20 Apr 2023 18:26:07 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-bkw2h with ESMTP id d33a56f28d0d407a8e99f4579a587bba for tzimmermann@suse.de;
        Thu, 20 Apr 2023 18:26:10 CST
X-Transaction-ID: d33a56f28d0d407a8e99f4579a587bba
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <3cf7b510-6257-d6ec-3280-b63e2ddf1f3c@189.cn>
Date:   Thu, 20 Apr 2023 18:26:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] drm/fbdev-generic: prohibit potential out-of-bounds
 access
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yi <liyi@loongson.cn>, Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     loongson-kernel@lists.loongnix.cn, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230420030500.1578756-1-suijingfeng@loongson.cn>
 <8ec3734b-4bc2-ad8f-fc17-3002f22d1fc9@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <8ec3734b-4bc2-ad8f-fc17-3002f22d1fc9@suse.de>
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

On 2023/4/20 15:04, Thomas Zimmermann wrote:
> Hi,
>
> this patch looks to me good and I'd like to merge it, if no one objects.
>
> In the near future, after i915 has switched to struct drm_client, I 
> intend to move DRM's deferred-I/O helpers into fbdev-generic and i915. 


That sound fine,  I can help to test then.

But I think,  it may better to make it a 100% DRM function?


> Those are the two users, but they are fairly different. They can then 
> both have something tailored towards their needs.
>
> Best regards
> Thomas
>
> Am 20.04.23 um 05:05 schrieb Sui Jingfeng:
>> The fbdev test of IGT may write after EOF, which lead to out-of-bound
>> access for drm drivers hire fbdev-generic. For example, run fbdev test
>> on a x86+ast2400 platform, with 1680x1050 resolution, will cause the
>> linux kernel hang with the following call trace:
>>
>>    Oops: 0000 [#1] PREEMPT SMP PTI
>>    [IGT] fbdev: starting subtest eof
>>    Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
>>    [IGT] fbdev: starting subtest nullptr
>>
>>    RIP: 0010:memcpy_erms+0xa/0x20
>>    RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
>>    RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
>>    RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
>>    RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
>>    R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
>>    R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
>>    FS:  0000000000000000(0000) GS:ffff895257380000(0000) 
>> knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
>>    Call Trace:
>>     <TASK>
>>     ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
>>     drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
>>     process_one_work+0x21f/0x430
>>     worker_thread+0x4e/0x3c0
>>     ? __pfx_worker_thread+0x10/0x10
>>     kthread+0xf4/0x120
>>     ? __pfx_kthread+0x10/0x10
>>     ret_from_fork+0x2c/0x50
>>     </TASK>
>>    CR2: ffffa17d40e0b000
>>    ---[ end trace 0000000000000000 ]---
>>
>> The is because damage rectangles computed by
>> drm_fb_helper_memory_range_to_clip() function does not guaranteed to be
>> bound in the screen's active display area. Possible reasons are:
>>
>> 1) Buffers are allocated in the granularity of page size, for mmap 
>> system
>>     call support. The shadow screen buffer consumed by fbdev 
>> emulation may
>>     also choosed be page size aligned.
>>
>> 2) The DIV_ROUND_UP() used in drm_fb_helper_memory_range_to_clip()
>>     will introduce off-by-one error.
>>
>> For example, on a 16KB page size system, in order to store a 1920x1080
>> XRGB framebuffer, we need allocate 507 pages. Unfortunately, the size
>> 1920*1080*4 can not be divided exactly by 16KB.
>>
>>   1920 * 1080 * 4 = 8294400 bytes
>>   506 * 16 * 1024 = 8290304 bytes
>>   507 * 16 * 1024 = 8306688 bytes
>>
>>   line_length = 1920*4 = 7680 bytes
>>
>>   507 * 16 * 1024 / 7680 = 1081.6
>>
>>   off / line_length = 507 * 16 * 1024 / 7680 = 1081
>>   DIV_ROUND_UP(507 * 16 * 1024, 7680) will yeild 1082
>>
>> memcpy_toio() typically issue the copy line by line, when copy the last
>> line, out-of-bound access will be happen. Because:
>>
>>   1082 * line_length = 1082 * 7680 = 8309760, and 8309760 > 8306688
>>
>> Note that userspace may stil write to the invisiable area if a larger
>> buffer than width x stride is exposed. But it is not a big issue as
>> long as there still have memory resolve the access if not drafting so
>> far.
>>
>>   - Also limit the y1 (Daniel)
>>   - keep fix patch it to minimal (Daniel)
>>   - screen_size is page size aligned because of it need mmap (Thomas)
>>   - Adding fixes tag (Thomas)
>>
>> Fixes: aa15c677cc34 ("drm/fb-helper: Fix vertical damage clipping")
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Link: 
>> https://lore.kernel.org/dri-devel/ad44df29-3241-0d9e-e708-b0338bf3c623@189.cn/
>> ---
>>   drivers/gpu/drm/drm_fb_helper.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c 
>> b/drivers/gpu/drm/drm_fb_helper.c
>> index 64458982be40..6bb1b8b27d7a 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -641,19 +641,27 @@ static void drm_fb_helper_damage(struct 
>> drm_fb_helper *helper, u32 x, u32 y,
>>   static void drm_fb_helper_memory_range_to_clip(struct fb_info 
>> *info, off_t off, size_t len,
>>                              struct drm_rect *clip)
>>   {
>> +    u32 line_length = info->fix.line_length;
>> +    u32 fb_height = info->var.yres;
>>       off_t end = off + len;
>>       u32 x1 = 0;
>> -    u32 y1 = off / info->fix.line_length;
>> +    u32 y1 = off / line_length;
>>       u32 x2 = info->var.xres;
>> -    u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
>> +    u32 y2 = DIV_ROUND_UP(end, line_length);
>> +
>> +    /* Don't allow any of them beyond the bottom bound of display 
>> area */
>> +    if (y1 > fb_height)
>> +        y1 = fb_height;
>> +    if (y2 > fb_height)
>> +        y2 = fb_height;
>>         if ((y2 - y1) == 1) {
>>           /*
>>            * We've only written to a single scanline. Try to reduce
>>            * the number of horizontal pixels that need an update.
>>            */
>> -        off_t bit_off = (off % info->fix.line_length) * 8;
>> -        off_t bit_end = (end % info->fix.line_length) * 8;
>> +        off_t bit_off = (off % line_length) * 8;
>> +        off_t bit_end = (end % line_length) * 8;
>>             x1 = bit_off / info->var.bits_per_pixel;
>>           x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
>
