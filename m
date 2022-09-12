Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D305B5F84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiILRt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiILRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:49:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516C13D17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:49:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3454e58fe53so110711797b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=jWgkwgfBD1+tHUCOkIKFWyMLrIoFRnNCeVp68JF8lTw=;
        b=BUVPATAqZawD6Ha5mbfzj2LDvZFprW9spaYMcRAshkEpDRXnp0WO3Qp/lx+FLXAocl
         r0NlcKtfir336riLHmWi7kPaAtVuF6yAqveDECKJrhBDEdgqJ5CQaC/HkE8R1OMMzOcc
         Hjrhp6B34bS5/o2eT7hgcOVOLnoc1aGtgY0DX6jI10Vxdrb3SPhWj1EPNjVp5ss2dZTi
         xk4UNstZeyimE1WQj61VDmAw8RDAXmdSHB0HmCSYLNpH2lQbC4OcXR9guPh8DM8eQwz9
         jmFJe5Hg6o+8OuOm0FW9GpIrik9yN+sotk+eDuSwZmNsRtNuqyM3IbJ+FqvLSonZX7ch
         IHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jWgkwgfBD1+tHUCOkIKFWyMLrIoFRnNCeVp68JF8lTw=;
        b=LdZqf4TPKn5htZSXccqPUyJi8Sdew65tBM2ITa3oY4Q9rG5eo4aKCP9ZQ2eqzNWFzY
         TWDJUoGEz3MOkLbModQcDF4+iRjYT+ASNAe0WhOjxuAjMYkLI9czZhfdeo9ohSXddU8V
         z+fk96KfmKQVpRU6ZYqTvD5/7yjfGSlGvBfWkpqHGEwyLYPG0T+0/maSeaS2zzM8MX68
         OZclBw7ezjGr33x3gBH/934hjCkRj3VoIb1+n33VeCpX0D13cXphdJSTtLNaAtXJTTRg
         rgsFm6AuVYKg+9KMDTEJ5f8WjhKgsc2p5Ir2gDTiBK/PfWls3nwH2NctSdeTZIET69FI
         dx1w==
X-Gm-Message-State: ACgBeo1DhR3F8y/sK5rE6S4peUvmaYcpOpVCi+QcSZpZsyi82EBoa3ST
        IwRVmHpmg9Yx+oo9TY2dRed58A5i2txEbzaJP6zNrGmLTEE=
X-Google-Smtp-Source: AA6agR4ToJGdZDWJQc0dNFkx/4YlVB7nnr3hnS8aYKVz1xUs2QQ23S3v2xlSRwhhYNYiW2uzJgjfVqWVf4b+si1Joo8=
X-Received: by 2002:a0d:fb86:0:b0:335:cdab:1a58 with SMTP id
 l128-20020a0dfb86000000b00335cdab1a58mr22641009ywf.270.1663004991520; Mon, 12
 Sep 2022 10:49:51 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 13 Sep 2022 01:49:40 +0800
Message-ID: <CAFcO6XOSwwe+4H5cCEdgj6KD+QutNMZA89rWXYvbQCsREqFqtQ@mail.gmail.com>
Subject: A divide error bug in framebuffer_check
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there is a divide error bug in framebuffer_check in
drivers/gpu/drm/drm_framebuffer.c in the latest kernel.
we can trigger it via drm_mode_addfb2 IOCTL.
The call trace is drm_mode_addfb2 -> drm_internal_framebuffer_create
->  framebuffer_check.
let us see code below:
```
static int framebuffer_check(struct drm_device *dev,
     const struct drm_mode_fb_cmd2 *r)
{
const struct drm_format_info *info;
int i;

/* check if the format is supported at all */
if (!__drm_format_info(r->pixel_format)) {
DRM_DEBUG_KMS("bad framebuffer format %p4cc\n",
      &r->pixel_format);
return -EINVAL;
}

if (r->width == 0) {
DRM_DEBUG_KMS("bad framebuffer width %u\n", r->width);
return -EINVAL;
}

if (r->height == 0) {
DRM_DEBUG_KMS("bad framebuffer height %u\n", r->height);
return -EINVAL;
}

/* now let the driver pick its own format info */
info = drm_get_format_info(dev, r);   //// [1] get info data

for (i = 0; i < info->num_planes; i++) {
unsigned int width = fb_plane_width(r->width, info, i);   ///  [2]
unsigned int height = fb_plane_height(r->height, info, i); /// [3]
unsigned int block_size = info->char_per_block[i];
u64 min_pitch = drm_format_info_min_pitch(info, i, width);
 ......
```
the drm_get_format_info gets info data and would call
__drm_format_info.see code below:
__drm_format_info
````
const struct drm_format_info *__drm_format_info(u32 format)
{
static const struct drm_format_info formats[] = {
 .....
{ .format = DRM_FORMAT_Q410, .depth = 0,
  .num_planes = 3, .char_per_block = { 2, 2, 2 },
  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
  .vsub = 0, .is_yuv = true },
{ .format = DRM_FORMAT_Q401, .depth = 0,
  .num_planes = 3, .char_per_block = { 2, 2, 2 },
  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
  .vsub = 0, .is_yuv = true },
......
}
unsigned int i;

for (i = 0; i < ARRAY_SIZE(formats); ++i) {
if (formats[i].format == format)
return &formats[i];
}

return NULL;
}
```
It would return a defined format.if format is that:
```
{ .format = DRM_FORMAT_Q410, .depth = 0,
  .num_planes = 3, .char_per_block = { 2, 2, 2 },
  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
  .vsub = 0, .is_yuv = true },
{ .format = DRM_FORMAT_Q401, .depth = 0,
  .num_planes = 3, .char_per_block = { 2, 2, 2 },
  .block_w = { 1, 1, 1 }, .block_h = { 1, 1, 1 }, .hsub = 0,
  .vsub = 0, .is_yuv = true },
