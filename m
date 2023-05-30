Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEE716FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjE3Vrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjE3Vr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE846106
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685483206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqBO6vTTzk4oznJ9hlyfyIGAmPcF6erUeOSR8ZOo0PY=;
        b=OW58rvcUtcki+xz7VT5F9+UETeGNCkfHo9a6qSIfAaM6uxPMeP1rhRyga6FkGCF61mazU9
        3fMYDN31KnBWG9m+OA4ZrKk9vBuBsb3vD6fxDn4qEJ7k965vyq+h3egj8I538Cw2b3SADA
        b0gC+QnR9xfZFCxImVcmI11k0bXEY+g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-OGnXMq6ANB6wrNGukqlJpA-1; Tue, 30 May 2023 17:46:45 -0400
X-MC-Unique: OGnXMq6ANB6wrNGukqlJpA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f80f8e5eb1so29727291cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483204; x=1688075204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqBO6vTTzk4oznJ9hlyfyIGAmPcF6erUeOSR8ZOo0PY=;
        b=jObzNqv7DJrokVuyoErZ6uhPepsbthrV3uCxgxEadOhFVjSlDlGprPBap9zOH74E28
         J9tuaWdzf1f+pfad6sFwmQazM9dewLUw+fs0DUlsePXi4CYzPFI7b2MPrleuWu4oZ6fz
         zb3GmDNJwoQU+hVDfF2frbhhZmCmVLaitAFyKlspH0TjBAv2BLMNJd2l80PyQVPJYwXD
         axnqXXqeraDnUvEsj/RHgW44857qsQ5kMe43Ecw6hf6HoQ3AP0l50N88/RZ6en5EB/KZ
         3LzboP8/AKqqLRHmXE81gCnjAN8zobdUJhvxJmnv+Po9o1H7OH4wp60DZ870fvwKkXkX
         fESQ==
X-Gm-Message-State: AC+VfDwZ2qofCGrNbHlSQU7QngptG2qVfMP0XrysWtUWLAUlre3Co7a/
        JtyhXGePSPrhutZ/Yb3mXRK5/iap8cssYBajr9Gfhf60yXOtMNnpdMOQL5px04PtfzM5gOvvW52
        Z5Mx3OSsXGCFmEu0qZnuKVEJeffzg+nQvTAGFBCdHk78BXtKxVmFa947UswmJC/CVYt4SrnuSU3
        N8kGyX7jA=
X-Received: by 2002:a05:622a:203:b0:3f3:669f:473a with SMTP id b3-20020a05622a020300b003f3669f473amr3798147qtx.57.1685483204472;
        Tue, 30 May 2023 14:46:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qcQD/xcCnlOGQcJjUFjRM/CuzaO9UDyH56GpMOoIAI4SyN1rp1LEW0R+l/WFlqgoPFhwTrw==
X-Received: by 2002:a05:622a:203:b0:3f3:669f:473a with SMTP id b3-20020a05622a020300b003f3669f473amr3798132qtx.57.1685483204182;
        Tue, 30 May 2023 14:46:44 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm5121602qtc.82.2023.05.30.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:46:43 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/5] irq: Always enable parent interrupt tracking
Date:   Tue, 30 May 2023 17:45:46 -0400
Message-Id: <20230530214550.864894-2-rrendec@redhat.com>
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

The kernel already has some support for tracking the parent interrupt in
the case of chained interrupts, but it is currently used only by the
IRQ-resend code.

This patch enables the parent interrupt tracking code unconditionally.
The IRQ-resend code still depends on CONFIG_HARDIRQS_SW_RESEND.

The intention is to (re)use the existing parent interrupt tracking
support for different purposes, more specifically to expose chained
interrupt topology to userspace. That, in turn, makes it possible to
control the SMP affinity of chained interrupts in a way that does not
break the existing interface and the promises it makes.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 include/linux/irq.h | 7 -------
 kernel/irq/manage.c | 2 --
 2 files changed, 9 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1b28affb32a7..7710f157e12de 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -641,14 +641,7 @@ static inline void irq_force_complete_move(struct irq_desc *desc) { }
 
 extern int no_irq_affinity;
 
-#ifdef CONFIG_HARDIRQS_SW_RESEND
 int irq_set_parent(int irq, int parent_irq);
-#else
-static inline int irq_set_parent(int irq, int parent_irq)
-{
-	return 0;
-}
-#endif
 
 /*
  * Built-in IRQ handlers for various IRQ types,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index eb862b5f91c42..49683e55261eb 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1004,7 +1004,6 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 	return ret;
 }
 
-#ifdef CONFIG_HARDIRQS_SW_RESEND
 int irq_set_parent(int irq, int parent_irq)
 {
 	unsigned long flags;
@@ -1019,7 +1018,6 @@ int irq_set_parent(int irq, int parent_irq)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_set_parent);
-#endif
 
 /*
  * Default primary interrupt handler for threaded interrupts. Is
-- 
2.40.1

