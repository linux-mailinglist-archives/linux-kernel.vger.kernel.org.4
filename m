Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7F689267
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBCIhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBCIhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A14B8B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675413376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SgfxfX+R40emIUXjC0IKRTnZn8Kx7fI1FhxMp6y+tk=;
        b=Q7JDJpdG/3r7bwguhrXrKooTJizuh0gUty06fGVe0B1xauRjdVoD+Y8YyU/5/MPvzK39hB
        IyGe/N+5onyi6iKrP3fSdes1PSh3Jhldn+9R32jqiEK8D2pb46KOpJyHvBeoUgCW3yRCPf
        u/48YT9Fw6ZJQ36iSAxq/eonqR1T72c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-UC8RY2tXMU2MA0Ie6u6v0g-1; Fri, 03 Feb 2023 03:36:12 -0500
X-MC-Unique: UC8RY2tXMU2MA0Ie6u6v0g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B68D101A55E;
        Fri,  3 Feb 2023 08:36:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C25A492C14;
        Fri,  3 Feb 2023 08:36:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com>
References: <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com> <e8065d6a-d2f9-60aa-8541-8dfc8e9b608f@redhat.com> <000000000000b0b3c005f3a09383@google.com> <822863.1675327935@warthog.procyon.org.uk> <1265629.1675350909@warthog.procyon.org.uk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>,
        hch@lst.de, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in skb_dequeue (3)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1723029.1675413370.1@warthog.procyon.org.uk>
Date:   Fri, 03 Feb 2023 08:36:10 +0000
Message-ID: <1723030.1675413370@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interestingly, the problem also goes away if the ftruncate is removed from the
test program.

Are pages ever spliced from the pipe directly into the pagecache on both xfs
and ext4?  I'm not sure whether that could happen as the test seeks 2048 bytes
in before doing the sendfile().

David

