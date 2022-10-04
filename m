Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC55F3F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJDJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDJSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:18:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D72CC9F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:18:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sd10so27558120ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=GepVW2cosVKq4FOy7qPGQiiaFt7pA6f/gcQCJZTM9XA=;
        b=BSAulJVDWFtrIsHwbMyqfAA1W9iUIVx6ybxt/IR9VjEX3CL9Iavr6IZGL0fV/9pLHR
         gq8uKzd0S5CrWKVNTeaUAWLzJD0evCE5HVBtF1V6mw1iiSY+fuXgNhCcwT3AxVD2/D+w
         wqbt9MaxWN6BRqbEvYANVUwkjjZEGTDQm8QJqMx/yZXLTNlS32XscMOxYmke8N9SdLDV
         CUVkSKjH7GfP/bewO+fRQrAZ6oOEkfODvCNXt6O9GD66ES+lx6/20mB/sao7qO46ckji
         jE1aiB4kEmKNSjI0XBMWyYu+DxcujF7uRtGao+YTPheEPiy6BP+58s5aC89GtQtCtp/4
         25oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GepVW2cosVKq4FOy7qPGQiiaFt7pA6f/gcQCJZTM9XA=;
        b=BO/bObY0ToLdToVathI8gb7f3lDqomBdrGD9Wh9LMNL8M7f49AvkNGrbALj3BWCk7A
         HlLe+bKXzRiQsHy4F7ywQkxGJiO2OuITEQPoi0y7D407xaxMcfwoewqmGhNyMNMRA4Px
         52IAw43raIS5gw/HBBTt7KNtonkbiKqiORP5pVgHbk3f+HbmNDb1+c3+VQvAZz/x7bsS
         sflzBLgmuIaLPRDF/f0zkZkp+lJxF1MCvEhcBXRFje3cGHw8kt0kmKrv/cgd4bzLPs10
         yVPo9nXsgx0F2EIC2EwVH5wref7e/FjVmQTk7jnhJedLoRQ2JqLnfNAHWyggnrjRwmF2
         M/WA==
X-Gm-Message-State: ACrzQf1Fwd5VfWNWKYSzWhelmnBJCyX2N0mQjuiO6BARzFykds5sBs4D
        sBhBOMXOALtlOEOWXdCrtbz78g==
X-Google-Smtp-Source: AMsMyM7YCH91AtxyEX+iVLXk5gMjuMDSFuh2ufmUEtUhF4IOzmdv41+Wmg0NH1nrAwwAACpyKaqKug==
X-Received: by 2002:a17:907:7b97:b0:782:20fd:b956 with SMTP id ne23-20020a1709077b9700b0078220fdb956mr18625004ejc.204.1664875124476;
        Tue, 04 Oct 2022 02:18:44 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b007826c0a05ecsm6597926ejf.209.2022.10.04.02.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:18:43 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue,  4 Oct 2022 11:18:08 +0200
Message-Id: <20221004091816.79799-1-paolo.valente@linaro.org>
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
this is a new version of a patch series that extends BFQ so as to
optimize I/O dispatch to multi-actuator drives. The only difference
from the previous version is a fix in the invocation of bio_end_sector
in patch "block, bfq: retrieve independent access ranges from request
queue" (I have appended a -1 after such invocation). See [2] for
details on this fix.

Here is the general description of this patch series again.  This
extension addresses the following issue. Multi-actuator drives appear
as a single device to the I/O subsystem [1].  Yet they address
commands to different actuators internally, as a function of Logical
Block Addressing (LBAs). A given sector is reachable by only one of
the actuators. For example, Seagate’s Serial Advanced Technology
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
[2] https://www.spinics.net/lists/kernel/msg4410750.html

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
  block, bfq: turn scalar fields into arrays in bfq_io_cq
  block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS

 block/bfq-cgroup.c  |  97 +++++----
 block/bfq-iosched.c | 489 +++++++++++++++++++++++++++++---------------
 block/bfq-iosched.h | 149 ++++++++++----
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 494 insertions(+), 243 deletions(-)

--
2.20.1
