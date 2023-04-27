Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3636F013B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbjD0HI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0HI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE4B469E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682579260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlogBekyk2gSeEekDg86LcWxQDtHbn1xGkaDN0V88A0=;
        b=Et77/lmWqklBqJ745Br0WlrONTiGDqFwzJvWVdFukWEgnvMQy6lzksT56q18DTw2m9sYCm
        d4QSeuIGkl0EFnbmfP1uFwtnlvqfepj4fkueIeCBjK3ghVzGDKxLeSFC1FV/vNf3Dn8Gwx
        Ozlh70Ai3SgPPr9H4ZGW4ybiztxKCXE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-0KaW5vXqMcu4kBz-dyI1yg-1; Thu, 27 Apr 2023 03:07:38 -0400
X-MC-Unique: 0KaW5vXqMcu4kBz-dyI1yg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ecd50d9db9so12480491cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682579258; x=1685171258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlogBekyk2gSeEekDg86LcWxQDtHbn1xGkaDN0V88A0=;
        b=KEQDYwrDiqvHDh/9Pq0E2vCKIWY2OdA2SvqMDOBR4vWJv4XtLO5shizR8LbcKanjni
         WY4D6gZkCANhTTvOrMuP+7PmSvPVhqUSee35Hz+oPHLFbre/LoM+8jdfOmpVwmOQvmHk
         Wd1SBuWGlQQwJmuycR2J23Z8Qw7GuzmxCyectDY2sqoaEaTyxoFv/+oWLThLIMrO8aSe
         UefisbhV7fLqHclIQ7czHI37mNFuQWmdEvEMwyc9NyJ1cJ/CW6rIBdT1+1XEkZZdYA42
         SeVPL0vOAolKJQhmjfDdIDbj1xii5x6Lulu4osBj1W+tLWVySlNigurlnJIZSXPhseOW
         /uLQ==
X-Gm-Message-State: AC+VfDzpIfsjzom9wmDNre2mysqq1rF2fBv7B73iQXE46zym0uVxTQJe
        sBCNvmzU/aWoOCoYrZQzSBpxD6/1uBTFWRDWzubXVUmzM2FZPMXwTTaTvQkjaRTjQbtw2KjgLR8
        dazuFkKRAEGtE3oc94rAviAnv
X-Received: by 2002:a05:622a:510:b0:3ef:37fa:e1d6 with SMTP id l16-20020a05622a051000b003ef37fae1d6mr818894qtx.2.1682579258343;
        Thu, 27 Apr 2023 00:07:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5F3RtmIl+pQlfLGDCcC43NoGUaeEyMbtQ1c/nG8/GmJLAbwkFZxTzib2OlzZCRXxLG9aqQUw==
X-Received: by 2002:a05:622a:510:b0:3ef:37fa:e1d6 with SMTP id l16-20020a05622a051000b003ef37fae1d6mr818879qtx.2.1682579258051;
        Thu, 27 Apr 2023 00:07:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-21.dyn.eolo.it. [146.241.243.21])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a094400b0073b8745fd39sm2198762qkw.110.2023.04.27.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 00:07:37 -0700 (PDT)
Message-ID: <e05d4d4d33a2c50973d139752b4fcfad5dbdf056.camel@redhat.com>
Subject: Re: [PATCH net-next] wifi: ath11k: Use list_count_nodes()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 27 Apr 2023 09:07:34 +0200
In-Reply-To: <87v8hiosci.fsf@kernel.org>
References: <941484caae24b89d20524b1a5661dd1fd7025492.1682542084.git.christophe.jaillet@wanadoo.fr>
         <87v8hiosci.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-27 at 07:35 +0300, Kalle Valo wrote:
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
>=20
> > ath11k_wmi_fw_stats_num_vdevs() and ath11k_wmi_fw_stats_num_bcn() reall=
y
> > look the same as list_count_nodes(), so use the latter instead of hand
> > writing it.
> >=20
> > The first ones use list_for_each_entry() and the other list_for_each(),=
 but
> > they both count the number of nodes in the list.
> >=20
> > While at it, also remove to prototypes of non-existent functions.
> > Based on the names and prototypes, it is likely that they should be
> > equivalent to list_count_nodes().
> >=20
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Un-tested
>=20
> I'll run sanity tests on ath11k patches. I'll also add "Compile tested
> only" to the commit log.
>=20
> Oh, and ath11k patches go to ath tree, not net-next.

Just for awareness, there are 2 additional patches apparently targeting
net-next but being instead for the WiFi tree:

https://lore.kernel.org/all/e77ed7f719787cb8836a93b6a6972f4147e40bc6.168253=
7509.git.christophe.jaillet@wanadoo.fr/
https://lore.kernel.org/all/e6ec525c0c5057e97e33a63f8a4aa482e5c2da7f.168254=
1872.git.christophe.jaillet@wanadoo.fr/

Cheers,

Paolo

