Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CFB6FCD83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjEISMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjEISMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB0259E5;
        Tue,  9 May 2023 11:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A73064745;
        Tue,  9 May 2023 18:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01AC433EF;
        Tue,  9 May 2023 18:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683655861;
        bh=QUIlMq5k9T6STtI5tHiTubb4VsiMOXpe8//RQa1AvRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urzxOlCi66xMt+lMN/e7USr+4divle1WP5LYITrSVp2AgrKm0u2iZ1nToYvioF/s5
         17PmCicvqmJuQTxRJYDlHN0POF8/NvPjeA3yQd3NQnWJoSAL73ihbVtuMLhFOJ7bGy
         3GLVjBPeVQzuoRqonpVyX2PyN7ddpKFeTyS143Lp2S42LsjhszWitgWsN6O7sBgJxy
         pHFHOAZX7azVsFcIkSJphlCLFJ55e/vw9KrWQPh6BTq7krPeSMsIkpbD7jaB7ag87j
         IvkvchkA4xokBzglT+bqMxkbz8/rxMwM9jLu73t2oLseKDdFwZAojDf0QYSqtCGHyg
         DV8MAd5aAxzMQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B3E7F403B5; Tue,  9 May 2023 15:10:58 -0300 (-03)
Date:   Tue, 9 May 2023 15:10:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: reduce run time of perf test Test java symbol
Message-ID: <ZFqMsjJg00zmQyJG@kernel.org>
References: <20230509131847.835974-1-tmricht@linux.ibm.com>
 <CAP-5=fVC1bAMk5gOGSXi0sHdetdLHGT2tqW43dxTTyJ3jRz8QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVC1bAMk5gOGSXi0sHdetdLHGT2tqW43dxTTyJ3jRz8QA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 09, 2023 at 10:34:44AM -0700, Ian Rogers escreveu:
> On Tue, May 9, 2023 at 6:19 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Test case Test java symbol might run a long time. On Fedora 38 the
> > run time is very, very long:
> >
> >  Output before:
> >  # time ./perf test 108
> >  108: Test java symbol                  : Ok
> >  real   22m15.775s
> >  user   3m42.584s
> >  sys    4m30.685s
> >  #
> >
> > The reason is a lookup for the server for debug symbols as shown in
> >  # cat /etc/debuginfod/elfutils.urls
> >  https://debuginfod.fedoraproject.org/
> >  #
> > This lookup is done for every symbol/sample, so about 3500 lookups
> > will take place.
> > To omit this lookup, which is not needed, unset environment variable
> > DEBUGINFOD_URLS=''.
> >
> >  Output after:
> >  # time ./perf test 108
> >  108: Test java symbol                  : Ok
> >
> >  real   0m6.242s
> >  user   0m4.982s
> >  sys    0m3.243s
> >  #
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: leo.yan@linaro.org
> > Cc: irogers@google.com
> > ---
> >  tools/perf/tests/shell/test_java_symbol.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
> > index 90cea8811926..499539d1c479 100755
> > --- a/tools/perf/tests/shell/test_java_symbol.sh
> > +++ b/tools/perf/tests/shell/test_java_symbol.sh
> > @@ -56,7 +56,7 @@ if [ $? -ne 0 ]; then
> >         exit 1
> >  fi
> >
> > -if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> > +if ! DEBUGINFOD_URLS='' perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> 
> Jiri, is this the best way to workaround a debuginfod slowness?

I noticed this delay, It is good that someone worked on rootcausing this
excessive delay, thanks Thomas.

I'll test it now.

- Arnaldo
