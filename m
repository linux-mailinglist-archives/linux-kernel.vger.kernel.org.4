Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB03723284
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjFEVsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjFEVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:47:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B523D2;
        Mon,  5 Jun 2023 14:47:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2564dc37c3eso4853663a91.0;
        Mon, 05 Jun 2023 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686001677; x=1688593677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRCWb92eslY3If4y48w+1ybK5UGe1Uv8OM5AIElN3xI=;
        b=q6oYbEYemCtG/Bz9JoV4sdaQSoedE0qwwerb/Ux5axiSG+45zRQv3GEFotosT/nKlc
         7lQpbM0BkEOaiLovbtU8eLuNtBivYxbdJBbpkNsoSFvq3tT3Gb1zXl91vKr0cumRICWr
         PJexaUKDKRJxfh4m/X2Gqr68oJvAp9XCThXBOdTWhJcJXrpmgIzy3y/dhd+ai90WzhEe
         ZE70unHSweoDX/4zxGfUqBsp1Sz2LWHa9T0gQ8nOx4O2xHMenJwnP3jLgquRI3nud3BN
         1+H14v6yPgkRKzysfrrAE3fFsbqGFrCX5rRPbF0eIU939P/6Mbe6aQ59LZbe1o/7Sc5N
         OwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001677; x=1688593677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRCWb92eslY3If4y48w+1ybK5UGe1Uv8OM5AIElN3xI=;
        b=GtlTznu5CjXkWMxCLtzwP64ymU2ef4ccqu2T5QeutOiFWaCzLMIxlMPTJinbovox5l
         MIuI0qD8CTr8hEYxca6kcc9ShDXigCIF+WbnNas4jW6+NhWknu6uB2dHbcdv7+Ikw6Ie
         yoph1w8Q34AsXYNGT0Reh2CKxPYsdtODgSvgp9qfUCwc5COE2XSg4SQYG2a0oDMYD3mi
         yuuBeQIW8lP93zCYpgtT2gYXVZZYJIX4C/1TRcTdS5vN+cPmpiz4f8uThtu0Vm6gixjj
         z7s/O5vzPpLhwJYqQrqxQFDANIOT3Z1Ot1NpvjFcfZ6MRXopLDUEPfhvKSQq47CnqASq
         BdrA==
X-Gm-Message-State: AC+VfDxawQaxRwg9vYvo5VAl6i+956cB+qhHe4Rhqm1tdM2yckzVDjRo
        A/wbkONyahYzCcxrPM8FWX8=
X-Google-Smtp-Source: ACHHUZ7qv/jqKzNzG6E3n8xBgkvo9NRVnOOkV4Tdn1fJchGNI92akceb3eW99XYRoI67ggPJBAejNg==
X-Received: by 2002:a17:90a:de14:b0:256:2056:ee52 with SMTP id m20-20020a17090ade1400b002562056ee52mr244219pjv.17.1686001677333;
        Mon, 05 Jun 2023 14:47:57 -0700 (PDT)
Received: from yoga ([2400:1f00:13:129e:90cb:29f2:26ab:44a9])
        by smtp.gmail.com with ESMTPSA id o70-20020a17090a0a4c00b0025063e893c9sm8607253pjo.55.2023.06.05.14.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 14:47:56 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 6 Jun 2023 03:17:48 +0530
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
Message-ID: <ZH5YBBWW5ANckoMp@yoga>
References: <ZG5kjDN63HqqMuJJ@yoga>
 <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga>
 <ZHkEWse0NVZhwKR7@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHkEWse0NVZhwKR7@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:19:30AM +0530, Anup Sharma wrote:
> On Sat, May 27, 2023 at 01:19:47AM +0530, Anup Sharma wrote:
> > On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> > > On Thu, May 25, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Anup,
> > > >
> > > > On Wed, May 24, 2023 at 12:25 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
> > > > > This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
> > > > > and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
> > > > > profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
> > > > > and analyzing the performance data.
> > > > >
> > > > > As a starter task, I have created a test for testing the perf data JSON converter command.
> > > > > I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
> > > > > your advice and guidance.
> > > > >
> > > > > In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
> > > > > potential issues but have not found any :). Additionally, I am running perf data commands to ensure
> > > > > that all use cases are handled properly.
> > > >
> > > > Great, good to know it works well with asan for the basic use cases at least.
> > > >
> > > > >
> > > > > I have one question regarding the installation process. Typically, I navigate to the perf directory,
> > > > > run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
> > > > > the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
> > > > > like to know how all of you compile the perf tree.
> > > >
> > > > I guess $HOME is the default prefix unless you set it to other, then
> > > > make install will put
> > > > the binary there.  You can make sure if your PATH contains the ~/bin and use it.
> > > >
> > > > But it's also possible you can run the perf without installing.  I
> > > > have a symlink in
> > > > my tmp directory to point to the recent build of the binary and use it
> > > > always. :)
> > > > To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
> > > > in the top
> > > > level linux source tree.  I also pass "BUILD_BPF_SKEL=1" to enable BPF.
> > > >
> > > > Thanks,
> > > > Namhyung
> > > 
> > > I quite often test with address sanitizer, I do this by passing to make:
> > > DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame- pointer
> > > -fsanitize=address" NO_LIBTRACEEVENT=1
> > > 
> > > The libtraceevent exclusion is to avoid false address sanitizer
> > > warnings in libtraceevent (it wasn't compiled with address sanitizer).
> > > The other flags are to make the code easier to debug. A good place to
> > > start for a description of the build flags is Makefile.perf:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf-tools-next
> > > 
> > > There's also some description here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/Build.txt?h=perf-tools-next
> > > 
> > > Perhaps you can suggest improvements :-)
> > >
> > 
> > Thanks Namhyung and Ian for your suggestions. I'll try them out and let you know if I have any questions.
> >
> 
> Hello all,
> 
> Thank you for participating in today's office hours and helping me clarify my doubts. 
> One topic that emerged from our discussion is the choice of programming language 
> for writing the converter. I am considering using Python as it offers convenient
> libraries for JSON manipulation. However, I need to investigate whether Python is
> enabled by default in most of the Linux distributions that ship with perf, as its
> absence could pose a potential obstacle.
> 
> Additionally, two profile formats are available: Gecko profile format and Processed profile format[1].
> Upon discussing on Firefox Profiler matrix channel, they recommended opting for the Processed format,
> as it will be supported in future releases as well. Therefore, I intend to begin by working with the
> Processed format and evaluate the results. If any of you have suggestions regarding the choice of 
> format, I would greatly appreciate your input.
> 
> Later on, I will address concerns I have regarding the file-loading process.
> Once again, thank you all for your time.

I wanted to provide an update on my exploration of various tools
and methods to generate a profiler format. In my experimentation, I 
considered following command as a reference. 

perf record -F 99 -g -- perf test -w noploop

The command generated perf.data file has been used with three
different tools to generate the required format and uploaded them to 
profiler.firefox.com. Interestingly, I noticed distinct call trees in
each of the three cases. I find myself in a state of confusion regarding
which result to consider as a reference. Here are the outcomes:

    1. Result obtained using perf script: https://share.firefox.dev/3qxEt7F
    2. Result obtained using samply:https://share.firefox.dev/3OZsha2
    3. Result obtained using simpleperf gecko_profile_generator: https://share.firefox.dev/45Q2BTe

I would greatly appreciate any guidance or suggestions in this matter.

> Thanks, 
> Anup 
> 
> [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/custom-importer.md
> 
> > > Thanks,
> > > Ian
> > > 
> > > > >
> > > > > Thank you for your support and I'm looking forward to collaborating with you on this project!
