Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4913A5FEC54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJNKIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJNKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:08:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27DE1C8417
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 03:07:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so6773187wrj.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK2HhZFuYKBw9Q1i1G+ZYdrg12Uwlkokjhvoi/Q+HPY=;
        b=Q12kDcAzx20GbyBwu82F09Ued3HbvtAmoSfgYktrLlHUxhFVva+VbCLnOORVMgJJ68
         m1V2dJ2/LxOOba2XMIYnLgS00yWRtc9i/wJhpaeW1um5b8wTmHAL/expuRyQauiQFAsr
         U4WUyjJ1jSL6zmYaPgvpvjRXBmxUp+mv3JrwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK2HhZFuYKBw9Q1i1G+ZYdrg12Uwlkokjhvoi/Q+HPY=;
        b=c9bQfNDKn5R+Rlj/dF0Ic+iBwh6ShFlPJa4iIXEW34uaqog5Gtasa/qsg4YhAs7B8X
         n0JP14Kb+c3QIsDVxLn7NzgigIriGyVJW00ZP8CJ/xImk0MbqZ0oN/Pk3Q3VqD/ULTD+
         abmk6J0Y81w0tuICzhBjiuvKJWiz4304Q2CnAO9+RLWSxwSNdSXXv18fxKpSw4p57gKI
         zO6fbYn5wz/GTlhtCTQ5ouIRUkY2YQD5HZD8JYcdxip9JZN0wtvaIYOtDC9e16YgTdXI
         hr4OIoTzZw9Lw9L/I/MMuVsbmJ2CNvZLdTLv3llgPKzOp4EOJpscLGICUi34WvM4aO0l
         rd/g==
X-Gm-Message-State: ACrzQf2HghDhkIKWriOo8zqsSJGlw2xfG8bY3ZJVHJp8HG4k+jYYp0ly
        9ygURwXNn4i8IKpU1R6HHREOaw==
X-Google-Smtp-Source: AMsMyM6DWkbFsKMaUZdaXa24yX9XWkVFPkekjvx0o5XgsrJElKco8OsZ9YjMxQQu0bBYZIpsa+UiiA==
X-Received: by 2002:adf:ea04:0:b0:22e:6545:9963 with SMTP id q4-20020adfea04000000b0022e65459963mr2748701wrm.417.1665742075710;
        Fri, 14 Oct 2022 03:07:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:5308:6600:49a0:d6bf:5c1a:f3da])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d414f000000b002285f73f11dsm1931008wrq.81.2022.10.14.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 03:07:55 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 4/4] crypto: remove unused field in pkcs8_parse_context
Date:   Fri, 14 Oct 2022 11:07:37 +0100
Message-Id: <20221014100737.94742-5-ignat@cloudflare.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221014100737.94742-1-ignat@cloudflare.com>
References: <20221014100737.94742-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

remove unused field 'algo_oid' in pkcs8_parse_context

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/asymmetric_keys/pkcs8_parser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index e507c635ead5..f81317234331 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -21,7 +21,6 @@ struct pkcs8_parse_context {
 	struct public_key *pub;
 	unsigned long	data;			/* Start of data */
 	enum OID	last_oid;		/* Last OID encountered */
-	enum OID	algo_oid;		/* Algorithm OID */
 	u32		key_size;
 	const void	*key;
 	const void	*algo_param;
-- 
2.30.2

