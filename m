Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C76AA6B3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCDAyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCDAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:54:21 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365E66D0A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:53:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e195-20020a25e7cc000000b00a1e59ba7ed9so4159717ybh.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677891238;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KMOqXh7hVSFhgcl31RbknZfV4w7k6tUCijEEKHPjbLg=;
        b=Mj5pbKfgEFR8HCEqE8P7tGDaE8G5NvqI5ZXhTw+87HZ4mo7NjPk7M5F9gADFKc8oN+
         PvYZlXxKaQGCPsnPkB8jkypjZjdyUzuvhct+dSvvGU8Ybs6hWLz/jX/1guwSP3Fpk4tC
         1fAjWqelMByC2oQ9vLB1jk72Y012anfzn0Ie04CkFnGIyQ7Uy2vFbOPa1RnkQqhXbYj5
         H0S2UKecv58EHgKu6YuyNvUYlpWAEM0TY66iotkUDP3upuzY3XrIl/l6WgGCLgWqXp9V
         G38/kcl9hMlpVmMZLYoiin+L62W0ZB4YGapPqWLPc90TEk7C2WvqQkYDH57LAKDEJE0R
         Fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677891238;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMOqXh7hVSFhgcl31RbknZfV4w7k6tUCijEEKHPjbLg=;
        b=eaVZAsYsp+2/lSHoX9KFbgBzNFGyPxlZ3HrY3q8GnZ02bSAvF46n6anIg736vJrQIz
         vVfOHBJ4l9BJx9VtoLSyiJ5Ielr4E7VT3mdkEDgixK2Bj6HqofGcKDcCjplFCMLGpLi8
         PDsWqegdx7R1PCqEyFqPLNpLhpPd4TzCea9dsocgV5S9W1f5P4T8Pf0Z7bpKx4jtjY7v
         TXSYbwMPuemG3Odxa0epV2CP44zsewKP5gSRZDPnK1bHCdlg7Oqp1fqptFoAlJ8IGt0A
         icV62OsBYmfcDVs7928GDQQNVcSgDeRftuhHDIng2smFbZuBBvBhDpKbZrYcX8FQhwbL
         1NuQ==
X-Gm-Message-State: AO0yUKW/hl/wnvAFglCZXOj6/a1rb51YJxRQAFLxFhuRHDRQ/EF8gdsT
        5yFrSJXtV536PEiYS/YL5pnAvV7XtKOW42g=
X-Google-Smtp-Source: AK7set+l86zHNxMDRbOJ7XGRMnZDbC3A6l1xQWIVEbI3uGdI2Vwlr1phzi7JaDR3MSHOvvzj0TyWUwmtGTvKAZU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ef0c:d8be:ebb3:b639])
 (user=saravanak job=sendgmr) by 2002:a81:ae47:0:b0:533:9ffb:cb13 with SMTP id
 g7-20020a81ae47000000b005339ffbcb13mr2046588ywk.3.1677891238011; Fri, 03 Mar
 2023 16:53:58 -0800 (PST)
Date:   Fri,  3 Mar 2023 16:53:52 -0800
Message-Id: <20230304005355.746421-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 0/2] Give more control of sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In systems where some devices don't have drivers, sync_state() will
never get called for suppliers of those devices. This is working as
intended since those consumer devices might be powered on, and cutting
resources to those consumer devices might make the system unstable.

However, not all systems will the same concern. For example, the
consumer device might have been left powered off and unused. In such
cases, sync_state() never getting called might cause an unnecessary
power regression if the bootloader had left the supplier in a powered on
state.

So give more control of sync_state() in the form of a kernel commandline
for a global timeout or a per device sysfs control to trigger
sync_state().

These patches have been tested on my end and seem to work well.

Thanks,
Saravana

v1->v2:
Patch 1: Updated commit text, documentation and log message.
Patch 2: Check for "1" in the write, updated doc, fix error handling.

Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>

Saravana Kannan (2):
  driver core: Add fw_devlink.sync_state command line param
  driver core: Make state_synced device attribute writeable

 .../ABI/testing/sysfs-devices-state_synced    |  5 ++
 .../admin-guide/kernel-parameters.txt         | 14 +++++
 drivers/base/base.h                           |  9 +++
 drivers/base/core.c                           | 63 +++++++++++++++++--
 drivers/base/dd.c                             | 29 ++++++++-
 5 files changed, 115 insertions(+), 5 deletions(-)

-- 
2.40.0.rc0.216.gc4246ad0f0-goog

