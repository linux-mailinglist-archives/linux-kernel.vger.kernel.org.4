Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7C465918E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiL2Uhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiL2Uhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:37:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AC1572B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jo4so47416293ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXFg2yYaAB6S4MxMGxEcZLOgUNKxyT0DBdu5JG8/72g=;
        b=KWJqtgZAz4Hx98dc87ZfYDATs7g2MgrmI3tCHcxxM+x6bF1Jbp1XOQjLtTkNSKxCdW
         n9/cnYq9Aza8+IJZn0tW1PlcwWW3sjOu6xrKWAzqy2x9ixxjNEFSbI3nZy6pd2jnssJL
         QeKn2eHtfUeHTCXkwqvZB7lwiNIXPTh5+RPk5vBwU6ds27rs/Toly/LjZtjdxAO3vkBC
         +F2j3Ipxm8bINILpnAcFlCoXrAb/xnwd1H7sSyQyXIAIXz2UGhXRfjszxtOtTEi3C24i
         RBGAI6PomfxgvBmSbg33HLFUgrL/BSg3fxENcdk51BIwDq08WNuiztN2rrNthPkJLjD4
         FuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXFg2yYaAB6S4MxMGxEcZLOgUNKxyT0DBdu5JG8/72g=;
        b=nhdH4KmWY9oo4ISAX775THe3jXcGjLQIBwU80FhFT+FBypgBaISZibQPZSIbxJ/q6z
         3MJViL0Q66Xm3EKBYku+S4Rvf7aTLQmli1YcepGuSUgOalW3QFvf6FOWQN4EOLh/lHGB
         HTsma6Hq91WKEttV++e5Qc5R3cY/P/XFfgdGBPV7kh8B4cmgIiGy2FbKfcnXtVG9OEmi
         UzDT7ZUYJcyyeiLLU16i31Hql8EuEZUMefTT6+3jS+0Nw0nGwu4Fr0doYbw5t1wCBrMt
         H53H8V2qXGHZnwfIgqP86Ag90kuZEiJRSNWBsrx+Yl85DqZmI1I2gBL4iKJNIxXh3Yhv
         i+3Q==
X-Gm-Message-State: AFqh2koTo9gtNxz6a5rY/bZ+kIz1oBNREVyWm5jKCXi1KhkLgPbstkHe
        utXjYbuVs1KilnDK9fFMSetEHjUKtplHOZUR
X-Google-Smtp-Source: AMrXdXurFqQk307rW/edSlHzZMiOW+xO8s5Rrclekyw2EZyTuJYysKRqJfnIcwc3M1nGpHpHxN284A==
X-Received: by 2002:a17:906:60cd:b0:845:bb21:f638 with SMTP id f13-20020a17090660cd00b00845bb21f638mr21517513ejk.75.1672346258461;
        Thu, 29 Dec 2022 12:37:38 -0800 (PST)
Received: from localhost.localdomain (mob-109-118-160-216.net.vodafone.it. [109.118.160.216])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906371000b0073d7b876621sm8872814ejc.205.2022.12.29.12.37.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 12:37:38 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu, 29 Dec 2022 21:36:59 +0100
Message-Id: <20221229203707.68458-1-paolo.valente@linaro.org>
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
here is the V13, it differs from V12 in that it applies the
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
[2] https://lkml.org/lkml/2022/12/26/428

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

 block/bfq-cgroup.c  |  93 +++----
 block/bfq-iosched.c | 587 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 565 insertions(+), 259 deletions(-)

--
2.20.1
