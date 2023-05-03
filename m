Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915A26F52A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjECIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjECIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A733646AE;
        Wed,  3 May 2023 01:03:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D6B4223FE;
        Wed,  3 May 2023 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2pq1wjnhWpzpAUzywg7yjYCKpUJJXlcUeZCAZuKjeQ=;
        b=ajMzP1vczLO7G7jIFOc9NiidYl3WFlbFEYBsoWk5mT4U81vaYTbjZr9pcOOAfYA5/Wnv8n
        gF9mfH3QzZ7eqmT/3/XLXcCx9W5GVaars2uGz/GGATDQq6hjZmjYuzdhQ3Je48S7Eq3jCT
        uDZ5XBFtdofwoW/HsWrSRNr3T6fr1CE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2pq1wjnhWpzpAUzywg7yjYCKpUJJXlcUeZCAZuKjeQ=;
        b=Fdy1nUpx1DqPaJ5pDiwa7wy5yJ4yRGpqmlpU+rtEVOjvLbIo3wBU/xMLMqZWOjUkcxeUOP
        6NKxwyuyAGhxFrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F66A1331F;
        Wed,  3 May 2023 08:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bwWbC0MVUmRDYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:15 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Date:   Wed,  3 May 2023 10:02:55 +0200
Message-Id: <20230503080258.14525-10-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the number of random threads to 32 for big machines. This still
gives enough randomness but limits the resource usage.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/fio | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/fio b/common/fio
index 1db6128be632..06659d7d1d84 100644
--- a/common/fio
+++ b/common/fio
@@ -189,7 +189,8 @@ _run_fio() {
 # Wrapper around _run_fio used if you need some I/O but don't really care much
 # about the details
 _run_fio_rand_io() {
-	_run_fio --bs=4k --rw=randread --norandommap --numjobs="$(nproc)" \
+	_run_fio --bs=4k --rw=randread --norandommap \
+		--numjobs="$(OMP_THREAD_LIMIT=32 nproc)" \
 		--name=reads --direct=1 "$@"
 }
 
-- 
2.40.0

