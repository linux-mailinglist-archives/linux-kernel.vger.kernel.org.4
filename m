Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7414D6B8FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCNKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCNKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:23:28 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D909BA5C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:22:56 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id s23so10183088uae.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678789375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oK6l1bLYaFxR9jVa3Sb0b7gfGtMaLgpY33m0htG6rbI=;
        b=qAujV86UmC0NGw1Dtp+ks5Kkvw0sAmpu4k5RJs+CgI9NiKjNTCQm85QaTy7hj8l8li
         Xz2eBYt5pG0VMBC4C1pWsslZpUACSnplxf6DzTBH3z5YRtB5vbtmx+ddOF6T1ALCs9Z7
         SUcMt3t6fAUaLUr0E87yIFc5SH0xPZMf4qMYRlzmhPQI3qFIrOxFZUJaczbf7HInkDdC
         B+obj5Wq6p90KHwSEZBTWvlkXbXHmbhigX3n+Nps2zYBBx5yfyRUrtMR3w4YRHOtKk+f
         gg/jeGowVu4OP175v4gCgoqp8Vw2g3VU9LJaHuxt7unhbBxndDnJZUvT+MXGRn69h1XC
         sVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678789375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK6l1bLYaFxR9jVa3Sb0b7gfGtMaLgpY33m0htG6rbI=;
        b=GAg1AayBvIb+XYdnbfR/8wIrSqy0bpCj1kVAnOo0lQiCJO/HI9GpjaBh3gTAj+jPmJ
         DXJmHg6s31KFsxzcIIbVU1btEEcyatMBwZv/sod3mxo/hSChX/bcbSvvNf2K+/Rs6yKz
         Q2VHgMQJ+n/nhRgkpG+CM8FCJso7TXdHuN1B6UIMSsKkrjjmK0M/EPBdVM0GSZcRjQaN
         TQkCFd3uFWqNT+eG+Wx+IhjGjsqYXstRza9sFS18jLaz2syB/MZ8rsnhFKEowMRAfCgZ
         XiZiiZuSjoX0a0ToOGf7j3k7N9uydaWZC3GYtA/TK8Urqaio9dKlmaf/werTTFhUDDCV
         31CA==
X-Gm-Message-State: AO0yUKXDjmzQpC7pp70sVSC0/dwdAsAvGTUAkbfG7xj9cQjTQiX1mFHN
        5EWNEM+b1i0lTFZ1OwDuhAdFtJyIVmTt0BmcM2ucI9CTP7AIqVLbAekeZA==
X-Google-Smtp-Source: AK7set8hMUVOa/qYE8BdEgeaQtRuTH3svAjQltS166F8lAkGHwHJevtx5wqU7pymCMpPOF1NLi8bpKbTkfXr41b8ZMY=
X-Received: by 2002:ab0:5402:0:b0:688:d612:2024 with SMTP id
 n2-20020ab05402000000b00688d6122024mr23748723uaa.2.1678789375323; Tue, 14 Mar
 2023 03:22:55 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Mar 2023 15:52:44 +0530
Message-ID: <CA+G9fYtF-XEKi9YNGgR=Kf==7iRb2FrmEC7qtwAeQbfyah-UhA@mail.gmail.com>
Subject: selftests: ftrace: event filter function - test event filtering on
 functions [FAIL]
To:     open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.

selftests ftrace failed on qemu-x86_64 and qemu-arm64.
Please find the test log below.

Is this expected to fail ? Am I missing anything ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

kselftest: Running tests in ftrace
TAP version 13
1..1
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check [PASS]

...

# [23] event filter function - test event filtering on functions [FAIL]

...
# [58] Kretprobe %return suffix test [PASS]
# [59] Register/unregister many kprobe events
[  431.662904] trace_kprobe: Could not probe notrace function startup_64
[  431.669846] trace_kprobe: Could not probe notrace function _stext
[  431.674104] trace_kprobe: Could not probe notrace function _text
[  431.675908] trace_kprobe: Could not probe notrace function
secondary_startup_64
[  431.677876] trace_kprobe: Could not probe notrace function
secondary_startup_64_no_verify
[  431.679899] trace_kprobe: Could not probe notrace function __pfx_verify_=
cpu
[  431.681738] trace_kprobe: Could not probe notrace function verify_cpu
[  431.683667] trace_kprobe: Could not probe notrace function
__pfx_sev_verify_cbit
[  431.685594] trace_kprobe: Could not probe notrace function sev_verify_cb=
it
[  431.687381] trace_kprobe: Could not probe notrace function start_cpu0
[  431.689225] trace_kprobe: Could not probe notrace function __pfx___start=
up_64
[  431.691223] trace_kprobe: Could not probe notrace function __startup_64
[  431.693088] trace_kprobe: Could not probe notrace function
__pfx_startup_64_setup_env
[  431.695021] trace_kprobe: Could not probe notrace function
startup_64_setup_env
[  431.697012] trace_kprobe: Could not probe notrace function
__pfx___traceiter_initcall_level
[  431.700780] trace_kprobe: Could not probe notrace function
__pfx___traceiter_initcall_start
...
[  439.183587] trace_kprobe: Could not probe notrace function
__pfx_hv_check_msr_access
[  439.186192] trace_kprobe: Could not probe notrace function
__pfx_kvm_hv_flush_tlb
...

# [106] (instance)  event filter function - test event filtering on
functions [FAIL]

...
#
# # of passed:  109
# # of failed:  2
# # of unresolved:  3
# # of untested:  0
# # of unsupported:  3
# # of xfailed:  1
# # of undefined(test bug):  0
not ok 1 selftests: ftrace: ftracetest # exit=3D1

log link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230314/te=
strun/15564370/suite/kselftest-ftrace/test/ftrace_ftracetest/log

--
Linaro LKFT
https://lkft.linaro.org
