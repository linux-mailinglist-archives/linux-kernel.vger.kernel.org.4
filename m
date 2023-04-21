Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA56EA55F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjDUHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDUHyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:54:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60349764
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:54:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4eca19c3430so1391332e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682063686; x=1684655686;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Wh8weJt8MJNcMpPGqSo6AWzC32rS1+vzeDVd0dv2ds=;
        b=XPy9s7e65qNm1qT8IKSzdOZynHmkmK2kk+w8/KWnOOgWpy3HBEWVT5FUMIj3jFRbxk
         khx7teJtwYgv9RvV59C35bLiVrLQXxfGwRCTVC23bGyfQv6joyZK2Zbrq877pxVezv/g
         9TVLnWT8/FW68M19ulsbjB1lcYQeYdLTKBF7zTaELfhXhknMl6N0zayIovgS3v3vWj7z
         ruTlMEd8cZ+EpYh0hUmDdULpDm4YfhDkPN7aVMjMabbXfMr7x2pHgkJzTTWU9Z8dWfCP
         cdKHq0Tt56ykzAq7CMdPSppF42JipVMrL3cViihUgLrjsdFFDihEAzb8zGOTQBcpRY+L
         nWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063686; x=1684655686;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wh8weJt8MJNcMpPGqSo6AWzC32rS1+vzeDVd0dv2ds=;
        b=a3JQwgAhZB1/pfdwHWumAkEI7wZ/+PpkwgRVAyQ67cZdPEPjUXPlnp98NWl3UgqOdv
         +6VnRqKc1ekTUzluRnkQ6F/TgjdYTVlQ0h/L0VgJieUYLlAks5gmueOvXJeMgalS4kti
         qgfdc78kexNa2ywe5QrJ0V/4PDCBaYtQm0AL50ZWoV08PT/FKCUgxwiijhDQqWtmnnP1
         Gx2r4I2LKE4FnQu+PY8m+SBwrCvt+59E8rT7qM8zZJ1/BoO6VwkLE5B96ZEHGarH2dZg
         QbcsMHsSbWzs4mxMafbRLH2o3BVu5AhtI4qaANjbHwyFrLarXFJv1x8ZK0ar31fZGYZr
         vuTg==
X-Gm-Message-State: AAQBX9dAzF86YiNYTGXyKPai2IgKgBj7CW3sJX/hUrpV02gpHgpDOvVg
        l+E4JCGrrIwVPKs6oJT1DDpE6w==
X-Google-Smtp-Source: AKy350aI/gfjWYMEX8FEBnMG6f3jPDPE7j076Zv9ZCwKRsCe4qJ2vPd/M/ZRqyYyhzSMb6wODl0MSA==
X-Received: by 2002:a05:6512:64:b0:4ee:d8f3:1398 with SMTP id i4-20020a056512006400b004eed8f31398mr1149093lfo.68.1682063685701;
        Fri, 21 Apr 2023 00:54:45 -0700 (PDT)
Received: from rayden (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm470622lfn.216.2023.04.21.00.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:54:45 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:54:43 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix uninitialized variable in OP-TEE driver for v6.3
Message-ID: <20230421075443.GA3136581@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch fixing an unintialized variable in the
OP-TEE driver. The error has been reported recently by the kernel test
robot.

I realize that this is late for v6.3, please queue this for v6.4 instead
if v6.3 isn't possible.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-async-notif-fix-for-v6.3

for you to fetch changes up to 654d0310007146fae87b0c1a68f81e53ad519b14:

  optee: fix uninited async notif value (2023-04-20 14:52:25 +0200)

----------------------------------------------------------------
Fixes an uninitialized variable in OP-TEE driver

----------------------------------------------------------------
Etienne Carriere (1):
      optee: fix uninited async notif value

 drivers/tee/optee/smc_abi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
