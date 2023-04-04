Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F016D58C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjDDG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjDDG1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:27:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823B138
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:27:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so41041426lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680589650;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeGOQuK/PqzO98tcIpRjRjtyM7MAYGn7fx/rVzbfxbA=;
        b=EjTKQSWArVmGJn07Bgb/RFPq5OzTe3ynIe2RyF5sF6J6Zu9Hd0vb7aD+HRM8iAcVvO
         4SvVFyxsHSrUb6S33xnWPv9ocTxqDRvt9PRAvwZxOxhYWwgpdvxlgfhlPqWvSI24ldza
         AhFjvGx8lBjyhJfAeIap4dVjqK7hI1MXX3uST5UYCTd39PcfM/1XBT4yfGhp4XhS2XK5
         Tm1lp/aV32UX73s9Ygr41J2Id0nRyaXcdhOfXqfRJAuyGBbQ8h1kqI/LsfJfKpqlDKWF
         ygaY88FBUb5UeEhZ+eWID0wdxF/fcoivqeMvyONaS6BB9172Rlod8RiuGEFkcsYjhujX
         wYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680589650;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeGOQuK/PqzO98tcIpRjRjtyM7MAYGn7fx/rVzbfxbA=;
        b=NUxdshlU8RVnUnK6ef7dfui2nJa3UO6FSUn49kh94tEifI4v2CSB3D5+83hBPqS9WX
         jMaEfoakWVOns2ACkqAByM02O/jZ1Sz7jD6/2XCcudAs/N9diQViih9IkqnKnUYsKgS0
         7NzeedAWjL4NhMw4q6tiquwhTS0ecD9Q7leWgJptPWN32nGS0lGIoOEYIYOTBqLk7/OR
         +z/QfnfCDfcTYMJrSWCrD/bvBCUvzegjpXhq7jLQRZ5ICBTx13eX6iKxYWRZtVLv3b5P
         18vLmhsfTTOl2/fh1ZuApldCPY6MCvbppGvTbowVjahIuF/XdSjFiYQ9Gec98quEgLgn
         rpDA==
X-Gm-Message-State: AAQBX9dLF/KLQZvRpJVNKE8lMqH3s40EsSjqei80fd+2MdHtHTmPzgGJ
        GCr/M/UTM9XB2MLmD++5WMRDjBZJAUiX9To1nug=
X-Google-Smtp-Source: AKy350YiC2UwD4PywR32gwG+CKVshieQmX+ZaOSzlwo9nQhlBMJAJK90V5UaCUIkUF7iWuYN7em4AQ==
X-Received: by 2002:ac2:4911:0:b0:4de:7a23:23e2 with SMTP id n17-20020ac24911000000b004de7a2323e2mr308513lfi.21.1680589649762;
        Mon, 03 Apr 2023 23:27:29 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y27-20020ac2447b000000b004e9b183fc5bsm2157556lfl.8.2023.04.03.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 23:27:29 -0700 (PDT)
Date:   Tue, 4 Apr 2023 08:27:27 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [GIT PULL] OP-TEE per-cpu irq for v6.4.
Message-ID: <20230404062727.GA2765560@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these patches which add support for using per-cpu interrutps
to signal asynchronous notifications from OP-TEE in secure world to the
OP-TEE driver.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-per-cpu-irq-for-v6.4

for you to fetch changes up to b3b4ced12c1bc829888803ce07fff317e590ec1c:

  optee: add per cpu asynchronous notification (2023-03-30 08:27:05 +0200)

----------------------------------------------------------------
Add OP-TEE per cpu asynchronous notification

Adds support for signalling from secure world with per-cpu interrupts in
addition to edge-triggered peripheral interrupts.

----------------------------------------------------------------
Etienne Carriere (2):
      dt-bindings: optee driver interrupt can be a per-cpu interrupt
      optee: add per cpu asynchronous notification

 .../bindings/arm/firmware/linaro,optee-tz.yaml     |   3 +-
 drivers/tee/optee/optee_private.h                  |  24 ++++
 drivers/tee/optee/smc_abi.c                        | 122 ++++++++++++++++++++-
 3 files changed, 144 insertions(+), 5 deletions(-)
