Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E41647C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLICTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLICS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:18:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2F71D67E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:18:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so6620111pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP2JhvQ/nXbjiALnflrIMIPBw0fYLqdcvynpr/luaz4=;
        b=ShYb/nGmDFKeKcQhogFI+dsBzw/V1ttzvjMr4aRxdgwo9MDnai1pDK1eURpjYi2fJZ
         tSWE6dv5vyhz4Skq/SHYKVTnWYnEtecPQaYSzf6w8Fa52dhNAYcQDPzpoBLeuj/Hwmod
         QYTmBU8y/hdnD/a+iln4cqucW+qCdSk+HtHxP92VnjuCuqqsml3TRB0L5AMCcc/vHcLV
         No4ypahaipbq/zivtJ6WwVlb65GLPWeQroH2XIQ7DVNp3KNWyLSuHkaKaac4H090KUXo
         Yn2okwEY4iumYrZMMMWkDr/5SpsdjMXrfRYp9qmoqDnL8pYG24eUWRYQq3X8OHJ+C5xE
         i8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP2JhvQ/nXbjiALnflrIMIPBw0fYLqdcvynpr/luaz4=;
        b=DTkzPxeZRV8CNpxxfi8NVxsZ2D66gDHdufABKCUP3oFoYiVR58EfiYYcBtC/uTqFfx
         U75R3cQgS3JZrSdbUndo8wmKVALi+ueAE6JM36b6mZwlceVe0zGwIbAz7zfvqC2uvcEI
         svnpOl7Hsd4eQgbohQ9kXaJ5mI1ZT1Vpr+hyTn1mZbaQpEcnVT5oBxDm94VRQl8Mccak
         VzqYheeI7RmT4kVURLxy/d6cSjZSP2uNMrOo5Zzoy7tEXuPvqhiCurJNbVr3A8ItDHNH
         bO+UmZNqJp1d7KvE9/kn9BzsMzswpdZzyN4jjWb5J9P9QEdC7aW5aBi+VmkowZ6g/F5E
         +Vyw==
X-Gm-Message-State: ANoB5pnVDmtRi+jhRzes6JP0+UGf8VpUKwjUKN4cMBGzw9PQXlYwCSCz
        +jvtNML5coN/P0Yv20pN5ZI=
X-Google-Smtp-Source: AA0mqf6EfTKaf56Mx2uMQ1tm5kYotOCc7W9e3xxXY8+PJQdooNECNmWH6SrWa4f+Hg+qFS5qxAWzZQ==
X-Received: by 2002:a05:6a20:94c8:b0:a4:6ce5:46e7 with SMTP id ht8-20020a056a2094c800b000a46ce546e7mr5892197pzb.10.1670552335610;
        Thu, 08 Dec 2022 18:18:55 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e283-776d-8739-aa48-f251-9f2f.emome-ip6.hinet.net. [2001:b400:e283:776d:8739:aa48:f251:9f2f])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902779000b0017f5ad327casm116249pll.103.2022.12.08.18.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:18:55 -0800 (PST)
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Matt Jan <zoo868e@gmail.com>
Subject: [PATCH v3 3/3] staging: vme_user: replace 'unsigned' with 'unsigned int'
Date:   Fri,  9 Dec 2022 10:17:56 +0800
Message-Id: <20221209021756.5597-3-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209021756.5597-1-zoo868e@gmail.com>
References: <20221209021756.5597-1-zoo868e@gmail.com>
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

Update the bare use of "unsigned" to the preferred "unsigned int".

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---

Changelog
v2->v3: Resend the patch set in properly threaded and move the patch
		changelog to correct position, noted by Greg Kroah-Hartman
		<gregkh@linuxfoundation.org>
v1->v2: Resend the correct patch set, noted by Greg Kroah-Hartman
		<gregkh@linuxfoundation.org>
		Align the comment correctly, noted by Dan Carpenter
		<error27@gmail.com>

 drivers/staging/vme_user/vme_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 5da2643e20d5..11df0a5e7f7b 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -84,7 +84,7 @@ struct vme_error_handler {
 	unsigned long long end;		/* End of error window */
 	unsigned long long first_error;	/* Address of the first error */
 	u32 aspace;			/* Address space of error window*/
-	unsigned num_errors;		/* Number of errors */
+	unsigned int num_errors;	/* Number of errors */
 };
 
 struct vme_callback {
-- 
2.25.1

