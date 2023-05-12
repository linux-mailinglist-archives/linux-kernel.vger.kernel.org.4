Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7673570096A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbjELNrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjELNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:47:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE6124B8;
        Fri, 12 May 2023 06:47:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1250E68AA6; Fri, 12 May 2023 15:47:09 +0200 (CEST)
Date:   Fri, 12 May 2023 15:47:09 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/14] block: fix not to apply bip information in
 blk_rq_bio_prep()
Message-ID: <20230512134709.GC32242@lst.de>
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1> <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p7> <20230510085111epcms2p7022e97fd97c1a32c59f935d72f8dda94@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085111epcms2p7022e97fd97c1a32c59f935d72f8dda94@epcms2p7>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#if defined(CONFIG_BLK_DEV_INTEGRITY)

The normal style is to use #ifdef.

> +	if (bio_integrity(bio))
> +		rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
> +#endif
> >

Don't we need to walk the iter here, as it might already have been
advanced?  Although it seems nothing in the integrity code follows
that model right now, so I'm not quite sure how it's even working with
clones at the moment.
