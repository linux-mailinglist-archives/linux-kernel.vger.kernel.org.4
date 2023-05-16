Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE0704E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjEPMyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjEPMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:54:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B43E56
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30789a4c537so7724691f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241647; x=1686833647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=291lIgk0Dkec8nzfiMqr4Pnou0+BFHlG8Ki/DRM6Hgw=;
        b=yReW3lle5yvtwsa0LRvS1OxUj3R8Rnw3n1LoJZlI3q5RQglqn28P1Ykh7NHwJS+MqQ
         dT2kSbiwK8/okZ4Lhrd+Kd1f5SMxFvTKDaZjsYDMYzTr8s68+G8f3Q8GP0MGrVb+7Iy4
         uM0juq3NSc9LsxZdRIoqyZw/y75AojRJoX2atcPXsXkAmL+1P36JeJjGc/Wwr++xd5UP
         c3gTYrKlZ1wyIGL6lnlAfLr70NcPp8JNKKc0+NJ0BoraEPkadRw9ZcQ3LH84tQ+BKnoA
         iMH9n6L0NXZqqwTFhKO5jeZERDQeJTcOjWnVUH+nf180KwxX9d4Gg09gmDflQ/1kxgO/
         JOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241647; x=1686833647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=291lIgk0Dkec8nzfiMqr4Pnou0+BFHlG8Ki/DRM6Hgw=;
        b=XwoYjyWTBtwQlarHJi6CPLbxfpY/ngH4FUlbQmf3lN0fKsb21dPL8IKhMHmTpFz9WV
         p132pZuQJ318s1eJY4VGV5wezaEX6hkNTlmYu00+9MJ6VKkU29Vh7q14MM4e8sYwYvuu
         ET2K4UeFE8H7pJ1muC5W+/6kQBpARz0B9t0Y62E40Uur+5SDpIG6mh56EjLFBpkIRVQf
         He/FQk+bvzfuiFfUI5QGTEu1bkzfaHT8PI9aXP6KPIYiUjYxCWn52ZPzQm7ewpq2BCKM
         03H1aqNaIZVzmHuq/rZsgizOQ3VfV416IFXBOaTZrRrQKkSYSvBlGhcy0rOFufK/iQZ8
         DiZA==
X-Gm-Message-State: AC+VfDzJvy5/avz0j1ueQecdmGAlqhtVykPRDbM0ADAEtJ6eukdIHU42
        ghCyUoJaFEQ9tHAVXo3yMvBUgIAlgDurn3i3lgo=
X-Google-Smtp-Source: ACHHUZ65zltyG5HO3mPAj3A711rK62JGGMfllVGVO2u3+tpXEEGYXPp3GMiFb4tLCKKKGjRTbHEHbA==
X-Received: by 2002:a5d:4b91:0:b0:306:2a1a:d265 with SMTP id b17-20020a5d4b91000000b003062a1ad265mr25410731wrt.58.1684241646883;
        Tue, 16 May 2023 05:54:06 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (87-88-164-239.abo.bbox.fr. [87.88.164.239])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b003047d5b8817sm2521963wrx.80.2023.05.16.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:54:06 -0700 (PDT)
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
Subject: [PATCH v8 0/4] tee: introduce TEE system session
Date:   Tue, 16 May 2023 14:51:07 +0200
Message-Id: <20230516125111.2690204-1-etienne.carriere@linaro.org>
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
 drivers/tee/optee/call.c          | 155 +++++++++++++++++++++++++++---
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  13 +--
 drivers/tee/optee/optee_private.h |  39 +++++++-
 drivers/tee/optee/smc_abi.c       |  31 ++++--
 drivers/tee/tee_core.c            |   8 ++
 include/linux/tee_drv.h           |  16 +++
 8 files changed, 235 insertions(+), 36 deletions(-)
---
No change since v7

Changes since v6:
- Added this cover letter missing in previous patch series revisions.

-- 
2.25.1

