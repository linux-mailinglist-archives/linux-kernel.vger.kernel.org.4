Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A5D730F08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbjFOGFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbjFOGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:04:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5F295B;
        Wed, 14 Jun 2023 23:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hRjaMQchwaDw51gYY0A6pzxnY9mg2ZrdZZNaLj4dZeA=; b=2hlMq+ya9mZtwNO3r77yfR79wx
        jteAUkH60G2v+Yo4PufzKQT8JLVtKTUoRCQO1Pv3W3rJro3RDat/Gqx84gGOdEO1xgpa+c8tz6SF/
        oiLLUuc0aE4g9+haEXR6sNQObtZTm56QUaTd3whFwOYuPNEpMe1d98L9iQEEWGptFPFKtb+3LbVCF
        hZUZrP7OpDQRiryZRmVJCKy/rGCwv73AISmQHKFv98u66P13D3PksbofOHp/Lj1+x//HllJDN0Pje
        DPlnLFq/lFc7t3/gbMVBFZaQxUCvWS8EGwoZEBX4rAONc7d5ffPgH6iu5nYoPoV6DOxnIqrPh51S0
        pA/4zdpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9g5C-00DnhB-0u;
        Thu, 15 Jun 2023 06:03:46 +0000
Date:   Wed, 14 Jun 2023 23:03:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ayush Jain <ayush.jain3@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "V, Narasimhan" <Narasimhan.V@amd.com>,
        "Shetty, Kalpana" <Kalpana.Shetty@amd.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>
Subject: Re: Kernel null pointer dereference on stopping raid device
Message-ID: <ZIqpwhu4Tfa9MDzM@infradead.org>
References: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
 <3c4911c4-d3d7-a93e-5f14-e97384ae4f21@amd.com>
 <ZIlqvsZ6nMv2OT2u@infradead.org>
 <IA1PR12MB61375A452083D65B5FB815DBBA5AA@IA1PR12MB6137.namprd12.prod.outlook.com>
 <ZInIMLlMby2aNNr1@infradead.org>
 <fc7b82a6-a74a-7675-7cfd-4dd9ac10543b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7b82a6-a74a-7675-7cfd-4dd9ac10543b@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:14:02AM +0530, Ayush Jain wrote:
> > That was just a quick hack to verify the problem.  I think this is
> > the proper fix, can you try it as well?
> > 
> 
> Sure, this works on my machine.
> 
> Tested-by: Ayush Jain <ayush.jain3@amd.com>

So it turns out that Jens merged the md pull request for 6.5 yesterday,
and that includes and equivalent change in

3ce94ce5d05ae89190a23f6187f64d8f4b2d3782
Author: Yu Kuai <yukuai3@huawei.com>
Date:   Tue May 23 09:27:27 2023 +0800

    md: fix duplicate filename for rdev

With that I think we don't need an extra fix.  Sorry for all the
extra work.
