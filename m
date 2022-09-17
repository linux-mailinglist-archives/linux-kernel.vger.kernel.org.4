Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155AD5BB501
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 02:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQA3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 20:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQA3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 20:29:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9959BA154
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:29:07 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g5so34806911ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+HxepImlUydRiKuaywPNMKwGNoxJ1/ntVZdpC/RkL38=;
        b=QapHkMhS91QlqU3YEoqsunZ2Qx1Fo7W9geL3/D1pUEoEd3mVs0sqhBn9CMinDkocAH
         MDqqbNAh7G0+sZy+N5HlrZ5JX1pCdg4+i+g5fnkUJOUP13AMsdItIG45YBuOWPUdPliK
         1ZL9COqOCGn/AJXxCvI8Jl9XXIeqUuusbByGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+HxepImlUydRiKuaywPNMKwGNoxJ1/ntVZdpC/RkL38=;
        b=7pGYZetHBlAZNG2T4Eeb6rz6WehfxzqdbLTviyvf/j3C1ULo+RvGhckDK197r5lsw5
         4MO2MQv4MRu3JOiaDQaEhJNZ6Ufkk0rCWzsQYwKjDFiRzYpp7NhzV1bqcIx3QUnD0fsW
         qX5D0SVmrgm0gAOuV+LwaXLp3oEyBeHlzhY53BqH6zitlW2FYYQ8lgHJvLfr7Tyc3QPW
         WlZXhOkyNuvlrRe9SWCo3Y2nxscmpfvTMCiHHkwurXnGpFI3Kn7AxtSnCO5LBgVkwKVo
         ZUCgb/rnBlNGeW2AyjdjXxXTZaAVWAovPKIqDjw+/F/LDbu3s1o19pFR3xxFj/xsJ/Tl
         +HDA==
X-Gm-Message-State: ACrzQf1cu+CYKNs0kadayfDy8dWnTI8CQ7rmhD+mBrMY9I31betOylb/
        /NknCMHP0jnMJ27LFantoPr3DEDHq0D8ogm79NuW7w==
X-Google-Smtp-Source: AMsMyM7R4xl3/sm1opae870FiGQ2n7amMJehgFy3haRpr9GGguwVxzuB7DEx/HSpRFXd6RTjUm81+ggn1lRODY5IPnk=
X-Received: by 2002:a25:f504:0:b0:683:2272:6c42 with SMTP id
 a4-20020a25f504000000b0068322726c42mr6610179ybe.558.1663374546947; Fri, 16
 Sep 2022 17:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220916230853.49056-1-ivan@cloudflare.com> <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
In-Reply-To: <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 16 Sep 2022 17:28:56 -0700
Message-ID: <CABWYdi19enVm2VAjrGE75DU3C3w7OSs_s9CzOLdJh=DRO0K6Kg@mail.gmail.com>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 5:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> (cc's added)
>
> On Fri, 16 Sep 2022 16:08:52 -0700 Ivan Babrou <ivan@cloudflare.com> wrote:
>
> > Many monitoring tools include open file count as a metric. Currently
> > the only way to get this number is to enumerate the files in /proc/pid/fd.
> >
> > The problem with the current approach is that it does many things people
> > generally don't care about when they need one number for a metric.
> > In our tests for cadvisor, which reports open file counts per cgroup,
> > we observed that reading the number of open files is slow. Out of 35.23%
> > of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
> > `proc_fill_cache`, which is responsible for filling dentry info.
> > Some of this extra time is spinlock contention, but it's a contention
> > for the lock we don't want to take to begin with.
> >
> > We considered putting the number of open files in /proc/pid/stat.
> > Unfortunately, counting the number of fds involves iterating the fdtable,
> > which means that it might slow down /proc/pid/stat for processes
> > with many open files. Instead we opted to put this info in /proc/pid/fd
> > as a size member of the stat syscall result. Previously the reported
> > number was zero, so there's very little risk of breaking anything,
> > while still providing a somewhat logical way to count the open files.
>
> Documentation/filesystems/proc.rst would be an appropriate place to
> document this ;)

I am more than happy to add the docs after there's a confirmation that
this is an appropriate approach to expose this information. I probably
should've mentioned this explicitly, that's on me. There are two
alternative approaches at the bottom of my original email that might
be considered.
