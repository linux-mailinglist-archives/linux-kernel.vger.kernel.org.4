Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72D65FD46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjAFJEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjAFJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:04:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8368C93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:04:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d17so702539wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oh+tO4VAYKsBsuVwmWetnQdvzWD6pRcTuec9yQCMBE=;
        b=VcaBOgij5Nk7bOXAUDlWpO3pECWUZyZWpSZ9DBn9QmP8brgHn/moTN+rNHmuO6cOtC
         asHTEQw18D4FXFnaijCwcAt7eYm/Kh2f4vnvOhoSe5bCickgXh6TdjnkDr+bByGv+i1w
         H24kaMd/bbmMxayX/wnQyntJY1KG+9uUD+jnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oh+tO4VAYKsBsuVwmWetnQdvzWD6pRcTuec9yQCMBE=;
        b=MMAyo2nVJNb7rFKu6frsSG3GrlL/eS9i498rrqEWo9JIcRtsodNyu463RKB1XoLoMn
         u3Qh8cVsVlgoKwdeAs6TBF91zlJxUHJH+nAVFFXhNBuhIw25bxU28jQwvEuVf//ZiLBy
         9ve38o4Cx/whfdEEWfcrFtyP49yeYLYj9RIbgmkYG1i3Hvs6Jy7lZeF9/wcwbEi79lPb
         fTqsocBS7rELxN1tVPsjZxrHFJ39bbIzsfaEZods56hTPop7dhmWu5GTG1iJrLKPd5W5
         i8oJv1O1BEE/dWcX/8dmXEQ7uqSwqytZimm/Z8ViaLyfr0YHa4pZgccRTgjS/mMfBQY4
         Aa0A==
X-Gm-Message-State: AFqh2krcU3DRnX3qEiRBbaEU57Z0G+6G8j2LxL9xQp88sqawDvJP/rGH
        qq7PanUUQcabcmsy9JAmX+21Bg==
X-Google-Smtp-Source: AMrXdXsF6r0whrWtJmT10SJbfExjNBDHpWpevEeXU/qX5vrGPfkbuLARTKy9wemqwWZrlmIvuLuqHw==
X-Received: by 2002:a5d:48c6:0:b0:242:844a:835d with SMTP id p6-20020a5d48c6000000b00242844a835dmr30521789wrs.65.1672995876891;
        Fri, 06 Jan 2023 01:04:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b002549b649b62sm569112wrq.50.2023.01.06.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 01:04:36 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:04:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Set preferred depth.
Message-ID: <Y7fkIvBRHcsgHR0l@phenom.ffwll.local>
Mail-Followup-To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230106071609.3948-1-steev@kali.org>
 <f52cca60-ab6a-460a-65f9-367c083b51fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52cca60-ab6a-460a-65f9-367c083b51fa@linaro.org>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 09:18:21AM +0200, Dmitry Baryshkov wrote:
> On 06/01/2023 09:16, Steev Klimaszewski wrote:
> > As of commit 37c90d589dc0 ("drm/fb-helper: Fix single-probe color-format
> > selection"), if no supported color formats are found, it tries to use the
> > driver provided default, which msm didn't have set and leads to the
> > following output:
> > 
> > msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> > msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> > msm_dpu ae01000.display-controller: [drm] bpp/depth value of 32/0 not supported
> > msm_dpu ae01000.display-controller: [drm] No compatible format found
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 73 at drivers/gpu/drm/drm_atomic.c:1604 __drm_atomic_helper_set_config+0x240/0x33c
> > Modules linked in: ext4 mbcache jbd2 msm mdt_loader ocmem gpu_sched llcc_qcom gpio_keys qrtr
> > CPU: 0 PID: 73 Comm: kworker/u16:2 Not tainted 6.2.0-rc2-next-20230106 #53
> > Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET74W (1.46 ) 10/12/2022
> > Workqueue: events_unbound deferred_probe_work_func
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : __drm_atomic_helper_set_config+0x240/0x33c
> > lr : __drm_atomic_helper_set_config+0x68/0x33c
> > sp : ffff800008a7b790
> > x29: ffff800008a7b790 x28: ffff73ee3e130a00 x27: 0000000000000000
> > x26: ffff73ee3d256e00 x25: 0000000000000038 x24: ffff73e6c0d65e00
> > x23: ffff73e6c17a7800 x22: ffff73e6c0d64e00 x21: ffff73e79c025e00
> > x20: 00000000c0d64e00 x19: ffff73ee3e130a00 x18: ffffffffffffffff
> > x17: 662074616d726f66 x16: 20656c6269746170 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa829144ff8bc
> > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : ffff73e6c0d65f50 x4 : ffff73ee3d254950 x3 : ffff73e6c0d65ec0
> > x2 : ffff73ee3c953a00 x1 : ffff73e79c025580 x0 : 0000000000000000
> > Call trace:
> > __drm_atomic_helper_set_config+0x240/0x33c
> > drm_client_modeset_commit_atomic+0x160/0x280
> > drm_client_modeset_commit_locked+0x64/0x194
> > drm_client_modeset_commit+0x38/0x60
> > __drm_fb_helper_initial_config_and_unlock+0x528/0x63c
> > drm_fb_helper_initial_config+0x54/0x64
> > msm_fbdev_init+0x94/0xfc [msm]
> > msm_drm_bind+0x548/0x614 [msm]
> > try_to_bring_up_aggregate_device+0x1e4/0x2d0
> > __component_add+0xc4/0x1c0
> > component_add+0x1c/0x2c
> > dp_display_probe+0x2a4/0x460 [msm]
> > platform_probe+0x70/0xcc
> > really_probe+0xc8/0x3e0
> > __driver_probe_device+0x84/0x190
> > driver_probe_device+0x44/0x120
> > __device_attach_driver+0xc4/0x160
> > bus_for_each_drv+0x84/0xe0
> > __device_attach+0xa4/0x1cc
> > device_initial_probe+0x1c/0x2c
> > bus_probe_device+0xa4/0xb0
> > deferred_probe_work_func+0xc0/0x114
> > process_one_work+0x1ec/0x470
> > worker_thread+0x74/0x410
> > kthread+0xfc/0x110
> > ret_from_fork+0x10/0x20
> > ---[ end trace 0000000000000000 ]---
> > 
> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
> > ---
> >   drivers/gpu/drm/msm/msm_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I think a documentation patch that preferred_depth = 0 actually means
xrgb8888 would be good, since we seem to have a serious confusion going on
here?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
