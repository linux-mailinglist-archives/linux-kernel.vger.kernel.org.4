Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6B73E51F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFZQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjFZQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1555183
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687797031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17WXujS/YadeWAnXnT2WRgIIGXFkn1Rmc4cmEtM2dPk=;
        b=i6xIPZfqogIk9InALTKjmB8yJLNFx3bFolbuImYIosMf4TgHOa7KurNSp0rfOfwgSIO+/m
        0Oy0UAXmKY1PgCmM+53RsGR526vtN/Nreo4LYmLeJUwPW7ZNvnLF+Y3O3L7C0RjiKEB3LY
        XfRbi5w6k+jtazgCsFCB3TqhicMkWCQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-mv9RbFfYPhOBo9xGeKFM7A-1; Mon, 26 Jun 2023 12:30:29 -0400
X-MC-Unique: mv9RbFfYPhOBo9xGeKFM7A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6355b301c9dso19977996d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797028; x=1690389028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17WXujS/YadeWAnXnT2WRgIIGXFkn1Rmc4cmEtM2dPk=;
        b=VoVt1CUBDIiRT84a22DhBOOXgDoIk0YKXX/DPIwcwTu7sTZ+WNsy5QdEBdRy31IO5L
         pc0u14heNXgYlgWjCYrDsMZTDoi67cI/zyOsy4nYTpWvsAVfravt5E2pggUe6GSMcTDD
         DX1+rYPXCdhH6TfijYFISRjUwMP80Xps/qeNcdTrjZe5t3WlvcpFu065VcSuBks3se1d
         Hba5K6GbBnemnglj9FydoEN6y2/NXzhxN9k0afmowQFU2Bid1g1ACQacOdIqlAL5LfE6
         QHTzE1NU08vyq5hSYFD74C5OiTtdkl/mpF0CMPGDuN5SuqmnO2ZRUmyyCtxVRpM6LK6C
         a28g==
X-Gm-Message-State: AC+VfDwp4t311qnhOijwBYXOC5K43A9GXJNjYuEjg9eoDVvqFZlJM6U2
        Vj+Qh/OVM4OC2JnqxNEKkVN1O/L2Ewg398qgT32R46Ayf0+3exyHtrbAT+ho+x60g9aSUtppTCt
        Yh7PenL4rKmxO0ic1lKmDf7kl
X-Received: by 2002:a05:6214:1cc5:b0:62d:e8a2:4d36 with SMTP id g5-20020a0562141cc500b0062de8a24d36mr34309510qvd.61.1687797028068;
        Mon, 26 Jun 2023 09:30:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uBH00Gk/fKeQLrvD/GY47XvG7v3BCuca4UyzNoimZCXIfrb0LXztvOgJ/KifRuXdADW4Jbg==
X-Received: by 2002:a05:6214:1cc5:b0:62d:e8a2:4d36 with SMTP id g5-20020a0562141cc500b0062de8a24d36mr34309488qvd.61.1687797027844;
        Mon, 26 Jun 2023 09:30:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id nd14-20020a056214420e00b006215d0bdf37sm3351810qvb.16.2023.06.26.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:30:27 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:30:23 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 0/4] virtio/vsock: some updates for MSG_PEEK flag
Message-ID: <tmcj34lrgk7rxlnp4qvkpljwovowlz3wnosqboxssv6f6enr6u@qnf422n6lu6j>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 09:24:47AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>This patchset does several things around MSG_PEEK flag support. In
>general words it reworks MSG_PEEK test and adds support for this flag
>in SOCK_SEQPACKET logic. Here is per-patch description:
>
>1) This is cosmetic change for SOCK_STREAM implementation of MSG_PEEK:
>   1) I think there is no need of "safe" mode walk here as there is no
>      "unlink" of skbs inside loop (it is MSG_PEEK mode - we don't change
>      queue).
>   2) Nested while loop is removed: in case of MSG_PEEK we just walk
>      over skbs and copy data from each one. I guess this nested loop
>      even didn't behave as loop - it always executed just for single
>      iteration.
>
>2) This adds MSG_PEEK support for SOCK_SEQPACKET. It could be implemented
>   be reworking MSG_PEEK callback for SOCK_STREAM to support SOCK_SEQPACKET
>   also, but I think it will be more simple and clear from potential
>   bugs to implemented it as separate function thus not mixing logics
>   for both types of socket. So I've added it as dedicated function.
>
>3) This is reworked MSG_PEEK test for SOCK_STREAM. Previous version just
>   sent single byte, then tried to read it with MSG_PEEK flag, then read
>   it in normal way. New version is more complex: now sender uses buffer
>   instead of single byte and this buffer is initialized with random
>   values. Receiver tests several things:
>   1) Read empty socket with MSG_PEEK flag.
>   2) Read part of buffer with MSG_PEEK flag.
>   3) Read whole buffer with MSG_PEEK flag, then checks that it is same
>      as buffer from 2) (limited by size of buffer from 2) of course).
>   4) Read whole buffer without any flags, then checks that is is same
>      as buffer from 3).
>
>4) This is MSG_PEEK test for SOCK_SEQPACKET. It works in the same way
>   as for SOCK_STREAM, except it also checks combination of MSG_TRUNC
>   and MSG_PEEK.
>
>Head is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d20dd0ea14072e8a90ff864b2c1603bd68920b4b

Nice cleanup, LGTM, but I'd like a comment from Bobby.

Thanks,
Stefano

