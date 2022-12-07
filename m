Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9A6452D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLGECt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiLGECo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:02:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1C2DED3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 20:02:43 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so324750pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 20:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JpzwpkKCmH2sOx1GakX1P9BwZsMPGRIYnZX6CUK5AeE=;
        b=J54Uj5AVZuhIZz5YmG1N8uxXOjD1eAaOOBsf1S2cy8THrKvt/Hwv5ZvlwgN9Bl8c8l
         M2tnc/0CkBKLeQI7F92o3mfoXHByXC02CjLvw89b2MORerb7QLWjfhtWyz4EA24tY01v
         nvBZwqxii1QUSU8X8s+6i74/3kv5B6PkK4Lrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpzwpkKCmH2sOx1GakX1P9BwZsMPGRIYnZX6CUK5AeE=;
        b=HJ3GkSDLEbOQfGLuoL3f39geIeiN3o/r8LV3qb2u4yf1TH2RtXCTmEPaufcB4yBac7
         wZy6+YOnN7Us66dRR9UzsjeVm41I9DZgQ7HeXFnUjCKxG0XluFeZAX/C7q2Lg/8GCtuw
         1cdwj47c0PhS8UGXpyl3+qUZ8J8nrGn4wO+MhsioX1tRwJ0OLWOKuqxFfefRfrJcnAtl
         B2cSxhR943WFAC7Nev3dsB3uh5GmNw6Nxnsgkj/qp9+tRDuo839NI3+Qx2bGs9S1mA50
         r+knEzpPqQVx03zR2z0YUDtvfHxIH1rCLvD6vlri7yHHflxziNHtEwLIY/UnkEqKM5pt
         EIMw==
X-Gm-Message-State: ANoB5pnAbJOTchYgGAIxw6QU5A/tvNKDsexGDs1W+FuugWLrr7LCla2d
        1p80i47FWi58G7szOeGtuSPXc+UCPeGltCZmPZ2lp+49
X-Google-Smtp-Source: AA0mqf5oRBxRQoJi7SCi44xUMQuWzsGARoZmCn30XHcrfM0wUrUsU4SqnNz4GPGHwV275yEx8fCKwg==
X-Received: by 2002:a17:90a:4a8f:b0:215:f80c:18e6 with SMTP id f15-20020a17090a4a8f00b00215f80c18e6mr104577701pjh.45.1670385762436;
        Tue, 06 Dec 2022 20:02:42 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:bdb7:35b1:b44c:1926])
        by smtp.gmail.com with UTF8SMTPSA id a2-20020a17090abe0200b0020ae09e9724sm143925pjs.53.2022.12.06.20.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 20:02:42 -0800 (PST)
From:   Victor Ding <victording@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     tinghan.shen@mediatek.com, gustavoars@kernel.org,
        sebastian.reichel@collabora.com, dnojiri@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, pmalani@chromium.org,
        groeck@chromium.org, tzungbi@kernel.org,
        gregkh@linuxfoundation.org, dustin@howett.net,
        Victor Ding <victording@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: zero out stale pointers
Date:   Wed,  7 Dec 2022 04:01:08 +0000
Message-Id: <20221207040049.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`cros_typec_get_switch_handles` allocates several pointers when
obtaining four handles. These pointers are all freed if failing to
obtain any of the four handles; therefore, pointers in `port` becomes
stale. The stale pointers eventually cause use-after-free or double in
later code paths.

This patch proposes to elimite these stale pointers by zeroing them out
right after they are freed.

Signed-off-by: Victor Ding <victording@chromium.org>
---

 drivers/platform/chrome/cros_ec_typec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2a7ff14dc37e..59de4ce01fab 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -173,10 +173,13 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 
 role_sw_err:
 	typec_switch_put(port->ori_sw);
+	port->ori_sw = NULL;
 ori_sw_err:
 	typec_retimer_put(port->retimer);
+	port->retimer = NULL;
 retimer_sw_err:
 	typec_mux_put(port->mux);
+	port->mux = NULL;
 mux_err:
 	return -ENODEV;
 }
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

