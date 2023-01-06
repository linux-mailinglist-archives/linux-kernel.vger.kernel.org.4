Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2174D65FAC8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAFExm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 23:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAFExh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:53:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023A63197
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:53:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 141so528575pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 20:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucPcZnvSnliyKzF3FzS8x9nzvdgl+X568XlSsg8Ujag=;
        b=eFlpYJt6BGx10WuGmSHJ06RVtgefzYMk7o4vICRBvI+Ce0zRR8yeR+JT9I18WQ69OC
         ob6+aKLKxGJOPepO5ZQWScCPVpiDYXGZRv8h9PNGf3YXc4XkvVu7OyCXawqq22RzPuKs
         oMCuWakE0bVYs2a6SPxVYMaC+xHAFg503LRuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucPcZnvSnliyKzF3FzS8x9nzvdgl+X568XlSsg8Ujag=;
        b=U9zNYvBdj/9693wjjb+93z+kkqxqyo0cmMhzIMcemkWveqbI6gmlaAHBNJDO2ij2Ai
         /1OoX1YwwSuE3Hs9IjDhvvobt/nvXiNNCEGJSILtfwqDMlHl53ZrpAZTJiMsx+QtFogO
         VQuZUaRgmrOYokSUBCGcrsRv8oZdG1+cfXEtC8UmuFePQVlLl4T+x1EokCqcZ3MTk+0z
         MmSV5uffTpBvzzJQIuvBlDSdDsH17Elon9JDRz/rS+2qafTLqqBJKr0s+w72LYpBHxIt
         YVG4CrunAkc+t/z8pRGIBn2G+tlQWBA+g9BqMgSmp6jnE0XVL1nuJYvbqCkSKxQIwQPH
         V0Cw==
X-Gm-Message-State: AFqh2kpJc8EtDvoMVh6cEvBgbcy0HT5to4XUmv8uK0C2HxFHmarFW/1i
        THqAH+9hcwefSh6qZ6W/l7gmuA==
X-Google-Smtp-Source: AMrXdXupEo1fXUBQN+JRRn4cBXjEpm73Fpc6gTeW4dT+eNE6AKecNP/lnbEaZbnHWV28zIEIxQ5aVg==
X-Received: by 2002:a62:16cb:0:b0:581:1f5c:503a with SMTP id 194-20020a6216cb000000b005811f5c503amr40718388pfw.18.1672980814752;
        Thu, 05 Jan 2023 20:53:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12-20020aa796cc000000b0058248f4a02esm122524pfq.156.2023.01.05.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 20:53:34 -0800 (PST)
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
Subject: [PATCH] firmware: coreboot: Check size of table entry and split memcpy
Date:   Thu,  5 Jan 2023 20:53:31 -0800
Message-Id: <20230106045327.never.413-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; h=from:subject:message-id; bh=y0kHdLQi26hCPCDdF7wSoFT5L8ipKqZIT/AYPWfrvc8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt6lLAoWBga5/pBxWWkCo53mTYpyBj/uSUyZ1qjbz DFcCCH2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7epSwAKCRCJcvTf3G3AJlGRD/ 9DdzPO9m2f7qqnggZhpZCkTsM83e7t8P2ROCVZUyAz8J5s3Jn6DOTkhSwEplsYfIMjQancSOywepFi CHXaZxSeRc/3cB5vCsWRccBLyOgeVxaVAgn5t/Ijj98SxkIfcmhrjEirT3QpYhqSEJ9oEcOKhOJ8FN GHwTaxYAM7nUtwvroa9yCH5EtswTYCJevBnh0PhciGQeAHjgU+CBpSlc0F24tTBtnRrteOod6M2Ent rkx00XL+bC/VSJoqCTRk5Rjqvnz3hD078J+XbNO7gx1Krk1CGwZfD5B/YmRy1eyKU5vcMesMZ9H7vU adg9DpxdXJqZsgZSiVsBPBOaQN0x/9t1Uyr1lHToWjw8SRFbnjjiZfAE/Z+1UO9nzzEwE0JNdQKQBH iGeDg8Cnh0Mg1lz82GfzQxON176tME8uw+j4ygqed7UuxXubRT04UWkJ2mFVth17lZZyZP4p+IejgO Lze3jayHOGg7mi9LtRzQYp7ICfMDDcEQjGhn/hB5LN0QdujsFuJOiaWf4r5LTLZe62I8tU2+s4IbsO +SLrfrz8WIk3/qgUuzwUZeMoWK3rkoiuKz0wSs5+6YL9Cf+RW68wgCj7hKKcpjOdCEoH2L48+et5LY zP5rqZWvRbkHRlELZ6xNDqoD985LGFsCFTelbo86RtG5WI1E7QDRBk4hUGug==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy() of the data following a coreboot_table_entry couldn't be
evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it easier
to reason about, add an explicit flexible array member to struct
coreboot_table_entry, and validate the sizes before copying. Avoids this
run-time false positive warning:

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
---
 drivers/firmware/google/coreboot_table.c | 8 +++++++-
 drivers/firmware/google/coreboot_table.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2652c396c423..102edfb4eb7b 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -93,6 +93,11 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 	for (i = 0; i < header->table_entries; i++) {
 		entry = ptr_entry;
 
+		if (entry->size < sizeof(*entry)) {
+			dev_warn(dev, "coreboot table entry too small!\n");
+			return -EINVAL;
+		}
+
 		device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
 		if (!device)
 			return -ENOMEM;
@@ -100,7 +105,8 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
-		memcpy(&device->entry, ptr_entry, entry->size);
+		device->entry = *entry;
+		memcpy(device->entry.data, entry->data, entry->size - sizeof(*entry));
 
 		switch (device->entry.tag) {
 		case LB_TAG_CBMEM_ENTRY:
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 37f4d335a606..2a2cea79204b 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -29,6 +29,7 @@ struct coreboot_table_header {
 struct coreboot_table_entry {
 	u32 tag;
 	u32 size;
+	u8 data[];	/* Size here is: "size - (sizeof(u32) * 2)" */
 };
 
 /* Points to a CBMEM entry */
-- 
2.34.1

