Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3C7045CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEPHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjEPHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C65A10FE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684220860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2/jG0CqRWsSGJSAoe82IzilNICtj9ZU3hzw25K3C5M=;
        b=awuDaejYQqlJuNclBuQBafC/PECmaWGXr3mFxdzdnyzq87XRADDyBB1ixIVlVu05T3jcH+
        +yM+vhgAwmvj47pnWlubJTzNXXWyEYIctk2n7UNlX5ztp5b/0TB30l+aVg4333R1Flb1Fz
        Ov/XlVVn6YmWhdGaGFjvIIKg5cLgrVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-KorgASyZPnCdiS7Wl_h2OA-1; Tue, 16 May 2023 03:07:39 -0400
X-MC-Unique: KorgASyZPnCdiS7Wl_h2OA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f08900caadso17374675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684220857; x=1686812857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2/jG0CqRWsSGJSAoe82IzilNICtj9ZU3hzw25K3C5M=;
        b=WDoPBqZguwIuotUQx/Lbzx4qtoNCcnuIQ0x/uLNEShaQ+Fp1rR84rk5j3bfe8zj6RS
         IPnEa1BGLwgpJtmAF6LzbBtoryN+/hfjlV594j9EanxU0SQL3zvWhiNW/rvrJ6j0sqVp
         7PTYZarDBvTGOSqeBukJsdBe9yJ/1C4zPvxrVvEaBqxnlnzBTMfUydyOVcsYdEDjXH3y
         FeTTLvqoEtQgPahtVl/IkX1HCc1uvXuGv5Cl7ks6xnkwvZmT7IHxEN95Q/t1wUS8fbb6
         PkSaEgs5Z0rjvPu6SnmhukH7J0VYDzwOLv0ZtElzi24pcBCZreAzsKkAfGGBf2MvDRxT
         pKbg==
X-Gm-Message-State: AC+VfDxRGiFXJLvjT6PAStOu24ELRqqbot+Rz2RzY0QVI/nwLGnnMGwf
        C0rytXhGSTacInGywK0bli+VBgq3rMs6MFKAZ0iriR+xxo4OBh8C9Yr1WhcV0kgx5r+gVYAd7QW
        w7RKK1C1InA05h/FYOUr8ZmpHqWX5uJmM
X-Received: by 2002:a05:600c:1d13:b0:3f4:27ec:9d12 with SMTP id l19-20020a05600c1d1300b003f427ec9d12mr1316208wms.4.1684220857697;
        Tue, 16 May 2023 00:07:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pk2rHz8r6RepJeoG4HzSBnLlCjskbfrF7eE6Y3yskyh3sRkXTMsQUzTryzgWvSTQlNX4yWQ==
X-Received: by 2002:a05:600c:1d13:b0:3f4:27ec:9d12 with SMTP id l19-20020a05600c1d1300b003f427ec9d12mr1316176wms.4.1684220857315;
        Tue, 16 May 2023 00:07:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-74.dyn.eolo.it. [146.241.225.74])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003f0ad8d1c69sm1220209wmg.25.2023.05.16.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:07:36 -0700 (PDT)
Message-ID: <ff3c537ada67e27823d7605686ef0b5c05c13ab5.camel@redhat.com>
Subject: Re: [PATCH net-next 2/7] net: lan966x: Add support for offloading
 pcp table
From:   Paolo Abeni <pabeni@redhat.com>
To:     Piotr Raczynski <piotr.raczynski@intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        UNGLinuxDriver@microchip.com
Date:   Tue, 16 May 2023 09:07:35 +0200
In-Reply-To: <ZGIGkZDW84tHr04f@nimitz>
References: <20230514201029.1867738-1-horatiu.vultur@microchip.com>
         <20230514201029.1867738-3-horatiu.vultur@microchip.com>
         <ZGIGkZDW84tHr04f@nimitz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-15 at 12:16 +0200, Piotr Raczynski wrote:
> On Sun, May 14, 2023 at 10:10:24PM +0200, Horatiu Vultur wrote:

[...]

> > +static int lan966x_dcb_ieee_setapp(struct net_device *dev, struct dcb_=
app *app)
> > +{
> > +	struct dcb_app app_itr;
> > +	int err;
> > +	u8 prio;
> > +
> > +	err =3D lan966x_dcb_app_validate(dev, app);
> > +	if (err)
> > +		goto out;
> > +
> > +	/* Delete current mapping, if it exists */
> > +	prio =3D dcb_getapp(dev, app);
> > +	if (prio) {
> > +		app_itr =3D *app;
> > +		app_itr .priority =3D prio;
> Compiles OK, still looks little weird :).

Since it looks like a v2 is required to update later patches, please
additionally remove the unneeded whitespace above:

		app_itr.priority =3D prio;

Thanks!

Paolo

