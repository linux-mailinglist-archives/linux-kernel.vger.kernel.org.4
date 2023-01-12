Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8316687B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjALXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjALXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:03:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB662C779
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:03:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bj3so17442698pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdXCfrcaOhbo0DQ24Gs3840B6JjcosyykPmZPSgByuo=;
        b=bxvhX+0hmxy3ZPmYMNbTYHE07nH/KsZIYfg32Chp9oNlLZDpwWZUPDvECabb2DzsMG
         gxbwAnEmKVEnHh06Vft0meiA//CacwKY2DP4/UXU87of+Gd6OlyD8gX1OHPsJk3tPs9T
         Hu98ycldMiYbUUz6mEH9Xo+dJPybPYTqYVqOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdXCfrcaOhbo0DQ24Gs3840B6JjcosyykPmZPSgByuo=;
        b=UYPd0ZlxbsKOQJtCgV4fT5dfXWzccemKnJgN38x+OMtjul14SmHgw5U3IJMMjnA/R8
         lrbXHTDQ1I592N9uzZIbwAseKms77Y9MNHFup0nfJTZJ2c2x6MUKt+onuONxPuFfj28E
         /QXsbcLdgWz+cshHsxLte8A7xxG24x3rRA0PDkH/c+TcypJdoOCcSlqhrqD18k9nnf4/
         x4NFOVehD38MX+wGe/T9SdgTrAfSz7XFP3tQZ9FTgyRNLgnDz08Upbebl5ocxD1QtnIU
         K4eJzpq+jNANrGsTy36IGpVJCB5buuOvhNTtRVRG4C31br2BFZn15IMqMXEtDCQce7hp
         amRQ==
X-Gm-Message-State: AFqh2kqaA59DrIZpC28RZYzRnoU1HqKPxWcPJ+sc669MGWk5hPMHZJOh
        0w5ad7Ks+yAfT10KegDPxmhu6A==
X-Google-Smtp-Source: AMrXdXswEU6ydJ3XG14OCeHZAgL8erfqvc4yRlswnRuUZkxfKpn0AanNRi/5PgPFcRQcu/CDp09+uw==
X-Received: by 2002:a17:902:c7d5:b0:193:678:df13 with SMTP id r21-20020a170902c7d500b001930678df13mr6691748pla.36.1673564603372;
        Thu, 12 Jan 2023 15:03:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm12735726plh.124.2023.01.12.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:03:22 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] firmware: coreboot: Check size of table entry and split memcpy
Date:   Thu, 12 Jan 2023 15:03:16 -0800
Message-Id: <20230112230312.give.446-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; h=from:subject:message-id; bh=HfkDZoD0PsXY4HCTv6rs6peb74009vSJZfmw29HWd/4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjwJG0AROMg+H6Lwp93tzJz/6vP4x3vFzj4NCq83KJ x4bYDzmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY8CRtAAKCRCJcvTf3G3AJmYHD/ 9L/bO+ehwRJLdw5vRp4w+HBmWiUltUbVKOowr8ltP37OsJY37jfO9ayPMHiDiWQol3tDRyg6dZmyos ciicocwSfcq0y+7LkUxTV3JDwJ4TBRUQaY2V73KbFEu3PlLBdb0FIPtmhl2vtohb9tX8BsUIB5GmhN oufs1FW8y0ccHhG3KZGwHE1HD+5QcqjXWIC/RK1Wdz4/rW8e64DhndJPmR/6AFwT8bBk+qUPYTwA8A laagHqql5h34QUP+0wBIc4E+cQkr7BN0zqc2mvOhUfzV2CzZHzlBO6KKyw0eAox9o0bF3Iv1Rv9YP8 R3ymJWCW1dZAwIYMdmrtVw/OJkE4fLpjzNa0++M4T0G6EugPri9LC02YdED9dneLkwhqvToB5pdD5M KLQk6ibQr1N+Z1nuseEoEfBjnfw20bVMRiopdgtN1FU3P6cwmismJ/QUQPAikbdBVO7hIu1OtVntYh iUFULy7sDdpWSa0EDuZDzQtClLLv1196k/dW6F2gaW0cTlTvpX8vEESFhsGru1yW8GJAr3cXPJVxqS GXelk3nMJkw9qTmKEy0eRFNaE9VGFKIHcr9TBsq7fo22msNo3yxpG9BPztrtZZSfT2axQv5CpdaZfV bKP/Tx/kACO329hJCa7B9wgCUcGmv+SS3NxfdI26MkjsHh5/91vsrNWY4deg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy() of the data following a coreboot_table_entry couldn't
be evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it
easier to reason about, add an explicit flexible array member to struct
coreboot_device so the entire entry can be copied at once. Additionally,
validate the sizes before copying. Avoids this run-time false positive
warning:

  memcpy: detected field-spanning write (size 168) of single field "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/all/03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de/
Cc: Jack Rosenthal <jrosenth@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20230107031406.gonna.761-kees@kernel.org
---
v3: leave memcpy source as ptr_entry (jwerner)
v2: https://lore.kernel.org/lkml/20230107031406.gonna.761-kees@kernel.org
v1: https://lore.kernel.org/lkml/20230106045327.never.413-kees@kernel.org
---
 drivers/firmware/google/coreboot_table.c | 9 +++++++--
 drivers/firmware/google/coreboot_table.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2652c396c423..33ae94745aef 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -93,14 +93,19 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 	for (i = 0; i < header->table_entries; i++) {
 		entry = ptr_entry;
 
-		device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
+		if (entry->size < sizeof(*entry)) {
+			dev_warn(dev, "coreboot table entry too small!\n");
+			return -EINVAL;
+		}
+
+		device = kzalloc(sizeof(device->dev) + entry->size, GFP_KERNEL);
 		if (!device)
 			return -ENOMEM;
 
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
-		memcpy(&device->entry, ptr_entry, entry->size);
+		memcpy(device->raw, ptr_entry, entry->size);
 
 		switch (device->entry.tag) {
 		case LB_TAG_CBMEM_ENTRY:
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 37f4d335a606..d814dca33a08 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -79,6 +79,7 @@ struct coreboot_device {
 		struct lb_cbmem_ref cbmem_ref;
 		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
+		DECLARE_FLEX_ARRAY(u8, raw);
 	};
 };
 
-- 
2.34.1

