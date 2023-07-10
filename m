Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568B774E0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGJWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjGJWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:01:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069EFDB;
        Mon, 10 Jul 2023 15:01:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8ad907ba4so24823775ad.0;
        Mon, 10 Jul 2023 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689026478; x=1691618478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=noXk0R27HPx3THK3yfqnsU/gqkuv8yKrLuQKPLP+V2A=;
        b=nGu3r0sV3DJyP0P2MeifuOet0MgQekGDmeWLcDPUE1xP4123fWOR4Cb5X5qMoYi3Am
         PcBNhepVVlV3wvm5HymMyCPiTc+i1w+fG4qUxaZcfa7g2ntLLJho10RCQ2B66YU94NwF
         U829Q13l3mRUxjw1fWICWNHT6nBbbou0yntiUCDqCkEjJ/EgiUTrU78dR/V4EfGg3Gbd
         9UD4TOIS91gX6yY98aSeG607aDZ4zqZfIszzQNJZsjb2PD9FLGmHF9AKqF90A5vcXFoS
         t5Qx0j3/ACqCTHhNcR5J39c4/PFAGrq1kaJF5oIZd7cHKPOcng4ki0WAQiebBf9O1BZZ
         Xt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689026478; x=1691618478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noXk0R27HPx3THK3yfqnsU/gqkuv8yKrLuQKPLP+V2A=;
        b=Iv7hI8mxwa8QiVOap/6hT7p/W62bR4LInfN8pSs4iA82paQR0p0QWT3dqe6f1kjYa5
         MxFamqK8u6TpbtUbFotAB3wu+gaKGFeXPUSfVTa5Uq9dgfiIxRwSzM0OJhod801zYNQb
         0E/M+aRjmVt6n1C5wPZmFkjQD4Am8SJDJZ+7ajl5wHnbkTKgi9ht/aFo+Lv2uqTw40ba
         6vJXjU271Ow7r7tsqa7yxHYhUBrMm1svtGMQJc3BvJCU2e6fHnS59zcyYL3x6Ho3QnJ1
         jNxQ24rhAS/A6ikSVaUAzidq89EMuR8vULr1kHCUyrRARb8deHU8FlZ33l9buZP/tQdv
         Ws6Q==
X-Gm-Message-State: ABy/qLZBydgj3D2BcX9jyxLZxU2vm/ljQ6k8A5wx38+3ZoEmdL2GXlXI
        hB23S/ntvqaOC4UY164AMf1XS9fMaSkND19s
X-Google-Smtp-Source: APBJJlG1RJ1pRviKI/Ux2CN+PjCKK9mzBVgbONzmfvtdM05eJ71EmYz51bSX8G3qb9jbxfqJFlmDRQ==
X-Received: by 2002:a17:903:482:b0:1b8:a2af:fe23 with SMTP id jj2-20020a170903048200b001b8a2affe23mr10920008plb.2.1689026478150;
        Mon, 10 Jul 2023 15:01:18 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:d743:45e6:d02:e038])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001b3df3ae3f8sm349404plx.281.2023.07.10.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 15:01:17 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Tue, 11 Jul 2023 03:31:10 +0530
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
Subject: Re: [PATCH v2 4/7] scripts: python: implement get or create stack
 function
Message-ID: <ZKx/pqBA6+14qkeN@yoga>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
 <d432405a93438f1780a767567b69bcdab32e1683.1688585597.git.anupnewsmail@gmail.com>
 <CAM9d7ciAeGJ=n6DiR9=0K1AmN1mLoYXqYVjFFEPPD8UnRrstoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciAeGJ=n6DiR9=0K1AmN1mLoYXqYVjFFEPPD8UnRrstoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:55:52PM -0700, Namhyung Kim wrote:
> On Wed, Jul 5, 2023 at 12:48 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > The get_or_create_stack function is responsible for retrieving
> > or creating a stack based on the provided frame and prefix.
> > It first generates a key using the frame and prefix values.
> > If the stack corresponding to the key is found in the stackMap,
> > it is returned. Otherwise, a new stack is created by appending
> > the prefix and frame to the stackTable's 'data' array. The key
> > and the index of the newly created stack are added to the
> > stackMap for future reference.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  tools/perf/scripts/python/firefox-gecko-converter.py | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index e56864e78dc1..6f69c083d3ff 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -65,6 +65,17 @@ def process_event(param_dict):
> >                         },
> >                         'data': [],
> >                 }
> > +               stringTable = []
> > +
> > +               stackMap = dict()
> > +               def get_or_create_stack(frame, prefix):
> > +                       key = f"{frame}" if prefix is None else f"{frame},{prefix}"
> > +                       stack = stackMap.get(key)
> 
> I'm confused about what the 'stack' is.

The stack is a list of frames.

> > +                       if stack is None:
> > +                               stack = len(stackTable['data'])
> 
> It seems like a kind of index for the stackTable's data.

Yes, it is an index.

> > +                               stackTable['data'].append([prefix, frame])
> > +                               stackMap[key] = stack
> > +                       return stack
> 
> So this function returns an index, right?

Correct, it returns an index. This index allows to access or identify
a specific stack within the table.

> Thanks,
> Namhyung
> 
> 
> >
> >         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
> >                 thread = thread_map.get(tid)
> > --
> > 2.34.1
> >