```
we can see format.hsub and format.vsub all are NULL.

[2] and [3], the fb_plane_width/height would process  info data, see
fb_plane_width code below:
```
static int fb_plane_width(int width,
  const struct drm_format_info *format, int plane)
{
if (plane == 0)
return width;

return DIV_ROUND_UP(width, format->hsub); //// [4]
}
```
[4] it would call DIV_ROUND_UP, but format->hsub is NULL.

##crash log
[  211.845762][ T4677] divide error: 0000 [#1] PREEMPT SMP
[  211.846194][ T4677] CPU: 1 PID: 4677 Comm: drm_internal_fr Not
tainted 6.0.0-rc5 #15
[  211.846732][ T4677] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  211.847396][ T4677] RIP: 0010:drm_internal_framebuffer_create+0x151/0x6a0
[  211.847896][ T4677] Code: 00 0f b6 53 05 41 83 c5 01 41 39 d5 0f 8d
10 02 00 00 45 85 ed 45 8b 7c 24 04 0f 84 6b 01 00 00 0f b6 4b 12 41
8d 44 0f ff 99 <f7> f9 0f b1
[  211.849390][ T4677] RSP: 0018:ffffc9000aaafd18 EFLAGS: 00010202
[  211.849800][ T4677] RAX: 000000000000001e RBX: ffffffff83841768
RCX: 0000000000000000
[  211.850305][ T4677] RDX: 0000000000000000 RSI: 00000000ffffffff
RDI: 00000000ffffffff
[  211.850814][ T4677] RBP: 0000000000000000 R08: 0000000000000000
R09: 0000000000000002
[  211.851310][ T4677] R10: 0000000000000054 R11: 000000000007e2a0
R12: ffffc9000aaafe50
[  211.851810][ T4677] R13: 0000000000000001 R14: 0000000000001808
R15: 000000000000001f
[  211.852307][ T4677] FS:  0000000000dd7880(0000)
GS:ffff88807ec00000(0000) knlGS:0000000000000000
[  211.852885][ T4677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  211.853277][ T4677] CR2: 0000000020000000 CR3: 0000000047fba000
CR4: 00000000000006e0
[  211.853783][ T4677] Call Trace:
[  211.854027][ T4677]  <TASK>
[  211.854244][ T4677]  ? find_held_lock+0x2b/0x80
[  211.854538][ T4677]  drm_mode_addfb2+0x2f/0xd0
[  211.854835][ T4677]  ? drm_mode_addfb_ioctl+0x10/0x10
[  211.855210][ T4677]  drm_ioctl_kernel+0xac/0x140
[  211.855501][ T4677]  drm_ioctl+0x21f/0x3e0
[  211.855753][ T4677]  ? drm_mode_addfb_ioctl+0x10/0x10
[  211.856058][ T4677]  __x64_sys_ioctl+0x7b/0xb0
[  211.856388][ T4677]  do_syscall_64+0x35/0xb0
[  211.856662][ T4677]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  211.857018][ T4677] RIP: 0033:0x44dcbd
[  211.857286][ T4677] Code: 28 c3 e8 36 29 00 00 66 0f 1f 44 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f8
[  211.858603][ T4677] RSP: 002b:00007ffeee92f738 EFLAGS: 00000213
ORIG_RAX: 0000000000000010
[  211.859179][ T4677] RAX: ffffffffffffffda RBX: 0000000000400530
RCX: 000000000044dcbd
[  211.859705][ T4677] RDX: 0000000020000000 RSI: 00000000c06864b8
RDI: 0000000000000003
[  211.860211][ T4677] RBP: 00007ffeee92f750 R08: 0000000000000000
R09: 0000000000000000
[  211.860708][ T4677] R10: 000000000000ffff R11: 0000000000000213
R12: 0000000000403120
[  211.861206][ T4677] R13: 0000000000000000 R14: 00000000004c5018
R15: 0000000000000000


Regards,
 butt3rflyh4ck.


-- 
Active Defense Lab of Venustech
