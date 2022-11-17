Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1262E611
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiKQUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiKQUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:39:17 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE258CB85
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:12 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id bp12so1522804ilb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBMrn5FpFpyo6XLLEvcLrJTYaTIQkMIKgkloGnkuSUA=;
        b=Hme4cLCtXAaX9LqVE8bdNByEHHkvn6cBFTD9Z299bI4A2Aybw7Uz0dM8tg3n3SkkHg
         x+61Jdtz1YbB0GHTgtPtM66W1lrayEX9ndqwqIDGS4+ZN5QjdDuXuhUUfaB1M/lIUutn
         awlO9fLKxauHwnc51wZYSBzuaBEwGNr5XJJcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBMrn5FpFpyo6XLLEvcLrJTYaTIQkMIKgkloGnkuSUA=;
        b=zEzE60p7tG8fwUd1uNOkiRmUA2ntjJfHnjIzPAq+GYq7vGzWsJUqGoEdks9RwQ/Lwb
         xFjGU7irwsyA9Xm5qJjX28r7ArJoCKxalTx3fL2ysgjeKBVGQWSisDD16axDZww7ZxrC
         Ugp2YIefMm3f0axcvTPlyGOMXjCa/J1NyaDQ8FSHAcNlzv96tgq/vWPLMlwbDElhvkc3
         NCEOhWA1H8LBvA76aZFkdI8ntfPPWxaqYrAZjhL6mPrqmpEPTIg44lEQlfk0ESBIpbFh
         6ni7ee/PkVCNbTlqsLjHQdcZvwv71zN2ICmMIIKRbhGyW8Uc9/Y22cMD9J54xqJMChKb
         CPsw==
X-Gm-Message-State: ANoB5pne+LrcbttrZSZzMnLL/P8dY2gdkIa/Ngbqj7zwYXn7WH7DnS84
        gnKQcuvnusOmewzGp12yHmar5g==
X-Google-Smtp-Source: AA0mqf5DOe5AO4XAr4/ZX3dTaQsRYrztItnwsdC1NGdTpSOzTtm8WSNGyQlclYNxGvJoWToS2a1irQ==
X-Received: by 2002:a92:d9cb:0:b0:2fa:12a7:b8c8 with SMTP id n11-20020a92d9cb000000b002fa12a7b8c8mr1990295ilq.286.1668717552319;
        Thu, 17 Nov 2022 12:39:12 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:b285:6808:3f3e:f538])
        by smtp.gmail.com with ESMTPSA id d191-20020a0262c8000000b00363da904602sm570192jac.13.2022.11.17.12.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:39:11 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     dianders@chromium.org, Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/panel-samsung-atna33xc20: Extend autosuspend delay
Date:   Thu, 17 Nov 2022 13:38:48 -0700
Message-Id: <20221117133655.5.I96ce2a565ff893eddcbee70174c991179311a3ae@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
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

Avoid the panel oscillating on and off during boot. In some cases it
will be more than 1000ms between powering the panel to read the EDID early
during boot, and enabling the panel for display. Extending the
autosuspend delay avoids autosuspending during this interval.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>

---

 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index f4616f0367846..5703f4712d96e 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -310,7 +310,7 @@ static int atana33xc20_probe(struct dp_aux_ep_device *aux_ep)
 	ret = devm_add_action_or_reset(dev,  atana33xc20_runtime_disable, dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_set_autosuspend_delay(dev, 2000);
 	pm_runtime_use_autosuspend(dev);
 	ret = devm_add_action_or_reset(dev,  atana33xc20_dont_use_autosuspend, dev);
 	if (ret)
-- 
2.38.1.584.g0f3c55d4c2-goog

