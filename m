Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B870ECC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjEXE7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjEXE7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:59:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9A13E;
        Tue, 23 May 2023 21:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3cqLQxSD9pGuqgjwI40zZQxFCK7ZM0myf/djuDV5MFg=; b=fwDNoeFbu59alevHNXxjQ4UtcX
        z4Nmn91xZTx2tfK9c/84TCrR7U0lEPaXIyi0YCtlrOsdU0yI3kfG6hgm3vxKv0txBywb0QQn8xo7b
        WA/TJqaIhOTkyK/+PsT8Wo5aXRNWSiLAft36+EU9A76hU1hw/EdjynpSBKuiPw2jZpjHJPtvSOWpX
        aHnd8xa+vN0kWv4BYUWLZc4Q3mrRO2zubNbtWLOWzmm7wNxU5XO87vRbWAskvdWzCz0wQbyAmk6AJ
        +BBFUKXtbaVsYD9KLE2Zg8ZsGWIruTEeftNL95FFSumG+Z52rQocISza4Jh3Eva6F/Cxi/8xGYTqE
        vVXHccEQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1gaM-00CMV4-1i;
        Wed, 24 May 2023 04:58:54 +0000
Message-ID: <b384f464-92c6-6a14-4072-1faa9fa6a6a8@infradead.org>
Date:   Tue, 23 May 2023 21:58:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/24] block: move the code to do early boot lookup of
 block devices to block/
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-16-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230523074535.249802-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 00:45, Christoph Hellwig wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f08b83e62c6222..3f8cf6dc7de887 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5452,7 +5452,7 @@
>  			port and the regular usb controller gets disabled.
>  
>  	root=		[KNL] Root filesystem
> -			See early_lookup_bdev comment in init/do_mounts.c.
> +			See early_lookup_bdev comment in block/early-lookup.c

Patch 13 does this:

 	root=		[KNL] Root filesystem
-			See name_to_dev_t comment in init/do_mounts.c.
+			See early_lookup_bdev comment in init/do_mounts.c.

Should this latter chunk be dropped?

-- 
~Randy
