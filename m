Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF60725DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjFGLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbjFGLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:50:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F3761BE5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:50:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF26AB6;
        Wed,  7 Jun 2023 04:50:56 -0700 (PDT)
Received: from [10.57.24.86] (unknown [10.57.24.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E31A3F6C4;
        Wed,  7 Jun 2023 04:50:09 -0700 (PDT)
Message-ID: <2a9ed73a-256c-4ace-6b26-e30ac69cbdbc@arm.com>
Date:   Wed, 7 Jun 2023 12:50:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <20230211172829.f2igueizqpwijjjz@airbuntu>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20230211172829.f2igueizqpwijjjz@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 2023-02-11 17:28, Qais Yousef wrote:
> On 02/07/23 10:45, Vincent Guittot wrote:
>> [...]
> 
> Isn't it better to go back to v1 form then? The inconsistent type paired with
> the cast isn't getting too ugly for me :(
> 
> I don't think we can convert cpu_cap to long without having to do more work as
> it is used with 'util'.

Sorry if I'm missing something obvious, but why can't we convert util to 
long? The only place I see which mixes with util is

	lsub_positive(&cpu_cap, util);

but at this point both cpu_cap and util should have sane values (top bit 
not set) so doing clamped subtraction should just work fine?

Hongyan
