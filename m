Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5766ABFD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 16:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjANPEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 10:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjANPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 10:04:10 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAF7A93;
        Sat, 14 Jan 2023 07:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nRnb7B1cKZnECL2BKcMAOHI7QY483KI3u4D6sNuPq/0=; b=qLyb4VwUVGpRsEpYScJutMD0Ut
        s2AiPTRTrqh7RkqmjWLuSr8eL2DjRjn6hcZSsnfY72zYIJUVmxs1BVmv6eK/Sj6lp7WJSWyVuWlHT
        GX14P+8rs+dfueoaG22WoBNZ6Kh6I1tHlsk2o71woTvJhH+Bx5j1CVFtOyYDYLP8xg1SMcbytYE3P
        qAkSiEL8Zt2IsLGIiOON5Rx4QxfDDik9tIHiE3gSIqPFHucdTQR8LM/v0W44zECZlh8/IQQzecFFe
        rz8IXVmnzTZ8T0m4btgqPD4RZBOcwLRnh+6JOav+Clgz+gYZnkvNnXU67+i3A36rXHE5fT/3F6kTr
        3jlyhaCw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1pGi4E-007Ewu-KQ; Sat, 14 Jan 2023 15:03:35 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id 05B93BE2DE0; Sat, 14 Jan 2023 16:03:33 +0100 (CET)
Date:   Sat, 14 Jan 2023 16:03:32 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Ian Rogers <irogers@google.com>, 996839@bugs.debian.org
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Brendan Gregg <brendan@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        spiermar@gmail.com, yadd@debian.org
Subject: Re: Bug#996839: [PATCH v1] perf script flamegraph: Avoid
 d3-flame-graph package dependency
Message-ID: <Y8LERKrMSSXwo51j@eldamar.lan>
References: <20230105030434.255603-1-irogers@google.com>
 <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
 <bd4a55a4-8e9c-82bf-92c8-1fa354289dce@redhat.com>
 <CAP-5=fX3LaJgft8T+nYV8SHpmoAOYZ9S5-pztKF9j--Um4HKDQ@mail.gmail.com>
 <928c76bf-39bc-cbc0-373e-70c5561cd5b0@redhat.com>
 <CAP-5=fWyE_cqumLFxrj_tncnhVSDpiN0cMij3iB_FMY9qmjNWw@mail.gmail.com>
 <68e8840e-d894-c211-184d-91a06c87579c@redhat.com>
 <f389dc6495890e42c95c7b897cbb02ad@marek.priv.at>
 <CAP-5=fXQ01+ZvQDyD2q6wL2P6JfmnwRyEJHin1B4as9Hfq0GFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXQ01+ZvQDyD2q6wL2P6JfmnwRyEJHin1B4as9Hfq0GFw@mail.gmail.com>
