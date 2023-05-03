Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFA6F528C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjECIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:03:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746C1BEB;
        Wed,  3 May 2023 01:03:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8441200AC;
        Wed,  3 May 2023 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6YJe18H1iAIRYoNmcH07vSIQyLGOOyZsOInNYrr5z9A=;
        b=FVbY187ssjjfX7yvlbpc0MWurU6d3iFWBY8+D4c5j07PipzL6G/n2eMFU/AF2KbEDDwr2K
        RjGDn3Fm5YfhJyAsV7uO0WEIysfAxb2dGyLJxAvDGHUODapWM+8rK4pTSuXrzgZrfz9NLz
        03KlUDb7dTY8/n05L93d9YutkeuWmhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6YJe18H1iAIRYoNmcH07vSIQyLGOOyZsOInNYrr5z9A=;
        b=Z8KkrNa5TpoNJNeOp3eMl19mQA4zWMWA3gKVq7WqyOhmOzGHBsEVvyEaSqeV9JTFB7KgaG
        sZNRsvwK6qR9BTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6EDB1331F;
        Wed,  3 May 2023 08:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XFi4KD0VUmQjYgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:09 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 00/12] nvme testsuite runtime optimization
Date:   Wed,  3 May 2023 10:02:46 +0200
Message-Id: <20230503080258.14525-1-dwagner@suse.de>
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

Addessed all the comments I got for v2. If I didn't response to all
comments that just means I silently acked them and updated the series
accordingly. Hopefully I didn't miss anything.

I've changed the defaults back to the previous hard coded defaults. That means
the default image size is 1G and the many iterations count is 1000 (nvme/002
always runs 1000 as this is necessary to actually test the page overflow).

This time I also made sure the nvme pci tests nvme/030... get executed. With the
defaults the loop transport gives

loop:
  real    13m17.778s
  user    0m27.396s
  sys     5m48.958s

and with nvme_img_size=16M nvme_num_iter=10 it gets down to

loop:
  real    6m2.588s
  user    0m13.450s
  sys     1m55.236s

Althought some of the tests get skipped (nvme/012, nvme/013) with such small
test image sizes.

The values for tcp and rdma are similiar

tcp:
  real    8m29.010s
  user    0m14.068s
  sys     2m57.573s

rdma:
  real    8m46.285s
  user    0m13.843s
  sys     2m2.662s

get down to

tcp:
  real    2m18.117s
  user    0m5.928s
  sys     0m42.649s

rdma:
  real    2m5.546s
  user    0m6.474s
  sys     0m37.818s

The fc transport is not passing all tests and hence let's ignore it for now.

Obviously you can also turn the values in the other direction and increase the
tests 'coverage'.

Thanks,
Daniel


changes:
v3:
  - 'nvme/rc' instead of 'nvme-rc' subject prefi	x
  - fixed spaces vs tabs indention
  - nvme/014, nvme/015 dropped -1 in #block calculation
  - common/xfs: use 'tail -1' instead 'awk'
  - common/xfs: no need for printf for integer division
  - nvme/035 limit disk size via nvme_img_size
  - set defaults to previous values: nvme_img_size=1G, nvme_num_iter=1000
  - nvme/032, nvme/040 let fio figure out image size
    set timeout to infinity
    cleanup fio
  - add documentation for nvme_tr_type, nvme_img_size and nvme_num_iter
  - limited nproc to 32 for num jobs for random fio job
  - drop job size limit calculation
  - drop nvme_num_iter from nvme/002
  - limit xfs fio job size inside _xfs_run_fio_verify_io()
  - added reviewed tags

v2:
  - made image size configurable via nvme_img_size env
  - make number of iteration configurable via nvme_num_iter
	- do not hard code test values
  - calculate job size
	- use runtime for fio background jobs
  - https://lore.kernel.org/linux-nvme/20230421060505.10132-1-dwagner@suse.de/

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20230419085643.25714-1-dwagner@suse.de/


Daniel Wagner (12):
  nvme/rc: Auto convert test device size info
  nvme: Do not hard code device size for dd test
  common/xfs: Make size argument optional for _xfs_run_fio_verify_io
  common/xfs: Limit fio size job to fit into xfs fs
  nvme: Use runtime fio background jobs
  Documentation: Add info on nvme_tr_type
  nvme: Make test image size configurable
  nvme/rc: Add minimal test image size requirement
  common/fio: Limit number of random jobs
  nvme/rc: Calculate IO size for random fio jobs
  nvme/rc: Move discovery generation counter code to rc
  nvme: Make the number iterations configurable

 Documentation/running-tests.md |   12 +
 common/fio                     |    3 +-
 common/rc                      |   30 +-
 common/xfs                     |   17 +-
 tests/nvme/002                 |    4 +-
 tests/nvme/002.out             | 3004 --------------------------------
 tests/nvme/004                 |    2 +-
 tests/nvme/005                 |    2 +-
 tests/nvme/006                 |    2 +-
 tests/nvme/007                 |    2 +-
 tests/nvme/008                 |    2 +-
 tests/nvme/009                 |    2 +-
 tests/nvme/010                 |    5 +-
 tests/nvme/011                 |    5 +-
 tests/nvme/012                 |    5 +-
 tests/nvme/013                 |    5 +-
 tests/nvme/014                 |   12 +-
 tests/nvme/015                 |   12 +-
 tests/nvme/016                 |    2 +-
 tests/nvme/017                 |    4 +-
 tests/nvme/018                 |    2 +-
 tests/nvme/019                 |    2 +-
 tests/nvme/020                 |    2 +-
 tests/nvme/021                 |    2 +-
 tests/nvme/022                 |    2 +-
 tests/nvme/023                 |    2 +-
 tests/nvme/024                 |    2 +-
 tests/nvme/025                 |    2 +-
 tests/nvme/026                 |    2 +-
 tests/nvme/027                 |    2 +-
 tests/nvme/028                 |    2 +-
 tests/nvme/029                 |    2 +-
 tests/nvme/030                 |   22 +-
 tests/nvme/031                 |    2 +-
 tests/nvme/032                 |    5 +-
 tests/nvme/034                 |    2 +-
 tests/nvme/035                 |    4 +-
 tests/nvme/040                 |   11 +-
 tests/nvme/041                 |    2 +-
 tests/nvme/042                 |    2 +-
 tests/nvme/043                 |    2 +-
 tests/nvme/044                 |    2 +-
 tests/nvme/045                 |    6 +-
 tests/nvme/047                 |    8 +-
 tests/nvme/048                 |    2 +-
 tests/nvme/rc                  |   40 +
 46 files changed, 185 insertions(+), 3081 deletions(-)

-- 
2.40.0

