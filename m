Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8642664EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAJW1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjAJW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:27:23 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97D1001;
        Tue, 10 Jan 2023 14:27:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e10so9241144pgc.9;
        Tue, 10 Jan 2023 14:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VB24opVLQI6VW8G8oZfy8uXJs5IC1RhDeqkeodkQkAc=;
        b=hwicu8soi/8gvcUAsRSJHQvCHEXv+hDQ5G5ZAB/xac7LActHdMXaQJhcyByKNzUMOz
         ixPjQ5htdNTlOljksjENeWOj5599HXJH4SaUmvCp2P4L3nFYutdqkKE7IE9NOhIcQgQV
         cKm85ayMmWp457jv+jk5NNy5fyRrA7WinrxSCtT0TVZTpEAnHACGJFAyCzm8AnvCsaFJ
         TiScEN1qASQppJxHnGpRo9ktwYuVmMVigvuZ5KWg1JwMjve/li1XOVQtNPeJ/wQyUCLJ
         BaLhslWYt6IFXXTnF/FRr7wv5BD7mM0SK6rr9mI8f+cwZ1J6mnmwdILt5UPVOnjhFkRw
         k0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB24opVLQI6VW8G8oZfy8uXJs5IC1RhDeqkeodkQkAc=;
        b=Mcuj0dp4iL51FAKnNRZnQmdC4Z7COHh+O2bV/3gfjj8COcXCVdGjZU44qyjgB1IFj0
         MyH+vU4rFPw1FA3gMzd4cwZCNmYdKPHFh9onOG9j8KwfFTXlN81zXAAd5dWNCfpL1Sjw
         HzdiZUtsbldno6l02mX2fDY/hgQrkEyhUXoUMBDqJws7oudVaBxaTdNnK0JduPnDjC/H
         jPTv54ZhXQM1Wx8oSiItZGNXC3hC2Vwq65KzIGYuGF4EzQkg5FmTHf4APywXtV+LYKWv
         XYjPOadYxEP7WBQyPSFQZz/eMNXVi1LrOWLQ/nFbnQJ015nw9uyNsFRkjVy2fZbQrpEs
         RCrg==
X-Gm-Message-State: AFqh2kpw66m1egqQFeh2nre5FyAmUJKp9peX+mqH28Gshc8f4Ndb+E62
        02DXsUqWC8xNl/nO3D9dV4VBoAtnRQ0=
X-Google-Smtp-Source: AMrXdXv8OBc2bwWWv/MRNeh6iOU9dEv/6MXsfdBDOlMp0hcNcZejdh7PzH7WmH5/HSaW9LTtvuuwBQ==
X-Received: by 2002:aa7:8d86:0:b0:580:c796:d68f with SMTP id i6-20020aa78d86000000b00580c796d68fmr77158pfr.24.1673389641436;
        Tue, 10 Jan 2023 14:27:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x1-20020aa78f01000000b005882b189a44sm5092754pfr.104.2023.01.10.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:27:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 block/for-next] blkcg: Improve blkg config helpers and make iolatency init lazy
Date:   Tue, 10 Jan 2023 12:27:10 -1000
Message-Id: <20230110222714.552241-1-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

* v2[2] fixes the build failure caused by v1[1] forgetting to update bfq.

* v3 drops __acuquires/__releases() changes and updates patch descriptions.

This patchset:

* Improves blkg config helpers so that they can be used consistently for all
  the existing use cases. This also allows keeps using the same bdev open
  instance across lazy init of rq_qos policies.

* Updates iolatency so that it initializes lazily when a latency target is
  set for the first time. This avoids registering the rq_qos policy when
  iolatency is not used which removes unnecessary calls into iolat from IO
  hot paths.

and contains the following four patches:

 0001-blkcg-Drop-unnecessary-RCU-read-un-locks-from-blkg_c.patch
 0002-blkcg-Restructure-blkg_conf_prep-and-friends.patch
 0003-blk-iolatency-s-blkcg_rq_qos-iolat_rq_qos.patch
 0004-blk-iolatency-Make-initialization-lazy.patch

and is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git iolat-lazy-init-v2

diffstat follows. Thanks.

 block/bfq-cgroup.c    |    8 ++-
 block/blk-cgroup.c    |  122 ++++++++++++++++++++++++++++----------------------
 block/blk-cgroup.h    |   10 ++--
 block/blk-iocost.c    |   58 +++++++++++++----------
 block/blk-iolatency.c |   39 +++++++++++++--
 block/blk-rq-qos.h    |    2 
 block/blk-throttle.c  |   16 ++++--
 block/blk.h           |    6 --
 8 files changed, 159 insertions(+), 102 deletions(-)

[1] https://lkml.kernel.org/r/20230105002007.157497-1-tj@kernel.org
[2] https://lkml.kernel.org/r/20230105212432.289569-1-tj@kernel.org

--
tejun

