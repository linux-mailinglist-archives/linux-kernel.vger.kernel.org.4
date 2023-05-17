Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7070643F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEQJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEQJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:36:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B86210C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gtYEL+cNF7JBOxTUOl920ZwaVms6oMpqn+5use50Dtc=; b=zTihcchDPUHLMoURHpwYR6cQZM
        stP81hCQFi1oM6TlF5VeYFxwswzfvO73CQXC+d0HK4KBesR0iicRSupkwNvKr2oAjUoX0v93RoKQY
        NFD++5fvKU9r6s/tGhD0GdE4IP/r2EhdGaxKMWIila8PRiF0TQzsn38p67AUPig4SgItiNrX8xjnS
        NKjtEziY2Rth+74sQNv8i5JUzpa6sTLxJ8+DSTARpanLoH08XAXRxr6bV5CL1cMwuriptuEeijwuQ
        wUN9r1fPuic8B9pLBmkXUYhGWzKwHWQ1HNLCXQ7wI3w4AsPE2OR4piTLjOyU1udqLVeCm6e4+rchU
        ViVrwtNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzDZp-0095AA-1E;
        Wed, 17 May 2023 09:36:09 +0000
Date:   Wed, 17 May 2023 02:36:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Message-ID: <ZGSgCZrg+RjAbGO1@infradead.org>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:56:13PM +0530, Sumit Garg wrote:
> Do you mean a pinned user-space page can be paged out automatically?

No, pinned pages can't be paged out.

But a short term pin implies it will be release after a short delay,
and it is feasible for wait for the pin to go away.

For a long term pin waiting is not an option, and anyone wanting to
do something with the pinned page that requires it to not be pinned
must simply give up.

> Just FYI, the underlying use-case for TEE registered shared memory is
> that the references to pinned pages are provided to TEE implementation
> to operate upon. This can happen over multiple syscalls and we want
> the pinned pages to be always in RAM as otherwise the physical
> addresses may change if they are paged out in between.

That's a very use clear case for a long term pin.
