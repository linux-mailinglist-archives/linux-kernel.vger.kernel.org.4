Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851B65F36C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJCT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJCT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:56:17 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2349B4F;
        Mon,  3 Oct 2022 12:56:16 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id f26so6992698qto.11;
        Mon, 03 Oct 2022 12:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bC0sul2UGgyQdiwsa57rpyF6YKEsyQTncLxjmLU3TUU=;
        b=sXuI9LRajLew2PFBbs3p5oWmFb7zUePNccmeD6Bb9FJcsPmA0syYw3ge33ipAQpvmy
         bG7VNUsT5sVVOmKrHEJPPrUJhHaUEfDjyFcWsJtbKS5Ue7p82MBS+zSHREjQ7V+QP7io
         vPHlR5OKNUdJ7ljw9/PxIc6uyGSMmSF+CwzZluHmqESz+5diirfarNtNAqGRAzJEv3Wx
         37dqRhcBxVmiQp1yxfTS8lY6FYRU9KX3d1zE8OrHlmNXaGSWQkz4m0cKnNL8UFjkBqOG
         FsQ0DYFuVz++zxxhBL+g+u/sbzmN/dCQp8Oiuixbf/QiQFHdnuOKppi4XtA8vkXnJiSS
         mVAQ==
X-Gm-Message-State: ACrzQf1NfZzXMh9ayvnPF/xaO7RBxvUtYAulUGQ6ciapL6EZEKYAhz/d
        iQEfXClYMg09GZXyoHr2dU2wOUi2LFEwfyulHexbelna75M=
X-Google-Smtp-Source: AMsMyM66rCZx4CeA/G2ZAExrlZIzA1vdVT1w+bxbTDaKdHOm5a9nVOpVe1luXEP2FcnJ1scSdk2AWOdBxgyj20SFPUU=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr17230683qtb.494.1664826975306; Mon, 03
 Oct 2022 12:56:15 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Oct 2022 21:56:04 +0200
Message-ID: <CAJZ5v0ip_C6y1KopyN2pEs7dyqPw6NzKG1WtJSeqyKJeMOYwfA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.1-rc1

with top-most commit ac73ce394a129a88cb01ce190844bcd172ce14fb

 Merge branches 'pm-cpuidle', 'pm-core', 'pm-sleep' and 'powercap'

on top of commit f76349cf41451c5c42a99f18a9163377e4b364ff

 Linux 6.0-rc7

to receive power management updates for 6.1-rc1.

These add support for some new hardware, extend the existing hardware
support, fix some issues and clean up code.

Specifics:

 - Add support for Tiger Lake in no-HWP mode to intel_pstate (Doug
   Smythies).

 - Update the AMD P-state driver (Perry Yuan):
   * Fix wrong lowest perf fetch.
   * Map desired perf into pstate scope for powersave governor.
   * Update pstate frequency transition delay time.
   * Fix initial highest_perf value.
   * Clean up.

 - Move max CPU capacity to sugov_policy in the schedutil cpufreq
   governor (Lukasz Luba).

 - Add SM6115 to cpufreq-dt blocklist (Adam Skladowski).

 - Add support for Tegra239 and minor cleanups (Sumit Gupta, ye xingchen,
   and Yang Yingliang).

 - Add freq qos for qcom cpufreq driver and minor cleanups (Xuewen Yan,
   and Viresh Kumar).

 - Minor cleanups around functions called at module_init() (Xiu Jianfeng).

 - Use module_init and add module_exit for bmips driver (Zhang Jianhua).

 - Add AlderLake-N support to intel_idle (Zhang Rui).

 - Replace strlcpy() with unused retval with strscpy() in intel_idle
   (Wolfram Sang).

 - Remove redundant check from cpuidle_switch_governor() (Yu Liao).

 - Replace strlcpy() with unused retval with strscpy() in the powernv
   cpuidle driver (Wolfram Sang).

 - Drop duplicate word from a comment in the coupled cpuidle driver
   (Jason Wang).

 - Make rpm_resume() return -EINPROGRESS if RPM_NOWAIT is passed to it
   in the flags and the device is about to resume (Rafael Wysocki).

 - Add extra debugging statement for multiple active IRQs to system
   wakeup handling code (Mario Limonciello).

 - Replace strlcpy() with unused retval with strscpy() in the core
   system suspend support code (Wolfram Sang).

 - Update the intel_rapl power capping driver:
   * Use standard Energy Unit for SPR Dram RAPL domain (Zhang Rui).
   * Add support for RAPTORLAKE_S (Zhang Rui).
   * Fix UBSAN shift-out-of-bounds issue (Chao Qin).

 - Handle -EPROBE_DEFER when regulator is not probed on
   mtk-ci-devfreq.c (AngeloGioacchino Del Regno).

 - Fix message typo and use dev_err_probe() in rockchip-dfi.c
   (Christophe JAILLET).

