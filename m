Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154835F612C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJFGqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJFGqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:46:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CF11A2E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:46:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j71so1085269pge.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8U8sTusKp4JhPNItLtJY5qj5sKhcgHnhEpfdOFEcRoc=;
        b=f0XpWhr7eCwozs4wwkPIJYQ/+vtm+mmphwUBVU9QPj4IA/j45fT8I6SSnjcgQAbu2f
         zjv5a34R22FYrdrlUz9an2Y3CvArVzV39Hm/vOkSChKJzyX+NhsrblOdC+lfKlZNYQXt
         0EePa93WtFh9+sZtD4MCvZm8LJyA753SFTk253mIctN46PaC5cBKum59IVDUcNl8FBC9
         giccn+9tT32i8A3PVRLF2bhwSE7ElFI1/Oo3jE8pvB2c/+hw6WBELE3UTSmNZR3kEPBs
         /NGR5Ov4b0AnxilBLCc4UYmVvCbWEtCN2sM7LWvIhD/5v4coKTfREsIDH9Nsgd9wkMXl
         fFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U8sTusKp4JhPNItLtJY5qj5sKhcgHnhEpfdOFEcRoc=;
        b=f2Akj0K6Wacrda1bdY20FwHayXMC/X+uKzwvwneOvxgiCkzfTbKAhNYQcA8Z50E7+T
         eXImfztHqzWOav+7zLmzLgJGsySm57+Y9pjIOH7megdfYZPw0vCmQBkEVc7p0WaLU6ky
         Nhblpv/sx2S8dZK9nVbE5vKQZUN6n+X3jp5G+424N22eCNDIjTabRJiGu+AyvPGlv52K
         bBqa0yrCWtgH1zEu9D4TW7SrpWBSnHUPBkzCsoJ6ZCUZxXqbZ4dsyvmvxrumwr2WIF9+
         0s+rSRhXRGEfHJGkQeM8JBk0t1WYkyE7YGcGoTCs+NavsfMM3gEaaq5EQ4Q9G8zMM+SQ
         TfkQ==
X-Gm-Message-State: ACrzQf2ViL/UG2yZjZ2gZZnYwZNa7IkypNUMXVoD0zdH9dWLNf8FjFel
        uNBhgTN5WO32xpFQpJJh+eA=
X-Google-Smtp-Source: AMsMyM5u5IO13G+eelWsn4vfLpVx9Dbk4VoW5mUJ5i95QvSBXZ0Lyc6hEUtNTQNChRi+hrOR0NQGFQ==
X-Received: by 2002:a63:211a:0:b0:451:f444:3b55 with SMTP id h26-20020a63211a000000b00451f4443b55mr3111339pgh.60.1665038777524;
        Wed, 05 Oct 2022 23:46:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b0017f62877604sm5852884plk.66.2022.10.05.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:46:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Oct 2022 23:46:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>, Alex Hung <alex.hung@amd.com>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        Hersen Wu <hersenwu@amd.com>, Paul Hsieh <paul.hsieh@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: fix array-bounds error in
 dc_stream_remove_writeback()
Message-ID: <20221006064615.GA2817657@roeck-us.net>
References: <20220927191200.216488-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927191200.216488-1-hamza.mahfooz@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:12:00PM -0400, Hamza Mahfooz wrote:
> Address the following error:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function ‘dc_stream_remove_writeback’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:55: error: array subscript [0, 0] is outside array bounds of ‘struct dc_writeback_info[1]’ [-Werror=array-bounds]
>   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
>                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
>                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
> ./drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing ‘writeback_info’
>   241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
>       |
> 
> Currently, we aren't checking to see if j remains within
> writeback_info[]'s bounds. So, add a check to make sure that we aren't
> overflowing the buffer.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

With gcc 11.3, this patch doesn't fix a problem, it introduces one.

Building csky:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript 1 is above array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];

Building mips:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];

Building arm:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];

Guenter
