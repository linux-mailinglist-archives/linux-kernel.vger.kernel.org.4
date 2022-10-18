Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF46025FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJRHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJRHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:40:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F31135;
        Tue, 18 Oct 2022 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=15NCkKgLMuQLzxL5npYUzX5h0+d6v+LAZHYlqwZhX/I=; b=2dIxVBCxo2PVGleuIxWGtdFE4F
        QJilqrPtxuclT82GK8v+7gMZ/13PkPJ/kSX55DNAzqWjeWN4vgvPt9GSrFoLSsGDWpYVDYB4wXkjv
        xH7aANVoXcAJqZTYvpp+jS/C7TgkSksI3LMnOs96my1zy6iopjyadaUmS18oR+jxmjz1hVp/6aZGQ
        72l1cvLe9G7BD9BXi2BIGhpX//i7U2XXJ75syBnsGW3apLnV6G8Vlsx63uVT4BDsMA1yB4fn1395Z
        nkgqit5UUlOeAH2RHd9A+25JkP/JUTe2Wox7xz00ORvqZxVDqRatF1fQUnTjP1wGte3b+7zwR2ydK
        2sV7kdAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okhD9-003vLl-QV; Tue, 18 Oct 2022 07:40:27 +0000
Date:   Tue, 18 Oct 2022 00:40:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/3] blktrace: introduce 'blk_trace_swicth_state'
 helper
Message-ID: <Y05Ya7+KdR4Kz6EG@infradead.org>
References: <20221017065321.2846017-1-yebin10@huawei.com>
 <20221017065321.2846017-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017065321.2846017-2-yebin10@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:53:19PM +0800, Ye Bin wrote:
> +static int blk_trace_switch_state(struct blk_trace *bt, int start)

This is a very confusing helper.  Please split it into two helpers
(e.g. blk_trace_{start,stop}) instead of the awakward int used as
boolean argument that makes it do two entirely unrelated things.