Thanks!


---------------

Adam Skladowski (1):
      cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist

AngeloGioacchino Del Regno (1):
      PM / devfreq: mtk-cci: Handle sram regulator probe deferral

Chao Qin (1):
      powercap: intel_rapl: fix UBSAN shift-out-of-bounds issue

Christophe JAILLET (1):
      PM / devfreq: rockchip-dfi: Fix an error message

Doug Smythies (1):
      cpufreq: intel_pstate: Add Tigerlake support in no-HWP mode

Jason Wang (1):
      cpuidle: coupled: Drop duplicate word from a comment

Lukasz Luba (1):
      cpufreq: schedutil: Move max CPU capacity to sugov_policy

Mario Limonciello (1):
      PM: wakeup: Add extra debugging statement for multiple active IRQs

Perry Yuan (6):
      cpufreq: amd-pstate: simplify cpudata pointer assignment
      cpufreq: amd-pstate: fix white-space
      cpufreq: amd_pstate: fix wrong lowest perf fetch
      cpufreq: amd_pstate: map desired perf into pstate scope for
powersave governor
      cpufreq: amd-pstate: update pstate frequency transition delay time
      cpufreq: amd-pstate: Fix initial highest_perf value

Rafael J. Wysocki (1):
      PM: runtime: Return -EINPROGRESS from rpm_resume() in the RPM_NOWAIT case

Sumit Gupta (1):
      cpufreq: tegra194: Add support for Tegra239

Viresh Kumar (1):
      cpufreq: qcom-cpufreq-hw: Fix uninitialized throttled_freq warning

Wolfram Sang (3):
      cpuidle: powernv: move from strlcpy() with unused retval to strscpy()
      intel_idle: move from strlcpy() with unused retval to strscpy()
      PM: suspend: move from strlcpy() with unused retval to strscpy()

Xiu Jianfeng (1):
      cpufreq: Add __init annotation to module init funcs

Xuewen Yan (1):
      cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh

Yang Yingliang (1):
      cpufreq: tegra194: change tegra239_cpufreq_soc to static

Yu Liao (1):
      cpuidle: Remove redundant check in cpuidle_switch_governor()

Zhang Jianhua (1):
      cpufreq: bmips-cpufreq: Use module_init and add module_exit

Zhang Rui (3):
      powercap: intel_rapl: Add support for RAPTORLAKE_S
      intel_idle: Add AlderLake-N support
      powercap: intel_rapl: Use standard Energy Unit for SPR Dram RAPL domain

ye xingchen (1):
      cpufreq: tegra194: Remove the unneeded result variable

---------------

 drivers/base/power/runtime.c         |  7 +++--
 drivers/base/power/wakeup.c          |  2 ++
 drivers/cpufreq/amd-pstate.c         | 39 ++++++++++++++------------
 drivers/cpufreq/bmips-cpufreq.c      | 10 +++++--
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/highbank-cpufreq.c   |  2 +-
 drivers/cpufreq/intel_pstate.c       |  1 +
 drivers/cpufreq/qcom-cpufreq-hw.c    | 24 ++++++++++++----
 drivers/cpufreq/sti-cpufreq.c        |  2 +-
 drivers/cpufreq/tegra194-cpufreq.c   | 35 +++++++++++-------------
 drivers/cpufreq/ti-cpufreq.c         |  2 +-
 drivers/cpuidle/coupled.c            |  2 +-
 drivers/cpuidle/cpuidle-powernv.c    |  4 +--
 drivers/cpuidle/governor.c           | 11 ++++----
 drivers/devfreq/event/rockchip-dfi.c |  7 ++---
 drivers/devfreq/mtk-cci-devfreq.c    |  8 ++++--
 drivers/idle/intel_idle.c            | 53 +++++++++++++++++++++++++++++++++++-
 drivers/powercap/intel_rapl_common.c |  5 +++-
 include/linux/suspend.h              |  2 +-
 kernel/sched/cpufreq_schedutil.c     | 30 ++++++++++----------
 20 files changed, 165 insertions(+), 82 deletions(-)
