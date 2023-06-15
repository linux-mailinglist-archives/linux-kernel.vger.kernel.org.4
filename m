Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C6730DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjFODmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjFODmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:42:07 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D70191;
        Wed, 14 Jun 2023 20:42:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vl8rmkW_1686800519;
Received: from 30.221.149.117(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vl8rmkW_1686800519)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 11:42:02 +0800
Message-ID: <c8494676-25f8-72de-3279-70d49b74a91c@linux.alibaba.com>
Date:   Thu, 15 Jun 2023 11:41:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <ZH452mAFn1uNo4NF@kernel.org>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <ZH452mAFn1uNo4NF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/6 上午3:39, Arnaldo Carvalho de Melo 写道:
> Em Mon, Jun 05, 2023 at 10:46:36AM +0800, Jing Zhang escreveu:
>> 在 2023/6/3 上午12:20, John Garry 写道:
>>> On 01/06/2023 09:58, Jing Zhang wrote:
>>>> It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
>>>> In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
>>>>
>>>> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
>>>> "arm_cmn700_4", it can be matched.
>>>
>>> OK, I see what you mean. My confusion came about though your commit message on this same patch, which did not mention cmn650. I assumed that the example event which you were describing was supported for arm_cmn650 and you intentionally omitted it.
>>>
>>
>> Yes, I didn't write cmn650 in the commit message, just because I omitted it. I will add it in a later version.
> 
> Ok, will wait for v4 then.
> 
> - Arnaldo

Hi Arnaldo,

Thank you for following up this patchset, maybe we can merge patch4 to patch7 into your branch first?
They have all been reviewed/acked and there is no dispute. And patch4-7 does not depend on patch1-3,
because patch4-7 is about the metric of ali_drw_pmu, and patch1-3 is about the metric of arm_cmn.
It may take some time for patch1-3 to reach a consensus.

Thanks，
Jing
