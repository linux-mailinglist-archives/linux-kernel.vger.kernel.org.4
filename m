Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB82624F04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKKAjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKKAjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:39:36 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6C311C21;
        Thu, 10 Nov 2022 16:39:35 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1otI4k-0006Am-98; Fri, 11 Nov 2022 01:39:18 +0100
Date:   Fri, 11 Nov 2022 00:39:15 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] mtd_blkdevs: add option to enable scanning for
 partitions
Message-ID: <Y22Zs7Jg0FNFHeHD@makrotopia.org>
References: <Y2rgbfpYfpbLKHaf@makrotopia.org>
 <1691046252.219046.1668109493753.JavaMail.zimbra@nod.at>
 <Y21ZXRKJF3hZg8wk@makrotopia.org>
 <871124728.219224.1668111155161.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871124728.219224.1668111155161.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:12:35PM +0100, Richard Weinberger wrote:
> ----- Urspr�ngliche Mail -----
> > On Thu, Nov 10, 2022 at 08:44:53PM +0100, Richard Weinberger wrote:
> >> ----- Urspr�ngliche Mail -----
> >> > Von: "Daniel Golle" <daniel@makrotopia.org>
> >> > +
> >> > +		if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS) || mtd_type_is_nand(new->mtd))
> >> > +			gd->flags |= GENHD_FL_NO_PART;
> >> 
> >> I know that NAND should not get used with mtdblock because lack of wearleveling
> >> and
> >> in general too many writes. But what exactly is the rationale to deny part
> >> scanning for NAND?
> > 
> > As UBI should be used on NAND, partition scanning should be enabled for
> > ubiblock devices to have uImage.FIT filesystem subimages mapped by the
> > partition parser.
> > 
> > If not skipping partition scanning on NAND-backed mtdblock devices the
> > scanning itself will already trigger multiple warnings which now happen
> > every time when a NAND-backed mtdblock device is being opened since
> > commit 96a3295c ("mtdblock: warn if opened on NAND").
> 
> I see, you want to promote UBI. Makes sense.
> In case you do a v5 series, please add a comment to the code.

Will do, I'm planning to send v5 early next week.

If we are going to have only CONFIG_MTD_BLOCK_PARTITIONS and no other
config symbol for ubiblock devices I'd also merge the two patches for
mtdblock and ubiblock partition scanning into a single one.

Thank you for reviewing!


Daniel
