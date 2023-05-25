Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7271092E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjEYJuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEYJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:50:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A5197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KFZI0jrvSnP8i73jOgPau2f4uBHJqNU4q0kHLQiJIwk=; b=G7sduiF1N7/mNC2HnetFtqFaxt
        BUcKM04q3z55SQjhS5mX6ujntAykMlhBipyJ8yJd2ofjoUjHODiIDxpdoXIVbCOlMYtp63RmwP3IQ
        MRRhftNZ9kuvYiybyYSt1ZlgD2Pm2Ompcxn5dSsDxC/cnAW/WbHQZi8u0C8oyQ/5gxPsuOfKJwqk3
        kYHW/cEIHGxenupsPYfbBhCombPEEUtrd/Lb3WjIIbpiHDnMPp3UAbdKAxD+HAZMibtP2I7VfLybh
        aArXBg+ocWd7JuKSveCDb48pXvHm65JMC2kGe2RvzJUOEW3FCVJCBLaeTSTip/Pgi085R5pf1bMdz
        QZcwBkJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q27bj-00GBmU-0Z;
        Thu, 25 May 2023 09:50:07 +0000
Date:   Thu, 25 May 2023 02:50:07 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     "hch@infradead.org" <hch@infradead.org>, kernel <kernel@axis.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] ubi: block: Fix deadlock on remove
Message-ID: <ZG8vT8f0mTjTpNgP@infradead.org>
References: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
 <20230523-ubiblock-remove-v1-2-240bed75849b@axis.com>
 <ZG2o4rrfqWGbYziq@infradead.org>
 <fa2a06491cf2d90eb35c95042f888cd49df119fe.camel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2a06491cf2d90eb35c95042f888cd49df119fe.camel@axis.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:36:39PM +0000, Vincent Whitchurch wrote:
> On Tue, 2023-05-23 at 23:04 -0700, Christoph Hellwig wrote:
> > If you imlement ->free_disk, the list_del and kfree can move into
> > that, and we don't really care if a new opener raced with the delete.
> 
> Moving the kfree() to ->free_disk() works, but the list_del() still
> needs to be in ubiblock_remove() since otherwise ubiblock_remove() could
> attempt to remove the same device twice.

Or we'd still need your removed flag..

> I assumed the current code really wanted to prevent new openers racing
> with delete, but if that is not needed, yes, we don't need to add a
> ->removing flag if we move the kfree() to ->free_disk().  I'll re-spin
> this based on your suggestions.  Thanks.

I think in the past we always had to protect against removals of live
devices because handling of hot removes sucked so bad, both in drivers
and in the block layer itself.  With some newer infrastructure including
the ->free_disk method this can now be handled sanely.
