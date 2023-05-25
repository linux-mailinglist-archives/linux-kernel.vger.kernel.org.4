Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D805710D21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjEYNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbjEYNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:19:50 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828DD194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:19:48 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-783f7e82f2aso304069241.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685020787; x=1687612787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LxwYtGB9RBUo2ARBEDaRy/j62e5UsedQQydMRI+nQLA=;
        b=MMcqVtbtrkBNeoUv3HforN2Tm6L6iCwCIBv793tAV7Ufz+ANrbu/ezmTA7UZp8mXC9
         lH57eB6u4V4f3StbMW1WCizBsB+CJpTnCn7Yi/QsuWgeWKHxcF3/ELMDVukdHwpEu9qC
         Fjprx7sB6aEz6BcNaTkAwUDS7PmPBpQBTlHhiM0SFDFb1R9HC3uTuG8HjVOF0XVF1EM0
         BRUD0y7jNUgTE9+NGSGJ2FR9V/6ix5KcLWm8DH3hEN3Sjinzosx5kYKz9zIZ/cZemS+N
         klVuoSk/wGC1vBt0es3psdtY+hJkt7sQUMg8CViSOYXwXEq4rWbCK4RfyntGFTHYg8O9
         UHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685020787; x=1687612787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxwYtGB9RBUo2ARBEDaRy/j62e5UsedQQydMRI+nQLA=;
        b=LG+eiwZBPlU/gaNSbs3Lz0PxmuWEtNEBXjpWHlOe3VLXGbw6XYD3+Zm+Neuh2/+A5x
         1DTkBWbEUXBp+iyyFxj6MNwYwKPoQ/r4S0dlNsM2PRQmMonG6gHAVnTBIrVqF8MAFbyw
         5PFmGIPdGWNcFjGcEvFLELzR5fJwfrk+6ZdqNQXwQT2/6pFp4IWkLn1Vcz6470ibudgO
         XuPNBSxi9eJGiweSAHZf9Gg1rA+fXtOoMmO4nhv3ri4dNwPWUUSgADqSqyJdfYTWhLjA
         ut0Q2jU5IxuXL9lVypEOnPCyC1TRvgNyQeF0omp9lq8tcp+Gy4SzWO7+4/tJe1wk25Fi
         UhRA==
X-Gm-Message-State: AC+VfDy5MjGtWjrn5Y/fbltZiYarG1wk98jDjnKCrGM0VHyszJZLAF+m
        DHNJQTZw3ePjK8ke5oEti4/r59Dnlgj9CPnWAQBGxg==
X-Google-Smtp-Source: ACHHUZ42Drc7sO+IRPZGz/5d/uVry/K390ESSzAk3GBhH6r+qU6dbeXUk2WO+qVRetwGo9sXfBaagpUHwTE1H2R+ODo=
X-Received: by 2002:a67:cd82:0:b0:430:2d04:4691 with SMTP id
 r2-20020a67cd82000000b004302d044691mr5130904vsl.23.1685020787396; Thu, 25 May
 2023 06:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck>
In-Reply-To: <20230516134447.GB30894@willie-the-truck>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 May 2023 18:49:36 +0530
Message-ID: <CA+G9fYtZjGomLjDi+Vf-hdcLpKPKbPmn4nwoPXvn24SG2hEJMg@mail.gmail.com>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in fpsimd_release_task
To:     Will Deacon <will@kernel.org>
Cc:     broonie@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, 16 May 2023 at 19:14, Will Deacon <will@kernel.org> wrote:
>
> Hi Naresh,
>
> On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> > Following kernel BUG noticed while running selftests arm64 fp-stress
> > running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.
>
> Is there a known-good build so that we could attempt a bisection?

[ Sorry for the delay ]

Since this problem is intermittent, It is not easy to bisect.

On Linux next this fp-stress BUG: has been happening *intermittently* from
next-20230314 dated March 14, 2023.

On Linux stable-rc it started happening on 6.3.2-rc1 and 6.1.28-rc2.

Here is the proof showing the intermittent occurance on Linux next,
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230518/testrun/17066471/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/?page=3
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230518/testrun/17066471/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/?page=2
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230518/testrun/17066471/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/?page=1

Here is the proof showing the intermittent occurance on stable-rc 6.3 and 6.1.
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3-rc4-1628-g48aa7b4284af/testrun/16730800/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.22-1202-g2b7e1f92aa55/testrun/16814751/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/history/

- Naresh
