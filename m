Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A2652E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiLUJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:13:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F1101
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671613988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9B1AE9iXfUV5VO4gONRrYR5hHzr17wsWJVUV7OEY3E=;
        b=D1XLT/rYhYT7HMVsT0S7YCEtvLL93mvb7TBBu4YDcE8+SYIDdUA3klqqpbQiL72wKYhFms
        d2eKQK+1atgtUdPY3R82K3+ACViPwQP9lGvVIdthr01zvvxQ+FqsLtwsrbcpDzGfcVkUv+
        r7BLlzAh+xyCMzJvExps1nzNbCN0CU0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-gkB7oKeOOWm8fzk2tm0c3w-1; Wed, 21 Dec 2022 04:13:07 -0500
X-MC-Unique: gkB7oKeOOWm8fzk2tm0c3w-1
Received: by mail-ed1-f71.google.com with SMTP id e14-20020a056402190e00b0047005d4c3e9so10679428edz.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9B1AE9iXfUV5VO4gONRrYR5hHzr17wsWJVUV7OEY3E=;
        b=5vbfySywydMHPTWCgxofC+5KZqfiVVUVDYgs1l+ceUIMRAxVr6Pn2/AQPlRBvT/PWq
         IKY6DW95m7gpU0mZnzd/Ay5Yzm25iKtwJLQcmzzsLjOgRntnbRCH3STZJEga93Rj4mZt
         YEUnaaj6LWP9v3HCACoU1Wn3YIognSkiFAQrlPQv/46GE3J4dP2z5IvUiMO+cdXz0qVO
         cClaW2INOSB4LuDhHP5KCtR8pXolA9rfQ38bFsL8X46mvAK1Dl14NvOX1X3yKIlQdQdN
         5x8msT7CfuA3eeRcApH98PW5R990k8vOs6yRAruOy7dQ0Lp5iHMdaOCBMcOqSoZbgB1H
         3jGw==
X-Gm-Message-State: AFqh2kpzI5VXvtKhd2w7oFeX81vizCliQnvO9mehm3KjLxhcPmL4zW5Q
        m4THXXJsswHA2f7TWY6h7szNZ22bi1cRKAobTfyu9mxF3l4gU8VYq7uUCzkOHzrlE+0MowwPnxn
        satRHDkduD3nJg/xBZ4BASwO7
X-Received: by 2002:a17:906:6441:b0:7c1:994c:f168 with SMTP id l1-20020a170906644100b007c1994cf168mr4585940ejn.54.1671613986264;
        Wed, 21 Dec 2022 01:13:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4K0F4pqOQKTW+FeVXRl7LTyqCua6J0mFvEILbLF6Z4guSWcyoysAbSikqTK6jLvlp7X2krw==
X-Received: by 2002:a17:906:6441:b0:7c1:994c:f168 with SMTP id l1-20020a170906644100b007c1994cf168mr4585934ejn.54.1671613986092;
        Wed, 21 Dec 2022 01:13:06 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906305300b007c4f8bc322asm6653739ejd.196.2022.12.21.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 01:13:05 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:13:02 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] tools/virtio: fix the vringh test for virtio ring changes
Message-ID: <20221221091302.mxnmrnqvn7oua7nf@sgarzare-redhat>
References: <20221221075506.3291148-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221221075506.3291148-1-mie@igel.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 04:55:06PM +0900, Shunsuke Mie wrote:
>Fix the build caused by missing kmsan_handle_dma() and is_power_of_2() that
>are used in drivers/virtio/virtio_ring.c.
>
>Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>---
> tools/virtio/linux/cpumask.h  |  7 +++++++
> tools/virtio/linux/gfp.h      |  7 +++++++
> tools/virtio/linux/kernel.h   |  1 +
> tools/virtio/linux/kmsan.h    | 12 ++++++++++++
> tools/virtio/linux/log2.h     | 11 +++++++++++
> tools/virtio/linux/topology.h |  7 +++++++
> 6 files changed, 45 insertions(+)
> create mode 100644 tools/virtio/linux/cpumask.h
> create mode 100644 tools/virtio/linux/gfp.h
> create mode 100644 tools/virtio/linux/kmsan.h
> create mode 100644 tools/virtio/linux/log2.h
> create mode 100644 tools/virtio/linux/topology.h
>
>diff --git a/tools/virtio/linux/cpumask.h b/tools/virtio/linux/cpumask.h
>new file mode 100644
>index 000000000000..307da69d6b26
>--- /dev/null
>+++ b/tools/virtio/linux/cpumask.h
>@@ -0,0 +1,7 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef _LINUX_CPUMASK_H
>+#define _LINUX_CPUMASK_H
>+
>+#include <linux/kernel.h>
>+
>+#endif /* _LINUX_CPUMASK_H */
>diff --git a/tools/virtio/linux/gfp.h b/tools/virtio/linux/gfp.h
>new file mode 100644
>index 000000000000..43d146f236f1
>--- /dev/null
>+++ b/tools/virtio/linux/gfp.h
>@@ -0,0 +1,7 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __LINUX_GFP_H
>+#define __LINUX_GFP_H
>+
>+#include <linux/topology.h>
>+
>+#endif
>diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>index 21593bf97755..8b877167933d 100644
>--- a/tools/virtio/linux/kernel.h
>+++ b/tools/virtio/linux/kernel.h
>@@ -10,6 +10,7 @@
> #include <stdarg.h>
>
> #include <linux/compiler.h>
>+#include <linux/log2.h>
> #include <linux/types.h>
> #include <linux/overflow.h>
> #include <linux/list.h>
>diff --git a/tools/virtio/linux/kmsan.h b/tools/virtio/linux/kmsan.h
>new file mode 100644
>index 000000000000..272b5aa285d5
>--- /dev/null
>+++ b/tools/virtio/linux/kmsan.h
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef _LINUX_KMSAN_H
>+#define _LINUX_KMSAN_H
>+
>+#include <linux/gfp.h>
>+
>+inline void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
>+			     enum dma_data_direction dir)
>+{
>+}
>+
>+#endif /* _LINUX_KMSAN_H */
>diff --git a/tools/virtio/linux/log2.h b/tools/virtio/linux/log2.h
>new file mode 100644
>index 000000000000..aa67bb21d8e2
>--- /dev/null
>+++ b/tools/virtio/linux/log2.h
>@@ -0,0 +1,11 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+
>+#ifndef _LINUX_LOG2_H
>+#define _LINUX_LOG2_H
>+
>+inline bool is_power_of_2(unsigned long n)
>+{
>+	return true;
>+}

is_power_of_2 seems defined in tools/include/linux/log2.h so
`#include <linux/log2.h>` in tools/virtio/linux/kernel.h should be
enough.

If that's not the case, however, I think we should return true here only
if n is really power of 2.

Thanks,
Stefano

