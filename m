Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35A9742F77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjF2VYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF2VX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD91BD1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688073788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEvn4mNBJjxGCfxtSjAM8jMyMTbXVbbppuQzIKpSf88=;
        b=OvsZHuVyMg77vlKJnRqka/XCO3fzzLctDqp0nRzcy7wTz/6ePPYmAJKcKy0YOVWXR6Guj2
        kPtkBsVzEZuTsfV+WRx0/xBLbEiR2VLxvjiKWW7J3JgZAm9nsIrZcO+Ej8/hpJ5FFjsebb
        B7NO5E6iF606AohxpzqoPmlCzknou8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-Mn4whvRiN6qoD5RPWRCUAg-1; Thu, 29 Jun 2023 17:23:05 -0400
X-MC-Unique: Mn4whvRiN6qoD5RPWRCUAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDE381DB6C;
        Thu, 29 Jun 2023 21:23:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ED20200B402;
        Thu, 29 Jun 2023 21:23:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
References: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com> <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     dhowells@redhat.com, Aurelien Aptel <aaptel@nvidia.com>,
        netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55022.1688073781.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 29 Jun 2023 22:23:01 +0100
Message-ID: <55023.1688073781@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> wrote:

> simple way to check is to run:
> nvme_trtype=3Dtcp ./check nvme

It says a lot of:

nvme/002 (create many subsystems and test discovery)         [not run]
    nvme is not available
    nvme_trtype=3Dtcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [no=
t run]
    nvme is not available
nvme/004 (test nvme and nvmet UUID NS descriptors)           [not run]
    nvme is not available
nvme/005 (reset local loopback target)                       [not run]
    nvme is not available
...

I have the following NVMe config:

# NVME Support
CONFIG_NVME_COMMON=3Dy
CONFIG_NVME_CORE=3Dy
CONFIG_BLK_DEV_NVME=3Dy
CONFIG_NVME_MULTIPATH=3Dy
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=3Dy
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TCP=3Dy
CONFIG_NVME_AUTH=3Dy
CONFIG_NVME_TARGET=3Dy
CONFIG_NVME_TARGET_PASSTHRU=3Dy
CONFIG_NVME_TARGET_LOOP=3Dy
# CONFIG_NVME_TARGET_RDMA is not set
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_TCP=3Dy
CONFIG_NVME_TARGET_AUTH=3Dy
# end of NVME Support
CONFIG_RTC_NVMEM=3Dy
CONFIG_NVMEM=3Dy
# CONFIG_NVMEM_SYSFS is not set
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# CONFIG_NVMEM_RMEM is not set

Can you tell me what I'm missing?

David

