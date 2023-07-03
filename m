Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2367074582F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGCJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGCJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:16:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF7612E;
        Mon,  3 Jul 2023 02:16:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6AB51FD75;
        Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688375815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+8YBrUpE2qb6+lv32u7UaAshwQ/NzzYaAEBiSNLejw=;
        b=aJmI21XoZATqMcxjej/15bKMZYrd+hA/+VsblssIvVvsNxnaHbEuh69tJAbB3DukWKT0tT
        HZ8blHsP1mKB8H06vSWCONF0DI+Wm5BTluLIB0ww4qUG/cvqOvbp2+aUTvOhWKu+U3RDFZ
        squn7W+cBtbkXqTAk4EqLQ3IN7GAjus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688375815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+8YBrUpE2qb6+lv32u7UaAshwQ/NzzYaAEBiSNLejw=;
        b=EFyh0LmGkHJ0/iuIO0GzOGCahFA9hXk1xaPJe68n7OeLUpLX8Cvr/9t0Iuarq2VSnhdoST
        6urwYVCwcpLUeiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9CA613276;
        Mon,  3 Jul 2023 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kRBAMQeSomSLDgAAMHmgww
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
Subject: [PATCH blktests v3 2/3] nvme/rc: Avoid triggering host nvme-cli autoconnect
Date:   Mon,  3 Jul 2023 11:16:46 +0200
Message-ID: <20230703091647.800-3-dwagner@suse.de>
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

When the host has enabled the udev/systemd autoconnect services for the
fc transport it interacts with blktests and make tests break.

nvme-cli learned to ignore connects attemps when using the --context
command line option paired with a volatile configuration. Thus we can
mark all the resources created by blktests and avoid any interaction
with the systemd autoconnect scripts.

Only enabled this for the fc transport.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c2c2fab62c1..9b5442b2c07b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -176,6 +176,57 @@ _nvme_calc_rand_io_size() {
 	echo "${io_size_kb}k"
 }
 
+_have_nvme_cli_context() {
+	# ignore all non-fc transports for now
+	if [[ "${nvme_trtype}" != "fc" ]] ||
+	   ! nvme connect --help 2>&1 | grep -q -- '--context=<STR>' > /dev/null; then
+		return 1
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
@@ -208,6 +259,9 @@ _setup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
+	_setup_nvme_cli "${local_wwnn}" "${local_wwpn}" \
+			"${remote_wwnn}" "${remote_wwpn}"
+
 	_nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
@@ -250,6 +304,8 @@ _cleanup_fcloop() {
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
 	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
 			       "${remote_wwnn}" "${remote_wwpn}"
+
+	_cleanup_nvme_cli
 }
 
 _cleanup_nvmet() {
@@ -452,6 +508,9 @@ _nvme_connect_subsys() {
 	subsysnqn="$2"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if _have_nvme_cli_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" == "fc" ]] ; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
@@ -496,6 +555,9 @@ _nvme_discover() {
 	ARGS=(-t "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
+	if _have_nvme_cli_context; then
+		ARGS+=(--context="blktests")
+	fi
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.41.0

