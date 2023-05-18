Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACBA7078E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjEREVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEREVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:21:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B035AD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XIkCd52W+zN1SoFPBBm4oRim+UuYVpQOjJ1oTywL0QA=; b=jeegl84LJTWlBvMYHO6PjMdDOZ
        bHFnD2cjDSkO9WsX8M0mJPhrPc5QnpgcLPvvcqFDTU2v5dx7rIVO4y1ptyGkIrXJL9vKSWz3FrFAe
        jWlyQJGTJTJJCU2eSZ57ncHshcFo62zj6HBUHeJ6cYTTyr2wKaYItDCsTo1Qv6df1wZu56SNewTU8
        XrW7oDDOM3PRMh9I3LGqIU49LiEBcvIbuBG44FDLmyun/cKcamm4sJBrvScr+zmVUMshR2+f5zRzu
        98hmyKVBf+Nk6YnDTfPJPMLS4UZYf1+IHxvdTKQVkm9Ny3D+zy+gdMAdjAO7j/obg3S73305dWtFo
        mKCcUBjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzV8N-00Bq7k-20;
        Thu, 18 May 2023 04:20:59 +0000
Date:   Wed, 17 May 2023 21:20:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Subject: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add FOLL_LONGTERM
 for CMA case when alloc shm
Message-ID: <ZGWnq/dAYELyKpTy@infradead.org>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
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

On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
> In general: if user space controls it -> possibly forever -> long-term. Even
> if in most cases it's a short delay: there is no trusting on user space.
> 
> For example, iouring fixed buffers keep pages pinned until user space
> decides to unregistered the buffers -> long-term.
> 
> Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
> unpin in essentially one operation.

Btw, one thing that's been on my mind is that I think we got the
polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
behavior it really should be the default, with a FOLL_EPHEMERAL flag
to opt out of it.  And every users of this flag is required to have
a comment explaining the life time rules for the pin..
