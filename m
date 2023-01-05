Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF83A65E16E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjAEAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAEAUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:20:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78261D0CB;
        Wed,  4 Jan 2023 16:20:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w203so7542216pfc.12;
        Wed, 04 Jan 2023 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8HGYh4uvWX6khV9cMo5O6XnraOEnVQvZkHWgtr4zshY=;
        b=mAMyC1Zedw/SVH8CBbI8/Bh/R/ayqOA8HXQCzlmmlSIIOwoS5mHiCDBawPxT4SEbh1
         +lDjjKLqUecLpp9AXe0Mex6YM3CGSVQIjETZo9553G6BoTVoO9RIBUHWA/P0snroa0R5
         3s/RNHxi6z22X18i1yLpGO4m+aLioV8eUKpt3TxLktpgISlPMDhWhv0hH8BZ00ggjtub
         ttgz9gkqA5pUL7DJ27wH4rXoBFEal/nDABT8cqpklsbhNMbWlQ566hwk6zCfYkB33Mpr
         46gwmOxnZSIYdtiInuw0TvZoaLJ/E8b/H0nvYhrkwrF6UZXX6SNyfMJjKMpBe4Pf9Bsn
         f3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HGYh4uvWX6khV9cMo5O6XnraOEnVQvZkHWgtr4zshY=;
        b=L3Sqf+wMEYAXSdv2HMocy1SfMxWVEVZQTIqDUp+jxhNxVPABw2zfeEbncRR3K6GXr8
         Ok7TbpWZirOpc3VfDbplKKuxUf/uaHI8IRQXYfUgsXhZCjp1zhlAGRafMBz5xM5wiYTe
         E6Sowjo14Ds9tlg4HbESV0TairC36rNJCXjH7jCWLHTsWw8xwouTow0Vpq2+EXKmWhwv
         KP8ns6PddEbhmfcA4+QFRW/OorlJP3DnS/fqW3xAXfEY2V5+R3PlmqVeSJwBhED7YQOW
         07Pf88hVbmeTEsllfFTjne9I1j1NE3ZryoB2fmoRBqCzd59q+194e211wm3WjM0LWweJ
         rXRQ==
X-Gm-Message-State: AFqh2krzU53/4vr5GY4JBVqHl4BGAbyTkyCkspyFqr7rqi1WsotDLVzE
        z5xGqVouU6AnNESbpseay+e65/Pbm+0=
X-Google-Smtp-Source: AMrXdXvG031p3vb0bU8kfmasYwfg27oYIIveXBcmlOkqNfFM/NQo/J2LSZXVcZpPITF1JI+KidIOUw==
X-Received: by 2002:a05:6a00:27a0:b0:57f:cf88:edf5 with SMTP id bd32-20020a056a0027a000b0057fcf88edf5mr65805887pfb.24.1672878012266;
        Wed, 04 Jan 2023 16:20:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7998a000000b00582197fa7b4sm9443486pfh.7.2023.01.04.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:20:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHSET block/for-next] blkcg: Improve blkg config helpers and make iolatency init lazy
Date:   Wed,  4 Jan 2023 14:20:03 -1000
Message-Id: <20230105002007.157497-1-tj@kernel.org>
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

* Improve blkg config helpers so that they can be used consistently for all
  the existing use cases. This also allows keeps using the same bdev open
  instance across lazy init of rq_qos policies.

* Update iolatency so that it initializes lazily when a latency target is
  set for the first time. This avoids registering the rq_qos policy when
  iolatency is not used which removes unnecessary calls into iolat from IO
  hot paths.

This patchset contains the following four patches:

 0001-blkcg-Drop-unnecessary-RCU-read-un-locks-from-blkg_c.patch
 0002-blkcg-Restructure-blkg_conf_prep-and-friends.patch
 0003-blk-iolatency-s-blkcg_rq_qos-iolat_rq_qos.patch
 0004-blk-iolatency-Make-initialization-lazy.patch

and is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git iolat-lazy-init

diffstat follows. Thanks.

 block/blk-cgroup.c    |  120 +++++++++++++++++++++++++++-----------------------
 block/blk-cgroup.h    |   10 ++--
 block/blk-iocost.c    |   58 ++++++++++++++----------
 block/blk-iolatency.c |   39 ++++++++++++++--
 block/blk-rq-qos.h    |    2 
 block/blk-throttle.c  |   16 ++++--
 block/blk.h           |    6 --
 7 files changed, 152 insertions(+), 99 deletions(-)

--
tejun

