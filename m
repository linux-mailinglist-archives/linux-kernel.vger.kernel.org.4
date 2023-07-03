Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046F7456C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGCIDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGCICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:02:51 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493BEE76;
        Mon,  3 Jul 2023 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1688371330;
        bh=mxT+hp0pGIWfYK4XM4T63enx90hO11e+CShcYgfo8H0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iY49mJOi8grshnjTw7grQ3MauTVbYoj0RJm4FCUljQPdjDMRI8vQ6Y8pO6+2OS43+
         P+fAm31J9NbYzsF/SYpRVP4ZRVFU8XLN7qQFvi4UD4SYiBFMOuvruDEw8syyH7vK+1
         e2aIDQg/d2mT1Y1lDoBIik0J7t7IDAeqQ6I3a1eM=
Received: from [IPv6:240e:358:110a:4b00:dc73:854d:832e:4] (unknown [IPv6:240e:358:110a:4b00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CD90E660BB;
        Mon,  3 Jul 2023 04:02:02 -0400 (EDT)
Message-ID: <1b331090f91215d6c061a24c4cc61680995412f8.camel@xry111.site>
Subject: Re: [PATCH v4] =?gb2312?Q?wifi=A3=BAmac80211=3A?= Replace the
 ternary conditional operator with conditional-statements
From:   Xi Ruoyao <xry111@xry111.site>
To:     You Kangren <youkangren@vivo.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MAC80211" <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
Date:   Mon, 03 Jul 2023 16:01:53 +0800
In-Reply-To: <20230703030200.1067-1-youkangren@vivo.com>
References: <20230703030200.1067-1-youkangren@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-03 at 11:02 +0800, You Kangren wrote:
> Replacing ternary conditional operators with conditional statements=20
> ensures proper expression of meaning while making it easier for=20
> the compiler to generate code.

No you underestimated the compiler here.  Both GCC and Clang translates
the ternary operator and the if statement into the same IR during very
early passes.

Maybe there is some reason to avoid ternary operators, but "making it
easier for compiler" is just invalid.  And "my text book/my teacher says
ternary operators are bad" will be invalid too, the kernel coding
convention is not what the text book or teacher say.

> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
> =C2=A0net/mac80211/tdls.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
> index a4af3b7675ef..41176491965d 100644
> --- a/net/mac80211/tdls.c
> +++ b/net/mac80211/tdls.c
> @@ -946,7 +946,8 @@ ieee80211_tdls_build_mgmt_packet_data(struct
> ieee80211_sub_if_data *sdata,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ieee80211_link_dat=
a *link;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link_id =3D link_id >=3D 0 ? l=
ink_id : 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (link_id < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0link_id =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_lock();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link =3D rcu_dereference(=
sdata->link[link_id]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (WARN_ON(!link))

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
