Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCCA716FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjE3Vr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjE3Vrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE1DE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685483220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mzt6sKEeGzbAhjgpcG+38PHhkqIkbsGljCwJXP3Xp9M=;
        b=V5JJHPYTJis3IcKAzRh5Mu1Yul7fL2MMXCXTUTs0FgohOyPKu/OAfOojCUkH8uc1Ugr6MY
        hsCaSnoEAMdz8h+qd0+KuTiSvTMrkvdt2Ws6xKs7FLWUINh6xnk70NimXn55Co9I/rsHZM
        pPXxsDI5yUOLspcYXEbAyhaHoRHbqwA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Vw-0BepCOKGPYqD7M1bJPg-1; Tue, 30 May 2023 17:46:59 -0400
X-MC-Unique: Vw-0BepCOKGPYqD7M1bJPg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62628df5347so17341036d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483218; x=1688075218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzt6sKEeGzbAhjgpcG+38PHhkqIkbsGljCwJXP3Xp9M=;
        b=fI/aBKVg9GapZzYPqilb8k5Nm/V6+pyEbzR0OwcWkrXZCiyKCXNOfSlGtUKaluHLB8
         STCPB+zaZuOM6dn51nUqD1fMr+GUcHaKePoWmNlcSU46lkXF/0f71m1jTtfnQy8Gazz6
         tQM81KROkLld0SDaOms1rahVYpKVRtkD+5ipgppq1GmjkT4jKT4J6oVQBdv5ybbc/FaB
         mtZwcTjikxsef/83ny+KxUg22zXT1YeM4HfX8fk48zzSRTZiyNyfdjbIkQh/wVJ7Z5NG
         KAfB1CMNrD5sFH/ZXShDM6053v0S410Zgv/rLsutqqdjd0nrRCv0MtV5PW+TmEHUUrsc
         qIDQ==
X-Gm-Message-State: AC+VfDxe6eHa4/SQmwAMkEFUMAOuZj2AJ5596BZSUtTJyufCu1smsT2X
        gIJ80LEX4zBb+/ewm94VZPUw2HpUbxZOIjC2pTPtGz9bJCIMcFr/giKpK3FL7yjVAGiNYXX04dE
        uL1fzP2fQBG2np6I+oY7eA/7tyRKcbp2+Nyjc9KomHhBmZK1ODEFtexBnywhXodNiaSVKQh6WZU
        H/LAU+eKg=
X-Received: by 2002:ac8:5a86:0:b0:3f6:c5c7:fc4e with SMTP id c6-20020ac85a86000000b003f6c5c7fc4emr3188024qtc.28.1685483218357;
        Tue, 30 May 2023 14:46:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zCQBYTcNi3MNR4maQxvAuFFkrUSI9JhR5Cr2+0YfjZ9mnql4AGPNwdm54QH3B3he3a40f9w==
X-Received: by 2002:ac8:5a86:0:b0:3f6:c5c7:fc4e with SMTP id c6-20020ac85a86000000b003f6c5c7fc4emr3188009qtc.28.1685483218068;
        Tue, 30 May 2023 14:46:58 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm5121602qtc.82.2023.05.30.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:46:57 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 5/5] irq: Add smp_affinity/list attributes to sysfs
Date:   Tue, 30 May 2023 17:45:50 -0400
Message-Id: <20230530214550.864894-6-rrendec@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530214550.864894-1-rrendec@redhat.com>
References: <20230530214550.864894-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the smp_affinity and smp_affinity_list attributes to the
sysfs interrupt interface. The implementation is identical to procfs,
and the attributes are visible only when CONFIG_SMP is enabled.

The intention is to allow SMP affinity to be controlled for chained
interrupt parents, which are typically not visible in procfs because
they are not requested through request_irq().

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 kernel/irq/irqdesc.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a46a76c29b8d1..5b014df9fd730 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -210,6 +210,9 @@ static struct kobject *irq_kobj_base;
 #define IRQ_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
+#define IRQ_ATTR_RW(_name) \
+static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
+
 static ssize_t per_cpu_count_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
@@ -332,6 +335,54 @@ static ssize_t actions_show(struct kobject *kobj,
 }
 IRQ_ATTR_RO(actions);
 
+#ifdef CONFIG_SMP
+static ssize_t smp_affinity_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	const struct cpumask *mask = desc->irq_common_data.affinity;
+
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+	if (irqd_is_setaffinity_pending(&desc->irq_data))
+		mask = desc->pending_mask;
+#endif
+
+	return scnprintf(buf, PAGE_SIZE, "%*pb\n", cpumask_pr_args(mask));
+}
+static ssize_t smp_affinity_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+
+	return write_irq_affinity(desc->irq_data.irq, buf, count, false, false);
+}
+IRQ_ATTR_RW(smp_affinity);
+
+static ssize_t smp_affinity_list_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	const struct cpumask *mask = desc->irq_common_data.affinity;
+
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+	if (irqd_is_setaffinity_pending(&desc->irq_data))
+		mask = desc->pending_mask;
+#endif
+
+	return scnprintf(buf, PAGE_SIZE, "%*pbl\n", cpumask_pr_args(mask));
+}
+static ssize_t smp_affinity_list_store(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+
+	return write_irq_affinity(desc->irq_data.irq, buf, count, true, false);
+}
+IRQ_ATTR_RW(smp_affinity_list);
+#endif
+
 static struct attribute *irq_attrs[] = {
 	&per_cpu_count_attr.attr,
 	&chip_name_attr.attr,
@@ -340,6 +391,10 @@ static struct attribute *irq_attrs[] = {
 	&wakeup_attr.attr,
 	&name_attr.attr,
 	&actions_attr.attr,
+#ifdef CONFIG_SMP
+	&smp_affinity_attr.attr,
+	&smp_affinity_list_attr.attr,
+#endif
 	NULL
 };
 ATTRIBUTE_GROUPS(irq);
-- 
2.40.1

