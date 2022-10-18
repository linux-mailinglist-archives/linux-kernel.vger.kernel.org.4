Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F8603038
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJRPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJRPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:53:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E934D73D5;
        Tue, 18 Oct 2022 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9umXzzWtQP5eYE7XZAmxOba2FRKQNp21/wLkLXTZbzI=; b=q+bre3PY/IaynCNmu9+CDAXFPu
        66x3n4XJAYUXU+noAFfIBD+b/V8CdP1uO1YiIt3cdRkxltS0VzeS5bqv6J/sxsLcRVmatWXpGCI7s
        Kt7o8tMivZVS9r5fEsjq1QHSaxKZC563F9VBvaDHqJ55WF+wpi2YB7Sih+R1Of/CsKqFrwTEDN1jR
        2nltCkpsCduuEap77qlPXShT0C1lA7xAefbwdZOiKhbA9McLkJqbEPPggv8W3pRJvZWcCtHvhjwgn
        OcjmCHsUPKsj/6viOFKb9EClogeuhfggJovRw8+l3hKdylhC4f5MYmkOhcdf/qMAH/Btc+SwXM2eC
        lr5TAIHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okotL-0081B2-J8; Tue, 18 Oct 2022 15:52:31 +0000
Date:   Tue, 18 Oct 2022 08:52:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] blktrace: introduce 'blk_trace_{start,stop}'
 helper
Message-ID: <Y07Lv1BVm0+mRDS9@infradead.org>
References: <20221018145135.932240-1-yebin@huaweicloud.com>
 <20221018145135.932240-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145135.932240-2-yebin@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int blk_trace_start(struct blk_trace *bt)
> +{
> +	/*
> +	 * For starting a trace, we can transition from a setup or stopped
> +	 * trace.
> +	 */

That's pretty obvious from the check, isn't it?

> +	if (bt->trace_state == Blktrace_setup ||
> +	    bt->trace_state == Blktrace_stopped) {

I'd invert the check and return early from the function for the error
case so that the real starting code is in the main path.

> +static int blk_trace_stop(struct blk_trace *bt)
> +{
> +	/*
> +	 * For stopping a trace, the state must be running
> +	 */
> +	if (bt->trace_state == Blktrace_running) {

The same two comments apply here as well.