X-Debian-User: carnil
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 12, 2023 at 02:28:59PM -0800, Ian Rogers wrote:
> On Wed, Jan 11, 2023 at 10:08 AM Andreas Gerstmayr
> <agerstmayr@redhat.com> wrote:
> >
> > On 11.01.23 18:13, Ian Rogers wrote:
> > > On Wed, Jan 11, 2023 at 5:18 AM Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
> > >>
> > >> On 10.01.23 20:51, Ian Rogers wrote:
> > >>> On Tue, Jan 10, 2023 at 10:02 AM Andreas Gerstmayr
> > >>> <agerstmayr@redhat.com> wrote:
> > >>>>
> > >>>> On 05.01.23 10:24, Ian Rogers wrote:
> > >>>>> On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
> > >>>>>>
> > >>>>>> Currently flame graph generation requires a d3-flame-graph template to
> > >>>>>> be installed. Unfortunately this is hard to come by for things like
> > >>>>>> Debian [1]. If the template isn't installed warn and download it from
> > >>>>>> jsdelivr CDN. If downloading fails generate a minimal flame graph
> > >>>>>> again with the javascript coming from jsdelivr CDN.
> > >>>>>>
> > >>>>>> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> > >>>>>>
> > >>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> > >>>>
> > >>>> I'm not entirely convinced that this perf script should make a network
> > >>>> request. In my opinion
> > >>>>
> > >>>> * best would be if this template gets packaged in Debian
> > >>>> * alternatively print instructions how to install the template:
> > >>>>
> > >>>>        sudo mkdir /usr/share/d3-flame-graph
> > >>>>        sudo wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html
> > >>>> https://cdn.jsdelivr.net/npm/d3-flame-graph@4/dist/templates/d3-flamegraph-base.html
> > >>>>
> > >>>> * or eventually just embed the entire template (66 KB) in the Python
> > >>>> file (not sure if this is permissible though, it's basically a minified
> > >>>> HTML/JS blob)?
> > >>>> * if the above options don't work, I'd recommend asking the user before
> > >>>> making the network request, and eventually persist the template
> > >>>> somewhere so it doesn't need to be downloaded every time
> > >>>>
> > >>>> What do you think?
> > >>>
> > >>> So the script following this patch is going to try 3 things:
> > >>> 1) look for a local template HTML,
> > >>> 2) if a local template isn't found warn and switch to downloading the
> > >>> CDN version,
> > >>> 3) if the CDN version fails to download then use a minimal (embedded
> > >>> in the script) HTML file with JS dependencies coming from the CDN.
> > >>>
> > >>> For (1) there are references in the generated HTML to www.w3.org,
> > >>> meaning the HTML isn't fully hermetic - although these references may
> > >>> not matter.
> > >>
> > >> The references to w3.org are XML namespace names. As far as I'm aware
> > >> they do not matter, as they are merely identifiers and are never
> > >> accessed [1,2]. Therefore the generated HTML file in its current form is
> > >> hermetic.
> > >>
> > >> This was a design decision from the start - the flame graph generation
> > >> and the resulting HTML file should not use any external resources loaded
> > >> over the network (the external host could be inaccessible or compromised
> > >> at any time). I understand that this requirement may not apply to every
> > >> user or company.
> > >>
> > >>> For (2) there will be a download from the CDN of the template during
> > >>> the execution of flamegraph. The template is better than (3) as it
> > >>> features additional buttons letting you zoom out, etc. The HTML will
> > >>> contain CDN references.
> > >>> For (3) the generated HTML isn't hermetic and will use the CDN.
> > >>>
> > >>> For (2) we could give a prompt before trying to download the template,
> > >>> or we could change it so that we give the wget command. I wouldn't
> > >>> have the wget command require root privileges, I'd say that the
> > >>> template could be downloaded and then the path of the download given
> > >>> as an option to the flamegraph program. Downloading the file and then
> > >>> adding an option to flamegraph seems inconvenient to the user,
> > >>> something that the use of urllib in the patch avoids - it is
> > >>> essentially just doing this for the user without storing the file on
> > >>> disk. I think I prefer to be less inconvenient, and so the state of
> > >>> the code at the moment looks best to me. Given that no choice results
> > >>> in a fully hermetic HTML file, they seem similar in this regard. Is it
> > >>> okay to try a download with urllib? Should there be a prompt? I think
> > >>> the warning is enough and allows scripts, etc. using flamegraph to
> > >>> more easily function across differing distributions.
> > >>
> > >> I fully agree, your changes make the flame graph generation more
> > >> convenient in case the template is not installed. Also, downloading the
> > >> template to a local directory and having to specify the path to the
> > >> template every time is an inconvenience.
> > >>
> > >> I think it is a tradeoff between convenience and security/privacy.
> > >> jsdelivr can get compromised, serving malicious JS (well, in that case,
> > >> printing instructions to jsdelivr is also flawed :|).
> > >> In the end it's up to the maintainers to decide.
> > >
> > > Agreed. It is something of an issue with the perf tool, I think noted
> > > by Arnaldo and Linus, that it has too many dependencies. We also have
> > > a problem that a number of dependencies aren't license compatible for
> > > distribution with perf's GPLv2. flamegraph.py is always installed but
> > > it carries a dependency that can't be satisfied on Debian and
> > > everything deriving from it. The prompting to install a package
> > > solution, as is generally used in the build, is one approach. Using
> > > http rather than files is the approach this change introduces, and is
> > > an approach advocated by the d3 flamegraph README.md. Perhaps package
> > > maintainers like Michael and Ben have opinions here.
> > >
> > >>> An aside, Namhyung pointed out to me that there is a "perf report -g
> > >>> folded" option, that was added in part to simplify creating
> > >>> flamegraphs:
> > >>> http://lkml.kernel.org/r/1447047946-1691-2-git-send-email-namhyung@kernel.org
> > >>> Building off of perf report may improve/simplify the flamegraph code,
> > >>> or avoid the requirement that libpython be linked against perf.
> > >>
> > >> Yep, in this case another tool is required to generate the flame graph
> > >> visualization, for example [3].
> > >
> > > Thanks, perhaps [3] needs updating to use it as current processing
> > > appears to be done using perf script:
> > > https://github.com/brendangregg/FlameGraph/blob/master/stackcollapse-perf.pl
> > >
> > > I think users end up trying out flamegraph as they want something
> > > easier to read than perf report and the command ships with the tool.
> > > flamegraph is unique in being like this and it is a pity that the
> > > Debian half of the world has difficulty making it work.
> >
> > Maybe someone with Debian packager rights could package the template
> > [1]? Then it'd work the same way like with RPM-based distros, and it'll
> > also work in environments without network access.
> 
> I chatted a little with Arnaldo and have sent out a v2 that adds the
> prompt as well as an md5sum check on the downloaded file. PTAL:
> https://lore.kernel.org/lkml/20230112220024.32709-1-irogers@google.com/

Regarding having packaged the template: The request is here:
https://bugs.debian.org/1002492 

Regards,
Salvatore
