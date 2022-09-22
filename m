Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C55E5816
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIVBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIVBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:34:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE4E7E;
        Wed, 21 Sep 2022 18:34:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x1so7382678plv.5;
        Wed, 21 Sep 2022 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=f2GYAPjGytreCqfwFeLf15gOWqnBBF1ZtmJUJlelVfI=;
        b=kBr8AKSPX5/uW6Seli3WG2p+5WtfSleavPkNeZY1/Eq5MLWmuvx9D98PZqSCh/uDa2
         U9Ni4hrWsdH8f02UE/NOnffnTot9X6yxR8pBBFhh+EDlQJ1wsjsbNCII02IddmU4zERU
         ISjf9sdm9DBa/wOElhOxqnDCugh3LGs384B9sw649uiozW6wQizpRsdIVdQ+n8nDov4u
         bL7+87yNLDsCrAUXPd/ukxF1UdvIOy60di32sGJ4hK01DuGwkdK6KWIaADuHVrv/YcZ7
         ziaccH+i3UJRzqBGZQq3gjNBeibxLg7zX2n+w5KTzaBCA8gEJGdVXFgD+Pr7EfJjPNop
         B94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=f2GYAPjGytreCqfwFeLf15gOWqnBBF1ZtmJUJlelVfI=;
        b=rRpcWu2ipNEJxqXaRBez696oJZGcnvsS7xsAghwf35xoz+sVEjIZ/81CPpCRPJQ245
         VBoUT4z/Ty2FKzdsIFBM/AmXWYXh8eLAcnq2ESX3bkeCuDGhUjLGIVPiSiiLyXxhntA0
         ChAK49SaQpydePIFZWa+aatIu8eoe2Evp+4y8LZ+bvATbYvDABhD9+sNyAsGmEWiYY+O
         5nAXieWGW7F4RtI2iQ7rNef9TbSO/y//b+db2JbSy/+yFjYwL8LQfhNzm4VP2ACt7c6x
         viRasCiWEvlJN8CevJ9nEganJePga22rDf8qJuAueqzaKYWZmy4o0A76SXIhz0Nt+Dzs
         7rew==
X-Gm-Message-State: ACrzQf2j3EnCTOt7mnpOfYJGD5h/YyIIqEhJN8sHt1bIKhObnJFGi37+
        gnXNsycrjtiKxTTgAo8oXAU=
X-Google-Smtp-Source: AMsMyM4cJ6y2ka96Wp3PKSA5ofxGQ5/lUrJdDfmsX7P5lWGpa0FTA7yUfIRwRSyQ5isyOgSA7i5cow==
X-Received: by 2002:a17:90a:be0a:b0:200:5dda:910a with SMTP id a10-20020a17090abe0a00b002005dda910amr13030008pjs.114.1663810469454;
        Wed, 21 Sep 2022 18:34:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y26-20020aa79afa000000b0053ebe7ffddcsm2902471pfp.116.2022.09.21.18.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:34:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf probe-file: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:34:24 +0000
Message-Id: <20220922013424.233053-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/util/probe-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 3d50de3217d5..8bc90b856ce3 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -459,7 +459,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
 
 	if (target && build_id_cache__cached(target)) {
 		/* This is a cached buildid */
-		strlcpy(sbuildid, target, SBUILD_ID_SIZE);
+		strscpy(sbuildid, target, SBUILD_ID_SIZE);
 		dir_name = build_id_cache__linkname(sbuildid, NULL, 0);
 		goto found;
 	}
-- 
2.25.1
