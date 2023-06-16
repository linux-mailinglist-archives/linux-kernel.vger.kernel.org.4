Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704D7334C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjFPP32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjFPP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7FB270B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686929322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maoLH1+iFdOHtUfb3uVlDmFpd4ojetev/CDoWNYqeqE=;
        b=cgNzMa7QiOpf+pFf4w28NVWxhDF7oTvZBjXdRekbIVbI9MQC2BiGnTyhdgS8QwsGrPeryh
        gkDO4JEOzPzsGmlDffQLrN+VdBPIvdFa6GH7T1qt5/0zt/HwQ/IFtYqt83l360a+HuI+Rd
        pEkeg6OY5a43X9xNtwy1UELsvVSaBpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-VwVwMy6RNq2uvUCKs61D4w-1; Fri, 16 Jun 2023 11:28:36 -0400
X-MC-Unique: VwVwMy6RNq2uvUCKs61D4w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4AFF85A58A;
        Fri, 16 Jun 2023 15:28:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C62E748FB01;
        Fri, 16 Jun 2023 15:28:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com>
References: <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com> <20230524153311.3625329-1-dhowells@redhat.com> <20230524153311.3625329-4-dhowells@redhat.com>
To:     Alexander H Duyck <alexander.duyck@gmail.com>
Cc:     dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator alignment param a pow-of-2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <617058.1686929309.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 16:28:29 +0100
Message-ID: <617059.1686929309@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander H Duyck <alexander.duyck@gmail.com> wrote:

> The requirement should only be cache alignment, not power of 2
> alignment.

Sure, but, upstream, page_frag_alloc_align() allows the specification of an
alignment and applies that alignment by:

	offset &= align_mask;

which doesn't really make sense unless the alignment boils down to being a
power of two.  Now, it might make sense to kill off the align_mask parameter
and just go with SMP_CACHE_BYTES (which will be a power of two).

Note, though, that most users seem to use an align_mask of ~0u which feels a
bit dodgy (it's not an unsigned long), but is probably fine.

David

