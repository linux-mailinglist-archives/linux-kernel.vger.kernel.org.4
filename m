Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17DD66E406
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjAQQs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjAQQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:48:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B441BAFF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:48:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g205so6875753pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwULElhPTzwU0Cn91yFb7oU/NqXKv5A/BuICJ7dBarw=;
        b=D3qBcSGY4pnz+IV+Rq/MlkNeGRLQX7tlJDfX6I5795w+2ZnWKerNBwdyLnM3yQbpvI
         +e/+uyko+k71WnxPGLS5VmfQuv85i5wXU7ptROYr17ufsMPDnJBY10mfVOSRkT1pk5KN
         25H22Fi+CtMLkhgU1bBBjq6yk/hMaJ8PdJRmpLD8YzNVIA3rFW3yddTViu9bXrNrpFFs
         g80Ej20m0L3ouV2UU+P9Qkjf8oCpM9B7H07mTvo6oIoiueiNGMNLaW3OpWlgKM2xUb7W
         sUx5hLODny7o+zFshRT0r+NiF/qN9HjpJl8lvCLW7w1AijZct38Z6nz+loaNqvjkxCRt
         2K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwULElhPTzwU0Cn91yFb7oU/NqXKv5A/BuICJ7dBarw=;
        b=NiC4vD1fRU6wtwLrbfsVoN5QA2UxiOeqoSjofP13/KVakLMRyfaC+42cipso+P+zpU
         UMq/yfQymF+FYLaKFajN065AGmEfa2mCUWUed8/6M2gNum99ANaNdLa66NKKnXDMirO8
         A7o06m3gF1Zs7dnJI+iRgdGKj8B9cplREicaxFwM99fpZl9q8iZ5f2LZFtoq+MRnJxR0
         iYTrz6NJ9xIt4OCp29UHSZjwKQhngdM/ML95Hn2Ot4YLU1FXQKOQZV0TYYiB5W//Xxpa
         6yxR8n0rfgkxih2RzTb8P9A4dcp0wou4C+NzUTLYeDHS8A3FCbqe+MJDTQzYVKzj4UJG
         7COg==
X-Gm-Message-State: AFqh2kqkL7zpkcU4jtCV5Mwqwb5pc3+bmLoOS74jZyCVYVtmUZ/NOopL
        QG3EIIzKXQgPuKjId+ZezQol0Q==
X-Google-Smtp-Source: AMrXdXvfI+bNX8pSPmRlAIN/95q/1EHqR4L7aYxetwfgCqF2PuOlKuv2jdtmNDatFJmd/G+2z9Kzxw==
X-Received: by 2002:a62:1981:0:b0:58b:be84:da12 with SMTP id 123-20020a621981000000b0058bbe84da12mr4148898pfz.17.1673974088013;
        Tue, 17 Jan 2023 08:48:08 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id x4-20020a634844000000b0044046aec036sm17519683pgk.81.2023.01.17.08.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2023 08:48:07 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Wysocki, Rafael J'" <rafael.j.wysocki@intel.com>,
        "'Huang Rui'" <ray.huang@amd.com>, <li.meng@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <sedat.dilek@gmail.com>,
        "'Jinzhou Su'" <Jinzhou.Su@amd.com>, <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com> <7964ec80-4d02-6c9c-ff9e-a6a8a0c427c3@intel.com>
In-Reply-To: <7964ec80-4d02-6c9c-ff9e-a6a8a0c427c3@intel.com>
Subject: RE: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
Date:   Tue, 17 Jan 2023 08:48:07 -0800
Message-ID: <004e01d92a93$79f21e50$6dd65af0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEknpZUEiBrgHDxpFXXuJtNDAGNIAJYvhVor/khjdA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023.01.17 07:40 Rafael wrote:
> On 1/17/2023 3:03 PM, Sedat Dilek wrote:
>> Hi,
>> I regularly test:
>> $ LANG=3DC LC_ALL=3DC make -C tools/ clean 2>&1 | tee =
../make-log_tools-clean.txt
>> This removes:
>>
>> $ git status -s
>> D tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> D tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>>
>> Checking the log:
>>
>> $ grep pstate_tracer.py ../make-log_tools-clean.txt
>> 89:rm -f -r   =
/home/dileks/src/linux/git/tools/testing/selftests/amd-pstate/../../../po=
wer/x86/amd_pstate_tracer/amd_pstate_trace.py
>> /home/dileks/src/linux/git/tools/t
>> =
esting/selftests/amd-pstate/../../../power/x86/intel_pstate_tracer/intel_=
pstate_tracer.py
>>
>> Is that intended or not?
>
> I don't think so.
>
> Doug?

Nothing should ever remove the intel_pstate_tracer.py source file.

Sedat, Thank you for your report.
I get the same results when running your test.

Note that I know nothing about Makefiles and such, but
think the guilty commit is this one:

commit ba2d788aa873da9c65ff067ca94665853eab95f0
Author: Meng Li <li.meng@amd.com>
Date:   Mon Oct 31 16:49:22 2022 +0800

    selftests: amd-pstate: Trigger tbench benchmark and test cpus

    Add tbench.sh trigger the tbench testing and monitor the cpu desire
    performance, frequency, load, power consumption and throughput etc.

    Signed-off-by: Meng Li <li.meng@amd.com>
    Acked-by: Huang Rui <ray.huang@amd.com>
    Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

diff --git a/tools/testing/selftests/amd-pstate/Makefile =
b/tools/testing/selftests/amd-pstate/Makefile
index 6f4c7b01e3bb..cac8dedb7226 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,7 +4,15 @@
 # No binaries, but make sure arg-less "make" doesn't trigger =
"run_tests"
 all:

+uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
+ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e =
s/x86_64/x86/)
+
+ifeq (x86,$(ARCH))
+TEST_GEN_FILES +=3D =
../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+TEST_GEN_FILES +=3D =
../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+endif
+
 TEST_PROGS :=3D run.sh
-TEST_FILES :=3D basic.sh
+TEST_FILES :=3D basic.sh tbench.sh

 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/run.sh =
b/tools/testing/selftests/amd-pstate/run.sh
...

And if I do this:

doug@s19:~/kernel/linux$ git diff
diff --git a/tools/testing/selftests/amd-pstate/Makefile =
b/tools/testing/selftests/amd-pstate/Makefile
index 5f195ee756d6..5fd1424db37d 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -7,11 +7,6 @@ all:
 uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
 ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e =
s/x86_64/x86/)

-ifeq (x86,$(ARCH))
-TEST_GEN_FILES +=3D =
../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
-TEST_GEN_FILES +=3D =
../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
-endif
-
 TEST_PROGS :=3D run.sh
 TEST_FILES :=3D basic.sh tbench.sh gitsource.sh

The source files do not get deleted with Sedat's test.

... Doug


