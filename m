Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DB7277F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjFHG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjFHG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:59:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0DC6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:59:10 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so48225ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686207549; x=1688799549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0czNx4xihVoYBZOBbjpQnU/SGKpkCpnJ5YtgwCexgwE=;
        b=n9QYYP67uD0xQw0IoZmhHl2rH69b+bIgBAiAdagbKa7AIlHi/0ybFS3Dc8KxlY0deL
         kY61SKti3pPms6raM5J8+J9PQtMafPDsK1qfhGB0nhwvNZ5n7E0YBn8nlr5XNagrvXoa
         +yaPwXc6W/cM+m1+wrvpLW3c6h+X8r4IFgr/rd2JM2FzgGZiG8mR84v9BVWO1ANN7rmz
         Eqw9kj+oG+53O5ezUXdQf07ejjp3cLJenafl5pT/7JI2V9C+aPXSkUe2ZDjBGoK7hphX
         vi0q82YfdN9erVlAL8Chxy4vg99icoNbTYJb1Yu7BLW3M0JUJeH0KDPVBf/mlTz3AW6O
         brHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207549; x=1688799549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0czNx4xihVoYBZOBbjpQnU/SGKpkCpnJ5YtgwCexgwE=;
        b=BbM7f4lAeEUpb10w7+lpduRODNyOqew4bAtcULJB+DhyPVT8aqVF9E8y30UyyRLICH
         4rn4sJgzh+3/3hrCFqTzbnYsdZsAMPHUfHkZ1hgZGxzCDv29ZloObLJ4T+ITYoTDD2yW
         Rd0l0XRVVvUn/jUfugDPUEWo1GH0Mlb5tvyWcj33WlENX5vZjA9GE1UNJ6vz6jUkvj4V
         in6FFkdFacrzesn7UC+X2zeV3pW5YC1VQwZbCM/Wd6dULDbFAj71ogHwHuBshQCN9xF4
         REUVXmqMMvAhqbvZLDkp2MNiVNtGfKV9Caanmh/5K2BbX+cLUVKSuvDg3X800kqhhKzX
         QFMg==
X-Gm-Message-State: AC+VfDwAVN9s02p7jK3PkX52BI5zKKzJuo6hDNOC1kc7PI0X+pZfmvtN
        oVt7IxGlafaf9cVaFI4RsCfb29p0DtOWpBvph6GzLw==
X-Google-Smtp-Source: ACHHUZ68VfU2GL62XATDvwCiDK4nqX19yKroKp3G6shFlntQvxL01aUK8BMx0sVOgxQNwEinq8d+IqmHKAZVD/PZKIs=
X-Received: by 2002:a05:6e02:216f:b0:33d:75d4:c83a with SMTP id
 s15-20020a056e02216f00b0033d75d4c83amr42441ilv.16.1686207549483; Wed, 07 Jun
 2023 23:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZG5kjDN63HqqMuJJ@yoga> <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
 <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
 <ZHENW4HOIo0F6FnN@yoga> <ZHkEWse0NVZhwKR7@yoga> <ZH5YBBWW5ANckoMp@yoga>
In-Reply-To: <ZH5YBBWW5ANckoMp@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Jun 2023 23:58:57 -0700
Message-ID: <CAP-5=fU7ukrQSh_8OwH9C+a-EwCamCrMaZxjqDhE9f+bFJwQBQ@mail.gmail.com>
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 2:47=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com>=
 wrote:
