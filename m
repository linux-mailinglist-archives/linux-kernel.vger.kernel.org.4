Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887DC6D13B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjC3Xul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjC3XuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:50:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CA12CFD;
        Thu, 30 Mar 2023 16:50:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PngBx54V5z4x1R;
        Fri, 31 Mar 2023 10:50:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680220204;
        bh=rCPjUHBP/pV9Uau0ptAEaLCUF3D9Ml3/OGmrv28mF4g=;
        h=Date:From:To:Cc:Subject:From;
        b=S0ABsE+rmZ0++GhOZmrtmLwI8G76LtysR3QpaeEi92LTIh4SUJh1rwpwvJMCKOI7q
         lDQQe7YbEXwImSz6IZpwH1ma9/Au4G4Z2BypT6ujcFzuOEX2G/9NHz6/DCfGrEbi+Q
         A64GlyIb1Gzwwgw6aL5JnwOiN68JhmaJMvufvGaFAgUA8VBgRg+j+9a/PDIy3+OLKh
         Y8kqUNyMSVTPIWCaJ62uwHb+CMmKme6MdTPVw3wNEH385RX6/V9bHe6GkWPhfTHyff
         AWut5xijCh7NTYmR/hEK31y5k5zCAv5xIcqWhnwvs/V21STxBS5QWF+M2/CnFFZKeh
         w5NAcv7nfHOSQ==
Date:   Fri, 31 Mar 2023 10:49:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: linux-next: manual merge of the wireless-next tree with the
 wireless tree
Message-ID: <20230331104959.0b30604d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z75pzBwRDy.ne14p3qRShtd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z75pzBwRDy.ne14p3qRShtd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/rx.c

between commit:

  a16fc38315f2 ("wifi: mac80211: fix potential null pointer dereference")

from the wireless tree and commit:

  fe4a6d2db3ba ("wifi: mac80211: implement support for yet another mesh A-M=
SDU format")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mac80211/rx.c
index 3e2176a730e6,1c957194554b..000000000000
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@@ -2776,27 -2862,12 +2843,31 @@@ ieee80211_rx_mesh_data(struct ieee80211
  		rcu_read_unlock();
  	}
 =20
 +	/* Frame has reached destination.  Don't forward */
 +	if (ether_addr_equal(sdata->vif.addr, eth->h_dest))
 +		goto rx_accept;
 +
 +	if (!--mesh_hdr->ttl) {
 +		if (multicast)
 +			goto rx_accept;
 +
 +		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
 +		return RX_DROP_MONITOR;
 +	}
 +
 +	if (!ifmsh->mshcfg.dot11MeshForwarding) {
 +		if (is_multicast_ether_addr(eth->h_dest))
 +			goto rx_accept;
 +
 +		return RX_DROP_MONITOR;
 +	}
 +
  	skb_set_queue_mapping(skb, ieee802_1d_to_ac[skb->priority]);
 =20
+ 	if (!multicast &&
+ 	    ieee80211_rx_mesh_fast_forward(sdata, skb, mesh_hdrlen))
+ 		return RX_QUEUED;
+=20
  	ieee80211_fill_mesh_addresses(&hdr, &hdr.frame_control,
  				      eth->h_dest, eth->h_source);
  	hdrlen =3D ieee80211_hdrlen(hdr.frame_control);
@@@ -2914,14 -2982,24 +2985,24 @@@ __ieee80211_rx_h_amsdu(struct ieee80211
  					  data_offset, true))
  		return RX_DROP_UNUSABLE;
 =20
 -	if (rx->sta && rx->sta->amsdu_mesh_control < 0) {
 +	if (rx->sta->amsdu_mesh_control < 0) {
- 		bool valid_std =3D ieee80211_is_valid_amsdu(skb, true);
- 		bool valid_nonstd =3D ieee80211_is_valid_amsdu(skb, false);
+ 		s8 valid =3D -1;
+ 		int i;
+=20
+ 		for (i =3D 0; i <=3D 2; i++) {
+ 			if (!ieee80211_is_valid_amsdu(skb, i))
+ 				continue;
+=20
+ 			if (valid >=3D 0) {
+ 				/* ambiguous */
+ 				valid =3D -1;
+ 				break;
+ 			}
 =20
- 		if (valid_std && !valid_nonstd)
- 			rx->sta->amsdu_mesh_control =3D 1;
- 		else if (valid_nonstd && !valid_std)
- 			rx->sta->amsdu_mesh_control =3D 0;
+ 			valid =3D i;
+ 		}
+=20
+ 		rx->sta->amsdu_mesh_control =3D valid;
  	}
 =20
  	ieee80211_amsdu_to_8023s(skb, &frame_list, dev->dev_addr,

--Sig_/Z75pzBwRDy.ne14p3qRShtd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQmICcACgkQAVBC80lX
0Gyc7Qf8CT58uZK2qOJyG/1i1sV+AZ51ZNKUlxXH4cQ/OcLOAlk6X/LuI0DTFfpE
sG8KHR2fWI9oVQqhXStFTI3yPAUB9Y5NKJR8WCVN5sqVE2zdWbKax2dYo9wAZ9wa
Sd7n7+QhdI8aJwBmM7cnOtRnYngpunTwGdRKDfaJZmftxKsPvmuM+jyBpBovIiZi
3bmfvoSU61TRZ3pqIL363RsoWT7MiQ+XaEpx7gc9U7Wnuc0hKLbC+sMkAsEnks1E
eVxukHXZhowsT+IhorkLBROpLDkD+75DoU6AFbNGAgS0+65T+OFkCymNmDYPZOGO
sgnMs9gbQiAfHinB4riWu2MSIAdszw==
=8hDd
-----END PGP SIGNATURE-----

--Sig_/Z75pzBwRDy.ne14p3qRShtd--
