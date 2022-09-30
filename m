Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3AE5F0DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiI3Olx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3Olv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:41:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EB10502E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:41:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u24so6229193edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/1DxuLJFLLsCcKR9xIk/BovDONGX4FOkeIuowA2lYU0=;
        b=pbDuPVnXVQSqgprmcVlW0DAPHC+MGTmo5rSeDEcxUAoBd0kQjtq5RNHKDR+Ongl4Qw
         kbi9DoKcWs7lfkeHXRtT2WTMm7sQqlu0U86+Kvk85znR3zD4Wyhzgz2NqApjHAVQewIl
         0sjYlH6eZgX4uBw0OMgVCDp4kUkRPfarhBOrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/1DxuLJFLLsCcKR9xIk/BovDONGX4FOkeIuowA2lYU0=;
        b=ujXA8zfykXtJQwUvvzQpZCQC73SDs+UeMk1YOdMC0wdnYVDsNY0CCtfjTa/S2kzIhp
         ljROyy81FvolRxy7qI75ZlsjLGQHCn9IEn++8CrPYiL/tKgtUB21ZqX1HG2KsOIsQsBX
         qMo4GxJgUaTQ2CSf/DeQVU3Ixfs2VgYrohBoa4c0JCMsqH056im3Xn1eJLC99UeJy/Gb
         ehdkMIc17/kaP1jD2CDQa7Ppr4WQPZVrIIClUl0YN6RNu3jNwH0FeUqo/hzlhN8sAJ0R
         CsCMJrn5E/LSQrYBG1ocoRed0paG9CfUZjqLmwtpdPF+CvAP8QYH3xHQCfpKpTZqez5P
         GqYA==
X-Gm-Message-State: ACrzQf1p5HbG9Ma2OySz4TBcgkXR2dlm/FO5PQGYhYzgaxuQt7C+NsI5
        FmKxqMhcJIWoNk48BgL/1J/6EPvLPqf3nd+CTZLGrg==
X-Google-Smtp-Source: AMsMyM6AlbQvk93q+vtvXPIVZUD9mqNYY1hSvy1NLQDca7i/j/uo7rYkrbiQwKPrZPitZ3Fmj6DypqmLVhCpERceUL0=
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id
 ek12-20020a056402370c00b004539fab1b53mr8307036edb.28.1664548908613; Fri, 30
 Sep 2022 07:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
 <20220929163944.195913-1-tycho@tycho.pizza> <CAJfpegtcHW8AwjfjDSm8Y7OXbesrw=ZpX-CMujJ=1Zz_Ly2FdQ@mail.gmail.com>
 <Yzb20Y4wHrqUZ93Z@tycho.pizza>
In-Reply-To: <Yzb20Y4wHrqUZ93Z@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 16:41:37 +0200
Message-ID: <CAJfpegsZk+R2wmXo_358J6YrxLaWN7=VAUEUaGjF1Jveb+qKJQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: In fuse_flush only wait if someone wants the
 return code
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sept 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Fri, Sep 30, 2022 at 03:35:16PM +0200, Miklos Szeredi wrote:
> > On Thu, 29 Sept 2022 at 18:40, Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > If a fuse filesystem is mounted inside a container, there is a problem
> > > during pid namespace destruction. The scenario is:
> > >
> > > 1. task (a thread in the fuse server, with a fuse file open) starts
> > >    exiting, does exit_signals(), goes into fuse_flush() -> wait
> >
> > Can't the same happen through
> >
> >   fuse_flush -> fuse_sync_writes -> fuse_set_nowrite -> wait
> >
> > ?
>
> Looks like yes, though I haven't seen this in the wild, I guess
> because there aren't multiple writers most of the time the user code
> that causes this.
>
> I'm not exactly sure how to fix this. Reading through 3be5a52b30aa
> ("fuse: support writable mmap"), we don't want to allow multiple
> writes since that may do allocations, which could cause deadlocks. But
> in this case we have no reliable way to wait (besides a busy loop, I
> suppose).
>
> Maybe just a check for PF_EXITING and a pr_warn() with "echo 1 >
> /sys/fs/fuse/connections/$N/abort" or something?

AFAICS it should be perfectly normal (and trivial to trigger) for an
exiting process to have its dirty pages flushed through fuse_flush().

We could do that asynchronously as well, generally there are no
promises about dirty pages being synced as part of the process exiting
.  But ordering between dirty page flushing and sending the FUSE_FLUSH
request should be kept.  Which needs more complexity, unfortunately.

Thanks,
Miklos
