Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC50E646D91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLHKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiLHKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:48:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C738AAE3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:43:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id t17so2918144eju.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayq2uzYmxur5KO3TBD7Tr7qziqy3xJrvwA2myfA8G2M=;
        b=zeWPkoCZb1FlV7oMvzbYNU2TqdCH2PecBvv9BOPMv1x/pbetJ/0zzxlW9aLYpXI+Uj
         rLpDGjKActCDbELjrkfq5YHMz/duulYHGsoVZe1eGCogKHRZDN0WicmHTwb52JJsDGv7
         mx+FomyfQPKw7Wi6EvBj6WfFjGpqVGOeQeWnR7x46B3oCKm+skdTsNqIVPbTfGcbhmur
         zRxWNz8W5DCd/WtodpRe2sna/Mxulse9tkACWGy4TzT8oSoD8SYSzB7K8DOuaZn5rdq5
         /3msWgsvHEatA0Np63ffbStzLoLqEw9hj4DJVvbJ86HmdRsK0dhaaRIO/bYSn9Nj7MvP
         EXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ayq2uzYmxur5KO3TBD7Tr7qziqy3xJrvwA2myfA8G2M=;
        b=usvMnSJ9uXilP8VMGEd182aksRzQGwDR4obt2OgM73+ikdYCpi6NoGbJZ2W++gLLSo
         TGUHt76AbhvYfDS9nkE7++F2CsMuGKukxgvFbp95f5XSuzNWYk2l2HBsNw5tLhHJPyIH
         OiIJ8nURoFBHqp6serEI+pneoBxev/M2xCNJ3zMgqqvn3No7rYkzlKqEtgTFD0UEIADN
         OjZn+jwZGJY7SbmPLo7LGhOHDg+ptYDjDWCfodMR7pRyzEvZdU+Zvf+Qu57QAsZGAnRm
         uKXCJOJ3feO/hx9A3vG4LeDEa45IA41xQyIr8ogHAHjs9ZPqcspvMGXxCytQm93gOy+l
         spPQ==
X-Gm-Message-State: ANoB5pldZDLrm4XO/k0Naoska0p3PtJciaeNJK+5E88YWGbpn4WMvxiX
        3fZuz9PH0VB4rWBBIhg0KAcU8A==
X-Google-Smtp-Source: AA0mqf4jzaLcHPMM3pVvfOP2Kujd1gMjC+2C370Fvv+vTgvoCQkzYjH+uTtcZZfjEx0gOgDzyKVPZQ==
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id z17-20020a170906435100b0078d513df447mr68192785ejm.708.1670496238174;
        Thu, 08 Dec 2022 02:43:58 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm9544193ejc.210.2022.12.08.02.43.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:43:57 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V9 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu,  8 Dec 2022 11:43:43 +0100
Message-Id: <20221208104351.35038-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here is the V9, it differs from V8 in that it applies the
recommendation by Damien in [2].

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
[2] https://lore.kernel.org/lkml/20221103162623.10286-5-paolo.valente@linaro.org/T/#mdb87dc01b2ac165056ee3c7a1386754dea42a006

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

 block/bfq-cgroup.c  |  94 +++----
 block/bfq-iosched.c | 580 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 565 insertions(+), 253 deletions(-)

--
2.20.1
