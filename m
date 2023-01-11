Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2E066606E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjAKQ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjAKQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424AF1DF0D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673454304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxBHdaiEAq2LsScflLkdFvYTtC4L7dZmM1H1mv+PG5k=;
        b=e1JDZ0zvEiYtJxd2PNBpRoRX36SRgcMaaqPaNLqj1MoyTf8S8BKeIZ9rijqtDQVC2ixkA7
        /cZ9sWFwdgXl7iEY+hGHwYjqR3ZmH8EtGGkKHaT84YOLfTw5BZU9NqTNdfF8M+z+CNQHLk
        EDItKr2obskEdoW22cZg5bcWQQ0fxU8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-86uM21hhPZONYQ_5UmZHIw-1; Wed, 11 Jan 2023 11:25:03 -0500
X-MC-Unique: 86uM21hhPZONYQ_5UmZHIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E8373C0F22C;
        Wed, 11 Jan 2023 16:25:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 626DE40C1060;
        Wed, 11 Jan 2023 16:25:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2431994.1673453386@warthog.procyon.org.uk>
References: <2431994.1673453386@warthog.procyon.org.uk> <20221226103309.953112-3-houtao@huaweicloud.com> <20221226103309.953112-1-houtao@huaweicloud.com>
Cc:     dhowells@redhat.com, Hou Tao <houtao@huaweicloud.com>,
        linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Subject: Re: [PATCH v2 2/2] fscache: Add the missing smp_mb__after_atomic() before wake_up_bit()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2432455.1673454299.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 16:24:59 +0000
Message-ID: <2432456.1673454299@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> What two values are you ordering?
> 
> If we're using this to create a critical section, then yes, we would need a
> barrier to order the changes inside the critical section before changing the
> memory location that forms the lock - but this is not a critical section.

Actually, that said, the ordering is probably between the bit being cleared
and the task state.

David

