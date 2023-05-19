Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90147092D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjESJRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjESJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:17:37 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0774E75
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:17:33 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-456f19307f6so503059e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684487852; x=1687079852;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FjkRsaO51J+3h62ljii2sgaVK4RT4W9ZpTfAcGqp1pg=;
        b=q982RWsrY//sxZXwnVuCUIoDXyNwhOtyjSNdroAGncPmIatXf2X6FBJxj0RsCbzOr8
         PQhA9R3Ec4/8zyOkNse/4qWIL1q9qkqPvfv5UcsKswD9EaqI0mcJhI2J8K3DwUBQQhGi
         4EQi7mDme6k522YLsoCpU12Ysp0nbGZqgnV8/IGBt0lJLYAPHf5GJjdkzmYCVpZbiC3D
         Pxv2CERstitSHawdj+6hjn7KqWQTusyRevJIzKgwBydZv96sk8AZ70LGs9JgNFlTyvG8
         jnJm9mSkSVY4NoajpnbDw5F9GeLwoheTmEt3il/W8K+W7cKYjNKzGN+TpoFVrlNhfY+5
         dPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487852; x=1687079852;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjkRsaO51J+3h62ljii2sgaVK4RT4W9ZpTfAcGqp1pg=;
        b=WlKfqfI2pfHjoOBE+kETbzxsqmZmz2kLwmyduMqlGTplevkqCdE4ZyAED8Or8Nkri5
         VLxFBWEW0pAduBUnzTqpZWoqiwV37ujyFlN5h9GcrLqqJxfcVN5qIiLMn/6yyZZY9kJt
         BT/epr7yapUh96A7u+GEp+Rt0H7KpkFc+W2QfVC95/1FsNJPoJEH1UpCJHupJb0IEaLq
         kj7NqPGq8/Ax+yvBTox3Tsdel7x/vZKcbq4Q/XoGaJI3GPvcaE5nhQIPbvwvzWV1YefX
         pIxxWVkLO6iy3Bn3HAmxfGoosEKmfy8YNyhfZCbLLQTr6clqtIC/R6ZWIc61L42f/UW/
         KEfA==
X-Gm-Message-State: AC+VfDzRqxwTrYPR9CP1aSGp0H0Xrq8Q2w+EZGtkh96HonNdqS6z3lJd
        ZuitHzro+aQ95Qn/lvLnQ0ZV9FkBzWecJvIWL399Jpj8/8K7FRKmJEdUGw==
X-Google-Smtp-Source: ACHHUZ6FIvI8GJGjhJKl+w6GLlSXbVimRzZmRuLgK82KaqjxlnxJtZrYpsZP2DgLh3JBOcPn7qFNq8Luweco+Xkd/BM=
X-Received: by 2002:a1f:3f03:0:b0:453:8f1c:eb31 with SMTP id
 m3-20020a1f3f03000000b004538f1ceb31mr278701vka.14.1684487852406; Fri, 19 May
 2023 02:17:32 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 May 2023 14:47:21 +0530
Message-ID: <CA+G9fYs-Bc6wZKx+Fz4gFBQhkfRi+pQCnij5Kh3zhHU31mmGgQ@mail.gmail.com>
Subject: LTP: io_uring01 io_uring02 fails on compat mode - 64-bit kernel and
 32-bit userspace
To:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        Anders Roxell <anders.roxell@linaro.org>,
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

* qemu_x86_64-compat
   - io_uring01
   - io_uring02

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
io_uring01.c:80: TPASS: io_uring_setup() passed
io_uring01.c:89: TBROK: mmap((nil),388,3,32769,3,0) failed: ENOMEM (12)

tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
io_uring02.c:213: TBROK: mmap((nil),18752,3,32769,5,0) failed: ENOMEM (12)


log:
----

 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16883235/suite/ltp-syscalls/test/io_uring02/log
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16883235/suite/ltp-syscalls/test/io_uring01/history/


--
Linaro LKFT
https://lkft.linaro.org
