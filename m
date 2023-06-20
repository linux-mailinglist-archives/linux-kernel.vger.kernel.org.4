Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7B736D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjFTN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjFTN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:27:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD1B4;
        Tue, 20 Jun 2023 06:27:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7156921846;
        Tue, 20 Jun 2023 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687267637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdu4SLeXRX96eYJIkjFLNcHQfvWSCAFCqgoWIOGzVEU=;
        b=VpHAssbZ6FRo5bahpfqMn2JLtxTsbdwQg8XiNVzAWn97FXnm2W4DQ0d0Ut+s3zkXWwPh9+
        jtUimsqy1R29joc6RPnp3JJmhuwmybTMHTgD/yOAeKdyCcYoUEON9FxV4TQ5EA8R1kYDvZ
        p+wheu/EeNaK0wnzNf7kARKfnfjwCnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687267637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdu4SLeXRX96eYJIkjFLNcHQfvWSCAFCqgoWIOGzVEU=;
        b=KX02MQlMHQWX8D3ST42NL2EOoRv3f2X0aZYichzWCZ1f8zSFb8mwk5+Uwc6XodYr/je8+R
        65J8aSgfNXeRXSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6370B1346D;
        Tue, 20 Jun 2023 13:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YfhCGDWpkWSdOAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:27:17 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 1/3] nvme/048: Check for queue count check directly
Date:   Tue, 20 Jun 2023 15:27:01 +0200
Message-ID: <20230620132703.20648-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620132703.20648-1-dwagner@suse.de>
References: <20230620132703.20648-1-dwagner@suse.de>
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
 tests/nvme/048 | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/048 b/tests/nvme/048
index 81084f0440c2..3dc5169132de 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -42,6 +42,26 @@ nvmf_wait_for_state() {
 	return 0
 }
 
+nvmf_wait_for_queue_count() {
+	local subsys_name="$1"
+	local queue_count="$2"
+	local nvmedev
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+
+	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+
+	queue_count=$((queue_count + 1))
+	if grep -q "${queue_count}" "${queue_count_file}"; then
+		return 0
+	fi
+
+	echo "expected queue count ${queue_count} not set"
+	return 1
+}
+
 set_nvmet_attr_qid_max() {
 	local nvmet_subsystem="$1"
 	local qid_max="$2"
@@ -56,10 +76,7 @@ set_qid_max() {
 	local qid_max="$3"
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
-
-	# Setting qid_max forces a disconnect and the reconntect attempt starts
-	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
 
 	return 0
 }
@@ -77,12 +94,8 @@ test() {
 
 	_setup_nvmet
 
-	hostid="$(uuidgen)"
-	if [ -z "$hostid" ] ; then
-		echo "uuidgen failed"
-		return 1
-	fi
-	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	hostid="${def_hostid}"
+	hostnqn="${def_hostnqn}"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
@@ -103,7 +116,7 @@ test() {
 			echo FAIL
 		else
 			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
-			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
+			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
 		fi
 
 		_nvme_disconnect_subsys "${subsys_name}"
-- 
2.41.0

