Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB60C6EF343
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbjDZLTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDZLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C334ECD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682507927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D7k9+FthuusJl7if54fxaYap+uFJWroS2RQ6a9bGb4Y=;
        b=An+vwjduZhuoEnGx07iXFCkO14RqYSkXUrXnAY+RNna2TC4Nw4LvVUIHz2lxsj4hccwIh5
        x1MRlvQslkWodkEux5eMvFeExJ+kflpFCc+V0dtZDJ6sOBVCuPGO94l805rCHYhs7wPdxn
        nb7ETSMOZqY89ia7UMO1EHLNWHyiUQ4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-A7O2mqeJMQG6jgIvJ2TWNg-1; Wed, 26 Apr 2023 07:18:45 -0400
X-MC-Unique: A7O2mqeJMQG6jgIvJ2TWNg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5ef40d2af43so42903576d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682507925; x=1685099925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7k9+FthuusJl7if54fxaYap+uFJWroS2RQ6a9bGb4Y=;
        b=NILjhOwDGqAWPEEmcHdJmIcC+LCOxkCGV+nGt08hM2agL/9iAYh+dC8FoRsPJuMCYv
         oEsvwsT8G67n4/Rwh8WYA6YIYIqoMrc0fD5rwNyCVeWSjxPpKD9L+ZXWWo+yCiSxJgkf
         nGvo/s8unoaHwQspVYBhQD+aVGjxJCLKx0s4E1wdycOIHNvCz8kLOQvD2zT9si5z4Rne
         10685f6kyfkSpRMs4os8ggE0aucsKsttyhkIOka+v2t03gGNcYrma/ZjaoUUnTc0HBO2
         w7JDA3w4P4YR3QZmoEAMnU1A61dNL9NrJTbWJL39zzpL67+cWDxHJRCdyod7ylP5EFhd
         g1/g==
X-Gm-Message-State: AAQBX9fSWMOkMo6UIcVoCMd1CKxiEJ4MxBK404/bH72u2IgUIOmU2X0T
        XsrnD3BKkMADB0mJoS4FhB59CNnwcdFn+MMKC/l7ZU0/hTkY+J8GJYa6yMzUfknmTL1cypjNGlj
        DurF5iYysPV003vcm2OK2RG6d
X-Received: by 2002:a05:6214:262a:b0:5ef:52f0:7b1e with SMTP id gv10-20020a056214262a00b005ef52f07b1emr36095400qvb.31.1682507925248;
        Wed, 26 Apr 2023 04:18:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yei+ST19kHCsL3KHPalEzKbRARMslLTCav5d681fG95b97NunP1uQSjWSZdSykEIvd9sYpKg==
X-Received: by 2002:a05:6214:262a:b0:5ef:52f0:7b1e with SMTP id gv10-20020a056214262a00b005ef52f07b1emr36095368qvb.31.1682507925004;
        Wed, 26 Apr 2023 04:18:45 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p17-20020a0cf551000000b005ef59a383e6sm4789002qvm.119.2023.04.26.04.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 04:18:44 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, qingqing.zhuo@amd.com, hamza.mahfooz@amd.com,
        Josip.Pavic@amd.com, robin.chen@amd.com, alex.hung@amd.com,
        dingchen.zhang@amd.com, jiapeng.chong@linux.alibaba.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: set variable custom_backlight_curve0 storage-class-specifier to static
Date:   Wed, 26 Apr 2023 07:18:38 -0400
Message-Id: <20230426111838.728441-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:119:31:
  warning: symbol 'custom_backlight_curve0' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 68d95b92df76..30349881a283 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -116,7 +116,7 @@ static const struct abm_parameters * const abm_settings[] = {
 	abm_settings_config2,
 };
 
-const struct dm_bl_data_point custom_backlight_curve0[] = {
+static const struct dm_bl_data_point custom_backlight_curve0[] = {
 		{2, 14}, {4, 16}, {6, 18}, {8, 21}, {10, 23}, {12, 26}, {14, 29}, {16, 32}, {18, 35},
 		{20, 38}, {22, 41}, {24, 44}, {26, 48}, {28, 52}, {30, 55}, {32, 59}, {34, 62},
 		{36, 67}, {38, 71}, {40, 75}, {42, 80}, {44, 84}, {46, 88}, {48, 93}, {50, 98},
-- 
2.27.0

