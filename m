Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7811172EC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbjFMTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjFMTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AC119;
        Tue, 13 Jun 2023 12:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8663463A35;
        Tue, 13 Jun 2023 19:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC883C433D9;
        Tue, 13 Jun 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686685511;
        bh=J2Rp0IpcinSqHnXghEPSh9sey3GHHZL204OfuUZIpQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X02FdtQN9YPh5JeYdXPoKx0V1Oxl6wLWo89hJEgCoiwd65LRuvQKPHhp5pDR0BtYR
         WfD/GLL0PCdIi4kRuPoDZUswx84jNie7prWLGM8+YUVPOmQ0OBri0UOSmHMikweYE2
         jrgr88QJY4mxq9SSTt1pZ0hj11cTq3sTk6/c7wrKtEkByHsO7zuckJoh/kSi6H9seZ
         1KYnGJR22sYA+BFU9lycR5tVfdyOMmnbmQGfyFzuoUx7h4tlsDkBx8BrI3EZlNfmuH
         aQ3xL8lNYYRDfuKGDAekxfYIAMPJs0WJeBjFFE4KndlSrBBy5e6PCTysXzg3YGNlyt
         vX0w/rHCha0tw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34BF340692; Tue, 13 Jun 2023 16:45:09 -0300 (-03)
Date:   Tue, 13 Jun 2023 16:45:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Add missing newline in pr_err messages
Message-ID: <ZIjHRfq0/IJPyhYT@kernel.org>
References: <20230610094441.221525-1-yangjihong1@huawei.com>
 <ZIdqHeZOWCztKVe2@kernel.org>
 <cd1d5a4b-e69c-84c9-3e27-d197042df904@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1d5a4b-e69c-84c9-3e27-d197042df904@huawei.com>
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

Em Tue, Jun 13, 2023 at 09:32:05AM +0800, Yang Jihong escreveu:
> On 2023/6/13 2:55, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Jun 10, 2023 at 09:44:41AM +0000, Yang Jihong escreveu:
> > > The newline is missing for error messages in add_default_attributes()
> > > 
> > > Before:
> > > 
> > >    # perf stat --topdown
> > >    Topdown requested but the topdown metric groups aren't present.
> > >    (See perf list the metric groups have names like TopdownL1)#
> > > 
> > > After:
> > > 
> > >    # perf stat --topdown
> > >    Topdown requested but the topdown metric groups aren't present.
> > >    (See perf list the metric groups have names like TopdownL1)
> > >    #
> > > 
> > > In addition, perf_stat_init_aggr_mode() and perf_stat_init_aggr_mode_file()
> > > have the same problem, fixed by the way.
> > 
> > Wait a bit till I push what I had to perf-tools-next, as it is not
> > applying right now:
> OK, I'm doing the patch based on the mainline, and if I need to do it based
> on the perf-tools-next branch, I'll reissue it.

For patches for the currente perf development cycle the perf-tools-next
branch of:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Should be used.

Hopefully soon we will transition to:

git://git.kernel.org/pub/scm/linux/kernel/git/perf-tools/perf-tools-next.git

And also:

git://git.kernel.org/pub/scm/linux/kernel/git/perf-tools/perf-tools.git

For fixes geared to the current merge window, when we are accepting just
fixes.

- Arnaldo
