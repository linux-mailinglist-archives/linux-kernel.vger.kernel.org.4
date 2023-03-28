Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6142D6CCCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjC1WKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjC1WKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:10:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92F1FC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:09:57 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r14so4492775oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1680041396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+do5RbLU3FTsGCyiGfUyvpvc06CIKe8iN2wcuyFgpdk=;
        b=Xpn9Q5gVncsLo51GKrL6c6j8Xvr3Cw7fVwaMSzFQslWxG1K3wWhkJpHRZ519ne2b5C
         Rv5kRiXfXne25VOVjR/Ca+aO64nUkX0AnChhFB2k4Kko6H7O/DfgBBloSXZXuSkn5znl
         vOoTA47SfQdiQp7w+zOWyFY31pBV3NKlKqueYOLudpad7EMpkQxhKVsgjrs5IknVJXZh
         NVIGYaRf6shqf3eTEbkCOanf1Fe8HImUjtk2nxI6s3icOF/7LxJxoKoDAlLp78IpGFlu
         uCVR7AwQL8IVtSK+Ir2va5M/N0ZSMXeLhLcEPJWfiS08sNEFRIeYwSTnkR+44hQJlQAB
         OWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+do5RbLU3FTsGCyiGfUyvpvc06CIKe8iN2wcuyFgpdk=;
        b=hzTFNKlkmVgH83XmE/LgJ4oxK/HIqhVo1uetlTMh6Rrg9XflYs0VoBay8iomRCE5S4
         skF+6poBcmtPbuYuo40ZlFQqwqEl8QR+aN9RiembuXoRyaaOUD3nJhz2MBSMuml7uYAt
         6B8KwmnlrOzjt4JIFPunbBUOIH3welIa+nPAFYd1koBJtyOZZ4BX6h7T7KyxumBl56iA
         VOkAgykNBzhQdWWefF3NJdOP8FVk0zS5H+iC/Li235FgY+bYNL0yw+nmhieo2Jb1gmDD
         58aS1jbjhvVOPncmWfTA7VB+l9GlSr6bqbZgxZ3fA+0Fmyedfb11vNEcFdL72kMw9TNc
         vylQ==
X-Gm-Message-State: AO0yUKXmiO3R+HDPUkHKkfvxJ/NnhSwxYjb+AmDZTvXayAoearVyVJnc
        tQ5JRl6HmbOlRAxVIJcBaKG5bQ==
X-Google-Smtp-Source: AK7set/TXS3xSTLtKC+z7VZsY/Cb0Lq/C02tDibxlVEYu2PSIT1ral1k8nJ/tIKCnGedRgkbJbybZg==
X-Received: by 2002:a05:6808:394a:b0:383:d1e3:38f9 with SMTP id en10-20020a056808394a00b00383d1e338f9mr7790081oib.16.1680041396675;
        Tue, 28 Mar 2023 15:09:56 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id ee39-20020a056870c82700b0017299192eb1sm5400446oab.25.2023.03.28.15.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:09:56 -0700 (PDT)
From:   Caio Novais <caionovais@usp.br>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Caio Novais <caionovais@usp.br>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>, Roman Li <roman.li@amd.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH 0/2] drm/amd/display: Remove a unused variable and add a function prototype
Date:   Tue, 28 Mar 2023 19:09:45 -0300
Message-Id: <20230328220947.108188-1-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes one unused variable and adds a function prototype.

Caio Novais (2):
  drm/amd/display: Remove unused variable 'scl_enable'
  drm/amd/display: Add previous prototype to
    'optc3_wait_drr_doublebuffer_pending_clear'

 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h               | 2 ++
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.0

