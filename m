Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B2C71069D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbjEYHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjEYHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36901BF
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685000724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=moqm2xMtvs1QXIlu4uTeryrCfPMIkNPE51IfYtbbbXc=;
        b=eRvdO5twmhV7fLf8r82TH11k5aLsV/LpxyjUw8foeaL+41+LuOm/c9rvVseq72dON/QCP9
        qV2pkNJTn0Jt2zswnO7oCfy8X4rhFjx7XZmgcnQct2Fsu1e0DuPqDXlsUs+4rsfYHxPYWl
        NRW+hYBqD0wFOThbFSaW1T+hM48+X88=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-1UDXCO2yNqG4UyyWQ1bdYw-1; Thu, 25 May 2023 03:45:22 -0400
X-MC-Unique: 1UDXCO2yNqG4UyyWQ1bdYw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62380ffb993so10955206d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685000722; x=1687592722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moqm2xMtvs1QXIlu4uTeryrCfPMIkNPE51IfYtbbbXc=;
        b=SSChtS0g2V7APmC6VlWFTkoZT55AYtGgi30e+EuMMuIVbgpXyj5JvZrRnU4QuO40dS
         X5pxyuXWvkRGvrDaGNkybp7wl9b3szbVgzaQqiAX2ovEoziDyHt/pQuPg0uePnsKwFd+
         YZPWBbFYC+wh8QoKFgNzy2xkj7WPbYIoAUKv8Q1hT8C7UEl45etgKTExCVI01Gh/rnrs
         LtwuciB9Y5I7/TG/E8+GYqxivGFrnATLjWzCOdg0SV9WV88h9fz+xPXShHQSPN/GX7J7
         LAuH10rXHZzFw0i3Q/dg9SJC0Mw19oknIw+nZ5AKot7fGIj5V81fhfH5JVO3rIlPL3XQ
         e5+A==
X-Gm-Message-State: AC+VfDwU4MaWpRl0SVPKsX7FYMTFQhJ5+aXPvuq+F48rKSM2rQfreFGD
        sFa0TqPtEMa6hMOjuVfmFKBsRxFzAKaoQqSf9OZ0A59DdnW+KOCad17fwU8UdeVvsB7V+CqLTeR
        Bxy7ySAn629qCGY2vvwoOkXug
X-Received: by 2002:a05:6214:5013:b0:5ef:56e4:f629 with SMTP id jo19-20020a056214501300b005ef56e4f629mr514380qvb.38.1685000722331;
        Thu, 25 May 2023 00:45:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HCJKGlMVKZnjVIAhyXmrhUFUNU35N4whAygVzlGeR13jXaM1sA9iXGP6ukgCNVa86jNz5fg==
X-Received: by 2002:a05:6214:5013:b0:5ef:56e4:f629 with SMTP id jo19-20020a056214501300b005ef56e4f629mr514372qvb.38.1685000722072;
        Thu, 25 May 2023 00:45:22 -0700 (PDT)
Received: from redhat.com ([191.101.160.247])
        by smtp.gmail.com with ESMTPSA id l16-20020ad44250000000b0061b698e2acesm234148qvq.18.2023.05.25.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:45:21 -0700 (PDT)
Date:   Thu, 25 May 2023 03:45:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Message-ID: <20230525034503-mutt-send-email-mst@kernel.org>
References: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:36:12PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Ignore executions for ringtest.

I think you mean "executables".

> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/virtio/ringtest/.gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/virtio/ringtest/.gitignore
> 
> diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
> new file mode 100644
> index 000000000000..100b9e30c0f4
> --- /dev/null
> +++ b/tools/virtio/ringtest/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +/noring
> +/ptr_ring
> +/ring
> +/virtio_ring_0_9
> +/virtio_ring_inorder
> +/virtio_ring_poll
> -- 
> 2.39.1
> 

