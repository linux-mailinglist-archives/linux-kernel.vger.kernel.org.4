Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419876E92E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjDTLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjDTLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FCF30D4;
        Thu, 20 Apr 2023 04:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5616561752;
        Thu, 20 Apr 2023 11:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4F5C433EF;
        Thu, 20 Apr 2023 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681990440;
        bh=oDJTkprPHFF+WkngHmEuygFBMq5jaTaNLT3SVigoIe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWEut89UpPOUpEKMCDRbDia3adPLuifHtXT674ypZE6Dl3s3WjmWZb+jJ+J8msNUH
         etHvok8h8dwpmw2DhtS4iyPkzKZIi32w9KQrGYPMGdrPFBu0Az0YlSnUTNKSdGD8M3
         NZ8xsD4zdDv+uXYj9FOqup0BMvE9b5zkAGO9JuCbt7STIJIHPP0VakKlwS6rPi2FiC
         H0HVRFs4UyEH7jl/psioaDeOekCkUi4d4ILvTw+KaktVE9ohm8bCTcMJuie9NdM1/H
         3w1iNJW5/2AKdWV6wAx0qM3ddyF5qMynusIONtHuhITjHdKC/CQSzCnpQoFmazHnII
         Gacll48h+Azaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFEBA403B5; Thu, 20 Apr 2023 08:33:57 -0300 (-03)
Date:   Thu, 20 Apr 2023 08:33:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
Message-ID: <ZEEjJVTIcXvsV4Fh@kernel.org>
References: <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
 <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
 <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 19, 2023 at 09:51:20AM -0700, Ian Rogers escreveu:
> On Wed, Apr 19, 2023 at 7:16 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > For ADL/RPL platforms
> > - Segmentation fault which I just found this morning.
> > # ./perf stat true
> > Segmentation fault (core dumped)
 
> This may also stem from the reference count checking work that Arnaldo
> is currently merging. It is hard to test hybrid because it uses
> non-generic code paths.

Hey, could you please try this under gdb and provide a backtrace? It may
indeed be related to this refcount checking work, there was a bug fixed
by the ARM guys for cs-etm and I combed thru and fixed some other use
before check for NULL cases, maybe one more slipped up.

Here I couldn't reproduce, but I don't have a Intel hybrid system, will
check with an ARM, but unsure if it will exercise the same code paths...

- Arnaldo
