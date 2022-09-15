Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123B5B91C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiIOAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiIOAeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1648D3F4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663202000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrTT7QwQof63VN7IDSDKfIt2sJtV3+I3xYSNcLHiNaY=;
        b=TpTcnpMKOpKcegZnA5EhsEt7r5kSIt5d5Denj+U8M4hWmjxsR4bAZEl5IGjrJXc4s+hvs+
        F6XQgFGu/Njmdq2LEX1FyEttrLpoajzKdE88DXyb24O7Jn7xeGQXTjAP0mGNzN7qfcfoto
        WG4z9eO70FBgXAsqS+HsrftbTLPPVKI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-T7oj1C5EM3aNlSIIqvSQaw-1; Wed, 14 Sep 2022 20:33:11 -0400
X-MC-Unique: T7oj1C5EM3aNlSIIqvSQaw-1
Received: by mail-ed1-f70.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so11783462edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UrTT7QwQof63VN7IDSDKfIt2sJtV3+I3xYSNcLHiNaY=;
        b=KYt8X7tIFJQCTwrv3sLPCEi258wRuVNvLCRk5LEos5D05CwCDyfL+GKffddFgoYDVw
         2yaQkMMOgrqdGFwVGhpPXqX5BqqpsYBxnSsWcWElE6FwjDkeVW5DrEoFrXozhhXMMbRS
         uyjkq/ma+tLUKO9l0urqNDA+UBE/AZ7DwXj4Co8c6Kfpp+mWS6iDzMTGJ0QbXMeS/IEF
         DTtzv3uvw8RGo0v9/jWX+BX9VmTZe5qPampKPDjZ7HHCy1wA8ut5WKFsFXtIA/sJ7v+j
         HG6fl+nY3pH3bpIMxTyDVY05mHwe4UYO+ll6fZOzpNsv/n4XHL1wfGx00a4QNv9zuucl
         ZJag==
X-Gm-Message-State: ACgBeo0Jq/xEWv1S0zfvgFz1cIq6qxtox0tZTKWEmqLu2R0Hn4w4/S/7
        WDTTme7SG2F+6d9odF4J9d+HPqiGshL+6zFujiH9iyai/v+Jy/DdPECoT9r1TQckViw2/DHrInP
        TXv5TbeBAwIyOZCtYba4P0b9Y
X-Received: by 2002:a17:907:b09:b0:76f:99cc:81cd with SMTP id h9-20020a1709070b0900b0076f99cc81cdmr26426926ejl.530.1663201990444;
        Wed, 14 Sep 2022 17:33:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5g8V/nPxzHQDJZl0DRT92LXzhiR3i8YcPsXKLctBnnQWAlIwXPYox1IBRFR7Ze6l8SXhLAKA==
X-Received: by 2002:a17:907:b09:b0:76f:99cc:81cd with SMTP id h9-20020a1709070b0900b0076f99cc81cdmr26426916ejl.530.1663201990310;
        Wed, 14 Sep 2022 17:33:10 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p5-20020a50cd85000000b0043ba7df7a42sm10701852edi.26.2022.09.14.17.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:33:09 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 8/8] drm/fsl-dcu: remove trailing return statements
Date:   Thu, 15 Sep 2022 02:32:31 +0200
Message-Id: <20220915003231.363447-9-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915003231.363447-1-dakr@redhat.com>
References: <20220915003231.363447-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the trailing return statements at the end of void functions.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  | 1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index c77df9b7893f..23687551c831 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -147,7 +147,6 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 		     DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
 
 	drm_dev_exit(idx);
-	return;
 }
 
 static const struct drm_crtc_helper_funcs fsl_dcu_drm_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 1be3062a95df..d0a14b5b506e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -172,7 +172,6 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	drm_dev_exit(idx);
-	return;
 }
 
 static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
-- 
2.37.3

