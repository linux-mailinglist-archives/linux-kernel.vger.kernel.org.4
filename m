Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5F7107C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbjEYImw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbjEYImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6219E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685004114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eepdONxiiPS36uH7O93679zgdljhzRqM0IfU/ldEx9w=;
        b=TI5UKiKbERN+n9G35uDggTi8jT6XESxsmhHshmUn5fzmu4gQaoJXO7GEZ+iVhVGcxO0Qbs
        1x8n6ie20Cop31cPtk7C5IMlKrSCJ4/RD3kVxX3Hy0N98AAnDD+Bxun97DYafxoXooAGmc
        MQgqF2ZNBxoDfH8Hj8KJECrX4eb/+l4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-TdyODQMCMUKphEJCRRPqhw-1; Thu, 25 May 2023 04:41:49 -0400
X-MC-Unique: TdyODQMCMUKphEJCRRPqhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 022DD2A5957C;
        Thu, 25 May 2023 08:41:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20E68200B401;
        Thu, 25 May 2023 08:41:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZG8TXgs+36O9AS93@corigine.com>
References: <ZG8TXgs+36O9AS93@corigine.com> <20230524144923.3623536-1-dhowells@redhat.com> <20230524144923.3623536-3-dhowells@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>
Subject: Re: [PATCH net-next 2/4] chelsio: Convert chtls_sendpage() to use MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3788698.1685004106.1@warthog.procyon.org.uk>
Date:   Thu, 25 May 2023 09:41:46 +0100
Message-ID: <3788699.1685004106@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Horman <simon.horman@corigine.com> wrote:

> a minor nit, in case you need to repost this series for some other reason.

Note that the aim is to delete chtls_sendpage() entirely at some point soon.

David

