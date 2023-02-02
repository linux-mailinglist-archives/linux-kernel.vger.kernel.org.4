Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4A68843B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjBBQVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjBBQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:21:34 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80138719A9;
        Thu,  2 Feb 2023 08:20:47 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id p26so7355371ejx.13;
        Thu, 02 Feb 2023 08:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIASV2b9bWSSLE/gCMcOdLVLgAObEqrmZGUzUVXqCPM=;
        b=KPK35aLVgPVm7z9C4Fg65hT9LLWUoaLHirF1Bi6Qn6t6b5TdTWs/YG6YgmukhqfF1a
         X80bcVEM7etXtotSJpHT5CN0pBPAoTUWBSIaAB6I5lEbFk7r43l8NtBDT/hBAXkj9Djr
         ik1YpOdrou/12DgDw6oYAzSEzI0kayw8BLg57zFcz1+YxezDjA6LOo9st0umPVMQkVs3
         BE3cnukLouuuoqT3YIDUml3dj5FoK3sIXPiFbKDvT2oQMr6vSrz3eSZfE960RQj9A+8U
         mwDof/Zryukx25zLP5dkizLuuyAWXoAfOCFJiaQjaMtbgBYVMK505hxngn+LovkjI83M
         8Vsg==
X-Gm-Message-State: AO0yUKUBdn4ADGkSBgsA5sk/bV8aHJpl89yYangiWJia0s5b70b6A7gT
        f43s0n97Uah41JScepnNo8MHC2E0TH8slzcVkAA=
X-Google-Smtp-Source: AK7set97CeDup2Fz2CdClJJLmgDsbTu0CY0/1zGBfmDZD9el6JGQpLc4LP6DeTSwj48cr7DK0iARjDWQ0OB0aGzS2Rk=
X-Received: by 2002:a17:906:2f88:b0:844:44e0:1c4e with SMTP id
 w8-20020a1709062f8800b0084444e01c4emr2163764eji.291.1675354845869; Thu, 02
 Feb 2023 08:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 17:20:34 +0100
Message-ID: <CAJZ5v0i7HXqHMm6ewfXKqNZ5+jCGHwueFeKyXNo-bwbc0CHOBg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Use idle_inject framework for intel_powerclamp
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, kernel test robot <lkp@intel.com>
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

On Wed, Feb 1, 2023 at 7:35 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Dropped the per core idle injection patch from this series. Hence the
> subject of this series is changed. Now it is just for using
> idle inject framework for intel_powerclamp.
> Add additionl patch for module paramters to set cpumask and max idle percent.
>
> The old cover letter:
> This series introduces per CPU idle injection. In preparation for this
> enhance the existing powercap/idle_inject and modify intel_powerclamp
> to use this. Then add per core idle injection driver.
>
> v5:
> - additionl patch for module paramters to set cpumask and max idle percent
> - One fix for update callback
> - Rebased on top of patch
>  "thermal: intel_powerclamp: Fix cur_state for multi package system"

Patches [1-3/4] have been applied as 6.3 material and I'll comment
patch [4/4] separately.

>
> v4:
> - Dropped the per core idle inject patch
>
> v3
> - Change callback from per CPU to per device and use in intel_powerclamp
> - Remove unused var in per cpu idle injection module
>
> v2
> - Update based on feedback from Rafael on patch 2/4
> - Kconfig dependency issue
> Reported-by: kernel test robot <lkp@intel.com>
>
> Srinivas Pandruvada (4):
>   powercap: idle_inject: Export symbols
>   powercap: idle_inject: Add update callback
>   thermal/drivers/intel_powerclamp: Use powercap idle-inject framework
>   thermal/drivers/intel_powerclamp: Add additional module params
>
>  .../driver-api/thermal/intel_powerclamp.rst   |  22 +
>  drivers/powercap/idle_inject.c                |  57 +-
>  drivers/thermal/intel/Kconfig                 |   2 +
>  drivers/thermal/intel/intel_powerclamp.c      | 512 ++++++++++--------
>  include/linux/idle_inject.h                   |   3 +
>  5 files changed, 367 insertions(+), 229 deletions(-)
>
> --
> 2.39.1
>
