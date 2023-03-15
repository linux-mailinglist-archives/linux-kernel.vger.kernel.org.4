Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0926D6BB6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjCOPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjCOPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE3C968D3;
        Wed, 15 Mar 2023 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l59wLLAdYkWPRXL2DR8xpU5dwlDJ3Y0fL5Qut2OPdh0=; b=H9TdPAnkNRPy6L5nWfp8dRCPQY
        3hbLEBY2TaPEDwRnp6mB945iHEGkTfcawPYlQHyBDdYFTN3kW3fIQbDebeC1V/JPrET+gE/FxwTSZ
        hDJB1MwPXEwBcPMj/lC0NfavlBi0C3k3FKrgxDHww8WEDWsxAzbEZVdUMXm3V2lKHg/4VbWfoPwos
        FMyOTVVb5Qa8uN4tLCGM7WDQUPAhw179iObEAXtvCu81yYS8n90q0ZAzig2Z+fML/7bJ/SGlsvdHp
        NGahIHzVOuNQuccJmQnyOZaOmwHC3LPrDVrUabqjdfrvvh1JIA/t9rLAWC0n6NcG2W8+C+xmKOdpi
        YA2JWcMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSc6-00Dj3s-2Y;
        Wed, 15 Mar 2023 15:00:26 +0000
Date:   Wed, 15 Mar 2023 08:00:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 1/4] blk-integrity: use sysfs_emit
Message-ID: <ZBHditvgrS3jKvNr@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-1-761a50d71900@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-1-761a50d71900@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if (bi->profile && bi->profile->name)
> -		return sprintf(page, "%s\n", bi->profile->name);
> +		return sysfs_emit(page, "%s\n", bi->profile->name);
>  	else

Might be worth to drop the else here if you touch the function.

>
> +	return sysfs_emit(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);

Please shorten these != 0 to !! expressions, i.e.

	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_VERIFY));

