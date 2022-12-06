Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27153643E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiLFIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiLFIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:16:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958C5DF08
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:15:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m18so2757064eji.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stOrUeAezGYWH6O5jRYFnyRnOGFSYXV3ludw//XtusM=;
        b=Uzo6WVa5XE+77HyTAn5Ic1ddgCFcKbbPuNTmHK8QywYcs2JKIpW0y6zrtIokCOmHPf
         0QxC6VwwGsJ+2uZId4MvlaPCAI1tzBsqqs9/UY6W1d0pAgEDCJkcoSnDwxt6QXCMZsE2
         eUSb8KQh95t68L2wDSe9niKDFsZZG7w5+T1wD5M94hS2BIx22IFZsItM1V065iP3LfWf
         0z6xTPNzDyFLDZGAw3Xk0iSsgLxykFd5Tfk7VgsdzFtGQCxKnKG5VoUxoY7tlMuRGbgA
         49apVPQc1mLxya/o7+hsjzjmUKXz6UEndO1IKfkOYYiCwoX+0MurcqZiIqveSQkzSVXi
         wZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stOrUeAezGYWH6O5jRYFnyRnOGFSYXV3ludw//XtusM=;
        b=Tc2BDTHVK/HN1y8kWNPZQyJ52fcZphecVkZdIQ/fK5+GUxr2r6UAxYKEzI/7PdPwD0
         F07QOgAEXrlVg1d4IDEhic2hGg/9ijwt8PYdRMoq1Bc62F2fr/6FeXVvj4m1fkECc0nh
         3IpRavDmU+Ucgq3L2t4Pgd01kBdDwLcOhLbx8wgOH9AeB5g5kccSsiGprBz/NJP6Sg5H
         M6t5T3CgUtsk6pAHhxnMd1+yYH7ymz4omeKLn2FLzphmCZ/eODNvq2w2C3wHx70xjR5d
         x7Vyl17JJwu6epTktTdGbbWnXBCrG5lIIgPQsijpia6RcVZGpA7LiMdFt+vHwUnfRKJI
         j4oA==
X-Gm-Message-State: ANoB5pmWOU6v/p5pQOUWOp2e1izU57ZOa4ewEk111zeeqNd//yT3awiF
        Ipn8gAhw4Cojwc546cTRk8k2P+l1ykntZG62
X-Google-Smtp-Source: AA0mqf4Fbck58myf45UKMDP+j97tSbHvZaV71xvZjUrVynI9H0xGLHQalfvut9hpd28nmFk0D4R1ig==
X-Received: by 2002:a17:907:2127:b0:7c0:ee16:3c5a with SMTP id qo7-20020a170907212700b007c0ee163c5amr7638168ejb.298.1670314558118;
        Tue, 06 Dec 2022 00:15:58 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b007b29d292852sm7161944ejw.148.2022.12.06.00.15.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:15:57 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V7 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue,  6 Dec 2022 09:15:43 +0100
Message-Id: <20221206081551.28257-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here is a V7, which differs from V6 in that it addresses the issue
reported in [2].

Here is the whole description of this patch series again.  This
extension addresses the following issue. Single-LUN multi-actuator
SCSI drives, as well as all multi-actuator SATA drives appear as a
single device to the I/O subsystem [1].  Yet they address commands to
different actuators internally, as a function of Logical Block
Addressing (LBAs). A given sector is reachable by only one of the
actuators. For example, Seagate’s Serial Advanced Technology
Attachment (SATA) version contains two actuators and maps the lower
half of the SATA LBA space to the lower actuator and the upper half to
the upper actuator.

Evidently, to fully utilize actuators, no actuator must be left idle
or underutilized while there is pending I/O for it. To reach this
goal, the block layer must somehow control the load of each actuator
individually. This series enriches BFQ with such a per-actuator
control, as a first step. Then it also adds a simple mechanism for
guaranteeing that actuators with pending I/O are never left idle.

See [1] for a more detailed overview of the problem and of the
solutions implemented in this patch series. There you will also find
some preliminary performance results.

Thanks,
Paolo

[1] https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-sata-hard-drives/
[2] https://lore.kernel.org/lkml/20221103162623.10286-5-paolo.valente@linaro.org/T/

Davide Zini (3):
  block, bfq: split also async bfq_queues on a per-actuator basis
  block, bfq: inject I/O to underutilized actuators
  block, bfq: balance I/O injection among underutilized actuators

Federico Gavioli (1):
  block, bfq: retrieve independent access ranges from request queue

Paolo Valente (4):
  block, bfq: split sync bfq_queues on a per-actuator basis
  block, bfq: forbid stable merging of queues associated with different
    actuators
  block, bfq: move io_cq-persistent bfqq data into a dedicated struct
  block, bfq: turn bfqq_data into an array in bfq_io_cq

 block/bfq-cgroup.c  |  95 ++++----
 block/bfq-iosched.c | 575 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 561 insertions(+), 253 deletions(-)

--
2.20.1
