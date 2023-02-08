Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E268F957
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjBHVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjBHVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D34FAED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675889885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c19y15vFgdgq3qzwbs9TNv81UfD0n+GAFQYuUQ5/imc=;
        b=MY516DravlPOGQIqksoWUFhKfvcqU66XkqtULzCu4XOAZRDIz0K8VyvcGUrLcEpLhwGqJX
        wcZa4UqMzpimlkkcYf5+im0DSefYu9SjBeTD1py8PzV1fFcIm0U0/mmEqqVWL486zd+/BJ
        PKFxIpRxpBPNF84HvZ3kjHhpURBzuZc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-l8neLt3XM-WLCdO-PaN1HQ-1; Wed, 08 Feb 2023 15:58:04 -0500
X-MC-Unique: l8neLt3XM-WLCdO-PaN1HQ-1
Received: by mail-qk1-f199.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so12798793qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c19y15vFgdgq3qzwbs9TNv81UfD0n+GAFQYuUQ5/imc=;
        b=Z2dCEjaE3p0Y74/gLamEwVmcXbHwtCpzZXUsaQk8rixlByrg9RC4YkLEkZbrctHy0R
         L04q3rCzhDofvKggugV7fBFkL3vx5B824rrWztidpuoKXMXi2p2rgP4MJcSYLu2fS5+y
         ARZDnuYo6IfSaQ6Sq6d0RmBWYg/U06kZuPY3FK/2vvnjJo2Cx2Iy7NujqdnchtTqwR6c
         S34yhrnNBPzQjP1gw1TFYbXBJF3gip5XJCq7NhMtgMmzl414c0ZRez5+KIMnRgST2cDe
         IYDN6xcGftsGaz+mIoejk2wxoUf+yx3UkVtAHmP9OKq+rGh1lRMye7FQosQmikcXA5WH
         Xmhw==
X-Gm-Message-State: AO0yUKViRqAPLHpTekh1F8AlZdx150kC5dctUm/ZMa8pTm0e2st0Q9A6
        dg8egiqg3/jBu7fqsuIcF64FBjsy2+qnv5SEJVO8P8w9/ikk/yaRupe8XQ2F04P3tZRodYrljvg
        mkOEnJkDWQ3YKkK14SfwaOdCc
X-Received: by 2002:ac8:5a54:0:b0:3ba:1acd:4f8 with SMTP id o20-20020ac85a54000000b003ba1acd04f8mr15598465qta.42.1675889883754;
        Wed, 08 Feb 2023 12:58:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/wovYixPV1h2XRRqRycKSEi/i0QxGQmfsuo8Z2G3dqDhLj5NeHfUw6BSXS4RMUzWS1RX9f9A==
X-Received: by 2002:ac8:5a54:0:b0:3ba:1acd:4f8 with SMTP id o20-20020ac85a54000000b003ba1acd04f8mr15598433qta.42.1675889883403;
        Wed, 08 Feb 2023 12:58:03 -0800 (PST)
Received: from lobep17 ([2600:6c64:4e7f:603b:6e24:8ff:feb9:533e])
        by smtp.gmail.com with ESMTPSA id r19-20020ac87953000000b003b6953fbb8fsm12168420qtt.32.2023.02.08.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:58:02 -0800 (PST)
Message-ID: <caff1add88d1e46c962ee52aae441769450c4dd9.camel@redhat.com>
Subject: Re: [PATCH] scsi: target: iscsi: set memalloc_noio with loopback
 network connections
From:   Laurence Oberman <loberman@redhat.com>
To:     David Jeffery <djeffery@redhat.com>, target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Feb 2023 15:58:01 -0500
In-Reply-To: <20230208200957.14073-1-djeffery@redhat.com>
References: <20230208200957.14073-1-djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-08 at 15:09 -0500, David Jeffery wrote:
> If an admin connects an iscsi initiator to an iscsi target on the
> same
> system, the iscsi connection is vulnerable to deadlocks during memory
> allocations. Memory allocations in the target task accepting the I/O
> from
> the initiator can wait on the initiator's I/O when the system is
> under
> memory pressure, causing a deadlock situation between the iscsi
> target and
> initiator.
> 
> When in this configuration, the deadlock scenario can be avoided by
> use of
> GFP_NOIO allocations. Rather than force all configurations to use
> NOIO,
> memalloc_noio_save/restore can be used to force GFP_NOIO allocations
> only
> when in this loopback configuration.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/target/iscsi/iscsi_target.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c
> b/drivers/target/iscsi/iscsi_target.c
> index baf4da7bb3b4..a68e47e2cdf9 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -16,6 +16,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/idr.h>
>  #include <linux/delay.h>
> +#include <linux/sched/mm.h>
>  #include <linux/sched/signal.h>
>  #include <asm/unaligned.h>
>  #include <linux/inet.h>
> @@ -4168,7 +4169,10 @@ int iscsi_target_rx_thread(void *arg)
>  {
>  	int rc;
>  	struct iscsit_conn *conn = arg;
> +	struct dst_entry *dst;
>  	bool conn_freed = false;
> +	bool loopback = false;
> +	unsigned int flags;
>  
>  	/*
>  	 * Allow ourselves to be interrupted by SIGINT so that a
> @@ -4186,8 +4190,25 @@ int iscsi_target_rx_thread(void *arg)
>  	if (!conn->conn_transport->iscsit_get_rx_pdu)
>  		return 0;
>  
> +	/*
> +	 * If the iscsi connection is over a loopback device from using
> +	 * iscsi and iscsit on the same system, we need to set
> memalloc_noio to
> +	 * prevent memory allocation deadlocks between target and
> initiator.
> +	 */
> +	rcu_read_lock();
> +	dst = rcu_dereference(conn->sock->sk->sk_dst_cache);
> +	if (dst && dst->dev && dst->dev->flags & IFF_LOOPBACK)
> +		loopback = true;
> +	rcu_read_unlock();
> +
> +	if (loopback)
> +		flags = memalloc_noio_save();
> +
>  	conn->conn_transport->iscsit_get_rx_pdu(conn);
>  
> +	if (loopback)
> +		memalloc_noio_restore(flags);
> +
>  	if (!signal_pending(current))
>  		atomic_set(&conn->transport_failed, 1);
>  	iscsit_take_action_for_connection_exit(conn, &conn_freed);


I had mentioned to Mike that this was already tested at a large
customer and in our labs and resolved the deadlocks .

Regards
Laurence Oberman

