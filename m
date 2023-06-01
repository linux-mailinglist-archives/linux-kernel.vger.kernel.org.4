Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88E771F42F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjFAUtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:49:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730599;
        Thu,  1 Jun 2023 13:49:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-652d76be8c2so63241b3a.3;
        Thu, 01 Jun 2023 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685652578; x=1688244578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NFle+2quE+iVu1iFr+Pdl8V/lsTChZS2X+Ytwx9y/DM=;
        b=Nar4E7tlEdy35gy+DiOITbbZ0BJ1FLnBR2zDV5GaRfNf/7NEOI7NGcqVZPvR7W4M60
         j4tpmglxIicgDiYqhX5fKa68K6wD91GAKJn6D11MW5b++laxwjlMyUrTeY5FsRL2duSe
         dpiVMjMbmgbmqqN5RJVp16iIl0FC8owfN5AF4ecqS0CCwZNWoiCG3UtU6hgA/dZxDSfJ
         i+IqmXrtmRF6vl8buB+9qD785P2hy2Ck+35VGI72xrJXWbac21aPnJ3bFANTNh/svrA0
         8DgOnm+UjQywB2N8NWCWpxMARLEIKYNsPqGxFVoBXO9yGDWIWG7qmnCLUoenMoby4cx2
         /EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652578; x=1688244578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFle+2quE+iVu1iFr+Pdl8V/lsTChZS2X+Ytwx9y/DM=;
        b=DfVXhxCPaFnLsFQQOftO8y5Dc9gZB+RkUU1rY5BePb/1uFEOFo3pNDiDF21PvAIVKG
         XHVUQxtrYtDUX38fzk0TxQFBhg18amGYlANWglRI3Z86tWrL5TKjsj9CiLE3KCEjrONy
         Rk1v05kFCIEWQ8OjyOJIjxPAzCY2Q5qGGFhQawIX/yVnhoyKdUJlrEJrQb0s3lMkFu4P
         LkDXIqZnG5ypUF5KUrxTPytaCoMudgO8ag3yqPJqRR1/qeGZu8LOBMXQwoZUL8SKJpel
         RFzI4G0xL/KAX5MW6454BTMJ2H60kERbwVgOAxINoRuAhnsY6GXgBMw2XrzSS2JbRnqU
         J1fw==
X-Gm-Message-State: AC+VfDw+QpfwwpM0lLzmyfDu5UZufyDi2B6XVBwy4v1dVolySxEg6RRf
        tnjCeZbiOPkTCl0LGC6kOo0qVBi3vnqGaCUl
X-Google-Smtp-Source: ACHHUZ6OUyO524uHrlOh42mwJoWxar07gxBYwVYGhQD8nyNuSCqXJC9T918IIkwf+kBto172xn+QJg==
X-Received: by 2002:a05:6a20:2d27:b0:10c:ff51:99bb with SMTP id g39-20020a056a202d2700b0010cff5199bbmr12812254pzl.20.1685652578093;
        Thu, 01 Jun 2023 13:49:38 -0700 (PDT)
Received: from yoga ([2400:1f00:13:1f00:ef4e:82b7:f2a:86f6])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0063b7c42a072sm5674708pfu.13.2023.06.01.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:49:37 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 2 Jun 2023 02:19:30 +0530
To:     linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <ZHkEWse0NVZhwKR7@yoga>
References: <ZG5kjDN63HqqMuJJ@yoga>
 <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHENW4HOIo0F6FnN@yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 01:19:47AM +0530, Anup Sharma wrote:
> On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> > On Thu, May 25, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Anup,
> > >
> > > On Wed, May 24, 2023 at 12:25 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> > > >
> > > > Hello everyone,
> > > >
> > > > I'm happy to share that I'll be working on adding support for Firefox's Gecko profile format.
> > > > This format is utilized by the Firefox profiler, which is a powerful tool for performance analysis
> > > > and debugging. By enhancing the perf data command to generate perf.data files in the Gecko
> > > > profile format, it will allow us to leverage the capabilities of the Firefox profiler for visualizing
> > > > and analyzing the performance data.
> > > >
> > > > As a starter task, I have created a test for testing the perf data JSON converter command.
> > > > I'm also looking for a few more starter tasks related to this project. I would greatly appreciate
> > > > your advice and guidance.
> > > >
> > > > In my effort to identify any existing bugs, I have enabled flags like 'fsanitize=address' to detect
> > > > potential issues but have not found any :). Additionally, I am running perf data commands to ensure
> > > > that all use cases are handled properly.
> > >
> > > Great, good to know it works well with asan for the basic use cases at least.
> > >
> > > >
> > > > I have one question regarding the installation process. Typically, I navigate to the perf directory,
> > > > run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that by default, perf is installed in
> > > > the '~/bin/perf' directory. Could someone please clarify why this is the case? Furthermore, I would
> > > > like to know how all of you compile the perf tree.
> > >
> > > I guess $HOME is the default prefix unless you set it to other, then
> > > make install will put
> > > the binary there.  You can make sure if your PATH contains the ~/bin and use it.
> > >
> > > But it's also possible you can run the perf without installing.  I
> > > have a symlink in
> > > my tmp directory to point to the recent build of the binary and use it
> > > always. :)
> > > To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
> > > in the top
> > > level linux source tree.  I also pass "BUILD_BPF_SKEL=1" to enable BPF.
> > >
> > > Thanks,
> > > Namhyung
> > 
> > I quite often test with address sanitizer, I do this by passing to make:
> > DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame- pointer
> > -fsanitize=address" NO_LIBTRACEEVENT=1
> > 
> > The libtraceevent exclusion is to avoid false address sanitizer
> > warnings in libtraceevent (it wasn't compiled with address sanitizer).
> > The other flags are to make the code easier to debug. A good place to
> > start for a description of the build flags is Makefile.perf:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.perf?h=perf-tools-next
> > 
> > There's also some description here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/Build.txt?h=perf-tools-next
> > 
> > Perhaps you can suggest improvements :-)
> >
> 
> Thanks Namhyung and Ian for your suggestions. I'll try them out and let you know if I have any questions.
>

Hello all,

Thank you for participating in today's office hours and helping me clarify my doubts. 
One topic that emerged from our discussion is the choice of programming language 
for writing the converter. I am considering using Python as it offers convenient
libraries for JSON manipulation. However, I need to investigate whether Python is
enabled by default in most of the Linux distributions that ship with perf, as its
absence could pose a potential obstacle.

Additionally, two profile formats are available: Gecko profile format and Processed profile format[1].
Upon discussing on Firefox Profiler matrix channel, they recommended opting for the Processed format,
as it will be supported in future releases as well. Therefore, I intend to begin by working with the
Processed format and evaluate the results. If any of you have suggestions regarding the choice of 
format, I would greatly appreciate your input.

Later on, I will address concerns I have regarding the file-loading process.
Once again, thank you all for your time.

Thanks, 
Anup 

[1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/custom-importer.md

> > Thanks,
> > Ian
> > 
> > > >
> > > > Thank you for your support and I'm looking forward to collaborating with you on this project!
