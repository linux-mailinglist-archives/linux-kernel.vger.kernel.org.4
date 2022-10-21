Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBAD607F80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJUUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJUUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:07:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F2F10B5F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:07:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso5635393pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh4YIgtLxUw6WgoDzxlF5MErsV4sylhzFrfQBBr3GjE=;
        b=in9tvOX8bP32FVB9PxADmtd00bHTP0G4N3hxe3LC3/czC3+AWMUbkfNVT5VKN6rpMn
         /FRxKs2wOQFDbegwIP+zAXvI1//2TkDnk8DmFTbVZOInjumlV9KGNaPX4xjgQ0/ocm8P
         h8TDMtEEctwPCFhtwjSSryElS7YDqI2e3aV+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vh4YIgtLxUw6WgoDzxlF5MErsV4sylhzFrfQBBr3GjE=;
        b=rzSGOTWiDPB818pMQQoMUb5nILYLjbb/OIigDpTXyAD2RqAwhia/KT6UsYkQeYrEBp
         uh4BKi9i3Lb1YhGSGqdqWEee15xCKhWZwlETV8BbAK4fwCii5Iw64BQHI15SpbZx7Cp3
         a3qx58kcVGancwNMvVi4e377pnxym3cxq2qavzViMcG3HE7CBC+1ILN3yXvdrDsZ9Md3
         x3HQx1/XkfIEqRnAMzPPFAmDav8WinTs0aKa4E8s/sCnZSXAxUe78W7KcgFwgloG4Ct7
         AdQC3o/2Z8p7yKj7YBN0ZcoP2wS0em7sSVwc25g8O6h2STm/wynI0jZG0JrWeR9OL2ly
         kfew==
X-Gm-Message-State: ACrzQf2igREKi14UlZ9VktkAk9FET6/XRx0a26Il32LyNFBLtBLlVw+c
        r6+a7K/jMsVynLJIhiGEal9TNZJ22iYUGW6i
X-Google-Smtp-Source: AMsMyM57zE472B2sgzDvVJYufYcmqXY3A2Omv5vWUX4NlKuHUPlbj7J/SwqISYDA6oDu0wnOsPRy2Q==
X-Received: by 2002:a17:902:e1cd:b0:184:aa71:217d with SMTP id t13-20020a170902e1cd00b00184aa71217dmr20515106pla.77.1666382851068;
        Fri, 21 Oct 2022 13:07:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:361c:b732:581f:2329])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b0017a032d7ae4sm10209137plg.104.2022.10.21.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:07:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Dump the EDID when drm_edid_get_panel_id() has an error
Date:   Fri, 21 Oct 2022 13:07:07 -0700
Message-Id: <20221021130637.1.I8c2de0954a4e54e0c59a72938268e2ead91daa98@changeid>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to get a valid panel ID in drm_edid_get_panel_id() we'd
like to see the EDID that was read so we have a chance of
understanding what's wrong. There's already a function for that, so
let's call it in the error case.

NOTE: edid_block_read() has a retry loop in it, so actually we'll only
print the block read back from the final attempt. This still seems
better than nothing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_edid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 47465b9765f1..d63e26ec88b1 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2721,6 +2721,8 @@ u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
 
 	if (edid_block_status_valid(status, edid_block_tag(base_block)))
 		panel_id = edid_extract_panel_id(base_block);
+	else
+		edid_block_dump(KERN_NOTICE, base_block, 0);
 
 	kfree(base_block);
 
-- 
2.38.0.135.g90850a2211-goog

