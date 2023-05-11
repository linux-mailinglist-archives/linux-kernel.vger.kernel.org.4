Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA96FF3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjEKOLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbjEKOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418C2E729;
        Thu, 11 May 2023 07:10:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75E5021D11;
        Thu, 11 May 2023 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBBNJFzPgSeRiv4JN3mjqd7wSLy3Fu+TgA+AgZ0WBjU=;
        b=b7hIN+CGfSesgk7ANYYMMoV34Zqgdlrht2Q5N8Mkh2dPgsuuN59ZrZZcxx+/IKShjiimI2
        ORvfcTRsvbzdyCZa+KRAC8doFtIGGUoPBrPZwGyceFSCAI4qqr9qDg1r0Kg8po5XSBxmgF
        VBJAqF0WbKJpI/eZRW+/Rq66xNA4HfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814224;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBBNJFzPgSeRiv4JN3mjqd7wSLy3Fu+TgA+AgZ0WBjU=;
        b=hkwG1AqZvoTCwLoOT2+WQG1DhA3JUNoRmY8aPF0cl0PGvgBsomI1ieKWFfBcfeBKsUB/BY
        2rKfmFcbD3P50vCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AA48134B2;
        Thu, 11 May 2023 14:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XjqHOU/3XGSgPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:23 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 11/11] nvme{016,017}: Make the number iterations configurable
Date:   Thu, 11 May 2023 16:09:53 +0200
Message-Id: <20230511140953.17609-12-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some tests hard code high values of iterations. This makes them run
relatively long compared to the other tests. Introduce a new environment
variable nvme_num_iter to allow tune the runtime.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 2 ++
 tests/nvme/016                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/rc                  | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 4d8393f2002d..b35ae10316e4 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -107,6 +107,8 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
+- nvme_num_iter: 1000 (default)
+  The number of iterations a test should do.
 
 ### Running nvme-rdma nvmeof-mp srp tests
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 4eba30223a08..c0c31a55b190 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -17,7 +17,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local port
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local subsys_nqn="blktests-subsystem-1"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 0248aee9bc41..e1674508f654 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -18,7 +18,7 @@ test() {
 
 	local port
 	local file_path
-	local iterations=1000
+	local iterations="${nvme_num_iter}"
 	local subsys_name="blktests-subsystem-1"
 
 	_setup_nvmet
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 11357cbf7816..933b585643ac 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -18,6 +18,7 @@ def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
 def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
+nvme_num_iter=${nvme_num_iter:-"1000"}
 
 _nvme_requires() {
 	_have_program nvme
-- 
2.40.0

