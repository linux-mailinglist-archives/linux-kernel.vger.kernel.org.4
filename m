Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89907716FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjE3Vro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjE3Vrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87897113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685483210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiTjFtC5d0ywUVJqroEDBw4SKoGPctycpTO5H1+bDbM=;
        b=ZGQGNDwghOz/zHt6JCmxWxPFGR/fOxQRPokCUgNScpBe4HutbhCUCeX4/NdkEwUVs20NET
        kB3Z6/pXvbUqmPdMjhBqLZ4WMM8EnDEBEbHwC8fxNQ5NqnG8+zCfvpRHFAGpLk+PksD7CZ
        VLZLqrJaHvkz/zp5drXddcV8uIy2cKk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-sm858xiiNDm4UL5gzh2iyQ-1; Tue, 30 May 2023 17:46:49 -0400
X-MC-Unique: sm858xiiNDm4UL5gzh2iyQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6aaa6df23so33489581cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483208; x=1688075208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiTjFtC5d0ywUVJqroEDBw4SKoGPctycpTO5H1+bDbM=;
        b=RLQYXE/MATdKC/lPPl8QxquWtyHIc987oauSx4OZfsRdrBNdnnz0Ya+UCTmri0GLm1
         xsTKxCQHdoKIKaQ9LZsIHDqSW0mxjL3iDy6hPQy+Z4Ay0bpBa0yvUgM/tKp1RPUCVKvP
         7qtzzmzqTBinf916uw1hXd/y16hQ9K58zIoWxB5Cj2trzIT9yNAw/F7X+sLyjUFcfuYb
         lQx9/Aa9JjajKCvxpDdInd3ajX1ek5ZOrHV2vifsZiMBqHYqJqmwGpHGMdFmiPxnQp8R
         819IbdFoHdwwZQ5xnSrZbAbPsanBzHYAPaUvdwiv8DyYq/Q8olfQyRBLr+2qVrsaS3Gm
         YAlA==
X-Gm-Message-State: AC+VfDzKBcF+uokrFuOyt0uI8ezjByc0jGQ8MUv1VBrdNnCOJ0W5vpa2
        Q7BtB1W7nefbnEu+AUw8Rm1aT4PFZfV8bKrdhJ28kaOnF/EoFheG3CsdIIlQC5TfrQLVMhy9irn
        Xb9/pmjkFk0TVnRkxCxMrb0wMY4pTo3JjqWdQK6/39t4p2p/ubw21+pii5DdN7nfbe3YgclJ50Q
        19UxdEQxs=
X-Received: by 2002:a05:622a:4d:b0:3f6:b760:f3dd with SMTP id y13-20020a05622a004d00b003f6b760f3ddmr4181189qtw.33.1685483208516;
        Tue, 30 May 2023 14:46:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ507wIALjSuHpRo1cS0IkJi/HtXsdUCgPGx8sAhAVNpmCGQpGDAweoxaSLIhaiw8o3q/Hd8/A==
X-Received: by 2002:a05:622a:4d:b0:3f6:b760:f3dd with SMTP id y13-20020a05622a004d00b003f6b760f3ddmr4181173qtw.33.1685483208211;
        Tue, 30 May 2023 14:46:48 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a191000b003ef13aa5b0bsm5121602qtc.82.2023.05.30.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:46:47 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 2/5] irq: Show the parent chained interrupt in debugfs
Date:   Tue, 30 May 2023 17:45:47 -0400
Message-Id: <20230530214550.864894-3-rrendec@redhat.com>
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

This is a trivial change to expose the parent chained interrupt. The
intention is to make it easier to debug chained interrupts, particularly
in the context of setting the SMP affinity.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 kernel/irq/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index bbcaac64038ef..3ada976df8612 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -177,6 +177,7 @@ static int irq_debug_show(struct seq_file *m, void *p)
 			    ARRAY_SIZE(irqdesc_istates));
 	seq_printf(m, "ddepth:   %u\n", desc->depth);
 	seq_printf(m, "wdepth:   %u\n", desc->wake_depth);
+	seq_printf(m, "parent:   %d\n", desc->parent_irq);
 	seq_printf(m, "dstate:   0x%08x\n", irqd_get(data));
 	irq_debug_show_bits(m, 0, irqd_get(data), irqdata_states,
 			    ARRAY_SIZE(irqdata_states));
-- 
2.40.1

