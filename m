Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8470DFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbjEWOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjEWOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D09FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684853655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XzmSpxQsa2CTLr4rwU0KMIUjwE1e290Moluru4LsCWQ=;
        b=i+51YwHQqeDuhjq6wbuiMqh/tMYVpy5JjTUjGzq5XkzJKlefDUaxb1UThcXE8/i2qCKsIq
        L4T7Q/qMowrXwCFB51w2hgSDd4hETqNeorCe2RoaFEF9GE0eFlT3WFEaMq7ubYm6gZfmRh
        Gru6Ai0WMpC2N4oojBWVRRUKCevKOvY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-hGm0NJs0OUKlecjgItN9DQ-1; Tue, 23 May 2023 10:54:14 -0400
X-MC-Unique: hGm0NJs0OUKlecjgItN9DQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3095483ea29so2085647f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853653; x=1687445653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzmSpxQsa2CTLr4rwU0KMIUjwE1e290Moluru4LsCWQ=;
        b=aN2ljhxL6WwHFc38s9n4EgpKHmacpRD7b1LkFDEg3DnnA49GvoMT174pbWltQCBTg2
         pf0mvfBmc/d3Vrxo5lieWZTm/UQ0RHQvzqfbV8KZ8fqBm2r5JZcInDh60nslk592WHiQ
         S3l2XDhAoj5uSLuYIwSbkb4oH97zj1NkK6apu/OXkyGY/rJHN3NsYUtbSBb4P7SMFDgW
         +p9Wbj+FQzwBFJNAWPACdk3Z0IYjDeRIhKxKotzFRISQpNDSfWXMYaWB65zyg+8yNhjw
         W0R9KBrGEbDwpN6BebHI9P+3EvbP522QAGeY9Hn6YGIQ00KvoSeeEArLF8HcEZklvYar
         B9bA==
X-Gm-Message-State: AC+VfDxZHfskLBNbI6JADZC+aZZaj0AAdb3ap4NuJgTXZrmKgIC90h+r
        8Q7x6xB6siEtToBrfu7NDGFtqZiuOecwLxqorFm3Tws+pGgYieT4rGxiRP109Exuyxa6pVlyo2p
        iOPHYgU3OLuIZVLoyllcjiPlX
X-Received: by 2002:a5d:4707:0:b0:306:31e0:964 with SMTP id y7-20020a5d4707000000b0030631e00964mr9243299wrq.55.1684853652814;
        Tue, 23 May 2023 07:54:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4s9KcYtaMvwy+5Pq6aNhocIKn4SglN2/iLOvifbgaQZ0TrNWZdT1Hfp3EtsXRoATqppHcvZw==
X-Received: by 2002:a5d:4707:0:b0:306:31e0:964 with SMTP id y7-20020a5d4707000000b0030631e00964mr9243289wrq.55.1684853652535;
        Tue, 23 May 2023 07:54:12 -0700 (PDT)
Received: from sgarzare-redhat ([89.42.5.88])
        by smtp.gmail.com with ESMTPSA id g9-20020adffc89000000b002e5ff05765esm11359411wrr.73.2023.05.23.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:54:12 -0700 (PDT)
Date:   Tue, 23 May 2023 16:54:09 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: use kzalloc() instead of kmalloc() followed by
 memset()
Message-ID: <5kn47peabxjrptkqa6dwtyus35ahf4pcj4qm4pumse33kxqpjw@mec4se5relrc>
References: <20230522085019.42914-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230522085019.42914-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:20:19PM +0530, Prathu Baronia wrote:
>Use kzalloc() to allocate new zeroed out msg node instead of
>memsetting a node allocated with kmalloc().
>
>Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
>---
> drivers/vhost/vhost.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a92af08e7864..579ecb4ee4d2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2575,12 +2575,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
> /* Create a new message. */
> struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
> {
>-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>+	/* Make sure all padding within the structure is initialized. */
>+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
> 	if (!node)
> 		return NULL;
>
>-	/* Make sure all padding within the structure is initialized. */
>-	memset(&node->msg, 0, sizeof node->msg);

the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 	node->vq = vq;
> 	node->msg.type = type;
> 	return node;
>
>base-commit: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
>-- 
>2.34.1
>
>

