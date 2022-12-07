Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1046646098
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLGRrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiLGRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:47:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270955C0F9;
        Wed,  7 Dec 2022 09:47:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93F6BCE2029;
        Wed,  7 Dec 2022 17:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CC9C433C1;
        Wed,  7 Dec 2022 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670435218;
        bh=gtFvS1K9cmF71vVl/G+yPms/MdTHWdnZNLQIeGfWovY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDitrQs+qRdv5/8zy+IVSAtxnBonbLiswtsP5NWv0/oUQVJMGUrMbqbfd6qhFUIT2
         ZQJ6VIRKgScTHnyYpnXVJ8wX0wfBXteRlHdUWTyDWoSGljA1MeRF0DcUR/XZxbZbbq
         R5CGWwp+UFMlsqF97yonXivv4VRRr8toGQMv5HLH9QWXfyyHd0VoK1yovEShl/UixB
         IlRGfqowqw8qxxnU14x+1nz/oxRvFxfOaoxClfteXGONKIar/9dzxTJGCOsHKVFYFS
         MN0RkuGyzDzptrNfTjeQUSoRgzADDCTNsGq7RW6CEp4B6tKydf4sw0JQpv5d+ixE+Q
         fh18AoWqd9a5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5AEC40404; Wed,  7 Dec 2022 14:46:53 -0300 (-03)
Date:   Wed, 7 Dec 2022 14:46:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4] perf jevents: Parse metrics during conversion
Message-ID: <Y5DRjecE88KFc4He@kernel.org>
References: <20221207055908.1385448-1-irogers@google.com>
 <Y5DQKif+PdRJblk+@kernel.org>
 <0d64e485-5acf-b7ad-e228-9bf85d8ae16d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d64e485-5acf-b7ad-e228-9bf85d8ae16d@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 07, 2022 at 05:42:52PM +0000, John Garry escreveu:
> On 07/12/2022 17:40, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 06, 2022 at 09:59:08PM -0800, Ian Rogers escreveu:
> > > Currently the 'MetricExpr' json value is passed from the json
> > > file to the pmu-events.c. This change introduces an expression
> > > tree that is parsed into. The parsing is done largely by using
> > > operator overloading and python's 'eval' function. Two advantages
> > > in doing this are:
> > John, what tag can I get from you? 😄
> > 
> > - Arnaldo
> Sure,
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks a lot!

- Arnaldo
