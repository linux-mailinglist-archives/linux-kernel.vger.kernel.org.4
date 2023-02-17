Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38D69AA17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBQLQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBQLQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36909642C8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676632480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GwnXqRN41dS8yeNMsOJVqb/p7IdMaJcNLJqGuiCPy3I=;
        b=L+DoRngSNsCH1xar+WU2vWkI9HS8PcVCXXMscusw3bL/DIyukzJJlWpDqzK0moRtmpMmwk
        70qtoL6inw/MmoMQMnhPCxIpHcCgGq65qmad3dUMwrZ3f+34L5ROZ9eANzYGR2OOonvCzW
        rVrMx9HEZ1M8D8i7LLTPoiUJY5cBXbI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-7NmCq82yP0qXUBCzBsWTLQ-1; Fri, 17 Feb 2023 06:14:39 -0500
X-MC-Unique: 7NmCq82yP0qXUBCzBsWTLQ-1
Received: by mail-qv1-f71.google.com with SMTP id o11-20020a0ceccb000000b0056ecf4b8f5cso244110qvq.19
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwnXqRN41dS8yeNMsOJVqb/p7IdMaJcNLJqGuiCPy3I=;
        b=X4SltO+vnEN3tyeTlNcqfqGCasdhfMwa1cwEM0uth4yOaGKOi+RlsG8sx8A5pmyglg
         4tB+P+TUoD0jXdjZ6g+6VvoaKQomCXZpHi7REI6QXIXbqmilHnJBt/JLglz7FM9J/lMJ
         wA796b8brgT8m6PhujFM0+kyEw5rIPwNvWRo1eCyaJGp3mW+f+zzvxFicda7yqNkoTxU
         PcFtYPahLH80oldFen1DMlR0vDRf7nQIQRG/e0MHAk7fXoTrGiYXGjLnSjJ2lCYjKqD5
         gzM3sUDwVnjruH+eL2/df4vzTCNDBhj7wCWfEctzHEmS3yZJluQXkMjwIu2bU1QUq04g
         GL+Q==
X-Gm-Message-State: AO0yUKVsr+TEDp2vRpzT8h7p8bZR0TpFIDT5skGS5HLgy8WCvKG9BBoP
        FcgpCncZfAdEvvOZ1COTRqyEyF5oM6siNRn2qwxSl/08Wmk3AVEpmFLP1c9j9qw5+eeN67w+Zv9
        F3qUFzTgnMyQXbW61nPHTUQGjN6i6KA==
X-Received: by 2002:a05:622a:100d:b0:3b9:b260:1e76 with SMTP id d13-20020a05622a100d00b003b9b2601e76mr1600335qte.1.1676632478723;
        Fri, 17 Feb 2023 03:14:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+8uzOSpW1cpKYb+uvihRbYVIJFTUowWidMaTVzImSrBl99cLyg0x5RBoagtKPioicS78k0Xw==
X-Received: by 2002:a05:622a:100d:b0:3b9:b260:1e76 with SMTP id d13-20020a05622a100d00b003b9b2601e76mr1600312qte.1.1676632478456;
        Fri, 17 Feb 2023 03:14:38 -0800 (PST)
Received: from debian (2a01cb058918ce00f383cbdd978c726b.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:f383:cbdd:978c:726b])
        by smtp.gmail.com with ESMTPSA id x68-20020a379547000000b0073b692623c5sm3020287qkd.129.2023.02.17.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:14:37 -0800 (PST)
Date:   Fri, 17 Feb 2023 12:14:34 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net v3] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y+9hmmAlHOo4yX9Q@debian>
References: <20230216163710.2508327-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216163710.2508327-1-syoshida@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 01:37:10AM +0900, Shigeru Yoshida wrote:
> @@ -840,8 +850,7 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
>  	}
>  	if (drop_refcnt)
>  		l2tp_session_dec_refcount(session);
> -	if (drop_tunnel)
> -		l2tp_tunnel_dec_refcount(tunnel);
> +	l2tp_tunnel_dec_refcount(tunnel);
>  	release_sock(sk);
>  
>  	return error;

The l2tp_tunnel_dec_refcount() call could be done after release_sock(),
to make the code more logical (as the refcount is now taken before
lock_sock()). Anyway, that shouldn't be a problem and I don't want to
delay this fix any longer.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

