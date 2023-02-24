Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E866A16E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBXHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBXHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:05:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFC53ECE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:05:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bfec4a66so169239567b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RtOdossUcDgJLVAP/vxVkTtjnzUIhFTFo3MpYs9j7yI=;
        b=Zq63LwSzDsAxgRDXEC5JTzihjGiElNDE42xZhN8svvBKBKKfr06s8yi0JjQwCoVwfJ
         9gNUERYOeVm0NUCWDpRCgyuCEAJ6RJxxezwmWfMkwTZY8bTmKJfEXayzzZXhebdaWg98
         3TqMJuSfcCoEikUPjDM3n1A0jiBuN8olH6kmXszmUeb8sEYrRkuM0IGEVpm9JCFl9g6X
         oKR4QLDdMcCo4RcuuKtJEDpBwswwRXa0nreV8wp5EYKD9/s/ny4JJhUfHCT36gBLlaDa
         P+lbT2bHd8QOjslS71ZO8YwwKlx+NJh97d+W+Br2GqSBfXrBH8efRpgnbcVv82lQXmqU
         h3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtOdossUcDgJLVAP/vxVkTtjnzUIhFTFo3MpYs9j7yI=;
        b=N9G1uRbHwabS/9kFlo9n0cJWchNyUlAXE9wjCzhGfXH38dQDEti1pHe6WoSuI6GnFW
         DUjpj+OAm49168LAXaVJJwX0d+uBwMch42bSTMoE85KB4Dv1JMQEf2zT8zthq513toL3
         Z5mp+1zw+UwUN/1OfB5TBGdSyDU8GwoR9pgYesZ+sv/kTMXPK9wmtRcOnuF7J7t6fTgF
         OV81Z9t2Gilm+yrZOgNxa3Bf6W4xW178tHc8DYqCY1+FWQ3itX01LttpzpBCKPQiWBJx
         BOEPw0WDdLtbeQTX1aQZ5D+vWNPev0yhDppoqa20fEyonFz0U/P+iyMWhfla5Xes+9gE
         Hmcg==
X-Gm-Message-State: AO0yUKUQYp513iPf7tsiZ27LJyD/SNCfft2jk2OBWMrUHVrIu25cKxxP
        4RHObmOX/ZVrPSvEeCPlxmQg925gQjGYbzc=
X-Google-Smtp-Source: AK7set/k0aJ6VgmrHK0J/8ltGNUBE24C+s+KAxpitxkmld16TsKJIWYCv+LjoB18fwaytwzy0VcX5gWLvcrduTY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8a2e:9303:e359:c4d6])
 (user=saravanak job=sendgmr) by 2002:a81:b722:0:b0:52e:b635:5496 with SMTP id
 v34-20020a81b722000000b0052eb6355496mr3930821ywh.2.1677222309635; Thu, 23 Feb
 2023 23:05:09 -0800 (PST)
Date:   Thu, 23 Feb 2023 23:05:02 -0800
Message-Id: <20230224070506.4157738-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 0/2] Give more control of sync_state()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>

Saravana Kannan (2):
  driver core: Add fw_devlink.sync_state command line param
  driver core: Make state_synced device attribute writeable

 .../ABI/testing/sysfs-devices-state_synced    |  5 ++
 .../admin-guide/kernel-parameters.txt         | 12 ++++
 drivers/base/base.h                           |  9 +++
 drivers/base/core.c                           | 63 +++++++++++++++++--
 drivers/base/dd.c                             | 24 ++++++-
 5 files changed, 108 insertions(+), 5 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

