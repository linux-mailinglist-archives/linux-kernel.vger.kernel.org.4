Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0569EE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBVFjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:39:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB8528D19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:39:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id bh1so7562454plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=emZcX0exsXWMNu2WtKZos0anmdtCl/O+H+3q40s/XQU=;
        b=fzgyZlAlM6sjZ4AraJ1T1vEKvI77yHDLcd5KhVKJBZhjVv8x5pd6Hq963x0ca12tw7
         uMQTh1Q4yAKtJH9aecr0fC944ZymmdMYdU2Sd2n+Dj00FHm/brqlLJMzDf0yr03wphqY
         9mrQcW1uuFsx4O4iWmTb/CHjlv6lewstIzsopfxgkgpw/Mca8hSdj+c42kMbIJvZTyls
         WjE/EtbS6PthK2ctuM6BP1dLh3HDVVbpiTK4R5hP76D9CPJz1SKHswF78Z4X5MUOTAIB
         23npEXGwVidDk62KxzAZLpZ/S5nnFI9d0nA9x5Ms6Ikq0sFOSphUQ45AnywPGheD668O
         /Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emZcX0exsXWMNu2WtKZos0anmdtCl/O+H+3q40s/XQU=;
        b=zGVF3TAexq+Zoa3pHkmoaEBKRzFU+VTgsVhenDaVNHtmIfshfuk82rUHhnBJoSHrZA
         V9f5rsmtHtrRXnVngo6rwfoqCM8NSn2aXZkBMUIdo5OIt80xuMFL0qYevIqmW/Rwmjt0
         qVvkhjMfCXLBCJKqMxXpM32ya5NHBAq6Y+4yqbZ5AVoNUUPpgs2RqMbWHx9jdoD2G/nI
         qselbcANBftzbhSnEZdFS1CpzjZ0czlFMngilVDuGj9o3KA1wnexQQN2UGyrauHNrXK9
         vEbyKFGbN8PktcDhYhzsv0QtT/3eOyG0R+ccIxjXBfGsPdGw+BwH9rpkVGBoe1wGCDF5
         Y9Dg==
X-Gm-Message-State: AO0yUKW5Dgcf8awDhSLANz9ARdUkH7DvmXfrNiuQ6CuDiDtxjFe16yHb
        JRVpEuX0Lnl5Azm56iZJy1q+XQ==
X-Google-Smtp-Source: AK7set/bs4zGW8QMHc9/c7VtL4J5ZuxMFHdBWeh0lyWFl+RPoKUnLbAUKaMjBJVRDQ2aGShVyJVlrA==
X-Received: by 2002:a05:6a20:12c3:b0:bf:6cd3:954a with SMTP id v3-20020a056a2012c300b000bf6cd3954amr7421487pzg.42.1677044352245;
        Tue, 21 Feb 2023 21:39:12 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79203000000b005931a44a239sm1107130pfo.112.2023.02.21.21.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:39:11 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 0/3] introduce tee-based EFI Runtime Variable Service
Date:   Wed, 22 Feb 2023 14:38:21 +0900
Message-Id: <20230222053825.992-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
- remove TEEC_ERROR_EXCESS_DATA status, it is refered just to output
error message

Masahisa Kojima (3):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  12 +
 drivers/firmware/efi/stmm/mm_communication.h | 249 ++++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 626 +++++++++++++++++++
 include/linux/efi.h                          |   4 +
 6 files changed, 907 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

-- 
2.30.2

