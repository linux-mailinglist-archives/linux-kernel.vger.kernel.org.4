Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF860602140
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJRCiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJRCiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:38:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A99410D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:38:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fw14so12690041pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/sbw9esP61gV6/BLjaGWBnk+miYGbzeL/QwROnEOEk=;
        b=H2b63KJVBO2GdMY0nV/dRf6TlFnJ9QK+L5IU7T5QQXV42NprTy4I0+Hy0Pf735/iXm
         3lx/MrbJ0PvxxE1zwSSXG6I4SG/bhHsWeltVfRw3pEPGkm6o5LHtvIygegVL/ABhfNkG
         VFoyQeZYn8eVRg5UyTUrqWgY/up6MImhm2A28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/sbw9esP61gV6/BLjaGWBnk+miYGbzeL/QwROnEOEk=;
        b=AY5LHWrjPGmpG1emV/J/GC+x4wNaGtROb0nrVBXtFGJ54oGiXmKxcga+LVqeWrTIKp
         CINymoXcs0sgNAHmtgNo0I8DqasR3P48rGaIK9CkDcD5dpYp0XThZ1ujqi2HcK8cRxub
         RE96i9rlfNpB/3HWVmo7fpTbaKqv3pe8Va2WFCIseVaN9wRL0WPq3fzld2pyEzoa4J4n
         GKX4Uernm2BgrIeFQa/01ZYBguN+hFPgDMXOmedWLGHd1NV+NlQTBq6KgirYqtDAxC/T
         BWwutbmYG805vZ8+lNe5/cIvm+maKj6A7FY9z9u2I4HiJ/HLVpu7qPeQN7mWTcTgauVh
         X2Hg==
X-Gm-Message-State: ACrzQf1P+WxeEhHGpM3dQt/Xf49IEYIYgp+Enijx1pD6gJ9yKZzePeCe
        2FXOBtED3yYCBgWKO0N1dHzFjA==
X-Google-Smtp-Source: AMsMyM6s2Ekj+FmLeqNvK1NM2HJla6ZcerERHHYbU3/pACFrqZ+Ucd9P8aD3+AQE3rjZ6laoBn05Dg==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr715059plh.142.1666060683550;
        Mon, 17 Oct 2022 19:38:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902a41800b00172b87d97cbsm7315559plq.67.2022.10.17.19.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:38:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Simon Kelley <simon@thekelleys.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH][next] atmel: Fix atmel_private_handler array size
Date:   Mon, 17 Oct 2022 19:37:59 -0700
Message-Id: <20221018023732.never.700-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; h=from:subject:message-id; bh=Dxza05rOmp3v/aLKDNxxdoNSiFdbo0KfFIwpTTS9BCk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjThGHNro1AgkFkolg4wYwZle8Iky3GKlCqcc25/rt uZHSEsmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04RhwAKCRCJcvTf3G3AJpZLEA CFUjDExOqbpd2QqGOnokVzYUb9oUUeGMozp2aB0M0LWltq2+sESFlbav9rDITqdSV4an+tRFToGfmL 11+p3ENB1hcZVYN7beLUiiMjBEmU+wQa0/aO8XWS6PDLV+HX1YZaqLCKjE8B0SWD3EGvHXGNWQgBVQ 6j9QtQfWuVq8hE9fsN+lxUshnVUhTJruaV71sPXTyS4uMKeH8FJpb5CiuIDSVSGyu7opBEJRK0AQZk LRjG0PbadvFMM8q+V04WGy9sqIhs13rAOeBFREysnBG3n/tmHhJ9/C9X4BHRH+zVKfDy4xgvCedl57 2VXVizkyBXsbRPBhVO4qWSyyefCIBPVKzTKXVTX5qYQM3r7lzg/zcA3frKW/sUDdZKpHPgdVpzproJ FZS3QRO/zyXQck8HFyi+OWYDOhE/Xl710sh1yRnYMItWOQYMprMaUZyHsRYAG5w8l3IJvrQ+6daOes UqjLO+Ak74KEgnc2e3ZCXgEBlgIROxyk0pqtxd2zjwUDd4mjp+jl3Nh8iqnTK53z/MA8kPPCj7fXQN wQ6YVZkXlO++4qetIMNVa0yHu0IFJf1Qpg7oi6jMixyGhyChjQRGsCC+e6hOsnbzmnzMyyE7693fPI f2RZJoA7CFsMmZl2uRS3NHVSyM/sv1v3hZyNb6/9cCEUPtNgzcy9B4olDoRg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the atmel_private_handler to correctly sized (1 element) again. (I
should have checked the data segment for differences.) This had no
behavioral impact (no private callbacks), but it made a very large
zero-filled array.

Cc: Simon Kelley <simon@thekelleys.org.uk>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 8af9d4068e86 ("wifi: atmel: Avoid clashing function prototypes")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/atmel/atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index ed430b91e2aa..7c2d1c588156 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -2570,7 +2570,7 @@ static const iw_handler atmel_handler[] =
 
 static const iw_handler atmel_private_handler[] =
 {
-	IW_HANDLER(SIOCIWFIRSTPRIV,	NULL),
+	NULL,				/* SIOCIWFIRSTPRIV */
 };
 
 struct atmel_priv_ioctl {
-- 
2.34.1

