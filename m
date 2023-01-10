Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCC66397D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjAJGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAJGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:49:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E16321BB;
        Mon,  9 Jan 2023 22:49:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E23168B05; Tue, 10 Jan 2023 07:49:00 +0100 (CET)
Date:   Tue, 10 Jan 2023 07:49:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from
 blkg_conf_prep/finish()
Message-ID: <20230110064900.GA10277@lst.de>
References: <20230105212432.289569-1-tj@kernel.org> <20230105212432.289569-2-tj@kernel.org> <20230108170240.GA19165@lst.de> <Y7x9t+4EwXFl7OwS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7x9t+4EwXFl7OwS@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:48:55AM -1000, Tejun Heo wrote:
> Now that all RCU flavors have been combined, holding a spin lock, disabling
> irq, disabling preemption all imply RCU read lock.

Can you write it like this in the commit log, please? 

> I can drop the changes but this actually bothers me. The annotation has been
> broken for a *long* time and nobody noticed. Furthermore, I can't remember a
> time when __acquires/__releases notation caught anything that lockdep
> couldn't trivially and can't even think of a way how it could. AFAICS, these
> annotations don't contribute anything other than preservation of themselves.
> I don't see why we would want to keep them.

People have noticed it.  It just hasn't been a priority as there are
lots of even more problematic things.
