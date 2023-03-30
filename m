Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC26CF924
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC3Cc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjC3Cc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:32:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1055245
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:32:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a16so15917920pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680143545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3cJZfEXazIu0RyCr6dj5L3jtGo+WiGbTKxGLGBfEyo=;
        b=MBFKxmiUeIKmhWq8oeCh+GRAwRucQ7yAnW5myJl/xjb/CMm18Irj+t0hkbFJZetlZg
         kp28RJDE75Xsd3aEcaQU5aQngMEaNkTiVd96w/qk2FYx7aqvAyMfPDjtn9hWJDgt12cK
         bocoOOYGFfslK50UwpBKfY5BaV7cFLhdvCxJhjSkA8DenK5FE+zj5YiduMfEXM/2t5l3
         I4B0QFPB9pYefBbSwYnFLPYcD9ODLH+asd6vlOytqQuGee8nrFB1hI8dPpA63tz3LJb1
         IaEtm234YrJxi8dtZJ+NfxZDN+QJK9m3K+meSq9CsSenPhBtriMnR5icR8cZlw5WeibR
         6H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680143545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3cJZfEXazIu0RyCr6dj5L3jtGo+WiGbTKxGLGBfEyo=;
        b=AgeuOP6TDd1q3a5TXWPkx5I1hmOxTDl4BWldeeVJLRyceJYyGyh1q0QWo/VLDZa+fT
         xVvRrCkR5cfPcSqnwxqxxWIXyuBbLJtnqxliZT2LrTZbkzQppaZr6BTl7DGyXlODmU6/
         QNvhYN0pu+Tp39/JYH2k0TjjQlXVqm/7BOs+DFkPkcHKYR7I49riQ/m69o/UaUpEHMH8
         Z0t8btrxO3+z/aM8vKS1h2OdCYHQ2SMkRwh9r/OBnhzPLIebRaKtLRy3HBx4WVMK1dBV
         /DbgIb1eB7DQgBgdaBrzqmHHJiPsQjLXkjVwk6y9JIGPAqEMjTea6VP7qdH5xDqmtAy1
         EVPw==
X-Gm-Message-State: AO0yUKW1aBoIP+LIl4quLY+yow/ICoGUUyCDSCpyghDNHccj/ypZjqjU
        uPqevOsURiekWdJGhtACchUpx+alZl9EsSI/Xjlgpw==
X-Google-Smtp-Source: AK7set8R0cmMRUfzW0dAO2ZSj8Ig0qWUemT7PvM0jB5gvDRukyHROfrLICELC4ok8IJX4z2tNJ2wPg==
X-Received: by 2002:a05:6a20:e1e:b0:da:b92c:a949 with SMTP id ej30-20020a056a200e1e00b000dab92ca949mr18496286pzb.36.1680143544883;
        Wed, 29 Mar 2023 19:32:24 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.100.185])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005dd65169628sm24486846pfo.144.2023.03.29.19.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 19:32:24 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:32:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Add raw decoding for SPEv1.3 MTE and MOPS
 load/store
Message-ID: <20230330023219.GC252145@leoy-yangtze.lan>
References: <20230327162057.4057188-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327162057.4057188-1-robh@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:20:57AM -0500, Rob Herring wrote:
> Arm SPEv1.3 adds new load/store operation subclasses for Memory Tagging
> Extension (MTE) and memory operations (MOPS). The memory operations
> are memcpy and memset. Add support for decoding these new subclasses in
> the raw decoding.
> 
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org
