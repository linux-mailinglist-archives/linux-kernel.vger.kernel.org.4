Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612CC65F5AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjAEVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbjAEVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:24:40 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C36319A;
        Thu,  5 Jan 2023 13:24:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k19so18606040pfg.11;
        Thu, 05 Jan 2023 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m4p393MWB7Oqj56DlLo7/CNa0wXky/kq19Hx63x8OIY=;
        b=giUbr3pUIc8jRWD6RjxTY6287ijomf3pG85WCAw9dujJo9kwTWK17AqM0tgrbKxtlv
         hl07TQgV9qzPMx/lNE0CNlAqTU5h9yglwiMXcLwYbQ4cE8WhZxnZZ5WNlW/76FfYIVCq
         bJ7grOVyCed32kgehj8cF8QaYwotuLAjeXHnCAaQdVlpnwthgJCFyuYnTMxYOydZkhiu
         7rr/41mchOWM2PDXKDoZu5Bqex2sAyTMGhuh98BQR8Q/J6ex41LhM/WyNQGTqZoI2Aqg
         sha9ZEl2kSjIWSLMG2yhcrFPaNcjKrTs269mL1kmmqV/aLpcoXOoPnd7fRrdg6NewgXM
         vm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4p393MWB7Oqj56DlLo7/CNa0wXky/kq19Hx63x8OIY=;
        b=8FQds3Ue+tXuQMTyErJyCA3AeDP9HFtotp+9LSVKx4dp9Bq3hnOKE0gocfpbIS2SJX
         /BFkU2CGvaGG5YoN1kozw1Wgz1uEpSQe/+ujF/+addTUkv+R0jrG1pkg92i6al1OH2KP
         SnHebD0E4bCx8KfLvN7pt6a/KdBYPWj2rN1Uxu/K5TxB5UfJn5c3E8u/xWo3BNWt59Ni
         tvZqhmV7zXkckoZcPUzwms+eCiDgpP5D05R+MIjcxTpUbnydX/cWeiy82xZG95en2PBj
         GE+B0EMmmhRzeCqSMqlB7QoIDJYdAiAf13pm5ejp/iFRxp016KLc3wvkamoHCB2mXyqY
         Y3VA==
X-Gm-Message-State: AFqh2krEAemA+fMHeFI3DX2Z12X+bBQAN1ug5omVyrm5c8CUFCYVd/BC
        ywO+696hVF5vZSpuu+zB1sU=
X-Google-Smtp-Source: AMrXdXs8IJzjDnJVpKYPolCSwM4/h+iYaLqJoM8lk6eA58DtyS7ZIQrPA9L979WEyL5WAhq4EUXs/A==
X-Received: by 2002:a62:5801:0:b0:574:a541:574a with SMTP id m1-20020a625801000000b00574a541574amr50022955pfb.0.1672953879176;
        Thu, 05 Jan 2023 13:24:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f186-20020a6251c3000000b0056c3a0dc65fsm25034563pfb.71.2023.01.05.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:24:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 block/for-next] blkcg: Improve blkg config helpers and make iolatency init lazy
Date:   Thu,  5 Jan 2023 11:24:28 -1000
Message-Id: <20230105212432.289569-1-tj@kernel.org>
X-Mailer: git-send-email 2.39.0
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

v2 fixes the build failure caused by v1[1] forgetting to update bfq.

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

 block/bfq-cgroup.c    |    8 +++--
 block/blk-cgroup.c    |  120 ++++++++++++++++++++++++++++++++++++++++++----------------------------------
 block/blk-cgroup.h    |   10 +++---
 block/blk-iocost.c    |   58 +++++++++++++++++++++---------------
 block/blk-iolatency.c |   39 +++++++++++++++++++++---
 block/blk-rq-qos.h    |    2 -
 block/blk-throttle.c  |   16 ++++++----
 block/blk.h           |    6 ---
 8 files changed, 157 insertions(+), 102 deletions(-)

[1] https://lkml.kernel.org/r/20230105002007.157497-1-tj@kernel.org

--
tejun



