Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B7603BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJSIhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJSIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9DA5AC4E;
        Wed, 19 Oct 2022 01:37:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9552D2036F;
        Wed, 19 Oct 2022 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666168640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lE4h/gGDAk0yBt10s+3hx9RfdJ8m3r4PL0TleCCgZbQ=;
        b=XtfXblThih+H2z3lXpWveY5SYLNoqVOf1AWNmNq5EaoqAZoO6IwlMk+4jBXy7DT9i0vH4F
        mhaksZClG2j+TwYoS3FPm3nLcrbqV21Msx5JV6xgunkt2dDo+mJo1TP9R4oxXnBq576B7X
        UoR7Yy+I6Q8mo/krl7I5hrQH48MVBeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666168640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lE4h/gGDAk0yBt10s+3hx9RfdJ8m3r4PL0TleCCgZbQ=;
        b=yyavfjPgl7g9/9+NRoB0ar2h6C9zBUX9P4LhQwxE8ooKVWbJzugc7hkWGWM9dBYzp0xwfH
        jr58J9t/Dc6Z0TAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8514613345;
        Wed, 19 Oct 2022 08:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lJtYIEC3T2NFZQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 19 Oct 2022 08:37:20 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 1/5] padata: introduce internal padata_get/put_pd() helpers
Date:   Wed, 19 Oct 2022 10:37:04 +0200
Message-Id: <20221019083708.27138-2-nstange@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019083708.27138-1-nstange@suse.de>
References: <20221019083708.27138-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next commit in this series will add yet another code site decrementing
a struct parallel_data's refcount and invoking dealloction as appropriate.

With that, it's due to provide proper helper functions for managing
parallel_datas' refcounts and to convert the existing open-coded
refcount manipulation sites.

Implement padata_put_pd() as well as a padata_put_pd_many() for batched
releases as needed in padata_serial_worker(). For symmetry reasons, also
provide a padata_put_get(), even though its implementation is fairly
trivial.

Convert the exisiting open-coded parallel_data ->refcnt manipulation code
sites to these new helpers.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 kernel/padata.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e5819bb8bd1d..3bd1e23f089b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -45,6 +45,10 @@ struct padata_mt_job_state {
 };
 
 static void padata_free_pd(struct parallel_data *pd);
+static inline void padata_get_pd(struct parallel_data *pd);
+static void padata_put_pd_many(struct parallel_data *pd, int cnt);
+static inline void padata_put_pd(struct parallel_data *pd);
+
 static void __init padata_mt_helper(struct work_struct *work);
 
 static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
@@ -198,7 +202,7 @@ int padata_do_parallel(struct padata_shell *ps,
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-	refcount_inc(&pd->refcnt);
+	padata_get_pd(pd);
 	padata->pd = pd;
 	padata->cb_cpu = *cb_cpu;
 
@@ -370,8 +374,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 	}
 	local_bh_enable();
 
-	if (refcount_sub_and_test(cnt, &pd->refcnt))
-		padata_free_pd(pd);
+	padata_put_pd_many(pd, cnt);
 }
 
 /**
@@ -608,6 +611,22 @@ static void padata_free_pd(struct parallel_data *pd)
 	kfree(pd);
 }
 
+static inline void padata_get_pd(struct parallel_data *pd)
+{
+	refcount_inc(&pd->refcnt);
+}
+
+static void padata_put_pd_many(struct parallel_data *pd, int cnt)
+{
+	if (refcount_sub_and_test(cnt, &pd->refcnt))
+		padata_free_pd(pd);
+}
+
+static inline void padata_put_pd(struct parallel_data *pd)
+{
+	padata_put_pd_many(pd, 1);
+}
+
 static void __padata_start(struct padata_instance *pinst)
 {
 	pinst->flags |= PADATA_INIT;
@@ -654,8 +673,7 @@ static int padata_replace(struct padata_instance *pinst)
 	synchronize_rcu();
 
 	list_for_each_entry_continue_reverse(ps, &pinst->pslist, list)
-		if (refcount_dec_and_test(&ps->opd->refcnt))
-			padata_free_pd(ps->opd);
+		padata_put_pd(ps->opd);
 
 	pinst->flags &= ~PADATA_RESET;
 
-- 
2.37.3

