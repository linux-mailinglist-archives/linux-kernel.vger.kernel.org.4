Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978C718E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjEaWIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEaWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:08:42 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D38E41
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:08:21 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6260de7cfaeso2198446d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685570900; x=1688162900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVpzQtIDQfKWEqbseo+tZ+eEsBzkT6BTR9cKFnwSYiE=;
        b=UVc+juOdhvc+cdjx5ehHJJwwP68jGUuabxnGl2sSfw5+c3rM6PEEz7zmzj6t/Ykjlz
         IEsXCnKiFlo+h2JixjtD4OcEGGHRU/PJBz4uJQNMcO2ZId0sz4Pi773QRZBHIET4s7rS
         u0CUYL69ZSD7t8s8GCIDl4lvJdB5gvJ7I/eFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570900; x=1688162900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVpzQtIDQfKWEqbseo+tZ+eEsBzkT6BTR9cKFnwSYiE=;
        b=PV8l5PDrEtOb1lgDDGuWGt0YfoyJXsoJY6OEPo1d2qu8u+W26yTVdS3wkcDKMfZLBD
         Fbum5qRSWZh86sjcIP4NtWM7cv3FfOQ/WbL8rsTMt6zq9ack00q/Be3FbY1Hu5axbCOb
         c6Nf9lWG6oFmEvwvVLqcFEWfoSVUtNXNXbOBD7q7K/jY8EmzlpvcN0wjwwV4IgKsyErh
         Tj3EfaNGwzHXBcXR36EcABDyjB29jp+VexCPc8q2hurcLjf+1z1rbb0MSLMwYLwx0TLv
         kyezXcpAJy3mRdzFDFpSCZ1xHCkc2UBraJRs7RQNN84yAbhuVuLldBVZIftHZS8SS/M3
         R0lg==
X-Gm-Message-State: AC+VfDyRFtSxIU70rwN4XkYWd0o3V7bR9V/byxkDMs2x5U1+mhVAobAf
        2h/tBHgYzebFL4pxRWEA779BQXZOPUW4q3P7ShI=
X-Google-Smtp-Source: ACHHUZ6MK0NGbKvNzGTkIT5KQRbjPCfTItoxAs0WkJkwEfUWMktvJqSRp0xRq7Tiv2SENcLbvIsx6Q==
X-Received: by 2002:a05:6214:1ccc:b0:625:1c04:6761 with SMTP id g12-20020a0562141ccc00b006251c046761mr8116673qvd.27.1685570899912;
        Wed, 31 May 2023 15:08:19 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003f6b0f4126fsm6666172qtk.8.2023.05.31.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:08:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH v4 3/7] selftests: mm: Fix failure case when new remap region was not found
Date:   Wed, 31 May 2023 22:08:03 +0000
Message-ID: <20230531220807.2048037-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230531220807.2048037-1-joel@joelfernandes.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a valid remap region could not be found, the source mapping is not
cleaned up. Fix the goto statement such that the clean up happens.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..6822d657f589 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -316,7 +316,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		if (addr + c.dest_alignment < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
-			goto out;
+			goto clean_up_src;
 		}
 		addr += c.dest_alignment;
 	}
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

