Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27FF6C2591
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCTXVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCTXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25039E1AF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679354448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edAWeKA9AVpZQXK8a2sLtS/AGFpK5i6GnqmCo9prCkc=;
        b=ZzdbkeG8lQAe9+QhPBruMEvwXGNLeY6AlJ0BCBPII46FmboN6t/wxdak523PodFYFStLRT
        hpS4C/98cxhDw6Y2Y9JK/DCtYxsnFkMnd7PJm2mTQR7Hb/aNdfQQocmcyK9XcF9kufDU5L
        zRpGcupbIzD8xNP4g16+ktRt2Dmitrc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-0eW1T0y1PDKhrro_-ByLag-1; Mon, 20 Mar 2023 19:20:45 -0400
X-MC-Unique: 0eW1T0y1PDKhrro_-ByLag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FE5E3C02B65;
        Mon, 20 Mar 2023 23:20:44 +0000 (UTC)
Received: from ovpn-8-29.pek2.redhat.com (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8166440B934;
        Mon, 20 Mar 2023 23:20:38 +0000 (UTC)
Date:   Tue, 21 Mar 2023 07:20:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v2 2/5] block nbd: send handle in network order
Message-ID: <ZBjqQckL7d5EJPlh@ovpn-8-29.pek2.redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
 <20230317202749.419094-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317202749.419094-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 03:27:46PM -0500, Eric Blake wrote:
> The NBD spec says the client handle (or cookie) is opaque on the
> server, and therefore it really doesn't matter what endianness we use;
> to date, the use of memcpy() between u64 and a char[8] has exposed
> native endianness when treating the handle as a 64-bit number.

No, memcpy() works fine for char[8], which doesn't break endianness.

> However, since NBD protocol documents that everything else is in
> network order, and tools like Wireshark will dump even the contents of
> the handle as seen over the network, it's worth using a consistent
> ordering regardless of the native endianness.
> 
> Plus, using a consistent endianness now allows an upcoming patch to
> simplify this to directly use integer assignment instead of memcpy().

It isn't necessary, given ->handle is actually u64, which is handled by
nbd client only.

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: new patch
> ---
>  drivers/block/nbd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 592cfa8b765a..8a9487e79f1c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -560,6 +560,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  	unsigned long size = blk_rq_bytes(req);
>  	struct bio *bio;
>  	u64 handle;
> +	__be64 tmp;
>  	u32 type;
>  	u32 nbd_cmd_flags = 0;
>  	int sent = nsock->sent, skip = 0;
> @@ -606,7 +607,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  		request.len = htonl(size);
>  	}
>  	handle = nbd_cmd_handle(cmd);
> -	memcpy(request.handle, &handle, sizeof(handle));
> +	tmp = cpu_to_be64(handle);
> +	memcpy(request.handle, &tmp, sizeof(tmp));

This way copies handle two times, really not fun.


thanks,
Ming

