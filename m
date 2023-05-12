Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F956FFFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjELFmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjELFmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:42:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A195172A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3078aa0b152so4647854f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683870155; x=1686462155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6olrtJonCVLJtFNntlrMczEuf6svIHnm0xX7DjUdLc=;
        b=dcUKxV0xY6Cwef52D2kCNDwf33OdAJMEe92Qv1bdPPZK3KtpE9eBmCcj3UxAxiG63l
         xpw/ElqZTXfCVwYuWthNp9cShitE7a5iXvIZHj6kN+p8O2rTmgkY37SZc2Tiqf6bkJGj
         AWyw3XD4aNIhnVIX/vxwP+cTZ4/NrVCAFa4v1N+uVLDe151Ha9i+IoIb3QaerLBycE+z
         Igrv9oShdsG4gW74ud6zAbpRSCO3IhDHdixwu6Gn8ioPOOvv8qiuYnqzsqAQqxyJtH/L
         nJ+2SLcX/W7YI/ne/5CgHf//E0wrm2pZBTie2FkxIY7idja5ER0lnzaCqaeut2wl/EkW
         XsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870155; x=1686462155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6olrtJonCVLJtFNntlrMczEuf6svIHnm0xX7DjUdLc=;
        b=XqTGXBhFjB7vuQdljjClwkG2HRoxyMO9UzQMFgZitBiwvVwhwpZfL2BTqhpYwOsBit
         PpZpxLvB+PVXQzCXAbdHGOPO+7uD37nHh72ZuIRFrc2RIM85SwPU7ycjkUphEAC8LzAC
         VlOUQ4HRwaVoCG4MAFqRILb3R3tFOKSDRei1KuJRHDH7BpAcbXyWuUB+Vh9gUAMzRvjl
         82lF22fZ5Xhcp9T2s4NQP7fpCqRuiePCF2xM7PRRXhGVEsVKYP183IaSiDZtJwdB+Q7P
         Yf5dBKr9vLK+Ji9UhM786ymsVCMQ+UJ3K9UQsA9yKEcoB0lCV3r5ryf4W4quQiIH7w6C
         gAdA==
X-Gm-Message-State: AC+VfDxa5TSe5sjlgLUXVGKOC/shEO9krBMo5M4cihXUVFna1qQ56ZUS
        xWCCloBe+wMJW89Lcvw08F/UWS2pLtNEeRQvUeM=
X-Google-Smtp-Source: ACHHUZ5vdoQWPYItp1xhkCrr3z/W3FWKhMOYZu/PAyNl1aHwFUoKaFnDsD/fhVcaRvnCubOp9AfJGw==
X-Received: by 2002:adf:f9d2:0:b0:2fa:6e37:3d97 with SMTP id w18-20020adff9d2000000b002fa6e373d97mr15815998wrr.54.1683870154757;
        Thu, 11 May 2023 22:42:34 -0700 (PDT)
Received: from lmecxl1178.home (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id j18-20020adfff92000000b00307bc4e39e5sm6301253wrr.117.2023.05.11.22.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 22:42:34 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v7 0/4] tee: introduce TEE system session
Date:   Fri, 12 May 2023 07:42:18 +0200
Message-Id: <20230512054222.2088837-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces TEE system sessions for TEE service sessions that
require TEE to provision resources to prevent deadlock when clients call
the TEE.

This deadlock situation can happen when a TEE service is used by low
level system resources as for example when Linux kernel uses SCMI
service embedded in TEE for clock, reset, regulator, etc... controls.
This case is detailled in patch 3/4:

> This feature is needed to prevent a system deadlock when several TEE
> client applications invoke TEE, consuming all TEE thread contexts
> available in the secure world. The deadlock can happen in the OP-TEE
> driver for example if all these TEE threads issue an RPC call from TEE
> to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
> device clock or regulator controller is accessed through an OP-TEE SCMI
> services. In that case, Linux SCMI driver must reach OP-TEE SCMI
> service without waiting until one of the consumed TEE threads is freed.

Etienne Carriere (4):
  tee: optee: system call property
  tee: system session
  tee: optee: support tracking system threads
  firmware: arm_scmi: optee: use optee system invocation

 drivers/firmware/arm_scmi/optee.c |   4 +
 drivers/tee/optee/call.c          | 150 +++++++++++++++++++++++++++---
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  13 +--
 drivers/tee/optee/optee_private.h |  20 +++-
 drivers/tee/optee/smc_abi.c       |  31 ++++--
 drivers/tee/tee_core.c            |   8 ++
 include/linux/tee_drv.h           |  16 ++++
 8 files changed, 211 insertions(+), 36 deletions(-)

---
Changes since v6:
- Added this cover letter missing in previous patch series revisions.

-- 
2.25.1

