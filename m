Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9CC6E9B98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjDTSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDTSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:31:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122030DD;
        Thu, 20 Apr 2023 11:31:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4181FD8C;
        Thu, 20 Apr 2023 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682015484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p7TNLB57J6X+UfMywwYnNOVkSohxa+bcFxW5iBNiQqQ=;
        b=kB8rPenHhzYtL8Wf3Oyd4LNroiCyog4hBhPX1CT3zpidstSzL2PU9WjtkdTtpZL8iOxZCp
        v017WgfrB8h8p3Ln+L9UF9iVH5LE/DV2/ZYetbUKRKx3wmRaWg6DRbeTn566z5DbJ75e5Z
        vCWEnlMC+CYSaTTTDqTuXyUktJaexOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682015484;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p7TNLB57J6X+UfMywwYnNOVkSohxa+bcFxW5iBNiQqQ=;
        b=hV4fYc2G2Z0YUqhvIQrgzEoG7MaUs2DYpHYRbBVmJQCTuM8puy2y7zA0cgm+AkU4Lfah0l
        jkSwo8r+w2qb3mBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C69113584;
        Thu, 20 Apr 2023 18:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vbVsGvyEQWSaNAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:24 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/9] nvme testsuite runtime optimization
Date:   Thu, 20 Apr 2023 20:31:09 +0200
Message-Id: <20230420183121.4489-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
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

Refactored v1 into more smaller bits and fixed a bunch of bugs alongside. For
example the fio jobs size for rand rw used --jobs=$(nproc) which needs to fit
with the test device size.

The loop transport runs a few more test but the largest contributer why it runs
so much longer are the iteratons in 002. So I made them also configurable.

nvme_num_iter=100 nvme_img_size=350M (new defaults)

loop
  real    4m3.524s
  user    0m7.931s
  sys     1m35.871s

rdma
  real    4m20.559s
  user    0m8.895s
  sys     1m5.714s

tcp
  real    3m55.292s
  user    0m8.654s
  sys     1m15.314s

fc
  real    3m18.977s
  user    0m8.868s
  sys     0m58.655s

nvme_num_iter=1000 nvme_img_size=1G (previous/ defaults)

loop
  real    8m22.109s
  user    0m27.582s
  sys     3m0.484s

rdma
  real    9m1.784s
  user    0m14.274s
  sys     2m5.479s

tcp
  real    8m28.443s
  user    0m13.952s
  sys     2m55.544s

fc
  real    6m24.426s
  user    0m13.944s
  sys     2m2.489s

The fc tests are bit faster because some of them are failing.

changes:
v2:
  - made image size configurable via nvme_img_size env
  - make number of iteration configurable via nvme_num_iter
	- do not hard code test values
  - calculate job size
	- use runtime for fio background jobs

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20230419085643.25714-1-dwagner@suse.de/

Daniel Wagner (9):
  nvme-rc: Auto convert test device size info
  nvme: Do not hard code device size for dd test
  common-xfs: Make size argument optional for _xfs_run_fio_verify_io
  nvme: Use runtime fio background jobs
  nvme: Make test image size configurable
  nvme-rc: Add minimal test image size requirement
  nvme-rc: Calculate IO size for fio jobs
  nvme-rc: Move discovery generation counter code to rc
  nvme: Make the number iterations configurable

 common/rc          |   30 +-
 common/xfs         |    6 +
 tests/nvme/002     |    6 +-
 tests/nvme/002.out | 3004 --------------------------------------------
 tests/nvme/004     |    2 +-
 tests/nvme/005     |    2 +-
 tests/nvme/006     |    2 +-
 tests/nvme/007     |    2 +-
 tests/nvme/008     |    2 +-
 tests/nvme/009     |    2 +-
 tests/nvme/010     |    6 +-
 tests/nvme/011     |    6 +-
 tests/nvme/012     |    5 +-
 tests/nvme/013     |    5 +-
 tests/nvme/014     |   12 +-
 tests/nvme/015     |   12 +-
 tests/nvme/016     |    2 +-
 tests/nvme/017     |    4 +-
 tests/nvme/018     |    2 +-
 tests/nvme/019     |    2 +-
 tests/nvme/020     |    2 +-
 tests/nvme/021     |    2 +-
 tests/nvme/022     |    2 +-
 tests/nvme/023     |    2 +-
 tests/nvme/024     |    2 +-
 tests/nvme/025     |    2 +-
 tests/nvme/026     |    2 +-
 tests/nvme/027     |    2 +-
 tests/nvme/028     |    2 +-
 tests/nvme/029     |    2 +-
 tests/nvme/030     |   22 +-
 tests/nvme/031     |    2 +-
 tests/nvme/032     |    6 +-
 tests/nvme/034     |    4 +-
 tests/nvme/035     |    4 +-
 tests/nvme/040     |    9 +-
 tests/nvme/041     |    2 +-
 tests/nvme/042     |    2 +-
 tests/nvme/043     |    2 +-
 tests/nvme/044     |    2 +-
 tests/nvme/045     |    6 +-
 tests/nvme/047     |    8 +-
 tests/nvme/048     |    2 +-
 tests/nvme/rc      |   50 +
 44 files changed, 176 insertions(+), 3079 deletions(-)

-- 
2.40.0

