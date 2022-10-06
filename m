Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AB5F6E16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJFTVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiJFTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:20:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EA8D0FB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:20:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x1so2582840plv.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yDdKybISWjOBihvP0li8ufgojX9q5NF4de6wdOs2bcU=;
        b=ArGG/Gr6+qQRiJ6zFCfTw0V6NXFqPDORtWcQJ4C5zydvkZAFJZaS9aLnRLsbjLtj5K
         0vlwd04ljmE1egPFm4Oowb5gIGbFuAri0Sk5MZVtPJMP31jQ8me+5KfipLFNfO7n24ng
         opf2Ds6+LB+1cFDDOUos4/M5x6qZlC5xEfYZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yDdKybISWjOBihvP0li8ufgojX9q5NF4de6wdOs2bcU=;
        b=OQQRLo9Fitf7g93Gk4aA1cmpt5EmlGIegt5GyS0m+DqLHcw30cjJY3K8bBokjJuPix
         hMdTh5wxKH3IppjJfo7Cp9VncMHrhk66JGsLdys54GjmRNn6yX/3k8zS36FMXl/N38Ps
         ZibShFqThwBe3CVrTmOnxmFQNiPjnwcUJn8VUKMuj62ztJOEX50IyVylEGfwFnQSmo2n
         7/ddA18us04BpsP+QCfPH9OOVH/QPsP06J+94KMOgtW2E/zQ73YbYDtgINNc8L/t0tCv
         IEaW7kdBjHUvBUphOjbWYcB03TldfGgpFTDPHoXIgrWfp7Fjyl1hCcQFtSxCIQk3kDBG
         8NGQ==
X-Gm-Message-State: ACrzQf17qGVleL2UkIqw1NA9AoVs0PbU1jipxyj4tf+jXKdKCWbtbzBT
        e1LhhbkheieYUCoH6Ly0v7bHtQ==
X-Google-Smtp-Source: AMsMyM7A2ev3a/+ZEF2jzx3WwYvphECwPlS0TcJLnvqk28CY/FguYSsftr3CIwnX8uAKm5dnpxPgVw==
X-Received: by 2002:a17:902:aa03:b0:17f:6287:75da with SMTP id be3-20020a170902aa0300b0017f628775damr1326584plb.15.1665084052676;
        Thu, 06 Oct 2022 12:20:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c25-20020aa79539000000b00562a0759776sm719705pfp.117.2022.10.06.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:20:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] can: kvaser_usb: Remove -Warray-bounds exception
Date:   Thu,  6 Oct 2022 12:20:35 -0700
Message-Id: <20221006192035.1742912-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC-12 emits false positive -Warray-bounds warnings with
CONFIG_UBSAN_SHIFT (-fsanitize=shift). This is fixed in GCC 13[1],
and there is top-level Makefile logic to remove -Warray-bounds for
known-bad GCC versions staring with commit f0be87c42cbd ("gcc-12: disable
'-Warray-bounds' universally for now").

Remove the local work-around.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/can/usb/kvaser_usb/Makefile |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/Makefile b/drivers/net/can/usb/kvaser_usb/Makefile
index b20d951a0790..cf260044f0b9 100644
--- a/drivers/net/can/usb/kvaser_usb/Makefile
+++ b/drivers/net/can/usb/kvaser_usb/Makefile
@@ -1,8 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
 kvaser_usb-y = kvaser_usb_core.o kvaser_usb_leaf.o kvaser_usb_hydra.o
-
-# FIXME: temporarily silence -Warray-bounds on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_kvaser_usb_hydra.o += -Wno-array-bounds
-endif

