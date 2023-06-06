Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CE724BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbjFFS6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbjFFS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024995
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686077835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31JVF3l6gUDbROIl4YxBKRo91pCNMIATPATdnGp3EPo=;
        b=UZqXYyWEHDklJ0UWitqrK4ExKxdyUTwPtfTs4PqYORbtJDmUQ+Apu4O4eYHoel4RqSgwYi
        KVZijhcV6PxqlXP4cFmAOZyqbDwFTsvuDIGvNjus8dprNh1+MKbHwQEWh6dIlm/wqcmlIE
        /QYgCh2gkpL/kZOpW/DvjGEJujVp75s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-eNOoZgucM2ywRWZDnKFomg-1; Tue, 06 Jun 2023 14:57:12 -0400
X-MC-Unique: eNOoZgucM2ywRWZDnKFomg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so31637185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077831; x=1688669831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31JVF3l6gUDbROIl4YxBKRo91pCNMIATPATdnGp3EPo=;
        b=b8hPH04FP4krlLWv8CG57wbHTaLGoJrN6cyqWWPLx3x+Zrd9zuoQrNmJlwW0mZlTgB
         HoF/mDlYxMNh56zf6utrMgcvNVLnH+34sngHueO+ODiq1flMb7Yd5MPjVndswrDYMKlI
         ht6j1ffUXmZIVBOTagRTHGFDAakSE6S9F9QX0UrqJbNfLP18HVfLswGn+2AylJUr2tle
         Bz0Ybw1xh1sd58PLz76XoD6fOrZFeKjxAb44Jovmt4J5B9Osv2N35CGTSPMYY7iMfKdJ
         rY3HZUGbF0zZMbRVJfWf7ge22lZSmrF+PQaxMkoYBUc1J/HoOSi5Mcn1f+YAVkUqSRJR
         ov5Q==
X-Gm-Message-State: AC+VfDwCt2p4wC2lprA6K8OVrYfelUI1j02/gE+5/re6oRHL/W5oUuGJ
        0R4HfGbmkp7HSVGvTdynCtbfgRlPYfRcswmpbXASNcGhIy933LULq8y8dH7uLFosDVA3qh45D/q
        pmiuV1FUu6GpJo1Uc6th3p7s0
X-Received: by 2002:a7b:c858:0:b0:3f7:3991:e128 with SMTP id c24-20020a7bc858000000b003f73991e128mr2707039wml.2.1686077831251;
        Tue, 06 Jun 2023 11:57:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61P0R8sqac5ijSKL835rH/AuF3V6x11y/N9t9GsB91bZ5m/eBP7wH0Dj0CykwQ9ZrpciOtVQ==
X-Received: by 2002:a7b:c858:0:b0:3f7:3991:e128 with SMTP id c24-20020a7bc858000000b003f73991e128mr2707034wml.2.1686077830994;
        Tue, 06 Jun 2023 11:57:10 -0700 (PDT)
Received: from debian (2a01cb058d652b00fa0f162c47a2f35b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:fa0f:162c:47a2:f35b])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b003f7ead9be7fsm2685045wmk.38.2023.06.06.11.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:57:10 -0700 (PDT)
Date:   Tue, 6 Jun 2023 20:57:08 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL][FIX TESTED] in
 vrf "bind - ns-B IPv6 LLA" test
Message-ID: <ZH+BhFzvJkWyjBE0@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
 <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
 <ZH84zGEODT97TEXG@debian>
 <48cfd903-ad2f-7da7-e5a6-a22392dc8650@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48cfd903-ad2f-7da7-e5a6-a22392dc8650@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:07:36PM +0200, Mirsad Goran Todorovac wrote:
> On 6/6/23 15:46, Guillaume Nault wrote:
> > diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> > index c4835dbdfcff..f804c11e2146 100644
> > --- a/net/ipv6/ping.c
> > +++ b/net/ipv6/ping.c
> > @@ -114,7 +114,8 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >   	addr_type = ipv6_addr_type(daddr);
> >   	if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
> >   	    (addr_type & IPV6_ADDR_MAPPED) ||
> > -	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
> > +	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
> > +	     l3mdev_master_ifindex_by_index(sock_net(sk), oif) != sk->sk_bound_dev_if))
> >   		return -EINVAL;
> >   	ipcm6_init_sk(&ipc6, np);
> 
> The problem appears to be fixed:
> 
> # ./fcnal-test.sh
> [...]
> TEST: ping out, vrf device+address bind - ns-B loopback IPv6                  [ OK ]
> TEST: ping out, vrf device+address bind - ns-B IPv6 LLA                       [ OK ]
> TEST: ping in - ns-A IPv6                                                     [ OK ]
> [...]
> Tests passed: 888
> Tests failed:   0
> #
> 
> The test passed in both environments that manifested the bug.
> 
> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Thanks. I'll review and post this patch (probably tomorrow).

> However, test on my AMD Ubuntu 22.04 box with 6.4-rc5 commit a4d7d7011219
> has shown additional four failed tests:
> 
> root@host # grep -n FAIL ../fcnal-test-4.log
> 90:TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> 92:TEST: ping local, device bind - ns-A IP                                       [FAIL]
> 116:TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> 118:TEST: ping local, device bind - ns-A IP                                       [FAIL]
> root@host #
> 
> But you would probably want me to file a separate bug report?

Are these new failures? Do they also happen on the -net tree?

> Best regards,
> Mirsad
> 

