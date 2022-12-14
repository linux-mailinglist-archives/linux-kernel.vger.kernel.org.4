Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2C64CBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiLNOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLNOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:10:26 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6EC1CB07;
        Wed, 14 Dec 2022 06:10:25 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id k3so1275584qki.13;
        Wed, 14 Dec 2022 06:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOaoIjTxLglAaa4ZBfF7fq+YBzzQI1dyFt1768d7s6Q=;
        b=buJDK7XncEQgo95HJ4y/PaymrvZ4y5asEKchOP6Xxt/V4IXwlQmCOLbvJyRjy5wmoH
         Ogk//mGarC8idhWAsPY6VCZ/iTP7vF0WopJGQjM/jmmHIxdd/48Qjbl9gP2R25/y2m3c
         wZc9MY8OBcp3WtwdksIdSPFgny3Lt2W7AFsTPXnZKIFSS9lfh1CCSp6KCXkQtydDyMZM
         Z0e/mLWx1aqAS9YAULjDFlpgKdIzMkeFWy4Iy9PW//3fYBj/lzGNl+hf9EngGcqvQWBf
         SuD6BUbuFcM2vv19FP01AsoGoP5vubhPILV28wmTmCQ6MIcryAUSJkCWywP3FAIUXbfZ
         aPeA==
X-Gm-Message-State: ANoB5pnPUbg5VTXV6F8d0nEJEA4fwmjgZd3+Yfw+JLptoWsvKllllNAg
        WmMYsX2f8AaM/kLy5yVq/hIvAJvN+ro8yd3o5bM=
X-Google-Smtp-Source: AA0mqf4yN0p9XnWYWoCSWnpNDe91cxcXAlCLQp6mS1ey6TXfOyrXeqP7I6OJ99zfGyO7fmNAUIppldBwc28eaDKDOC8=
X-Received: by 2002:a05:620a:ec4:b0:6ff:86de:55f with SMTP id
 x4-20020a05620a0ec400b006ff86de055fmr695889qkm.648.1671027024912; Wed, 14 Dec
 2022 06:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
In-Reply-To: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 15:10:13 +0100
Message-ID: <CAJZ5v0h4RCnGv2C+x1m_Uvu5Hmy273wHDLNzYUuJxT_GFxS5qQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add ACPI trip points parser helpers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 9:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Regarding thermal, the ACPI code parsing the trip points is duplicated
> inside different Intel drivers. The generic ACPI thermal driver also
> duplicates this code.
>
> Those ACPI parsing actions are used to define trip points and these
> ones are defined by, and specific to, the backend driver.
>
> The different get_trip_* ops, also very similar between each other,
> are using the specific trip point structure to return the requested
> trip point information.
>
> From there, there is nothing new, all this can be converted to the
> generic trip point.
>
> The first patch provides the functions to parse trip point description
> from the ACPI table but based on the generic trip point structure. The
> other patches convert the different Intel driver to use the ACPI
> functions along with a migration to the generic trip point.

First off, please resend this series with CCs to linux-acpi.

Second, what does it depend on?  I think that it depends on the new
material that hasn't been integrated yet, doesn't it?

> Daniel Lezcano (5):
>   thermal/acpi: Add ACPI trip point routines
>   thermal/drivers/intel: Use generic trip points for intel_pch
>   thermal/drivers/intel: Use generic trip points int340x
>   thermal/drivers/intel: Use generic trip points for quark_dts
>   thermal/drivers/intel: Use generic trip points for
>     processor_thermal_device_pci
>
>  drivers/thermal/Kconfig                       |  13 +
>  drivers/thermal/Makefile                      |   1 +
>  .../int340x_thermal/int340x_thermal_zone.c    | 175 +++---------
>  .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
>  .../processor_thermal_device_pci.c            |  53 ++--
>  drivers/thermal/intel/intel_pch_thermal.c     |  88 ++-----
>  .../thermal/intel/intel_quark_dts_thermal.c   |  45 ++--
>  drivers/thermal/thermal_acpi.c                | 249 ++++++++++++++++++
>  include/linux/thermal.h                       |  15 ++
>  9 files changed, 377 insertions(+), 272 deletions(-)
>  create mode 100644 drivers/thermal/thermal_acpi.c
