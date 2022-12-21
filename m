Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E236533C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiLUQHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLUQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2592037A;
        Wed, 21 Dec 2022 08:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CB99B81B4A;
        Wed, 21 Dec 2022 16:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FD3C433EF;
        Wed, 21 Dec 2022 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671638834;
        bh=44yRHWfKYxV3hy7ywPLqpzm3ZqvZS0s31zkOEJ8k8OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPDtN5UWekRIJ6bbC9mTA+YzCP8s/mdrupaSPbX3r8uSuOgNim/ExOJlyzGlAFVN0
         av+HyYUizikTM7y3SsR6Q3vDhkApHT/c9pT9VVX5+L64v30H0r6f7ijQso8Vl6mmzb
         4qLKRgBsi+NAXlkdvIGrbD6zeZ4stPiv3gFzqbD9QlrHbiY1uOp9nLTVoMPWHszl1X
         awvPf40FJkcQOqgnWFBKqNBRcNCdmoWJBF0z1qA4b+yclYXVK/SUcSf5IYZQs+1L9W
         SMYEfdMFpebwPEJIvde8Kt9XhDm6+rgH5Kqv3MlBBTPJ9X5zaNdfx148OR5qf0hDok
         +ztWq6jkKFH6Q==
Date:   Wed, 21 Dec 2022 17:07:10 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Message-ID: <Y6MvLszMEvtQjcOk@lore-desk>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
 <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
 <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8r/cDTU/p+QQtpFQ"
