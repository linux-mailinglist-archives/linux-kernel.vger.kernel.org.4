Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696DC6F52A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjECIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjECIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB34237;
        Wed,  3 May 2023 01:03:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 556AA200AD;
        Wed,  3 May 2023 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UkWJx05E9MLusXpaMoAUDzDV3FpDulw27zMIYbaE6Bk=;
        b=KU2DPa6TI7pReNFUqNP0wRVepwFCjfFKul70wQS1VRH+6q/hewinLQlxjr2PsZC2u3QjPO
        PEGqhR4hMzzbp0mSwv37J7RZ+2TmhTHTE+FSBSF2qLSlCJqww/k9dS9aClssmmyO+qQ7yp
        OQyE4W/dKCspm6r2e3QKn6vf1nuLBjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UkWJx05E9MLusXpaMoAUDzDV3FpDulw27zMIYbaE6Bk=;
        b=WkFTJhIjxJcjgTR697sFSUMl2oF6CroR72eIue0A1r96lDhzJ/YT0pswtHorapXyoWaFPV
        58dLGyC09jtK+qBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C4E81331F;
        Wed,  3 May 2023 08:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xt1dDkUVUmRLYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:17 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 12/12] nvme: Make the number iterations configurable
Date:   Wed,  3 May 2023 10:02:58 +0200
Message-Id: <20230503080258.14525-13-dwagner@suse.de>
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

Some tests hard code high values of iterations. This makes them run
relatively long compared to the other tests. Introduce a new environment
variable nvme_num_iter to allow tune the runtime.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 2 ++
 tests/nvme/016                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/rc                  | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 6b34a253fd97..243975e43583 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -107,6 +107,8 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm' and 'g' postfix
 	are supported.
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
index a14458d5b80f..76ca683a40b4 100644
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

