Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075825B637B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiILWOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiILWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:14:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5E4E621
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q83so6084337iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AO8ELqmpv4JTpt7IbubS6DP/bQTOugLMw7Qn2st0yGY=;
        b=XSp5pncr9yu/es3paVMOJaxYPzJhZW5sFXx4sOGyu+zkxl0xUR9EQ2ROZ0HHsGbfzI
         RX1Bp8NZRQZ51QjuNk5OlgbiBl8MIAZx54hrbftzqE6Ew7WNPIb3aATT1ssatyQHpF3D
         Zo0lpM7MeqH2La8keyYOYYttUoxJlynbnBdok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AO8ELqmpv4JTpt7IbubS6DP/bQTOugLMw7Qn2st0yGY=;
        b=o4zHrAfT2z2mq/nipZwY0v106G1MplkcKH7qP7fGtEMaXr5dUH0EIMcKwBiouxNw4f
         ytZ9dDWfq8orMqI6F9KH278Pryv5qnqHdsu7BQtdXC7rclVH7vOVZdSQv7V3b2HZBIgt
         qRkR8edSC6Mubqe93MD0Cj93Sy3RzfBY+xoz/UyrbQQZsW2UoIPVQw3ZgiLAcrZbunGc
         dRmIpHjmLgPHrYqmhvE3y2mSBdy5F19cIaaopMuwiTGZ3Ntw5ZfUagVfh9Hor1nhAME2
         jX6dE5o8Xdlld4dyRnzxpU1Am4+m1ckMf7aXVNzHdhkFr6rp5EAHSBEDYJibVa2tCS78
         18GQ==
X-Gm-Message-State: ACgBeo1Nsh16oyesdirhBCG2VJJs6DtmcidPb5gu+Pe9/MSXpgf4dBxf
        uL2vZ/l0yQL5w/kKZabPltzVUA==
X-Google-Smtp-Source: AA6agR4j7otLmc4Qt+KhYnFBTvDOoaO/IFebheo79BvjoHtEC90WfKYj6d4ZvVT/o43pV21YYR7DAA==
X-Received: by 2002:a05:6638:4416:b0:35a:3cca:4db3 with SMTP id bp22-20020a056638441600b0035a3cca4db3mr3340109jab.0.1663020833972;
        Mon, 12 Sep 2022 15:13:53 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:13:53 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
Date:   Mon, 12 Sep 2022 16:13:10 -0600
Message-Id: <20220912160931.v2.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912221317.2775651-1-rrangel@chromium.org>
References: <20220912221317.2775651-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---

Changes in v2:
- Added ability to extract wake bit from Interrupt/IRQ resources

 drivers/acpi/irq.c             | 11 ++++++++---
 drivers/acpi/resource.c        | 24 +++++++++++++++++-------
 drivers/pnp/pnpacpi/rsparser.c |  9 ++++++---
 include/linux/acpi.h           |  3 ++-
 include/linux/ioport.h         |  3 ++-
 5 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index dabe45eba055d1..5483cf9a28e3a0 100644
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
@@ -156,12 +157,14 @@ struct acpi_irq_parse_one_ctx {
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
+	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable,
+					     wake_capable);
 	ctx->fwspec->fwnode = fwnode;
 	ctx->fwspec->param[0] = hwirq;
 	ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
@@ -204,7 +207,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 		fwnode = acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
 					 irq->triggering, irq->polarity,
-					 irq->shareable, ctx);
+					 irq->shareable, irq->wake_capable,
+					 ctx);
 		return AE_CTRL_TERMINATE;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		eirq = &ares->data.extended_irq;
@@ -218,7 +222,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
 						      eirq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
 					 eirq->triggering, eirq->polarity,
-					 eirq->shareable, ctx);
+					 eirq->shareable, eirq->wake_capable,
+					 ctx);
 		return AE_CTRL_TERMINATE;
 	}
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 510cdec375c4d8..6a1c008a348902 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -336,8 +336,10 @@ EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
  * @triggering: Triggering type as provided by ACPI.
  * @polarity: Interrupt polarity as provided by ACPI.
  * @shareable: Whether or not the interrupt is shareable.
+ * @wake_capable: Wake capability as provided by ACPI.
  */
-unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
+unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable,
+				 u8 wake_capable)
 {
 	unsigned long flags;
 
@@ -351,6 +353,9 @@ unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
 	if (shareable == ACPI_SHARED)
 		flags |= IORESOURCE_IRQ_SHAREABLE;
 
+	if (wake_capable == ACPI_WAKE_CAPABLE)
+		flags |= IORESOURCE_IRQ_WAKECAPABLE;
+
 	return flags | IORESOURCE_IRQ;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_irq_flags);
@@ -442,7 +447,7 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
-				     bool check_override)
+				     u8 wake_capable, bool check_override)
 {
 	int irq, p, t;
 
@@ -475,7 +480,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		}
 	}
 
-	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
+	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable,
+					wake_capable);
 	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
 	if (irq >= 0) {
 		res->start = irq;
@@ -523,7 +529,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
 					 irq->triggering, irq->polarity,
-					 irq->shareable, true);
+					 irq->shareable, irq->wake_capable,
+					 true);
 		break;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
@@ -532,9 +539,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
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
+						 ext_irq->wake_capable, false);
 		else
 			irqresource_disabled(res, 0);
 		break;
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index da78dc77aed32e..55b28fc0a94042 100644
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
@@ -315,7 +316,8 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 		if (p->interrupts[i])
 			__set_bit(p->interrupts[i], map.bits);
 
-	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
+	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable,
+				   p->wake_capable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
@@ -339,7 +341,8 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 		}
 	}
 
-	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
+	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable,
+				   p->wake_capable);
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7ee946758c5bcc..10ecf935e59431 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -495,7 +495,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 				     struct resource_win *win);
 bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
 					 struct resource_win *win);
-unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
+unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable,
+				 u8 wake_capable);
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
2.37.2.789.g6183377224-goog

