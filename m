Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1632E70098A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbjELNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbjELNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:54:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3FE4A;
        Fri, 12 May 2023 06:54:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D450668AA6; Fri, 12 May 2023 15:54:10 +0200 (CEST)
Date:   Fri, 12 May 2023 15:54:10 +0200
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
Subject: Re: [PATCH v2 12/14] block: add helper function for iteration of
 bip's bvec
Message-ID: <20230512135410.GF32242@lst.de>
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1> <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p8> <20230510085941epcms2p8ad574939bc3edbd65b8f208c80a85911@epcms2p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085941epcms2p8ad574939bc3edbd65b8f208c80a85911@epcms2p8>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:59:41PM +0900, Jinyoung CHOI wrote:
> bip_for_each_vec() performs the iteration in a page unit.
> 
> Since a bio_vec of bip is composed of multi-page in the block, a macro
> that can be carried out in multi-page units has been added.

The naming here is a bit confused.  The rest of the block layers uses
_segment for the per-page iterators and _vec for the one that doesn't
break up.  I'd suggest we follow this naming scheme here.  And also
skip the extra for_each_mp_bvec level, just like we don't have that
intermediate level for bio_for_each_vec
