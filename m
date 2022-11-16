Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7743E62C279
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiKPP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKPP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:27:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1636218;
        Wed, 16 Nov 2022 07:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9EC1B81DD9;
        Wed, 16 Nov 2022 15:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C455C433D6;
        Wed, 16 Nov 2022 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668612423;
        bh=L6GbtZxCf5VqA/hILI0topC4Tv6j0OCw5gX8PuzWtR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPLgwsKelBv8+G6m3s6+6CN39OSO8+own0i9k1HT/xT8foVVmG4Szdbr1uIkS1tRr
         pP82m7xFo660YGRva7UDCdK9IupML14nL5kbVV7dwv94KrqDYisNLyH56YYKIrv/lt
         mXrb8dQEu1tqT77SNZkbZBseGKZtvZ8upcGbOnTpHOztenoZ/Vpgi2+qPbwku/mSIr
         gm0Ur8Wd1wTHoo7/2GYJw8g/2txt9JXn3xTePld6QhZz8JnAqC0rG5HGfnVoljy74e
         LdiAvIrMKAB60aZzVDB5YR9B2DWlysWKLa1ABqeTv9svn3NJYpo6XxP/LgyFe11lT5
         SJ3LWtr2SNuXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F8654034E; Wed, 16 Nov 2022 12:27:00 -0300 (-03)
Date:   Wed, 16 Nov 2022 12:27:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 0/4] perf list libpfm support and other fixes
Message-ID: <Y3UBRI5o1XDK6Zmg@kernel.org>
References: <20221116071259.2832681-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116071259.2832681-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 15, 2022 at 11:12:55PM -0800, Ian Rogers escreveu:
> Fix an asan issue and a a lack of libpfm support with the refactored
> perf list code. Add some improvements to wordwrap and the escape
> printing for json to aid this.
> 
> Ian Rogers (4):
>   perf list: Fix asan issue
>   perf list: Support newlines in wordwrap
>   perf list: Json escape encoding improvements
>   perf list: List callback support for libpfm

Please take a look at my reports, the patch just before the one having
fixes in this series has some problems, so please check and fold the
fixes for the JSON one.

I thought I hadn't published that part, but realized I did and force
pushed without the last two patches, to avoid breaking bisection before
it hits upstream.

- Arnaldo
