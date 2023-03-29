Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27786CF1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC2SGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjC2SF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:05:59 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA165B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:05:56 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17aaa51a911so17086358fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1680113156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dogo3BF2L9vBC4AT6xgMxoTJFXvXmfhOs0Wm2IXvUoA=;
        b=L0HwYwO3L/MNP7MmWs2RcJbpPDw4+LjAB6LZUkRjGQGTcOAeJV74uov52Ekfpp5dmx
         s9lGs7hbWkvuFTUwneVaHXamZVEnm4xDfnGAUPal58PW25X0ImisVK6cetvN9lnDxxpB
         S14152RBp3zDsK3rafFd6eeNnYPrDzXt3KSOf/f8/tH+QAuum8S3zUYAVtXz29+H3Ysr
         +JJmJ+SZm+bax72OFXXBsTF/JNpymn0AgJeQej1Hzg2/4mgEwTNsa5oo41F6HWUq2+Kg
         AkSmdqdvYDrjPRkHg8UO1RD3UssIXsf/yezuTeWy91kkBOGVueLttPUm9Jmt2+Nf3SDi
         QqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dogo3BF2L9vBC4AT6xgMxoTJFXvXmfhOs0Wm2IXvUoA=;
        b=euyqP31zjzQctkcu6efVJRXXqnC1+9cz0mg8VWFqk08XmcqOq5Qa6iFQU4jqkscWPM
         DVNHLghz578XgIuWJZu8sUa3csenhV84Z+Dbk45Y1JTxYfy/36vig28MLZ7JcoztE8hI
         q3mhtNYMbL0FJDxsFe9VCz/QRMqNX4K8gSERwv23Q6Wcm/7SYFvY6BE3kDWalWiaQMVt
         OYIvpsz2uKqxfZpqc/dnu/8fm86u9YDq1NlldDABaAd3qJNRIK41hFF12lSJAfHYlnwZ
         zSEn6n3XAWVDQedF/0auUfSdI9Bj5hFyMowt5k1PCdD1PTdiwldCo++KkwzUkZK+mpWc
         aH3w==
X-Gm-Message-State: AAQBX9cTxGin2MD1GVcCeNh0s37eIVYKQpPg3wq+ITCsUn0N5fVRHz+p
        BOF+5IND8MpIeA6o7D3Rm0ifiA==
X-Google-Smtp-Source: AKy350Y5nATzpWAejjs20Se142ta9u/ME/7RWzY7Q28O0MbOueyG/JtjDWUShvoc2IoJ5SkqvG6ZWg==
X-Received: by 2002:a05:6871:282:b0:177:a8a8:65c with SMTP id i2-20020a056871028200b00177a8a8065cmr13194714oae.4.1680113155874;
        Wed, 29 Mar 2023 11:05:55 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
        by smtp.gmail.com with ESMTPSA id yo7-20020a05687c018700b001777244e3f9sm12098767oab.8.2023.03.29.11.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:05:55 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drm/amd/display: Mark function 'optc3_wait_drr_doublebuffer_pending_clear' as static
Date:   Wed, 29 Mar 2023 15:05:34 -0300
Message-Id: <20230329180534.99151-3-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329180534.99151-1-caionovais@usp.br>
References: <20230329180534.99151-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for ‘optc3_wait_drr_doublebuffer_pending_clear’ [-Wmissing-prototypes]

Get rid of it by marking the function as static

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 08b92715e2e6..c95f000b63b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -291,7 +291,7 @@ static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool e
 		   OTG_DRR_TIMING_DBUF_UPDATE_MODE, mode);
 }
 
-void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
+static void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-- 
2.40.0

