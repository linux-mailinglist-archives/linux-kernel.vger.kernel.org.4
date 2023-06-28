Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F14740789
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjF1BRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1BQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:16:58 -0400
X-Greylist: delayed 159059 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 18:16:55 PDT
Received: from out-52.mta0.migadu.com (out-52.mta0.migadu.com [IPv6:2001:41d0:1004:224b::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C92F2139
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:16:55 -0700 (PDT)
Message-ID: <61ccfd88-1d08-124b-02cc-213107e81438@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687915013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qh54UmxMUrYnf3XawZlR6M2UEV3kFrEfjxB/XEVSXo=;
        b=CBD8Ex1dSBrqVpzY5Kq0adyotRuj/OdOnUZqi7ddyhhKG3Aoj0GkoD3O9nOC2EUvQtXrQM
        IHqGyzcql5kqehzYm7Midalcd45bqJzldHoHMZh+R81ELfwwlRhG7A5/3kPIeHaH/Aafqp
        XwbL2iHfvPIuDOZYyBIqXYYveG4b7gY=
Date:   Wed, 28 Jun 2023 09:16:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230626050405.781253-1-chengming.zhou@linux.dev>
 <20230626050405.781253-4-chengming.zhou@linux.dev>
 <ZJn5F4xb6gln0653@slm.duckdns.org>
 <e1da325b-8f16-f4d2-d6bf-65976a4239b4@linux.dev>
 <ZJsuszuMcX72R7qD@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJsuszuMcX72R7qD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 02:47, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 27, 2023 at 07:32:42PM +0800, Chengming Zhou wrote:
>> Since all requests in batch allocation use the same alloc and start time, so this patch
>> just leave it as it is, and reset it at actual used time.
>>
>> I think both way is ok, do you think it's better to just set the popped one request, leave
>> other requests time to 0 ? If so, I can update to do it.
> 
> I think it'd be clearer if the rule is that the alloc time is set once when
> the request is actually dispensed for use in all cases, so yeah, let's just
> set it once when it actually starts getting used.
> 

Good, I will update the patchset today.

Thanks.

