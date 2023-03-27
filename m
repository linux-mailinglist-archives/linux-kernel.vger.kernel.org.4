Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDC6CB28A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjC0Xff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjC0Xf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:35:27 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438B26B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bk5so7699622oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1679960109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAF560UdJX0GEGh8pB1EAaLbRBoRHEw96H0zayNQKjc=;
        b=s5BGJnAq7jaEqaXyIrghhFPGN9hy259iqKpXXpXaLj6L2JgntWwWRT6UwzgFlL+a6W
         br0qVZmkEWUZydrOQC4RCcT08aprE/usdIisKmADVQTJWZ9gkn3qOoRxa6xH/VwZdZYd
         H6xJ8snIaCAxI8OR/2rpEpjvQxq4fo8hn1T+N4L/9gP+EFRzPFNqq40G34MBOLW5+ltB
         xJiKW4lWmTocpeyGW60GYjyY67U9OI3/VgY814ZUnRKxgLIgyQ9UbU9XRVQF4vEaidER
         SQpbiRtTQMZRqidHy2/13vqKJSjrBZDDVKUU5qEqOj/9JRRRZkVpXovfI+KwpabwKJ9B
         yg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679960109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAF560UdJX0GEGh8pB1EAaLbRBoRHEw96H0zayNQKjc=;
        b=pp0PNU0jZFisIyW//M8hkbAnN9Q5hQbCV7/210MoYJwjjJFUy+2ipyANAUEmW05DRN
         aurCO9Muku9sLxcwlJ48oAaE5VhqNj/7FZRIP1AawWbxUxcPTfAYbHre96FLZRvFQ7MC
         vwDqAqXkEhba4R2vLIpmBkZpeVniXMhgppd1YghZUCE8B/y0NnRJVnOU1JV8DqZx2vwZ
         IBS6WPe0Ld+H9Nlm5EPFgM8ZdWLoxwCg/J6teDENAUoa76xwjQYOAeFUaGY0USL3cfdD
         dswz8FgR2h/aqAjB+S8Gn+s5PVpkfUw5EOkRBRMjJDxPZ4Y07HFDeBnS/oszLFdOSuZP
         m51g==
X-Gm-Message-State: AAQBX9cor96hNxB/wnSGoBeyyEyBJ0lqRAq/YW/uFVLECeIxeyVZ/iVr
        nP08Li5eTRRy0eXzofufdxjknA==
X-Google-Smtp-Source: AKy350aHN1ssxfd7wdlDmSEKxo8G+lYPHr4FVFNdyq/GmsDYlksjWmJHcmWgoxbY/wLtygfAH8HgwA==
X-Received: by 2002:a05:6808:9b3:b0:389:545c:a95f with SMTP id e19-20020a05680809b300b00389545ca95fmr5474oig.42.1679960109737;
        Mon, 27 Mar 2023 16:35:09 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id b186-20020aca34c3000000b00389295e8424sm1643409oia.45.2023.03.27.16.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:35:09 -0700 (PDT)
From:   Caio Novais <caionovais@usp.br>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Caio Novais <caionovais@usp.br>,
        Joshua Ashton <joshua@froggi.es>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Zhan Liu <zhan.liu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Martin Leung <Martin.Leung@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        George Shen <George.Shen@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Jingwen Zhu <Jingwen.Zhu@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Felipe Clark <felipe.clark@amd.com>,
        Sung Joon Kim <sungjoon.kim@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
        Taimur Hassan <Syed.Hassan@amd.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Brian Chang <Brian.Chang@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Chaitanya Dhere <chaitanya.dhere@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ryan Lin <tsung-hua.lin@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 06/12] drm/amd/display: Remove unused variable 'mc_vm_apt_default'
Date:   Mon, 27 Mar 2023 20:33:47 -0300
Message-Id: <20230327233353.64081-7-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327233353.64081-1-caionovais@usp.br>
References: <20230327233353.64081-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling AMD GPU drivers displays a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubp.c: In function ‘hubp3_set_vm_system_aperture_settings’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hubp.c:50:30: warning: variable ‘mc_vm_apt_default’ set but not used [-Wunused-but-set-variable]

Get rid of it by removing the variable.

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index dc3e8df706b3..e46bbe7ddcc9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -47,13 +47,9 @@ void hubp3_set_vm_system_aperture_settings(struct hubp *hubp,
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	PHYSICAL_ADDRESS_LOC mc_vm_apt_default;
 	PHYSICAL_ADDRESS_LOC mc_vm_apt_low;
 	PHYSICAL_ADDRESS_LOC mc_vm_apt_high;
 
-	// The format of default addr is 48:12 of the 48 bit addr
-	mc_vm_apt_default.quad_part = apt->sys_default.quad_part >> 12;
-
 	// The format of high/low are 48:18 of the 48 bit addr
 	mc_vm_apt_low.quad_part = apt->sys_low.quad_part >> 18;
 	mc_vm_apt_high.quad_part = apt->sys_high.quad_part >> 18;
-- 
2.40.0

