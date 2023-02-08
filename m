Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812268F98B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjBHVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBHVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1C2D159
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tS9+7/8O/6fAFa8QO010Xn8p8THh7DB9ISxGEslYQs4=;
        b=T2bEJyuvcDla8+rK6h4vuekQ7ep62zSEnsJfPslF+MOn/koF0C4uq9hlZmPFgeltYMPGLS
        Q6Ft12z0BK6TAP1Q+pbStxC5f4LvhtUDRKlvUF5ZZUtbw1WbWiQntpO2dNgv/l5TWQDRFF
        r3cp0Zs+51VoO85TD2dBfgnQR9IfX48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-117-Dja7HQCmMc-KA8tftd840Q-1; Wed, 08 Feb 2023 16:12:52 -0500
X-MC-Unique: Dja7HQCmMc-KA8tftd840Q-1
Received: by mail-wr1-f69.google.com with SMTP id t3-20020adff043000000b002bfd38027fcso3228385wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS9+7/8O/6fAFa8QO010Xn8p8THh7DB9ISxGEslYQs4=;
        b=Txx2+VuAgUHHt5IdoMQfCIWbeLcVr/YUzUGnx9+27s6I0qTQwQa4AbMS7yWTg+PrD6
         xozZTFr42BjX8ZG5s3jLvhnAEyoWZ5uFlrFb4nYbP2qkr58nKpQDqydPl+cpYg3CV298
         KxUijPIWIERsZOO8LnUZQtfasx6DSsUoBSK0Hpa/stXsvhZX9NS9ToSv4JlE8eL2xq11
         OAcFhQad2fOm6XsmlOHsl4HsOGaJ3X3PGDdtA36K3iiI+1bxwbYnauGeJRy/bDuqlFvQ
         xd15TnzSY+cq7ULNJ99XYePI2aC9WbbQtc43MlRI9O/gX0ZTIfUXaeNv/MBOtSlaF6LE
         /wAA==
X-Gm-Message-State: AO0yUKVwa27tl390EtWOWEPje1/o+GT//Cvewk6bCF6Xv5Ip76XeTH/q
        IAp4xEqmmpS+SVRHBOpfKxFdiR8dAtLtnDgkOnFvAb6vrxkJjGulRG7whhLClZQqlY+AKWasdG4
        MGWORjA7qXSBKEaTOWvUCCWoa
X-Received: by 2002:a05:600c:747:b0:3dc:438a:c381 with SMTP id j7-20020a05600c074700b003dc438ac381mr7510794wmn.28.1675890770887;
        Wed, 08 Feb 2023 13:12:50 -0800 (PST)
X-Google-Smtp-Source: AK7set9iMoFTHiyVDA/tXK+cM7w+o64RXFY6qMkpfJBFLnhKSPwfd/l/vFf31/EdopCJ5I2wdU0tew==
X-Received: by 2002:a05:600c:747:b0:3dc:438a:c381 with SMTP id j7-20020a05600c074700b003dc438ac381mr7510779wmn.28.1675890770641;
        Wed, 08 Feb 2023 13:12:50 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm7197641wms.1.2023.02.08.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:50 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Eduardo Habkost <eduardo@habkost.net>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH RFC 5/7] Revert "x86: use typedef for SetupData struct"
Message-ID: <20230208211212.41951-6-mst@redhat.com>
References: <20230208211212.41951-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208211212.41951-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit eebb38a5633a77f5fa79d6486d5b2fcf8fbe3c07.

Fixes: eebb38a563 ("x86: use typedef for SetupData struct")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 32f37ab7c2..76b12108b4 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -657,12 +657,12 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
     return dev;
 }
 
-typedef struct SetupData {
+struct setup_data {
     uint64_t next;
     uint32_t type;
     uint32_t len;
     uint8_t data[];
-} __attribute__((packed)) SetupData;
+} __attribute__((packed));
 
 
 /*
@@ -803,7 +803,7 @@ void x86_load_linux(X86MachineState *x86ms,
     FILE *f;
     char *vmode;
     MachineState *machine = MACHINE(x86ms);
-    SetupData *setup_data;
+    struct setup_data *setup_data;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     const char *dtb_filename = machine->dtb;
@@ -1086,11 +1086,11 @@ void x86_load_linux(X86MachineState *x86ms,
         }
 
         setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(SetupData) + dtb_size;
+        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
         kernel = g_realloc(kernel, kernel_size);
 
 
-        setup_data = (SetupData *)(kernel + setup_data_offset);
+        setup_data = (struct setup_data *)(kernel + setup_data_offset);
         setup_data->next = cpu_to_le64(first_setup_data);
         first_setup_data = prot_addr + setup_data_offset;
         setup_data->type = cpu_to_le32(SETUP_DTB);
@@ -1101,9 +1101,9 @@ void x86_load_linux(X86MachineState *x86ms,
 
     if (!legacy_no_rng_seed) {
         setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(SetupData) + RNG_SEED_LENGTH;
+        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
         kernel = g_realloc(kernel, kernel_size);
-        setup_data = (SetupData *)(kernel + setup_data_offset);
+        setup_data = (struct setup_data *)(kernel + setup_data_offset);
         setup_data->next = cpu_to_le64(first_setup_data);
         first_setup_data = prot_addr + setup_data_offset;
         setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
-- 
MST

