Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74A70FBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjEXQyw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:54:45 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB5E9;
        Wed, 24 May 2023 09:54:44 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96fc07d7e6bso28694866b.1;
        Wed, 24 May 2023 09:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947282; x=1687539282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7mhVD4XTMnqROD616kljeDBlLud+Bhb73ooieBcdEc=;
        b=Pl0NF9wPkItXq1l96mkCcAvKNn+KX0rgBHBmiQQHAm4IDsmso7q0WhhBd1eWHd7eXL
         G2yZYq4Cp9r2Sa8De6YVGMK3ebzZ0Hp4SYQ/fQ+Hbw27PZr4S6QvzhZPik1eZtcsXQqS
         usGHxPkNHNAjQbysc5w6K0PzVUfbxTf/EiGJR6V4JGSwCTpepdae/XHNZxnTiwIHZgod
         zf0AsqdfKSXMzeNdtgn5RWBapIlptnJIFhW2NFsjymwzr9BTN7towac0qKTwoKOCsEbG
         OTtYf7dXoQmf5Woumftn3hNOdqjLSgiya1KFlV6ujJ50lQ2OKitLxmN6B+12wb7/9LQM
         fQ4g==
X-Gm-Message-State: AC+VfDxmc2gE6iO9NKhERafrmkLTlQev3pWPNY2qD1LTYrJkkdI3VXda
        zTpsP3C+jFTOo+RBXFA5PV2AQYK4vf3kIb78wQYyAor8
X-Google-Smtp-Source: ACHHUZ6liAGoZTnKFZUz9S6DWgLnyzIVMVT1sbU56fUZMYgmFj8pOE+AqVS6mk+bAhcH3bd6Akn31Bx4XWCzB6UharQ=
X-Received: by 2002:a17:906:5189:b0:96f:469d:19ba with SMTP id
 y9-20020a170906518900b0096f469d19bamr17150526ejk.2.1684947282487; Wed, 24 May
 2023 09:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230419024419.324436-1-rui.zhang@intel.com>
In-Reply-To: <20230419024419.324436-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 18:54:31 +0200
Message-ID: <CAJZ5v0g5+wsBjCFhO--hfJYfRxheNA1V1XuB6zp-7wV-nwSf+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/15] powercap/intel_rapl: Introduce RAPL TPMI support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 4:44 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> The TPMI (Topology Aware Register and PM Capsule Interface) provides a
> flexible, extendable and PCIe enumerable MMIO interface for PM features.
>
> The TPMI documentation can be downloaded from:
> https://github.com/intel/tpmi_power_management
>
> Intel RAPL (Running Average Power Limit) is one of the features that
> benefit from this. Using TPMI Interface has advantage over traditional MSR
> (Model Specific Register) interface, where a thread needs to be scheduled
> on the target CPU to read or write. Also the RAPL features vary between
> CPU models, and hence lot of model specific code. Here TPMI provides an
> architectural interface by providing hierarchical tables and fields,
> which will not need any model specific implementation.
>
> Given that there are some differences between RAPL TPMI Interface and the
> existing RAPL MSR/MMIO Interface, this patch series improves the RAPL
> common code to satisfy the new requirements from TPMI interface, and then
> introduces the RAPL TPMI Interface driver.
>
> Patch 1-4       cleanups and preparation work.
> Patch 5         adds support for per Domain Unit register.
> Patch 6-10      improves Power Limits handling, and provides support
>                 for per Power Limit register, and per Power Limit Lock.
> Patch 11-12     support rapl_package without online CPUs. So that TPMI
>                 rapl_package still works with whole package offlined.
> Patch 13-15     introduces RAPL Core support for TPMI Interface and the
>                 RAPL TPMI Interface driver.
>
> This series depends on the TPMI base driver which has been merged in 6.3-rc1.
>
> thanks,
> rui
> ---
> Changes since v1:
>    - use set_defaults() and variable name 'defaults' for rapl_defaults
>      structure.
>    - use 'rpi_default' instead of 'rpis' for the default rapl primitive
>      information of MSR/MMIO Interface.
>    - rephase the changelog of patch 7/15.
>    - change the subject of patch 10/15 and use a helper for getting the
>      primitive for power limit LOCK bit control.
>
> ----------------------------------------------------------------
> Zhang Rui (15):
>       powercap/intel_rapl: Remove unused field in struct rapl_if_priv
>       powercap/intel_rapl: Allow probing without CPUID match
>       powercap/intel_rapl: Support per Interface rapl_defaults
>       powercap/intel_rapl: Support per Interface primitive information
>       powercap/intel_rapl: Support per domain energy/power/time unit
>       powercap/intel_rapl: Use index to initialize primitive information
>       powercap/intel_rapl: Change primitive order
>       powercap/intel_rapl: Use bitmap for Power Limits
>       powercap/intel_rapl: Cleanup Power Limits support
>       powercap/intel_rapl: Introduce per Power Limit lock
>       powercap/intel_rapl: Remove redundant cpu parameter
>       powercap/intel_rapl: Make cpu optional for rapl_package
>       powercap/intel_rapl: Introduce RAPL I/F type
>       powercap/intel_rapl: Introduce core support for TPMI interface
>       powercap/intel_rapl_tpmi: Introduce RAPL TPMI interface driver
>
>  drivers/powercap/Kconfig                           |  14 +
>  drivers/powercap/Makefile                          |   1 +
>  drivers/powercap/intel_rapl_common.c               | 868 ++++++++++++---------
>  drivers/powercap/intel_rapl_msr.c                  |  14 +-
>  drivers/powercap/intel_rapl_tpmi.c                 | 325 ++++++++
>  .../intel/int340x_thermal/processor_thermal_rapl.c |  11 +-
>  include/linux/intel_rapl.h                         |  40 +-
>  7 files changed, 875 insertions(+), 398 deletions(-)
>  create mode 100644 drivers/powercap/intel_rapl_tpmi.c

The whole series has been applied as 6.5 material, thanks!
