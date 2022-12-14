Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949B364CE45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiLNQoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiLNQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:44:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABE81A3BA;
        Wed, 14 Dec 2022 08:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LUIcL+YXbcbzvkfJ4G0OlJ2uFHW1TivRGIOqxGEv0/8=; b=gSAfY5ddPi2TwSDSFkf0Y9QKWA
        n7BBpDDTJRFtjZrMHyZm1SvSOv/lQ+TQfLeCEehgDrTmx0nmQNfhdmaxTzGjhe4NH6QtEzTZ92DfM
        X/u9rC16spIa4Fr9n23l6a+DMwUuYmQP8d2pRI+NiN3ceG15HE1AtxJQ7xysLWBjg0jt6un25NBJ2
        D5Dyt9HsIFn2IrIYN2zg7HQTGLJs5/Fgr4PVtKPUJvSZ7J/CrH0YpwYl6YAN8QASt7ZkwWBRhZHn4
        DEj4taU/2obMToxaNl7qFEUCsBG6tK8t94KFtM2WCOW3Qe07fj/00npp0Xhw194enMECXgJflWaA6
        o7VsnK4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5Urj-000mR8-56; Wed, 14 Dec 2022 16:44:19 +0000
Date:   Wed, 14 Dec 2022 08:44:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH 1/2] init: move block device helpers from
 init/do_mounts.c
Message-ID: <Y5n9Yz4fNzAWczF5@infradead.org>
References: <Y5hz9nuq7tECYcyt@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5hz9nuq7tECYcyt@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:45:42PM +0000, Daniel Golle wrote:
> In init/do_mounts.c there are helper functions devt_from_partuuid,
> devt_from_partlabel and devt_from_devname. In order to make these
> functions available to other users, move them to block/bdev.c.

NAK.  As pointed out many times there should be no more users.
These functions are a horrible hack forthe  pre-initramfs boot
code and should not grow any additional users.
