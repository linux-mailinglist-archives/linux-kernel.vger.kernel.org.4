Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0365442D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiLVPWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiLVPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:22:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB12B268
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:22:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id tz12so5636700ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00e9FJpVGfEOAiHvEaDoajL9FdeFE17qZFjV5ZA2BMg=;
        b=EVi3Vc9v/lZHjNlZy63H9HJA32sgrDaK4EOlRf44uvWlkkHR56dlTLOEOh9ql8GhH+
         Bh7NrP5yO+j8uOJw9C53S4+SwuK2E2XXoECRZnnIkDalrNlSdk9bUKQZ9mI8qTNLXLcy
         igM3WhHNkdk/I+Ki+PyZ3Tp07Q75Z7iy/Wj+DMSbZSrW8Yv9+J1f8rLGgM40P9u7RLrB
         DuPv4cUUFEdjPgnh+NwK6T5wb9mFL2VOuGsg26TIcOcpCCl5w69ciB6OKN5mS1nIFohJ
         DWMH+rDbxCVdSk8bhiz4ObE1SEztQtj44jr8VTG1dSVtXPJBiiQvx+7aPiiUXTroPNux
         ekcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00e9FJpVGfEOAiHvEaDoajL9FdeFE17qZFjV5ZA2BMg=;
        b=D3wYeApBulvRxbQTzOYnSpTSm8c8x3lMvUbPWkXT++MEPHnjNKaj5GMQFCD0VcoX9z
         hDoQHCCah9cQwAcp1M9TBLNrlh501DOPseeQYQCsJEbHMqR/vswlirKs76BFB06x21SK
         X5ciPwvzfbBcqvFvulW/LRzAWZtcrrjfXvYpYl7mpQXxGXLzc/hayEF1CTFhA6jyswZ0
         X4CENvG6x/Iy8j2BZ0yPNDEwqxLkWWn6sK3dEYp0ZFFj7vRxT1jSAAmGUbhrQ6dqpR+4
         Z8Z7/ra99QqK7U4eK5CKnJKY9KYQiLVayyESaeGrOlXfYT+PC2wuih7SGIFYR5IpBIw+
         ORxw==
X-Gm-Message-State: AFqh2kphKP0cztFewMqrcfxda68C6l/dh0CQIqTnLX5Lt1yh6kmD32w6
        zEU2U5NQF5cxpYTOkHMYhQQKpg==
X-Google-Smtp-Source: AMrXdXslN8b6R+g9KHsnBjoshEGJHr9DIix6zotavKJINuzFk309lGbOAEitD5WLkDrSRpER4xWtwQ==
X-Received: by 2002:a17:906:39d8:b0:847:410:ecff with SMTP id i24-20020a17090639d800b008470410ecffmr831336eje.16.1671722524619;
        Thu, 22 Dec 2022 07:22:04 -0800 (PST)
Received: from MBP-di-Paolo.station (net-93-70-85-0.cust.vodafonedsl.it. [93.70.85.0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007c08439161dsm355670ejo.50.2022.12.22.07.22.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:22:04 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V12 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Thu, 22 Dec 2022 16:21:49 +0100
Message-Id: <20221222152157.61789-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here is the V12, it differs from V11 in that it applies the
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
[2] https://lore.kernel.org/lkml/20221220095013.55803-1-paolo.valente@linaro.org/T/#m28f40c3b060087a230998a3b55a021020c396cab

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
 block/bfq-iosched.c | 591 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 142 ++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 569 insertions(+), 259 deletions(-)

--
2.20.1
