Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99677092D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjESJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjESJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:17:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF6E47
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:17:32 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-437d6a60763so448389137.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684487850; x=1687079850;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EyqtzOzYWX6JRvNob/w8wtaOTH2ZW4ullCjMcrbQt84=;
        b=zRvxgZdjVaC0wM7XeeOgxt3NbiwlmT38GWMl7PWKSG8f8T5z0tfKB4I+487Wu2J2QX
         wCM9NlgvLUbNa/Gd+DZ+JADCVilNLsLZXRrZ01Zmo8fVvYyPoFgJI9NNcoRg/1ulgBe2
         el4DzrArMkz3HcYzEt1DnIKv9tacor94bK/6YevcX1tZEFtrxMX7f5zX17tKFl5VCUZK
         XwdemgLE2M6x+jilv0YwN4RGquzszXM/9zgk/zUJwUBY8BchRJgdV5aBqcLUJdDKY05X
         zLx7Ey/H6lhBRjv2lHjBMxt96U2DwuWhZAgQFgnnJR2N7dw2gyeAX87nch5wOOTmhoiI
         +k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487850; x=1687079850;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyqtzOzYWX6JRvNob/w8wtaOTH2ZW4ullCjMcrbQt84=;
        b=ePZHCiRDq6YBAjj8m+I/JL7rN9BLe3O6bosUVBOaWTaCZwD79q36+ZCfKxigTUYckl
         tkTcPCHggwU9zWqqlE1siXud2nEinMVCuxkYIr2c4F0k83ZPnG5cpqs6jnz7zGiIBpg+
         2NAvUO/DS9wJ/E+vTzub/KCBD0jHNV0gIv7D/rrOCv4TbGcQEy1dSaoVCeaxW/FuF4Ar
         20QHrVYnrSDZIWF47uS3G0ygXcE68BZePHuAadmIVRC3rnWF9c5L9kAlgKKI7Ha/Mjin
         QAlskXlrIz1wd3w7LIqNeuZeq2Nq0vW1zI8i+d38O+mzT3I7xl+7eNV83iUBsJvqvUAh
         LRPQ==
X-Gm-Message-State: AC+VfDzXA6h44fYAW2yd5q0CWTdg8eDFY1eIaFrmBtaB+yg3WBv2hlZl
        7HBjKB7SfY4iaHDnxrzNS8n0elaWYt8waCkroUpfTHIkLZX7dLaSr9VQGA==
X-Google-Smtp-Source: ACHHUZ7qIUMxdpZJ/pPArQrhJcxkdOvkT3Ni6MqkUJEeHYxiqb4zb7qGxo21gCQCJ9cJcpOHDYckJB+fo+0hATp9r2c=
X-Received: by 2002:a05:6102:1521:b0:42e:5b08:ec71 with SMTP id
 f33-20020a056102152100b0042e5b08ec71mr900473vsv.11.1684487850295; Fri, 19 May
 2023 02:17:30 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 May 2023 14:47:19 +0530
Message-ID: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
Subject: LTP: shmget02 fails on compat mode - 64-bit kernel and 32-bit userspace
To:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Martin Doucha <mdoucha@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP running on compat mode where the tests run on
64-bit kernel and 32-bit userspace are noticed on a list of failures.

What would be the best way to handle this rare combination of failures ?

* arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
    - shmget02

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
<4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
enough memory for the allocation
shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
EINVAL: ENOMEM (12)
shmget02.c:95: TPASS: shmget(1627422610, 4096, 1024) : EINVAL (22)
shmget02.c:107: TPASS: shmget(1627422610, 2048, 256) : EACCES (13)
shmget02.c:107: TPASS: shmget(1644199826, 2048, 2560) : EPERM (1)
shmget02.c:95: TPASS: shmget(1644199826, 2048, 2560) : ENOMEM (12)

logs:
-----
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16880333/suite/ltp-syscalls/test/shmget02/log
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16880333/suite/ltp-syscalls/test/shmget02/history/


--
Linaro LKFT
https://lkft.linaro.org
