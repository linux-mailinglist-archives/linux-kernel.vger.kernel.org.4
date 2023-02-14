Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C8696A61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjBNQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjBNQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBC4EE3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676393571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xcfym2iP6C8F9eW2STT09alZWHtr17+Oe7VPDOEqNNs=;
        b=I74mgQK9Fq2f9fh6PoETBNaCp8ErtZdEGiS8rfwPavY6LjEejyPB03HIk4VFyf81Pm4D7B
        4sLysVmaGjqyGM0MF7pr/r8o92wixwaLsDF3zNo0X4CKQN1vDSs7eeCM0mdK3JaCV5TyEC
        8waXhpys0oCRRq771oclzi2sn9LUP+c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-JsiHI0-CNBOoVmsePDfqxg-1; Tue, 14 Feb 2023 11:52:50 -0500
X-MC-Unique: JsiHI0-CNBOoVmsePDfqxg-1
Received: by mail-pj1-f69.google.com with SMTP id d16-20020a17090ad3d000b00233f132b99dso3649433pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcfym2iP6C8F9eW2STT09alZWHtr17+Oe7VPDOEqNNs=;
        b=Hso7OJ5lplcv6oBepTm5V8MGXSgV6tjx6mxvdc060z0WlkMeH5TusNJIFrHMc3/j6E
         OomDcuT/MxJ2m7lKpnNDcDS/WbDB5fxzucD1XPzZkw3m1OcKabJPZfd42D0z0yvHuOnM
         LFPXBcIX072/eiec0xsyFIwcAXBVGLSn/r+PCDeIp6Tj9//MewlTGCIE8ItBfdh7pJOq
         Q8X6C1zy9E72AyMfFp9b83rrTcDyb38djai4ckEs/riBwb10kIBpKbkzGOVBWTJ0mYpy
         ATc3EjvHQNH7jW/RE00uEqAwDuMrkCg6R5K/aecrMrsXKozRCRphir9laRC3ckpskdpj
         hlxw==
X-Gm-Message-State: AO0yUKWIk6YPb1gkfl/mD2zVAxO98trYv6+zGJBbsKK+f5mAyqs3403C
        y+T/S0Lz01qWOejqRXpZLM0AFNeHo1zN0WZnb4p3seCiv35Kt04i4CogZGQWx87NG9tq5fZcbcM
        l1J+UckKm22TMz4PvQiXK4mMpzlSD/5A4
X-Received: by 2002:a05:6a00:1b:b0:5a8:ee14:1ec3 with SMTP id h27-20020a056a00001b00b005a8ee141ec3mr545837pfk.12.1676393569404;
        Tue, 14 Feb 2023 08:52:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/vxkZHr4tyViFNHfd4KdX/nsNresC+xIQfLeb5maHeyEsQjba+o4qiR647YUzLPWg2Cxa0oQ==
X-Received: by 2002:a05:6a00:1b:b0:5a8:ee14:1ec3 with SMTP id h27-20020a056a00001b00b005a8ee141ec3mr545826pfk.12.1676393569195;
        Tue, 14 Feb 2023 08:52:49 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id e12-20020aa78c4c000000b005a87d636c70sm61420pfd.130.2023.02.14.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:52:48 -0800 (PST)
Date:   Wed, 15 Feb 2023 01:52:44 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gnault@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y+u8XKx0k9ow8/NA@kernel-devel>
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

Hi Olek,

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

Thank you so much for your comment.  Yes, I agree with you.  But I'd
like to keep the original structure as Guillaume suggested.

Thanks,
Shigeru

> 
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

