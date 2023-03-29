Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB06CEC16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjC2Osr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjC2OsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:48:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0C11B8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:47:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b7so338081pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680101256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vkIx82vxHUxasJUQGPHlcad9JIpsq+cAvDr1GutREnU=;
        b=w2hGU03ndtZNATot+6jleng8JvxmnajdGyNHS6uO4tn7ZQ4LbqTAhwJ2fD4lzKHm52
         Vldv8QxUmibNgV6p+bxQmJ1vQK7GPBU6I/wIAmHawV7cf9zt7jRFcPKGr1t0IFi5dDX/
         SawxTalo5eCK/CGbx4g/m3WKDFK0GUwbeURuiok6t8Kk9cVBITXx3DB7i2/minjhGYVW
         gU4eSyRc0OJiJ44FoOVUhqbvqBwiumA67wNZCvA8fHpqCne6wChuajU3vPvth6YkP8V4
         jy5FC2fzuOMP/TX911Gpq+x/Zr5GUoAz1ZGtDzn6NHmyfoUeSwjisLWDwDYQUtf+u6yy
         j0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkIx82vxHUxasJUQGPHlcad9JIpsq+cAvDr1GutREnU=;
        b=IsXCgW8TybDobKV1Zt3gJplfMxRP5Zdhtyymbsfnbvd/ciRts9sY+RhAdc5im3delj
         YIVA4XUFCQeLrKnwaLwfKeC+F7M1vya071jruB8wskB3PCm0BC1VTBTMm5IlbYhJIoJz
         JDnBPV9BqcwTQjVWdBUBXcnrXCjvQLJ9Du2JeoDlfj4ORgcZsNaNfXP+inExzJfaUj6c
         uCE+2DgN3uZUlP/angqCxICYlmQwjGCThjtg+BlYd2Efrh9XSBYkBrM67l9jAN3kv008
         SQOMA/NQAkUo7IHxiV5pFf82yVS6NQNZ2giJytKxLJ/j/cXQEAfRhifMc2WmPWNcqqJd
         ngPA==
X-Gm-Message-State: AAQBX9eOtgrKydMmo+32PsEsAVHLpWNi2A9sksZqw5j1IdasaNT+If1d
        Mx5GmDNTPr3pTTqDCQlqEnd47J3pf1LY+Pd68XBCnw==
X-Google-Smtp-Source: AKy350b8EHJoKCyK8Zr0M23UFnC3QLJmNC+h7Va2BvOe0Y6c1aHg5e8SQUnYr7TFmbL5LW+oLTMvEctqsRKad18gX1o=
X-Received: by 2002:a63:d307:0:b0:50b:dda2:6140 with SMTP id
 b7-20020a63d307000000b0050bdda26140mr5521846pgg.11.1680101256089; Wed, 29 Mar
 2023 07:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230329111422.3693-1-mike.leach@linaro.org> <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org> <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com> <ZCQ7nhrISA+jCfnI@kernel.org>
In-Reply-To: <ZCQ7nhrISA+jCfnI@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 29 Mar 2023 15:47:25 +0100
Message-ID: <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 at 14:22, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Mar 29, 2023 at 01:59:10PM +0100, Mike Leach escreveu:
> > Sorry - my error.
> >
> > The same change is made in patch 3/3 of this set.
> >
> > Looks like I didn't do a patch by patch build check when I was testing yesterday
>
> np, its fixed now and pushed to tmp.perf-tools-next, please check, will
> go to perf-tools-next later today after passing thru my set of container
> build tests.
>
> - Arnaldo

tmp.perf-tools-next - Builds and tests OK

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
