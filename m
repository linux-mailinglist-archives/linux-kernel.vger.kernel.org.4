Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B72711C17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjEZBI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEZBIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:08:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D7194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:08:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae507af2e5so2479675ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685063332; x=1687655332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFFBqO23ZdjuSNhKAA3uySPbv4aSMUNRY+kLje5uP6k=;
        b=iiiRN2AE4sxDcpe8vPpNJ3luJpn3I/pjI4+O+H/mL1Tshhz/QfaOLADea8fJm0gKLL
         Xis+X1HFu4QC4Nte+PA/jyuyS5lnG1a+7aZJqX4m8fOTCr4lG0a9zmlabLMIpmtX8tFh
         NgvZw6iQsabj69enVcFHWvR++dmFiIiXKiBKmuha82RXqdAb15PMAD/uwUxyyIic8T0r
         HsdM1vDf8OTbXPpV1VTZ9vq8CevamNdRT/k9dZSutUbX0Ptrf4xx58h8M54kJpcuAmXk
         faL7SKlarfOr/g8nJgEEFzMbUHm68q6jHRx+e2VLeEQeC4RR+aYKhsPu6Zr3/wQi7vER
         2UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063332; x=1687655332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFFBqO23ZdjuSNhKAA3uySPbv4aSMUNRY+kLje5uP6k=;
        b=OHUMMsRIFJLUoaFziPR8PUBNrkkQepI9IjV1dVP3JRPz0rLC4eQDfMM58URTlBZKlK
         wXrI4giCx4CZUo51XJJ+zICHobM952r966QbT/bb/Q6+cFTCuZmjvWMJZyHg8X9rsVd6
         kBz6gtp5e4aRwJWxc5lkO+0M9BPR16dPS9yk/2TfuTwY1LRn2LIQSIjOIQKbqBjmbjvK
         fiJfZ5tOSkz045raMx/ykYtuaSIaDRBwwiYMjlMpop3LtwLX1FrIv12XBMvGE1ovSDva
         ZMIObEDa5l3xMQ5E7suCLRFHLFPzlj3+6rB7pC7PLcVUAgTFY6EiZZdpOGqRQIz3KoML
         Ovgg==
X-Gm-Message-State: AC+VfDxfFR0YIs7DFXs/7+DwltAQS2/+N1eZIuQscAx+tilqVELr6mZJ
        x3WWA+lSpJfMjC7XxNczpm5i7Q==
X-Google-Smtp-Source: ACHHUZ7N0XJXr7Q0+QkU3V2hhZVn0oe+706y4/+a9mfzR4FTCQlKPBanRBG6FXompYd8lcG549v2rA==
X-Received: by 2002:a17:903:1111:b0:1ae:89a:a4 with SMTP id n17-20020a170903111100b001ae089a00a4mr186526plh.8.1685063332107;
        Thu, 25 May 2023 18:08:52 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902bd4b00b001ab2b415bdbsm1981797plx.45.2023.05.25.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:08:51 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 0/3] introduce tee-based EFI Runtime Variable Service
Date:   Fri, 26 May 2023 10:07:44 +0900
Message-Id: <20230526010748.1222-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
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

This series introduces the tee based EFI Runtime Variable Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
v4 -> v5
- rebase to efi-next based on v6.4-rc1
- set generic_ops.query_variable_info, it works as expected as follows.
$ df -h /sys/firmware/efi/efivars/
Filesystem      Size  Used Avail Use% Mounted on
efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars

v3 -> v4:
- replace the reference from EDK2 to PI Specification
- remove EDK2 source code reference comments
- prepare nonblocking variant of set_variable, it just returns
  EFI_UNSUPPORTED
- remove redundant buffer size check
- argument name change in mm_communicate
- function interface changes in setup_mm_hdr to remove (void **) cast

v2 -> v3:
- add CONFIG_EFI dependency to TEE_STMM_EFI
- add missing return code check for tee_client_invoke_func()
- directly call efivars_register/unregister from tee_stmm_efi.c

rfc v1 -> v2:
- split patch into three patches, one for drivers/tee,
  one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
- context/session management into probe() and remove() same as other tee
client driver
- StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
- use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
  this file does not contain op-tee specific code, abstracted by tee layer and
  StMM variable driver will work on other tee implementation.
- PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
- implement query_variable_store() but currently not used
- no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
  Other tee client drivers use 0 instead of using TEEC_SUCCESS
- remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
error message

Masahisa Kojima (3):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  12 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
 include/linux/efi.h                          |   4 +
 6 files changed, 906 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

-- 
2.30.2

