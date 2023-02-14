Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC30B696A12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBNQnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjBNQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395402CFD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676392922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6eqvoFwqH6MbbrEiiK8eru7l+SZ5tdaOJINEp0Ly7Y=;
        b=i2XiWe2KIeenlk2H7d8vKsLMjPM+ud15JutYsxX4PQltXqqdEAEveDpB40ihBY+73SGLYs
        O/VvGlkkFnjvuzWP0HjC1QU1j+jq/jy+CglF7kpRDpUSnDgcuMWQ23bgHT6U7ixzsMN+iY
        VONRpXe3tcI+FSezNWoj5lK6X/c/mbg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-DV_7l-xJNnyn8NmnXAK99w-1; Tue, 14 Feb 2023 11:41:59 -0500
X-MC-Unique: DV_7l-xJNnyn8NmnXAK99w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 689AC87A385;
        Tue, 14 Feb 2023 16:41:58 +0000 (UTC)
Received: from localhost (unknown [10.39.193.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC0A42026D4B;
        Tue, 14 Feb 2023 16:41:57 +0000 (UTC)
Date:   Tue, 14 Feb 2023 11:41:56 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, hackerzheng666@gmail.com,
        jasowang@redhat.com, pbonzini@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in  virtscsi_rescan_hotunplug
Message-ID: <Y+u51GN1uf3i0A4+@fedora>
References: <20230202064124.22277-1-zyytlz.wz@163.com>
 <20230213070906-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8UxNTXH0/J1RCIqe"
Content-Disposition: inline
In-Reply-To: <20230213070906-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8UxNTXH0/J1RCIqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 07:09:50AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 02, 2023 at 02:41:24PM +0800, Zheng Wang wrote:
> > There is no check about the return value of kmalloc in
> > virtscsi_rescan_hotunplug. Add the check to avoid use
> > of null pointer 'inq_result' in case of the failure
> > of kmalloc.
> >=20
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
>=20
> I fixed a typo in subject and tweaked the patch a bit

Thanks for picking this patch up.
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=3Dl=
inux-next&id=3D4a8fc6e3ac68ce4c355d1f4473ef1d8468b23bdc

Stefan

--8UxNTXH0/J1RCIqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPrudQACgkQnKSrs4Gr
c8gR5QgAyX3SyeEgLJ/OpK4aeXYNWXfpZcmtdCK3YtTy7c7C16RA7vFll5zv1CpI
z2+qqNf1KeDsrntla046kqeNVgASEKEorQJm9chEw1emaLFyOvzLBCXNd7wvfso3
ix4l6Ua7dM9nm5Rrf6j6zBs9PcdEGtb/llC5m8RR0GFX8iO+izOk1hVG3DmPDOsQ
rK3ZETdRiLAE51MVYNHT+XKR545IK5R9JMhRUzhKEqdR0cMePk0ZPoNKtU2wAzlf
9tiJGw2oiebN9ZHbnpXrulA74v9VQmhKqH/KGv20WkXRL9/QutViOECSBHJGuACf
MFd+kMz4hzdbv50rWM4ksYjDFz45zw==
=SFCg
-----END PGP SIGNATURE-----

--8UxNTXH0/J1RCIqe--

