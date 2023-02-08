Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E9568F29B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBHP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjBHP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A494C6C4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675871706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7sUnVzlMx2m7Rm8oB22gZPkorcr5iVWMwlElG24lMuQ=;
        b=FqRa0PAiRAgFzKGPuMl6n86T0H7/Az+ceMEcWmjSbdpBJv6JM+hu2R/oElsnSHHXZtdhiN
        79JFyU/n+iPPQCg/BC2+YNOkRQ4Tc9qnuLuSmC7C0siwFmM8GXv11g3hc3o8e4L1+SqDJL
        9Ju7Ci3n2yNVx3kqorxYkXJsFFhopA8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-On2clsKoMbOkahzMOGZWwQ-1; Wed, 08 Feb 2023 10:55:05 -0500
X-MC-Unique: On2clsKoMbOkahzMOGZWwQ-1
Received: by mail-qk1-f200.google.com with SMTP id ay10-20020a05620a178a00b0072db6346c39so11087449qkb.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 07:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sUnVzlMx2m7Rm8oB22gZPkorcr5iVWMwlElG24lMuQ=;
        b=Oq+dhE6VsLM6AyezSraSe/gJtT6XGwAfTE8PNmytWUweSi/ewztn2w6wC7vI6Mdyzl
         nkTEZJjX0yFhYUgehBoDy18AVGjzrgKzN9a0elDm6HUOXt/ESDMP6aGS+dyVtvSkOwLN
         xsqur13k8Fh/zoOYHqhQXCVnmoShnLmw4pzIcA7SWsZ3shhWucE1pNZ211pYXLF2Zv0/
         KGGYlrpJ5ZLNQPW6PKOLEo8FSwdnDGJG/X8b7r8PTVaZ72QjBVp0FvcQhcTtozDPtOSL
         NOByTwgLuHP06mRuowIUajSl0voHUEgbMFL8ClqCRr1pJ9DJnJFFdabFnJ3Ls41oUcdV
         921A==
X-Gm-Message-State: AO0yUKWsCzu4ZD93kt4zqLmTW5yQ9H+or60309vFfbI0mbU5i6keTZ5G
        xnt3fyf2s3fwNldRZKPmVe1PPt0uctqXs0CokL3H3bhAE7+XbaUIadlgmd8pR/Xzw2V2FAe+k7v
        Hn4WlOpr+w3NmKQYoOJqCnTkz
X-Received: by 2002:a05:622a:5ca:b0:3b9:c08f:219c with SMTP id d10-20020a05622a05ca00b003b9c08f219cmr13508074qtb.29.1675871704837;
        Wed, 08 Feb 2023 07:55:04 -0800 (PST)
X-Google-Smtp-Source: AK7set862iDAv82HIBQc08b5kthNBVKLMTR0KXzZsKi+mk6XsGXu9KCp2Z6GeLeI1VsYZYW5IjQWMQ==
X-Received: by 2002:a05:622a:5ca:b0:3b9:c08f:219c with SMTP id d10-20020a05622a05ca00b003b9c08f219cmr13508050qtb.29.1675871704525;
        Wed, 08 Feb 2023 07:55:04 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a0bc900b0071aacb2c76asm11841896qki.132.2023.02.08.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:55:04 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     ogabbay@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        kelbaz@habana.ai
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] habanalabs: change unused extern decl of hdev to forward decl of hl_device
Date:   Wed,  8 Feb 2023 07:54:50 -0800
Message-Id: <20230208155450.1941608-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with clang W=2 has several similar warnings
drivers/accel/habanalabs/common/decoder.c:46:51: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
static void dec_error_intr_work(struct hl_device *hdev, u32 base_addr, u32 core_id)
                                                  ^
drivers/accel/habanalabs/common/security.h:13:26: note: previous declaration is here
extern struct hl_device *hdev;
                         ^

There is no global definition of hdev, so the extern is not needed.
Searched with
grep -r '^struct' . | grep hl_dev

Change to an forward decl to resolve these issues
drivers/accel/habanalabs/common/mmu/../security.h:133:40: error: ‘struct hl_device’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  133 |         bool (*skip_block_hook)(struct hl_device *hdev,
      |                                        ^~~~~~~~~

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/accel/habanalabs/common/security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/security.h b/drivers/accel/habanalabs/common/security.h
index 234b4a6ed8bc..d7a3b3e82ea4 100644
--- a/drivers/accel/habanalabs/common/security.h
+++ b/drivers/accel/habanalabs/common/security.h
@@ -10,7 +10,7 @@
 
 #include <linux/io-64-nonatomic-lo-hi.h>
 
-extern struct hl_device *hdev;
+struct hl_device;
 
 /* special blocks */
 #define HL_MAX_NUM_OF_GLBL_ERR_CAUSE		10
-- 
2.26.3

