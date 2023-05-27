Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA69F7131A7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbjE0Bm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbjE0Bmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22B1B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1172712b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151745; x=1687743745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrSnet5OHiffmIbqSfs7JuxPbvC81vL93khftEXYXiY=;
        b=BT+dRPt9LSQc3DlKLaKCfmyetEhgoJWmpfPImFeN4Zed3b/jcHaHA0DNeF4IWSNxJZ
         pQJPuH6IffGDZ6zcJvw+gKseGPHpDIJ1vf2pyqkdOHxYFk6spwySKVC18nfFTiPC4p1U
         vBzpXfaeufNjvxECgwzvl9XLbFJ2N0kpAe2ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151745; x=1687743745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrSnet5OHiffmIbqSfs7JuxPbvC81vL93khftEXYXiY=;
        b=St5YAeHAUp5yvKXmOOB+9/LUCPappgzWBFIGi3chIxVsZWj02pFiDv/wQmcUPJKhzv
         oshxqlbwZzy5f4X6s0qNvVj1nlfX0O0HYCidRLRg/fTJIHSLcoq2wcOo0JL/8R5WkQXN
         0qewmVOQgTHC2Yi3HiCYNt5BRczc1JRsueMosLCZ5CQApDTsbvbTQAMnTWTDNBtzkQ+i
         ZCZW3QNvfOcm80vHE8MSps4zk2Zuu/uD256yJmrQrTaiEhpfa4/61BaFo4iz/EEQEqfq
         fl6ePi5niGQd2Hvp4h1sKYX/OeVrkaffqdSkT/6t/xc29X98OoGHFMxCkkxMxUryyDaM
         t7VQ==
X-Gm-Message-State: AC+VfDw8etUlKcqIW1CR7Ni+Kb9XhVRrDLE0nmYQMdOq6WxfJSZZoapn
        uOl47Lg3G49xfErwHhysN88LSA==
X-Google-Smtp-Source: ACHHUZ40Aya6L3K9wWALtZHzSbN8jGhO+EVfPlmtY3VStdyZv7cwbEJlQWNy+d0vp5EsQiqF5NEtCg==
X-Received: by 2002:a05:6a00:2386:b0:64d:1185:241a with SMTP id f6-20020a056a00238600b0064d1185241amr6871168pfc.5.1685151745069;
        Fri, 26 May 2023 18:42:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 05/10] watchdog/hardlockup: remove softlockup comment in touch_nmi_watchdog()
Date:   Fri, 26 May 2023 18:41:35 -0700
Message-ID: <20230526184139.5.Ia593afc9eb12082d55ea6681dc2c5a89677f20a8@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("watchdog/hardlockup: add comments to
touch_nmi_watchdog()") we adjusted some comments for
touch_nmi_watchdog(). The comment about the softlockup had a typo and
were also felt to be too obvious. Remove it.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/nmi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 3a27169ec383..6c6a5ce77c66 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -140,10 +140,6 @@ static inline void touch_nmi_watchdog(void)
 	 */
 	arch_touch_nmi_watchdog();
 
-	/*
-	 * Touching the hardlock detector implcitily pets the
-	 * softlockup detector too
-	 */
 	touch_softlockup_watchdog();
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

