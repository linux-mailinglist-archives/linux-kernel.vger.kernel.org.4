Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89473F893
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjF0JUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjF0JT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66064F5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687857551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBL/ONwUzr+ymBLvWZ1Y11d3T68bnTpzSD3KdNONaLc=;
        b=YustFy5ZKCuC+rbV1cigkgLqAZ/VDbgZJE+UBrusKU2jv23JUNKKYkI4jlCQ3R6cvCiSgX
        NfkQc0ix+Wir63OsndNj3dCeAFP6SaTP+M53VkVWE/+zOqeFKdnoE6vyE72m7wzNzdL8w2
        DQOUjqcS6fl1tAFJy5WAFUBHIsNoCms=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Q--aXHTwMd20ihkZPQ-MOQ-1; Tue, 27 Jun 2023 05:19:09 -0400
X-MC-Unique: Q--aXHTwMd20ihkZPQ-MOQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635df023844so3830646d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857549; x=1690449549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBL/ONwUzr+ymBLvWZ1Y11d3T68bnTpzSD3KdNONaLc=;
        b=NzYQp2w7IhIiw1m0g40TMJNBbJ6mlxqkC8T8PD7oKH/ksULVnVB3BG6NOkJ86JE5pN
         yWfsQ6Vd2ZZLJTLleBwOOFIk2eUEBxMtqaS1N3ZHNMMy04X43S/7EWBD6Gp+GdaixT5L
         hLr60I8qeyPE7Mjwo0a1CZvojVDgQ+l7Z3Oi6viMsyhPIQp95kuOVQYX8Mi8urnmEVw6
         VRm2XunxVrRSy6sop7hQWvYROE5hf7wHj5/yvWR5WoO1BIbLHBTUqebg7pxSvYb7k/vR
         GzOZLMXrPdKwSPaJiQS9Fb705XgsCC/EPgcvKIQM3PpmEbg5vmOayuvgNPODQ7KzRk73
         OY/Q==
X-Gm-Message-State: AC+VfDxiN3L2KgRdQV/mdnOtB8wQFyXt5f3K6IqFtSfdhWqt3I8NWmxT
        0omdb2WsueWuz6woVikgCU3QKw3+LRkp7Rp+FmevtCE7OlT2PFqqT+5byFFcnKO0B1v8ssia5iK
        yQ+lqiA05/rJ4mT6K8y1GbZQk
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr37647405qvb.2.1687857548926;
        Tue, 27 Jun 2023 02:19:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Mpr5BxSTiv/lGQNPYL079y7c7KMZMILIPd+bPX/Eb9M0+r627zUdyOvLZwRglkf/GIl0WJQ==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr37647399qvb.2.1687857548666;
        Tue, 27 Jun 2023 02:19:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id q15-20020ae9e40f000000b0075ed10554a5sm3758590qkc.11.2023.06.27.02.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:19:08 -0700 (PDT)
Message-ID: <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Jun 2023 11:19:05 +0200
In-Reply-To: <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-26 at 20:59 +0200, Ian Kumlien wrote:
> On Mon, Jun 26, 2023 at 8:20=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.co=
m> wrote:
> >=20
> > Nevermind, I think I found it, I will loop this thing until I have a
> > proper trace....
>=20
> Still some question marks, but much better

Thanks!
>=20
> cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> [   62.624003] BUG: kernel NULL pointer dereference, address: 00000000000=
000c0
> [   62.631083] #PF: supervisor read access in kernel mode
> [   62.636312] #PF: error_code(0x0000) - not-present page
> [   62.641541] PGD 0 P4D 0
> [   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #364
> [   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
> BIOS 1.7a 10/13/2022
> [   62.663344] RIP: 0010:__udp_gso_segment
> (./include/linux/skbuff.h:2858 ./include/linux/udp.h:23
> net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
> net/ipv4/udp_offload.c:277)

So it's faulting here:

static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs)
{
        struct sk_buff *seg;
        struct udphdr *uh, *uh2;
        struct iphdr *iph, *iph2;

        seg =3D segs;
        uh =3D udp_hdr(seg);
        iph =3D ip_hdr(seg);

        if ((udp_hdr(seg)->dest =3D=3D udp_hdr(seg->next)->dest) &&
        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The GSO segment has been assembled by skb_gro_receive_list()
I guess seg->next is NULL, which is somewhat unexpected as
napi_gro_complete() clears the gso_size when sending up the stack a
single frame.

On the flip side, AFAICS, nothing prevents the stack from changing the
aggregated packet layout (e.g. pulling data and/or linearizing the
skb).

In any case this looks more related to rx-gro-list then rx-udp-gro-
forwarding. I understand you have both feature enabled in your env?

Side questions: do you have any non trivial nf/br filter rule?

The following could possibly validate the above and avoid the issue,
but it's a bit papering over it. Could you please try it in your env?

Thanks!

Paolo
---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..75531686bfdf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4319,6 +4319,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
=20
 	skb->prev =3D tail;
=20
+	if (WARN_ON_ONCE(!skb->next))
+		goto err_linearize;
+
 	if (skb_needs_linearize(skb, features) &&
 	    __skb_linearize(skb))
 		goto err_linearize;

