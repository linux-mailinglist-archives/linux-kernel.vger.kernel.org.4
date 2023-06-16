Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821E47325DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjFPDcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjFPDb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:31:57 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F29213B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:31:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39cf00a2ad2so290719b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686886290; x=1689478290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnVRVEex7zv96gP6Vvvr955VJfIGHw0Z5yBXSHEzL9Y=;
        b=USQ7+vYBVyVXupzKlH4ARI7VEYpIak1CEUzK/eNJwX3kaZ23Wv6FaHQWUT9bfKSM2q
         Xo+8H2Ni4LvHVaqJi3nZELFHPCnRlHUEmPN3bGQyF3JgWU1GBgzhV1cPohpAuovFlX+r
         F+vSlW6RbFXYBHg3TrnYOlxOSU/I/ju70VJPWH56IblpWXr7yHYs0t5Rc1YntOFAX03Z
         mF7ths37qrT/YbJwh3F56fjIvyR9O68/ionTyl5lD/KvrufaM6BErU0zGu2cJiOv+Zye
         UzJG2FqcFJMGm6ud8usoK+G51Xf5084F1lkhxfW9NOFyMePOxzroze36oocAzHx4KH3g
         tOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686886290; x=1689478290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnVRVEex7zv96gP6Vvvr955VJfIGHw0Z5yBXSHEzL9Y=;
        b=IcbCfexuNeUm0wQbUP47t4yPL2QYHpvymWYoyKx8KWn89vF3JEazHNraqnA3k7RvtL
         047B/px+d2enuqlvrrfxPHpC8DIq/Nu200y//WQxnCPelaCgz2mXG9nR8e1JJEddnNIr
         cOE92Gwv5JWEsw+B4J3kzZ4r1B9vh3gmfidghVk3DZYJBzccF892235g47JK4Lz2+xTB
         k5KTaDJzUMAn4mv8XgAZBk5gTyoFW0yOrxyXsBnVPcTqBcqnducohIrTYZH9mHrVmg83
         KDcJ7KndFiRd3eU0LjdQ1dpDat+KxsLnp75DypfrKqkA8aVmbeZRMwTSi3GN0ln25vgR
         MItg==
X-Gm-Message-State: AC+VfDx7bF90AYkMFHDR0m5t0QmQL7qQwY+wy9p/Zm/ZkG0oqE4aqN6h
        /eIvRScj0Vd7/OqAHMqQi/7t4Pb9QEIvbmcETNMQIg==
X-Google-Smtp-Source: ACHHUZ5lTiATGTCHFxAVboCkbg2byvFYf5+kw7yI4S0FGUFwwSonU4oseJqQzzGOcZpRpMnwYQUh+Pv0eVOL03QFZH0=
X-Received: by 2002:aca:c45:0:b0:39b:d6f1:36e5 with SMTP id
 i5-20020aca0c45000000b0039bd6f136e5mr1000182oiy.50.1686886290150; Thu, 15 Jun
 2023 20:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz> <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
 <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz> <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
 <ZIsR09IkLquV72dj@dhcp22.suse.cz> <CACSyD1P19kxERKPUAVChjy7AzV6h6RKTV8252ntoK5EUy8uC2A@mail.gmail.com>
 <ZIseQdSx9GAiyYDm@dhcp22.suse.cz>
In-Reply-To: <ZIseQdSx9GAiyYDm@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 16 Jun 2023 11:31:18 +0800
Message-ID: <CACSyD1OA1kzD5tyJW7=uTj0V-uk8PmHKmU8XE8zTtK_eXEkG7Q@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:21=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 15-06-23 22:13:09, =E8=B4=BA=E4=B8=AD=E5=9D=A4 wrote:
> > > This is not really answering my question though. memcg under hard lim=
it
> > > is not really my concern. This is a simpler case. I am not saying it
> > > doesn't need to get addresses but it is the memcg hard limited case t=
hat
> > > is much more interested. Because your charges are going to fail very
> > > likely and that would mean that swapout would fail AFAIU. If my
> > > understanding is wrong then it would really help to describe that cas=
e
> > > much more in the changelog.
> > >
> >
> > OK, Got it. In many cases I have tested, it  will not fail because we d=
id
> > not charge the page directly=EF=BC=8Cbut the objects(like  slab,compres=
sed page),
> > for the zspage may be shared by any memcg.
>
> That sounds like a broken design to me.
> --
> Michal Hocko
> SUSE Labs

I will try more cases in different compression ratios and make sure
that swapout will not fail.
