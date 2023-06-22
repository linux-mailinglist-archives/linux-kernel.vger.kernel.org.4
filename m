Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8273A218
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFVNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFVNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785C1721
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687441378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NU8Lw02JeDg73saYrOOM6gfGtZyrD9LEgpI4/sQumxo=;
        b=C2MhNVEjIXeRYa5mtY4YGzZn5ObPS79GiXo2tC0qUXM0KLZQYnOOizSsODqLO9B8RbX4BU
        N+MbWM8bhoKjnb7l86lBiT8cQpDDjetkzeH2yhQQqaDqHu8NvGWQLRnyAeh7YA/pdGQ2Ze
        LX0qNDfi2YiWx5ZpIu8uCncA4dEObgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-SdsMgxbtPYSILWXZuc7tSQ-1; Thu, 22 Jun 2023 09:42:56 -0400
X-MC-Unique: SdsMgxbtPYSILWXZuc7tSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC798AB385;
        Thu, 22 Jun 2023 13:42:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D804C478C7;
        Thu, 22 Jun 2023 13:42:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230615160806.94000-1-marcel@holtmann.org>
References: <20230615160806.94000-1-marcel@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] cachefiles: allocate static minor for /dev/cachefiles
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1886145.1687441374.1@warthog.procyon.org.uk>
Date:   Thu, 22 Jun 2023 14:42:54 +0100
Message-ID: <1886146.1687441374@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote:

> The cachefiles misc character device uses MISC_DYNAMIC_MINOR and thus
> doesn't support module auto-loading. Assign a static minor number for it
> and provide appropriate module aliases for it. This is enough for kmod to
> create the /dev/cachefiles device node on startup and facility module
> auto-loading.

Why?  The systemd unit file for it just modprobe's the module first.  It's a
specialist device file only for use by the appropriate daemon.

David

