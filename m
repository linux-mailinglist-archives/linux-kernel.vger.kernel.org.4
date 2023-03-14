Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07E6B8D46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCNI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCNI07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:26:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE09AA35
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:25:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s22so18894782lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678782334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mNHNB7b1NtvxFvxeL3QlM6Gt0k+k8OB6GgAKuSCNv7c=;
        b=FLxeSI5dpfVKFQBOhtuUao2XVEA7o4+QNGwIeHkHIVIeF0+N7uWfAZCYq6HSlOckYJ
         uYIVRgc6x5eYVFvbXju5Xd4y9j/GLgY0x7Qx10/sl6CBhW+rAZTfBg4AtuVYACMFS1uS
         Jlb0BQ6mKohLxfdv3q8XL394Cx4HuExTMwKhQ8lJJt7hnYt5ZZNFGXiu020E9WDPGJhS
         BA1Ib0cf1ArG2npUo2XzSWi0EMtMFRyLK/04db2uGBxFwXKl+KFw3XpUhWcCnucB6dH5
         lw+kJyaxbCssU2a2EhWkoYdfP7JQT8U9WuOtBpEeNatkP7IVNkPj9rsADef6239tvXqv
         J90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNHNB7b1NtvxFvxeL3QlM6Gt0k+k8OB6GgAKuSCNv7c=;
        b=y1ZRGEiYQBXAmYTEDFCNXITs6mbPADQ78qWMwF3QFmpOA0FP5Zy8BP1k606y26WfIP
         76MPhxQBa9EVTMX27rBymSuann/V/AFWNaFgaTFwTTId+/Hz/8yZ9kd9+L4rBOU+dPnv
         8yw8qfyFPy7LTOcYGvLbP62hW/9GjGvF98fgn0/PyDbeA+DH3lrQMB5fy1T+KjSbT9ku
         8LF/mBSrPswYrJwXWClG8agiO/sGuK3ukaQB+S+3LARIxoL5ujg/5o8zgwc2lZ07bQIw
         2cRS0xDNz3opeWtB6seUgmhESzcTk5/5PWDUqLKdQaeokGgQer6kMD1S+PLl6n7v+jpw
         9DFQ==
X-Gm-Message-State: AO0yUKUOwiDCE8RPpegtAV2VJAFtT3QKK0C8qlkUxrbNMzcdf/KMn8CP
        kpB3RL/BkDB61d90GooAqXkKfuO7dm0nqQ+egkwHcw==
X-Google-Smtp-Source: AK7set9n2Bo15zmS9U4pJp+/z3GtiDGOYkUHMoNoyj+emM5XvZgbXYzNG1Yr4r4sqferDV2JMWh9I0cmwBh4t1olbe8=
X-Received: by 2002:ac2:46d4:0:b0:4dd:9da1:acd9 with SMTP id
 p20-20020ac246d4000000b004dd9da1acd9mr449286lfo.6.1678782334073; Tue, 14 Mar
 2023 01:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230126154118.2393850-1-dvyukov@google.com> <20230220144347.267585-1-dvyukov@google.com>
 <20230222151908.GA20057@redhat.com>
In-Reply-To: <20230222151908.GA20057@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Mar 2023 09:25:21 +0100
Message-ID: <CACT4Y+Yvp7qj_420fk6UiPNB+dsRzRssPf4K=fMSNBoLB1oBiA@mail.gmail.com>
Subject: Re: [PATCH v5] posix-timers: Prefer delivery of signals to the
 current thread
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 at 16:19, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 02/20, Dmitry Vyukov wrote:
> >
> >  kernel/signal.c                               | 23 +++++-
> >  tools/testing/selftests/timers/posix_timers.c | 73 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 3 deletions(-)
>
> For the change in kernel/signal.c
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Hi Thomas,

Do you have any remaining concerns about this patch?
Should I drop the test to not confuse people? Then it will be just a
few lines in signal.c.
