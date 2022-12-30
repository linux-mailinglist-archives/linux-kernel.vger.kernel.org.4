Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37AA659CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 23:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiL3WSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 17:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiL3WSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:18:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F01D0CE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 14:18:48 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 124so15223240pfy.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 14:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2Eiv94gXUiZTv5jAScVh7PDfObsExkg3yzW4Xpf6ec=;
        b=fNbGZ4QS1HISSASq84ExMqyKXBgayNGI3wh9FOogNgn/9U4PUJa6k3MDw4iJDpXDVw
         g33v+aBkLjcDNP/0V7iywo0w0E47ArN7b3gQ/yic61BeaRtixcmGCjhk//+k+3KMaqQh
         4/wwEkgdUgbmwoF9QKdQFSjS21IH00hHfftRf6FLMNqBOhhsEGlUIFrk1K2rFoPEDFh0
         5Fi5ZvJmHMgM5y7KanqjryE2NtPrfMAn1zVI5ye17I9mj5mBBuzlOJai3YxoCtIKg4N1
         kTe940rRMu4WeEvQ9vbYxbDd37jjZSp8mN+2Em0iy7ZjOV4VmRj8eyJA6k8BcBa0FRri
         PoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2Eiv94gXUiZTv5jAScVh7PDfObsExkg3yzW4Xpf6ec=;
        b=eQnijaC7Xaor+HgdvaHOdRFPtyMAqCIIw3GmqW3+rlhxuuJN5FU8yC7IKKUZ7L3HdD
         7vHPfZXE5jc95K8udTNUwtSosi/CO45TK7awl1+/j3efSt8tPGIbfPM/UTUxBQnqRBoX
         dg6GLtJKzWePNnwozumUjSKh1FTrDhI8MUdGN3YV/MGGPJ4Co9lllTyuUUmnYh8lOICl
         1ysWK4fv4sHPP6zzsdkUubr8KOlEa8SqfSR2WFWQTr3cK80VJ5HnzUKGo8/KegzkfKKf
         Lu4vaMAPwzav5GQLdVa3qqBAR0XYi/3JhEYbr2YN24HE2JHCqhYuW+5LI/yQeUigE5lC
         HKfg==
X-Gm-Message-State: AFqh2kpTxii11sELenP9uGx6+dNabETSbv/CU1UQO5LlOHuV1JnKd3/g
        8rx23VR41/dbtRrpnjHNnwhNoA==
X-Google-Smtp-Source: AMrXdXvtcuEKwIXXtSk8m7o7D45t2sYdbzWBSy8axpB+FNv1xERaZ/adkxA59s+qLBTh0RBwQhKK6Q==
X-Received: by 2002:aa7:8084:0:b0:574:8995:c0d0 with SMTP id v4-20020aa78084000000b005748995c0d0mr2652914pff.1.1672438727649;
        Fri, 30 Dec 2022 14:18:47 -0800 (PST)
Received: from [2620:15c:29:203:8954:8b68:67ce:a964] ([2620:15c:29:203:8954:8b68:67ce:a964])
        by smtp.gmail.com with ESMTPSA id c21-20020a621c15000000b00581498190efsm8267889pfc.161.2022.12.30.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 14:18:46 -0800 (PST)
Date:   Fri, 30 Dec 2022 14:18:46 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
cc:     Peter Gonda <pgonda@google.com>, Andy Nguyen <theflow@google.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        John Allen <john.allen@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
In-Reply-To: <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
Message-ID: <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
References: <20221214202046.719598-1-pgonda@google.com> <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au> <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com> <Y6wDJd3hfztLoCp1@gondor.apana.org.au> <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SEV_GET_ID2, the user provided length does not have a specified 
limitation because the length of the ID may change in the future.  The 
kernel memory allocation, however, is implicitly limited to 4MB on x86 by 
the page allocator, otherwise the kzalloc() will fail.

When this happens, it is best not to spam the kernel log with the warning.  
Simply fail the allocation and return ENOMEM to the user.

Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
Reported-by: Andy Nguyen <theflow@google.com>
Reported-by: Peter Gonda <pgonda@google.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -881,7 +881,14 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 	input_address = (void __user *)input.address;
 
 	if (input.address && input.length) {
-		id_blob = kzalloc(input.length, GFP_KERNEL);
+		/*
+		 * The length of the ID shouldn't be assumed by software since
+		 * it may change in the future.  The allocation size is limited
+		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
+		 * If the allocation fails, simply return ENOMEM rather than
+		 * warning in the kernel log.
+		 */
+		id_blob = kzalloc(input.length, GFP_KERNEL | __GFP_NOWARN);
 		if (!id_blob)
 			return -ENOMEM;
 
