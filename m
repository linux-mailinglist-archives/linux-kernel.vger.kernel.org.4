Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EE6B1E03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCII1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCII0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D3A83A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678350237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZw+8PkpvnITOM51K6QxrDhmPN2cNcmXJdgLsTe/KhY=;
        b=BWBgLYVPxzYk+C4quOpyUXP8eBAIFrh/K1af8CqkAB+eifn/QmhyLhK+GjpCKLYBtbTuz5
        CTCPUrWpOlLG1QEtXnJxmBLB818S0BNfwhJjs10l/DYcnD7CAOknHMB5eHXqNmvq19qZ9J
        2G+3jkjslIZvIa626i8MCuuLRBTMht8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-BZpqgHvsOc2VUGUdaWvpIw-1; Thu, 09 Mar 2023 03:23:56 -0500
X-MC-Unique: BZpqgHvsOc2VUGUdaWvpIw-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so383280wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZw+8PkpvnITOM51K6QxrDhmPN2cNcmXJdgLsTe/KhY=;
        b=njjG2pkG1TOSq6OCwnf4f+O1hx0JPc7LUyQZTJP22jD9wrcopau+sE/RBWlNPUr5ZR
         B3rf4GQZ/btArBK45j+TXGtscaC6COEVYOMpIh1EG7u94QXU8CENHy35jdtWXRxcqTPx
         6TC67mNl/zhxmEynJpS1AKOgPlz1SbjFl2rU9hPdXN1wyD4ttwv7sDo78OCMSLPlUUYA
         9ARHB5WGvH1Wuw5dUTL15oG38ghDPAu07IloqDMWAl8hqZkJAPDbmHTgq+9wdGNJEX/j
         2tcslBlHjjeMq0iM/1scv05ar3lrdxEPTGtFUdn5EnRob8MQInCeSyb/GFdX7dKxh6NE
         SJEg==
X-Gm-Message-State: AO0yUKUHquEV3JtMTTx4jTdCmxwRvXtNSEbFbHvpQg39iBp6JbUsEmMb
        vB7BkzUvV/Yf7wtSZVqtHgnSyEatp3GIW9XEaXyWUxwpD5Mzji+aLvnv3B3d//m24iYRr4dAQHZ
        FgghZjOxqWm3bxWyVS62jsk8q
X-Received: by 2002:a05:600c:c11:b0:3df:d431:cf64 with SMTP id fm17-20020a05600c0c1100b003dfd431cf64mr19159706wmb.39.1678350235115;
        Thu, 09 Mar 2023 00:23:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8WNigRlS2/369LtM0djAYyNqN3raDfhZGg8ODekM6tL6N33xyLTnVfkUTqE57R1YdM9kFjFA==
X-Received: by 2002:a05:600c:c11:b0:3df:d431:cf64 with SMTP id fm17-20020a05600c0c1100b003dfd431cf64mr19159693wmb.39.1678350234844;
        Thu, 09 Mar 2023 00:23:54 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003e4326a6d53sm1751764wmr.35.2023.03.09.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:23:54 -0800 (PST)
Date:   Thu, 9 Mar 2023 09:23:51 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     mst@redhat.com, Rong Tao <rongtao@cestc.cn>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Ignore virtio-trace/trace-agent
Message-ID: <20230309082351.y63lsa7gaxpoq2k7@sgarzare-redhat>
References: <tencent_52B2BC2F47540A5FEB46E710BD0C8485B409@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_52B2BC2F47540A5FEB46E710BD0C8485B409@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:13:07PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>since commit 108fc82596e3("tools: Add guest trace agent as a user tool")
>introduce virtio-trace/trace-agent, it should be ignored in the git tree.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
> tools/virtio/.gitignore | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
>index 075588c4da08..9934d48d9a55 100644
>--- a/tools/virtio/.gitignore
>+++ b/tools/virtio/.gitignore
>@@ -2,3 +2,4 @@
> *.d
> virtio_test
> vringh_test
>+virtio-trace/trace-agent
>-- 
>2.39.1
>

