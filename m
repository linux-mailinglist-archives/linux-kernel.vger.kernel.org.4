Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2277B660C21
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 04:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbjAGDOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 22:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGDOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:14:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35448B53F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 19:14:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso3753088pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 19:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95kJcOt/ikThNKTdqewmJ/CgBxR51Y5xOIZwLQSCcrE=;
        b=kYwsB08+CWBm2ntQJcxzd406oSmeUX7X62aURGdszpiOSJ5peUzvreisyRJmZqlttW
         aLML4KJoMVRA7+8gCiobfD2jb0s6uhIzyUBNxH5UHMRQxwY3cdjln+s+4d1TzeFwIXI6
         2fFyXSEw+mI6nWmc0G3f89SmYpdFS7VAkfgbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95kJcOt/ikThNKTdqewmJ/CgBxR51Y5xOIZwLQSCcrE=;
        b=oRUCtoRCf+AxeTPXSc/HgbOSUptdFM3TzLPW+AouSBLXwrqPZGq8OHLaDDSCrYTDN6
         GEWiw8vUO2zdTbOFNC1Q0IzLXQNYhfH1jH2qGQFKtil8BZjvZ/3M09JmrQAS7QyXL5nI
         fxaLlfjk/Ch5QnrtekGwDdXGoSCsJ8Whv/UqEgkvcWiBdAj6Hgv/oamPWDmCvA7fOwMb
         plY06or/3PtqGcvSPgIWL4/bhFZaWBZ8S2FtGIFlR8ShGEMGtJ9Z0flyLU9yuuaMkkwp
         aX/cAeHppjQK6WcHEO4HxIffRHegIRbe5ZSlkrBOg2TkdUOcYXMjXHtUB8w6x94YlcNh
         ZqJA==
X-Gm-Message-State: AFqh2koKGd8VihLl//FkiC66R7HHOPStjwtasWo5NFyld5vAYjo9xINP
        qtsgHvzlT4Cz/vluLSmeFp9HZQ==
X-Google-Smtp-Source: AMrXdXsuFld/ch6CePsBUh/kn78v7/4CRF1u/NL0e/NTv25kqx98NdYnlHu2Fvy8jUMmWvuk28UbWg==
X-Received: by 2002:a05:6a20:65a9:b0:a5:df86:f0e1 with SMTP id p41-20020a056a2065a900b000a5df86f0e1mr77542877pzh.16.1673061253478;
        Fri, 06 Jan 2023 19:14:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bb9-20020a170902bc8900b00192c4055e72sm1598011plb.173.2023.01.06.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 19:14:12 -0800 (PST)
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
Subject: [PATCH v2] firmware: coreboot: Check size of table entry and split memcpy
Date:   Fri,  6 Jan 2023 19:14:10 -0800
Message-Id: <20230107031406.gonna.761-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; h=from:subject:message-id; bh=Hmpc+o4lwHPnt4nPVCo2lthNb1BNnwcQ159clj/k64U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjuOOBQ0hsMATs0ww/lc0c22TSgpuQUnwEptZZRMZS mHoWZV2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7jjgQAKCRCJcvTf3G3AJmNRD/ 9mC1D7F+9noWBc7+He3LuDcSkJtwNHumb6K17bFminY+yYvSz0OgYUIPwrgryLRNmECI1uDxqdc/1X 5iQGFdWTJX5vbZuAbQJpelg7ld3fmwFygs2w1D6NBFcO9V7czUPWwi6wE0b/+IfCOThlcQl21XaXgu tUAp7S2diCDjAf87FHArjHnizy+aDEF6E58IRQIFNR4mddB7z+0HAjumzGLsGhBXFVnb+hLnphbAB2 h0kkD0KwFpn8cnv6HxcZnT3+bxWnLO3StAHg6y69kb+j/IiODn4x7aPGiu3mjPJ9TCfu76TEkV4NVq nKNEFytEWzQoC/2HZ0cksrEwAWnM8CE1GiVvsGCXSKqHmkqTMqg1X7T12F76KHK37BEbm7uxm6YHFc q0oblhyQy8VmQ73HLXcjfqIDh+TkuakSEa7tvg7fkXvXhyAY821on/lXXvGGsHLDRmGtU2meFV9qSO tBMrtCoFn+R70d2JcBxOgA0OtOhOo33HnnFSMDaDuHbGn9hTYOYYRcm0GjDes+zXhcGaHHvf/CQabi 19D+9hHoZatdZ09FRh/DrhFMu4KEwhac+xgSU1ejDpCGDp1oIT7gdtmiQ03e5aNYUFgN3Ds59Qh+5p 0FMfJnm0QqsKYHGs/ph93J/svkxphKbhkg1g61WoaJetwltufydGJOyP5hRg==
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
---
v2: move flex array to struct coreboot_device (julius)
v1: https://lore.kernel.org/lkml/20230106045327.never.413-kees@kernel.org
---
 drivers/firmware/google/coreboot_table.c | 9 +++++++--
 drivers/firmware/google/coreboot_table.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2652c396c423..564a3c908838 100644
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
+		memcpy(device->raw, entry, entry->size);
 
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

