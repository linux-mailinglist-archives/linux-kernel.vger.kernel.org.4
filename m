Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583885EFA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiI2QUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiI2QTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:19:31 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777EE1E0C4B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:28 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d14so952833ilf.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trAVAQ/Rk+05nanA+Ls+tVQdWt1P+e+XoZ1M5Mz7QPs=;
        b=ClCJa5EeIpkbGLUnO1iAjuRXn86T2iN6ujl8XRaJrvhJ8kpYKDupSHzyOl+yFht1AK
         ITKHOMHT71jNBG4ppllwJpnzN5TyyA/7lAgRygqNezwuivEvblef33AlkTVG1OYDz2LE
         IUHEqhZY2+5M/i6riHlVmhYyC/aicDj6wd9SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trAVAQ/Rk+05nanA+Ls+tVQdWt1P+e+XoZ1M5Mz7QPs=;
        b=1w8Lnd26bDUbMGGe+95j/tzg45xQ9nYGJeRmAChoeKnLiWX8rFmXf9lnE8Ety4UaS4
         EFEyDvJgMqDF+aovdSfU0W7Ozop0XBNqxoNonYOnBlSm10HRTUhDmmebhi/tTnxeZe0O
         4SF3Pq1n8RFVto1tDKbSWE1Nyk9JA7B97vsRcW0rWiBER3FRvcIdiHS3CkUouV4Pejsh
         LmngP2qBJ5rW5IbmcWYEqY+tg5mt5UfdSa9S8j1UvyvpbdQ1byo8qFTnEgzqVY0TVF5l
         eORymATW2EZuQNOZO8Ade5M3a7M4xhJurNPhmtxujKQYg5L/1reBQr1OWUFpyBQWkxck
         YLYg==
X-Gm-Message-State: ACrzQf0fmvUU5GqkQsmw8Mlw0t2Z7S0NOt8EeuPvVcD4FqIF0EL3FLyP
        SmkWJ5XzS3lVsMp47dDfXQ5PiA==
X-Google-Smtp-Source: AMsMyM4zClFMoDKbvaeEW+zlLBZjqnVkfst4kRK+81w90pZm1NYPxNwRdJR9ZKhjrxM+yROnPglfzA==
X-Received: by 2002:a92:c988:0:b0:2f6:16a8:a4cb with SMTP id y8-20020a92c988000000b002f616a8a4cbmr1947632iln.241.1664468368183;
        Thu, 29 Sep 2022 09:19:28 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a02848c000000b0035aab2f1ab1sm2965451jai.134.2022.09.29.09.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:19:27 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Raul E Rangel <rrangel@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
Date:   Thu, 29 Sep 2022 10:19:10 -0600
Message-Id: <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220929161917.2348231-1-rrangel@chromium.org>
References: <20220929161917.2348231-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI IRQ/Interrupt resources contain a bit that describes if the
interrupt should wake the system. This change exposes that bit via
a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
before arming an IRQ to wake the system.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

(no changes since v5)

Changes in v5:
- Removed clang-format white space changes

Changes in v4:
- Added Reviewed-by
- Reformatted with 96 char limit

Changes in v3:
- Fixed bad indent

Changes in v2:
- Added ability to extract wake bit from Interrupt/IRQ resources

 drivers/acpi/irq.c             |  8 +++++---
 drivers/acpi/resource.c        | 16 +++++++++++-----
 drivers/pnp/pnpacpi/rsparser.c |  7 ++++---
 include/linux/acpi.h           |  2 +-
 include/linux/ioport.h         |  3 ++-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index dabe45eba055d1f..4bb5ab33a5ceb10 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -147,6 +147,7 @@ struct acpi_irq_parse_one_ctx {
  * @polarity: polarity attributes of hwirq
  * @polarity: polarity attributes of hwirq
  * @shareable: shareable attributes of hwirq
+ * @wake_capable: wake capable attribute of hwirq
  * @ctx: acpi_irq_parse_one_ctx updated by this function
  *
  * Description:
@@ -156,12 +157,13 @@ struct acpi_irq_parse_one_ctx {
 static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
 					    u32 hwirq, u8 triggering,
 					    u8 polarity, u8 shareable,
+					    u8 wake_capable,
 					    struct acpi_irq_parse_one_ctx *ctx)
 {
 	if (!fwnode)
 		return;
 	ctx->rc = 0;
-	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable);
+	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable, wake_capable);
 	ctx->fwspec->fwnode = fwnode;
 	ctx->fwspec->param[0] = hwirq;
 	ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
