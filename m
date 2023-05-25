Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7F71187A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjEYUxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 16:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjEYUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:53:05 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E05D3;
        Thu, 25 May 2023 13:53:04 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-456f1cc1791so1223e0c.2;
        Thu, 25 May 2023 13:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047983; x=1687639983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpw7RNcTReU2qScwvfTVSMvkxHzv4Yt97VJVzcEC3uQ=;
        b=mIKan7oWD5ARYO0WX6l2CZRO0NCM/wl++M3vTVWDPrtD5WaQn8VvK9pv/d5ylNG0DO
         r8bltCfYdvQ43GMwwZQEfcWMYfaD9hXzRVJUhukknLfiJk2yb4OFKqR9dQv36SkC/Maw
         e756iXiGniDFFTNlzfdKFufPauL/uqYHLsMKvSPnvLVfIUlyJdP45eo1F7AHKVmml1bs
         GyRi/IEPS8vWcyRJT6J3TtbFHiapy05Kwys9UzdjGzV/vDATKQpe12SqwKiZD2oqzoNi
         Rr0Ad74NpTCzEYzfR+FxMxpXfd2GotbrM8viNwFZRV7K4icbomRXeBb46fzTj+hyXv30
         CQhA==
X-Gm-Message-State: AC+VfDyRzm4vgxpHWv7naKPmTg/YIn3D9gjHmFCVKTwM9s0U1gUzG9k8
        F4Lkjl5sf+JFiIy25w3jSBZnqdou5gnhVoptnVk=
X-Google-Smtp-Source: ACHHUZ5VsbV9KqpUNKJtWCFvi06cBt1kkTz+ekt+Wul+Uvb51lK85gIkefG2pchGbvxj6VU8XQdRQuMYk/OW5meTk2s=
X-Received: by 2002:a1f:438d:0:b0:44f:ef57:c49a with SMTP id
 q135-20020a1f438d000000b0044fef57c49amr7372307vka.11.1685047983337; Thu, 25
 May 2023 13:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZG5kjDN63HqqMuJJ@yoga>
In-Reply-To: <ZG5kjDN63HqqMuJJ@yoga>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 25 May 2023 13:52:52 -0700
Message-ID: <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Wed, May 24, 2023 at 12:25 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> Hello everyone,
>
> I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
> This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
> and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
> profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
> and analyzing the performance data.
>
> As a starter task, I have created a test for testing the perf data JSON converter command.
> I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
> your advice and guidance.
>
> In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
> potential issues but have not found any :). Additionally, I am running perf data commands to ensure
> that all use cases are handled properly.

Great, good to know it works well with asan for the basic use cases at least.

>
> I have one question regarding the installation process. Typically, I navigate to the perf directory,
> run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
> the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
> like to know how all of you compile the perf tree.

I guess $HOME is the default prefix unless you set it to other, then
make install will put
the binary there.  You can make sure if your PATH contains the ~/bin and use it.

But it's also possible you can run the perf without installing.  I
have a symlink in
my tmp directory to point to the recent build of the binary and use it
always. :)
To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
in the top
level linux source tree.  I also pass "BUILD_BPF_SKEL=1" to enable BPF.

Thanks,
Namhyung

>
> Thank you for your support and I'm looking forward to collaborating with you on this project!
