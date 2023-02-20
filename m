Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9569D209
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjBTRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjBTRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:19:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DF1C7F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:19:10 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 873B63F582
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676913546;
        bh=KsFWVKyUTisvLWEBfJHuAqZZOIzRC+wakmOYPwQrXVU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=FZMzSoeecI91UrA5teqL8d4x6aQbaIiXb6laVlwqHzRU2vioww5CHpvnaQ1oCEGKW
         iXE+W5kkIjMnKl8MVSgEP3w3QFUeAf9c7InTtYY3YWJkBgn3Vw4CbEMS5ehn3Lvmsj
         rb/FVr3bQjgJYmenUJSsIbfZ3XUu7GjmYi+U6hMMTd8zIAya4IHoGKx1plBsMNSX4f
         gYIkyr98FT/4P4jzHnO1jBIrAy48XS19llrrwFAyh5DFGRjkZXcNHfVLo92Db7rLBB
         c11hHySKzRqHfsOBwwttQHUNNA+qNWELKjfCxam3h3/9FE6OD8mCXPt9dBuuMSUm+Z
         lg8EcUMXwMzSg==
Received: by mail-ed1-f70.google.com with SMTP id dk16-20020a0564021d9000b004aaa054d189so2261506edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsFWVKyUTisvLWEBfJHuAqZZOIzRC+wakmOYPwQrXVU=;
        b=mqdSRICZ3WRGrLl0pwvL6JfG8A3K0y8y0N9bPN/6vmZVDWVm3ZoOE8sM0Z+Z/62BCC
         vc6IhoUMJP1PcaLbrYit/mjZ2I660iz2hnOh2/8aGkEPInin6xNGhDr6ECPoGvS5yR5O
         5ZJG5SIkhDr3z1Y1TlxUE7eRm/gbefrbMpsY6rUAn/b2WNTe9pIcGRDxH3EI14KWGYyA
         hj4JbLNhvCv7bXyLJ3QH0mc0vY5sJizAi8h38dvqRSib2l343poqDWxluD7AOCeup7cl
         clmYCqLfrxkiI8DtP7PuakEOviGCziKvqtRr59qpWzVM/Zt+XRmI+my73UuaCimF415n
         S6fw==
X-Gm-Message-State: AO0yUKV8b4hUUM6oftTQi+HOZRukFcUfr25drg6n0j0whS9ljXNeEJHD
        NepYogfaeetjUugkWNYAfCRBjYtppG30lzyikd3JuhvfAI351Y0a1uKwcDUe33Zuv6Mns16PbQo
        kAx7XhSwC38G7xblfnqnIJ4AUWBCTaikIIehxAYxsZAqERm+ldQ==
X-Received: by 2002:a05:6402:1151:b0:4ac:beba:dc87 with SMTP id g17-20020a056402115100b004acbebadc87mr1075439edw.0.1676913546121;
        Mon, 20 Feb 2023 09:19:06 -0800 (PST)
X-Google-Smtp-Source: AK7set8Oj7a1xx8jk5ISCHq4+eehJqR5ZQt/ZuPqDE6BQzrZixfjYgaHw5I/qT7NHOl5lv7OxFJ56Q==
X-Received: by 2002:a05:6402:1151:b0:4ac:beba:dc87 with SMTP id g17-20020a056402115100b004acbebadc87mr1075416edw.0.1676913545790;
        Mon, 20 Feb 2023 09:19:05 -0800 (PST)
Received: from localhost.localdomain (host-79-44-179-55.retail.telecomitalia.it. [79.44.179.55])
        by smtp.gmail.com with ESMTPSA id ee51-20020a056402293300b004aef6454d6dsm1984489edb.37.2023.02.20.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:19:05 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/sseu: fix max_subslices array-index-out-of-bounds access
Date:   Mon, 20 Feb 2023 18:18:58 +0100
Message-Id: <20230220171858.131416-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that commit bc3c5e0809ae ("drm/i915/sseu: Don't try to store EU
mask internally in UAPI format") exposed a potential out-of-bounds
access, reported by UBSAN as following on a laptop with a gen 11 i915
card:

  UBSAN: array-index-out-of-bounds in drivers/gpu/drm/i915/gt/intel_sseu.c:65:27
  index 6 is out of range for type 'u16 [6]'
  CPU: 2 PID: 165 Comm: systemd-udevd Not tainted 6.2.0-9-generic #9-Ubuntu
  Hardware name: Dell Inc. XPS 13 9300/077Y9N, BIOS 1.11.0 03/22/2022
  Call Trace:
   <TASK>
   show_stack+0x4e/0x61
   dump_stack_lvl+0x4a/0x6f
   dump_stack+0x10/0x18
   ubsan_epilogue+0x9/0x3a
   __ubsan_handle_out_of_bounds.cold+0x42/0x47
   gen11_compute_sseu_info+0x121/0x130 [i915]
   intel_sseu_info_init+0x15d/0x2b0 [i915]
   intel_gt_init_mmio+0x23/0x40 [i915]
   i915_driver_mmio_probe+0x129/0x400 [i915]
   ? intel_gt_probe_all+0x91/0x2e0 [i915]
   i915_driver_probe+0xe1/0x3f0 [i915]
   ? drm_privacy_screen_get+0x16d/0x190 [drm]
   ? acpi_dev_found+0x64/0x80
   i915_pci_probe+0xac/0x1b0 [i915]
   ...

According to the definition of sseu_dev_info, eu_mask->hsw is limited to
a maximum of GEN_MAX_SS_PER_HSW_SLICE (6) sub-slices, but
gen11_sseu_info_init() can potentially set 8 sub-slices, in the
!IS_JSL_EHL(gt->i915) case.

Fix this by reserving up to 8 slots for max_subslices in the eu_mask
struct.

Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/gpu/drm/i915/gt/intel_sseu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_sseu.h b/drivers/gpu/drm/i915/gt/intel_sseu.h
index aa87d3832d60..d7e8c374f153 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu.h
+++ b/drivers/gpu/drm/i915/gt/intel_sseu.h
@@ -27,7 +27,7 @@ struct drm_printer;
  * is only relevant to pre-Xe_HP platforms (Xe_HP and beyond use the
  * I915_MAX_SS_FUSE_BITS value below).
  */
-#define GEN_MAX_SS_PER_HSW_SLICE	6
+#define GEN_MAX_SS_PER_HSW_SLICE	8
 
 /*
  * Maximum number of 32-bit registers used by hardware to express the
-- 
2.38.1

