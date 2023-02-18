Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CD69BB55
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBRRwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:51:59 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D30714EA7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 09:51:57 -0800 (PST)
Date:   Sat, 18 Feb 2023 17:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1676742714; x=1677001914;
        bh=fSJSZvw8bXvV0qGXKxeTFlEAuqIm4ngzQtZtpV/7jVM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=lcWC8MYnANHLs66BVc94Af9SzXnGvxjGm3S3k+oIc5JYgnnfQqf01khfiF48zJiSO
         OCNGBdb5lslN2DrWjZ9QE1cKEkNWk63kw2pebnuXOyYxdHs4wGqP5S7ShxgHk8tewr
         bxdRFATEDWwzz+r4b9tKsRe9r2HcFlsIGJxulaLC2m9PwNBU0UfvucNo6VbB1m+ZIl
         ORsQjexHdyWTGIrPfHbaSF6ZnEx7uVlyIOQg4YPJIKN2Buxn3Xl5jCRobpVRUYBUD/
         XA8ZHX7FTG2tTdxe3UHyka8HskfLoA6EUx2X9BSTO55BIFa5H+QKNCgXN8KYhLJfSZ
         40pmGmyaTHLFQ==
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio: Reorder fields in 'struct virtqueue'
Message-ID: <fX2wxaI61f0J2ax9XieNDNpG2EkR6fo6o1GmEqWktmTfSa97oOG-hNOYz8qkdHB4S1xQolMdLWX6wKYANQJox_F0GVOo9xp4qKmz_HSJ7_E=@n8pjl.ca>
In-Reply-To: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
References: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 18th, 2023 at 03:10, Christophe JAILLET <christophe.j=
aillet@wanadoo.fr> wrote:
>=20
>=20
> Group some variables based on their sizes to reduce hole and avoid paddin=
g.
> On x86_64, this shrinks the size of 'struct virtqueue'
> from 72 to 68 bytes.
>=20
> It saves a few bytes of memory.
>=20
> Signed-off-by: Christophe JAILLET christophe.jaillet@wanadoo.fr
>=20
> ---
> Using pahole
>=20
> Before:
> =3D=3D=3D=3D=3D=3D
> struct virtqueue {
> struct list_head list; /* 0 16 */
> void (*callback)(struct virtqueue ); / 16 8 /
> const char * name; / 24 8 /
> struct virtio_device * vdev; / 32 8 /
> unsigned int index; / 40 4 /
> unsigned int num_free; / 44 4 /
> unsigned int num_max; / 48 4 /
>=20
> / XXX 4 bytes hole, try to pack /
>=20
> void * priv; / 56 8 /
> / --- cacheline 1 boundary (64 bytes) --- /
> bool reset; / 64 1 /
>=20
> / size: 72, cachelines: 2, members: 9 /
> / sum members: 61, holes: 1, sum holes: 4 /
> / padding: 7 /
> / last cacheline: 8 bytes /
> };
>=20
> After:
> =3D=3D=3D=3D=3D
> struct virtqueue {
> struct list_head list; / 0 16 */
> void (*callback)(struct virtqueue ); / 16 8 /
> const char * name; / 24 8 /
> struct virtio_device * vdev; / 32 8 /
> unsigned int index; / 40 4 /
> unsigned int num_free; / 44 4 /
> unsigned int num_max; / 48 4 /
> bool reset; / 52 1 /
>=20
> / XXX 3 bytes hole, try to pack /
>=20
> void * priv; / 56 8 /
>=20
> / size: 64, cachelines: 1, members: 9 /
> / sum members: 61, holes: 1, sum holes: 3 */
> };
> ---
> include/linux/virtio.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 6ac2655500dc..9439ae898310 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -35,8 +35,8 @@ struct virtqueue {
> unsigned int index;
> unsigned int num_free;
> unsigned int num_max;
> - void *priv;
> bool reset;
> + void *priv;
> };
>=20
> int virtqueue_add_outbuf(struct virtqueue *vq,
> --
> 2.34.1

This will shrink the struct size on 32 bit archs too.

Acked-by: Peter Lafreniere <peter@n8pjl.ca>

- Peter
