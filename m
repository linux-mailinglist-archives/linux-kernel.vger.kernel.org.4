Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AE5EF5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiI2Mxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiI2Mxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:53:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14801616E3;
        Thu, 29 Sep 2022 05:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C4FB82471;
        Thu, 29 Sep 2022 12:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C339C433D7;
        Thu, 29 Sep 2022 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664456020;
        bh=PTARz97QHfY0nKOwUC2+qib5w+nBB8hInZ3B9jd1p8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQIMpb2cpaO2QAs3RlUgzeiAuoWyCWK036XhaW5Z6aYDyNwCTLAVilZUoRwlHxUXe
         XOkr5/sZTvNgLaxbXYMjRKjPgXt5HF+ghehYrNn+Z3qD32MGKDGlmmC8dKN68vY1JM
         sGwvXjX19JBnVXviBmISmckoC7B+vqxt4pQ31UI8jLolxUd+hH9YRLB/cUH3cWUyVh
         LkNvn0BZamswuVg9A44YKz6f4b7iquZMnPbyvSDeFSIGAKcTgFr93+Yci2KlgdtYY/
         6Pq2YgqbkpX3MigQ0juaU2lAFcVAUvnCfOvWTLh5KYn1sH8w1ICZNIicATGkolnYyO
         oh39itZgOdLGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D7EF4405F0; Thu, 29 Sep 2022 09:53:37 -0300 (-03)
Date:   Thu, 29 Sep 2022 09:53:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf test: Fix test case 87 ("perf record tests") for
 hybrid systems
Message-ID: <YzWVUUHSsckvR5Xn@kernel.org>
References: <20220927051513.3768717-1-zhengjun.xing@linux.intel.com>
 <YzRaAxFrg56uph+W@kernel.org>
 <CAP-5=fVgsMzx6F=rgy9kyfWS=Gj3hvtLTJmTzf6+O954x4oY_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVgsMzx6F=rgy9kyfWS=Gj3hvtLTJmTzf6+O954x4oY_g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 28, 2022 at 07:11:15PM -0700, Ian Rogers escreveu:
> On Wed, Sep 28, 2022 at 7:28 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Sep 27, 2022 at 01:15:13PM +0800, zhengjun.xing@linux.intel.com escreveu:
> > > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > >
> > > The test case 87 ("perf record tests") failed on hybrid systems,the event
> > > "cpu/br_inst_retired.near_call/p" is only for non-hybrid system. Correct
> > > the test event to support both non-hybrid and hybrid systems.
> > >
> > > Before:
> > >  # ./perf test 87
> > >  87: perf record tests                                   : FAILED!
> > >
> > > After:
> > >  # ./perf test 87
> > >  87: perf record tests                                   : Ok
> >
> > Looks sane, applied.
> >
> > Ian, consider providing your Acked-by,
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, added.

- Arnaldo
