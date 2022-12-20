Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242DE651A82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiLTGCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiLTGB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E74EA5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671516071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CxcvbW4SQ7pucHdedQHJukcG8VAvXPlq9vKxUj0hMx4=;
        b=CI19OwdKKIwpz+GLHY37h2SRPO/m6g61XfH52RDQKTEX49TgKyaE0UioyhQ2jaDSngqdJZ
        N5tb/REyWsV443B0+wcPQHlmq4qNE/ewA/1+Y8B4/z5fkpqfeGeryPJYV2tqt9uBeyZedv
        HJZQu7ZtWV6q+9Ow3T3jbYww6AdQF9Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-i4l1UMXnNc6oqYMI7mNntw-1; Tue, 20 Dec 2022 01:01:09 -0500
X-MC-Unique: i4l1UMXnNc6oqYMI7mNntw-1
Received: by mail-qt1-f198.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso5095916qtb.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxcvbW4SQ7pucHdedQHJukcG8VAvXPlq9vKxUj0hMx4=;
        b=exwQNuAZzMrBc7qAopBqDPwA/ohNHoq1opXpEbatzgd6L2uKiu6sqf3jUqVs+X531V
         UFaYYiWeYRZrT9wYdwgc1QxTrNzfRPjiOwJWKX5oFdzcr7jcgHVa/Gwo7EppDwDH03Ob
         Zas3Da9cfrqRG7lB9wC7WUQfHqw/jdieEqUvmepGFkzJXC7MyXE2UGMA9Nb2fkcAVxYQ
         /peiwkXVfLDVLX79pRRb+lBEDaIV8J07aSihe9xXLY8wTGGicOYAdWrVpBniS9udsFjN
         tTnNeNfZpbbbBp7gH1hibVP3H8tiq25g17dDnGUkpTS668alHs9A4gQRSbHaeuQ1E6+q
         KNSg==
X-Gm-Message-State: AFqh2kqyAfK9Du9W3ML0jZUYIrNpGi2I/u7QgryCqirvThbjUeraS+iF
        Tbc/03jTTjwp89vAB+uyOm+i5bBVtnFALTL9nBwYBC3MsukaLN77KhnL3YT5Wa3ZaKqckFHWMd3
        t3mCmUzefT9YTF6zr0lZxD1nO
X-Received: by 2002:ac8:6b82:0:b0:39c:efc8:b2a8 with SMTP id z2-20020ac86b82000000b0039cefc8b2a8mr1860741qts.27.1671516068868;
        Mon, 19 Dec 2022 22:01:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsw52UDtMVMxI8ZArmIc5bnjpD/48/efjCKcb+gL01Wag8osM5NZqk2rULUr1W6iSJyLCyEPg==
X-Received: by 2002:ac8:6b82:0:b0:39c:efc8:b2a8 with SMTP id z2-20020ac86b82000000b0039cefc8b2a8mr1860722qts.27.1671516068550;
        Mon, 19 Dec 2022 22:01:08 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id y23-20020ac87097000000b003a50b9f099esm7063711qto.12.2022.12.19.22.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:01:07 -0800 (PST)
Date:   Tue, 20 Dec 2022 01:01:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20221220010040-mutt-send-email-mst@kernel.org>
References: <20221220105956.4786852d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220105956.4786852d@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:59:56AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/linux/virtio_config.h:74: warning: duplicate section name 'Note'
> include/linux/virtio_config.h:94: warning: expecting prototype for virtio_config_ops(). Prototype was for vq_callback_t() instead
> 
> Revelealed by commit
> 
>   333723e8bc39 ("docs: driver-api: virtio: virtio on Linux")


Ricardo I assume you will fix this? Patch on top is ok.

> -- 
> Cheers,
> Stephen Rothwell


