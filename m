Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76B2652756
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLTTvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLTTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429541134
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671565855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dJi8OKv/lfpiYHlxZQhWkr2Fn+pTTwnDKMiC+l7rhY=;
        b=R53fyT7/cpWyq5/Hzsul/v0owww1iLL+8SK2ivT/6XtoCD13KuzCFWhCKIx8XOppdzL90j
        +n0OkaVDbAqFatROdgaVUugKXIiPM94w/pMOKSJHAkyv4hMRyL70uFCQssZwIPUY4XlJyY
        +lx3KvMZYTFRIMziWFHNphVpsrnNu2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-YJEg4p33N7yafxArripUdA-1; Tue, 20 Dec 2022 14:50:53 -0500
X-MC-Unique: YJEg4p33N7yafxArripUdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD541857A8A;
        Tue, 20 Dec 2022 19:50:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 355F7112132C;
        Tue, 20 Dec 2022 19:50:51 +0000 (UTC)
Date:   Tue, 20 Dec 2022 14:50:50 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Message-ID: <Y6ISGqiSzK2WQi5G@fedora>
References: <20221220112340.518841-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qs7BktVcbA5Ws00G"
Content-Disposition: inline
In-Reply-To: <20221220112340.518841-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qs7BktVcbA5Ws00G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 06:23:44AM -0500, Michael S. Tsirkin wrote:
> When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
> is excluded from array of driver features.
> As a result virtio_has_feature panics in virtio_check_driver_offered_feat=
ure
> since that by design verifies that a feature we are checking for
> is listed in the feature array.
>=20
> To fix, replace the call to virtio_has_feature with a stub.
>=20
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qs7BktVcbA5Ws00G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOiEhoACgkQnKSrs4Gr
c8j1sAgArFbeE12ThS17C8bvQ/gd4ePFCbYmOiFcuTrQZ4fBWVzD6K2vGZhTWrRT
O5EJiIzBGTdeoWGg/BuhYXddcyXimSyiwBRQquawn5IIKeleNtODdiWT3dZOAiW6
ZEfTlKRGSjqSVWKkEiL943KRQ8Y3RYSGzu2pHNRgB2AieQmjX1hAjNj3WzhM/Emy
tKJr+R4FhEqfZF7i9x4fTAHQeyjgJWyY3m57yJ+Im0mxxiiQhufIKNeLDNSp2N5T
4z8XvTj81aLfQPtOeAppVdNetBBo2fS8Dzj7r+O0YfKRCPufHUILGnyU7SrnMpJ4
Tkt5GDbZi9cxlMFD2te/Vhs5RK/o4w==
=rcjH
-----END PGP SIGNATURE-----

--qs7BktVcbA5Ws00G--

