Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8E736D53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjFTN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjFTN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:27:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCE185;
        Tue, 20 Jun 2023 06:27:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 165491F38A;
        Tue, 20 Jun 2023 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687267638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QGmZ/olQcis6+UwkuO2nwZxUQO0u8CCpdn9kXeK69lI=;
        b=p2LyCrwU9BVcEuKucE5EYfVVjhCTR2cBrL3CyOm3m11u09Fy+PSShBnRPWiN3oRvXtlnwv
        yX2onXbW7xqn62c/pxQgXavz+u48Ni+7Vjkxcl8J+UaxwH9VITke98KJHpAVzSH2iPX/HU
        LK9zJz7Z8WnBpNN1tIar+M/zlASJknM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687267638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QGmZ/olQcis6+UwkuO2nwZxUQO0u8CCpdn9kXeK69lI=;
        b=ePCe6gPxYXv8wXkMXq1XXyCUnZhao+eGWj+8V9InX/BxhCBQqn1cRLqblGj/9ES/Rz1RPw
        ceL6JMYchPVHO4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0658C1346D;
        Tue, 20 Jun 2023 13:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NVk8ATapkWSfOAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:27:18 +0000
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
Subject: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli autoconnect
Date:   Tue, 20 Jun 2023 15:27:02 +0200
Message-ID: <20230620132703.20648-3-dwagner@suse.de>
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

When the host has enabled the udev/systemd autoconnect services for the
fc transport it interacts with blktests and make tests break.

nvme-cli learned to ignore connects attemps when using the
--context command line option paired with a volatile configuration. Thus
we can mark all the resources created by blktests and avoid any
interaction with the systemd autoconnect scripts.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2e0c43..00117d314a38 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,8 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
-def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
-def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8"
+def_hostid="242d4a24-2484-4a80-8234-d0169409c5e8"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
@@ -161,6 +161,50 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
+_nvme_cli_supports_context() {
+	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
+		    return 1
+	fi
+	return 0
+}
+
+_setup_nvme_cli() {
+	if ! _nvme_cli_supports_context; then
+		return
+	fi
+
+	mkdir -p /run/nvme
+	cat >> /run/nvme/blktests.json <<-EOF
+	[
+	  {
+	    "hostnqn": "${def_hostnqn}",
+	    "hostid": "${def_hostid}",
+	    "subsystems": [
+	      {
+	        "application": "blktests",
+	        "nqn": "blktests-subsystem-1",
+	        "ports": [
+	          {
+	            "transport": "fc",
+	            "traddr": "nn-${def_remote_wwnn}:pn-${def_remote_wwpn}",
+	            "host_traddr": "nn-${def_local_wwnn}:pn-${def_local_wwpn}"
+	          }
+	        ]
+	      }
+	    ]
+	  }
+	]
+	EOF
+}
+
+_cleanup_nvme_cli() {
+	if ! _nvme_cli_supports_context; then
+		return
+	fi
+
+	rm -f /run/nvme/blktests.json
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -235,6 +279,8 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
+
+	_cleanup_nvme_cli
 }
 
 _cleanup_nvmet() {
@@ -337,6 +383,8 @@ _setup_nvmet() {
 		def_host_traddr=$(printf "nn-%s:pn-%s" \
 					 "${def_local_wwnn}" \
 					 "${def_local_wwpn}")
+
+		_setup_nvme_cli
 	fi
 }
 
@@ -436,18 +484,18 @@ _nvme_connect_subsys() {
 	trtype="$1"
 	subsysnqn="$2"
 
-	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	ARGS=(-t "${trtype}"
+	      -n "${subsysnqn}"
+	      --hostnqn="${hostnqn}"
+	      --hostid="${hostid}")
+	if _nvme_cli_supports_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" == "fc" ]] ; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
 		ARGS+=(-a "${traddr}" -s "${trsvcid}")
 	fi
-	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
-		ARGS+=(--hostnqn="${hostnqn}")
-	fi
-	if [[ "${hostid}" != "$def_hostid" ]]; then
-		ARGS+=(--hostid="${hostid}")
-	fi
 	if [[ -n "${hostkey}" ]]; then
 		ARGS+=(--dhchap-secret="${hostkey}")
 	fi
@@ -482,7 +530,12 @@ _nvme_discover() {
 	local host_traddr="${3:-$def_host_traddr}"
 	local trsvcid="${3:-$def_trsvcid}"
 
-	ARGS=(-t "${trtype}")
+	ARGS=(-t "${trtype}"
+	      --hostnqn="${def_hostnqn}"
+	      --hostid="${def_hostid}")
+	if _nvme_cli_supports_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.41.0

