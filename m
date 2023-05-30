Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F58715BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjE3Kah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjE3KaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D71716
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685442509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9maJC3tkWXrOh5gynTfOn7BcjZTymBhWFjWHqIetvJk=;
        b=VVz0NNB6LOIuQ5IV8/PuIez1JtmDSFdkEwzrFaZisr+wEN3pEAHLzaKeLWAB7rTp9iKRag
        H77ZPJbfwW1zPlFQSihDNyqXE+p5GiOjfndl3hEn85arfIVBYDMMtnDf3UGgqCmXPF6amI
        +0JkHAylQZMm47zvQbOLb1HJtCzFNcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ziKl8k9JODW_vN0fbcE-Zg-1; Tue, 30 May 2023 06:28:28 -0400
X-MC-Unique: ziKl8k9JODW_vN0fbcE-Zg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f60eee2aacso5683595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442507; x=1688034507;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9maJC3tkWXrOh5gynTfOn7BcjZTymBhWFjWHqIetvJk=;
        b=VECTVLiVs+fd4lfL38au48DEeScwPrtSeQNTBr9IxVqdKBJbt1NxM2776DgnNU0Z8U
         PzsA8HbKTh/Gd1RcsmbITRnVdRk8mu7fcU2AGLOXEzB2b5q4GxIG3PUwU10rK0jRU81u
         tNhKciq3U9A4VH0IkBwqDa9gn2mSXORE1zoPBoDsq5KO3FR0rIxYnMxsRkgiCYH7f//h
         Hw+G/ZMxj2Tn04uIHIrPo/NPZiswQekmUClpnxJk7U7OjklHdaNfJiplcWhshjjQwCAt
         hfscWTfQzZk5JiEvXunOsJ3by9SptlYk594TXcXCxL4wJusp+8QSYag+tXd8qPRYy79S
         lQiA==
X-Gm-Message-State: AC+VfDxt68lFBetQIjFppp6hPEOA+a09aI59cqnm8LRmBlXXTZ7CeqeV
        eSnvrnsSKgmhltKKEegFqiCI5RFsMLnpu7BfEj5dyO9/FdVklSA9FJxtc/SviXsGVloD4HF+o0Y
        o6VvF4GkI0JufCqm3ZybrbKJdSPNLrSp7
X-Received: by 2002:adf:f3c5:0:b0:30a:e55c:1e8e with SMTP id g5-20020adff3c5000000b0030ae55c1e8emr996978wrp.2.1685442507039;
        Tue, 30 May 2023 03:28:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6n+HAg5Xabix7rRTJdxhFbnQ8iNRWdeQ9OI2ATI2A/DhevyHWXMGhE3jF6Bdq/Wy6NKILorw==
X-Received: by 2002:adf:f3c5:0:b0:30a:e55c:1e8e with SMTP id g5-20020adff3c5000000b0030ae55c1e8emr996963wrp.2.1685442506729;
        Tue, 30 May 2023 03:28:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-248-97.dyn.eolo.it. [146.241.248.97])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b0030ae09c5efdsm2843808wrc.42.2023.05.30.03.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:28:26 -0700 (PDT)
Message-ID: <0ab4f3ea2bd97c7067ed332c0128829f4a7ea596.camel@redhat.com>
Subject: Re: [PATCH] net: skbuff: fix missing a __noreturn annotation warning
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>, linmiaohe@huawei.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Tue, 30 May 2023 12:28:25 +0200
In-Reply-To: <20230527040038.6783-1-kuniyu@amazon.com>
References: <20230527110409.497408-1-linmiaohe@huawei.com>
         <20230527040038.6783-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-26 at 21:00 -0700, Kuniyuki Iwashima wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> Date: Sat, 27 May 2023 19:04:09 +0800
> > Add __noreturn annotation to fix the warning:
> >  net/core/skbuff.o: warning: objtool: skb_push+0x3c: skb_panic() is mis=
sing a __noreturn annotation
> >  net/core/skbuff.o: warning: objtool: skb_put+0x4e: skb_panic() is miss=
ing a __noreturn annotation
>=20
> What arch are you using ?
>=20
> IIUC, BUG() should have an annotation for objtool, for
> example, __builtin_unreachable() for x86.
>=20
> Maybe the arch is missing such an annotation ?
>=20
> Also I'm curious why objtool complains about only skb_push(),
> there should be more non-inline functions that has BUG().

AFAICS, the BUG() macro implementation should already carry the
__noreturn annotation, via panic() or other arch-specific way.

This looks like the old toolchain not being able to
successfully/correctly propagate the annotation???

I think we can drop this patch.

Cheers,

Paolo

