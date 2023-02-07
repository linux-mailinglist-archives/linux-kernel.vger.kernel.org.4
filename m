Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E23E68D4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjBGKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBGKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC82739
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675766692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cReNp7hDj843BCfXnq5z9fX/qXUWLWCg2gp8gMVVH90=;
        b=L11WXZCcIpZQhHccCB7Ksv5pOuZIKko0EVXHFmlsAgqYc2VukdEUShKQzHejFUAmOojRoD
        4yBamIW4zQtIbPq2AjG7vDWpgcnz6zHpvgYvXIJuX5x7yGnKaG5/SQSgrTHUGYdgEYklXT
        cE+pwU2hGTdDlUsRxASP8xgl2jQSC8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-iHOssuylNCGAnJ8sr6nDAw-1; Tue, 07 Feb 2023 05:44:51 -0500
X-MC-Unique: iHOssuylNCGAnJ8sr6nDAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E73C6800050;
        Tue,  7 Feb 2023 10:44:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 969A240398A0;
        Tue,  7 Feb 2023 10:44:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230207094731.1390-1-hdanton@sina.com>
References: <20230207094731.1390-1-hdanton@sina.com> 
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Need help tracking down a bug in the bio-FOLL_PIN patches
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3024112.1675766689.1@warthog.procyon.org.uk>
Date:   Tue, 07 Feb 2023 10:44:49 +0000
Message-ID: <3024113.1675766689@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> 	pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
> 	iov_iter_revert.part.0+0x402/0x730 lib/iov_iter.c:935
> 	iov_iter_revert+0x4c/0x60 lib/iov_iter.c:919

Yeah.  That seems to be the problem.

Thanks,
David

