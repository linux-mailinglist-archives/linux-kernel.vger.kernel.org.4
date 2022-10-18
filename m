Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAA602607
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJRHl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJRHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:41:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502AB36DD9;
        Tue, 18 Oct 2022 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jax8WsvgWCLEDfYEgIyhaUWsRzyH31RMbbNyco9nBvE=; b=oPJjOlxzMyn/wvmsgI/5rU3SuG
        U46HISEzXZw2eTE+FEZzqs7/SJqreOVSSX40QjHzyyJHBmdNyZfSf7IwhBCcMFMeQuRGo3RDSaMZD
        455DBHNTA/GNqXAGzZgUMH8Xxqwj+kmEb1KCBd+pT1XJh0ab+cK+S4fSJY8uglM9B8KafIRpuwyAK
        59hGfjeTxQc5Adv12ugJyDu9KYcbxCcHDr2H2opH4m52LXglnv+YLY3Ze+ER9yU649BBicE84veCy
        furhQTZ/iTxNFglswOCqHDUf2kFJe5jTV2L8af1o7413n+8BM9xqqC/bW4CwUoyHQILUibZQRSKDd
        UC+W/thQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okhEO-003wZL-71; Tue, 18 Oct 2022 07:41:44 +0000
Date:   Tue, 18 Oct 2022 00:41:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] blktrace: fix possible memleak in
 '__blk_trace_remove'
Message-ID: <Y05YuJO2WDGasWdS@infradead.org>
References: <20221017065321.2846017-1-yebin10@huawei.com>
 <20221017065321.2846017-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017065321.2846017-3-yebin10@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:53:20PM +0800, Ye Bin wrote:
> +	if (bt->trace_state == Blktrace_running)
> +		blk_trace_switch_state(bt, 0);

AFAICS blk_trace_switch_state already has that state check, so there
should be no need to duplicate it here.

I think having this call in blk_trace_cleanup itself might be a little
more obvious, too.
