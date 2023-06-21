Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B28738859
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjFUPGS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjFUPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:06:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2982135;
        Wed, 21 Jun 2023 08:00:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-987f13f8d21so133788066b.0;
        Wed, 21 Jun 2023 08:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687359499; x=1689951499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQgcSi11x60RW/FFHyKWmOjoC911mNST/9JBZIHptvk=;
        b=W1SLRDd3rPBxA9ZspVk1vkj20s38sOO0B7Y6algErLJN4EP4zozFB/MpFfDCI69Mr2
         SeVIJOZtzU/PvGfAAR+pYsLII1sBu5rVxiVamTZ9fhhpO9jEbjryu+Ow3xwD03zo7weG
         GS/Oe0Ti3CRKRwIkpXGxeDhUGSZDdAXnb96z7CwGFadiAGS0wyDbxg9dAdWnKKzPfrgB
         KDniOYkRXnQxNLFCv+gbQJcYPh8KTDsUXg2AzLPcpo/Efc+eNdMDcVJf0gEeGWHkE52U
         VnviErnApTBk8EYG6+QeTPD6zAFkUYYt6DdgqoQV3jXEVJ5RhzmXipDYRCW+wa68HcJd
         9j/w==
X-Gm-Message-State: AC+VfDyQa+hRq/RtSi7MgJpvIPYGC2ZDL5HQFIh3ce2rfTZ9vvltCwEA
        VnRbZdAWfCrqEsbcC1m6YkumhQjVJZentxeCmwo4FtOz
X-Google-Smtp-Source: ACHHUZ4zOmKFCiRY/93PgkC/EmyUUkGrnaTqR4BSa+01OTVPYz47owdtRluCjLQIny1zn/MAfC2T3MDxnNocNHJkeZ8=
X-Received: by 2002:a17:906:77ca:b0:989:1ed3:d010 with SMTP id
 m10-20020a17090677ca00b009891ed3d010mr4063730ejn.2.1687359499235; Wed, 21 Jun
 2023 07:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Jun 2023 16:58:08 +0200
Message-ID: <CAJZ5v0jGp_Rsu6S+znmrKhQ+y88Mqf9PLf66Ec-SffdFdyH_4g@mail.gmail.com>
Subject: Re: [PATCH 0/7] thermal: processor_thermal: Suport workload hint
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 1:01 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add support for Meteor Lake workload hints. Before adding this support,
> some reorganization and clean up is required.
> First four changes are for clean up and to reorganize code to add
> support for workload hint. The last patch adds a test program as part
> of self tests.
>
> Srinivas Pandruvada (7):
>   thermal: int340x: processor_thermal: Move mailbox code to common
>     module
>   thermal: int340x: processor_thermal: Add interrupt configuration
>   thermal: int340x: processor_thermal: Use non MSI interrupts
>   thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for
>     Meteor Lake
>   thermal: int340x: processor_thermal: Add workload type hint
>   thermal/drivers/int340x: Support workload hint interrupts
>   selftests/thermel/intel: Add test to read workload hint
>
>  .../driver-api/thermal/intel_dptf.rst         |  38 +++
>  .../thermal/intel/int340x_thermal/Makefile    |   2 +
>  .../processor_thermal_device.c                |  17 +-
>  .../processor_thermal_device.h                |  21 +-
>  .../processor_thermal_device_pci.c            |  76 ++++--
>  .../processor_thermal_device_pci_legacy.c     |   3 +-
>  .../int340x_thermal/processor_thermal_mbox.c  | 179 ++++---------
>  .../processor_thermal_wlt_hint.c              | 239 ++++++++++++++++++
>  .../processor_thermal_wlt_req.c               | 137 ++++++++++
>  .../testing/selftests/thermal/intel/Makefile  |  16 ++
>  .../thermal/intel/workload_hint_test.c        | 114 +++++++++
>  11 files changed, 680 insertions(+), 162 deletions(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_req.c
>  create mode 100644 tools/testing/selftests/thermal/intel/Makefile
>  create mode 100644 tools/testing/selftests/thermal/intel/workload_hint_test.c
>
> --

Because of the timing of the first posting, I'm going to treat this
series as 6.6 material.
