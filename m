Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942D26CB183
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjC0WQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjC0WQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:16:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F410D;
        Mon, 27 Mar 2023 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1zi/i86E8XgBRgRxeY/BsLYtQQ6Fdg+6BWeRfJn0r9k=; b=xWZpxnLz+ETa/xI6MKcTDuiRv1
        ZSb/Q0i8haEL/oC5wP5V1DB80hFBySd5UR+7yRBq8F6WfIj4q+NSC8WJwnZIq/j3OPk55c3b5obQU
        PK9ZTWt3rWsbAzUiTNdFfo7DgIAG8W8LirYSq/0TwtZ7O7B69RXQH43rHpVUOIl48LG0GMrIuFc1G
        R+T7Yhiee5kE0TBno5lDY47SIJpXVSbXOfyhShl6/2nCTvG1h3/qrM0gPFxdbCTHZa0qH15TYj2UT
        0CjxURw6g2HpBjGXD/opMCdtQShWmNDKk1BNp+1aay+aVFW4DQDGdc6V3kjke/+By0TUF/Pom0WLU
        grsQ99/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgv8p-00CVth-2l;
        Mon, 27 Mar 2023 22:16:39 +0000
Date:   Mon, 27 Mar 2023 15:16:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: annotate bdev_disk_changed() deprecation with a
 symbol namespace
Message-ID: <ZCIVx2UNN8VAWYAH@infradead.org>
References: <20230327184410.2881786-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327184410.2881786-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:44:10AM -0700, Luis Chamberlain wrote:
> Instead of relying on fragile documentation which can easily let us
> slip, use a symbol namespace to annotate which symbols should not be
> used by others.
> 
> This ensures no other users pop up by mistake easily and provides
> us a with an easy vehicle to do the same with other routines should
> we need it later.

I don't think deprecated really cuts it.  For these two drivers we
can't really get rid of the calls as it is part of their ABI.

What I'd really want is something like an

EXPORT_SYMBOL_FOR(bdev_disk_changed, loop, CONFIG_BLK_DEV_LOOP);
EXPORT_SYMBOL_FOR(bdev_disk_changed, dasd_kmod, CONFIG_DASD);

Which ensures that the symbol lookup only succeeds for loop.ko and
dasd_kmod.ko, and that the export only happens if the relevant
symbols are set.
