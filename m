Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530506CF1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjC2SFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2SFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:05:48 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3B4202
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:05:44 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso17068258fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1680113144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gvT2+hYG9YTsl59VNP7YaGR4GU2t1ElrBSXIbGw5O0=;
        b=kum9hvQcJhQxvpZnLYfOsayFZbt/VJU/E8QmI/FIu3qMvXugcvzTrzukVbwWYZru4/
         C+0mvS9A67oTlla//Huq7cuFre670IMG6AFC2RtylU9iDiTK6WLRYLMekcoVvginbNWc
         PHjukN1WGzYslWrF2Q168ZlsNpt42XRqpaBvxEZQRi3q4YuQu/HeFyCivAgpw9ROsT+t
         zVxuBem744WeDhCdq598jerLE4uVCRltzfF5QNfoVbdc86ewcvrebF9Dffju+Lm+3uo9
         XjVTfXTOSFSc0Q0HrgqTfZbR2rCCNvvRrCbHBz6e3OCMj+GtCo9qf8OUVa103E/i/vwe
         3mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gvT2+hYG9YTsl59VNP7YaGR4GU2t1ElrBSXIbGw5O0=;
        b=EttKAbeC29IibVDYD6eMw6AU++cWLF17UsH5cg0LItJGmYxhnyor7fRxRYoYw54pQD
         JrN8gx5eqb9mSfoXaHZwwSJ4CRu6+QRAkGEyU+7XbZw31gK+f08p/9Z45CycJCy75th/
         z2HHnS4XlUN2J1ACnZtxQJmYsH2AWpekB5XSxuJYLWrlKXuta6V3IJyU8+rY5wTAd/x1
         XtgXG7o9EYkVyj/Qq+j560uMme4+tl0V7/iYJYUi9mZQYflgknhjdq0Qer83X1f0NGGf
         J+HI+f+hr2gyRs5IAxw0a7SKGG3zYa5APNsbMzzrEMutLXCM9FxAac0VpoJoS4Djp1S1
         HdnA==
X-Gm-Message-State: AAQBX9cDDC9dWn8UAfTfFlNP4kWg8YA9iIHg9Ndt5PfogOk+76yDu/Br
        S1wpNoK6f9uRIkKFSC0qsn+O+Q==
X-Google-Smtp-Source: AKy350YNgr/qkdBS4RnMoR+3Rtoz5LaA3HHitm3EVEE3vqnDKuJ6lb1ITT2IwvnEMsF0rJG2pjwNwQ==
X-Received: by 2002:a05:6870:9592:b0:17c:ae2:85af with SMTP id k18-20020a056870959200b0017c0ae285afmr12600042oao.34.1680113143872;
        Wed, 29 Mar 2023 11:05:43 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id yo7-20020a05687c018700b001777244e3f9sm12098767oab.8.2023.03.29.11.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:05:43 -0700 (PDT)
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
Subject: [PATCH v2 0/2] drm/amd/display: Remove a unused variable and mark a function as static
Date:   Wed, 29 Mar 2023 15:05:32 -0300
Message-Id: <20230329180534.99151-1-caionovais@usp.br>
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

This patchset removes one unused variable and mark a function as static.

Caio Novais (2):
  drm/amd/display: Remove unused variable 'scl_enable'
  drm/amd/display: Mark function
    'optc3_wait_drr_doublebuffer_pending_clear' as static

 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c               | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.40.0

