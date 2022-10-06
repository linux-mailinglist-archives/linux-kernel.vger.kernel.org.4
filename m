Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C35F6E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJFTVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiJFTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:20:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651C8D0FB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:20:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lx7so2624947pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bhbYN1/ws6y+dvibVWQIhc2niyZnNj0uIem726dovow=;
        b=nfkPVlGQxxm0gH2aJgFsIJGQT1ZrA2aYg20i6S6j1e0pj9rutxyhA6DNlE+ldLGfB8
         z3TH67MlNuDOm4QRNmE2nSaSvdwPZQkP+iQhx69iDFKze/TLzlT/zx3k7dfa9cdSCnpb
         /bWQeCrx2pqX1KL0u5cltFMJyhI0roiByl8cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bhbYN1/ws6y+dvibVWQIhc2niyZnNj0uIem726dovow=;
        b=LLPQSQyMEfVXv2U4j3RnJPwFETDSoRJPcshL4F14/N3UPH8KKBpDitf7BbObf8iqup
         KtAzBYLfUjZBqdrpE5ntr0+XWy698Oexw9lmAD4PB3UrLKlEnWgAxdenNeOg33lg8iXe
         KEzf/biqR+NNsQvH8YRpFcWwJA7ZD556d0Riwzgiaxj1Sj8Wfid83ap/hRGf5dR/64Hr
         yM4a2/qBMisKjmL34f1dBFirxjqitMN5T3EWsOdtiE4JSPYGNEY/ey+mXvPphWxljDCw
         RITCa4mBchTae+mXzmz6vPPij2CWTWTI+umiR+uNnRnvj8YIF674bAcY1qXeSbx3kalK
         +NhQ==
X-Gm-Message-State: ACrzQf0NUzKwoZmR8bzqBvKykbYik66Xsk+Vk/OCv+6od5+kbe1FQ73I
        1d1btFeCorFHlDL2NSVAJGYVdw==
X-Google-Smtp-Source: AMsMyM7xbIJakV+zr+CrMGNTwjFGTBB9I9gY4Yexu9BF+gqKocdMGxlTu6JuPlg58XON0QY5nDXoeg==
X-Received: by 2002:a17:90a:a40a:b0:20a:882a:7ed8 with SMTP id y10-20020a17090aa40a00b0020a882a7ed8mr1222841pjp.129.1665084057317;
        Thu, 06 Oct 2022 12:20:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc14-20020a17090b3b8e00b0020a28156e11sm1814611pjb.26.2022.10.06.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:20:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] ath9k: Remove -Warray-bounds exception
Date:   Thu,  6 Oct 2022 12:20:54 -0700
Message-Id: <20221006192054.1742982-1-keescook@chromium.org>
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
 drivers/net/wireless/ath/ath9k/Makefile |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/Makefile b/drivers/net/wireless/ath/ath9k/Makefile
index 9bdfcee2f448..eff94bcd1f0a 100644
--- a/drivers/net/wireless/ath/ath9k/Makefile
+++ b/drivers/net/wireless/ath/ath9k/Makefile
@@ -45,11 +45,6 @@ ath9k_hw-y:=	\
 		ar9003_eeprom.o \
 		ar9003_paprd.o
 
-# FIXME: temporarily silence -Warray-bounds on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_mac.o += -Wno-array-bounds
-endif
-
 ath9k_hw-$(CONFIG_ATH9K_WOW) += ar9003_wow.o
 
 ath9k_hw-$(CONFIG_ATH9K_BTCOEX_SUPPORT) += btcoex.o \

