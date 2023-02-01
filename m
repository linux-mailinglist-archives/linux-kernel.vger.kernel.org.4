Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB968654A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjBALVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjBALVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:21:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790410C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:21:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so1653436pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 03:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To8dIB5BFykLmRsvemQjsPLonG1CxMfjfObIAxtKKNw=;
        b=OXCTpSIeFsm3GkCKGqQ2B+LPsais089QVJRWCB+2umVwj3fsTsmgLCu1UeeYjVsDO2
         0MFNXjR0pZ7h/bTeSny4oHB9jVgekH9Ku4V8TKeVlbsMUJTc+NWszWK/SHEGOnI5HwUN
         9bHEa2oDu69VduKXvFnZ9RMkAFXqAC4lBof9798mgGvq7pxR0xl8JVnb4zShC9WmmCP2
         F+uf8wnezih844uj5WkXPrvlgSCVZmiuj5oJbhymmBKfliJZS6WCtCv8i8PG1pINkLBM
         NQgsi2thbLt6AAUwXSGvZHNHs+ttDhRRtL5kexAXbh7Xs9QWIt3mzZdns89Xy2caIbXL
         4tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To8dIB5BFykLmRsvemQjsPLonG1CxMfjfObIAxtKKNw=;
        b=mdzssTHxNg6o/50kBPbokWaWQ+agWpnA04X1/awMORJEks9Ok0mXra8zvhBDoh6hna
         mp4rjI4aKFEZVCYAaFnQSFAv78rs3qrA0Dfmou8EBGivCpp8gdWEHHmGVb4J0Dl+K/UI
         o5r0VQTo/XvfqgDGaIJ86nmYpgxK+UV0tZnAXfajzh4kIbJaYH5nYxiNyxkvIRPe8dJH
         bx4ZCDu+nelpwKO07JabnsDhhlO9xaLwKgulxuzm5FnA4NjvR4qIpx2ETKA6QfOhLb5Q
         qmkbIUzib8CB4LYQpuaeVc6bHzkXhxvL5rzfL7m2dCYnEA6Cr3fcuXr3nhAq5BEicIx+
         /qag==
X-Gm-Message-State: AO0yUKVBvKjcBrgtluB2Ru8oA2nICqReYp8nJk9dzjd+OrH/FXvUlp13
        LLhKTv5yGHvNKekEOMwKYpbUcLnOTE9x40av
X-Google-Smtp-Source: AK7set8Ll6XSvaMvmf+XfDmbU6Xx676TNNIFNQzp1+gBqTzmDEGbxHJjoE+AsId0LLUBhCjVypEqgQ==
X-Received: by 2002:a17:902:d508:b0:198:b945:4107 with SMTP id b8-20020a170902d50800b00198b9454107mr139015plg.65.1675250489025;
        Wed, 01 Feb 2023 03:21:29 -0800 (PST)
Received: from localhost.localdomain ([124.123.179.186])
        by smtp.gmail.com with ESMTPSA id jl16-20020a170903135000b0019719f752c5sm4884910plb.59.2023.02.01.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 03:21:28 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, arnd@arndb.de,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 15/16] driver core: make struct bus_type.uevent() take a const *
Date:   Wed,  1 Feb 2023 16:51:22 +0530
Message-Id: <20230201112122.16098-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111113018.459199-16-gregkh@linuxfoundation.org>
References: <20230111113018.459199-16-gregkh@linuxfoundation.org>
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

Following build regression started from next-20230130.

Regressions found on sh:

  - build/gcc-11-dreamcast_defconfig

drivers/sh/maple/maple.c:785:19: error: initialization of 'int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=incompatible-pointer-types]
  785 |         .uevent = maple_bus_uevent,
      |                   ^~~~~~~~~~~~~~~~
      
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230201/testrun/14479366/suite/build/test/gcc-11-dreamcast_defconfig/history/

The bisection pointed to this commit,
  2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")

--
Linaro LKFT
https://lkft.linaro.org
