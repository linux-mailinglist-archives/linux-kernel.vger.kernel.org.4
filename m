Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7969DB52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjBUHjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjBUHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB01A8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676965102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpylCVDeNKOcCz8TxW56ldOgYHn+p48CYKA2OyhXRpE=;
        b=KHTUnrCMfjrSLx+f7AbjAJ46nwt/9U2+Brcd7IYyRRC1AuGWTfUYeXEKsdtcYK9AUsWCkf
        1m6zp63cWo81pc//d2Lt74zHwRMB9Rk7mGr+30E4UnOwr9IHNEJ9X9u+Z+8gWgfG/HIWtO
        teOg7hMiVjpsDWf7H+1D++67jxfoytw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-xNi3ujvAMoSl9ThppGYgWA-1; Tue, 21 Feb 2023 02:38:21 -0500
X-MC-Unique: xNi3ujvAMoSl9ThppGYgWA-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003e2249bd2b4so1738628wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676965099;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpylCVDeNKOcCz8TxW56ldOgYHn+p48CYKA2OyhXRpE=;
        b=qqbA8b+b57fq28GAgZpwqnfMJ3tch5ZKhbkXqn0mU0M0fzYq4NajWJ1s+qRMnwKidn
         rRQdoBWxxbqIa3BKQ1bf4Ol0BeQh8YHdPyOlQFnjFhFOImj5gJZ3v2eHAZARAdfbDYRB
         gFogsXAoi65L3f9SPZEwCg3LMofUH8Yuvsgz5TNlPPTjezZbzd+gL6iXKoskzy9fclAE
         JpP5UQyvkRcMLIqg4a3AmPhmhCdvimDyol4epWeHwSkJ8utgEDtiCDjAdc6wsxxV0zEn
         xxcbfkSo7E4FqEXuXGHeJWwLNtvQeFdgMdVFMRJ4+4IDG5lsQzW/IHDjt+702SDwiT+6
         LoTA==
X-Gm-Message-State: AO0yUKUp1kSsItrTOLao17JvJXMZ7nlANUJW0ZckNN+RI/T6dF1w7yw3
        1dOnXCqj/s5DRFeFAARk5rsr55cWjrNXUOF3jdBIcmQfW0kAW5YU5QEenUH11l7SgSGGgUzZC3s
        v83DRJ9DFWzNAFfoa6jBeO3C9C1ZHpQ==
X-Received: by 2002:a05:600c:4591:b0:3db:35e3:baf6 with SMTP id r17-20020a05600c459100b003db35e3baf6mr3333612wmo.4.1676965099747;
        Mon, 20 Feb 2023 23:38:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+OeCfEd82E845XPOg445Odd8FoAY4S13GDODN8WerLIxNfyXG1a91+w6YEnXSejF/jhKkghA==
X-Received: by 2002:a05:600c:4591:b0:3db:35e3:baf6 with SMTP id r17-20020a05600c459100b003db35e3baf6mr3333605wmo.4.1676965099424;
        Mon, 20 Feb 2023 23:38:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b002c559405a1csm5027360wrq.20.2023.02.20.23.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 23:38:18 -0800 (PST)
Message-ID: <05e7f7bb8573a32d81e09fbb5744d77d01292d51.camel@redhat.com>
Subject: Re: [PATCH net-next v3 2/5] vxlan: Expose helper vxlan_build_gbp_hdr
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>
Cc:     Gavin Li <gavinl@nvidia.com>, davem@davemloft.net,
        edumazet@google.com, roopa@nvidia.com,
        eng.alaamohamedsoliman.am@gmail.com, bigeasy@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gavi@nvidia.com, roid@nvidia.com, maord@nvidia.com,
        saeedm@nvidia.com
Date:   Tue, 21 Feb 2023 08:38:17 +0100
In-Reply-To: <20230220123021.448dc1a0@kernel.org>
References: <20230217033925.160195-1-gavinl@nvidia.com>
         <20230217033925.160195-3-gavinl@nvidia.com> <Y/KHWxQWqyFbmi9Y@corigine.com>
         <b0f07723-893a-5158-2a95-6570d3a0481c@nvidia.com>
         <Y/MV1JFn4NuptO9q@corigine.com>
         <c8fcebb5-4eba-71c8-e20c-cd7afd7e0d98@nvidia.com>
         <Y/NMH2QRKoUpdNef@corigine.com> <20230220123021.448dc1a0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-20 at 12:30 -0800, Jakub Kicinski wrote:
> On Mon, 20 Feb 2023 11:31:59 +0100 Simon Horman wrote:
> > On Mon, Feb 20, 2023 at 03:15:20PM +0800, Gavin Li wrote:
> > > > Right. But what I was really wondering is if the definition
> > > > of the function could stay in drivers/net/vxlan/vxlan_core.c,
> > > > without being static. And have a declaration in include/net/vxlan.h=
 =20
> > >=20
> > > Tried that the first time the function was called by driver code. It =
would
> > > introduce dependency in linking between the driver and the kernel mod=
ule.
> > >=20
> > > Do you think it's OK to have such dependency? =20
> >=20
> > IMHO, yes. But others may feel differently.
> >=20
> > I do wonder if any performance overhead of a non-inline function
> > also needs to be considered.
>=20
> Do you recall any details of why Hannes broke the dependency in the
> first place?

IIRC it was that was a cleanup thing, so that setup not using vxlan
does not load the module (and the related deps chain) for no reasons.

Cheers,

Paolo

> Commit b7aade15485a ("vxlan: break dependency with netdev drivers")
> Maybe we should stick to the static inline, it doesn't look too
> large/terrible?

IMHO static inline is good enough here.

Thanks,

Paolo

