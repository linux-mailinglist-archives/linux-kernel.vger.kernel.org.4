Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495965ED56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjAENle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjAENlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:41:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309E12D02;
        Thu,  5 Jan 2023 05:41:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1332341wms.2;
        Thu, 05 Jan 2023 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GyyRdgebspZF1HHBg/x+bnzRDFwvCGUNNQpRJ9GE9NE=;
        b=gVovIXNCyutrMkt3B7RkQAXY9mkDckwwv0IwDDTcMNXgyGB/xpYBpp07ss+3hnRL4r
         VNSazoyUN8XC1C5yLkMI1DcBWCH/YA+y2FXM45UghIv6aUPAUBAoFZBnNe4FEUAMegID
         3c7ZnWO5b0AYdk7acTUBed5ytK1VLXUtsK7B5zybvgrnnHOXdGMKZV75T4f0G+Hh4kbH
         opPfBEB4SE6UA4OESxQIGCoqAgfjqna0saJ9vGzS2ClRJnzWUEhhOEILucszK8ZIqZHA
         /CV/27Jtt8du9zkuwBXSoPf57ZxeJN9c0VC+b6XRkLohdWdipAVn9lU4jBJjNe6mgCo7
         8mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyyRdgebspZF1HHBg/x+bnzRDFwvCGUNNQpRJ9GE9NE=;
        b=a9idR9MiBNKwb5HIjJxgiuLep+q5KE7ZFvVc5GXZt1WiwLVgQce83R3NBJ8dYINGLd
         f3VShGEZsBpivS1O9EH7nz2ylRpQ/dZliAqI9Pkx08bboTtJBJ9fsV+ZTE6rNggBQmCI
         Bbnm2+qfwog5D7l4f3Q7OwX/73XSXv9xCSH1HMQXPdKum6bKacErNgTZXdgRc97iObaM
         ezWw/ufYxSR0R8QWDRfNCcuSo/4mkOzeUwYx24lohqtyxhHzW9nRsOyAlKRRUMXai2RJ
         32OU24nfvDDpPXBo9kUz27X9qKEUtOMubA7YLSCPkrEnAd+yhvbLmb6RTnQTilMJ+6Np
         7GSg==
X-Gm-Message-State: AFqh2kpnVRfzfw8yWlJMcAQj4Edtu9G06KpRaUCD0Ne503VRQAHHqKIz
        FldixAtNEgcRF5KqAv7wTiKb8fu8IPjp5Msw
X-Google-Smtp-Source: AMrXdXv+HroiUbAmYEH/mD+Ekli8hj6yu3IC02jJ00oTFNUO93iv3a1BHfq46uZB6xtnwejHQ1zFMQ==
X-Received: by 2002:a05:600c:b4d:b0:3d3:5d69:7aa5 with SMTP id k13-20020a05600c0b4d00b003d35d697aa5mr34879221wmr.25.1672926073037;
        Thu, 05 Jan 2023 05:41:13 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003d9780466b0sm2689085wmq.31.2023.01.05.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:41:12 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cifs: remove redundant assignment to the variable match
Date:   Thu,  5 Jan 2023 13:41:11 +0000
Message-Id: <20230105134111.45001-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable match is being assigned a value that is never read, it
is being re-assigned a new value later on. The assignment is redundant
and can be removed.

Cleans up clang scan-build warning:
fs/cifs/dfs_cache.c:1302:2: warning: Value stored to 'match' is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/cifs/dfs_cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 43ad1176dcb9..e20f8880363f 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -1299,7 +1299,6 @@ static bool target_share_equal(struct TCP_Server_Info *server, const char *s1, c
 	 * Resolve share's hostname and check if server address matches.  Otherwise just ignore it
 	 * as we could not have upcall to resolve hostname or failed to convert ip address.
 	 */
-	match = true;
 	extract_unc_hostname(s1, &host, &hostlen);
 	scnprintf(unc, sizeof(unc), "\\\\%.*s", (int)hostlen, host);
 
-- 
2.30.2

