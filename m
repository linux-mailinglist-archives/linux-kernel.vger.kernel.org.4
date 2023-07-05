Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6528C748226
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGEK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEK3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78853E57
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688552926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaRBNJkOnaaSRUUKURGngA0lO7NJcgI2BAIjJLAUBVs=;
        b=TURMPEmRCO+ZDGkw0uq+cf/7mctiKIyABcQg4SOOcBXdxsOUL3SWIM6IqtZCuMGG4cKE9r
        oRLSTLiq9kngTUxpct5h7TNLk9pw/zoUBY6w0yFfubyz8MXpsNgKfE9RIm9DliTAxyp7Xb
        94dMpZ2ty261LPbZnsKW3HImKNBWOyQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-usK3rNgmP7ykFCs2SJvEHQ-1; Wed, 05 Jul 2023 06:28:45 -0400
X-MC-Unique: usK3rNgmP7ykFCs2SJvEHQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-443510058b5so96933137.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552925; x=1691144925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaRBNJkOnaaSRUUKURGngA0lO7NJcgI2BAIjJLAUBVs=;
        b=ct6denMjwRWB7NZ9LVgJcF6XdLytjonvtRaowTBCsWaroePKaXm9xDfWgA71XvTe1q
         OzvNRWRWH5nuMwUyqXCoMTPXoITtTPWB9cQGrGof6yKH7EmP7MT4lCIgWBH+kAig+jYg
         VqAH1cqhyVypvpAseg+oP1aJ7slXoQBtjmJW4X2tgUh4lCEhJ8jrYrtfugqqAbUTfiiL
         7Q3dPaH5jjZWkmDY1j68puQVUyin9CYpBsqPMrh0sOqwjY5herlJQJZcqyl25JO774My
         S28IS1NNplksD1dPi5xHGa0XXdyNkXaW0FmyVhNG+p8Cu2Lz9fiNFhL1NM0c7j3lRKf3
         WUcA==
X-Gm-Message-State: ABy/qLYC9Qg4DfnxfDtsWLgMLRdHwQButTQ4iz3+M6gPg7IrKJSCQF5m
        3k/y6bq0YVtgp2YcEjGJOudzwYLu9kjgyj9iMGAp9LNkhDxWFo8MweReGwm3e16pPqZu0tQZ7Ma
        sAJ4s1RPvqjRm1Q4yivHJ/y2Y
X-Received: by 2002:a05:6102:1612:b0:443:58b5:ecbf with SMTP id cu18-20020a056102161200b0044358b5ecbfmr5739460vsb.0.1688552925089;
        Wed, 05 Jul 2023 03:28:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHrDJ+TfFusA3C/7TfnvROpll19p/QwWd+s6VUdXx2Bu0WCxdDZG9XQkvxflQGQ9I3YXyZ9SA==
X-Received: by 2002:a05:6102:1612:b0:443:58b5:ecbf with SMTP id cu18-20020a056102161200b0044358b5ecbfmr5739457vsb.0.1688552924795;
        Wed, 05 Jul 2023 03:28:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-75.dyn.eolo.it. [146.241.249.75])
        by smtp.gmail.com with ESMTPSA id e14-20020ad4418e000000b006363f2c37f0sm6665534qvp.91.2023.07.05.03.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:28:44 -0700 (PDT)
Message-ID: <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Jul 2023 12:28:40 +0200
In-Reply-To: <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
         <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
         <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
         <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
         <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
         <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
         <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
         <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
         <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
         <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
         <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
         <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
         <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
         <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
         <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
         <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
         <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
         <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
         <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
         <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
         <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
         <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
         <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
         <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
         <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
         <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
         <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
         <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> More stacktraces.. =3D)
>=20
> cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> [  411.413767] ------------[ cut here ]------------
> [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud	p.h:509
> udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
> net/ipv6/udp.c:787)

I'm really running out of ideas here...

This is:

	WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);

sort of hint skb being shared (skb->users > 1) while enqueued in
multiple places (bridge local input and br forward/flood to tun
device). I audited the bridge mc flooding code, and I could not find
how a shared skb could land into the local input path.

Anyway the other splats reported here and in later emails are
compatible with shared skbs.

The above leads to another bunch of questions:
* can you reproduce the issue after disabling 'rx-gro-list' on the
ingress device? (while keeping 'rx-udp-gro-forwarding' on).
* do you have by chance qdiscs on top of the VM tun devices?

The last patch I shared was buggy, as it attempts to unclone the skb
after already touching skb_shared_info.

Could you please replace such patch with the following?=20

Thanks!

Paolo
---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..0b0f4309506d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4261,6 +4261,17 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb=
,
=20
 	skb_push(skb, -skb_network_offset(skb) + offset);
=20
+	if (WARN_ON_ONCE(skb_shared(skb))) {
+		skb =3D skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			goto err_linearize;
+	}
+
+	/* later code will clear the gso area in the shared info */
+	err =3D skb_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list =3D NULL;
=20
 	while (list_skb) {

