Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D77106A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbjEYHrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjEYHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF95E71
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685000756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hxihn5MvJp1k9amFLZx8DIAvEjfASYEqP9tbQw550jY=;
        b=axrwksA8vNl6i+/dps4mmtqw1LhXjGxuxlDR3uMI25d0KEoI2k4rOoLfR0W6PgKxanCBVF
        4PCGujNUDAqfQcBzwTErzCCie7TJrJrAOZ1GzMTqTP4UDZbEZNrrJcSvFvtH5np0/2RnGn
        bmPXxJRBEAOMeB3i0uI6LPJGGFNQtNY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-9YZRRYvqPaWayh1U8eXTcg-1; Thu, 25 May 2023 03:45:55 -0400
X-MC-Unique: 9YZRRYvqPaWayh1U8eXTcg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f6ab996ea3so11897881cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685000754; x=1687592754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxihn5MvJp1k9amFLZx8DIAvEjfASYEqP9tbQw550jY=;
        b=eTENwQEvyZerGOjaWIpOvwQ3qOg/THpaKWpSRg6niHgSyK0yFuixz2Qoa/YjU9JO25
         YBi6Wrqd0pVh6x8axa3afH7lPnEMKlaLujfwd9tJ0rzvhvnWoYDKRDp/00aV8rphtoz/
         +dKCir/Xh0MyPoS1s+QT8r1+hqHszV9tMEIuVaLnb4iv2984LrkWtt9iu/2IF+F/Jwob
         qxj3w7hMG5uB9vpbcSFNhaLuZOShkvjGtzYKQc0klIJK8SMA1twT5t52kPZk48t3cpBu
         wRuNcca++d4Kfx70w0GzEf3fzyvNYdUVNUny/VyqWGv3bHpHx9HZWK69lgt6rlu6Ez1d
         VKaA==
X-Gm-Message-State: AC+VfDyxXjG4nFVKYySWWx8vtrMNapS/dQ8oj/0F75eqsVtuC+lZi5ue
        Rr81gHnhVD7u2zZBkOJEXL0mMCmBLbP1X7kNT368B2syDfRfz7N5exxL5qjrETIC5gBkPoW6KQc
        x6poeVVkHqv4/KuBgOXXRzqd+PESo0V84bHY=
X-Received: by 2002:ac8:7e86:0:b0:3f6:9473:7799 with SMTP id w6-20020ac87e86000000b003f694737799mr28852604qtj.55.1685000754506;
        Thu, 25 May 2023 00:45:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79HwPB3ChFKJ7SuFGYhJbVkKZLWrv+0vEbTM6L29n+LMt7qKoBZHFzUSxiE+6oG07CCgQQxA==
X-Received: by 2002:ac8:7e86:0:b0:3f6:9473:7799 with SMTP id w6-20020ac87e86000000b003f694737799mr28852596qtj.55.1685000754187;
        Thu, 25 May 2023 00:45:54 -0700 (PDT)
Received: from redhat.com ([191.101.160.247])
        by smtp.gmail.com with ESMTPSA id z1-20020ac87ca1000000b003f517e1fed2sm216383qtv.15.2023.05.25.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:45:53 -0700 (PDT)
Date:   Thu, 25 May 2023 03:45:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Message-ID: <20230525034526-mutt-send-email-mst@kernel.org>
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


Subject should be "for ringtest" not "to ringtest".

On Wed, May 24, 2023 at 08:36:12PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Ignore executions for ringtest.
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

