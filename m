Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186C764D78C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLOILQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:11:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24488264BD;
        Thu, 15 Dec 2022 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7F/w1+bgYd6v1VWCuyfIhzBdoJUVqxRnHsydL7xQkFk=; b=k3vh0K6gvoIhiuLJikZaqSewrJ
        Kdvu11aUfhQc4RsykQBeuX26MlnuYCO/F8PlajVGadrk/9hI2SLKv8kTUdppog5F41O/VTf1nwmhF
        w85SJbCQjBUrcGts9YRI63ubWA57fC8ld9DNuyHCdb1RnIiAUZVIetzqrZhYdtgtvCGMmY9VGh6Po
        cytStLdwW4PKOOar7+OPcJTKl+Q6wpK6++9Pp1UpZsWLRgYXVVqo4ShWofUqWEfPgV2OdcZU7Tnwg
        Upav0l2OLN3mZ8bb5kyG71CQk9LtuDcG+esbbtbKlOuPVoqnaMPGWyFRrBRnrmrl6vHwXyZQhl/no
        JPLNUbsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5jKh-007XKW-7p; Thu, 15 Dec 2022 08:11:11 +0000
Date:   Thu, 15 Dec 2022 00:11:11 -0800
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
Subject: Re: [RFC PATCH 2/2] block: add uImage.FIT block partition driver
Message-ID: <Y5rWn85kmuzeTvPW@infradead.org>
References: <Y5h0C4iKoeCJgRCb@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5h0C4iKoeCJgRCb@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	dev = class_find_device_by_devt(&block_class, devt);
> +	if (!dev)
> +		return -EPROBE_DEFER;

FYI, class_find_device_by_devt is not for driver use.  The only reson
it isn't marker static is because of various legacy driver model and
devtmpfs interactions.
