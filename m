Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72482702BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjEOLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbjEOLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:49:22 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C04740F6;
        Mon, 15 May 2023 04:38:48 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id CE35715E2ED;
        Mon, 15 May 2023 13:38:22 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1684150703; bh=7eot/urJwPqecmJHn4WdqB1OxDqxye+YdJap2ozMB3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=4TK/HXFYdkxVY2zDjVJTHLWuVlPoXsU5Pe1OmQFgENK1eT/3M7nupdzS3bXo+gu9e
         k/2p9styYG1GeusiRD/YQKIc0PMzUxlXoo/UozbvgRKaVFgydXABGVaWXS/8C74ETe
         sBdmKZLt/rv+lSw7kKu3NSbhRp2Y8l2B6ooy85hhi6b1yiyistFiMVO6c5vbq5lU0l
         V03Qhlkk6KZIgVGbxwAcRYta8I3gy5MF8krbVGeA1VJa6SC3awdsKlAA+gNN+FeV6o
         HiPWwdcpEw/OJEGnl8yJqs1eM+U35F1KsJVmJbxlrzq3ZOCn35lgf4CwK8ONH5qbaZ
         mQIxvx5o8wbHA==
Date:   Mon, 15 May 2023 13:38:21 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Yajun Deng" <yajun.deng@linux.dev>
Cc:     "Christoph Hellwig" <hch@lst.de>, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org, bp@suse.de,
        akpm@linux-foundation.org, peterz@infradead.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        thunder.leizhen@huawei.com, ardb@kernel.org, bhe@redhat.com,
        anshuman.khandual@arm.com, song.bao.hua@hisilicon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Message-ID: <20230515133821.769158bb@meshulam.tesarici.cz>
In-Reply-To: <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
References: <20230515094955.GB23880@lst.de>
        <20230512094210.141540-1-yajun.deng@linux.dev>
        <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 11:23:27 +0000
"Yajun Deng" <yajun.deng@linux.dev> wrote:

> May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
> 
> > This looks fine to me. Can you please work with Barry to make sure
> > the slight different place of the initcall doesn't break anything
> > for his setup? I doubt it would, but I'd rather have a Tested-by:
> > tag.  
> 
> Barry's email is no longer in use. I can't reach him.

Which one? I would hope that his Gmail account is still valid:

  Barry Song <21cnbao@gmail.com>

Petr T