Content-Disposition: inline
In-Reply-To: <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8r/cDTU/p+QQtpFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 21.12.22 14:10, Mikhail Gavrilov wrote:
> > On Wed, Dec 21, 2022 at 3:45 PM Felix Fietkau <nbd@nbd.name> wrote:
> > >=20
> > > I'm pretty sure that commit is unrelated to this issue. However, while
> > > looking at the code I found a bug that would explain your issue.
> > >=20
> > > Please try this patch:
> > > ---
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > @@ -422,15 +422,15 @@ void mt7921_roc_timer(struct timer_list *timer)
> > >=20
> > >   static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_v=
if *vif)
> > >   {
> > > -       int err;
> > > -
> > > -       if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> > > -               return 0;
> > > +       int err =3D 0;
> > >=20
> > >         del_timer_sync(&phy->roc_timer);
> > >         cancel_work_sync(&phy->roc_work);
> > > -       err =3D mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> > > -       clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> > > +
> > > +       mt7921_mutex_acquire(phy->dev);
> > > +       if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> > > +               err =3D mt7921_mcu_abort_roc(phy, vif, phy->roc_token=
_id);
> > > +       mt7921_mutex_release(phy->dev);
> > >=20
> > >         return err;
> > >   }
> > > @@ -487,13 +487,8 @@ static int mt7921_cancel_remain_on_channel(struc=
t ieee80211_hw *hw,
> > >   {
> > >         struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_pri=
v;
> > >         struct mt7921_phy *phy =3D mt7921_hw_phy(hw);
> > > -       int err;
> > >=20
> > > -       mt7921_mutex_acquire(phy->dev);
> > > -       err =3D mt7921_abort_roc(phy, mvif);
> > > -       mt7921_mutex_release(phy->dev);
> > > -
> > > -       return err;
> > > +       return mt7921_abort_roc(phy, mvif);
> > >   }
> > >=20
> > >   static int mt7921_set_channel(struct mt7921_phy *phy)
> > > @@ -1778,11 +1773,8 @@ static void mt7921_mgd_complete_tx(struct ieee=
80211_hw *hw,
> > >                                    struct ieee80211_prep_tx_info *inf=
o)
> > >   {
> > >         struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_pri=
v;
> > > -       struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> > >=20
> > > -       mt7921_mutex_acquire(dev);
> > >         mt7921_abort_roc(mvif->phy, mvif);
> > > -       mt7921_mutex_release(dev);
> > >   }
> > >=20
> > >   const struct ieee80211_ops mt7921_ops =3D {
> > >=20
> >=20
> > Unfortunately this patch did not fix the issue.
> > There are still many messages in the logs "mt7921e 0000:05:00.0:
> > AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0010 address=3D0xffdc6a80
> > flags=3D0x0050]"
> Thanks! I guess I focused on the wrong part of your kernel log
> initially. After more code review, I found that there is in fact a DMA
> related bug in the commit that your bisection pointed to, which happened
> to uncover and trigger the deadlock fixed by my other patch.
>=20
> So here's my fix for the DMA issue:

Thx for fixing this issue, I tested the patch with mt7986 w and w/o WED ena=
bled and it works
fine.

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -205,6 +205,52 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt=
76_queue *q)
>  	mt76_dma_sync_idx(dev, q);
>  }
> +static int
> +mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
> +		    struct mt76_queue_buf *buf, void *data)
> +{
> +	struct mt76_desc *desc =3D &q->desc[q->head];
> +	struct mt76_queue_entry *entry =3D &q->entry[q->head];
> +	struct mt76_txwi_cache *txwi =3D NULL;
> +	u32 buf1 =3D 0, ctrl;
> +	int idx =3D q->head;
> +	int rx_token;
> +
> +	ctrl =3D FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
> +
> +	if ((q->flags & MT_QFLAG_WED) &&
> +	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
> +		txwi =3D mt76_get_rxwi(dev);
> +		if (!txwi)
> +			return -ENOMEM;
> +
> +		rx_token =3D mt76_rx_token_consume(dev, data, txwi, buf->addr);
> +		if (rx_token < 0) {
> +			mt76_put_rxwi(dev, txwi);
> +			return -ENOMEM;
> +		}
> +
> +		buf1 |=3D FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
> +		ctrl |=3D MT_DMA_CTL_TO_HOST;
> +	}
> +
> +	WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
> +	WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
> +	WRITE_ONCE(desc->ctrl, cpu_to_le32(ctrl));
> +	WRITE_ONCE(desc->info, 0);
> +
> +	entry->dma_addr[0] =3D buf->addr;
> +	entry->dma_len[0] =3D buf->len;
> +	entry->txwi =3D txwi;
> +	entry->buf =3D data;
> +	entry->wcid =3D 0xffff;
> +	entry->skip_buf1 =3D true;
> +	q->head =3D (q->head + 1) % q->ndesc;
> +	q->queued++;
> +
> +	return idx;
> +}
> +
>  static int
>  mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
>  		 struct mt76_queue_buf *buf, int nbufs, u32 info,
> @@ -215,6 +261,11 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_q=
ueue *q,
>  	int i, idx =3D -1;
>  	u32 ctrl, next;
> +	if (txwi) {
> +		q->entry[q->head].txwi =3D DMA_DUMMY_DATA;
> +		q->entry[q->head].skip_buf0 =3D true;
> +	}
> +
>  	for (i =3D 0; i < nbufs; i +=3D 2, buf +=3D 2) {
>  		u32 buf0 =3D buf[0].addr, buf1 =3D 0;
> @@ -224,51 +275,28 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_=
queue *q,
>  		desc =3D &q->desc[idx];
>  		entry =3D &q->entry[idx];
> -		if ((q->flags & MT_QFLAG_WED) &&
> -		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
> -			struct mt76_txwi_cache *t =3D txwi;
> -			int rx_token;
> -
> -			if (!t)
> -				return -ENOMEM;
> -
> -			rx_token =3D mt76_rx_token_consume(dev, (void *)skb, t,
> -							 buf[0].addr);
> -			if (rx_token < 0)
> -				return -ENOMEM;
> -
> -			buf1 |=3D FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
> -			ctrl =3D FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
> -			       MT_DMA_CTL_TO_HOST;
> -		} else {
> -			if (txwi) {
> -				q->entry[next].txwi =3D DMA_DUMMY_DATA;
> -				q->entry[next].skip_buf0 =3D true;
> -			}
> -
> -			if (buf[0].skip_unmap)
> -				entry->skip_buf0 =3D true;
> -			entry->skip_buf1 =3D i =3D=3D nbufs - 1;
> -
> -			entry->dma_addr[0] =3D buf[0].addr;
> -			entry->dma_len[0] =3D buf[0].len;
> -
> -			ctrl =3D FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
> -			if (i < nbufs - 1) {
> -				entry->dma_addr[1] =3D buf[1].addr;
> -				entry->dma_len[1] =3D buf[1].len;
> -				buf1 =3D buf[1].addr;
> -				ctrl |=3D FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
> -				if (buf[1].skip_unmap)
> -					entry->skip_buf1 =3D true;
> -			}
> -
> -			if (i =3D=3D nbufs - 1)
> -				ctrl |=3D MT_DMA_CTL_LAST_SEC0;
> -			else if (i =3D=3D nbufs - 2)
> -				ctrl |=3D MT_DMA_CTL_LAST_SEC1;
> +		if (buf[0].skip_unmap)
> +			entry->skip_buf0 =3D true;
> +		entry->skip_buf1 =3D i =3D=3D nbufs - 1;
> +
> +		entry->dma_addr[0] =3D buf[0].addr;
> +		entry->dma_len[0] =3D buf[0].len;
> +
> +		ctrl =3D FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len);
> +		if (i < nbufs - 1) {
> +			entry->dma_addr[1] =3D buf[1].addr;
> +			entry->dma_len[1] =3D buf[1].len;
> +			buf1 =3D buf[1].addr;
> +			ctrl |=3D FIELD_PREP(MT_DMA_CTL_SD_LEN1, buf[1].len);
> +			if (buf[1].skip_unmap)
> +				entry->skip_buf1 =3D true;
>  		}
> +		if (i =3D=3D nbufs - 1)
> +			ctrl |=3D MT_DMA_CTL_LAST_SEC0;
> +		else if (i =3D=3D nbufs - 2)
> +			ctrl |=3D MT_DMA_CTL_LAST_SEC1;
> +
>  		WRITE_ONCE(desc->buf0, cpu_to_le32(buf0));
>  		WRITE_ONCE(desc->buf1, cpu_to_le32(buf1));
>  		WRITE_ONCE(desc->info, cpu_to_le32(info));
> @@ -567,17 +595,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_q=
ueue *q)
>  	spin_lock_bh(&q->lock);
>  	while (q->queued < q->ndesc - 1) {
> -		struct mt76_txwi_cache *t =3D NULL;
>  		struct mt76_queue_buf qbuf;
>  		void *buf =3D NULL;
> -		if ((q->flags & MT_QFLAG_WED) &&
> -		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
> -			t =3D mt76_get_rxwi(dev);
> -			if (!t)
> -				break;
> -		}
> -
>  		buf =3D page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
>  		if (!buf)
>  			break;
> @@ -591,7 +611,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_qu=
eue *q)
>  		qbuf.addr =3D addr + offset;
>  		qbuf.len =3D len - offset;
>  		qbuf.skip_unmap =3D false;
> -		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
> +		if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
>  			dma_unmap_single(dev->dma_dev, addr, len,
>  					 DMA_FROM_DEVICE);
>  			skb_free_frag(buf);
>=20

--8r/cDTU/p+QQtpFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6MvLgAKCRA6cBh0uS2t
rB4/AQChIEW0bPXvse07Y2wmrgktWdBGYn108B4OPLQxXqXRJQEA2bO5f1KbCjev
PZto9Aja5p18nE7G/40I3Z8ZtimpYgw=
=oSsM
-----END PGP SIGNATURE-----

--8r/cDTU/p+QQtpFQ--
