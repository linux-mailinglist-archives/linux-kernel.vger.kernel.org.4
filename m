Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73C6BBBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjCOSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjCOSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:20:15 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA728534A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:41 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cu4so13487152qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmvH53QQmvyr82/tblOMveznsjZSWtMQ0eLvrELgokY=;
        b=AiMp38QXMO7TX9Ex53Fqj+qKtuIf9QDHoK6g5kf7FPb5LvDRL9lR4q3pABkjYygPCd
         xtrgLXSwyEtrQ5IoNv1WRYyW70egsO6RItBE5A1UbEY1r98si1HoY87B2WSsumwlNUtx
         hQ7yFbbOynQHjABcQPhpXvu+p5HgybXNekw1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmvH53QQmvyr82/tblOMveznsjZSWtMQ0eLvrELgokY=;
        b=YAH01F0nen99gmuqqqT++g9JAwx1ASjLIPTB3NQAUMd/EltdSnNS9RfLB3jruBHSnR
         a4E5Z6Q8VCE6qPDdzma8IvGPC+sp6avL+MbprUfPpzvVNw6fAN0P0Xj43OaJGXaVCX/E
         PI5OZ6aNXozN0/MT+G5Xxv5mFckdPsA2E06EMxBSENNjYkooK4MbUBWMb/HCcEGxpqKY
         nZ4uBdmwrb9xbHuhGS4kHvtTmUEgvBWKF37cUs23uVK2wIyABaygGyS31V4Cdv4d+Zgw
         gza4YUJkuKeIBhv+5rYpIi+QimTR2AcyupMtIYmdMFMGgzTe/IxWn5hehEZWr229hTAW
         95Mg==
X-Gm-Message-State: AO0yUKWrwcQe3JHOS/Af18x2pqFtVFb86D+q2Q6YbbLIrkOPuMvCqMvx
        HGX3DIButjiLvw6VCOVNoFZrPrMkyS5dCMqZcho=
X-Google-Smtp-Source: AK7set8VWIoM+fw9HPAuncZo0c69C5zwMhD6csH9aM7kHRcJgHmyeaOuA+E2G295NLYCbIxbVoiT6w==
X-Received: by 2002:a05:6214:2389:b0:56a:d94d:6deb with SMTP id fw9-20020a056214238900b0056ad94d6debmr23706425qvb.25.1678904379286;
        Wed, 15 Mar 2023 11:19:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] checkpatch: Error out if deprecated RCU API used
Date:   Wed, 15 Mar 2023 18:19:01 +0000
Message-Id: <20230315181902.4177819-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single-argument kvfree_rcu() usage is being deprecated [1] [2]. However,
till all users are converted, we would like to introduce checkpatch
errors for new patches submitted.

This patch adds support for the same. Tested with a trial patch.

For now, we are only considering usages that don't have compound
nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
This is sufficient as such usages are unlikely.

Once all users are converted and we remove the old API, we can also revert this
checkpatch patch then.

[1] https://lore.kernel.org/rcu/CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com/
[2] https://lore.kernel.org/rcu/CAEXW_YSY=q2_uaE2qo4XSGjzs4+C102YMVJ7kWwuT5LGmJGGew@mail.gmail.com/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c9..9da0a3cb1615 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6388,6 +6388,15 @@ sub process {
 			}
 		}
 
+# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
+		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
+			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
+				ERROR("DEPRECATED_API",
+				      "Single-argument k[v]free_rcu() API is deprecated, please call the API with an rcu_head object passed, like: k[v]free_rcu(object_ptr, rcu_head_name);  " . $herecurr);
+			}
+		}
+
+
 # check for unnecessary "Out of Memory" messages
 		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
 		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
-- 
2.40.0.rc1.284.g88254d51c5-goog

