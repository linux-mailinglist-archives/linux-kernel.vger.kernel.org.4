Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815F68F987
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBHVNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjBHVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315630B04
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyB2eX4BrxplsV/cU4fgKDTd3hh497IDhiUSXuPJBb8=;
        b=Ugj6qnVLa+IipSd36ANBCW2XgNIORtB+n+0VfHI4197zdlI1Rg9rXgwssrfDjqPTT/YHvQ
        vMpWnFeNnL0rKvfYBU35TVADVopwiEJ0MsWcQO3W7HvTwAZXyCCkbUOvbF7mmNVkBKmyrQ
        oEdGKtdRUZHtAvXTf4TPruBLW3NG2CE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-UuMKYDssMVGdqKWtgVT25g-1; Wed, 08 Feb 2023 16:12:39 -0500
X-MC-Unique: UuMKYDssMVGdqKWtgVT25g-1
Received: by mail-wm1-f71.google.com with SMTP id n4-20020a05600c3b8400b003dfe223de49so1743231wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyB2eX4BrxplsV/cU4fgKDTd3hh497IDhiUSXuPJBb8=;
        b=FDY1sz/WRDvGck50seO46AsRqY7OBgxN2dEbNCFk+NTcQ84ppAPeSVyP5Pvg3g/R3u
         UQ51YjTBwf48T2K42EGb2YlsmvrEHBcp9GdmyLWgV0efPiRyhTNmrwpFCh1IQJVbVfyy
         z1oQZtPTAFFkzhgFdgIKxcwOVWQYkTPM7h/uSBR2Q1vMT+ozlGpNLRI5+WNyrAxS0KVg
         yxpYMV5RCNP0FEh6SnSkr5pu2j/ecZ2NVG8WHDkXN+HuVXbUEWvB63PBs03WDB2noLYC
         xnNpHZtHF0VbE2YNTnD6uA2KEH7LOtQmasKpKEODA3s8dG8rSvBSoPtP5w7mrX0dIaMG
         T4Yg==
X-Gm-Message-State: AO0yUKU3R8DPYA9hhp3z0u2hxgkABk4fE7ESTPKQe56A7hpUvdP0wBou
        RxDYxVz4J1fQ+kQzrW27YhEOuYKlbxUdMkCyxV8v+0qgRrPe+ra78MZT625o7bXqDmNthLbo/rO
        uU7PZhG8iR9RdHKJb9FovLot6
X-Received: by 2002:adf:e607:0:b0:2c4:5de:2d3e with SMTP id p7-20020adfe607000000b002c405de2d3emr1747033wrm.41.1675890757388;
        Wed, 08 Feb 2023 13:12:37 -0800 (PST)
X-Google-Smtp-Source: AK7set838VaFDlxa9uadyGE5Hk1bmbh3K276tSM5JtsHQY0vUmJXrZ16/41fZCphaQYDSIClM32nOA==
X-Received: by 2002:adf:e607:0:b0:2c4:5de:2d3e with SMTP id p7-20020adfe607000000b002c405de2d3emr1747022wrm.41.1675890757189;
        Wed, 08 Feb 2023 13:12:37 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id y5-20020adfee05000000b002c3f6d7d5fesm4398119wrn.44.2023.02.08.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:36 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:31 -0500
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
Subject: [PATCH RFC 2/7] Revert "x86: do not re-randomize RNG seed on
 snapshot load"
Message-ID: <20230208211212.41951-3-mst@redhat.com>
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

This reverts commit 14b29fea742034186403914b4d013d0e83f19e78.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 14b29fea74 ("x86: do not re-randomize RNG seed on snapshot load")
---
 hw/i386/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 78cc131926..7984f65352 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1115,7 +1115,7 @@ void x86_load_linux(X86MachineState *x86ms,
         setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
         setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
         qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
-        qemu_register_reset_nosnapshotload(reset_rng_seed, setup_data);
+        qemu_register_reset(reset_rng_seed, setup_data);
         fw_cfg_add_bytes_callback(fw_cfg, FW_CFG_KERNEL_DATA, reset_rng_seed, NULL,
                                   setup_data, kernel, kernel_size, true);
     } else {
-- 
MST

