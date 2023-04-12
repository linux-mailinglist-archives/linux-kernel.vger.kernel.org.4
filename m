Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3696DEC26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDLG5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:57:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC775260
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:57:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D18CC68AA6; Wed, 12 Apr 2023 08:57:36 +0200 (CEST)
Date:   Wed, 12 Apr 2023 08:57:36 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        martin.petersen@oracle.com
Subject: Re: [PATCH 2/2] nvme-pci: fix metadata mapping length
Message-ID: <20230412065736.GB20550@lst.de>
References: <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8> <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:24:43PM +0900, Jinyoung CHOI wrote:
> Even if the memory allocated for integrity is physically continuous,
> struct bio_vec is composed separately for each page size.
> In order not to use the blk_rq_map_integrity_sg(), the length of the
> DMA mapping should be the total size of integrity payload.

Hmm, looking outside the bio_vec is pretty nasty.

I think the problem here is that bio_integrity_add_page should
just add to the existing bvec, similar to bio_add_page and friends.

