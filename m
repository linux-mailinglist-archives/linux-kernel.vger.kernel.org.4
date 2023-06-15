Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BCC7311CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjFOIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbjFOIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:10:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551F1A3;
        Thu, 15 Jun 2023 01:10:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-519b771f23aso1739697a12.1;
        Thu, 15 Jun 2023 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686816621; x=1689408621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQKLPV7svhmFXU+YY6Z2XlGXEMzdG3pBcvTN7P5dgn4=;
        b=DPMMQaiav3CPksaSlGQi1OmGyLof3HczsehsRRZbQBEfFtlNNnBnxuuTu/SY5YTuia
         +Sx0uf/yEp8t3dYWj1ffJGkL7z7MrpyRMN7Vx2/4oMUmLAeC128ew/+d0XBvPlrA3E/S
         rd48CUgHvIkEAZESZvatkrSGjUZGM/VoCEwAsl/qqbIbyLP4MjugbT4fyKCqnviINbMX
         ln5FRujoUViiiFqosDrazXgBU2dA03foNPBF+q8vR5kIsTIJwzuydKylCCOqQAOA5L0I
         Jp2DoCiVaoArqolQ7+aqAvLgESvj/GypiVKV4S4JkZwLWCKb7fjfn6kmvVF6cV9t4NZY
         Jvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686816621; x=1689408621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQKLPV7svhmFXU+YY6Z2XlGXEMzdG3pBcvTN7P5dgn4=;
        b=bsDfIMRBKxz3gthJnlMsQnl8OU8LTLZpOfwsxELagsx7HOciPzyw4OQM6cvSNJ0gJg
         zCJTm0kRxY5X7vl5Ie6dFQBMQRqlxJDfgXTw0RsFcveH319huRBKvAY7lHPYtjKgnyCX
         LLYszmfMWLGvLdR6uzQTgIRxSxHUR8V+/Xw7St2ZfERf5s3cZ5zDBlbvkkiHEkJGr9Nb
         QUdsOqczZXXFV3VEpN01w8DqoaKAfGOAZoa5Fm4/A/FejiyHiqkAv3WST6aNvM+YEsPO
         Qo8awOLFVD1L70MN3/09gs+vgVMNW2pb77bqmSnjqTkV2tOjuViXj4zRxMETACGt0H0T
         oSeg==
X-Gm-Message-State: AC+VfDzs/QJtqaVAB2WPJ0KigI/5Ct/7SW8Ziz6f+2+HSGVytNXRaKlS
        RvHV/ti3j2B2Ik2ygep9MNs=
X-Google-Smtp-Source: ACHHUZ7Yu4GfUyPRFFA0QZbcc49O0I0TJbx78NV21zRT7vAoHc4cYSbthRFGE1Lk8n0MA6ur2Ndn4Q==
X-Received: by 2002:a17:907:3e9f:b0:976:c9a6:4857 with SMTP id hs31-20020a1709073e9f00b00976c9a64857mr21640258ejc.57.1686816620649;
        Thu, 15 Jun 2023 01:10:20 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id dk17-20020a170906f0d100b0097886843f75sm9150820ejb.177.2023.06.15.01.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:10:20 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 15 Jun 2023 10:10:18 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
Message-ID: <ZIrHatpIlo3Y2ZPQ@krava>
References: <20221018020227.85905-1-namhyung@kernel.org>
 <20221018020227.85905-19-namhyung@kernel.org>
 <ZInDSgrOzYSX124p@krava>
 <CAP-5=fX2ULvR7KFCwZN4wn1LSQmtJqQk7bK=T=BHdvnHuL=DdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX2ULvR7KFCwZN4wn1LSQmtJqQk7bK=T=BHdvnHuL=DdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:20:53AM -0700, Ian Rogers wrote:
