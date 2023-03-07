Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323116AD324
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCGAH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCGAH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E64FA95
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678147605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiG8BgPH1QQ43j7yve5gAvlmd9pWIcu5Uac1q0tt6sI=;
        b=OhcdS/+hw7XnVOFGDIQzVKzjP9T+iDiem5uMImG5HiF0PB5mou8cvfo6xpUF6AOmkWqe3b
        IdtUIOw85wHtSnZo3JzLccqGKrKc3Xj/7Tk+nJJLPXUEYZLbq0R5sY2Xp4dGThxpKr6egg
        O6XuejLIg0ghXYGqLODxldK0zI5QClg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Jvq7vAApOnaSLsA1wri7rQ-1; Mon, 06 Mar 2023 19:06:44 -0500
X-MC-Unique: Jvq7vAApOnaSLsA1wri7rQ-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso10926846edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678147602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiG8BgPH1QQ43j7yve5gAvlmd9pWIcu5Uac1q0tt6sI=;
        b=e2s098xnPzCQzWd5CdoGP9B+5pAl354XEb+YMGMK5C/6WOWiACIgCIFrfa/kKzk9+O
         m+p01u5OO5eFcsR4Pwb4ePdoIgCnzTzjAuumlPG1Fo3qrlnpaoutepFzEA2XQ8ADGzQP
         2nCqS+OTSMNvzC5jTJlaVMTmvygGI2KEMlUmhvf+IQWXSHOrcp+Cg5zIkMLAlLBJAc1F
         3Lnnd5DJmwwEtdFBP5riDbPzhYPAASUweZlW+RtOASy3Te+uM3yNfnryZtYu1doN0V9D
         nobrvjrpvY5VpeAX6BhakZ97iJ7e7glVbTK42X3Y84emppcw6npI9IINNlsV8TUKVcMC
         Hn3w==
X-Gm-Message-State: AO0yUKW22dBUXxZyhE+wxQRMzC0PqDRX+99dGf5G0p5R7AkAW9ZLyMxH
        t3rkcPhld3kCeKYrzCVhG2pTYHceiBx28dRkDzPWAf2u8wQrTS4ZKVvGTCmOQzkMC/dMuiS5tbB
        46AA4mZiFuF0duIIVQenz5sl5Y2WUKTPv8QRGW4D1
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id v14-20020a170906338e00b0089558be0963mr6262945eja.3.1678147602616;
        Mon, 06 Mar 2023 16:06:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+tlZyOLrVQtITvkM4aCSQgfCcDyTdnBcxy/a9AwJHlmGApYotDt8QLwad83Q2rJffmtyK+Fiuv9O7gGylkK+s=
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id
 v14-20020a170906338e00b0089558be0963mr6262936eja.3.1678147602324; Mon, 06 Mar
 2023 16:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20230306191824.4115839-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230306191824.4115839-1-harshit.m.mogalapalli@oracle.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 6 Mar 2023 19:06:31 -0500
Message-ID: <CAK-6q+iHJouJc2WSuPipC8kieULYg02ipyHaOKDsnj4rT-gcyA@mail.gmail.com>
Subject: Re: [PATCH next] ca8210: Fix unsigned mac_len comparison with zero in ca8210_skb_tx()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Harry Morris <harrymorris12@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 6, 2023 at 2:20=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> mac_len is of type unsigned, which can never be less than zero.
>
>         mac_len =3D ieee802154_hdr_peek_addrs(skb, &header);
>         if (mac_len < 0)
>                 return mac_len;
>
> Change this to type int as ieee802154_hdr_peek_addrs() can return negativ=
e
> integers, this is found by static analysis with smatch.
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver"=
)
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

sorry, I didn't see that... Thanks for sending this patch.

- Alex

