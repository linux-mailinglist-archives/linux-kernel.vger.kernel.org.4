Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215107188FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEaSCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6A129
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685556079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGjsT8NGr6NLH3bPSVx6y2orm6yJThklHunLB8j4RRA=;
        b=A6mS8ed8TRTzat4Zk9CzvFXr4IbaVCvyaPCeXUghCyog8Sbdy6VHsJHVuXkX5ETEDS3YZ2
        Wkgsb+ogdmxg5wyQoUEeVovFfzVETZVX4tw/1lqQF0kMS2eOe3Xd/25ZItijI6R9v1ognJ
        51un5iGw1OEa9OeZVBmIAatv1etfxck=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-9iETfq-bNr2iMFFzxZdwtg-1; Wed, 31 May 2023 14:01:16 -0400
X-MC-Unique: 9iETfq-bNr2iMFFzxZdwtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37FCC384CC47;
        Wed, 31 May 2023 18:01:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 628BB2166B25;
        Wed, 31 May 2023 18:01:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZHd9vCcBNtjkqeqg@corigine.com>
References: <ZHd9vCcBNtjkqeqg@corigine.com> <20230531124528.699123-1-dhowells@redhat.com> <20230531124528.699123-3-dhowells@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <724854.1685556072.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 31 May 2023 19:01:12 +0100
Message-ID: <724855.1685556072@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Horman <simon.horman@corigine.com> wrote:

> > sendpage is removed as a whole slew of pages will be passed in in one =
go by
> =

> on the off-chance that you need to respin for some other reason:
> =

> 	s/in in/in/

What I wrote is correct - there should be two ins.  I could write it as:

	... passed in [as an argument] in one go...

For your amusement, consider:

	All the faith he had had had had no effect on the outcome of his life.

	https://ell.stackexchange.com/questions/285066/explanation-for-had-had-ha=
d-had-being-grammatically-correct

David

