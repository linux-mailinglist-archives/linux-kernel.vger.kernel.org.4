Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CC742F91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjF2Vfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjF2Vfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EA2D69
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688074506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vets7tG3ILEPoqG+7zzfJad8OpPNQJ5xWznjwspAC48=;
        b=dpRkFnan2rNlEDW+Dr0WfPX73XpM4F+nsLc3hn7i4QmSEt3LFuO41t8aVoBiTMqQfmQ4q9
        1Ivf2wwZbKGHSeS1uE5lpMUc56sLZaBi8UEeo5MAGS5uxQREsF9enF8S4HZKochjpG3FdW
        e46KdJJydHiuPV2i0b/x8K8nA4OziUE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-ygJyXz5vODysshN6s4CjSA-1; Thu, 29 Jun 2023 17:35:03 -0400
X-MC-Unique: ygJyXz5vODysshN6s4CjSA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 692412A5954E;
        Thu, 29 Jun 2023 21:35:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55AB0492C13;
        Thu, 29 Jun 2023 21:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com>
To:     Aurelien Aptel <aaptel@nvidia.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58465.1688074499.1@warthog.procyon.org.uk>
Date:   Thu, 29 Jun 2023 22:34:59 +0100
Message-ID: <58466.1688074499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meh:

                if (!sendpage_ok(page))
-                       msg.msg_flags &= ~MSG_SPLICE_PAGES,
+                       msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
                bvec_set_page(&bvec, page, len, offset);

David

