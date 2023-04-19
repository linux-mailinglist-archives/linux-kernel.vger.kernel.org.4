Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C436E75A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjDSIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjDSIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:48:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F29E1A4;
        Wed, 19 Apr 2023 01:48:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 203E321908;
        Wed, 19 Apr 2023 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681894083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEnZ644JL7BzqvU0sxbGAoBWYjk3iv5CXkJiuBwPN/c=;
        b=M8tPaWGNuTcM0+4I5u+VLunpNCH8/cK5wAYTEPICSez2IJ173pcGHxIEgnWuXF/lZE2ZIS
        3TyNEuKQ+TzkG6vjv5A5Gn/d+vsINCs4VC6Y8mnBxfCoUfRq5wOewasrdEfwpvrVCeBe+V
        FJMcsL7No4pmM/LALJEENsiuc1prKSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681894083;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEnZ644JL7BzqvU0sxbGAoBWYjk3iv5CXkJiuBwPN/c=;
        b=FHGWW/rllpupFShePGQj1O4dUlE0IMPgumOX32O9iG61oeSYDLecrcR+QYrvAf3mtcmTuO
        HF8gZr+O13sZBjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 118961390E;
        Wed, 19 Apr 2023 08:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yasgBMOqP2S7dQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:48:03 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before module unloading
Date:   Wed, 19 Apr 2023 10:47:57 +0200
Message-Id: <20230419084757.24846-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419084757.24846-1-dwagner@suse.de>
References: <20230419084757.24846-1-dwagner@suse.de>
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

Before we unload the module we should cleanup the fc resources first,
basically reorder the shutdown sequence to be in reverse order of the
setup path.

Also unload the nvme-fcloop after usage.

While at it also update the rdma stop_soft_rdma before the module
unloading for the same reasoning.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec0cc2d8d8cc..41f196b037d6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -260,18 +260,20 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
-	fi
-	modprobe -rq nvmet 2>/dev/null
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
 	if [[ "${nvme_trtype}" == "fc" ]]; then
 		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
 			        "${def_remote_wwnn}" "${def_remote_wwpn}"
+		modprobe -rq nvme-fcloop
 	fi
+
+	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
+	fi
+	modprobe -rq nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
-- 
2.40.0

