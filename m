Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0F6F529B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjECIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjECIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB37E74;
        Wed,  3 May 2023 01:03:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24D9D2233B;
        Wed,  3 May 2023 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
        b=bqoL0PAsnBVoBT+vIpTrr9Jset9nzF3lrBJXsVMbuSoNhTG2zu6/wtaluV7O2LU2DutVGG
        Z9v54fs4JRFGFQmHGwyaMDvWYnvoTpU5kBfvkFUgS/BKHxPUb6Z0o4PS8oW1YWJFBDe3hx
        TM2dAwYZQVVesKKsft+iGmk7pS+MWxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
        b=8KqA9O/ZNgmjUTpiONgED2mK5EzNsj5MZmjAK3nxMQFj4gGQ9Hl/a/HixnskEhFE4P+HAW
        63To15r+HFiOQ7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1696A1331F;
        Wed,  3 May 2023 08:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8VA0BUAVUmQzYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:12 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 04/12] common/xfs: Limit fio size job to fit into xfs fs
Date:   Wed,  3 May 2023 10:02:50 +0200
Message-Id: <20230503080258.14525-5-dwagner@suse.de>
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

The usable capacity of the filesystem is less than the raw
partition/device size due to the additional meta/log data.

Ensure that the job size for fio is not exceeding the limits.

Because we have hard coded the path where we mount the filesystem
and don't want to expose this, we just update max size inside
_xfs_run_fio_verify_io(). No need to leak this into the caller.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/xfs b/common/xfs
index 413c2820ffaf..37ce85878df2 100644
--- a/common/xfs
+++ b/common/xfs
@@ -37,6 +37,9 @@ _xfs_run_fio_verify_io() {
 		sz_mb="${avail_mb}"
 	else
 		sz_mb="$(convert_to_mb "${sz}")"
+		if [[ "${sz_mb}" -gt "${avail_mb}" ]]; then
+			sz_mb="${avail_mb}"
+		fi
 	fi
 
 	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
-- 
2.40.0

