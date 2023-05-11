Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724456FF1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbjEKMnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEKMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:43:18 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3AA4C39
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:43:15 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4360e73d0d4so2566228137.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1683808994; x=1686400994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc4TG/e8NTwXjjYtMMN70anYqnJTjgk3/xcobt+webk=;
        b=aNc1dkG0RMJEXhOtmHTOutlIkXZRjlKU8wzGsMrWh+1/bpZ9Ht6yx5MREwp/LkH5JE
         PhLLdRSCx77/l45wiIekoD8va8ahZL6OIPKwJOWFvNHCARgTiYgD4TprQ0F4539tSGtu
         MLndSaNme+ZvnUaRwjrdW5dXpJx8kQJGGebs8A7fST5L4rVTyNZFDctiemfg6cKMW3FI
         3VLTu0Onb6WKNdJrHI5FwbA+W29XIlLcG5qwYs/EtN2XsTtEhrowyaIJD/mJX9gU4FWs
         /D0wvSuXXlPpbn04spOSbbXBYwO2ZDYmnZWXs2EoXDGyKyphJw93lQ5ocMgw+sO2Ov3I
         jH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808994; x=1686400994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jc4TG/e8NTwXjjYtMMN70anYqnJTjgk3/xcobt+webk=;
        b=BU2NU6VvdrtSzz9x8MRso+pTSYUAxnFP5w+IdyGOGEfyjsbgAWGQ+tzrppJW90Js3O
         omSMHrGU6Fva6dttwc/kKANN75Xy3AmDVjGipCreuRSxUrXL2iblTKzwtc4hBGFcZP69
         kd3qZp5jEpbux51vHqfVCHToWQ9yMB3vqwZCAcsqyOgh/AVGVS6XpuaC1SCOWiKe5PG7
         K8XTmx6d1IDhBw1FpZ0Chpm5DJLxIxrsqO8c2p9A/gCZ7//g4H0uH6VoJ0aFRPtnEQev
         EZG80kHP4PRVfTymCsvi5CwoGh8TFh0P7Btr9EtvFPRd0LuqRk1ZJs4SvYU6/ItybjXJ
         4lLQ==
X-Gm-Message-State: AC+VfDzKWIEVKZwDIDSqkkRcup4IkjwEIoNL2nZX6AsVdG1QZC4FDsn0
        ezoZ7R63rJ/s3FmUSA7FoJ3/txJjlu78dBkiSNXL2w==
X-Google-Smtp-Source: ACHHUZ4npqirNcTYWVQyZx0Yvg4ZmtVZnpcgNx1G5V0A9Urqjcw+ydi8ESzpy0ob2Z2c09L1mbaKhxgLPTeRYMSlcM8=
X-Received: by 2002:a67:e3bc:0:b0:42f:78d5:d987 with SMTP id
 j28-20020a67e3bc000000b0042f78d5d987mr7041065vsm.1.1683808994426; Thu, 11 May
 2023 05:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 11 May 2023 14:43:03 +0200
Message-ID: <CAMRc=MeugGZmPxrezTxRR4CiiULeWZjsmdJbQEPq159mWfEVTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] selftests: gpio: gpio-sim: Fix BUG: test FAILED
 due to recent change
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 7:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>
> According to Mirsad the gpio-sim.sh test appears to FAIL in a wrong way
> due to missing initialisation of shell variables:
>
>  4.2. Bias settings work correctly
>  cat: /sys/devices/platform/gpio-sim.0/gpiochip18/sim_gpio0/value: No suc=
h file or directory
>  ./gpio-sim.sh: line 393: test: =3D: unary operator expected
>  bias setting does not work
>  GPIO gpio-sim test FAIL
>
> After this change the test passed:
>
>  4.2. Bias settings work correctly
>  GPIO gpio-sim test PASS
>
> His testing environment is AlmaLinux 8.7 on Lenovo desktop box with
> the latest Linux kernel based on v6.2:
>
>   Linux 6.2.0-mglru-kmlk-andy-09238-gd2980d8d8265 x86_64
>
> Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  tools/testing/selftests/gpio/gpio-sim.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/sel=
ftests/gpio/gpio-sim.sh
> index 9f539d454ee4..fa2ce2b9dd5f 100755
> --- a/tools/testing/selftests/gpio/gpio-sim.sh
> +++ b/tools/testing/selftests/gpio/gpio-sim.sh
> @@ -389,6 +389,9 @@ create_chip chip
>  create_bank chip bank
>  set_num_lines chip bank 8
>  enable_chip chip
> +DEVNAME=3D`configfs_dev_name chip`
> +CHIPNAME=3D`configfs_chip_name chip bank`
> +SYSFS_PATH=3D"/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
>  $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank=
` 0
>  test `cat $SYSFS_PATH` =3D "1" || fail "bias setting does not work"
>  remove_chip chip
> --
> 2.40.0.1.gaa8946217a0b
>

Queued for fixes. Thanks!

Bart
