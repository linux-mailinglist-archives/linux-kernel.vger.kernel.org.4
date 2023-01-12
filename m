Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415FE667293
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjALMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjALMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1248C13E02
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673527742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rno5HiyRqGhwFsXWgj2wBj/GKHwQLrsWjfu68P1ONBY=;
        b=Hb2/bADFQza7jJ7sR1hSqVKySsfoX2373x6w8IA8i/aOuV5Vabr9Mfla4GiCr5uSccAYMt
        ZCMDua5w5q3ugCeSkCHcjzQOlDhBSR7VmLribZQ9BH6aIwfmeyjoYopjXPZMtHozkPeqyY
        KlDkwmSaCwOxZ48hhHJRXmPxnwc7MCg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-Cr2Ni5cSO5mgXfCj_BSGXQ-1; Thu, 12 Jan 2023 07:48:55 -0500
X-MC-Unique: Cr2Ni5cSO5mgXfCj_BSGXQ-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so12910314qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rno5HiyRqGhwFsXWgj2wBj/GKHwQLrsWjfu68P1ONBY=;
        b=eaqKGVynWkTcFCJBHRN0uoUdCbVm1m3Y7HNXUL+oEi+1s4gzmPEBWjjrU+ZfRPaUs0
         OHcQPGMij4+19S1hlc6SVL9MPe7/dqdTJCqhlOmNK2Lokfk9WoALIZQHC4gJ5abzEgLY
         YkqzRjgIpfUbXKaIEH0NDOJXaHmh8kAeUyHfo0nZSZQrgTIV3ZQcZrIXHCSuKzvjUF/E
         GG3fdYLo9WGDEXI0JIzJh6IOlei+nA4CVTK3s4JK9PHFVhldR/ZpA2M2MMRRSJ6ji+LT
         7L47EkA4LU1EJXaYJp6oTJBN7SeRKlrot5K5MzxYZOm3/JG+DySbHCoe8YdF+dT/DnSQ
         qdwA==
X-Gm-Message-State: AFqh2kq8OjZ2BUZ88gopBPKlAWHbahNfUXyY7xDjsptnpiaOe/aU95om
        ULnF/8YwsHcQkCsrcgy/FoAc2+0/eVxy1DV+Fhcyua92Gk86pYX3var6x2NMNR97qcQbquH3U/X
        spHDR6IEjATNhNLdMR85d6+/5
X-Received: by 2002:ac8:4a03:0:b0:3a8:47e:3683 with SMTP id x3-20020ac84a03000000b003a8047e3683mr14682287qtq.56.1673527735183;
        Thu, 12 Jan 2023 04:48:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZS+6LYv70XNzuRBfKgSLfWrQlwLKIKlXW0YPfUujmfHY9koyjEYeg2PCxt45t5GG9QxZ0Cw==
X-Received: by 2002:ac8:4a03:0:b0:3a8:47e:3683 with SMTP id x3-20020ac84a03000000b003a8047e3683mr14682265qtq.56.1673527734914;
        Thu, 12 Jan 2023 04:48:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-183.dyn.eolo.it. [146.241.113.183])
        by smtp.gmail.com with ESMTPSA id e7-20020ac80647000000b003a69225c2cdsm9028818qth.56.2023.01.12.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:48:54 -0800 (PST)
Message-ID: <fa5895ae62e0f9c1eb8f662295ca920d1da7e88f.camel@redhat.com>
Subject: Re: [PATCH net 2/2] net/af_packet: fix tx skb network header on
 SOCK_RAW sockets over VLAN device
From:   Paolo Abeni <pabeni@redhat.com>
To:     =?ISO-8859-1?Q?Herv=E9?= Boisse <admin@netgeek.ovh>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Jan 2023 13:48:51 +0100
In-Reply-To: <20230110191725.22675-2-admin@netgeek.ovh>
References: <20230110191725.22675-1-admin@netgeek.ovh>
         <20230110191725.22675-2-admin@netgeek.ovh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2023-01-10 at 20:17 +0100, Hervé Boisse wrote:
> When an application sends a packet on a SOCK_RAW socket over a VLAN device,
> there is a possibility that the skb network header is incorrectly set.
> 
> The issue happens when the device used to send the packet is a VLAN device
> whose underlying device has no VLAN tx hardware offloading support.
> In that case, the VLAN driver reports a LL header size increased by 4 bytes
> to take into account the tag that will be added in software.
> 
> However, the socket user has no clue about that and still provides a normal
> LL header without tag.
> This results in the network header of the skb being shifted 4 bytes too far
> in the packet. This shift makes tc classifiers fail as they point to
> incorrect data.

I'm unsure I read correctly the use case: teh user-space application is
providing an L2 header and is expecting the Linux stack to add a vlan
tag? Or the linux application is sending packets on top of a vlan
device and desire no tag on the egress packet? or something else?

(Note: I think that in the fisrt 2 cases above the fix belong to the
user-space application).

Thanks!

Paolo

