Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2460BB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiJXVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiJXVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D92CA7E5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666638729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92rC7vra5jhLWtogZY2kc9h+cj7t9VuLWZS8/0qi9VI=;
        b=YHso0iYclsdKJGcM0z18udr30n6DSj9Kx6PmViq/74d7TI4aTMd9Q1RXyYwJso3jDmWOeu
        350QXlykfarfeNTmdLOylCXUf9R0v4oy4c4qukKRIKitxv0LAqDoJQyoTbIzKT7lXl5Z5G
        pYoX+U/Yw7ZeDh43isL4AmOIOYpt1Sk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-7b7FQSphNy-BQfdUC9UndQ-1; Mon, 24 Oct 2022 11:44:19 -0400
X-MC-Unique: 7b7FQSphNy-BQfdUC9UndQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E40BA858F17;
        Mon, 24 Oct 2022 15:44:18 +0000 (UTC)
Received: from localhost (unknown [10.39.194.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 627801415114;
        Mon, 24 Oct 2022 15:44:18 +0000 (UTC)
Date:   Mon, 24 Oct 2022 11:44:16 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
Message-ID: <Y1ay0NMQ7p03hgxu@fedora>
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+myidrQ2SNzoh0X"
Content-Disposition: inline
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+myidrQ2SNzoh0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2022 at 05:41:26PM -0300, Rafael Mendonca wrote:
> The virtblk_map_data() function returns negative error codes, however, the
> 'nents' field of vbr->sg_table is an unsigned int, which causes the error
> handling not to work correctly.
>=20
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H+myidrQ2SNzoh0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNWstAACgkQnKSrs4Gr
c8jYegf9FWI4IHxGcvMocCCgVz2xC4vCDXutBT1DcO/mwG8nFliPMNR10l8zwwTO
VgkOzVoed8mckPmnWXNyePLJB68ZeOmRvWRuExPwqZNMNHx8Nq/xtTG2NmYWR1qm
gfMJeRmaXxEdSy4Ah7NFx4y7LMRk2SodlFzQMzb4vcQOww0p+GCTyl5gDWYeGPCV
wbKCqdaKCnu85W9Z8cgjVPX6ACqdnIsy2X6Kik3mKUjQr389my9HODEI+7hOrWuR
8Yode18jCQX8uR0gi1IriIso3vh7lNYyfGrCK2fpkwX1tlG1fFfDjhdftGwD5frR
VkZXHYhphTdDZp+CcFRo7j2dO1mGLA==
=nNPq
-----END PGP SIGNATURE-----

--H+myidrQ2SNzoh0X--

