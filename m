Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032F7414B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjF1PQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:16:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51912 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjF1PQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:16:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C95C321861;
        Wed, 28 Jun 2023 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687965386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJc1MzgYT11bWjhAZk5pZTZ+qKRLUqhEZojvJZGv2AQ=;
        b=cXjxD4w65dW3uVVIZr7GmkGskiTpPMT5ApChVNhj+US7nfGN9oBG3f/DHbXhb04g+3BUBK
        jeLQHxQPxDaJLnumI2IJJptdFNTVQWrN52Ulvd9SLlK7t5DrpYXidcXwbDZ/cITYWexTse
        gv1/R1K6iLgOLMpDUEhUtZsTWzAmr90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687965386;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WJc1MzgYT11bWjhAZk5pZTZ+qKRLUqhEZojvJZGv2AQ=;
        b=t7qZ1tqmWmifP1TDgCoXPm5UKbU7Ezdi+aE9yh3Jwboh1P/7NokCRUGk7SosrXNmhEDeJd
        M7Fl60ptXX73+rBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA696138E8;
        Wed, 28 Jun 2023 15:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vNpFLcpOnGQzOQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 15:16:26 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/3] nvme/rc: Avoid triggering host nvme-cli autoconnect
Date:   Wed, 28 Jun 2023 17:16:22 +0200
Message-ID: <20230628151623.11340-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628151623.11340-1-dwagner@suse.de>
References: <20230628151623.11340-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the host has enabled the udev/systemd autoconnect services for the
fc transport it interacts with blktests and make tests break.

nvme-cli learned to ignore connects attemps when using the --context
command line option paired with a volatile configuration. Thus we can
mark all the resources created by blktests and avoid any interaction
with the systemd autoconnect scripts.

Only enabled this for the fc transport.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 81 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2e0c43..06d98f46b471 100644
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
@@ -161,6 +161,57 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
+_have_nvme_cli_context() {
+	# ignore all non-fc transports
+	if [[ "${nvme_trtype}" == "fc" ]] ||
+	   ! nvme connect --help 2>&1 | grep -q -- '--context=<STR>' > /dev/null; then
+		    return 1
+	fi
+	return 0
+}
+
+_setup_nvme_cli() {
+	local local_wwnn="${1}"
+	local local_wwpn="${2}"
+	local remote_wwnn="${3}"
+	local remote_wwpn="${4}"
+
+	if ! _have_nvme_cli_context; then
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
+	            "traddr": "nn-${remote_wwnn}:pn-${remote_wwpn}",
+	            "host_traddr": "nn-${local_wwnn}:pn-${local_wwpn}"
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
+	if ! _have_nvme_cli_context; then
+		return
+	fi
+
+	rm -f /run/nvme/blktests.json
+}
+
 _nvme_fcloop_add_rport() {
 	local local_wwnn="$1"
 	local local_wwpn="$2"
@@ -193,6 +244,9 @@ _setup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
+	_setup_nvme_cli "${local_wwnn}" "${local_wwpn}" \
+			"${remote_wwnn}" "${remote_wwpn}"
+
 	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
@@ -235,6 +289,8 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
+
+	_cleanup_nvme_cli
 }
 
 _cleanup_nvmet() {
@@ -436,18 +492,18 @@ _nvme_connect_subsys() {
 	trtype="$1"
 	subsysnqn="$2"
 
-	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	ARGS=(-t "${trtype}"
+	      -n "${subsysnqn}"
+	      --hostnqn="${hostnqn}"
+	      --hostid="${hostid}")
+	if _have_nvme_cli_context; then
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
@@ -482,7 +538,12 @@ _nvme_discover() {
 	local host_traddr="${3:-$def_host_traddr}"
 	local trsvcid="${3:-$def_trsvcid}"
 
-	ARGS=(-t "${trtype}")
+	ARGS=(-t "${trtype}"
+	      --hostnqn="${def_hostnqn}"
+	      --hostid="${def_hostid}")
+	if _have_nvme_cli_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.41.0

