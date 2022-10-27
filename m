Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA62A60EE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiJ0DWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiJ0DWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:22:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACCB8FD72
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:22:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so4991710pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAdp5j8ulbSqSMP5WhQQ65OXGcxKYysV58XuMaNjzUY=;
        b=gy3HWQyvWny4e6D1XXtgdsCcjIx6Rzbj2W5EZH2Iy54P7OmKCs88Rlz49SuKony4Jf
         opZrpoerdjb//gzLAO5Ny+kSF1OSL3hdDDJOqLyHlHs3JfNCDsD3pDo6ZZMEZTZfWyT+
         0QYIUMsF3UdyP9syDq9uDbz0SQqub8LVZBve4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAdp5j8ulbSqSMP5WhQQ65OXGcxKYysV58XuMaNjzUY=;
        b=iCCfan5Y55rdyHXvQAdY8DMzTeR8MSIiIv3BO9ofC7CXVYGX6wAxUjy+Ig26Muhl1K
         KgmR5s6zfRfSVw8z24OwHUnJPHCvc1EexsKsqIK5ohU3z8pQXbkQwCtYSV2sh3FieONY
         aApZ3Kv69jYZAKNeJmda2aa5Ns1t9wpaSoOMzD/wWr85XoegVEDghHP0WHG9uulhMas7
         WcbngljMj1XOfDFjdIW/zIxHrP6cLOqz8DDdXqWbo+jH5rEW4BxvFxQWLRSWq4eT5Z8U
         j9P/+5O6U9YhrjqvkCsjz5u6CWul/MFAMXVpr2G8oaQqtIslplCUIckAjfjeaxCrBn8L
         WYMQ==
X-Gm-Message-State: ACrzQf2Y2R5AcVwc8pibg2Ehwn5NQArFJvRtbNyOxUDvKEVgvsVbMcBs
        qWqCYftY7zCSA1RyHbKnrgYjTA==
X-Google-Smtp-Source: AMsMyM7ISTd7H5l+G+sR0cdRQnp4XV0OGpkEeWvzyTBCL/fYpUTGshzgfY1/BntVE31+WRiqRg0a9A==
X-Received: by 2002:a17:902:708a:b0:183:88dd:1d36 with SMTP id z10-20020a170902708a00b0018388dd1d36mr45241452plk.166.1666840932382;
        Wed, 26 Oct 2022 20:22:12 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3790:5571:53c5:e671])
        by smtp.gmail.com with ESMTPSA id y129-20020a633287000000b00464aa9ea6fasm62884pgy.20.2022.10.26.20.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:22:11 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: it6505: Fix return value check for pm_runtime_get_sync
Date:   Thu, 27 Oct 2022 11:21:49 +0800
Message-Id: <20221027032149.2739912-1-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`pm_runtime_get_sync` may return 1 on success. Fix the `if` statement
here to make the code less confusing, even though additional calls to
`it6505_poweron` doesn't break anything when it's already powered.

This was reported by Dan Carpenter <dan.carpenter@oracle.com> in
https://lore.kernel.org/all/Y1fMCs6VnxbDcB41@kili/

Fixes: 10517777d302 ("drm/bridge: it6505: Adapt runtime power management framework")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index b929fc766e24..21a9b8422bda 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2699,7 +2699,7 @@ static void it6505_extcon_work(struct work_struct *work)
 		 * pm_runtime_force_resume re-enables runtime power management.
 		 * Handling the error here to make sure the bridge is powered on.
 		 */
-		if (ret)
+		if (ret < 0)
 			it6505_poweron(it6505);
 
 		complete_all(&it6505->extcon_completion);
-- 
2.38.0.135.g90850a2211-goog

