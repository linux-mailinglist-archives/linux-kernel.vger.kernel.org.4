Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB24D6FF3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbjEKOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjEKOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:10:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E39558B;
        Thu, 11 May 2023 07:10:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 653321FEFE;
        Thu, 11 May 2023 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683814207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
        b=dM/I2q/UQK2R07M7bunrP2cK3vtkIrs3oRdNXboTpYtETDyKfFgXL8EWz+ewSS4++IGBXL
        0/8urNH58ilhIB1tMKcWoHES04VrZEGp6Xb7Fmg+Y03kJzDA2jzPsZUJi41gDaKW4cj+A/
        amtCufaH8rrMzg6geF7AWM/DFWqXgNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683814207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blxJG8cSb9nAOdVRY3eSjODYe9Zj/GUTrxASYKRPMLY=;
        b=5bHvKi+hhm7I9XfJQuEYd+NonkyMvnbkfieEJaqHqajxVhwsQXH8Pq6tyb1jziOf6WUxsf
        9pwSIGxPcqUirdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15AB4134B2;
        Thu, 11 May 2023 14:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kVEqOD73XGRmPwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:06 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 04/11] common/xfs: Limit fio size job to fit into xfs fs
Date:   Thu, 11 May 2023 16:09:46 +0200
Message-Id: <20230511140953.17609-5-dwagner@suse.de>
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

