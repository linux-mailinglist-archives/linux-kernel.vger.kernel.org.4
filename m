Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A4748E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGEUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:01:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11135121;
        Wed,  5 Jul 2023 13:01:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b89600a37fso18385585ad.2;
        Wed, 05 Jul 2023 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688587308; x=1691179308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lr+OJtVyAxS2YZZNpALcE7P9fld+sL5KFJ+QmTRku7k=;
        b=Zb1FJmd9sQBDTe7gTKyJ3r1Ie574IGzORuw90G/FqGbphJHOMPbAxyYG27GkZxp8BC
         vtrP+c99e3oJH69vFXwOkOSwCeDNjq8v1+yigmx0G3S2BHFqNKYU+TZJiZ7BfzM9RrQk
         68t3Z/UjAKdfGzr4e4+3a03lirqD7rUJx44YSJBl5Iuo2BapV88KomZZmc6khG1OsSff
         9MOXkghbR/dEW6BzFayPCQj3PMFuyBpiIqZNd4OMAztq3RRMS58vy2R1efRYaq467r5M
         CGDZjKcBx/pTb7k16Ae13Q9d8ThIBoyLRXoLjwYeKa82MK7rlPCzZSfA/O/5/uwkwK7w
         dRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688587308; x=1691179308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr+OJtVyAxS2YZZNpALcE7P9fld+sL5KFJ+QmTRku7k=;
        b=awDyfdUffvtkNFPteiaSEZGlgxqSiYBSnGlJKTnIfH3vDPOwJ1fjZuzSzKf7uKBgLE
         1DUnFRfUh0z+UUeHjebtXbdsymhbkklLMeTrHsmEpvA3O8irVbO+MkbA+rW2T+EWH+tK
         asdK00YciOPszDGknJFpmC7CEnvLKNdiv8fdGYrfa1yPvziveHLqe8+2LBvaTCMn6ByJ
         uhlVBY74ZUfsNDYGHfYOt4OlrOs4vjUTb6ckOVyyB/gQGjyop19a8pJgxZfGAhoHo8Fe
         rVPWhtY9D5SHh3a8zfDDKq40Qyull5ukZHv4T/jb4dXMyRqTeLQps004IKLZSTNwv32l
         /8Yg==
X-Gm-Message-State: ABy/qLa3triI4qfhRo5xhcj5y1MSO6I9EtTwFboF+7VLQcHJkuVIRM5M
        YnxnBvb0pH9BbdZCBd+Ng3U=
X-Google-Smtp-Source: APBJJlEqY3psRs/rL15v0HFzYAurAcy0x2HC2lCYLhzLAf3rWBW6IQwIyej94TTjT8xpdzej93G9qw==
X-Received: by 2002:a17:902:da92:b0:1b5:5a5f:369b with SMTP id j18-20020a170902da9200b001b55a5f369bmr16089762plx.65.1688587308312;
        Wed, 05 Jul 2023 13:01:48 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id m23-20020a170902bb9700b001b50cbc0b4fsm19351441pls.111.2023.07.05.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:01:47 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Thu, 6 Jul 2023 01:31:40 +0530
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] scripts: python: implement get or create frame
 function
Message-ID: <ZKXMJFckLMcGcVkP@yoga>
References: <cover.1687375189.git.anupnewsmail@gmail.com>
 <4d0ac80521ebd44322a360ac331ce2443a1f0f26.1687375189.git.anupnewsmail@gmail.com>
 <CAM9d7cgAfvzrGiU0QiEigTAYKMe+OEP0b3o3Xd-0VhXX5Wkx1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgAfvzrGiU0QiEigTAYKMe+OEP0b3o3Xd-0VhXX5Wkx1g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:04:56PM -0700, Namhyung Kim wrote:
> On Wed, Jun 21, 2023 at 12:45 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The CATEGORIES list and the USER_CATEGORY_INDEX and
> > KERNEL_CATEGORY_INDEX constants has been introduced.
> >
> > The get_or_create_frame function is responsible for retrieving or
> > creating a frame based on the provided frameString. If the frame
> > corresponding to the frameString is found in the frameMap, it is
> > returned. Otherwise, a new frame is created by appending relevant
> > information to the frameTable's 'data' array and adding the
> > frameString to the stringTable.
> >
> > The index of the newly created frame is added to the frameMap.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 30fc542cfdeb..866751e5d1ce 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -15,6 +15,13 @@ def isPerfScriptFormat(profile):
> >      firstLine = profile[:profile.index('\n')]
> >      return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
> >
> > +CATEGORIES = [
> > +{'name': 'User', 'color': 'yellow', 'subcategories': ['Other']},
> > +{'name': 'Kernel', 'color': 'orange', 'subcategories': ['Other']}
> > +]
> > +USER_CATEGORY_INDEX = 0
> > +KERNEL_CATEGORY_INDEX = 1
> > +
> >  def convertPerfScriptProfile(profile):
> >      def _createtread(name, pid, tid):
> >          markers = {
> > @@ -70,6 +77,37 @@ def convertPerfScriptProfile(profile):
> >                  stackMap[key] = stack
> >              return stack
> >
> > +        frameMap = dict()
> > +        def get_or_create_frame(frameString):
> > +            frame = frameMap.get(frameString)
> > +            if frame is None:
> > +                frame = len(frameTable['data'])
> > +                location = len(stringTable)
> > +                stringTable.append(frameString)
> > +
> > +                category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 or frameString.find('/vmlinux') != -1 or frameString.endswith('.ko)') else USER_CATEGORY_INDEX
> 
> This line is too long, we usually don't allow long lines
> over 100 characters.

Thanks for your suggestion. I have taken care in latest version.
Is there any way to add such checks in editor itself ? I used checkpatch.pl
scripts, however it didnt catch this.

> Thanks,
> Namhyung
> 
> 
> > +                implementation = None
> > +                optimizations = None
> > +                line = None
> > +                relevantForJS = False
> > +                subcategory = None
> > +                innerWindowID = 0
> > +                column = None
> > +
> > +                frameTable['data'].append([
> > +                    location,
> > +                    relevantForJS,
> > +                    innerWindowID,
> > +                    implementation,
> > +                    optimizations,
> > +                    line,
> > +                    column,
> > +                    category,
> > +                    subcategory,
> > +                ])
> > +                frameMap[frameString] = frame
> > +            return frame
> > +
> >          def addSample(threadName, stackArray, time):
> >              nonlocal name
> >              if name != threadName:
> > --
> > 2.34.1
> >
