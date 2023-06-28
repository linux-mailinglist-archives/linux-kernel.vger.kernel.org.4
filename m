Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDE7414B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjF1PQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjF1PQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:16:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED939A1;
        Wed, 28 Jun 2023 08:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88A8F2185C;
        Wed, 28 Jun 2023 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687965385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zv6B/Q4RjEXb57EGS3C2zPEi9FvspmBPaHYAN25eDeI=;
        b=rTdOIKrniP8M0nfVB6GfSGoo97mEymqi5OwLhCzFUnqbeSxTqQLamoMddRALP6vwvQ9305
        Za6BG7YnKYOMcv29J3ndKB4GvyyVlWlYYUsO4vKZqUIl3QNogyqP6dMCulX8NcFZniiMsw
        6rfcmxPvcocd0uivgRUX03b10tSJGLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687965385;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zv6B/Q4RjEXb57EGS3C2zPEi9FvspmBPaHYAN25eDeI=;
        b=Qed9wGMKuxajgT9cX6h+1A1kvviTydJNDv/uHApQnUQTBZ7+nTHSbyvWiYHrVFplzH3O0e
        wRNTMW4OQ5HuGeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B463138E8;
        Wed, 28 Jun 2023 15:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iZwUHslOnGQuOQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 15:16:25 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/3] More fixes for FC enabling
Date:   Wed, 28 Jun 2023 17:16:20 +0200
Message-ID: <20230628151623.11340-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
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

I (think) address all the feedback I got from Sagi and Shinichiro except one.
The _have_nvme_cli_context() (previously _nvme_cli_support_context()) function
is still there. I didn't find any other good way to achieve this and I found in
blktests another function doing the same: _have_fio_zbd_zonemode().

Daniel

changes:
v2:
  - nvme/048:
    - untaggle waiting for state change and queue count check
    - make all variables local
    - compare numbers not strings
  - nvme/rc:
    - rename _nvme_cli_supports_context to _have_nvme_cli_context
    - only add --context for fc
    - reordered setup/cleanup
  - nvme/{041,042,043,044,045,048}:
    - move all changes related to this patch
v1:
  - https://lore.kernel.org/linux-nvme/20230620132703.20648-1-dwagner@suse.de/

Daniel Wagner (3):
  nvme/048: Check for queue count check directly
  nvme/rc: Avoid triggering host nvme-cli autoconnect
  nvme/{041,042,043,044,045,048}: Use default hostnqn and hostid

 tests/nvme/041 |  8 ++---
 tests/nvme/042 |  8 ++---
 tests/nvme/043 |  8 ++---
 tests/nvme/044 |  8 ++---
 tests/nvme/045 |  8 ++---
 tests/nvme/048 | 32 +++++++++++++-------
 tests/nvme/rc  | 81 +++++++++++++++++++++++++++++++++++++++++++-------
 7 files changed, 103 insertions(+), 50 deletions(-)

-- 
2.41.0

