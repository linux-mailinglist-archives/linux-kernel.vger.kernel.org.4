Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE06D94DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbjDFLP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbjDFLP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C776E94
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680779715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJIFUKdbCVxH+e/HWZUZILs1Tdh2bp6w12YNbU+lrBE=;
        b=WngAuUzvCWRSSv+l2PHzkPQvO9HcQWyYTqPMqDIYe5gjEQ94c4hNKIWgw19hnrfrazClxo
        UP2pJk7k5WsXCEiSrWo0kTREyDKRZulqeUuOUNV0QTV6AsQSuN6ORepkuUXl/MIW/BkEuX
        qbL8OaXnKKlYKUHjq9Lp80aTJDOEnz4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-A40D6nrkPfO1B5FbOsWVRg-1; Thu, 06 Apr 2023 07:15:14 -0400
X-MC-Unique: A40D6nrkPfO1B5FbOsWVRg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5a3c1e28e73so2813026d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779714; x=1683371714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJIFUKdbCVxH+e/HWZUZILs1Tdh2bp6w12YNbU+lrBE=;
        b=OqknhSDCeDUJYE0BTGa18tTmF2TxRAox/qyEXYyC4XqvaBoOcFx6H82VrK/NyKmqVk
         wuHnjxVTgH6I34EJlHdJ8w2pOa6VFUJrQiKy2EBWD3unlQtAE3ieZGw+HSh+tlHOMI9a
         GUdCdatscwqPK4tRtWo/jusmd5eloEdpwsvjZYucMjVGG7JVYQumAumzMT3Xp+hIWSSd
         JKNt77p5jDQK/ZkIlTBY3ruPsAlbGMK2cdamnnhG1AvE9GCmQAiXuvn2xPPQTHphI6fF
         1fhHuH99rsn53wZm8C6d77vpLIruNCHrcLPTUN75Q7d7QB5i8Vc7e85K7PM5Ig7e/1wO
         Ehow==
X-Gm-Message-State: AAQBX9dXPl6rnPtwArEyi6Mb0w1U6bSvAQE77hNro6vwlHA3Ly3Vm7CX
        MvPvsJNKM1DNQ7DewiFemX3dJxNHXsTwcy1tjhjm+jdg63Tfe3AnAdDrmRwh9KZyefysQA1L8ht
        FlCypzpugCuzbgGzRNpcjY2GR
X-Received: by 2002:a05:6214:410d:b0:5df:4d41:9560 with SMTP id kc13-20020a056214410d00b005df4d419560mr8365678qvb.0.1680779714110;
        Thu, 06 Apr 2023 04:15:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350acgJFhERoKoMnZoLl+AOfUrAe2JLco/YpvIHdVhTrerf8HDLTi5O4DDcW1RvnctM3ICg9VjA==
X-Received: by 2002:a05:6214:410d:b0:5df:4d41:9560 with SMTP id kc13-20020a056214410d00b005df4d419560mr8365650qvb.0.1680779713836;
        Thu, 06 Apr 2023 04:15:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id fc2-20020ad44f22000000b005dd8b9345c2sm427343qvb.90.2023.04.06.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:15:13 -0700 (PDT)
Message-ID: <d24bcf952c8ceb3fa97b11cab222945b73723052.camel@redhat.com>
Subject: Re: [PATCH] r8152: Advertise support for software timestamping
From:   Paolo Abeni <pabeni@redhat.com>
To:     Matthew Dawson <matthew@mjdsystems.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 13:15:10 +0200
In-Reply-To: <3218086.lGaqSPkdTl@cwmtaff>
References: <3218086.lGaqSPkdTl@cwmtaff>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2023-04-05 at 01:26 -0400, Matthew Dawson wrote:
> Since this drivers initial merge, the necessary support for software
> based timestamping has been available.  Advertise support for this
> feature enables the linuxptp project to work with it.
>=20
> Signed-off-by: Matthew Dawson <matthew@mjdsystems.ca>
> Tested-by: Mostafa Ayesh <mostafaayesh@outlook.com>
> ---
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index decb5ba56a259..44f64fd765a7d 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9132,6 +9132,7 @@ static const struct ethtool_ops ops =3D {
>  	.set_ringparam =3D rtl8152_set_ringparam,
>  	.get_pauseparam =3D rtl8152_get_pauseparam,
>  	.set_pauseparam =3D rtl8152_set_pauseparam,
> +	.get_ts_info =3D ethtool_op_get_ts_info,
>  };
> =20
>  static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, in=
t=20
> cmd)

Does not apply cleanly to net-next due to last line being wrapped.

Please re-spin and specify the target tree into the subj.

Thanks!

Paolo

