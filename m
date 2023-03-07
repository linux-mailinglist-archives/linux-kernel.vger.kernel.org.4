Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24E6AF834
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCGWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCGWFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:05:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8CEAA737
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:05:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x34so14721305pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1678226750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iuFv0A/Ck/Q8e4YuvcBqj0gUpgGQfLBTSNOCt9bIelM=;
        b=XKJICQ5d2fSyxMll4s29WUxxIdUEbV3pRAWR10gMjlwWaUvdxauJBg5FihyholtycU
         eycULJgQOucWEzOMljNnymK7KzNChsHyUZVXUvsKOR2B806ksqYY8qtvuzDS4EvLgYix
         R/QdZ3zTECbz3e3GB4EFoqWxwA0teV7/j2SuUOFsnpPr2zvNu5Zr2AoJjvjjBNIpBe1y
         nJlzsxMLKw76SaWGlvZCK4vycqj4s95TKyY4/Mzhl8nlalmM3qSOHGirBE0xmWHoBjpG
         zNb8qpZ1TuEb78N2Obwdw7Wshw2L7wqceX0SO6gX/vp5YHY+FWnjB8Almvi748uD8u7t
         aBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuFv0A/Ck/Q8e4YuvcBqj0gUpgGQfLBTSNOCt9bIelM=;
        b=45d+z+2YW58DB3sVoUTceuknWb5SivsmdQXOzVowOOXuE5N2PT/db5p9Z112od7qXH
         l05nWwZlwF6wVpYqRnkdUpDMggIM1JpkVsivRp+8o7OQmXS5vIzH+ZBippTVeVRQ8pOx
         a0dx8oEz4Krgy3w4T6pvUChkXOgSkBMBoTBehR4Fx/gD7Wrkj5l7ajDl3KVwGmh5UH/w
         99vfqB2LfNN2fTreZ+SbNkJ02ezFrcRJ9Va9Uu2rJk7IhRIaXCTInFT11TFnqhcZQwAL
         Dsn5Qhu8rMys0KAq26ULxCrIy9H1GQKX0dRuPyNJCCeXtTox7MQg0MvhjNsQKpl0TEcK
         B/AQ==
X-Gm-Message-State: AO0yUKXL2lKLStJ7TWN8Z/4OVsJ4LogRY3XDVWW0rUu7gHRdmIjAFMGY
        vo/okCNP22Bi2Cq5O4K3+r7GeQ==
X-Google-Smtp-Source: AK7set8MWjv/nOw2kbx81+IF1fiyHTSOf4h0lLrxKVo1CstC0uzddY+5gW9iITvsxJwK/wF6dptGJw==
X-Received: by 2002:a05:6a20:8f08:b0:c7:6a98:5bdc with SMTP id b8-20020a056a208f0800b000c76a985bdcmr22521829pzk.16.1678226749788;
        Tue, 07 Mar 2023 14:05:49 -0800 (PST)
Received: from jerry-desktop3.skydio.lan ([50.217.93.66])
        by smtp.gmail.com with ESMTPSA id j14-20020a62e90e000000b005a8de0f4c76sm8596844pfh.17.2023.03.07.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:05:49 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
X-Google-Original-From: Jerry Zhang <Jerry@skydio.com>
Cc:     embedded@skydio.com, Jerry Zhang <Jerry@skydio.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sunrpc: Fix incorrect parsing of expiry time
Date:   Tue,  7 Mar 2023 14:05:25 -0800
Message-Id: <20230307220525.54895-1-Jerry@skydio.com>
X-Mailer: git-send-email 2.40.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expiry time field is mean to be expressed in seconds since boot.
The get_expiry() function parses a relative time value in seconds.
In order to get the absolute time of seconds since boot that the given
message will expire, the right thing is to add seconds_since_boot()
to the given relative value.

Previously this logic was subtracting boot.tv_sec from the relative
value, which was causing some confusing behavior. The return type of
time64_t could possibly underflow if time since boot is greater than
the passed in relative argument. Also several checks in nfs code compare
the return value to 0 to indicate failure, and this could spuriously
be tripped if seconds since boot happened to match the argument.

Fixes: c5b29f885afe ("sunrpc: use seconds since boot in expiry cache")
Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 include/linux/sunrpc/cache.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index ec5a555df96f..b96b1319c93d 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -301,16 +301,14 @@ static inline int get_time(char **bpp, time64_t *time)
 }
 
 static inline time64_t get_expiry(char **bpp)
 {
 	time64_t rv;
-	struct timespec64 boot;
 
 	if (get_time(bpp, &rv))
 		return 0;
 	if (rv < 0)
 		return 0;
-	getboottime64(&boot);
-	return rv - boot.tv_sec;
+	return rv + seconds_since_boot();
 }
 
 #endif /*  _LINUX_SUNRPC_CACHE_H_ */
-- 
2.37.3

