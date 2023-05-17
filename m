Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96F70623A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjEQIIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:08:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF310D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mctQMwQ1c+oB4gTe4gyG4JXC6wODbSHM0afcemBmK5E=; b=MiwoWHnukWLEc8HHBAQxr0V8gf
        heQzrC+fYM732ZPWIGHsBBhOAVy7EANqo+XUQlqKsLq+8XPSvRXU9rfE4M3eaDKYZeA5FgSYRMwZX
        lTHufQAa+Vf5hPr8800DznETF9mp/aOnIUHBQ6wn/8/A6iFiqxNst1VUYH1rmWDT2E5SMn4yQba6L
        txoPhqt9J50W/b/Oc4I4oGKU8wMHw6GyEWssUVDIU5H6buv/1n6SwwxzBUG7YVCr/MpQ4qtcoHkaH
        m4c2OzhwHT8NgX+yYXN4xnEMWtLz2drxB3cS9TEgqbuaY6FwuvO0YruAYlA3b5xrBJWKfJCsiI3gX
        EWKCzfJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzCDC-008nJF-2n;
        Wed, 17 May 2023 08:08:42 +0000
Date:   Wed, 17 May 2023 01:08:42 -0700
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
Message-ID: <ZGSLiiK/JzD5KMd7@infradead.org>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
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

On Wed, May 17, 2023 at 01:22:51PM +0530, Sumit Garg wrote:
> > > +#if IS_ENABLED(CONFIG_CMA)
> > > +     page_flag |= FOLL_LONGTERM;
> > > +#endif
> > >       if (flags & TEE_SHM_USER_MAPPED)
> >
> > If this mapping is long live it should always use FOLL_LONGTERM.
> 
> It depends on the userspace application needs. However, I think it
> should be safe to use FOLL_LONGTERM by default to serve cases like
> secure media playback.

long term is defined as won't automatically go away during the same
syscall.
