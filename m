Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0578B6F0C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbjD0Tek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245559AbjD0TeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB01FF5;
        Thu, 27 Apr 2023 12:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5202B63D93;
        Thu, 27 Apr 2023 19:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7555AC433EF;
        Thu, 27 Apr 2023 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682624054;
        bh=QneEEMrg5/ckBfmlDuKf2iDhBWq5sLbjAXtXQz9r3TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je8Ob7SlbIhT1icwkOj0Q36pTWd9cBGaIhiqbtkkHJCEdDCdzx4y497vBLZka4biJ
         0XKz5Xdb+GjaCP1H6Si4XQ7eqP2kw/5CPcP4RWwRF8Cb/lyTyF+1T0QO2ELie5FWBm
         XEAbvZNM/wRXEUOdisnfgz2IIgmQgKZJjqljayOzvXywp/a7jnXD9lltUHu+hq0OL9
         tOaY32ZRegZIStYvF7O7yLWW7/g1J/lDEJvD2uPfFkvI5obCl8zLgD8Z5tWTYfwvUO
         icuQb9W/SCRyHwA1BDmjRPimRZbVIKTdEXicaw+G/oqcCWNfHODzuIungspDLRGN9i
         o6vskMrIcOLog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6B07403B5; Thu, 27 Apr 2023 16:34:11 -0300 (-03)
Date:   Thu, 27 Apr 2023 16:34:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/40] perf stat: Avoid segv on counter->name
Message-ID: <ZErOMy8X2+dE4AKR@kernel.org>
References: <20230426070050.1315519-1-irogers@google.com>
 <20230426070050.1315519-8-irogers@google.com>
 <15ca8bed-db47-182e-1ae3-33e273027776@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ca8bed-db47-182e-1ae3-33e273027776@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 27, 2023 at 03:11:49PM -0400, Liang, Kan escreveu:
> On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> > Switch to use evsel__name that doesn't return NULL for hardware and
> > similar events.
 
> This one should be backport to 6.4. It helps to fix the Segmentation
> fault with default mode.
> https://lore.kernel.org/lkml/2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com/
 
> > Signed-off-by: Ian Rogers <irogers@google.com>
 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,

I'll pick those before pushing to Linus, I'm mostly waiting for you guys
to come to a resolution on moving forward, which I hope has been reached
with that patch you sent.

- Arnaldo
