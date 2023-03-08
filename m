Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84086B0A99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCHOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCHOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A065A18C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678284447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6cnINXPKnD2lG8vxbE8F7RlXvTWARojvYuwDfsphHk=;
        b=RwthRRk/Zv6kxKewGrPfBq4BMiBNETeTohyjBsyh3XoHSeAsSrhj+L/KehNpVv90dp2GYr
        bSjq42TDI+NsDMxZ3dhi3YAJQueT1GBrkZr7dNk7OWcD+3DBouQxtTsRbSfP1ypmXQyYTy
        4aLCQeuRrSZEy8xybuyjAIgJ8B5jKdw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-XKKV6SYuOimjzuukZKdWBw-1; Wed, 08 Mar 2023 09:07:17 -0500
X-MC-Unique: XKKV6SYuOimjzuukZKdWBw-1
Received: by mail-qk1-f197.google.com with SMTP id x14-20020ae9e90e000000b007429af46d5eso9336989qkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6cnINXPKnD2lG8vxbE8F7RlXvTWARojvYuwDfsphHk=;
        b=NP4PAFijukUUvUXLlyoZa6EYDqdvEyFyvjYxZYa+vpFDW5nbODmVCXXDicIv+sTxth
         jMJ2m3YSH7UzYL8VraHUMIARiIoP0+2FAKKPDac+8JRtkYbDKs7MuJOZzhvu2SZvGpZX
         mPb0NSJusj+Ijrsm6Aq9smbG5biLzhsRvos0WqKOacJgKDOIMNAlHrTuCAyX/vY1sq0+
         UDG/Cms1WUDoQVu3ouSReMfMq5afn2VEFBDfS93H44xn9/uR4GDkRMH4pRAlLRfi86Bf
         r/lh2YxkjttjnjqVViRraBEXvB2F7qiSIW8YbulopZ0qQ0Zm15+C+W98Tb15GdkIpIdv
         fsHg==
X-Gm-Message-State: AO0yUKX9hKfmAmPzK5E3fkuA0pm7nQEECzFjEjFMdIlLlnW/rqY+NmuZ
        pV1sC5fht19V423zJgtE/A5ifZxPV40MhYleocXUCVzKzr0xqlfhEVOHaph579p0REmnnO/0Y3g
        63tusfuKCgxMjxBnY3KejVIA2
X-Received: by 2002:a05:622a:514:b0:3b9:bc8c:c213 with SMTP id l20-20020a05622a051400b003b9bc8cc213mr38252432qtx.30.1678284429137;
        Wed, 08 Mar 2023 06:07:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+bnIm7lfXZMPMGp+YTM6UrwsXhtqFanRzxTP/WHmpltxuwqtKd97gRjNlbA6Fwv+mkWztPJw==
X-Received: by 2002:a05:622a:514:b0:3b9:bc8c:c213 with SMTP id l20-20020a05622a051400b003b9bc8cc213mr38252394qtx.30.1678284428852;
        Wed, 08 Mar 2023 06:07:08 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id x185-20020a3763c2000000b0073baa5ec0besm11506824qkb.115.2023.03.08.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:07:08 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:07:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio: Reorder fields in 'struct virtqueue'
Message-ID: <20230308140704.jsggcp4g3tz7vhxu@sgarzare-redhat>
References: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 09:10:31AM +0100, Christophe JAILLET wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct virtqueue'
>from 72 to 68 bytes.
>
>It saves a few bytes of memory.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>Using pahole
>
>Before:
>======
>struct virtqueue {
>	struct list_head           list;                 /*     0    16 */
>	void                       (*callback)(struct virtqueue *); /*    16     8 */
>	const char  *              name;                 /*    24     8 */
>	struct virtio_device *     vdev;                 /*    32     8 */
>	unsigned int               index;                /*    40     4 */
>	unsigned int               num_free;             /*    44     4 */
>	unsigned int               num_max;              /*    48     4 */
>
>	/* XXX 4 bytes hole, try to pack */
>
>	void *                     priv;                 /*    56     8 */
>	/* --- cacheline 1 boundary (64 bytes) --- */
>	bool                       reset;                /*    64     1 */
>
>	/* size: 72, cachelines: 2, members: 9 */
>	/* sum members: 61, holes: 1, sum holes: 4 */
>	/* padding: 7 */
>	/* last cacheline: 8 bytes */
>};
>
>After:
>=====
>struct virtqueue {
>	struct list_head           list;                 /*     0    16 */
>	void                       (*callback)(struct virtqueue *); /*    16     8 */
>	const char  *              name;                 /*    24     8 */
>	struct virtio_device *     vdev;                 /*    32     8 */
>	unsigned int               index;                /*    40     4 */
>	unsigned int               num_free;             /*    44     4 */
>	unsigned int               num_max;              /*    48     4 */
>	bool                       reset;                /*    52     1 */
>
>	/* XXX 3 bytes hole, try to pack */
>
>	void *                     priv;                 /*    56     8 */
>
>	/* size: 64, cachelines: 1, members: 9 */
>	/* sum members: 61, holes: 1, sum holes: 3 */
>};
>---
> include/linux/virtio.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index 6ac2655500dc..9439ae898310 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -35,8 +35,8 @@ struct virtqueue {
> 	unsigned int index;
> 	unsigned int num_free;
> 	unsigned int num_max;
>-	void *priv;
> 	bool reset;
>+	void *priv;
> };
>
> int virtqueue_add_outbuf(struct virtqueue *vq,
>-- 
>2.34.1
>

