Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6B72456A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbjFFOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjFFOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288AB18B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686060695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fw9T5rxLrJVKHG27fIjocIY1CyjQERL7+8LiZXQNd7E=;
        b=cH+eePk+jvy7j7r8m7h1wPjxs+DQjy1WVBuRMP34qraEfF07DqO9XnXMcyB1R3htvkLy3Y
        aXCJfZp5LjDjwAdB/tyyiPQPwfxczT+M0awhLczGvi7rOYawo9IVlalzRLX2RpBmEoJuZ7
        GWyNrQFD2X7jMWvKfNHgC1sEpWta3Go=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Q8hJf9zUNz-q1bFRcMLBwg-1; Tue, 06 Jun 2023 10:11:29 -0400
X-MC-Unique: Q8hJf9zUNz-q1bFRcMLBwg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f6f58e269eso34551465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060686; x=1688652686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw9T5rxLrJVKHG27fIjocIY1CyjQERL7+8LiZXQNd7E=;
        b=KBy0G5Kzhvk1YJ1It9DpLpavBjhjVitU28mMEKlw18Prxc3PujJww5maC/zz1uaUgP
         CHRm4yT6MJmFyFFHQIRK0wZ57YNz0HLNqwJwJujYqxHtACKScSfRibI+cKkQuwICG2ec
         1lliEgKp0TgvchamSSMcG69We11su9OFCiijD78qgo6llfOSk9xgrN2bwPQxB7HAIHGk
         YBMBxIi0hJ2S200SmQfl2RDgW+I6p3iop2/Nq6abfoKBM3mSojRs55rqAXAJ3uC6dCsm
         krPZy3rMLt8gt03xLX1APDkPEKuBggrVrgOs9MiqSqPTU6JcWjpyDdqrfZTzXUlCs7Y2
         KHAQ==
X-Gm-Message-State: AC+VfDyzkquBiW6jU2aSeSeEnJj1L4783ZNoH6BToGZzoLajx61L0uty
        9861++3fGU/WbOIHKcM2MdovujwX5WePUOR2i4eHLaR6W6RTHAbSJqF7JwEonPMB3/p85PSUG0t
        cLrTYdtOtos+wEarrzw3Xv9oI
X-Received: by 2002:a1c:7912:0:b0:3f7:33cf:7080 with SMTP id l18-20020a1c7912000000b003f733cf7080mr2254965wme.36.1686060686554;
        Tue, 06 Jun 2023 07:11:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wOLgLIb3XMmyPMrwryL9a1f6reu3dJklYXOBS8ZHG+qjkBneUwt1XyrlPOPxqX+dpQ7I6Tw==
X-Received: by 2002:a1c:7912:0:b0:3f7:33cf:7080 with SMTP id l18-20020a1c7912000000b003f733cf7080mr2254940wme.36.1686060686230;
        Tue, 06 Jun 2023 07:11:26 -0700 (PDT)
Received: from debian (2a01cb058d652b00fa0f162c47a2f35b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:fa0f:162c:47a2:f35b])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f736735424sm9067513wme.43.2023.06.06.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:11:25 -0700 (PDT)
Date:   Tue, 6 Jun 2023 16:11:24 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL] in vrf "bind -
 ns-B IPv6 LLA" test
Message-ID: <ZH8+jLjottBw2zuD@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
 <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
 <ZH84zGEODT97TEXG@debian>
 <60f78eaa-ace7-c27d-8e45-4777ecf3faa2@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60f78eaa-ace7-c27d-8e45-4777ecf3faa2@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:57:35PM +0200, Mirsad Todorovac wrote:
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index c4835dbdfcff..c1d81c49b775 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -73,6 +73,10 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         struct rt6_info *rt;
>         struct pingfakehdr pfh;
>         struct ipcm6_cookie ipc6;
> +       struct net *net = sock_net(sk);
> +       struct net_device *dev = NULL;
> +       struct net_device *mdev = NULL;
> +       struct net_device *bdev = NULL;
> 
>         err = ping_common_sendmsg(AF_INET6, msg, len, &user_icmph,
>                                   sizeof(user_icmph));
> @@ -111,10 +115,26 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>         else if (!oif)
>                 oif = np->ucast_oif;
> 
> +       if (oif) {
> +               rcu_read_lock();
> +               dev = dev_get_by_index_rcu(net, oif);
> +               rcu_read_unlock();

You can't assume '*dev' is still valid after rcu_read_unlock() unless
you hold a reference on it.

> +               rtnl_lock();
> +               mdev = netdev_master_upper_dev_get(dev);
> +               rtnl_unlock();

Because of that, 'dev' might have already disappeared at the time
netdev_master_upper_dev_get() is called. So it may dereference an
invalid pointer here.

> +       }
> +
> +       if (sk->sk_bound_dev_if) {
> +               rcu_read_lock();
> +               bdev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
> +               rcu_read_unlock();
> +       }
> +
>         addr_type = ipv6_addr_type(daddr);
>         if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
>             (addr_type & IPV6_ADDR_MAPPED) ||
> -           (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
> +           (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
> +                   !(mdev && sk->sk_bound_dev_if && bdev && mdev == bdev)))
>                 return -EINVAL;
> 
>         ipcm6_init_sk(&ipc6, np);
> 
> However, this works by the test (888 passed) but your two liner is obviously
> better :-)

:)

> Best regards,
> Mirsad
> 
> -- 
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu
> 
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> 

