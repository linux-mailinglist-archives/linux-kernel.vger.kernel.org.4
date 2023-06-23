Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7F73B3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjFWJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFWJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C36E75
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687513378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bhDod7bOodPKlDwEZ8o/bZlFM66QHRdXKlWqLMP49I=;
        b=By+4ciOMFG1qJFaJJrd2pt+BjUGKNMnKc2yt1ReaSKKZdz0zpMa+opSM30hgQjNflSzgAu
        mzu1n0BmPguRc5NNTb45lOWJolfyv5XgO3ejjdD5281G2U/oImBdHkcoB5jqgZeqJNg9Q8
        kzlDPe//dPAqHj1W8rofPIzoFo89u5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460--V30Opo5M3KFg4FLRsjnPw-1; Fri, 23 Jun 2023 05:42:51 -0400
X-MC-Unique: -V30Opo5M3KFg4FLRsjnPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5D5C858F1E;
        Fri, 23 Jun 2023 09:42:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F98341EF82;
        Fri, 23 Jun 2023 09:42:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2ee000f803bd1a099aa8fb02ef79c7b25e5f5b08.camel@redhat.com>
References: <2ee000f803bd1a099aa8fb02ef79c7b25e5f5b08.camel@redhat.com> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-3-dhowells@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 02/18] net: Display info about MSG_SPLICE_PAGES memory handling in proc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2046312.1687513368.1@warthog.procyon.org.uk>
Date:   Fri, 23 Jun 2023 10:42:48 +0100
Message-ID: <2046314.1687513368@warthog.procyon.org.uk>
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

Paolo Abeni <pabeni@redhat.com> wrote:

> Have you considered percpu counters instead of the above atomics?

Makes sense, since I've got per-cpu structs anyway.

David