> On Wed, Jun 14, 2023 at 6:40 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Oct 17, 2022 at 07:02:25PM -0700, Namhyung Kim wrote:
> > > Now aggr counts are ready for use.  Convert the display routines to use
> > > the aggr counts and update the shadow stat with them.  It doesn't need
> > > to aggregate counts or collect aliases anymore during the display.  Get
> > > rid of now unused struct perf_aggr_thread_value.
> > >
> > > Note that there's a difference in the display order among the aggr mode.
> > > For per-core/die/socket/node aggregation, it shows relevant events in
> > > the same unit together, whereas global/thread/no aggregation it shows
> > > the same events for different units together.  So it still uses separate
> > > codes to display them due to the ordering.
> > >
> > > One more thing to note is that it breaks per-core event display for now.
> > > The next patch will fix it to have identical output as of now.
> > >
> > > Acked-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > hi,
> > this one seems to break 'perf stat -r X' not sure why so far..
> >
> > final counts seems to be accumulated instead of displaying average, like:
> >
> >
> > with this patch:
> >
> >          Performance counter stats for './test_progs -n 103/1' (2 runs):
> >
> >                206,815,929      cycles:u                                                             ( +-  0.05% )
> >             16,052,747,533      cycles:k                                                             ( +-  0.10% )
> >             16,259,643,167      cycles                                                               ( +-  0.10% )
> >
> >                    1.98093 +- 0.00586 seconds time elapsed  ( +-  0.30% )
> >
> >
> > without this patch:
> >
> >          Performance counter stats for './test_progs -n 103/1' (2 runs):
> >
> >                103,300,812      cycles:u                                                             ( +-  0.37% )
> >              8,016,856,866      cycles:k                                                             ( +-  0.32% )
> >              8,120,200,572      cycles                                                               ( +-  0.32% )
> >
> >                    1.97272 +- 0.00270 seconds time elapsed  ( +-  0.14% )
> >
> >
> > any idea? ;-)
> 
> Is this still broken in perf-tools-next? The patch is quite old and
> there's been work in this area. I'm assuming yes, but thought it was
> worth checking.

yes


single run:

	[root@krava perf]# ./perf stat -e cycles:u ./perf bench sched pipe
	# Running 'sched/pipe' benchmark:
	# Executed 1000000 pipe operations between two processes

	     Total time: 4.725 [sec]

	       4.725795 usecs/op
		 211604 ops/sec

	 Performance counter stats for './perf bench sched pipe':

	       398,096,363      cycles:u                                                              

	       4.737638715 seconds time elapsed

	       0.227961000 seconds user
	       4.348895000 seconds sys


3 runs (with verbose):

	[root@krava perf]# ./perf stat -v -r 3 -e cycles:u ./perf bench sched pipe
	Using CPUID GenuineIntel-6-8C-1
	Control descriptor is not initialized
	[ perf stat: executing run #1 ... ]
	# Running 'sched/pipe' benchmark:
	# Executed 1000000 pipe operations between two processes

	     Total time: 4.659 [sec]

	       4.659396 usecs/op
		 214620 ops/sec
	cycles:u: 399150620 3866604490 3866604490
	[ perf stat: executing run #2 ... ]
	# Running 'sched/pipe' benchmark:
	# Executed 1000000 pipe operations between two processes

	     Total time: 4.656 [sec]

	       4.656820 usecs/op
		 214738 ops/sec
	cycles:u: 795910540 7700776638 7700776638
	[ perf stat: executing run #3 ... ]
	# Running 'sched/pipe' benchmark:
	# Executed 1000000 pipe operations between two processes

	     Total time: 4.634 [sec]

	       4.634090 usecs/op
		 215792 ops/sec
	cycles:u: 1189927957 11522039559 11522039559

	 Performance counter stats for './perf bench sched pipe' (3 runs):

	     1,189,927,957      cycles:u                                                                ( +- 19.18% )

		    4.6611 +- 0.0102 seconds time elapsed  ( +-  0.22% )


jirka
