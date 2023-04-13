Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CFA6E02FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDMAG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMAG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:06:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213BE5599;
        Wed, 12 Apr 2023 17:06:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i8so4241607plt.10;
        Wed, 12 Apr 2023 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681344415; x=1683936415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uW6vU7xQLZdXTM+N0W2uZdj4wLLbZ0pkWxeLicfHFn4=;
        b=gnysKRSLEIcDhi/vRIbU4FfivKL9YySdh6NpSVNnjQYEXAAC5Vx2EQNU+cw0HR3J0D
         ojzZbNy+0gTam02R5x/0AtiJkfnwAhAIvjQ4jfoIWF+j4tHLHDgtJCoLwKhnyperCjY8
         qxf7MIIeyx1W5Hz4yBCAtjmXghfZmYrkLIhErCzMVSC7EePeN/adeyWZYUWd4iSBLj8U
         wIV4sInnRSkpxHMcyU4Bs0BzsJkR83RudottRyQTd0hr7sFibp9f+5TFvxQ3m5bQAxvP
         2WnE9MxdqbC1MQVZY1foWyOKQaIewe5PR/QQt+AuJEdpPj9DMJJtNMGsfuZGP4WcdJyK
         bo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344415; x=1683936415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW6vU7xQLZdXTM+N0W2uZdj4wLLbZ0pkWxeLicfHFn4=;
        b=k6wgpBK4GF3UbB9Q+FgzmJHPOGJpwwVPiUhy+gYPvYa465MgHh/fgGpiKp2BZGHwOQ
         4YjjByiJWC5Tkci5yO4MeZTomaKHaaXkgfGBNMYB/Id6mIRpApZefIktF2V3c0LCAjWZ
         MHPDnl/IHGpnHDRnMABnNl96JokMqUKzOzeE47zeOL0IjB/1CMASvZuA1J6ZhftqDGbI
         u9GPtbA29ko0ikOy5s1e9btHFetRFcV6aaJ2to5zjp5vPxrAQdvjQCZrlFGaiE3e3vgB
         DSd9ONL2lilHKtNzJndDhBN9HxZpPivh/PrMuwGbChCIKAfbD2sloX7BYTwNzcmwl/EY
         AraA==
X-Gm-Message-State: AAQBX9d5060Zz17iyIdg/YDLuaRziqRnjD/xDGhABa7KBzCq/x8wf2L2
        H4V8y0W8opjm04+SoRINdbaK65o3LTQ=
X-Google-Smtp-Source: AKy350a57dN2inXLLXfBg9c5YPLvhJvu+WQYcXcMo4K3CA8FTdvQH4unXz0sy9KZcD99u7nqDWBSLA==
X-Received: by 2002:a17:90b:4c8e:b0:231:24c1:8028 with SMTP id my14-20020a17090b4c8e00b0023124c18028mr11721732pjb.29.1681344415422;
        Wed, 12 Apr 2023 17:06:55 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090ad30500b00246f856d678sm136599pju.1.2023.04.12.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:06:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
Subject: [PATCHSET v4 block/for-next] blkcg: Improve blkg config helpers and make iolatency init lazy
Date:   Wed, 12 Apr 2023 14:06:45 -1000
Message-Id: <20230413000649.115785-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

* v3[3] drops __acuquires/__releases() changes and updates patch descriptions.

* v4 rebases on top of the current block/for-next.

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

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git iolat-lazy-init-v4

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
[3] https://lkml.kernel.org/r/20230110222714.552241-1-tj@kernel.org

