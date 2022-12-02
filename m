Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36F6410CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiLBWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiLBWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:46:01 -0500
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C2EEFD3A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:46:00 -0800 (PST)
Received: by mail-oo1-xc4a.google.com with SMTP id x6-20020a4a2a46000000b0049ca27b1507so2093768oox.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9rB8T4wsLk/XiKnyLn1ChOtKZ9sbnSqHD/TUK5IA5c=;
        b=FKtnIANVOWz7QVSEbLOapzApcnKHXWL+sDMMTlpRER0DmPvpwDNQWejH44T8rhZ/g/
         4zLMVodKI7oWSvAxUHMUSwSA8Ob4O5iuspJ19UyRqD7f94yzb3qI5m9VqJP73JyxJL20
         CjKTY5D1NaTgiiStb1FlHHaLFYXq25aundNcK3gFpDvos/EyOCIQlCv9uS4edmtHEVBE
         DA/bkR7BAm2HKc1BnJyuLuMSqbrU4NCyTQm1l6jnlp6Vhmq7JH63ZDWOSFo90KwkAOJr
         9piAmZPcWCBs3Xya4n+Mts4aeoDe5LvQrCUyUwEy5H4//pYF0Ch0cxiu/mlHTEOdYbUj
         uL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9rB8T4wsLk/XiKnyLn1ChOtKZ9sbnSqHD/TUK5IA5c=;
        b=N9C4sSS9LdbOslfGZpA9Xv6X99LNRNx4s5Snl0jXRjCQ7kr5XC/3WOi8ZSO62Rz9xs
         DNlPoipn8joFR6VfAg13Bq7pmXh79rOA7ofr5SR1y3IUmU2As+noJ8pdTX5N4f/r4vgb
         5rXiy6cdEHw5J9Ne+8Dk0jTfgt7imSCBJhJVubOQ8kH4/7LhNi0n2utLPGRaYKuDes3d
         JxyrYZcWnmw4P/aceV3dRj3N1Xa1xruxIFvV2sRrBoAMTUPkIZXIcZMq0DJwRZIUoNSz
         e6DOZyAkvs61Wqc4iq7KpSeVEUrxPRy0sgB5guyJNgplHHT3qgJ34kQjE2d+qe1ep3bp
         0gyg==
X-Gm-Message-State: ANoB5pm2Mn8VVAszm8sniPwM6gtzjzY5Lk3dXoUVU48m7uhC9dAt6YMY
        cwN+CtG7B28VaubjLcCqEvTA9eoJAgPBMNo=
X-Google-Smtp-Source: AA0mqf7wvdGylDyAivlm1FKQpi+Pr3pcLL+c4xJlI61PFCspz/oPv3dAy7P0b8RMerI1ZTHykp7/Yqsj3TbC3T4=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6808:1701:b0:35b:722a:9eac with SMTP
 id bc1-20020a056808170100b0035b722a9eacmr24273459oib.268.1670021159815; Fri,
 02 Dec 2022 14:45:59 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:45:40 -0600
In-Reply-To: <Y4n0RWqSwDHVT+HA@kroah.com>
Mime-Version: 1.0
References: <Y4n0RWqSwDHVT+HA@kroah.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224540.1446952-1-allenwebb@google.com>
Subject: [PATCH v6 0/5] Add sysfs match-id modalias attribute for USB modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs match-id modalias attribute for USB modules

This patch series (v6) exposes the driver matching values from the
modalias to inform policy decisions in userspace for devices with the
authorized attribute in sysfs. In other words with this patch tools
like USBGuard could leverage not only modules.aliases, but also the
aliases for the builtin modules to associate devices with modules that
may be bound before deciding to authorize a device or not. This is
particularly useful in cases when new devices shouldn't be allowed part
of the time like for lock screens.

Note that at this point the series only implements USB, but Thunderbolt
and other subsystems could be added.

CONFIG_SYSFS and CONFIG_MODULES (adds /sys/module/) are both required
for the /sys/module/*/modalias attributes to be present.

--

# Module sysfs modalias attribute for match ids

Note that previous versions of this patch series were flattened into
a single patch, and a cover letter was first added in v5 with diffs
between each previous version of the patch series.

Also this version adds a `Documentation/ABI` entry for
`/sys/module/*/modalias`.

  RFC (broken patch): https://lore.kernel.org/lkml/CAJzde042-M4UbpNYKw0eDVg4JqYmwmPYSsmgK+kCMTqsi+-2Yw@mail.gmail.com/
  v1 (missing v1 label): https://lore.kernel.org/lkml/20221111152852.2837363-1-allenwebb@google.com/
  v2 (missing v2 label): https://lore.kernel.org/lkml/20221128201332.3482092-1-allenwebb@google.com/
  v3: https://lore.kernel.org/lkml/20221129224313.455862-1-allenwebb@google.com/
  v4: https://lore.kernel.org/lkml/20221130221447.1202206-1-allenwebb@google.com/
  v5: https://lore.kernel.org/lkml/20221201211630.101541-1-allenwebb@google.com/
  v6: This version

## Patch series status

This series is still going through revisions in response to comments.
USB is the only implemented subsystem, but PCI or other subsystems
with the authorized attribute could be added.

There is still an open question as to whether using kmod would be a
better approach to solve the problem. One big hurdle with that approach
is match-id-based aliases are not currently exposed through kmod and
changing that behavior might have unintended consequences. The
particular concerns I have are:

  - Are we OK with significantly growing the number of aliases handled
    by kmod by including the match-id-based aliases?

  - Are other tools that use kmod prepared to handle the addition of
    match-id-based aliases?

  - Additional work would be needed for kmod to be able to handle
    match-id-based aliases and it would likely require subsystem
    specific elements unless it leveraged files2alias.

Also, `mod_devicetable.c` is very similar to files2alias, so there
might be some possiblity of having common logic between the two. The
big difficulty lies in support both use cases which need to work both
at build time and at runtime.

Additionally before this is ready, there should be implementations for
the other subsystems whose devices have the `authorized` sysfs
attribute (Thunderbolt).

## Acknowledgements

Thanks to Greg Kroah-Hartman and the Linux maintainers for being
patient with me as I have worked through learning the kernel
workflow to get this series into a more presentable state.

Thanks to Luis Chamberlain for raising the alternative of
using kmod to address the primary motivation of the patch series.

Also, thanks to Intel's kernel test robot <lkp@intel.com> for catching
issues that showed up on different kernel configurations.


Allen Webb (5):
  module: Add empty modalias sysfs attribute
  drivers: Add bus_for_each for iterating over the subsystems
  Implement modalias sysfs attribute for modules
  docs: Add entry for /sys/module/*/modalias
  drivers: Implement module modaliases for USB

 Documentation/ABI/testing/sysfs-module |  12 ++
 drivers/base/Makefile                  |   2 +-
 drivers/base/base.h                    |   8 +
 drivers/base/bus.c                     |  42 ++++
 drivers/base/mod_devicetable.c         | 257 +++++++++++++++++++++++++
 drivers/usb/core/driver.c              |   2 +
 include/linux/device/bus.h             |   8 +
 include/linux/module.h                 |   1 +
 kernel/module/internal.h               |   2 +
 kernel/module/sysfs.c                  |  88 +++++++++
 kernel/params.c                        |   7 +
 11 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/mod_devicetable.c

-- 
2.37.3

