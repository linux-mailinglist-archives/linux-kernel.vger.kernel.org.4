Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9206869A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjBAPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjBAPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:10:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95F6A4A;
        Wed,  1 Feb 2023 07:10:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id me3so52324270ejb.7;
        Wed, 01 Feb 2023 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udBAvOMF3811JfYnSoT7LY+mJh84zG4u72FA8SZ9FR4=;
        b=OHVpVmxeTI4WIC/hMW77qq/3M0DYZ8oeiiu5IwlZPDc2WrZd5zGiPSY3+MgQshnyhq
         q8RRXneNaoThH+BSsl7yGpGAXOIdI5GQ2o+idk+Ep7WHv7x60cthSzv9HyAhJdcE+wfc
         11xvrWuwk/WVhOz/ALiP14scR4RIIfgymPP+u4yoVFyJRZRgNXbAUL83fypVgRO/8MED
         dbSP9u/V6eFX/Hgjet+gdwWTsjdEo8acvqFDhgqNb1+3macxbT2UqHm0ognGTVKgR3ji
         b1p5ScJtqq3hCyJWVjyfnl4D/LceUb0ApBREvhvbaGZb+5LWDvVt3VnZbjRjqHmtAc6Q
         qwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udBAvOMF3811JfYnSoT7LY+mJh84zG4u72FA8SZ9FR4=;
        b=AhFMEMzO+so2ItRBqS0N1pJcafxsOq23BsiihevxFADEUynU5KPB4mUrmeWiHmGOQx
         JgN/YrfvS2U9/Am1mG2U01RONH14w9EgKhSvLT1Og7S+VcWof4cgHtI89v41VyBG6cOc
         G1wPbC3i8SBURnG3ubSHy06kdJIYs0jRRMDRGxtLApLZplCoOFBR/0f2mJupaBoEPxa1
         fEGxGlJOmT+CrFcHMHuN9xteKwUlDRBltWRslCZ8cvjsO17NRrA34+lmRKLoY1oCNwEf
         ioZTwPCGAK/8u/TN/YxDuhIGAU24UTMOf+O5CXZMx7i2+FCJZjPZLIy3z90hT6FpBZRs
         WHgw==
X-Gm-Message-State: AO0yUKXO7BDJQEnBh3UClnNoC8myNs+GF0+dvPN31zDrGf2PMp/NUkV4
        Ni3tJ0NDuJFycf0V6oUbOhztK48Us2n6PA==
X-Google-Smtp-Source: AK7set8Zq5qLxwsm8eqV1R5IX9i4Gxd//12L/Vowaguej6tjOQpjg4wElp4KSFf0R3ZExOJsSuF20g==
X-Received: by 2002:a17:907:6d15:b0:877:6549:bb6 with SMTP id sa21-20020a1709076d1500b0087765490bb6mr3397994ejc.58.1675264198532;
        Wed, 01 Feb 2023 07:09:58 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b008845c668408sm6627147ejc.169.2023.02.01.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:09:58 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: [PATCH 12/13] doc: Update whatisRCU.rst
Date:   Wed,  1 Feb 2023 16:09:53 +0100
Message-Id: <20230201150954.409693-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150954.409693-1-urezki@gmail.com>
References: <20230201150954.409693-1-urezki@gmail.com>
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

The kfree_rcu() macro is deprecated. Rename it to the
kfree_rcu_mightsleep() in this documentation.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 2c5563a91998..8eddef28d3a1 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -597,10 +597,10 @@ to avoid having to write your own callback::
 If the occasional sleep is permitted, the single-argument form may
 be used, omitting the rcu_head structure from struct foo.
 
-	kfree_rcu(old_fp);
+	kfree_rcu_mightsleep(old_fp);
 
-This variant of kfree_rcu() almost never blocks, but might do so by
-invoking synchronize_rcu() in response to memory-allocation failure.
+This variant almost never blocks, but might do so by invoking
+synchronize_rcu() in response to memory-allocation failure.
 
 Again, see checklist.rst for additional rules governing the use of RCU.
 
-- 
2.30.2

