Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA8696A51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBNQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjBNQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA22E83C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676393356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUubzQ7KCAE1aIRENx4rj6ON9/S0MhnolQl1MQ3LvdE=;
        b=i7hdnp+TUEgUm/AX3XynjIY0d6lLiwAxEZf1I3tsKZkotOtfng6LAXQ/Md3PN70OhElqdk
        vN+yiYx2qKucJrUtwC+JDEei1u6OlZcI9o8B1rWs/zssqGtiFgvVin/iP06bAB9Fkc62Pb
        9+IpZgPk0PZNTpLw9Wi25Ef/ssFWYyc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-iayBYkpAM66ocg4tBuZHvA-1; Tue, 14 Feb 2023 11:49:14 -0500
X-MC-Unique: iayBYkpAM66ocg4tBuZHvA-1
Received: by mail-pj1-f72.google.com with SMTP id v24-20020a17090ac91800b00233e56ef3a0so3220396pjt.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUubzQ7KCAE1aIRENx4rj6ON9/S0MhnolQl1MQ3LvdE=;
        b=6GEwitjmSk086Ajfa4jJiCK41KWvCRjtRybaTJSEd6cJLu8SlJU5s69atwAaR3vByW
         aAOT4DzMkI3Zjra1ZdI+l3Y/6vhYeuH6rgXqGLiAVYxV8PldIkxZO8okqURJDIO2Kn01
         KVOe1UacHLP+L4EGnpJXsz98rfODiznM/ORTZelSOzcUdwmT4HEG6KXtLANFDJ0Bh2NZ
         yM2dB3Xjeu2dFbAAC8jl08kASI3ZXSOKZQPfq2fsjrj6ZMRP5yOg+hAXXOLCW0vrOV1R
         TaBNG2Z1Qt3BiLISo10ewK/Y8SpavYbfIT5d8t43ZrWQzkDQ9RCgJZCMr+1/ojbp3TWQ
         lYwg==
X-Gm-Message-State: AO0yUKXjpI5AFddwv/3eo3ZHQap5fF8qqo1CupVfi1x69I8E7oZk5lxO
        fSztheJSVqWf3dlBvDC6Hihkjp+grli3El6y6vjn5pOSSvLdkrjCaBehvIMjrQvMEfO5Vfx+CCE
        /MUUc2mgNCc499tirqYD5UgK9
X-Received: by 2002:a17:902:e38d:b0:19a:96f0:b13 with SMTP id g13-20020a170902e38d00b0019a96f00b13mr2210338ple.31.1676393353339;
        Tue, 14 Feb 2023 08:49:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/NrVzuxCjYm8lLvH1AzVpV4SSXCQwWIOzaYPj93yVDuqiq3AIhyyk1vgnTNuVGX4s3YyCPQQ==
X-Received: by 2002:a17:902:e38d:b0:19a:96f0:b13 with SMTP id g13-20020a170902e38d00b0019a96f00b13mr2210317ple.31.1676393353049;
        Tue, 14 Feb 2023 08:49:13 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b0019aaccb665bsm2883733plr.245.2023.02.14.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:49:12 -0800 (PST)
Date:   Wed, 15 Feb 2023 01:49:08 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y+u7hGIAxhvyDG/2@kernel-devel>
References: <20230212162623.2301597-1-syoshida@redhat.com>
 <Y+pPXOqfrYkXPg1K@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+pPXOqfrYkXPg1K@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Mon, Feb 13, 2023 at 03:55:24PM +0100, Guillaume Nault wrote:
> On Mon, Feb 13, 2023 at 01:26:23AM +0900, Shigeru Yoshida wrote:
> > +static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
> > +					       struct l2tp_connect_info *info,
> 
> Please make "*info" const.

Thank you so much for your comment.  I got it.

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
> > +
> > +		/* Error if socket is not prepped */
> > +		if (!tunnel->sock) {
> > +			l2tp_tunnel_dec_refcount(tunnel);
> > +			return ERR_PTR(-ENOENT);
> > +		}
> > +	}
> > +
> > +	return tunnel;
> > +}
> > +
> >  /* connect() handler. Attach a PPPoX socket to a tunnel UDP socket
> >   */
> >  static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
> > @@ -663,7 +722,6 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
> >  	struct pppol2tp_session *ps;
> >  	struct l2tp_session_cfg cfg = { 0, };
> >  	bool drop_refcnt = false;
> > -	bool drop_tunnel = false;
> >  	bool new_session = false;
> >  	bool new_tunnel = false;
> >  	int error;
> > @@ -672,6 +730,10 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
> >  	if (error < 0)
> >  		return error;
> >  
> > +	tunnel = pppol2tp_tunnel_get(sock_net(sk), &info, &new_tunnel);
> > +	if (IS_ERR(tunnel))
> > +		return PTR_ERR(tunnel);
> > +
> >  	lock_sock(sk);
> >  
> >  	/* Check for already bound sockets */
> > @@ -689,57 +751,6 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
> >  	if (!info.tunnel_id)
> >  		goto end;
> 
> The original code did test info.tunnel_id before trying to get or
> create the tunnel (as it doesn't make sense to work on a tunnel whose
> ID is 0). So we need move this test before the pppol2tp_tunnel_get()
> call.

Got it.

> > -	tunnel = l2tp_tunnel_get(sock_net(sk), info.tunnel_id);
> > -	if (tunnel)
> > -		drop_tunnel = true;
> > -
> > -	/* Special case: create tunnel context if session_id and
> > -	 * peer_session_id is 0. Otherwise look up tunnel using supplied
> > -	 * tunnel id.
> > -	 */
> 
> Just a note for your future submissions: for networking patches, we
> normally indicate which tree the patch is targetted to in the mail
> subject (for example "[PATCH net v2]"). Also, you should Cc:
> the author of the patch listed in the Fixes tag.

Thanks for the helpful advice.

Just one more thing.  I created this patch based on the mainline linux
tree, but networking subsystem has own tree, net.  Is it preferable to
create a patch based on net tree for networking patches?

Thanks,
Shigeru

> 

