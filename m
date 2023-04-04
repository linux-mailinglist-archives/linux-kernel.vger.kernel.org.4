Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAB6D60ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjDDMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjDDMj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0732D42;
        Tue,  4 Apr 2023 05:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562176314D;
        Tue,  4 Apr 2023 12:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4FC4339B;
        Tue,  4 Apr 2023 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680611950;
        bh=a4AitIhE2YMaf2uGBiw5XqIWZjiX7Lf1oP9sgnwjTXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSysgeUp0CAWy+7LsPKT7bVD4e7zKQkALNr6zVEZ7/lNInr0PXDkFteRzZM9txcAu
         ZKgevhbCCz6uvaUy1wJPXvhU/68rH/cnv7dZQQ4paIyeaHJUUPS7IL+7GszP29sAUd
         T5Mk15BDYb9bG7eqLZ4uBxiAaCRBsYzazLntvXxo07XMyzWlz6FyG2Jwww7TtAXqno
         SWpWYwOkdcv6Xx0KANpihWxhKfgdZoJaqi6zYb6zX4iwNT1hEkBmzc/8wN/18hmMBp
         cdqjVRCKDlEtGDGhPLiWwrlUZkUlsvJnJAfv/QA8/+9F3qByYd4FnSUJi7oqwE1FQZ
         +gK8Iba2k69IQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B9904052D; Tue,  4 Apr 2023 09:39:08 -0300 (-03)
Date:   Tue, 4 Apr 2023 09:39:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu: Make parser reentrant
Message-ID: <ZCwabKeceQUqgtAd@kernel.org>
References: <20230403172031.1759781-1-irogers@google.com>
 <ZCvT+OvZKQqsw8mh@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCvT+OvZKQqsw8mh@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 04, 2023 at 09:38:32AM +0200, Jiri Olsa escreveu:
> On Mon, Apr 03, 2023 at 10:20:31AM -0700, Ian Rogers wrote:
> > By default bison uses global state for compatibility with yacc. Make
> > the parser reentrant so that it may be used in asynchronous and
> > multithreaded situations.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

So this clashed with Namhyung's recent series, please update it using
what is in tmp.perf-tools-next.

- Arnaldo
