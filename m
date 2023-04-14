Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0686E267C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDNPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDNPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081083AAB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681484916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dntWt6MEzqE7MJUvMHAAGJ0dlLTaBYPZeQAgzMBHF18=;
        b=BdtTN6CaVbp6dkzdttH4asfkUHoi+uduhNiWvCdlHFNjgmrD/UAB4wngdf9qhZkW2bz6U6
        8fwQtD4w5OeCxcBhpId0aMafzvcYZqf39P4xpzacz0oY0bAH1L05kqi3kDxMVfz0F65sx/
        myNHhDE707xdYmoPBtMi3lRhOyz6UFc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-mBtKPdQlPnajhkyB55Zhsg-1; Fri, 14 Apr 2023 11:08:35 -0400
X-MC-Unique: mBtKPdQlPnajhkyB55Zhsg-1
Received: by mail-qt1-f200.google.com with SMTP id v3-20020a05622a130300b003eb13e57badso1264040qtk.18
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681484914; x=1684076914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dntWt6MEzqE7MJUvMHAAGJ0dlLTaBYPZeQAgzMBHF18=;
        b=fpGJvY5eQS4GStMnOAWh2tkzLr/BI4GeuScaPosozVrgO5nGs2zifOEffcv6XJOtAB
         zyWgZh2cEZ2NYpegT2S3tlnFgYnPsdHWZOupdV1ayuu2gQOFayX3fTMKbNpxu1FzYHrV
         WuXPwWvpCyCvx3/xO9stRaTtp9zDKGI+roxVeOd+f60xFibLxB3/AalaYyIsBLUjTIfG
         NUec4KxfYp785fwJuOfrPKqd4/bbkpJVCu5sCWKZxvA1mMLyL+/0S4S+5iOtMyniVOEW
         2AMfUyYBcj2ODCflJw5mFn2kx6q+wO7/zngdt0TLwjz0h/SmPHZqmqafRZL4kH0atYA4
         6xrg==
X-Gm-Message-State: AAQBX9eSX3gWECWjvF1Mo2Vdkdf+aQjRIALN29KK2DKLQamrvnd/UCIC
        PKgDeRPiGp185MiOqaDt6Pv+NxAsB8Z1nbSb6u6qtkSbWpuYcYYp8y0Jf71o0G92Lerkeb0zVbr
        K2CKxHz9PUrLJiAejATpdvFCq
X-Received: by 2002:ac8:5ccb:0:b0:3e6:4e79:7401 with SMTP id s11-20020ac85ccb000000b003e64e797401mr9604121qta.29.1681484914448;
        Fri, 14 Apr 2023 08:08:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGN/ZPCYxibgTViJjjyz5pv87pPzhZ5EyrP/e3wwVcRZqPGm413XGTEu5OHq/fnESmP3RN0w==
X-Received: by 2002:ac8:5ccb:0:b0:3e6:4e79:7401 with SMTP id s11-20020ac85ccb000000b003e64e797401mr9604084qta.29.1681484914150;
        Fri, 14 Apr 2023 08:08:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id eb3-20020a05620a480300b0074b5219b63esm342074qkb.121.2023.04.14.08.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:08:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, HaoPing.Liu@amd.com, aric.cyr@amd.com,
        qingqing.zhuo@amd.com, hanghong.ma@amd.com, felipe.clark@amd.com,
        Dillon.Varone@amd.com, Mike.Hsieh@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused variable oldest_index
Date:   Fri, 14 Apr 2023 11:08:30 -0400
Message-Id: <20230414150830.3173504-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp_check reports
drivers/gpu/drm/amd/display/modules/freesync/freesync.c:1143:17: style: Variable
  'oldest_index' is assigned a value that is never used. [unreadVariable]
   oldest_index = 0;
                ^

This variable is not used so remove.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 5c41a4751db4..5798c0eafa1f 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1137,10 +1137,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 
 	if (in_out_vrr->supported &&
 			in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE) {
-		unsigned int oldest_index = plane->time.index + 1;
-
-		if (oldest_index >= DC_PLANE_UPDATE_TIMES_MAX)
-			oldest_index = 0;
 
 		last_render_time_in_us = curr_time_stamp_in_us -
 				plane->time.prev_update_time_in_us;
-- 
2.27.0

