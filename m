Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24795638F41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiKYRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:42:32 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C50AB69;
        Fri, 25 Nov 2022 09:42:29 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id s4so2909522qtx.6;
        Fri, 25 Nov 2022 09:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd7JLS7K2RX5uhImtxN5fxn5NCVFRhRNnrf3mNn1ihY=;
        b=2yvKlzN+AhaosmP2s0Q5dgwXdTTgtnfxNxpoBVt68B6B1k3tNmXW42aCjZvtfO7baV
         0DcqqZb6mQxYmvDWbdAEVcwhd9OFyNA6ky/77cab1KyUBgmC1km+xHkauKs60HmzlXR+
         AQj3XW8zXFdlOhpcGAEkH9KBWNGFeFJXo5BqD9FXHPQyA6ic22JAJPy4r02HD1k8ZxKi
         TPlkxOCXDvWx5RDKsyIzJtfyM/0ICu0/FcRWd7hIpv1uLzfjj6aIdIbjrp5TFoeBbHNa
         7IgJz4OCzbyhmLyZxztJ/V59lM1v9FJ8Sl3iDlFa3f9TnOBauG9OjQRB6dKQlhwc80tL
         d0nw==
X-Gm-Message-State: ANoB5pnhtQ7m2jWaLGdpVDgQpbmai/boueXZZ7fdyVdkOcOU3Z9UNZVa
        50nCbUYpQcOcvpzsySOYnTIVM0DBF1/dmXZaFKkNo5mpEMg=
X-Google-Smtp-Source: AA0mqf4upWQUMGIIarIhe87kp1l3XuEV/NaTdTMUYckAbkiIK6K6lGfd6dgOpdWAoGmdZUeqY4a2Lb6H3O0yVvDK8MU=
X-Received: by 2002:ac8:60d3:0:b0:3a5:4678:5b24 with SMTP id
 i19-20020ac860d3000000b003a546785b24mr36364743qtm.411.1669398148180; Fri, 25
 Nov 2022 09:42:28 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 18:42:17 +0100
Message-ID: <CAJZ5v0ifxCo1ZLw8OqUMbnJHQLxP7dKjnxzN1wpogmt+dpm_=Q@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.1-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.1-rc7

with top-most commit 1056d314709d0607a22e589c54b1e47e0da57b9d

 Documentation: add amd-pstate kernel command line options

on top of commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8

 Linux 6.1-rc6

to receive power management fixes for 6.1-rc7.

These revert a recent change in the schedutil cpufreq governor that
had not been expected to make any functional difference, but turned
out to introduce a performance regression, fix an initialization issue
in the amd-pstate driver and make it actually replace the venerable
ACPI cpufreq driver on the supported systems by default.

Specifics:

 - Revert a recent schedutil cpufreq governor change that introduced
   a performance regression on Pixel 6 (Sam Wu).

 - Fix amd-pstate driver initialization after running the kernel via
   kexec (Wyes Karny).

 - Turn amd-pstate into a built-in driver which allows it to take
   precedence over acpi-cpufreq by default on supported systems and
   amend it with a mechanism to disable this behavior (Perry Yuan).

 - Update amd-pstate documentation in accordance with the other changes
   made to it (Perry Yuan).

Thanks!


---------------

Perry Yuan (4):
      cpufreq: amd-pstate: change amd-pstate driver to be built-in type
      cpufreq: amd-pstate: add amd-pstate driver parameter for mode selection
      Documentation: amd-pstate: add driver working mode introduction
      Documentation: add amd-pstate kernel command line options

Sam Wu (1):
      Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"

Wyes Karny (1):
      cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
register at init

---------------

 Documentation/admin-guide/kernel-parameters.txt | 11 ++++++
 Documentation/admin-guide/pm/amd-pstate.rst     | 30 +++++++--------
 drivers/cpufreq/Kconfig.x86                     |  2 +-
 drivers/cpufreq/amd-pstate.c                    | 49 +++++++++++++++++--------
 kernel/sched/cpufreq_schedutil.c                | 30 +++++++--------
 5 files changed, 74 insertions(+), 48 deletions(-)
