Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4851613C02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJaRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiJaRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:16:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DE13CCC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:16:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q71so11239082pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew7SqTPEFFhxu7/hKrNbrME/m/ofSkUv4YYTUxK9hTE=;
        b=LNy0wlk54NXx0XGRLGJLTGHN4ywvxf5ommsqE1Fdvkb3oQxH48emeDOhk5HgzYYP5i
         D6Idhh6Iw5QX1O0N/ayHK9u2K512PuftFkYPlMpLOP7ZAjKaGvggrvDwGBhXal3Q86yb
         19ek7qCAUe4SKIA9ct7LeonTh+0TQdvtmnfXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew7SqTPEFFhxu7/hKrNbrME/m/ofSkUv4YYTUxK9hTE=;
        b=7EIL3xJC9N6b6HgP4NsQjtyB1uI6ScaBX9aq5TnSuA8BENxdkq9sFDHBDh/zThiVzn
         iblH4XWbaJYTB7sshTmkVCMghCbt/UWHBmu0Q91JQD449Lig1AQKI2tQcjq3Gnv7Gvxg
         6gU28ko1mYqFaR/f2XhwVw47TS6Cbj6Xy0UhTH4Yh8lvPa4yHlD0QI7DqofUf9XG2GrG
         SPLYx/XLfaN5ppkr0FR2cHRMnMpBy2DxElYw/p4J8hrhLar7pgvSLN4SdA4g+kJytm38
         4GkGt+OIAZ7V29NOa5fnOAuU0bf1/aZyk5ph/BReIybjL9cyrNMxMEpWbHQn4Ml/lIoh
         7BYA==
X-Gm-Message-State: ACrzQf3i0EqTGr1CtLFBYP2xRJmH4tpl4O+RVBOxnABLWBjiCgp3ueL2
        0mhSK0EnUx4yAmR98EwQLwwCQLWB7rqb2g==
X-Google-Smtp-Source: AMsMyM4cDfw2gQpzV2vuUo36o86Uf/NDWo6Qa/wbI4r1jWqZL9p4/hZK2btJIj/1sXglXJX0VgmwHw==
X-Received: by 2002:a63:69c2:0:b0:46a:eeb1:e784 with SMTP id e185-20020a6369c2000000b0046aeeb1e784mr13351654pgc.589.1667236569518;
        Mon, 31 Oct 2022 10:16:09 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:cf9d:6561:637d:2194])
        by smtp.gmail.com with UTF8SMTPSA id f15-20020a170902684f00b0017d97d13b18sm4679040pln.65.2022.10.31.10.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:16:09 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] drm/rockchip: vop: Quiet always-warning AFBC log
Date:   Mon, 31 Oct 2022 10:16:01 -0700
Message-Id: <20221031101557.1.Ic1569d394173c1c3016142fee4bb87a09753db94@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream code from which this was derived didn't ever run through
this 'switch' block with non-AFBC formats, but the upstream code does --
we use this function to probe whether a given format is supported.

Demote the warning to eliminate this sort of warning seen on every
boot:

  [drm] unsupported AFBC format[3231564e]

And make it warn more than once, because if we *actually* care to see
what formats we're probing/rejecting and for what reasons, we probably
care about more than just the first message.

Drop the comment, because one of the two *is* commonly reachable.

And lastly, drop the unreachable return; we'd do better to let the
compiler complain if we start hitting this unexpectedly.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fa1f4ee6d195..aab77eb6caa3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -316,13 +316,10 @@ static int vop_convert_afbc_format(uint32_t format)
 	case DRM_FORMAT_RGB565:
 	case DRM_FORMAT_BGR565:
 		return AFBC_FMT_RGB565;
-	/* either of the below should not be reachable */
 	default:
-		DRM_WARN_ONCE("unsupported AFBC format[%08x]\n", format);
+		DRM_DEBUG_KMS("unsupported AFBC format[%08x]\n", format);
 		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
-- 
2.38.1.273.g43a17bfeac-goog

