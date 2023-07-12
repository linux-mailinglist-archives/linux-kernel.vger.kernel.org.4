Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E4750857
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjGLMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGLMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:33:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33481134;
        Wed, 12 Jul 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q28lbPibQoRUf1yZd4fvu6bxrGujY0ouRUurZ5rXnSs=; b=j7kRWgylLqK+jYPyG+Dp+9L9cI
        NYJMrZ7LJsYQHxxEHCt9mIvYYaUA4j/4e2mt2gpgikT6Xtb4elMDlfatkCIVB2glxtc5rTumoTtgA
        E/WMFzVxBzfJ5dgXJKCGahu4JsY2bLXmzuzlSUoi0VhJiKvSLdihmk4F0actsEVJo48Yqw/fWS1nb
        EQ4cmqfaLTW8BMF4EWpUmAAR4IiSoLt3Q6gnDu+Z0xQBKlJg9SvkbVzazNzjzy/P5T/TB8SVtLd1T
        Smjw8Z8hCP+yYKMOMEwQ7Z8L1fKz2k1vMOQqjIhGlhxpirtvvEs2CsJMB0d41qj64s21EEkhoxb2O
        /V0IKhTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJZ2N-00HXix-0L;
        Wed, 12 Jul 2023 12:33:43 +0000
Date:   Wed, 12 Jul 2023 05:33:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix stall due to recursive flush plug
Message-ID: <ZK6dpy7w/4YSwbBi@infradead.org>
References: <20230711160434.248868-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711160434.248868-1-ross.lagerwall@citrix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:04:34PM +0100, Ross Lagerwall wrote:
> We have seen rare IO stalls as follows:
> 
> * blk_mq_plug_issue_direct() is entered with an mq_list containing two
> requests.
> * For the first request, it sets last == false and enters the driver's
> queue_rq callback.
> * The driver queue_rq callback indirectly calls schedule() which calls
> blk_flush_plug().

-> this assumes BLK_MQ_F_BLOCKING is set, as otherwise ->queue_rq can't
sleep.

> * blk_flush_plug() handles the remaining request in the mq_list. mq_list
> is now empty.
> * The original call to queue_rq resumes (with last == false).
> * The loop in blk_mq_plug_issue_direct() terminates because there are no
> remaining requests in mq_list.
> 
> The IO is now stalled because the last request submitted to the driver
> had last == false and there was no subsequent call to commit_rqs().
> 
> Fix this by returning early in blk_mq_flush_plug_list() if rq_count is 0
> which it will be in the recursive case, rather than checking if the
> mq_list is empty. At the same time, adjust one of the callers to skip
> the mq_list empty check as it is not necessary.

From what I can tell this looks correct, but at the same time very
fragile.  At least we need a comment on learing plug->rq_count early
in blk_mq_flush_plug_list about this recursion potential, probably
paired with another one where we're checking rq_count instead of the
list now.  I wonder if there is a better way to do this in a more
explicit way, but I can't think of one right now.

