Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504E72B8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjFLHmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjFLHlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830241FD2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686555510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4o6iBs/cGUwezMGSZngT4KvoAhZmnl7dmMW6aK8mMXs=;
        b=bKPpWLypcHWNCkmoEUl1RR70XIvx2GUWwDQvvw1LHmKoGHU+U/gui6hxQqTgoL8GyYuwqv
        mv5zWyaFMXlSJVXtJDyRsP9OQuuq5/0331W5MdVvt75G6Dh6ve3q0CwuW/hzJRtCXRIhsi
        E2C6CJ/12kICCGuPodG3Jabv0MoXb9M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-aGansqPmNjSIEgn5_2uehQ-1; Mon, 12 Jun 2023 03:25:16 -0400
X-MC-Unique: aGansqPmNjSIEgn5_2uehQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75ec91f26c8so86316285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686554716; x=1689146716;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4o6iBs/cGUwezMGSZngT4KvoAhZmnl7dmMW6aK8mMXs=;
        b=P9fJfv07vLZzuKVplJQonxoABwp0R6IBotudigv6E5pohttcjsf0rORklsj8Hz/M5h
         68aipALNDF/aVCSwK0kSYtnEs2pRp6uj9oB9+F9FGhkWJQOghYrYgKjmAydJARINXH8l
         BkFz46GZFKieDgEsYWrgibk+Appp0ufsnzsYy7iqWJRPdSn3dZzV7IhmBtRs8MX252fh
         aAgOiJjr5q+fUzhn4LOboGl21Xrdve8+oSihu9gSThdW8ppVqu4h6ODcAW8e28emmWJd
         zgr1Jk6d4jnBOFLw/fzKCV2NJVcrCXXHKo8OvmpIhzhwkSZuH8sCOx96i8C6YbR3SQGG
         Gzmw==
X-Gm-Message-State: AC+VfDwP7hGcYVaWp/I4TmVlG4QU4zoaiz8WOiqzKrZFvC3q6nT0pSiT
        f9CrPI0J0D727EQSbSnmX8EdhgTvjgKxyfVZADt6uozYanw3R1n7jl04LIhOw1Im8Vu/1i6BMJg
        CdiMQSmanBULXZOej7VrCN2wp
X-Received: by 2002:a05:620a:261b:b0:75d:53ee:ced2 with SMTP id z27-20020a05620a261b00b0075d53eeced2mr9737759qko.3.1686554715880;
        Mon, 12 Jun 2023 00:25:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VuifOapEch7jQlR/qS70uakqBc0QmL94RvL3OjCGbDQ+rEyQGny14ZUgrn99WU43OqLM/LQ==
X-Received: by 2002:a05:620a:261b:b0:75d:53ee:ced2 with SMTP id z27-20020a05620a261b00b0075d53eeced2mr9737716qko.3.1686554715595;
        Mon, 12 Jun 2023 00:25:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-250-244.dyn.eolo.it. [146.241.250.244])
        by smtp.gmail.com with ESMTPSA id v11-20020ae9e30b000000b0074fb15e2319sm2685635qkf.122.2023.06.12.00.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 00:25:15 -0700 (PDT)
Message-ID: <38dad5cb196741e56d018cea155982928694b2cc.camel@redhat.com>
Subject: Re: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jiri Pirko <jiri@resnulli.us>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
        corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Date:   Mon, 12 Jun 2023 09:25:06 +0200
In-Reply-To: <ZIWVuPMyKRPv6oyh@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
         <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
         <ZIWVuPMyKRPv6oyh@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-11 at 11:36 +0200, Jiri Pirko wrote:
> Fri, Jun 09, 2023 at 02:18:46PM CEST, arkadiusz.kubalewski@intel.com wrot=
e:
> > From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>=20
> [...]
>=20
> > +int dpll_device_register(struct dpll_device *dpll, enum dpll_type type=
,
> > +			 const struct dpll_device_ops *ops, void *priv)
> > +{
> > +	struct dpll_device_registration *reg;
> > +	bool first_registration =3D false;
> > +
> > +	if (WARN_ON(!ops))
> > +		return -EINVAL;
> > +	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&dpll_lock);
> > +	reg =3D dpll_device_registration_find(dpll, ops, priv);
> > +	if (reg) {
> > +		mutex_unlock(&dpll_lock);
> > +		return -EEXIST;
> > +	}
> > +
> > +	reg =3D kzalloc(sizeof(*reg), GFP_KERNEL);
> > +	if (!reg) {
> > +		mutex_unlock(&dpll_lock);
> > +		return -EEXIST;
> > +	}
> > +	reg->ops =3D ops;
> > +	reg->priv =3D priv;
> > +	dpll->type =3D type;
> > +	first_registration =3D list_empty(&dpll->registration_list);
> > +	list_add_tail(&reg->list, &dpll->registration_list);
> > +	if (!first_registration) {
> > +		mutex_unlock(&dpll_lock);
> > +		return 0;
> > +	}
> > +
> > +	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
> > +	mutex_unlock(&dpll_lock);
> > +	dpll_device_create_ntf(dpll);
>=20
> This function is introduced in the next patch. Breaks bissection. Make
> sure you can compile the code after every patch applied.

WRT, I think the easiest way to solve the above is adding the function
call in the next patch.

Cheers,

Paolo

