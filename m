Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE7712DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbjEZTuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEZTt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:49:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AF9E;
        Fri, 26 May 2023 12:49:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1afbc02c602so19119635ad.1;
        Fri, 26 May 2023 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685130597; x=1687722597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2I0hQQzW2yDargibYWu+DA87dItM0w7zY2FsfJCnPOc=;
        b=FEaZIJ9A8oOy00alMc7o2MKrBaJuo41U7UYtyYXnyI6zwjaq7K8zGUSjpwXzKDECDS
         ayEhzaApqjvXvWihVb0SROvdi345okSy72sMe1Pjre8AtKFSRzPozyp+jCp+aX6/780F
         mmyT4JSziG5WBeLVSqRcWgsY9RrYP/f9qN8AauiVRZM3q0j6OcxBFygf42GwPkt9qmZV
         2SqkRYKuHldaqSsTq7pYstdQ7YRIgcXWDWTpGzj7/BbwVUGnDW4LNqBSw0ep8RtpYjCf
         8Bbz9mN+A5JM1j1y4gSRV07Fi4VQ+RNBb+dzm27ADiHVVcOZuEh831zPqExmfZYLPMN4
         WMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130597; x=1687722597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I0hQQzW2yDargibYWu+DA87dItM0w7zY2FsfJCnPOc=;
        b=ifNRzn/+0+XN15nifGF1fUORt8UNJViILRHzooqlWtqPVpv11nv9X2GlHTRTz2Y9Il
         0AGtf0DwkAGBWM5iLhaud0ptobVH9JQurcVbd2E2VmByuu3ZWpy+f59VKl8gJfr5XVYO
         CWp0yMQMKH8aF7cKHtWD/7iFfwOW9zXb77KyoSi8xW+z0GQYFmSY070F0Nu5kwtUv07S
         v9is91e1RkgO+hyG6OppsVshUARr5+hxmrWKLObCbXo/XGDDn4nFcBMAiTbHa0k+5oSz
         x2+2d3hRp6AaeRjw8ejU+w9kTsQ7pxxGtMe2vUjefGAxjmYsG1MbsQuaWTl04l+5hL0J
         MVDA==
X-Gm-Message-State: AC+VfDxxmf9pbNPYo5MdlekfcxALRvAP5C1cAHRUrjdJLgUDP+SlL6gz
        GzYzXhgua8GleESfdQJyhr0=
X-Google-Smtp-Source: ACHHUZ6l5IG3mC3AStAa0GO7GoPS0h5QjiyFPJlsnQJYzQQrp9Ldv7mbYMr3Nw9jnE5NPtrwd1sWZg==
X-Received: by 2002:a17:902:db10:b0:1af:ccc9:ce65 with SMTP id m16-20020a170902db1000b001afccc9ce65mr6704plx.28.1685130596833;
        Fri, 26 May 2023 12:49:56 -0700 (PDT)
Received: from yoga ([2400:1f00:13:58f8:114f:2b88:a753:89bb])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001aaeaa27dd5sm3594561plg.252.2023.05.26.12.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:49:56 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Sat, 27 May 2023 01:19:47 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZHENW4HOIo0F6FnN@yoga>
References: <ZG5kjDN63HqqMuJJ@yoga>
 <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> On Thu, May 25, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Anup,
> >
> > On Wed, May 24, 2023 at 12:25 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
> > > This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
> > > and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
> > > profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
> > > and analyzing the performance data.
> > >
> > > As a starter task, I have created a test for testing the perf data JSON converter command.
> > > I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
> > > your advice and guidance.
> > >
> > > In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
> > > potential issues but have not found any :). Additionally, I am running perf data commands to ensure
> > > that all use cases are handled properly.
> >
> > Great, good to know it works well with asan for the basic use cases at least.
> >
> > >
> > > I have one question regarding the installation process. Typically, I navigate to the perf directory,
> > > run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
> > > the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
> > > like to know how all of you compile the perf tree.
> >
> > I guess $HOME is the default prefix unless you set it to other, then
> > make install will put
> > the binary there.  You can make sure if your PATH contains the ~/bin and use it.
> >
> > But it's also possible you can run the perf without installing.  I
> > have a symlink in
> > my tmp directory to point to the recent build of the binary and use it
> > always. :)
> > To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
> > in the top
> > level linux source tree.  I also pass "BUILD_BPF_SKEL=1" to enable BPF.
> >
> > Thanks,
> > Namhyung
> 
> I quite often test with address sanitizer, I do this by passing to make:
> DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame- pointer
> -fsanitize=address" NO_LIBTRACEEVENT=1
> 
> The libtraceevent exclusion is to avoid false address sanitizer
> warnings in libtraceevent (it wasn't compiled with address sanitizer).
> The other flags are to make the code easier to debug. A good place to
> start for a description of the build flags is Makefile.perf:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf-tools-next
> 
> There's also some description here:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/Build.txt?h=perf-tools-next
> 
> Perhaps you can suggest improvements :-)
>

Thanks Namhyung and Ian for your suggestions. I'll try them out and let you know if I have any questions.

> Thanks,
> Ian
> 
> > >
> > > Thank you for your support and I'm looking forward to collaborating with you on this project!
