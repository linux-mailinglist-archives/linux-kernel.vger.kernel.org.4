Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984F69C4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBTFRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBTFRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:17:46 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A9CC3E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:17:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g14so112289pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HD+Nl+GfzBGiSwRfO/bSjedzMDMeWkGv1s23h0bZ6lA=;
        b=C4Jo8WUflAV5wmCxoI8DLlwQchJVCd86+LASD/xrXSqvc7CaR6OZXr8AsQkJXTjrJU
         uFgSRvk2Tl7AzfjBT+xnR5ycz3fZuRAsNNt5tnEZhdAe6FVbspAysoTdDTVqkX4PicjM
         KNRrYniTsMzEqXXyILeVy9uqe2KamAYfnDr9VxsuDPfLKFDgh6QfjyRqiEArreVkbC7z
         JUHMtPNf/9+w1Uh8gr5GkMc7Nv8mBd3Rzb5B4/ueIKYeIglQHdZwyPHpIw9hFipCFuLW
         a6FMOBUOUAu2WN21kyMTso34gJl2CVl1AKjx/j8zIQV31UcOLYnky24veWuMWKyfql8+
         oOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD+Nl+GfzBGiSwRfO/bSjedzMDMeWkGv1s23h0bZ6lA=;
        b=q4TG6suuh7RXtxknVjA/w3dhJ6llkvQ2X1XUg/R9f3tLECX8uyLJ2xVXYCpWPkEwtD
         tOstnzKjykYHX8mTXWLvjFxUbVObgoPlx02GSuWT5MDe/+b8k6jLWAlMnW0CeUP36AnV
         PJmGMiT1wYtCjxUFWTqL4+waIrR28lATKPrGqSmB4Y+dNtmzUsUavS4fWGk82fTjr43W
         36h6N6iat+OzFGqOTE3NAmxyUNzxff9dTdZ406juK7gs5X+NjvYYLJti0vIBMwYzZ8Mw
         YmrrqJFAKFPKxEtrkJg4CHS7KNpu2GeLCpoQi5Tc0E9JLdRts+WrWRNAfRH4M3zHiKWs
         +1Aw==
X-Gm-Message-State: AO0yUKXUMz+Q8fIU78g1cg7V/o7IcsvMioLXSESNdJsDvLp9Js6NtMo+
        7abiat8+5onRqxv19Ap4A8wVFw==
X-Google-Smtp-Source: AK7set99wQ4PEjS+Hyco0N1NtEQe1E3IfSGA7oF7zVXuuGpkHqYsxoINr02VRnLzYQ8kSow9uXen6w==
X-Received: by 2002:a05:6a20:698e:b0:c0:d8e1:82ae with SMTP id t14-20020a056a20698e00b000c0d8e182aemr286322pzk.36.1676870262119;
        Sun, 19 Feb 2023 21:17:42 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm3192087pfn.107.2023.02.19.21.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 21:17:41 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 0/4] introduce tee-based EFI Runtime Variable Service
Date:   Mon, 20 Feb 2023 14:17:18 +0900
Message-Id: <20230220051723.1257-1-masahisa.kojima@linaro.org>
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

This version moves StMM related code from drivers/tee/optee to
drivers/firmware/efi/stmm, since StMM code does not contain
OP-TEE specific code and can be used with other TEE implementation.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
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

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  tee: expose tee efivar register function
  efi: Add tee-based EFI variable driver

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  12 +
 drivers/firmware/efi/stmm/mm_communication.h | 249 ++++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 620 +++++++++++++++++++
 drivers/tee/tee_core.c                       |  23 +
 include/linux/efi.h                          |   4 +
 include/linux/tee_drv.h                      |  23 +
 8 files changed, 947 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

-- 
2.30.2

