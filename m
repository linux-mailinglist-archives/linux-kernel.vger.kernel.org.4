Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0074582E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGCJRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGCJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:16:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC0191;
        Mon,  3 Jul 2023 02:16:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 379731FD72;
        Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688375815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=;
        b=AYN6Xg5ypCLI8zd2oJ/WFghR//Umb+TVkxatu2rqY+riUBTN8uOgJYo72f5tilyspvJmhi
        XlMGYX8FZRRrASEccYMIfJ11tc/REdDaUt9x072X1oeQdw9uVbZCd2ilDOs392wjBlERwM
        f3/Y8M8nT8SWQ5CmfqV41Yi+Wv3ygxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688375815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/IJwReM/uXABoejcS3ER1zTUO2yvPD9h8VV7ZhYdrs=;
        b=4IzB3ZJCS0YkTVGdVhkf1yUtpT3iH6mRH45T72e4QNjOLQDYo/Ik3Ll3A33Gnk6HaWYUjh
        QEvU4exRzv9RxuBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29C2313276;
        Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3M7bCQeSomSJDgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 09:16:55 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 1/3] nvme/048: Check for queue count check directly
Date:   Mon,  3 Jul 2023 11:16:45 +0200
Message-ID: <20230703091647.800-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703091647.800-1-dwagner@suse.de>
References: <20230703091647.800-1-dwagner@suse.de>
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

The test monitored the state changes live -> resetting -> connecting ->
live, to figure out the queue count change was successful.

The fc transport is reconnecting very fast and the state transitions
are not observed by the current approach.

So instead trying to monitor the state changes, let's just wait for the
live state and the correct queue number.

As queue count is depending on the number of online CPUs we explicitly
use 1 and 2 for the max_queue count. This means the queue_count value
needs to reach either 2 or 3 (admin queue included).

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/048 | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 81084f0440c2..bbfb9873b5e8 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -42,6 +42,24 @@ nvmf_wait_for_state() {
 	return 0
 }
 
+nvmf_check_queue_count() {
+	local subsys_name="$1"
+	local queue_count="$2"
+	local nvmedev
+	local queue_count_file
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	queue_count_file=$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_count)
+
+	queue_count=$((queue_count + 1))
+	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
+		echo "expected queue count ${queue_count} not set"
+		return 1
+	fi
+
+	return 0
+}
+
 set_nvmet_attr_qid_max() {
 	local nvmet_subsystem="$1"
 	local qid_max="$2"
@@ -56,10 +74,8 @@ set_qid_max() {
 	local qid_max="$3"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-
-	# Setting qid_max forces a disconnect and the reconntect attempt starts
-	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
 	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
 
 	return 0
 }
@@ -103,7 +119,7 @@ test() {
 			echo FAIL
 		else
 			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
-			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
+			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${subsys_name}"
-- 
2.41.0

