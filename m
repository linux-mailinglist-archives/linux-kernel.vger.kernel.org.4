Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCC6AD53F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCGDFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCGDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:05:16 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6456BC1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 19:05:07 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z6so13149033qtv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 19:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678158306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lY+Nip7wJV+VZxdEHCUjTyczS4FvHFA8te+MeEMaKDU=;
        b=VY3fQPmtNzN3/ulBjNppq6O9TVhTu+wLj3D+zS2FhPOvqhTV4J4erHGGTi4mPDTeJ9
         gi8QGD7M3n5PKLiQEbD4mFyizskOVqicIsxodD83AjdMrkDPnfi2Qt+bQRpvpQQRPwpi
         5eDhCelSy4RGLI+u119OXmzMC0BJIxBM2LPqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678158306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY+Nip7wJV+VZxdEHCUjTyczS4FvHFA8te+MeEMaKDU=;
        b=mXndUypNvhKxc3uIbp9AK1yiYb9+bhKqUpRaaWeLTZrnyXhPJ9lJVoYlgIuAMsCDnc
         pibTsYmE35/e93qLBW/FF++pagbvY2c+AshxIF3LMXay/JFR6Vs9851AiKimo0oqnMaC
         iYyYGtRSVgqIBAyPbh+wFEp34djSSKMrRZq66BQJJTUEKxeXn8EFy92HQILsJ8xX4Jmn
         REUVfjbAeOPzrWCjmUuNot+9pCPDyCZzzQUTibFWd/WH4BHn453hQf6C+n8grxG0U6Hb
         WvMbgEXYRyzs3X8/fl/MX7HV6NOTIL/ubPWD01w1u5cPQbI731m/Yto3T112L1jciyhT
         kmUg==
X-Gm-Message-State: AO0yUKXv1rl2w15h3VlaLZnQUBPR7qblGmx4tG2lXLK29sh5udDRN/Jl
        MZifdKVKb0+B7c4BcEyg0llgrSr7ikEmrSSfNf4=
X-Google-Smtp-Source: AK7set8eYJM2ZEP7cocrzn+1e5IBEbAW5UUCwLJku8/7NMlBHAJQcXKXc25GcgBPL+HMshhx4rNJCQ==
X-Received: by 2002:ac8:5b15:0:b0:3b6:33c6:c5ac with SMTP id m21-20020ac85b15000000b003b633c6c5acmr21594114qtw.4.1678158305773;
        Mon, 06 Mar 2023 19:05:05 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id dt11-20020a05620a478b00b0073b399700adsm8664833qkb.3.2023.03.06.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 19:05:04 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] checkpatch: Error out if deprecated RCU API used
Date:   Tue,  7 Mar 2023 03:04:57 +0000
Message-Id: <20230307030457.3499834-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
error-prone. However, till all users are converted, we would like to introduce
checkpatch errors for new patches submitted.

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
 scripts/checkpatch.pl |  9 +++++++++
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
2.40.0.rc0.216.gc4246ad0f0-goog

