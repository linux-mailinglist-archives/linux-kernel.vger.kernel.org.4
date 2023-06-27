Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C473F0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjF0CBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjF0CBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:01:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23AC1715;
        Mon, 26 Jun 2023 19:00:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qqnx84x1Rz4wZr;
        Tue, 27 Jun 2023 12:00:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687831245;
        bh=vTe0qIu1u6l3/BzxgdzdRr5qwDbnigi8icXlQUmm+y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LkckMgtYuv61gH8Y6NBykmhNZDZ6p84AlXL9OJTvsFC9pp3nFqdOMgV7x2YpP4e6I
         Df5oc85PX6C0btvq5CFNPn1Z9k2XIAkM3zWxgLoaGr4KYdaMNSHpCiFOD5sCBdoFEv
         s79kKlurogwi/Lsku59zHc5Tw6q/wJnfzmSwgZmpSWfORwI5Vfy0wFIbeNNn9xmwAj
         B5p+8V/6Uw6VktZYuzNhhfwGC9M+qYOhF1rXKA6C/5XEmpCUidl4y2QqBjT6AJjhks
         tw42+1dKv63vwoRIQCJ9MdwsmFnHWDS9/SO0UU7C468ew29GC+5GaplnmWbKOsAwvX
         FL1rGqCBGUA/w==
Date:   Tue, 27 Jun 2023 12:00:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the net-next
 tree
Message-ID: <20230627120043.152df5dd@canb.auug.org.au>
In-Reply-To: <20230613125939.595e50b8@canb.auug.org.au>
References: <20230613125939.595e50b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1zMnyQ_fpp7ls0cIvHGjgX+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1zMnyQ_fpp7ls0cIvHGjgX+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 13 Jun 2023 12:59:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   fs/splice.c
>=20
> between commit:
>=20
>   2bfc66850952 ("splice, net: Add a splice_eof op to file-ops and socket-=
ops")
>=20
> from the net-next tree and commit:
>=20
>   6a3f30b8bdb2 ("splice: Make do_splice_to() generic and export it")
>=20
> from the block tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc fs/splice.c
> index 67ddaac1f5c5,2420ead610a7..000000000000
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@@ -969,23 -841,24 +937,35 @@@ static long do_splice_from(struct pipe_
>   	return out->f_op->splice_write(pipe, out, ppos, len, flags);
>   }
>  =20
>  +/*
>  + * Indicate to the caller that there was a premature EOF when reading f=
rom the
>  + * source and the caller didn't indicate they would be sending more dat=
a after
>  + * this.
>  + */
>  +static void do_splice_eof(struct splice_desc *sd)
>  +{
>  +	if (sd->splice_eof)
>  +		sd->splice_eof(sd);
>  +}
>  +
> - /*
> -  * Attempt to initiate a splice from a file to a pipe.
> + /**
> +  * vfs_splice_read - Read data from a file and splice it into a pipe
> +  * @in:		File to splice from
> +  * @ppos:	Input file offset
> +  * @pipe:	Pipe to splice to
> +  * @len:	Number of bytes to splice
> +  * @flags:	Splice modifier flags (SPLICE_F_*)
> +  *
> +  * Splice the requested amount of data from the input file to the pipe.=
  This
> +  * is synchronous as the caller must hold the pipe lock across the enti=
re
> +  * operation.
> +  *
> +  * If successful, it returns the amount of data spliced, 0 if it hit th=
e EOF or
> +  * a hole and a negative error code otherwise.
>    */
> - static long do_splice_to(struct file *in, loff_t *ppos,
> - 			 struct pipe_inode_info *pipe, size_t len,
> - 			 unsigned int flags)
> + long vfs_splice_read(struct file *in, loff_t *ppos,
> + 		     struct pipe_inode_info *pipe, size_t len,
> + 		     unsigned int flags)
>   {
>   	unsigned int p_space;
>   	int ret;
> @@@ -1081,9 -959,9 +1070,9 @@@ ssize_t splice_direct_to_actor(struct f
>   		size_t read_len;
>   		loff_t pos =3D sd->pos, prev_pos =3D pos;
>  =20
> - 		ret =3D do_splice_to(in, &pos, pipe, len, flags);
> + 		ret =3D vfs_splice_read(in, &pos, pipe, len, flags);
>   		if (unlikely(ret <=3D 0))
>  -			goto out_release;
>  +			goto read_failure;
>  =20
>   		read_len =3D ret;
>   		sd->total_len =3D read_len;

This is now a conflict between the net-next tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1zMnyQ_fpp7ls0cIvHGjgX+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSaQssACgkQAVBC80lX
0Gwkegf+KaweOSCqQ1Sz/QDtj3hFrCYCowyUVZmQO5ocg2ZzR2CdoQEW9/praDOM
/twS149DftI+10rURHfiM2eFbF/UxkyvT3b0dtL0hHHKU1DRt/vr0+oZbZnxETSX
6x2d59FCDlLD6NBoje0xxND7W1QdieqCWyIgOII7FMo0RvaxiOPYqJKxHCxSRUTR
Z2INic/3KCYVN7Y6L7MmXFn08ZqRsSxZ5gKa3/Ie5Z3h2KNehOmvvgYSz/yFpv3o
0C0vWx/CtnwYYzJX+gmmlIBglYfKZ2jnCrNCPB+mFgRuMe4K9tn8mDp9cslXHSM9
zX0l8nyJ3MpB9Jy/rv4anPOYvM4RJw==
=ln5M
-----END PGP SIGNATURE-----

--Sig_/1zMnyQ_fpp7ls0cIvHGjgX+--
