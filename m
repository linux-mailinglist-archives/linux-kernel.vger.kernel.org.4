Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476066E36A9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDPJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjDPJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:38:12 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14F3A198C;
        Sun, 16 Apr 2023 02:38:09 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:47894.353085718
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id F3817100248;
        Sun, 16 Apr 2023 17:38:04 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-ljp89 with ESMTP id c890ea7692304bfab0ddaf902e6dec90 for tzimmermann@suse.de;
        Sun, 16 Apr 2023 17:38:06 CST
X-Transaction-ID: c890ea7692304bfab0ddaf902e6dec90
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <3bbaf3a3-d7dc-d6ad-f2bb-f58899793f98@189.cn>
Date:   Sun, 16 Apr 2023 17:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/fbdev-generic: prohibit potential out-of-bounds
 access
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230413180622.1014016-1-15330273260@189.cn>
 <fccc494f-0e52-5fdf-0e40-acc29177c73c@suse.de>
 <32a1510e-d38a-ffb6-8e8d-026f8b3aa17a@189.cn>
 <ZDuqYp0RW9SngQ2H@phenom.ffwll.local>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <ZDuqYp0RW9SngQ2H@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/16 15:57, Daniel Vetter wrote:
> On Fri, Apr 14, 2023 at 06:58:53PM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2023/4/14 03:16, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> thanks for the patch. This is effectively a revert of commit
>>> 8fbc9af55de0 ("drm/fbdev-generic: Set screen size to size of GEM
>>> buffer"). Please add a Fixes tag.
>>>
>>> Am 13.04.23 um 20:06 schrieb Sui Jingfeng:
>>>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>>>
>>>> The crazy fbdev test of IGT may write after EOF, which lead to
>>>> out-of-bound
>>> Please drop 'crazy'. :)
>> This is OK.
>>
>> By using the world 'crazy',
>>
>> I meant that the test is very good and maybe it is written by professional
>> peoples
>>
>> with the guidance by  experienced  engineer. So that even the corner get
>> tested.
> 'thoroughly' would be better word to describe that I think.
>
> I think for the other discussions I've covered it all already in the other
> thread.
> -Daniel
>
Yes, 'thoroughly' is a definitely better word than 'crazy'.


I see your reviews in v1 the thread of this patch,  I will resend this 
patch with updates.

But I thinks we should wait Thomas Z. for a while.

I'm wondering whether he still have some strong feelings toward this, I 
guess not.

thanks, :-)