>
> On Fri, Jun 02, 2023 at 02:19:30AM +0530, Anup Sharma wrote:
> > On Sat, May 27, 2023 at 01:19:47AM +0530, Anup Sharma wrote:
> > > On Fri, May 26, 2023 at 08:17:44AM -0700, Ian Rogers wrote:
> > > > On Thu, May 25, 2023 at 1:53=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hi Anup,
> > > > >
> > > > > On Wed, May 24, 2023 at 12:25=E2=80=AFPM Anup Sharma <anupnewsmai=
l@gmail.com> wrote:
> > > > > >
> > > > > > Hello everyone,
> > > > > >
> > > > > > I'm happy to share that I'll be working on adding support for F=
irefox's Gecko profile format.
> > > > > > This format is utilized by the Firefox profiler, which is a pow=
erful tool for performance analysis
> > > > > > and debugging. By enhancing the perf data command to generate p=
erf.data files in the Gecko
> > > > > > profile format, it will allow us to leverage the capabilities o=
f the Firefox profiler for visualizing
> > > > > > and analyzing the performance data.
> > > > > >
> > > > > > As a starter task, I have created a test for testing the perf d=
ata JSON converter command.
> > > > > > I'm also looking for a few more starter tasks related to this p=
roject. I would greatly appreciate
> > > > > > your advice and guidance.
> > > > > >
> > > > > > In my effort to identify any existing bugs, I have enabled flag=
s like 'fsanitize=3Daddress' to detect
> > > > > > potential issues but have not found any :). Additionally, I am =
running perf data commands to ensure
> > > > > > that all use cases are handled properly.
> > > > >
> > > > > Great, good to know it works well with asan for the basic use cas=
es at least.
> > > > >
> > > > > >
> > > > > > I have one question regarding the installation process. Typical=
ly, I navigate to the perf directory,
> > > > > > run 'make', and then cp 'perf' to '/usr/bin'. However, I notice=
d that by default, perf is installed in
> > > > > > the '~/bin/perf' directory. Could someone please clarify why th=
is is the case? Furthermore, I would
> > > > > > like to know how all of you compile the perf tree.
> > > > >
> > > > > I guess $HOME is the default prefix unless you set it to other, t=
hen
> > > > > make install will put
> > > > > the binary there.  You can make sure if your PATH contains the ~/=
bin and use it.
> > > > >
> > > > > But it's also possible you can run the perf without installing.  =
I
> > > > > have a symlink in
> > > > > my tmp directory to point to the recent build of the binary and u=
se it
> > > > > always. :)
> > > > > To build, you can either 'cd tools/perf; make' or 'make -C tools/=
perf'
> > > > > in the top
> > > > > level linux source tree.  I also pass "BUILD_BPF_SKEL=3D1" to ena=
ble BPF.
> > > > >
> > > > > Thanks,
> > > > > Namhyung
> > > >
> > > > I quite often test with address sanitizer, I do this by passing to =
make:
> > > > DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fno-omit-frame- pointer
> > > > -fsanitize=3Daddress" NO_LIBTRACEEVENT=3D1
> > > >
> > > > The libtraceevent exclusion is to avoid false address sanitizer
> > > > warnings in libtraceevent (it wasn't compiled with address sanitize=
r).
> > > > The other flags are to make the code easier to debug. A good place =
to
> > > > start for a description of the build flags is Makefile.perf:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree=
/tools/perf/Makefile.perf?h=3Dperf-tools-next
> > > >
> > > > There's also some description here:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree=
/tools/perf/Documentation/Build.txt?h=3Dperf-tools-next
> > > >
> > > > Perhaps you can suggest improvements :-)
> > > >
> > >
> > > Thanks Namhyung and Ian for your suggestions. I'll try them out and l=
et you know if I have any questions.
> > >
> >
> > Hello all,
> >
> > Thank you for participating in today's office hours and helping me clar=
ify my doubts.
> > One topic that emerged from our discussion is the choice of programming=
 language
> > for writing the converter. I am considering using Python as it offers c=
onvenient
> > libraries for JSON manipulation. However, I need to investigate whether=
 Python is
> > enabled by default in most of the Linux distributions that ship with pe=
rf, as its
> > absence could pose a potential obstacle.
> >
> > Additionally, two profile formats are available: Gecko profile format a=
nd Processed profile format[1].
> > Upon discussing on Firefox Profiler matrix channel, they recommended op=
ting for the Processed format,
> > as it will be supported in future releases as well. Therefore, I intend=
 to begin by working with the
> > Processed format and evaluate the results. If any of you have suggestio=
ns regarding the choice of
> > format, I would greatly appreciate your input.
> >
> > Later on, I will address concerns I have regarding the file-loading pro=
cess.
> > Once again, thank you all for your time.
>
> I wanted to provide an update on my exploration of various tools
> and methods to generate a profiler format. In my experimentation, I
> considered following command as a reference.
>
> perf record -F 99 -g -- perf test -w noploop
>
> The command generated perf.data file has been used with three
> different tools to generate the required format and uploaded them to
> profiler.firefox.com. Interestingly, I noticed distinct call trees in
> each of the three cases. I find myself in a state of confusion regarding
> which result to consider as a reference. Here are the outcomes:
>
>     1. Result obtained using perf script: https://share.firefox.dev/3qxEt=
7F
>     2. Result obtained using samply:https://share.firefox.dev/3OZsha2
>     3. Result obtained using simpleperf gecko_profile_generator: https://=
share.firefox.dev/45Q2BTe
>
> I would greatly appreciate any guidance or suggestions in this matter.

Hi Anup,

of the 3 outcomes the perf script output looks best. Is the reason
using the processed profile format? For the other two the major issue
appears to be symbolization. Presumably with the first perf script is
helping out. I'm not sure why the simpleperf stacks are truncated.
Sorry to not be of more use, presumably you've looked into this more
and we can discuss this in the office hours tomorrow.

Thanks,
Ian

> > Thanks,
> > Anup
> >
> > [1] https://github.com/firefox-devtools/profiler/blob/main/docs-develop=
er/custom-importer.md
> >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > >
> > > > > > Thank you for your support and I'm looking forward to collabora=
ting with you on this project!
