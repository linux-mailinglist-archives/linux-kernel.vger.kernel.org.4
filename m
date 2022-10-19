Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFEB603BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJSIhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJSIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5274F677;
        Wed, 19 Oct 2022 01:37:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 131EF339ED;
        Wed, 19 Oct 2022 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666168642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7VyTjcX7VW48TVL80NmZysRhyGrdRwOMNYwKQUMavo=;
        b=edqx8wbz4Mm+r4zK7xBid02cl0Hen8mMeleU9d9POi505+eX92W7XmE4mbJgKSjnux9OrX
        HR0EtpTnR6+nINT+Qn75I5xYJIG1kMX2dUK4ki6v3695x5G2bDM9W8FeHutx/GCeg7enWV
        HDBk4lpFsOm0lqEFWM8mD4qWqD+NibI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666168642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7VyTjcX7VW48TVL80NmZysRhyGrdRwOMNYwKQUMavo=;
        b=dZPyjF1y8YbtDITpU29vZ91BAv8tTFw6T4i8RK/1levpSBAkUq5I+PahlYVT0y72721d2d
        GSIjW/09iXZBXYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0354F13345;
        Wed, 19 Oct 2022 08:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RHk4AEK3T2NLZQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 19 Oct 2022 08:37:22 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 2/5] padata: make padata_free_shell() to respect pd's ->refcnt
Date:   Wed, 19 Oct 2022 10:37:05 +0200
Message-Id: <20221019083708.27138-3-nstange@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019083708.27138-1-nstange@suse.de>
References: <20221019083708.27138-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a PREEMPT kernel, the following has been observed while running
pcrypt_aead01 from LTP:

  [ ] general protection fault: 0000 [#1] PREEMPT_RT SMP PTI
  <...>
  [ ] Workqueue: pdecrypt_parallel padata_parallel_worker
  [ ] RIP: 0010:padata_reorder+0x19/0x120
  <...>
  [ ] Call Trace:
  [ ]  padata_parallel_worker+0xa3/0xf0
  [ ]  process_one_work+0x1db/0x4a0
  [ ]  worker_thread+0x2d/0x3c0
  [ ]  ? process_one_work+0x4a0/0x4a0
  [ ]  kthread+0x159/0x180
  [ ]  ? kthread_park+0xb0/0xb0
  [ ]  ret_from_fork+0x35/0x40

The pcrypt_aead01 testcase basically runs a NEWALG/DELALG sequence for some
fixed pcrypt instance in a loop, back to back.

The problem is that once the last ->serial() in padata_serial_worker() is
getting invoked, the pcrypt requests from the selftests would signal
completion, and pcrypt_aead01 can move on and subsequently issue a DELALG.
Upon pcrypt instance deregistration, the associated padata_shell would get
destroyed, which in turn would unconditionally free the associated
parallel_data instance.

If padata_serial_worker() now resumes operation after e.g. having
previously been preempted upon the return from the last of those ->serial()
callbacks, its subsequent accesses to pd for managing the ->refcnt will
all be UAFs. In particular, if the memory backing pd has meanwhile been
reused for some new parallel_data allocation, e.g in the course of
processing another subsequent NEWALG request, the padata_serial_worker()
might find the initial ->refcnt of one and free pd from under that NEWALG
or the associated selftests respectively, leading to "secondary" UAFs such
as in the Oops above.

Note that as it currently stands, a padata_shell owns a reference on its
associated parallel_data already. So fix the UAF in padata_serial_worker()
by making padata_free_shell() to not unconditionally free the shell's
associated parallel_data, but to properly drop that reference via
padata_put_pd() instead.

Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 kernel/padata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 3bd1e23f089b..0bf8c80dad5a 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -1112,7 +1112,7 @@ void padata_free_shell(struct padata_shell *ps)
 
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
-	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
+	padata_put_pd(rcu_dereference_protected(ps->pd, 1));
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
-- 
2.37.3