>>
>>>> access for the drm drivers using fbdev-generic. For example, run
>>>> fbdev test
>>>> on a x86-64+ast2400 platform with 1680x1050 resolution will cause
>>>> the linux
>>>> kernel hang with following call trace:
>>>>
>>>>     Oops: 0000 [#1] PREEMPT SMP PTI
>>>>     [IGT] fbdev: starting subtest eof
>>>>     Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
>>>>     [IGT] fbdev: starting subtest nullptr
>>>>
>>>>     RIP: 0010:memcpy_erms+0xa/0x20
>>>>     RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
>>>>     RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
>>>>     RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
>>>>     RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
>>>>     R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
>>>>     R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
>>>>     FS:  0000000000000000(0000) GS:ffff895257380000(0000)
>>>> knlGS:0000000000000000
>>>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>     CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
>>>>     Call Trace:
>>>>      <TASK>
>>>>      ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
>>>>      drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
>>>>      process_one_work+0x21f/0x430
>>>>      worker_thread+0x4e/0x3c0
>>>>      ? __pfx_worker_thread+0x10/0x10
>>>>      kthread+0xf4/0x120
>>>>      ? __pfx_kthread+0x10/0x10
>>>>      ret_from_fork+0x2c/0x50
>>>>      </TASK>
>>>>     CR2: ffffa17d40e0b000
>>>>     ---[ end trace 0000000000000000 ]---
>>>>
>>>> The indirect reason is drm_fb_helper_memory_range_to_clip() generate
>>>> damage
>>>> rectangles which partially or completely go out of the active
>>>> display area.
>>>> The second of argument 'off' is passing from the user-space, this
>>>> will lead
>>>> to the out-of-bound if it is large than (fb_height + 1) *
>>>> fb_pitches; while
>>>> DIV_ROUND_UP() may also controbute to error by 1.
>>>>
>>>> This patch will add code to restrict the damage rect computed go
>>>> beyond of
>>>> the last line of the framebuffer.
>>>>
>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>>> ---
>>>>    drivers/gpu/drm/drm_fb_helper.c     | 16 ++++++++++++----
>>>>    drivers/gpu/drm/drm_fbdev_generic.c |  2 +-
>>>>    2 files changed, 13 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c
>>>> b/drivers/gpu/drm/drm_fb_helper.c
>>>> index 64458982be40..6bb1b8b27d7a 100644
>>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>>>> @@ -641,19 +641,27 @@ static void drm_fb_helper_damage(struct
>>>> drm_fb_helper *helper, u32 x, u32 y,
>>>>    static void drm_fb_helper_memory_range_to_clip(struct fb_info
>>>> *info, off_t off, size_t len,
>>>>                               struct drm_rect *clip)
>>>>    {
>>>> +    u32 line_length = info->fix.line_length;
>>>> +    u32 fb_height = info->var.yres;
>>>>        off_t end = off + len;
>>>>        u32 x1 = 0;
>>>> -    u32 y1 = off / info->fix.line_length;
>>>> +    u32 y1 = off / line_length;
>>>>        u32 x2 = info->var.xres;
>>>> -    u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
>>>> +    u32 y2 = DIV_ROUND_UP(end, line_length);
>>>> +
>>>> +    /* Don't allow any of them beyond the bottom bound of display
>>>> area */
>>>> +    if (y1 > fb_height)
>>>> +        y1 = fb_height;
>>>> +    if (y2 > fb_height)
>>>> +        y2 = fb_height;
>>>>          if ((y2 - y1) == 1) {
>>>>            /*
>>>>             * We've only written to a single scanline. Try to reduce
>>>>             * the number of horizontal pixels that need an update.
>>>>             */
>>>> -        off_t bit_off = (off % info->fix.line_length) * 8;
>>>> -        off_t bit_end = (end % info->fix.line_length) * 8;
>>>> +        off_t bit_off = (off % line_length) * 8;
>>>> +        off_t bit_end = (end % line_length) * 8;
>>> Please scratch all these changes. The current code should work as
>>> intended. Only the generic fbdev emulation uses this code and it should
>>> really be moved there at some point.
>>
>> Are you meant  that we should remove all these changes in
>> drivers/gpu/drm/drm_fb_helper.c ?
>>
>>
>> But this changes are helps to prevent the damage box computed go out of
>> bound,
>>
>> the bound of the displayable shadow buffer on multiple display case.
>>
>> It is the minimum width x height which could be fit in for all
>> display/minotor.
>>
>>
>> For example, one is 1920x1080 monitor, another is 1280x800 monitor.
>>
>> connected to the motherboard simultaneously.
>>
>>
>> Then, 1920x1080x4 (suppose we are using the XRGB) scanout buffer will be
>>
>> allocate by the  GEM backend. But the the actual display area is 1280x800.
>>
>> This is true at least for my driver on my platform, In this case,
>>
>> ```
>>
>>     info->var.xres ==1280;
>>
>>     info->var.yres == 800;
>>
>> ```
>>
>> If don't restrict this, the damage box computed out of the bound of  (0, 0)
>> ~ (1280, 800) rectangle.
>>
>> a 1920x1080 damage box will came out.
>>
>>
>> When running fbdev test of IGT, the smaller screen display will be OK.
>>
>> but the larger screen, the area outsize of 1280x800 will also be written.
>>
>> The background color became completely white from completely black before
>> carry out the test,
>>
>> luckily, linux kernel do not hung, this time.
>>
>>
>> On multi-screen case, we still need to restrict the damage box computed,
>>
>> Do not go out of 1280x800,  right?
>>
>>
>>>>              x1 = bit_off / info->var.bits_per_pixel;
>>>>            x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
>>>> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c
>>>> b/drivers/gpu/drm/drm_fbdev_generic.c
>>>> index 8e5148bf40bb..b057cfbba938 100644
>>>> --- a/drivers/gpu/drm/drm_fbdev_generic.c
>>>> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>>>> @@ -94,7 +94,7 @@ static int
>>>> drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>>>>        fb_helper->buffer = buffer;
>>>>        fb_helper->fb = buffer->fb;
>>>>    -    screen_size = buffer->gem->size;
>>>> +    screen_size = sizes->surface_height * buffer->fb->pitches[0];
>>> I guess we simply go back to this line. I'd R-b a patch that does
>>> exactly this.
>>>
>>> But some explanation is in order. Maybe you can add this as a comment to
>>> the computation, as it's not obvious:
>>>
>>> The value of screen_size should actually be the size of the gem buffer.
>>> In a physical framebuffer (i.e., video memory), the size would be a
>>> multiple of the page size, but not necessarily a multiple of the screen
>>> resolution. There are also pan fbdev's operations, and we could possibly
>>> use DRM buffers that are not multiples of the screen width. But the
>>> update code requires the use of drm_framebuffer_funcs.dirty, which takes
>>> a clipping rectangle and therefore doesn't work well with these odd
>>> values for screen_size.
>>>
>>> Best regards
>>> Thomas
>>>
>>>>        screen_buffer = vzalloc(screen_size);
>>>>        if (!screen_buffer) {
>>>>            ret = -ENOMEM;
