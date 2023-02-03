Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8196A689F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjBCQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjBCQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE11A702A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675441636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3uWwQqtA43whPYnPC+y1fwI+WtDukGxVuPx0qQHTyY=;
        b=Q/wGuPoF2AcehW3Q44AjKvsm/RPwcsMOGkeNGE2Z3JaeYHlHPzX50I8a9J7rvgQXEl7p3y
        IkZOggXLJ4671PkLANkYMDApzDoQYhMf5uAbS3y9+zgWqAW4DJTfKqXyd0NZ3uy9blPvH8
        TFupl1unUKIvQ+1onJqG2skvkB0WZio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-kNXTwb1SNRmOF34ahkZ4Jg-1; Fri, 03 Feb 2023 11:27:12 -0500
X-MC-Unique: kNXTwb1SNRmOF34ahkZ4Jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485D885A5B1;
        Fri,  3 Feb 2023 16:27:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69DE62166B34;
        Fri,  3 Feb 2023 16:27:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2112099.1675441439@warthog.procyon.org.uk>
References: <2112099.1675441439@warthog.procyon.org.uk> <2076817.1675434996@warthog.procyon.org.uk> <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com> <e8065d6a-d2f9-60aa-8541-8dfc8e9b608f@redhat.com> <000000000000b0b3c005f3a09383@google.com> <822863.1675327935@warthog.procyon.org.uk> <1265629.1675350909@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: How does ftruncate() interact with DIO read?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2116613.1675441630.1@warthog.procyon.org.uk>
Date:   Fri, 03 Feb 2023 16:27:10 +0000
Message-ID: <2116614.1675441630@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

What does ftruncate() do if there's a conflicting DIO read happening on the
same file?  Does it cancel the bio?

David

