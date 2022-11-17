Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80862D324
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiKQGAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiKQGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:00:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A58A16581;
        Wed, 16 Nov 2022 22:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ka0zWX28jwmPVoBvV9gqCxIV7SNbOuU8UYsaU9048Q8=; b=D6quLTD6qQFeVVAaaaR6f+qtrB
        z/Jom9O6meODBzgm1GH6/KunvdEvNQY7XIMs3gRtEKvbWXXa0owllsCKvC3e/LR+J2U+yyyudYQU3
        cIwBElUPrpB+w4DOQzPLlDLltNf0nD842kVjXsMvIjNHdVMo9VKHypAipsl/xkIqF2x1vRzJ302e8
        A+rOQp3h5vyXKSjjFD6NWl6ApWw0PmKNAX6b2mmxML0xZTIy8NJqVDcXaaN1Ti/enDG8WX6Jw7rcd
        9YwizRkHVVMoYixOy/i5yrS50o27AXxVMY1VrnEc8rWUL6FMm3kFLxHWgwyF5e1vRlq1eNC3QjxmH
        RyZ8oQUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovXwn-00AcUt-IU; Thu, 17 Nov 2022 06:00:25 +0000
Date:   Wed, 16 Nov 2022 22:00:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] partitions/efi: add support for uImage.FIT
 sub-partitions
Message-ID: <Y3XN+fDTjHz09qEE@infradead.org>
References: <cover.1668548123.git.daniel@makrotopia.org>
 <7526fc5a461a0d68eb1dab575f9c1950638fc21a.1668548123.git.daniel@makrotopia.org>
 <Y3R8oQXRQ8uq8p4P@infradead.org>
 <Y3V9/pmHs7ypE7lb@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3V9/pmHs7ypE7lb@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:19:10AM +0000, Daniel Golle wrote:
> While weirdness is certainly subjective, uImage.FIT is not just a
> random image format but used by a great majority of headless embedded
> Linux devices out there. It's the default image format of many of the
> SDKs distributed by chip vendors such as Allwinner, Marvell, MediaTek,
> NXP, Qualcomm/Atheros, ...

"Look see, my weird format is used by all these companies building
crappy SOCs, it is not weird.."

> Please let me know if this sounds acceptable, so I won't put effort
> into implementing something which will then be rejected again after 5
> iterations on the mailing list for reasons which could have been
> expressed from the beginning. An RFC for this series was posted on
> 2022-04-25 [1], I wouldn't have worked months to fix all requests of
> other maintainers and tested it on a variety of different hardware
> knowing that the whole approach will be NACK'ed...

If people ignore something that is obviously broken they might just hope
for it to go away, becaue often it does.
