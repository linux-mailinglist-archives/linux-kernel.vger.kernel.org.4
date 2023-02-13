Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58186694B94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBMPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjBMPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33EB1D92E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JU5gR2JfhT2YMusgdO9Wq8a6MnhhEnF0yv/p8fHaQm8=;
        b=gdHdoX9fvCIILzLRjvtJWb3Dd+26fnPY/J3sgWHx3cQqB2SKLk+Eil6YpbxSo+oZctsdgW
        11oQC1tsjKd8kK40j0oku7a58iqq45use0Mjx0vazUCV6STWF2zzr8UQHWUxpyPfXZaKGe
        NA9kZcYioORzYYiUydHPQt0cijJxq1g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-6hho7J9gP7W7W2fk7S3njQ-1; Mon, 13 Feb 2023 10:45:59 -0500
X-MC-Unique: 6hho7J9gP7W7W2fk7S3njQ-1
Received: by mail-qv1-f72.google.com with SMTP id jy16-20020a0562142b5000b0056eb7af8942so961213qvb.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU5gR2JfhT2YMusgdO9Wq8a6MnhhEnF0yv/p8fHaQm8=;
        b=hf1PpJv4wlwBVJdMFgQ9K/8F62vqmNqEmu19exH60cwbt15O7p2DRa5XczFFk3EXFU
         4u5ff1c95IsewD4PElhnG6ixa01Pg6vK2LNwhRSmsRJc7Lzu2Jjlja3eXMHzWDNMjpKj
         u6ptPVR5AbJfkcPsok1j22uEqrV3cP49e6rrf7mJaRu+BMLIOVKQQDZpTivMo1J4mJgM
         GpOWe9si/PlloA7tW22ck4srWWYdLYdocOXXgemZJo9Lf9v5a7neFDUezW1wLyW6fzO+
         7qFmJ9HPHhhfVL/LPjFYrfRA8N3w0q3GFVQpIjhsLhGTqKcKtwr1wm92LoY1dZeXLCRf
         9xBA==
X-Gm-Message-State: AO0yUKXlE817bD+TLnUowcdqGb5ce+PybvgeALmgzXFv7E/hYUM2YV29
        qMZrS5nbzxZJpGfL+PFU1HJEGGeotz7stzMID/K886r2zsqgf1o0J7eMp374mMjHHCxyiAn3YXh
        /zeaU5bNwlTDV55c/t6updEt3
X-Received: by 2002:a05:6214:e8f:b0:56e:b7a1:c7e with SMTP id hf15-20020a0562140e8f00b0056eb7a10c7emr4054955qvb.23.1676303159365;
        Mon, 13 Feb 2023 07:45:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8aW7aqzIzN2tmLsHI7C7rMX+FyClrDf7lnBwRHBSw/mjp1kiMRqZ2B/NK5+xijWm2Bz+o0tQ==
X-Received: by 2002:a05:6214:e8f:b0:56e:b7a1:c7e with SMTP id hf15-20020a0562140e8f00b0056eb7a10c7emr4054919qvb.23.1676303159085;
        Mon, 13 Feb 2023 07:45:59 -0800 (PST)
Received: from debian (2a01cb058918ce0052a1c4711233f5f0.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:52a1:c471:1233:f5f0])
        by smtp.gmail.com with ESMTPSA id l68-20020a37bb47000000b00733fe2fa3a3sm9965753qkf.36.2023.02.13.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:45:58 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:45:54 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>, jchapman@katalix.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y+pbMgEq0epVbB4P@debian>
References: <20230212162623.2301597-1-syoshida@redhat.com>
 <cd8907dc-0319-6c04-271c-489ca4550579@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8907dc-0319-6c04-271c-489ca4550579@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:05:59PM +0100, Alexander Lobakin wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> Date: Mon, 13 Feb 2023 01:26:23 +0900
> 
> > When a file descriptor of pppol2tp socket is passed as file descriptor
> > of UDP socket, a recursive deadlock occurs in l2tp_tunnel_register().
> > This situation is reproduced by the following program:
> 
> [...]
> 
> > +static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
> > +					       struct l2tp_connect_info *info,
> > +					       bool *new_tunnel)
> > +{
> > +	struct l2tp_tunnel *tunnel;
> > +	int error;
> > +
> > +	*new_tunnel = false;
> > +
> > +	tunnel = l2tp_tunnel_get(net, info->tunnel_id);
> > +
> > +	/* Special case: create tunnel context if session_id and
> > +	 * peer_session_id is 0. Otherwise look up tunnel using supplied
> > +	 * tunnel id.
> > +	 */
> > +	if (!info->session_id && !info->peer_session_id) {
> > +		if (!tunnel) {
> 
> This `if` is the sole thing the outer `if` contains, could we combine them?

The logic of this code is a bit convoluted, sure, but if we want to
rework it, let's simplify it for real:

	tunnel = l2tp_tunnel_get(...)
	if (tunnel)
		return tunnel; /* the original !tunnel->sock test is useless I believe */

	/* Tunnel not found. Try to create one if both session_id and
	 * peer_session_id are 0. Fail otherwise.
	 */
	if (info->session_id || info->peer_session_id)
		return ERR_PTR(-ENOENT);

	[...] /* Tunnel creation code */


However, I'd prefer to keep such refactoring for later. Keeping the
same structure in pppol2tp_tunnel_get() as in the original code helps
reviewing the patch.

> > +			struct l2tp_tunnel_cfg tcfg = {
> > +				.encap = L2TP_ENCAPTYPE_UDP,
> > +			};
> > +
> > +			/* Prevent l2tp_tunnel_register() from trying to set up
> > +			 * a kernel socket.
> > +			 */
> > +			if (info->fd < 0)
> > +				return ERR_PTR(-EBADF);
> > +
> > +			error = l2tp_tunnel_create(info->fd,
> > +						   info->version,
> 
> This fits into the prev line.
> 
> > +						   info->tunnel_id,
> > +						   info->peer_tunnel_id, &tcfg,
> > +						   &tunnel);
> > +			if (error < 0)
> > +				return ERR_PTR(error);
> > +
> > +			l2tp_tunnel_inc_refcount(tunnel);
> > +			error = l2tp_tunnel_register(tunnel, net, &tcfg);
> > +			if (error < 0) {
> > +				kfree(tunnel);
> > +				return ERR_PTR(error);
> > +			}
> > +
> > +			*new_tunnel = true;
> > +		}
> > +	} else {
> > +		/* Error if we can't find the tunnel */
> > +		if (!tunnel)
> > +			return ERR_PTR(-ENOENT);
> 
> [...]
> 
> Thanks,
> Olek
> 

