Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBA739AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFVIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjFVIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:51:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA81981
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:51:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b4f95833c7so36539485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687423901; x=1690015901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBASIqyXLSyx4ohPlvkpc6vmBqbM05l9NnN2xOGWiY0=;
        b=ZV0A9BA9V7hgFXz84L4WIGWx6ReJdC2NiwWESB6rlR3FkBo2KmqKSi1tN0sXMwF6Zo
         ddvVMw6kG3ZQcFjCNVo0UwC8QfYNKKQjSblgy7T1OaNfOuqTK9j/PTTLI2FQtNs8TUuv
         qs8buUvtjymzZyaM6NtOsGN5nKA6kWHWyDpwGmBbIK9VpnMGrjah1gywbfn7sdpboDnh
         PqKvR1efixnZY+Mct1tCX2JFu2Mkb5ClG4dFEdtTT00MDWvP7+8J5IfsEkwNg3VSSf0K
         kW4cpoPmcrcjklWWD5aPCPjuq0Zi0H9vLYkbOf7euwhL9IdcaApt3ysLpwqhDjLhpuc4
         kYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423901; x=1690015901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBASIqyXLSyx4ohPlvkpc6vmBqbM05l9NnN2xOGWiY0=;
        b=Stiy/VA/UlTqQNg/lM5zIVgGw0Ws1Ru9g+Ke/qgUUwCS3sSldTWp2zzeBQFBFghLCv
         Jpf/CpozpuRb63UQrES5pZgwyhS+Jwe7aIOdkW0etqskPydRPj130uwjZw5SkU2Lz2bx
         oHxa3/FmvyrNFGP+NUVc1cc0Y+ZP527iF5xC6j8p3XHTQP0OK/VizsLHoCqIS2CXszp/
         IR0jZN90SnpfVZSARskv3XDNdxirY4WfaJ/RSegGrvuHGuTiM/Xrr5TGEbshQB1OQ0cA
         YM3zOndln3KoZDlqvRZgq29/jfJkRk03Gn951WAiEvUBL2TrfTCYuRhmVF6A9Z4cJlvV
         juGw==
X-Gm-Message-State: AC+VfDzDxnm/UH5R6hXGwzjOknt9p/7xHhpLzFdMYqEkT4gjcCKepBH7
        0FZLYIew/wBF0rFKpHHZzpg/9Q==
X-Google-Smtp-Source: ACHHUZ7Za4yKdOM+MTL5yOnySZFXlzx34O/RbRRbWQAtkUaAfBKGQTAB+8KGeEyA08qo8v5OmxXaNw==
X-Received: by 2002:a17:903:1ca:b0:1b6:9b38:600d with SMTP id e10-20020a17090301ca00b001b69b38600dmr3665054plh.46.1687423901043;
        Thu, 22 Jun 2023 01:51:41 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001b02bd00c61sm4820154plg.237.2023.06.22.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:51:40 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Date:   Thu, 22 Jun 2023 17:51:07 +0900
Message-Id: <20230622085112.1521-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v5 -> v6
- new patch #4 is added in this series, #1-#3 patches are unchanged.
  automatically update super block flag when the efivarops support
  SetVariable runtime service, so that user does not need to manually
  remount the efivarfs as RW.

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

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver
  efivarfs: automatically update super block flag

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  18 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
 drivers/firmware/efi/vars.c                  |   8 +
 fs/efivarfs/super.c                          |  33 +
 include/linux/efi.h                          |  12 +
 8 files changed, 961 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c


base-commit: d0a1865cf7e2211d9227592ef4141f4632e33908
-- 
2.30.2

