Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D95EB660
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiI0Ak1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI0AkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:40:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228C33E04
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:40:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 129so6578285pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pGt51fVnZ3EKLkKkT429v72La88Y6sW9WqI8weW67S8=;
        b=Oq1JA4L/avWEqaRp3w58mg2z0PM4qsnliNUIsoKBlDE6tSA8D0QVjfVvKz0ZJJigRX
         XZsQLFTfMeXNBQ0fCNu8mHYPxUh7urDzyBF8UsgJ3LeHGmxtJvANVPv5iykuK0+wjL/i
         QEXkx5mq8tx8c8LxIDbjsg74TaDzSdDe/Tg6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pGt51fVnZ3EKLkKkT429v72La88Y6sW9WqI8weW67S8=;
        b=fuFebNUNmsMM+V3FQyPRXjXU4ivAvoqguwgnCeEKBLXCVm/a8uBUiTeao1WDnH0r7S
         d0zhdy/CUOmRm9GaAfhKhYXXHqjHzAmSxXtKgNCmotERmDwSElIX+mBtup+jDzHgqtNP
         NHFRPWCgxHsfjvrY0uz+LmFCxOdJBU4FlyuXdGi25NfYNhuBlX4X08lYys4+ZL1KrWCI
         1ZQJMUdhhBez1/BVHQHKpglIMyva2D2PnLiIgLsHLYMJDNrTfat2GHp+vgSver962Z2Q
         ulKvhl1zaNCrsL+fOskuVvC/I/DnChev7GhR4Ln6Ew3mrN0m09bFzavmwyclxT2tsyAM
         l0dw==
X-Gm-Message-State: ACrzQf2lXoEZxCa5+hu38zglmmUvQ227s9ITE0wUwku77KROaXFULVlw
        tFCwLJ0/42f5Acazetv2HivtYA==
X-Google-Smtp-Source: AMsMyM4DBwkJt9JgEwKhJyofsVCuApgj47vMcTyXAjbHT1YTCJiKsvKiWnfGQnHOgfU0c79wTb3QLw==
X-Received: by 2002:a62:2983:0:b0:54e:7cd5:adb3 with SMTP id p125-20020a622983000000b0054e7cd5adb3mr25944829pfp.38.1664239213900;
        Mon, 26 Sep 2022 17:40:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z187-20020a6265c4000000b005367c28fd32sm113065pfb.185.2022.09.26.17.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:40:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] platform/surface: Split memcpy() of struct ssam_event flexible array
Date:   Mon, 26 Sep 2022 17:40:11 -0700
Message-Id: <20220927004011.1942739-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; h=from:subject; bh=GL45TSDgSn7yiaUVdMr7d6+dV1xEwuSn6eIvk11kXhk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjMkZrIBbhM5eJ5F0lk3GSzc2tJpcGHkoXsVR+1CSD Z+kqhDiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzJGawAKCRCJcvTf3G3AJuYgD/ 42fEX1+srsvR9Fgixh0DPqR9AHu3bbG8VczVkxaEs0PIPA9m/U1oa61vODyMGQFvVpGTdtwtOqusao Lc0TCL8cxkBG9r985lB7EOFK5m6GOJq0qaATQVjyCgshaFJpd9i4KuZzj1OrUhyfFV11y1RPrZDeMx xZDjWfWyYmoJPjri9wFWsmxYh+wuDO2ZdhGUGcpF7UKEEfuLOQ5TdHvse0W5mgVr7vh6VgZsSQ8pwd YPJbaWfki0IsvGngCDXWd6WUkhHSbZXLCUiyL+xVk9jW4c3Q9mjyvseSyutd8l1Rweb8Z+nUSEyqjT pKZDSZyNqiNv/H0m7GfmguCiIaS2mp8ZGfarUOCqPK61YmiWzf/zr/7d+4A20CHcdiflyL49s0POov d7cldX6lZfTOQQh0Qy+/ObfAVmYRiG6Up1r/GB7sTM+YkKmqbfjtfvYfirXmBWFGFskZ20FvQ9Yc7E OdIV+frZTc8m36X9cNmWgcYd0XDtBxwQ5azt3DVdEnrTsD+L2qj/+nViU/PU07lghiFXiUmD6osc8q gmWLw8zA568medg+59ii7Zd5veCr+4xrl7pT9dLrx/Zo/e1PtV7GXSwHBPlP9lm4+1m0LRuEN1OSqc oWogHgOAb5bPrgyaAiQGoeO3xRS7a58Mzm3jVl2f6iYKmZ+3GTQrKeyoYUhQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), split the memcpy() of the header and the payload
so no false positive run-time overflow warning will be generated.

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org

Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/surface/surface_acpi_notify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
index 44e317970557..50500e562963 100644
--- a/drivers/platform/surface/surface_acpi_notify.c
+++ b/drivers/platform/surface/surface_acpi_notify.c
@@ -355,7 +355,8 @@ static u32 san_evt_bat_nf(struct ssam_event_notifier *nf,
 	INIT_DELAYED_WORK(&work->work, san_evt_bat_workfn);
 	work->dev = d->dev;
 
-	memcpy(&work->event, event, sizeof(struct ssam_event) + event->length);
+	work->event = *event;
+	memcpy(work->event.data, event->data, event->length);
 
 	queue_delayed_work(san_wq, &work->work, delay);
 	return SSAM_NOTIF_HANDLED;
-- 
2.34.1

