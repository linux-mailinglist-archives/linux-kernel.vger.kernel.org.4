Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F00665505
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjAKHJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAKHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:09:39 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81CAB1C7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:09:37 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so15831361plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXu3NFcy3E6k/qTfyZTmDtcSnmUuSgUYcvuwQn2oJ08=;
        b=AaKP+UATMx3qvunIjeo8Fd8WCxjRzcQ2m4z8RrCbs9qE5GaxtYhBDFiYyuWNkKlrIT
         4VhcL785Ej0lA/p5qdYgwYyqZp7MXoquBd3mXSN/o2A7RPnRnBvDoMcI9ZsPywKKmLpe
         wtvZTOzq3bG95CyKDA0aWNQn8ZHZRBcjjGUACSqRsKk4so1SzGeCEB+R7H2KNpIpkEzr
         tzyj2JmO6OCyzqc/OSdGvqI+buH7eCAwKkLGkFD/UAJfScuVIQcIQuSxvv7jNZ/przIA
         2t0LcTa7s9dU/uJ2ndgoNFY0YrwpQbx7x1EQMlA9UDMeoyzdzXRl+gj8+ThmPR/BTdSi
         YiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXu3NFcy3E6k/qTfyZTmDtcSnmUuSgUYcvuwQn2oJ08=;
        b=5x0N4reI/JlunoOzEXJpVU5gxyLliUDJFni3yQQYRrPKmOPQAb3y+CsEid317H+AUg
         wKC9o9L9xhB7jBpP+lg+KyHEsA0u5KCQNo73fA2iflSI/EofX2WALhGSXFFJywtQ2WD3
         E19RshCH8m+ynD2IlQvy6AoIMe3nOLClA/Ibmkx5jrIxoTUt2iJh4WenaO3I2mXhlW77
         9mkrJri98svbU6gtgZUWZ8LyIub3D8AcLv3yoZG+A+GIAcF/fTU7Q5dRdymV2fg3br1n
         hmytaKMI+JZq0xB00cSdpfM/g3FtPK3baWYwBMqgNHELsbZmw/GQKoWMRZPvSf0KA72L
         e+Zg==
X-Gm-Message-State: AFqh2kowsHJfBdTCp5Sh0UPCZP5XgkpH9x5IW6yyYGbU/cpCS5gRlPu7
        b9nIeOEdexdaF0kwbpsyxnydSA==
X-Google-Smtp-Source: AMrXdXs6dhihzdE8mH+xS+p4iaiATH5a3EjmMV3wqpinRnkNIIzJhknQz2wZ96miw/SyXkTQh7ljNg==
X-Received: by 2002:a17:902:7b94:b0:191:3ebd:c3a5 with SMTP id w20-20020a1709027b9400b001913ebdc3a5mr67556468pll.17.1673420977122;
        Tue, 10 Jan 2023 23:09:37 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b00192d07b8222sm9359429plx.100.2023.01.10.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 23:09:36 -0800 (PST)
Date:   Wed, 11 Jan 2023 15:09:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        mike.leach@linaro.org, sgoutham@marvell.com, gcherian@marvell.com,
        lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
Message-ID: <Y75gXmBZXQueCuvO@leoy-yangtze.lan>
References: <20230103162042.423694-1-james.clark@arm.com>
 <20230103162042.423694-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103162042.423694-3-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:20:36PM +0000, James Clark wrote:
> Remove some code that duplicates existing methods. This requires that
> some consts are removed because one of the existing helper methods takes
> a struct perf_pmu instead of a name which has a non const name field.
> But except for the tests, the strings were already non const.
> 
> No functional changes.

[...]

> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 2f2bb0286e2a..8f39e2d17fb1 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -2,6 +2,7 @@
>  #ifndef __PMU_H
>  #define __PMU_H
>  
> +#include <bits/types/FILE.h>

Nitpick: it's good to use <stdio.h> to replace <bits/types/FILE.h>.

Either way, this patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
