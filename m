Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6E68F988
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBHVNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBHVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC630E9C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NERecKdHLUqwMZWLwJADWmbTJLbslnFnPSfMbqlvP3U=;
        b=UePe9jeuleEU13xO8pLyOB0TvKEjaZXL5FcaG2tL0PFzS6rDSowyuwcxnfTa0grFF2XX5A
        PeckehzsxVQu9DHi3IUdvInkkLC4OJxhrADselCuXc6Ke4YN9OhjCUS7TcdTjaqmalwQcg
        3sMPR9LJJfUUpH0XimlQhD/P7IJzt1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-8F-1UlcFMu6oaa2V0_A1LQ-1; Wed, 08 Feb 2023 16:12:43 -0500
X-MC-Unique: 8F-1UlcFMu6oaa2V0_A1LQ-1
Received: by mail-wr1-f70.google.com with SMTP id e9-20020a5d6d09000000b002c172f173a9so3268984wrq.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NERecKdHLUqwMZWLwJADWmbTJLbslnFnPSfMbqlvP3U=;
        b=x5+s/XiAImCOLkxReoumqV5hbMatTNz9KsmBzWfwMfsqNBVee+8SSgCpu9Pyzins7P
         D09VWndXYDpsNxCJ/LxmZFpo8tPmymD8HjsD0uH83+DnAGoNRikSNVXvohoCY6WJ+Pev
         D7v1kb5329vF6WClSfHaA4la3kl1S1ffJj8WY/IzdSBlLXjm92qZZVuSs9+tVn178bcB
         zkqknH0r0vXpMN18GfT+CNMto8QOpxBbh/DsIERrUMZJi5GNmg8tkZBLi/L/NHzHsLbf
         LU3FQmXj4bVfy0f9nQCjzcxgLJYrhZlUwdtto3Ar8uiF1CoScuKe3gRHSo5MI6c2DzKm
         JsbQ==
X-Gm-Message-State: AO0yUKXxK5deWuo1wi2zdKXFcSnGo21yw01XYv6m2UVSyZv/fRWprxLL
        09LW4ZduCFuDmsGvsp9w5a+O1cRfFJd97Rp5X+eEwvYT1zyvbYbZ/PJe5JbCpmagwuGJZoU4XbV
        Qx0mAtEGDnpPUc00xe4oaT6ru
X-Received: by 2002:a05:6000:1d1:b0:2c3:ba99:44bc with SMTP id t17-20020a05600001d100b002c3ba9944bcmr8345841wrx.68.1675890762534;
        Wed, 08 Feb 2023 13:12:42 -0800 (PST)
X-Google-Smtp-Source: AK7set9hJ/RtQuMOQNR+s++VE21Jk7JmDAqkt+dsnQdLd0krrCQM6jyPXo7PC5NSAGcU94PVU+QKKw==
X-Received: by 2002:a05:6000:1d1:b0:2c3:ba99:44bc with SMTP id t17-20020a05600001d100b002c3ba9944bcmr8345830wrx.68.1675890762340;
        Wed, 08 Feb 2023 13:12:42 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b002bddac15b3dsm14220412wrt.33.2023.02.08.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:41 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:37 -0500
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
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH RFC 3/7] Revert "x86: re-initialize RNG seed when selecting
 kernel"
Message-ID: <20230208211212.41951-4-mst@redhat.com>
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

This reverts commit cc63374a5a7c240b7d3be734ef589dabbefc7527.

Fixes: cc63374a5a ("x86: re-initialize RNG seed when selecting kernel")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7984f65352..e1a5f244a9 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1116,14 +1116,11 @@ void x86_load_linux(X86MachineState *x86ms,
         setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
         qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
         qemu_register_reset(reset_rng_seed, setup_data);
-        fw_cfg_add_bytes_callback(fw_cfg, FW_CFG_KERNEL_DATA, reset_rng_seed, NULL,
-                                  setup_data, kernel, kernel_size, true);
-    } else {
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
     sev_load_ctx.kernel_data = (char *)kernel;
     sev_load_ctx.kernel_size = kernel_size;
 
-- 
MST

