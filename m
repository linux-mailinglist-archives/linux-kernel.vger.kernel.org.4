Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D76E6E75C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjDSI45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjDSI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:56:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4E4220;
        Wed, 19 Apr 2023 01:56:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15235218E9;
        Wed, 19 Apr 2023 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681894606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YGRx0VhssWGJmCamZm968ZBOnZT7J4WEtWI7lTv5X2o=;
        b=Sd6IwJjckufw078HuJfh4vwPeCiCz8HEBBW2CY4kcso57ZbSSDNDo3AJn5clFge3dFtsnF
        LmWtilBZ/tH3odXDa7eAMliBIIp/0eICiWzSMcJm4IHC0yvPVCFnrES50xLjf6RTKhAj8B
        i0LQ8nDidW9Qfctui/ZS9khLuvA6J0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681894606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YGRx0VhssWGJmCamZm968ZBOnZT7J4WEtWI7lTv5X2o=;
        b=tql449MYMu4a1UAQD1IhwaezuR6G/wP+RyHqPgY6j0dkMDtmDVS26at+vRSowxFBsq91uG
        O5SumSHT+m6U8HCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 058DF1390E;
        Wed, 19 Apr 2023 08:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PHRKAc6sP2RiegAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 08:56:46 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 0/1] nvme testsuite runtime optimization
Date:   Wed, 19 Apr 2023 10:56:42 +0200
Message-Id: <20230419085643.25714-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
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

While testing the fc transport I got a bit tired of wait for the I/O jobs to
finish. Thus here some runtime optimization.

With a small/slow VM I got following values:

with 'optimizations'
  loop:
    real    4m43.981s
    user    0m17.754s
    sys     2m6.249s

  rdma:
    real    2m35.160s
    user    0m6.264s
    sys     0m56.230s

  tcp:
    real    2m30.391s
    user    0m5.770s
    sys     0m46.007s

  fc:
    real    2m19.738s
    user    0m6.012s
    sys     0m42.201s

base:
  loop:
    real    7m35.061s
    user    0m23.493s
    sys     2m54.866s

  rdma:
    real    8m29.347s
    user    0m13.078s
    sys     1m53.158s

  tcp:
    real    8m11.357s
    user    0m13.033s
    sys     2m43.156s

  fc:
    real    5m46.615s
    user    0m12.819s
    sys     1m46.338s

Daniel Wagner (1):
  nvme: Limit runtime for verification and limit test image size

 common/xfs     |  3 ++-
 tests/nvme/004 |  2 +-
 tests/nvme/005 |  2 +-
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  2 +-
 tests/nvme/009 |  2 +-
 tests/nvme/010 |  5 +++--
 tests/nvme/011 |  5 +++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 | 10 ++++++++--
 tests/nvme/015 | 10 ++++++++--
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  2 +-
 tests/nvme/019 |  2 +-
 tests/nvme/020 |  2 +-
 tests/nvme/021 |  2 +-
 tests/nvme/022 |  2 +-
 tests/nvme/023 |  2 +-
 tests/nvme/024 |  2 +-
 tests/nvme/025 |  2 +-
 tests/nvme/026 |  2 +-
 tests/nvme/027 |  2 +-
 tests/nvme/028 |  2 +-
 tests/nvme/029 |  2 +-
 tests/nvme/031 |  2 +-
 tests/nvme/032 |  4 ++--
 tests/nvme/034 |  3 ++-
 tests/nvme/035 |  4 ++--
 tests/nvme/040 |  4 ++--
 tests/nvme/041 |  2 +-
 tests/nvme/042 |  2 +-
 tests/nvme/043 |  2 +-
 tests/nvme/044 |  2 +-
 tests/nvme/045 |  2 +-
 tests/nvme/047 |  2 +-
 tests/nvme/048 |  2 +-
 38 files changed, 63 insertions(+), 47 deletions(-)

-- 
2.40.0

