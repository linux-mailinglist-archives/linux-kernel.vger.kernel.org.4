Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B90711A55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjEYWxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEYWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A0D9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685055141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eH/m3nuC2rUICmXjI3vrVBe5xrzk336eMJPenhN/WVU=;
        b=XdNigM93u+M5OSH8VvE70R4SQjORNon/O1PGiVBWe9RVYukOjIJ4i2GvJuJVeOLZ4KNgON
        KlNER8qwU1wpOQVWZpePoZ67qaUZjvyfyrneHq5aeueO9kmdWjts6HuzPvfvOfQCJEzIB6
        LB+EeWCMchOcx3qtHY+vX0053BR4X0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-r5E-x5qvMTKelVVvgs9yLQ-1; Thu, 25 May 2023 18:52:16 -0400
X-MC-Unique: r5E-x5qvMTKelVVvgs9yLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74741803497;
        Thu, 25 May 2023 22:52:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42757AF5;
        Thu, 25 May 2023 22:52:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOWid-c2_atz6oQspoQq4MQQ=DQWfJ=-JgbV2QFY8PveC+Sb8Q@mail.gmail.com>
References: <CAOWid-c2_atz6oQspoQq4MQQ=DQWfJ=-JgbV2QFY8PveC+Sb8Q@mail.gmail.com> <20230525211346.718562-1-Kenny.Ho@amd.com> <223250.1685052554@warthog.procyon.org.uk>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     dhowells@redhat.com, Kenny Ho <Kenny.Ho@amd.com>,
        David Laight <David.Laight@aculab.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alexander.deucher@amd.com
Subject: Re: [PATCH] Truncate UTS_RELEASE for rxrpc version
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <225784.1685055132.1@warthog.procyon.org.uk>
Date:   Thu, 25 May 2023 23:52:12 +0100
Message-ID: <225785.1685055132@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Ho <y2kenny@gmail.com> wrote:

> This makes sense and looks fine to me.  I don't know the proper
> etiquette here, but
> Acked-by: Kenny Ho <Kenny.Ho@amd.com>

If I'm not going to pick the patch up, I tend to use Acked-by when reviewing a
patch that touches code I'm a listed maintainer for and Reviewed-by when it's
code that I'm not a maintainer for...  but the descriptions in:

	Documentation/process/submitting-patches.rst

seem to leave a lot of overlap.

David

