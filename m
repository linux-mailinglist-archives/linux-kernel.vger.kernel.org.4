Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055068F989
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBHVNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBHVNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB902DE50
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkQ9oa8tr+jHC1q9KvAdYJxLnDHRifzn1f10j1QSqk4=;
        b=Bug832DrRjZTvP1h7B2hT8f+Lf6NN9OUB+kY9VFeGiDxDwLLPRl4AEt7UOXFObJl76fhL+
        Y3km8kjKFbqLFrrQvDIZynN6b6S9H2hN3WKZA5ZlvNsYfA/lzsHfd+bDKOiAikuqJU0F8y
        k25UEHqVFAry/UHpxG3IeuBnnyj+yhA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-Kt2HPE9iOiCDF5rdjAp8Cg-1; Wed, 08 Feb 2023 16:12:48 -0500
X-MC-Unique: Kt2HPE9iOiCDF5rdjAp8Cg-1
Received: by mail-wr1-f71.google.com with SMTP id b9-20020adfc749000000b002c3dede475cso2355654wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkQ9oa8tr+jHC1q9KvAdYJxLnDHRifzn1f10j1QSqk4=;
        b=5TEN3/EI5t2kDIhDqsf+1QGIKeJJ/NBLi/bCrVZq2Z6S5Hk5a1dRlPV4R6uMfdMSRo
         h5WdZZfD4eAqy5MPZe5uhF6H3gihGLFNqQFN/Ag3Q2eEo+53Rf+zGp2HCQFZRukyo1hD
         IstQWRLdW91QLs7O/TtUyUtXC1aZZwJ2s7CKdiHdv3A2zl1fQ/QlZok0Ji0dXGtoielv
         EI4Xromhlj2YXE3n6N8/PJ9JIb/4kKVRnvS0v46GrJhgYMI4eNT5gVB7MdWxIZlmLgJV
         ommXuMwXYRWBbtRYHRkCEuz9QIeFDZtaGJ3K/UOfxASTwuBj++5FyIzSuVfwhJK+Cvv/
         z/Yw==
X-Gm-Message-State: AO0yUKVFNAghTpTbg1bOoBsHzVwa0poaXlgABimhH8dLRtSZAT4Qgy+L
        Nn3GaT8x1oR8PxT6/ndbUh8Nfw8TJ5CREee+hQAmq6Ue77RInlpnfLUgRZE5RCcFWpH7c4NI7Ci
        W3PuFPPZHHlaDMuiny7fH3iAWG/PfX4MG
X-Received: by 2002:a05:600c:3596:b0:3df:d431:cf64 with SMTP id p22-20020a05600c359600b003dfd431cf64mr7731433wmq.39.1675890766782;
        Wed, 08 Feb 2023 13:12:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8kNfnMKSwUT4zsOirgkb5KdNoSpzPeol3XSoJfqBxaPj4EX7PG3krQuGAKichXMOAacj8Caw==
X-Received: by 2002:a05:600c:3596:b0:3df:d431:cf64 with SMTP id p22-20020a05600c359600b003dfd431cf64mr7731407wmq.39.1675890766594;
        Wed, 08 Feb 2023 13:12:46 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b003dd1bd0b915sm2916208wms.22.2023.02.08.13.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:46 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:42 -0500
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
Subject: [PATCH RFC 4/7] Revert "x86: reinitialize RNG seed on system reboot"
Message-ID: <20230208211212.41951-5-mst@redhat.com>
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

This reverts commit 763a2828bf313ed55878b09759dc435355035f2e.

Fixes: 763a2828bf ("x86: reinitialize RNG seed on system reboot")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e1a5f244a9..32f37ab7c2 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -787,12 +787,6 @@ static void reset_setup_data(void *opaque)
     stq_p(fixup->pos, fixup->orig_val);
 }
 
-static void reset_rng_seed(void *opaque)
-{
-    SetupData *setup_data = opaque;
-    qemu_guest_getrandom_nofail(setup_data->data, le32_to_cpu(setup_data->len));
-}
-
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
                     int acpi_data_size,
@@ -1115,7 +1109,6 @@ void x86_load_linux(X86MachineState *x86ms,
         setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
         setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
         qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
-        qemu_register_reset(reset_rng_seed, setup_data);
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
-- 
MST

