Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314206C0A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCTG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTG0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:26:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336A191;
        Sun, 19 Mar 2023 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owX/GSJ4ipiXhQOajVZWX1Me7Jms4t/oUWhAspmudyg=; b=wjYHwQ9oHIg64n/tU2CYNDk1Zf
        B7bfkHy204YrNVySBez8BG/2dfzFH5r6/tx2z+ZyH9qgRXPnzwwzz5slmLmD+56B5gQSsKcFdJMNz
        u9yCBHsn9cVyVcvrJXRPGNdKt6xqXgR4QOU1CGBvZr8wAIRU4AjgMOYOoJJ7JFtfLmOphcYmx4kNv
        IK8in1/PGXd2cMnRo00ioul6fHeaN1ue/xkapaWcuzGnbsXxEcNOiiBi4Qy6CFvqaQCMnmN1hr53s
        2BFsh3wXFDXB+INaPNuKMWcyXbUCtilRXMMwzKnK+B5Fb3GIg0oQ2pyDJ9wxxf8+1f0hqiatc/hQv
        AU+xDsOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe8xx-008E9B-0g;
        Mon, 20 Mar 2023 06:25:57 +0000
Date:   Sun, 19 Mar 2023 23:25:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports
 an internal cache
Message-ID: <ZBf8dZm1FZIusMls@infradead.org>
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
 <ZBNIg8+rOdFKcsS8@infradead.org>
 <522a5d01-e939-278a-3354-1bbfb1bd6557@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522a5d01-e939-278a-3354-1bbfb1bd6557@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:12:35PM +0200, Adrian Hunter wrote:
> Historically file systems have assumed that sectors are updated
> atomically i.e. there is never a sector with a mixture of
> old and new data.

Yes.  Not just file systems, but also all kinds of applications.

> The eMMC spec does not guarantee that,
> except for the eMMC "reliable write" operation.

Neither to ATA or SCSI, but applications and file systems always very
much expected it, so withou it storage devices would be considered
fault.  Only NVMe actually finally made it part of the standard.

> So the paragraph
> above is informing the potential benefit of reliable write instead
> of cache flush.

But these are completely separate issue.  Torn writes are completely
unrelated to cache flushes.  You can indeed work around torn writes
by checksums, but not the lack of cache flushes or vice versa.


> Note, it is not that eMMC cannot avoid torn sectors, it is that
> the specification does not mandate that they do.

If devices tear writes it will break not only various file systems,
but more importantly applications, at least on file systems without
data checksum (aka all except for btrfs, and even that has a nodatacsum
option).

> However, the issue has been raised that reliable write is not
> needed to provide sufficient assurance of data integrity, and that
> in fact, cache flush can be used instead and perform better.

It does not.
