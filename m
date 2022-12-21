Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE56531C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLUNad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLUNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F90C25
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671629381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ExJ8LKwiPYZ7ICDIfMLKGDc4/w+9b39VLWD/GNS2Unc=;
        b=Obx48Pn4saPLjSW2JWgNJCv6c5hIPP2p+aV3tikXwe3j+6/alqjgkuecks8U0AEHSCwoNa
        ffmbRxd5P3E42GhoF3A7m5XXp6NqtY7IPza8xEQ8tbv/1zmjgzDumXW6NThXkwwmRUH/cm
        OaTefBxrnE45Ysm0qByQ/Ts9rVo142s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159--CNelN-vMlymcSUeqyEtOg-1; Wed, 21 Dec 2022 08:29:37 -0500
X-MC-Unique: -CNelN-vMlymcSUeqyEtOg-1
Received: by mail-wm1-f69.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so943959wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExJ8LKwiPYZ7ICDIfMLKGDc4/w+9b39VLWD/GNS2Unc=;
        b=VzxypEyi3KxWP0G2jPhmqcwOqNs5N6FtS5bLXE/5S47lhc14Z3wSbzPd5GeqTX5OBZ
         xBko3mcADkUHYsV9Vt85oDfvFDVznqRSScsv+xMJTK2SBPDWXz6XjDfD91BE1WXBKT9l
         RBXRMBS3/eql+WbAFBj/j8itFmV6PrTyQMGkeTnERDpHTrgWIGqRvfhfJS1wKeZ8SlNv
         LH8bCe5BTPXjebaaDc/m3HIOzq+81W9AiKskQRjgrW4frWQYe4R/5pGYB8vYrowsN7mT
         h8cA+McZPt3S6R6heWq65q43tyzj/FGFoQovMJoQB79YkKcR6gMyAfhOi24OrmAkVEaN
         dsmQ==
X-Gm-Message-State: AFqh2kqFG416jr3LxNwPcilca7zQv6JC0Vj6AnuWWRpHQE4yVo5foIqa
        Mir7Wz+yL47fqIc/aTnqJzEKLJXlOUb+F2t8tcErwsxQ5drYiz4KC3oKOTZ8zHPgs73nKxqgi+1
        pQYV7IzRwKulU4KgXDhYKvrL/
X-Received: by 2002:a7b:c7c8:0:b0:3d7:889:7496 with SMTP id z8-20020a7bc7c8000000b003d708897496mr1654903wmk.17.1671629376193;
        Wed, 21 Dec 2022 05:29:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvW6AH9BLD+Zo2jmVGceaMPUsMGAeTaSMzanQMfKKe98G9pT4EaDNsQGgFdg1UaM1DhAfxUsA==
X-Received: by 2002:a7b:c7c8:0:b0:3d7:889:7496 with SMTP id z8-20020a7bc7c8000000b003d708897496mr1654895wmk.17.1671629375963;
        Wed, 21 Dec 2022 05:29:35 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003d1d5a83b2esm2501080wmq.35.2022.12.21.05.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:29:35 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:29:33 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] vdpa_sim: switch to use __vdpa_alloc_device()
Message-ID: <20221221132933.zne6afpxgcpceijt@sgarzare-redhat>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221221061652.15202-2-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:16:49PM +0800, Jason Wang wrote:
>This allows us to control the allocation size of the structure.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b071f0d842fb..757afef86ba0 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -250,6 +250,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 			       const struct vdpa_dev_set_config *config)
> {
> 	const struct vdpa_config_ops *ops;
>+	struct vdpa_device *vdpa;
> 	struct vdpasim *vdpasim;
> 	struct device *dev;
> 	int i, ret = -ENOMEM;
>@@ -267,14 +268,16 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	else
> 		ops = &vdpasim_config_ops;
>
>-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
>-				    dev_attr->ngroups, dev_attr->nas,
>-				    dev_attr->name, false);
>-	if (IS_ERR(vdpasim)) {
>-		ret = PTR_ERR(vdpasim);
>+	vdpa = __vdpa_alloc_device(NULL, ops,
>+				   dev_attr->ngroups, dev_attr->nas,
>+				   sizeof(struct vdpasim),
>+				   dev_attr->name, false);
>+	if (IS_ERR(vdpa)) {
>+		ret = PTR_ERR(vdpa);
> 		goto err_alloc;
> 	}
>
>+	vdpasim = vdpa_to_sim(vdpa);
> 	vdpasim->dev_attr = *dev_attr;
> 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
> 	spin_lock_init(&vdpasim->lock);
>-- 
>2.25.1
>

