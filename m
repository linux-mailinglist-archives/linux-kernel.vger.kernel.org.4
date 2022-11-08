Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8183A620D46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiKHKaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiKHKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:30:10 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755D1DA67
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:30:08 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k13so13026363ybk.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c0t8MRtYwKPYmHc+uFj52fT/0bK2RxKS/AKiULktAkE=;
        b=ej6taqjjpNtiP/HV1iWwTEXhdg3YYHb5FtJY3uGIoKr0q09kdSMWcHz+JEDomGIjiY
         Wo7kDx7DZw7tO5qo83tNgNripoyCRQQwUDh9efq154InwJDMCidImzGI6boWAzrAOrG/
         3008tHshnyyIJOi2rS4Ptdjx1RvaPFtdsnaU+qXAbCwWuoCLXBkW1zTAYqCrGmU3Va9h
         IEUqIB54EELVw9WnK5RwX2mVFK/HGcyGag8rET7wKeVOxarxgHJKYe0QA5aSnh86SMT2
         /70dWyDPYpMnm90ZCtM3Y9h539YZRc95j7W3ud2wn2/xckyFXe1QMJ24pwsBWramSvtF
         PcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0t8MRtYwKPYmHc+uFj52fT/0bK2RxKS/AKiULktAkE=;
        b=sSp8ZCNpoxEHzqsb6UdtAR1vOVFVUgOqWNoJ2/F0tBQb7U/0eGWCGO2aYdRTAaLKA1
         +6yO22GjN0MmTefiDYORbBsGloXT5a0Kv0eiEYX8FDefvBPM/E6GyyRRLMqQd6M0sCaT
         dnrKvpgX5JjvhBHfSffGGyeOlQrvFmfdRaM2KY/wm+Y8F3nG/g6Sp7eFLP2wdzyP68RS
         I252N5W6gf0sqBY6TxKICGfDVh0WY3bMIYyCJi2GEgwYLGAxJV4MvYp8yWUgif/N1Oqb
         8V01aM8SrtJrRAYvwkKE3y0JW1otAcePbM+zICbOSGWu1U74Z+UcOsJ+alvZ1CfiPoWD
         sUKg==
X-Gm-Message-State: ANoB5plIC7AJ2Y/1CP4ZFAGjDJVCP8/dmnSP7dqJByROF5Nd4WD1LVRO
        151W98+im/jWfOe2mAQmfm6ANlxrU6rB4OeOQurlBLJ3D+y39Q==
X-Google-Smtp-Source: AA0mqf5Q6IpJPWPDtxNUT69YjRnDlcsHE6zOJaVsznPVdqxOBpw3UYzyyFZiFhU0xjeM7sXKZflzX0lsU9sXiL4He4g=
X-Received: by 2002:a05:6902:b16:b0:6d6:9455:d6c5 with SMTP id
 ch22-20020a0569020b1600b006d69455d6c5mr11867369ybb.164.1667903407271; Tue, 08
 Nov 2022 02:30:07 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 15:59:56 +0530
Message-ID: <CA+G9fYtLoBo31wRD=+Q8DfO36OGBACp2GY6xvyj8CmUk37rbuA@mail.gmail.com>
Subject: selftests: clone3: clone3_cap_checkpoint_restore fails - Could not
 set CAP_CHECKPOINT_RESTORE
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests clone3 cap_checkpoint_restore fails on all devices.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[   97.198602] audit: type=1701 audit(1651167820.383:12):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=1732
comm=\"clone3_cap_chec\"
exe=\"/opt/kselftests/default-in-kernel/clone3/clone3_cap_checkpoint_restore\"
sig=6 res=1

# selftests: clone3: clone3_cap_checkpoint_restore
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.clone3_cap_checkpoint_restore ...
# # clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child
has PID 1733
# # clone3() syscall supported
# cap_set_proc: Operation not permitted
# # clone3_cap_checkpoint_restore.c:164:clone3_cap_checkpoint_restore:Expected
set_capability() (-1) == 0 (0)
# # clone3_cap_checkpoint_restore.c:165:clone3_cap_checkpoint_restore:Could
not set CAP_CHECKPOINT_RESTORE
# # clone3_cap_checkpoint_restore: Test terminated by assertion
# #          FAIL  global.clone3_cap_checkpoint_restore
# not ok 1 global.clone3_cap_checkpoint_restore
# # FAILED: 0 / 1 tests passed.
# # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1

Test details links,
https://lkft.validation.linaro.org/scheduler/job/5812724#L2074

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/tests/

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_cap_checkpoint_restore/history/

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_cap_checkpoint_restore/details/


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: d8e87774068af213ab5b058b1b114dc397b577aa
  git_describe: next-20221107
  kernel_version: 6.1.0-rc3
  kernel-config: https://builds.tuxbuild.com/2HChVOSNxUpvfAfLTnaK7zyTdUi/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/687092361
  artifact-location: https://builds.tuxbuild.com/2HChVOSNxUpvfAfLTnaK7zyTdUi
  toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org
