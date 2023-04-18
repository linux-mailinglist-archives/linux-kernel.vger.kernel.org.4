Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9D6E5C26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDRIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDRIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0207EFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681806851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rv7GgXtXE5BwsWMierc+FyeJxK2YpNxYqQW013L/+7M=;
        b=drLh909BPNjahjto+qKA+tz0ULFsWTYhIoqw79+aMM+XLn2E4XSo/GYl7Mj7L79PGWWsSs
        /3ktgQJMgw0WAeaGxPvzHJN6FUbicIcchB14YHNfEZhvfhA5PLdX1gpgPD4JcAD2kvKbe/
        2V5RsI/MZys5iDTF/xxk5uJ374WEWuA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-WtixZ95ROMmTUbYAZ0pntQ-1; Tue, 18 Apr 2023 04:34:08 -0400
X-MC-Unique: WtixZ95ROMmTUbYAZ0pntQ-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c4f1400b003f0a04fe9b9so6130536wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806847; x=1684398847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv7GgXtXE5BwsWMierc+FyeJxK2YpNxYqQW013L/+7M=;
        b=RBb+svMJHNaSyOiKIhLArLAf4v1yNl+Xyz/knD5KSizWRzO+AChC0oeb1oESduYEzW
         c+l2RLHCx/lz7foCrRlgW5Dpch4FO1BkAsV53Gg42wruWcJNV3IZQy2T3H077bCZi/RQ
         sn7NPxg8v8/5aFd6RzDjlon3c8Mm/kZzUxjnRyEkhzH6PJZkZmyMd1xA1a72LpEX43JN
         YM5+0MV0X+lRADmnCNsE/CbABIeCuEc1+/tHcXTo8BWn+G/gH77SyAlS/182Tr3/aQB8
         vvOM5/8YVA344Z+ARjffZeso9pGnIMAZCY09/8Bza+WBPvzUJ58G2Rzspu1bTi87gumy
         rjjg==
X-Gm-Message-State: AAQBX9dikTjQPVoCTB/dGy/eUYBG/5KUFqDNH1Rybhuqe2PKUEZe1azQ
        /WPy7dik1gkBJmErLgDS6o6/z9mz+Kfm/P3NNDO1GbqH1IbLTgFUW+AUUxuMjbRHorvZGsd2BWL
        waVKefOkKMfgaqPjcwPxwJyykFS8uHNx3
X-Received: by 2002:a1c:cc05:0:b0:3ef:d8c6:4bc0 with SMTP id h5-20020a1ccc05000000b003efd8c64bc0mr12024308wmb.40.1681806847534;
        Tue, 18 Apr 2023 01:34:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAnXaPSvYcMlsYfwVlVoREfFWc5IGmWbn2t4pTzfp2bAd1gmhgH/3mQQN/vZnl6zfILt9UWw==
X-Received: by 2002:a1c:cc05:0:b0:3ef:d8c6:4bc0 with SMTP id h5-20020a1ccc05000000b003efd8c64bc0mr12024293wmb.40.1681806847207;
        Tue, 18 Apr 2023 01:34:07 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003ef4cd057f5sm18266803wmq.4.2023.04.18.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:34:06 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:34:03 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        James Chapman <jchapman@katalix.com>, tparkin@katalix.com,
        edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPPoL2TP: Add more code snippets
Message-ID: <ZD5V+z+cBaXvPbQa@debian>
References: <20230416220704.xqk4q6uwjbujnqpv@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416220704.xqk4q6uwjbujnqpv@begin>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 12:07:04AM +0200, Samuel Thibault wrote:
> The existing documentation was not telling that one has to create a PPP
> channel and a PPP interface to get PPPoL2TP data offloading working.
> 
> Also, tunnel switching was not described, so that people were thinking
> it was not supported, while it actually is.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> ---
>  Documentation/networking/l2tp.rst |   59 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 3 deletions(-)
> 
> --- a/Documentation/networking/l2tp.rst
> +++ b/Documentation/networking/l2tp.rst
> @@ -387,11 +387,12 @@ Sample userspace code:
>    - Create session PPPoX data socket::
>  
>          struct sockaddr_pppol2tp sax;
> -        int fd;
> +        int ret;
>  
>          /* Note, the tunnel socket must be bound already, else it
>           * will not be ready
>           */
> +        int session_fd = socket(AF_PPPOX, SOCK_DGRAM, PX_PROTO_OL2TP);

Please declare session_fd with the other variables.
Also, check the return value of the socket() call.

>          sax.sa_family = AF_PPPOX;
>          sax.sa_protocol = PX_PROTO_OL2TP;
>          sax.pppol2tp.fd = tunnel_fd;
> @@ -406,12 +407,64 @@ Sample userspace code:
>          /* session_fd is the fd of the session's PPPoL2TP socket.
>           * tunnel_fd is the fd of the tunnel UDP / L2TPIP socket.
>           */
> -        fd = connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
> -        if (fd < 0 ) {
> +        ret = connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
> +        if (ret < 0 ) {

Now you also need to close session_fd.

>                  return -errno;
>          }
>          return 0;
>  
> +  - Create PPP channel::
> +
> +        int chindx;
> +        ret = ioctl(session_fd, PPPIOCGCHAN, &chindx);
> +        if (ret < 0)
> +                return -errno;
> +
> +        int ppp_chan_fd = open("/dev/ppp", O_RDWR);
> +
> +        ret = ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx);
> +        if (ret < 0)
> +                return -errno;
> +
> +Non-data PPP frames will be available for read on `ppp_chan_fd`.
> +
> +  - Create PPP interface::
> +
> +        int ppp_if_fd = open("/dev/ppp", O_RDWR);

Check for errors please.

> +
> +        int ifunit;

Also, keep kernel style formatting:
  * All variable declarations in one block (ordered from longest to
    shortest line).
  * New line between variable declarations and code.

> +        ret = ioctl(ppp_if_fd, PPPIOCNEWUNIT, &ifunit);

You need to initialise ifunit first.
Use -1 to let the kernel pick a free unit index.

> +        if (ret < 0)
> +                return -errno;
> +
> +        ret = ioctl(ppp_chan_fd, PPPIOCCONNECT, ifunit);
> +        if (ret < 0)
> +                return -errno;
> +
> +The ppp<ifunit> interface can then be configured as usual with SIOCSIFMTU,
> +SIOCSIFADDR, SIOCSIFDSTADDR, SIOCSIFNETMASK, and activated by setting IFF_UP
> +with SIOCSIFFLAGS
> +
> +  - Tunnel switching is supported by bridging channels::

This is a PPP feature not an L2TP one. PPPIOCBRIDGECHAN's description
belongs to Documentation/networking/ppp_generic.rst, where it's already
documented. If documentation needs to be improved, that should be done
there.

If necessary, you can link to ppp_generic.rst here.

Also, calling this feature 'tunnel switching' is misleading. Switching
happens between L2TP sessions (or more generally between any PPP
transports), not between L2TP tunnels (which are just L2TP session
multiplexers).

