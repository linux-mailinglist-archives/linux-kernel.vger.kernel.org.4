Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B37494F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjGFFXP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 01:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGFFXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:23:13 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679E18B;
        Wed,  5 Jul 2023 22:23:12 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso3102775e9.0;
        Wed, 05 Jul 2023 22:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688620991; x=1691212991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMivQtxtxVUkXur2SbbNLbhHmemosTg/TiJqhMBJ3M0=;
        b=BEyHmsRnqke93A03sYAeIn+Rc7Y28fo5yzhEhD9z2I1CRebSP3JylX17xp/GJqkU82
         koKsy18ggkczr3rZvgM/tz52psSJrmjo6MOEP+tMVxymYUfqLoEiEpnIUcyU8Uy+rCel
         J4QsHlwGQgLJav6qvjpgMj5Em3bTJHPR8k9+WGusFVAsWawJPoq65CDsmjmEuLdXO79c
         YYxZlwDALi2v7iGGSCEr+/QBPWBWYqEu2Xhge/IceetayNJjgW+W/6hVpqgubXsL2flo
         m26Y+Xb0e2fGLd2eouUchA9M4GHbrfU2n/KnFhhP/4cE1IFcS2P5ZnnN6gvRAP7IO993
         Lfiw==
X-Gm-Message-State: ABy/qLZyjDtVdHtoanUjtg+8H0IYcBX8e7M6mRQRtlRPU070xKHCFFX6
        zgzWzCm8RjZ/lRQDK5TaamKurb1DDvSJxY8vnes=
X-Google-Smtp-Source: APBJJlH7tOA4DkAWHPhcX+7tjzo2ZuUlCn7WFo5kWzL1Ww/wCAhcVy50CtWBo7tnpsDUEdqHNhCDPo4eEDxrBKSBdxA=
X-Received: by 2002:a1c:7416:0:b0:3fb:b3aa:1c88 with SMTP id
 p22-20020a1c7416000000b003fbb3aa1c88mr438796wmc.26.1688620991009; Wed, 05 Jul
 2023 22:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230705082653.23566-1-james.clark@arm.com>
In-Reply-To: <20230705082653.23566-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 22:22:57 -0700
Message-ID: <CAM9d7chiPmHkbNh2vAT3tU5skWVy-Eu10_igZErJ4wC0VLzSiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf test: Fix event parsing test on Arm
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 1:27 AM James Clark <james.clark@arm.com> wrote:
>
> Changes since v1:
>
>   * num_entries() -> num_core_entries()
>
> James Clark (2):
>   perf test: Fix event parsing test on Arm
>   perf test: Fix event parsing test when PERF_PMU_CAP_EXTENDED_HW_TYPE
>     isn't supported.

Applied to perf-tools-next, thanks!
