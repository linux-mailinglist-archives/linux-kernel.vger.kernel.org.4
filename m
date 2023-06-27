Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545373F57B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjF0HWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjF0HVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:40 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6C2D65;
        Tue, 27 Jun 2023 00:20:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vm4sP4I_1687850391;
Received: from 30.221.150.4(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vm4sP4I_1687850391)
          by smtp.aliyun-inc.com;
          Tue, 27 Jun 2023 15:19:53 +0800
Message-ID: <e125258f-559e-ae0a-8eb3-f119b0e7c87c@linux.alibaba.com>
Date:   Tue, 27 Jun 2023 15:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
To:     Will Deacon <will@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAM9d7cj3v58m8NcsEK4sYsk_dbQDAq71hYo7DV=xaQa_rZyPYg@mail.gmail.com>
 <a5486c58-32b6-2d5e-e623-d7844c51474c@linux.alibaba.com>
 <CAM9d7chxMpUUouHsVTEvVEy8RyZ6tNzYbVD=a0Toao=n6cau-w@mail.gmail.com>
 <20230626124431.GB20045@willie-the-truck>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <20230626124431.GB20045@willie-the-truck>
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



在 2023/6/26 下午8:44, Will Deacon 写道:
> On Tue, Jun 20, 2023 at 10:00:46PM -0700, Namhyung Kim wrote:
>> On Tue, Jun 20, 2023 at 8:08 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>> 在 2023/6/21 上午3:04, Namhyung Kim 写道:
>>>> I'm curious why the first patch is needed, presumably the PMU
>>>> should have 'ali_drw' in the name already.  Do we use substring
>>>> match for the compat name in the JSON metric?
>>>>
>>>
>>> The main purpose of patch 1 is to add an identifier so that the Compat
>>> field can match the corresponding event when defining aliases or metrics
>>> for events.
>>>
>>> For example, "Unit" can match "ali_drw" in the name and different SoCs may
>>> be able to match ali_drw, but they may have different events, and even if
>>> the events are the same, the meanings may be different. Therefore, the
>>> Compat field is needed to match the Identifier to confirm which type and
>>> revision of PMU the current SoC has. Therefore, both "Unit" and "Compat"
>>> need to be matched at the same time. Although it seems that ali_drw is
>>> redundantly matched currently, it is meaningful for future expansion.
>>
>> I see, thanks for the explanation.
>>
>> I think you need to route the kernel patch differently.  I can apply the tools
>> part once the kernel patch gets Acks from others.
> 
> Sorry, I missed this initially as I didn't realise there were kernel changes
> hidden in this series (I saw "JSON" and ignored it...). Given that the 6.5
> merge window is now open, I'll pick the kernel change up for 6.6 when I
> start queueing patches in a few weeks.
> 
> Will

Thank you will, maybe it is because I did not describe this series well, and
it is easy to cause the patch to be ignored. I will pay attention to this
problem in the future.

Thanks,
Jing
