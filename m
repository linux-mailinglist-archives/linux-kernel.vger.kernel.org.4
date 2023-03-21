Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB96C31CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCUMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:37:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FB4346F;
        Tue, 21 Mar 2023 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EKPzzBQ3FvBycDuqBFuN9h8/3as7Wm8d7ysB+f2krm4=; b=nvjbX0z/nmnuQ6KwN3CNm8WoLu
        oyEVoMHPWDfIbLBsKuQBad4rZOOiRoj5uThoiY3ks5tCiIvftymvBulFkhxEeNft/MYn6IUmgQzTX
        xlWmqmGKYRdKZlKb/eP5Qupv1MBzXbv2T3mStJjk2S8lbDPiTtF5XVVPyLSxVGxUBHBsc+AeiNFyh
        pkrDNXbSNnzs4NeGGEdoBYxtdFWKiW9vRbGijsMbUyoNFz+Mw0BaTLocTU7JlVRj+1NbTg/zTSIRm
        Ts2x53hXcC+N11eHg7QYP8n945U6vZPrlZgqMjPrGyIJQj6eLTRMTWadfHu3OlFLvzqu45sIMa1Y9
        qKQ4zYKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pebF1-00CLpY-1d;
        Tue, 21 Mar 2023 12:37:27 +0000
Date:   Tue, 21 Mar 2023 05:37:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports
 an internal cache
Message-ID: <ZBmlB2K3KMt7Apv5@infradead.org>
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
 <ZBNIg8+rOdFKcsS8@infradead.org>
 <522a5d01-e939-278a-3354-1bbfb1bd6557@intel.com>
 <ZBf8dZm1FZIusMls@infradead.org>
 <CAPDyKFogTyf30X+3JGeqf+yER_OLQ8JwXy6oEF3Rn78KzLSDxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFogTyf30X+3JGeqf+yER_OLQ8JwXy6oEF3Rn78KzLSDxw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 04:24:36PM +0100, Ulf Hansson wrote:
> > Neither to ATA or SCSI, but applications and file systems always very
> > much expected it, so withou it storage devices would be considered
> > fault.  Only NVMe actually finally made it part of the standard.
> 
> Even if the standard doesn't say, it's perfectly possible that the
> storage device implements it.

That's exactly what I'm saying above.

> > But these are completely separate issue.  Torn writes are completely
> > unrelated to cache flushes.  You can indeed work around torn writes
> > by checksums, but not the lack of cache flushes or vice versa.
> 
> It's not a separate issue for eMMC. Please read the complete commit
> message for further clarifications in this regard.

The commit message claims that checksums replace cache flushes.  Which
is dangerously wrong.  So please don't refer me to it again - this
dangerously incorrect commit message is wht alerted me to reply to the
patch.

> > > However, the issue has been raised that reliable write is not
> > > needed to provide sufficient assurance of data integrity, and that
> > > in fact, cache flush can be used instead and perform better.
> >
> > It does not.
> 
> Can you please elaborate on this?

Flushing caches does not replace the invariant of not tearing subsector
writes.  And if you need to use reliable writes for (some) devices to
not tear sectors, no amount of cache flushing is going to paper over
the problem.
