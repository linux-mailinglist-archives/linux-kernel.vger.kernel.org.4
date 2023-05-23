Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878A70D86C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjEWJHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjEWJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:06:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E8184
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:06:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so3124629b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684832793; x=1687424793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhQ4IZJh9rBRd52mc51WGb6xZXwHr5KeJR6PlvutHx8=;
        b=m3yxgDswSpG87SHPe5J6Y6jGmQWzfvB0XTZSIjbtWFhEVuf/OOJU1tt1VRsJHPIoxl
         pqUQxuOzRzMiByyIztohzUJcCYnXwfVc0uAkgvLQsF5HKhj+Z6dvTn7T8n9JhjUnOdNN
         ctdIigWSeLjua8wPciBh7SEYKbphjA6fJ91+5iKuxAokCGhFeNXBjtlBVNpw2n+KQh+k
         WKRQK6LT4C5aWcaIyfOfJeibEZLyqjasMR6dx95eD6aXYRCHH/8SVFbAQucTNhe9+dDT
         tqRCMefD9yXeiFd3UWis/Y8flAbC5WSJwp7SSJbRPbM7PxljNxJcqIvyYVk9TPSOe3Ug
         TD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832793; x=1687424793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhQ4IZJh9rBRd52mc51WGb6xZXwHr5KeJR6PlvutHx8=;
        b=Phe30t+XaCvse+cpnm3tds+LKBjkc/nAw3oor7/xJes8yt3ILxGmdkU8BaXfaVLkVJ
         Edc0tup0x4cpdc6NEkhjl8b/OrtdOPcslC5sfu6/gb+FNRCtneci9k/9mxGxy+xyWUcS
         hfCu1+O7BEwOIArItteYP1+TRW+9WSAHi+7zbsHZy8HB331V8Yc0Fo0hPzb09vZhKYZx
         6rHMp1jagXUrovPQkH02CkyNxLjxx61TSsw30JkKXpY56cUpwAVa5SbVyjmimkkd9wiY
         U/w64Awe6CJ1X13N7wUgK6ufGuLiyOTG05XS6g8l+5AO912SgZ4t6i2liiP/s00FDpu3
         lxmQ==
X-Gm-Message-State: AC+VfDzQ/5pB7YyO75H74cayKUxoxoy2HM2B6njt9/Js/1/4xzpgze+e
        Oo0SgiFIb+g4a/3cpDadOH8MZfivRdKmJWFQCp8=
X-Google-Smtp-Source: ACHHUZ4u2NPLddBn5KyMt9OQl4Qr12q43L+BAb0WskDVSGUCuCz0tTctso+10oYPDqtb7jx/E9t8FA==
X-Received: by 2002:a05:6a20:9189:b0:106:9266:4448 with SMTP id v9-20020a056a20918900b0010692664448mr15511393pzd.16.1684832793504;
        Tue, 23 May 2023 02:06:33 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78113000000b006410f4f3ecdsm5338195pfi.83.2023.05.23.02.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:06:33 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
Date:   Tue, 23 May 2023 18:06:03 +0900
Message-Id: <20230523090607.1433-1-masahisa.kojima@linaro.org>
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
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 637 +++++++++++++++++++
 include/linux/efi.h                          |   4 +
 6 files changed, 905 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

-- 
2.30.2

