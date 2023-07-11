Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AE74EC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGKLGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGKLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:06:30 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BD98
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:06:28 -0700 (PDT)
Message-ID: <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689073586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMioJTi4y2yktAcf9xKDTRkg/Tfq6T8MUKYPAN6XQNE=;
        b=JncusKNOhbbD+6X8VyMjkP3dbCPVKOB1W1YoXAImaqaMgwRb9fNudqbjZOdocOW5r3XCdy
        C/AXSJWtBOzGXaStNlFu75e9xwwqTeTc+hbsboLj+OxpiXUGTW/ZlmqsreKCVf2o+Mn1OR
        Dc3XDamu2g9nOnoJ6cXPbYQc4A1sz0s=
Date:   Tue, 11 Jul 2023 19:06:20 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710133024.GA23157@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230710133024.GA23157@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/10 21:30, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 02:47:04PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
>> data sequence and post-flush sequence need to be done for this request.
>>
>> The rq->flush.seq should record what sequences have been done (or don't
>> need to be done). So in this case, pre-flush doesn't need to be done,
>> we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.
>>
>> Of course, this doesn't cause any problem in fact, since pre-flush and
>> post-flush sequence do the same thing for now.
> 
> I wonder if it really doesn't cause any problems, but the change for
> sure looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> It should probably go before your other flush optimizations and maybe
> grow a fixes tag.

Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.

Thanks.

