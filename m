Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4362EE0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiKRHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiKRHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31771B9DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668754863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1UVBsOVPw67xRYnFBpe4rf5zDWclcTyExIeSFPDtWs=;
        b=Ep0qy/Kt/0MJ6a5//SfY7x9l9/3pxoNdYpbZN5AreA1jFvDyIiStBlSeTxWLI8/1upcDFY
        qvqo/vWIw1u6RD73ZXb+peegNMPlMuvb9nXMjzxjkS8xffQZrBXckqvKWRYW+tDlPWCydn
        q49eNE9YE3+4ChKNL0TA9GXzQup/xKc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-k_snK5VINPap4V1eT5omIw-1; Fri, 18 Nov 2022 02:00:57 -0500
X-MC-Unique: k_snK5VINPap4V1eT5omIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEB923C0CD55;
        Fri, 18 Nov 2022 07:00:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC7D2027062;
        Fri, 18 Nov 2022 07:00:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <54854a71-5856-f80f-d8cb-ab75b826ba5f@huawei.com>
References: <54854a71-5856-f80f-d8cb-ab75b826ba5f@huawei.com> <166869954095.3793579.8500020902371015443.stgit@warthog.procyon.org.uk>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     dhowells@redhat.com, asmadeus@codewreck.org,
        syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com,
        Jeff Layton <jlayton@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        ericvh@gmail.com, lucho@ionkov.net, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: fix OOB Read in __fscache_acquire_volume
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4193089.1668754852.1@warthog.procyon.org.uk>
Date:   Fri, 18 Nov 2022 07:00:52 +0000
Message-ID: <4193090.1668754852@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhangpeng (AS) <zhangpeng362@huawei.com> wrote:

> Thanks for your advice. The size needs to be able to hold up to 255 to
> handle larger keys. After testing, this patch works fine.

Can I put you down as a Reviewed-by or Tested-by?

Thanks,
David

