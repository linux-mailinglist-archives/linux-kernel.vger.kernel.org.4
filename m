Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A115BD1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiISQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiISP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:59:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25933354
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r134so23247747iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pUn4t7LGIuBHcn9pbEoX7ny+qFkrwHq72tsErrsS46E=;
        b=P0QjsPmNe1GW+6RvsHxLh4YKSjvYRvgdviVs/VmaGx6cQgUDsUuaEhYaclxQXdQC9j
         srhHOvyWc6EQuMQLkK+YFY6O9wEyCL7I3e8Q7C2W5JW8MWhz/Vni7guUOvCtdbkPVpwj
         3VVnGh+3KEfaO7Mw4FZM6iVliR5z/6UcYj31k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pUn4t7LGIuBHcn9pbEoX7ny+qFkrwHq72tsErrsS46E=;
        b=n/LIK3S52skrmWQFiAmbnklpLo13joShEJlrSjBfMLRnDHIzYCcze+cItYQfhwu+tA
         CS882qtHJRvmDcA3oGcyrP57z4fHNaAdzg2bAA/1OtEDe7mNuOoPao8O5ACGREJtITxh
         HQZ0BqFNDQxqxD3HrdZcFOqFC2MD7W693rUFubtLDh9uOXzB6WVEqEAbdn+S7jnaXuMi
         1rjyl1rPIU1eho2EvN3O1ed+sotgENvaX5+4tohtyzR3T8YCy/ppC/kMjM49sjqCAv9L
         YE2LzBzxnb3PNoaG5UCmhwS7vd4bacCpqwlh7YW2547kdJnMnpGDokMFSDx2lgDdw6Yo
         0A3A==
X-Gm-Message-State: ACrzQf3xZkftu9y7TpKEuSAaqMRIwr6nXnk55F4cBhjiXIcRgiP2s3bb
        KDOf+3b8v7RyW19/KHzX8UCF3g==
X-Google-Smtp-Source: AMsMyM54ITLRKvir8ScMyAek/7DHrz6qcC4/52p/i0m45HVdEc+AJc9Rb849C11H3lKohistgy0q2w==
X-Received: by 2002:a02:bb0a:0:b0:35a:100f:74f3 with SMTP id y10-20020a02bb0a000000b0035a100f74f3mr8602064jan.237.1663603165715;
        Mon, 19 Sep 2022 08:59:25 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t70-20020a025449000000b00349fb9b1abesm5634154jaa.106.2022.09.19.08.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:59:25 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     timvp@google.com, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        mario.limonciello@amd.com, jingle.wu@emc.com.tw,
        mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
Date:   Mon, 19 Sep 2022 09:59:08 -0600
Message-Id: <20220919095504.v4.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220919155916.1044219-1-rrangel@chromium.org>
References: <20220919155916.1044219-1-rrangel@chromium.org>
MIME-Version: 1.0
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

ACPI IRQ/Interrupt resources contain a bit that describes if the
interrupt should wake the system. This change exposes that bit via
a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
before arming an IRQ to wake the system.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

Changes in v4:
- Added Reviewed-by
- Reformatted with 96 char limit

Changes in v3:
- Fixed bad indent

Changes in v2:
- Added ability to extract wake bit from Interrupt/IRQ resources

 drivers/acpi/irq.c             |  8 +++++---
 drivers/acpi/resource.c        | 23 ++++++++++++++++-------
 drivers/pnp/pnpacpi/rsparser.c |  7 ++++---
 include/linux/acpi.h           |  2 +-
 include/linux/ioport.h         |  3 ++-
 5 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index dabe45eba055d1..4bb5ab33a5ceb1 100644
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
index 510cdec375c4d8..fa3439aea76b3e 100644
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
@@ -532,9 +537,13 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			return false;
 		}
 		if (is_gsi(ext_irq))
-			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
-					 ext_irq->triggering, ext_irq->polarity,
-					 ext_irq->shareable, false);
+			acpi_dev_get_irqresource(res,
+						 ext_irq->interrupts[index],
+						 ext_irq->triggering,
+						 ext_irq->polarity,
+						 ext_irq->shareable,
+						 ext_irq->wake_capable,
+						 false);
 		else
 			irqresource_disabled(res, 0);
 		break;
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index da78dc77aed32e..4f05f610391b00 100644
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
index cd7371a5f2839b..ea2efbdbeee511 100644
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
index 616b683563a970..3baeea4d903bfd 100644
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
2.37.3.968.ga6b4b080e4-goog

