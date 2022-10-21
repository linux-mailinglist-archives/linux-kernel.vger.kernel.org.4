Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EF60710D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJUHas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJUHao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:30:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF923B704;
        Fri, 21 Oct 2022 00:30:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h13so1823674pfr.7;
        Fri, 21 Oct 2022 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWybCkNqc7BOIlhGtPQ8GIKC3VKRfzSYLOuETquJ7MQ=;
        b=U0yBPLAdkBv+Vxw5j7hfc4m2f/ZQWy2xecE2yMlGvLa4lkwPKKJQEZJkHKLDtlyCsq
         n+lNpkOANQPYyfjPPw/Anx7BbZE/dhzIUJqRXy3EEVYkby7CPDAoYvnL8ogyUA2BxWVN
         tUXY3jxFwjeNhJtWImPNrYXX/BqxHdov6WtUe7WbySC1VYf1xhm7/aVYU4zsc+GhNB1P
         LYfMF2uXYKsm91HF0y0/0UB43gZHzXmAAD7Kk0nh1DpPmmerC2ieIyK0WYZAdIVH/kZ4
         ZNlPmOvkZCO62SVP95oWUFIUSSFKgjRLwOM0+VQc9rC8u1f638WqiM9DHoBu+U/E78VI
         MVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWybCkNqc7BOIlhGtPQ8GIKC3VKRfzSYLOuETquJ7MQ=;
        b=iHDySUZ662l62dDa5pL9J82Clx+XEaR5F/RGYlbcZ+18deRTCaUIEpb1omjmyC65IK
         bIbuA6R9LPgbsn22ZCfNHpQP3AKfXtmb5pvJlcTcuKe1Ky7ecMOP2sk/38rHKh0UvSqm
         FlDgLm+iDDxg67kMzyEavDmrdWjyqHYO+121+fWO4sRFnk9TbgI4zwM7JP+InJRyNhhl
         3CSoF3i0pICuGW1TtHK1dhNthIWozRIv6XeXrq9Y9m74aUp4DLT5p3czofSe2l7W+r86
         /uoxbl04HjULuHH3rcLitvr7URpWwCvrlPhMYU1er0/L/oGTub6Jt9hW/1adwLN/a7z/
         O4ew==
X-Gm-Message-State: ACrzQf1reopul9mKuj2mSv9ikueDRhX789p/KIU+tJHG/uNAFg9IZE+q
        uEto9zQxNZqe2w4dS1xMVNw=
X-Google-Smtp-Source: AMsMyM73G6Q2SaNJoUiHw2hoARKPg/E1k+q3CQV5u3vkvt14y1Kou7aj21uKkgoNRUNckiglMVdw4w==
X-Received: by 2002:a05:6a00:4396:b0:563:6fd7:9c98 with SMTP id bt22-20020a056a00439600b005636fd79c98mr18284870pfb.13.1666337443014;
        Fri, 21 Oct 2022 00:30:43 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b005628a30a500sm14531929pfh.41.2022.10.21.00.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 00:30:42 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com
Cc:     CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Subject: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Date:   Fri, 21 Oct 2022 15:30:23 +0800
Message-Id: <20221021073025.18831-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

Summary
=======
These patches[1] supports the host to turn off FUA.

About FUA, roughly deal with the following two parts:
1) FUA(Forced Unit Access):
- The REQ_FUA flag can be OR ed into the r/w flags of a bio submitted from the
  filesystem and will make sure that I/O completion for this request is only
  signaled after the data has been committed to non-volatile storage.

2) In emmc, FUA is represented as Reliable write. code show as below:
static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
		int recovery_mode, bool *do_rel_wr_p, bool *do_data_tag_p)
{
	...
	/*
	 * Reliable writes are used to implement Forced Unit Access and
	 * are supported only on MMCs.
	 */
	do_rel_wr = (req->cmd_flags & REQ_FUA) &&
			rq_data_dir(req) == WRITE &&
			(md->flags & MMC_BLK_REL_WR);
	...
}

Patch structure
===============
patch#1:  for block
patch#2:  for sdhci-sprd

Tests
=====
Ran 'AndroBench' to evaluate the performance:
1. fua_disable = 1
/sys/block/mmcblk0/queue # cat fua 0
I tested 5 times for each case and output a average speed.

1) Sequential read:
Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
Average speed: 265.74MiB/s

2) Random read:
Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
Average speed: 98.81MiB/s

3) Sequential write:
Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
Average speed: 200.5MiB/s

4) Random write:
Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
Average speed: 70.32MiB/s

2. fua_disable = 0 (default 0)
/sys/block/mmcblk0/queue # cat fua 1
I tested 5 times for each case and output a average speed.
	
1) Sequential read:
Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
Average speed: 257.86MiB/s
	
2) Random read:
Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
Average speed: 100.2MiB/s
	
3) Sequential write:
Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
Average speed: 149.48MiB/s
	
4) Random write:
Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
Average speed: 12.68MiB/s
	
According to the above data, disable FUA (fua_disable = 1) improves the
performance:
1)Sequential read improved by 3%.
2)Random read were down 1%.
3)Sequential write improved by 34%.
4)Random write improved by 454%.
Therefore, it is recommended to support the host to control FUA.
	
Reference
=========
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/writeback_cache_control.rst
[2] Embedded Multi-Media Card (e•MMC) Electrical Standard (5.1)''

Wenchao Chen (2):
  mmc: block: Support Host to control FUA
  mmc: sdhci-sprd: enable fua_disable for SPRDSDHCI

 drivers/mmc/core/block.c      | 3 ++-
 drivers/mmc/host/sdhci-sprd.c | 2 ++
 include/linux/mmc/host.h      | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.17.1

