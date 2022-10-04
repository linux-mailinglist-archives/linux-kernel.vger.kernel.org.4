Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D065F4008
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiJDJnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJDJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:42:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F835558EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:40:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so27641365ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wxps3Pww2GgPqApls49Rzjsg7b3CV5/N+Xt2jcVujHQ=;
        b=VflCQ3sGRMJoxCNqSzSlctUU2CDZrp9MSN4eXCpTql3xtlyPvUS4GpSr1h/r81tu8/
         SOPmZMCrcxtzF22s9MXxnRvLHHRAVrePBNoONvqgGTAMc8td6fcvJSC45jrcWZPj53VF
         1Cu4RdWtUC+TOCawwY7I5ysXg0542Gl7kySAn6W0KNpt40hJKW97n8T55uWoas8jhEcN
         ifoMSFo1iWK3QDiAYEPFs5s3Q5DC2o2IzOw3K6UZLmA4rTsKNIKA333HsnD/XtzsePId
         z/Srd+nhn0Lt0r8zDwyEltG36IXoons6tF0A+OvtL6OAtRwbjmfx5FTJn3wcHfPqyUGD
         F6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wxps3Pww2GgPqApls49Rzjsg7b3CV5/N+Xt2jcVujHQ=;
        b=QqTZVAeyluyBBp8u6nLYvkmpMfR6Ovo3oWgwyZpK63lvYmxt5EHdA9QEQ8iD2XDUyp
         xIELTcX9PX1mhZBlsCGhQpjEgldtZyWEvyBDC2RTdV97O30DkNzn2151cIRTxRM804Lx
         j9UK26GeXBc0BLhqnwjYnPwpmY2WQrkUis9AedAw/YkXLmGjPtNyn+J47BzZ5RvJxAkj
         nOhzJkaUkpun0eI/kDfKTv+I2nePJYkQY2oyr8s1OaZCWtUnbtJcq1dTEzF5ocvkmPiS
         zfzjYjIaGKRWujuDBJ+3FEg1nHxuyGMfnLDKnKCWiE45/UTbBYft0Fc+KrPhH2LwW0cR
         +niQ==
X-Gm-Message-State: ACrzQf21v5MNVHKlViCDLInoRcobP8RIAWW7G6WVmpoBvaK3fkXaIPZp
        LSY3lYkdL/iG1+AuMf6uxev5+g==
X-Google-Smtp-Source: AMsMyM7zUkQWgnqvglH9cF+2TCR9ZZb6ryXF+cV6pymMpFRpw/9Lz2HAvzLCZlkNl9vfUQfF6wLK/Q==
X-Received: by 2002:a17:907:6d9c:b0:783:a3b4:2cf5 with SMTP id sb28-20020a1709076d9c00b00783a3b42cf5mr18014497ejc.216.1664876416967;
        Tue, 04 Oct 2022 02:40:16 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:16 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Tue,  4 Oct 2022 11:40:02 +0200
Message-Id: <20221004094010.80090-1-paolo.valente@linaro.org>
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

[I made a mistake, and the series did not compile, this V3 seems ok;
repeating below the same cover letter as V2]

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
 block/bfq-iosched.c | 490 +++++++++++++++++++++++++++++---------------
 block/bfq-iosched.h | 149 ++++++++++----
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 495 insertions(+), 243 deletions(-)

--
2.20.1
