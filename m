Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C606C86A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCXUS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCXUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:18:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4390;
        Fri, 24 Mar 2023 13:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0441B825FA;
        Fri, 24 Mar 2023 20:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C86C4339C;
        Fri, 24 Mar 2023 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679689098;
        bh=hP4byYZvNndNp7lGCCwVeD1cMtYskou/Yl3piA3t9PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fllQcmU1+cMham8BwE6rd68KE6hkxhTZTJILRu9VMfA8zncpeoQqYr/qV9hQzQ7fJ
         6mq4vIttklDpEzBcIUif8y0yQifF85W5uzb8FaXPPIWPY++DmfvDEm3R3MSBrbCuV0
         SK2fr9x7yN0RF5guz/Tr1LDQ3F7ERaOI/8hqVaxqB0TMSNCw7iN0jGgOepfhYGebCC
         Ugk3t2t/MLEtrwufnGrt5gHYgIYdVNubdIkqAQpfp/2qmWvRkaeS9SlLJeHCkI/10+
         Y6Q2jfTNN+9DkmrO+sa+DFjZQBvQJ4STces+VJ0qYZhw2mF2uL3A6VZbz677clwXut
         ZFkQlevXvCcnQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AACB94052D; Fri, 24 Mar 2023 17:18:15 -0300 (-03)
Date:   Fri, 24 Mar 2023 17:18:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf stat: Suppress warning when using cpum_cf events on
 s390
Message-ID: <ZB4Fh71hRVPXW+Ne@kernel.org>
References: <20230316074946.41110-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316074946.41110-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 16, 2023 at 08:49:46AM +0100, Thomas Richter escreveu:
> Running command perf stat -vv -e cpu_cycles -C0 -- true
> displays this warning:
> 
>  Attempting to add event pmu 'cpum_cf' with 'cpu_cycles,'
>  that may result in non-fatal errors
> 
> Make the PMU cpum_cf selectable and avoid this warning.
> While at it also fix this warning for PMUs pai_crypto and pai_ext.
> 
> Output before:
 

Thanks, applied.

- Arnaldo

>  #  ./perf stat -vv -e cpu_cycles -C0 -- true
>  Using CPUID IBM,3931,704,A01,3.7,002f
>  Attempting to add event pmu 'cpum_cf' with 'cpu_cycles,'
>    that may result in non-fatal errors
>  After aliases, add event pmu 'cpum_cf' with 'event,'
>    that may result in non-fatal errors
>    cpu_cycles -> cpum_cf/event=0/
>  Control descriptor is not initialized
>  ------------------------------------------------------------
>  perf_event_attr:
>   type                             10
>   size                             128
>   config                           0x1001
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
>  ------------------------------------------------------------
>  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
>  cpu_cycles: 0: 290434 2479172 2479172:
>  cpu_cycles: 290434 2479172 2479172
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>            290,434      cpu_cycles
> 
>        0.002465617 seconds time elapsed
>  #
> 
> Now the warning "Attempting to add event pmu 'cpum_cf' ..."
> does not show up anymore.
> 
> Output after:
>  # ./perf stat -vv -e cpu_cycles -C0 -- true
>  Using CPUID IBM,3931,704,A01,3.7,002f
>  After aliases, add event pmu 'cpum_cf' with 'event,'
>    that may result in non-fatal errors
>    cpu_cycles -> cpum_cf/event=0/
>  Control descriptor is not initialized
>  ....
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>            357,023      cpu_cycles
> 
>        0.002454995 seconds time elapsed
>  #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/arch/s390/util/Build |  1 +
>  tools/perf/arch/s390/util/pmu.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 tools/perf/arch/s390/util/pmu.c
> 
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
> index db6884086997..fa66f15a14ec 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -6,5 +6,6 @@ perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  
>  perf-y += machine.o
> +perf-y += pmu.o
>  
>  perf-$(CONFIG_AUXTRACE) += auxtrace.o
> diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
> new file mode 100644
> index 000000000000..11f03f32e3fd
> --- /dev/null
> +++ b/tools/perf/arch/s390/util/pmu.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright IBM Corp. 2023
> + * Author(s): Thomas Richter <tmricht@linux.ibm.com>
> + */
> +
> +#include <string.h>
> +
> +#include "../../../util/pmu.h"
> +
> +#define	S390_PMUPAI_CRYPTO	"pai_crypto"
> +#define	S390_PMUPAI_EXT		"pai_ext"
> +#define	S390_PMUCPUM_CF		"cpum_cf"
> +
> +struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu)
> +{
> +	if (!strcmp(pmu->name, S390_PMUPAI_CRYPTO) ||
> +	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
> +	    !strcmp(pmu->name, S390_PMUCPUM_CF))
> +		pmu->selectable = true;
> +	return NULL;
> +}
> -- 
> 2.39.1
> 

-- 

- Arnaldo