@@ -204,7 +206,7 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 		fwnode = acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
 					 irq->triggering, irq->polarity,
-					 irq->shareable, ctx);
+					 irq->shareable, irq->wake_capable, ctx);
 		return AE_CTRL_TERMINATE;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		eirq = &ares->data.extended_irq;
@@ -218,7 +220,7 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 						      eirq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
 					 eirq->triggering, eirq->polarity,
-					 eirq->shareable, ctx);
+					 eirq->shareable, eirq->wake_capable, ctx);
 		return AE_CTRL_TERMINATE;
 	}
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 510cdec375c4d88..81733369f4c1de0 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -336,8 +336,9 @@ EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
  * @triggering: Triggering type as provided by ACPI.
  * @polarity: Interrupt polarity as provided by ACPI.
  * @shareable: Whether or not the interrupt is shareable.
+ * @wake_capable: Wake capability as provided by ACPI.
  */
-unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
+unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable, u8 wake_capable)
 {
 	unsigned long flags;
 
@@ -351,6 +352,9 @@ unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
 	if (shareable == ACPI_SHARED)
 		flags |= IORESOURCE_IRQ_SHAREABLE;
 
+	if (wake_capable == ACPI_WAKE_CAPABLE)
+		flags |= IORESOURCE_IRQ_WAKECAPABLE;
+
 	return flags | IORESOURCE_IRQ;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_irq_flags);
@@ -442,7 +446,7 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
-				     bool check_override)
+				     u8 wake_capable, bool check_override)
 {
 	int irq, p, t;
 
@@ -475,7 +479,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		}
 	}
 
-	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
+	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable, wake_capable);
 	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
 	if (irq >= 0) {
 		res->start = irq;
@@ -523,7 +527,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
 					 irq->triggering, irq->polarity,
-					 irq->shareable, true);
+					 irq->shareable, irq->wake_capable,
+					 true);
 		break;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
@@ -534,7 +539,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		if (is_gsi(ext_irq))
 			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
 					 ext_irq->triggering, ext_irq->polarity,
-					 ext_irq->shareable, false);
+					 ext_irq->shareable, ext_irq->wake_capable,
+					 false);
 		else
 			irqresource_disabled(res, 0);
 		break;
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index da78dc77aed32e4..4f05f610391b006 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -206,7 +206,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		if (i >= 0) {
 			flags = acpi_dev_irq_flags(gpio->triggering,
 						   gpio->polarity,
-						   gpio->shareable);
+						   gpio->shareable,
+						   gpio->wake_capable);
 		} else {
 			flags = IORESOURCE_DISABLED;
 		}
@@ -315,7 +316,7 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], map.bits);
 
-	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
+	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable, p->wake_capable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
@@ -339,7 +340,7 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 		}
 	}
 
-	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
+	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable, p->wake_capable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index cd7371a5f2839bd..ea2efbdbeee5116 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -495,7 +495,7 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 				     struct resource_win *win);
 bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 					 struct resource_win *win);
-unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
+unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable, u8 wake_capable);
 unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
 bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 				 struct resource *res);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 616b683563a9704..3baeea4d903bfd1 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -79,7 +79,8 @@ struct resource {
 #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
 #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
 #define IORESOURCE_IRQ_SHAREABLE	(1<<4)
-#define IORESOURCE_IRQ_OPTIONAL 	(1<<5)
+#define IORESOURCE_IRQ_OPTIONAL		(1<<5)
+#define IORESOURCE_IRQ_WAKECAPABLE	(1<<6)
 
 /* PnP DMA specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
-- 
2.37.3.998.g577e59143f-goog

