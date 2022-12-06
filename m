Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77664493A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiLFQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiLFQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:32:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABF2DAB3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:32:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so7549990ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTesi+XMwOO6DggGYE/adAhyblAlWesbBFNRIu2wHW4=;
        b=JyfCpxCvNOf2ETLBMLxdSngurnZ49ZRWCLZSotJ8MSpZCulX5uFaN4ZbYgFZkkHvFH
         0RUXM9JVJ9ufi6nLZcffxzh4Zsv41NoAfE8zeJkFQ4mXbOJHiUvZithDvq8SmYjzetJ6
         LdTblZ1N+G868f8KVeiOhy8upitg5DbubebhWP6umM3/NKsiQ4c4xrIX6x+0mf/Rqa/B
         77gYaovItJYiH3N6ldvMr4RuWO5X8HNV0ooTCITOpje9mzoifXuEnCi2mZPvC7U/ajs6
         +AM5QF89cWfu+vAWjrLwEgRuHXjiHSkSXUAaY837dPugDppQEnNXlnGtpp4AUMTEr7LC
         JayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTesi+XMwOO6DggGYE/adAhyblAlWesbBFNRIu2wHW4=;
        b=I6760t/skrUpwc8dnuT0z+2UbsYIuBbsZdMb84yxRhVtv3/hdfmQmYb5xaco/zIEg1
         qhZY9CBdit1MBcHNxXdm5KA/1EQ2cY2tbipo1+z+PVpylYqeYgn7z6ZIBnnui1V2HmZA
         3MifdOe8bpu9vWQFp0jRfPY1TSHVVO6nxE0hF4HPybjCNR+/PoEZfdd2Ikzh2WREwDPr
         k8MdgXtIsZ3gFxjJQkdfYZ7YkBIXLa40McvW6yFAa43Ukyjnx0te026yJUWmaH4/olyW
         4TAxkq9WPuxETzouwk8H96HQLKjVbw9kze7kednALGS9U/xVfOXjCsFj/1mkbyzFWvTs
         Bncg==
X-Gm-Message-State: ANoB5pk6QZ8M5YGSVCMxNy7yh883rz1/sMlakcVU91cYjLuWGYKw4vtJ
        w8ZiFrSkCGFLUWqmxVvI5lgoIg==
X-Google-Smtp-Source: AA0mqf5STJjS2tk6WUgUVbwiv1TZzFQaT9jbG3AzstPY4qgHzCqghdImo0J8atoG+jo4TH8/ldSX+w==
X-Received: by 2002:a17:907:a4c3:b0:7c0:7c22:d70d with SMTP id vq3-20020a170907a4c300b007c07c22d70dmr33002119ejc.707.1670344330594;
        Tue, 06 Dec 2022 08:32:10 -0800 (PST)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id t5-20020a056402020500b0046ac460da13sm1170104edv.53.2022.12.06.08.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 08:32:10 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V8 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue,  6 Dec 2022 17:31:55 +0100
Message-Id: <20221206163203.30071-1-paolo.valente@linaro.org>
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
here is the V8, it differs from V7 in that it addresses the issues
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
[2] https://lore.kernel.org/lkml/20221206081551.28257-1-paolo.valente@linaro.org/T/#t

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

 block/bfq-cgroup.c  |  94 ++++----
 block/bfq-iosched.c | 573 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 558 insertions(+), 253 deletions(-)

--
2.20.1
