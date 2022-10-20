Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05FC60646F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJTP1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJTP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:27:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E71C6BE1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2647764wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydtkBiacMxQllimLMzTI7t4qiYmQ9CS3AWKunS3eI8w=;
        b=bnQEX0V9aOC+J0fe4SfrcFILUueKlcaZFaHr+cwCGyWITGwe/zAPJqG2q/RZhiobQh
         5LEQRTiLWFKjwH0FnV3kgPC6S7xr82By0iwBhunYMtFcny+E+fYPNfJsNm/eCevGFAuf
         JN1IgtFDFXgMdZ1VrQzDQPkSbfMUG3LvkgZtfyz3t3JMLLCbhManlTvz09KNQAODoUDZ
         Wmj7i7m2VBU6dTaiLGi7ps8RFoNLH1OVH2mxYm4pb/G/gBV1VSAwngRGcECtAwbL/rM+
         ihO0KsHcW/56lBU5+sObIgZwVh1swHmq+tVMMeVoIg9dBd5LG0DuDzdFzO/GsE9p+kZI
         C2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydtkBiacMxQllimLMzTI7t4qiYmQ9CS3AWKunS3eI8w=;
        b=Us/K/789PJMWxv9KWQ/x2VSrGWDfOJbJV079MTtpuI9lpAwpv+c0IgCPpfTZz71EHc
         6y74Ik4aLuCbteLrIzyAdUFDh/WlkY9iHCHw16hwRtljwLjNUfzBXb3MXy4tCB+WGZ/0
         6yT9gBddBTpPrI3cC6LdpmaFTa2qO/SbyfTG8DmKaZ+edd2ymWoDExZe9FuUY0SnPio9
         p6KX3HlWB3WUtMSHxi52tobxBpt531FnpmB6UckIeeI7HmZnAzgpk4kR/x10xtY1NRpJ
         pdhWVXtTEiCiQc3s/gaag9F0jLLdmxV6yMZC8xi8YAcen2JOP87esMSNnVrLJlDkmY7F
         cuRQ==
X-Gm-Message-State: ACrzQf1TvT/yj43EXpLs34Ac4JOg/hMnUqpDhtfnZcTjrTGfnBitbVOt
        RD1/p9MyuWQW1YTmCO3R6XPQPQ==
X-Google-Smtp-Source: AMsMyM6Rtzh1xd/Xx6n+d8wC4tcV9WtwB8mPwz1cWsV02HbCOZAi62Vxgdqbc93r7KXqH5zbBr8+Hg==
X-Received: by 2002:a1c:7c06:0:b0:3c6:cc24:82c8 with SMTP id x6-20020a1c7c06000000b003c6cc2482c8mr9445799wmc.180.1666279613205;
        Thu, 20 Oct 2022 08:26:53 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003c409244bb0sm134337wmh.6.2022.10.20.08.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:26:52 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V4 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu, 20 Oct 2022 17:26:35 +0200
Message-Id: <20221020152643.21199-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this V4 differs from V3 in that it implements all recommendations
provided by Damien Le Moal in the thread for V3 [2]. It also addresses
all the issues reported by the kernel test robot in the same thread.

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
[2] https://lore.kernel.org/lkml/20221004094010.80090-1-paolo.valente@linaro.org/

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

 block/bfq-cgroup.c  |  97 +++++----
 block/bfq-iosched.c | 518 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 141 +++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 523 insertions(+), 235 deletions(-)

--
2.20.1
