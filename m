Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC33722FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjFETjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjFETjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE2D9C;
        Mon,  5 Jun 2023 12:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC134629C9;
        Mon,  5 Jun 2023 19:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBBAC433EF;
        Mon,  5 Jun 2023 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685993949;
        bh=rGzDSv/Mb3kU6LAr3XV8zsvhZR0s0w1HUY7G26P7hWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0O4DxG/xO/Nv1XZ4Fc53a2O/nfSCcnp2wNJGuMBqn5WEzmjOs/49kSqlCkn+6EPl
         XPqtT/RcD64p30s7Wz6y6fpZIF0kdhFwHFWaLeq8qlbv4o413VFmcNlDpIGo61W7it
         lmh7ZXENGeFGrOxYs2tpfnQo+HRLvsx+R9NMuj12Bq8H6KkJy5ZhhTOTr736HsWQb6
         hK14MN+76HewPyHGHgRmJOPFnK9MbXBUnsbqZIY5iC3ZUz8QxMEtK2DhMfBTCkZRO3
         hpW7BLYqEqGufFgBN58LTapOjyOCpNDvImQW4RODQf26IlWXT8Z87TEbwWE1FnP4pm
         4beQLdpnAUK8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BED540692; Mon,  5 Jun 2023 16:39:06 -0300 (-03)
Date:   Mon, 5 Jun 2023 16:39:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
Message-ID: <ZH452mAFn1uNo4NF@kernel.org>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 05, 2023 at 10:46:36AM +0800, Jing Zhang escreveu:
> 在 2023/6/3 上午12:20, John Garry 写道:
> > On 01/06/2023 09:58, Jing Zhang wrote:
> >> It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
> >> In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
> >>
> >> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
> >> "arm_cmn700_4", it can be matched.
> > 
> > OK, I see what you mean. My confusion came about though your commit message on this same patch, which did not mention cmn650. I assumed that the example event which you were describing was supported for arm_cmn650 and you intentionally omitted it.
> > 
> 
> Yes, I didn't write cmn650 in the commit message, just because I omitted it. I will add it in a later version.

Ok, will wait for v4 then.

- Arnaldo
