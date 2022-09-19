Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166775BCAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiISLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiISLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:32:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785C27FD5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:32:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 41C901C0005; Mon, 19 Sep 2022 13:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1663587145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WY1gYrtCnNqGjs0Q/fpjBMLTKWRi7ReXkxQKX+F0iTI=;
        b=ec+KJvCqwqN50Os7AUV/P0YssxGbbWVP8Tc2ShvF2QMPGE2uXmGu6pbVR2jWplK9RLRGjO
        dkZmwuOb0H0WI6n4O1k3UTzbutxVb8g+sprxfCsHYX1zT7nFbH8HB9dGejZCMD9z700DA6
        sN6K6t2AKVzN2G/Naw1ebus1WOjWo0o=
Date:   Mon, 19 Sep 2022 13:32:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
Message-ID: <20220919113219.GA14632@duo.ucw.cz>
References: <20220826193545.20363-1-pchelkin@ispras.ru>
 <20220827091353.30160-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20220827091353.30160-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> spin_lock_irqsave(&gsm->tx_lock, flags) // taken a spinlock on TX data
>  con_write(...)
>   do_con_write(...)
>    console_lock()
>     might_sleep() // -> bug
>=20
> As far as console_lock() might sleep it should not be called with
> spinlock held.
>=20
> The patch replaces tx_lock spinlock with mutex in order to avoid the
> problem.
>

Do you have any hints why this might be correct?

Have you tested it?

Locking around line disciplines is spinlock_irqsave elsewhere in the
kernel.

Best regards,
								Pavel

> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>=20
> Fixes: 32dd59f96924 ("tty: n_gsm: fix race condition in gsmld_write()")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> v2->v1: sorry, now adapted patch from 5.10 to upstream
>=20
>  drivers/tty/n_gsm.c | 46 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index caa5c14ed57f..be62c601058d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -248,7 +248,7 @@ struct gsm_mux {
>  	bool constipated;		/* Asked by remote to shut up */
>  	bool has_devices;		/* Devices were registered */
> =20
> -	spinlock_t tx_lock;
> +	struct mutex tx_mutex;
>  	unsigned int tx_bytes;		/* TX data outstanding */
>  #define TX_THRESH_HI		8192
>  #define TX_THRESH_LO		2048
> @@ -680,7 +680,6 @@ static int gsm_send(struct gsm_mux *gsm, int addr, in=
t cr, int control)
>  	struct gsm_msg *msg;
>  	u8 *dp;
>  	int ocr;
> -	unsigned long flags;
> =20
>  	msg =3D gsm_data_alloc(gsm, addr, 0, control);
>  	if (!msg)
> @@ -702,10 +701,10 @@ static int gsm_send(struct gsm_mux *gsm, int addr, =
int cr, int control)
> =20
>  	gsm_print_packet("Q->", addr, cr, control, NULL, 0);
> =20
> -	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	mutex_lock(&gsm->tx_mutex);
>  	list_add_tail(&msg->list, &gsm->tx_ctrl_list);
>  	gsm->tx_bytes +=3D msg->len;
> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +	mutex_unlock(&gsm->tx_mutex);
>  	gsmld_write_trigger(gsm);
> =20
>  	return 0;
> @@ -730,7 +729,7 @@ static void gsm_dlci_clear_queues(struct gsm_mux *gsm=
, struct gsm_dlci *dlci)
>  	spin_unlock_irqrestore(&dlci->lock, flags);
> =20
>  	/* Clear data packets in MUX write queue */
> -	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	mutex_lock(&gsm->tx_mutex);
>  	list_for_each_entry_safe(msg, nmsg, &gsm->tx_data_list, list) {
>  		if (msg->addr !=3D addr)
>  			continue;
> @@ -738,7 +737,7 @@ static void gsm_dlci_clear_queues(struct gsm_mux *gsm=
, struct gsm_dlci *dlci)
>  		list_del(&msg->list);
>  		kfree(msg);
>  	}
> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +	mutex_unlock(&gsm->tx_mutex);
>  }
> =20
>  /**
> @@ -1024,10 +1023,9 @@ static void __gsm_data_queue(struct gsm_dlci *dlci=
, struct gsm_msg *msg)
> =20
>  static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>  {
> -	unsigned long flags;
> -	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
> +	mutex_lock(&dlci->gsm->tx_mutex);
>  	__gsm_data_queue(dlci, msg);
> -	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
> +	mutex_unlock(&dlci->gsm->tx_mutex);
>  }
> =20
>  /**
> @@ -1283,13 +1281,12 @@ static int gsm_dlci_data_sweep(struct gsm_mux *gs=
m)
> =20
>  static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
>  {
> -	unsigned long flags;
>  	int sweep;
> =20
>  	if (dlci->constipated)
>  		return;
> =20
> -	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
> +	mutex_lock(&dlci->gsm->tx_mutex);
>  	/* If we have nothing running then we need to fire up */
>  	sweep =3D (dlci->gsm->tx_bytes < TX_THRESH_LO);
>  	if (dlci->gsm->tx_bytes =3D=3D 0) {
> @@ -1300,7 +1297,7 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlc=
i)
>  	}
>  	if (sweep)
>  		gsm_dlci_data_sweep(dlci->gsm);
> -	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
> +	mutex_unlock(&dlci->gsm->tx_mutex);
>  }
> =20
>  /*
> @@ -1994,14 +1991,13 @@ static void gsm_dlci_command(struct gsm_dlci *dlc=
i, const u8 *data, int len)
>  static void gsm_kick_timer(struct timer_list *t)
>  {
>  	struct gsm_mux *gsm =3D from_timer(gsm, t, kick_timer);
> -	unsigned long flags;
>  	int sent =3D 0;
> =20
> -	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	mutex_lock(&gsm->tx_mutex);
>  	/* If we have nothing running then we need to fire up */
>  	if (gsm->tx_bytes < TX_THRESH_LO)
>  		sent =3D gsm_dlci_data_sweep(gsm);
> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +	mutex_unlock(&gsm->tx_mutex);
> =20
>  	if (sent && debug & 4)
>  		pr_info("%s TX queue stalled\n", __func__);
> @@ -2506,7 +2502,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>  	INIT_WORK(&gsm->tx_work, gsmld_write_task);
>  	init_waitqueue_head(&gsm->event);
>  	spin_lock_init(&gsm->control_lock);
> -	spin_lock_init(&gsm->tx_lock);
> +	mutex_init(&gsm->tx_mutex);
> =20
>  	if (gsm->encoding =3D=3D 0)
>  		gsm->receive =3D gsm0_receive;
> @@ -2538,6 +2534,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
>  			break;
>  		}
>  	}
> +	mutex_destroy(&gsm->tx_mutex);
>  	mutex_destroy(&gsm->mutex);
>  	kfree(gsm->txframe);
>  	kfree(gsm->buf);
> @@ -2609,6 +2606,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>  	}
>  	spin_lock_init(&gsm->lock);
>  	mutex_init(&gsm->mutex);
> +	mutex_init(&gsm->tx_mutex);
>  	kref_init(&gsm->ref);
>  	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
>  	INIT_LIST_HEAD(&gsm->tx_data_list);
> @@ -2636,6 +2634,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>  	}
>  	spin_unlock(&gsm_mux_lock);
>  	if (i =3D=3D MAX_MUX) {
> +		mutex_destroy(&gsm->tx_mutex);
>  		mutex_destroy(&gsm->mutex);
>  		kfree(gsm->txframe);
>  		kfree(gsm->buf);
> @@ -2791,17 +2790,16 @@ static void gsmld_write_trigger(struct gsm_mux *g=
sm)
>  static void gsmld_write_task(struct work_struct *work)
>  {
>  	struct gsm_mux *gsm =3D container_of(work, struct gsm_mux, tx_work);
> -	unsigned long flags;
>  	int i, ret;
> =20
>  	/* All outstanding control channel and control messages and one data
>  	 * frame is sent.
>  	 */
>  	ret =3D -ENODEV;
> -	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	mutex_lock(&gsm->tx_mutex);
>  	if (gsm->tty)
>  		ret =3D gsm_data_kick(gsm);
> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +	mutex_unlock(&gsm->tx_mutex);
> =20
>  	if (ret >=3D 0)
>  		for (i =3D 0; i < NUM_DLCI; i++)
> @@ -3012,7 +3010,6 @@ static ssize_t gsmld_write(struct tty_struct *tty, =
struct file *file,
>  			   const unsigned char *buf, size_t nr)
>  {
>  	struct gsm_mux *gsm =3D tty->disc_data;
> -	unsigned long flags;
>  	int space;
>  	int ret;
> =20
> @@ -3020,13 +3017,13 @@ static ssize_t gsmld_write(struct tty_struct *tty=
, struct file *file,
>  		return -ENODEV;
> =20
>  	ret =3D -ENOBUFS;
> -	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	mutex_lock(&gsm->tx_mutex);
>  	space =3D tty_write_room(tty);
>  	if (space >=3D nr)
>  		ret =3D tty->ops->write(tty, buf, nr);
>  	else
>  		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +	mutex_unlock(&gsm->tx_mutex);
> =20
>  	return ret;
>  }
> @@ -3323,14 +3320,13 @@ static struct tty_ldisc_ops tty_ldisc_packet =3D {
>  static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
>  {
>  	struct gsm_mux *gsm =3D dlci->gsm;
> -	unsigned long flags;
> =20
>  	if (dlci->state !=3D DLCI_OPEN || dlci->adaption !=3D 2)
>  		return;
> =20
> -	spin_lock_irqsave(&gsm->tx_lock, flags);
> +	mutex_lock(&gsm->tx_mutex);
>  	gsm_dlci_modem_output(gsm, dlci, brk);
> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
> +	mutex_unlock(&gsm->tx_mutex);
>  }
> =20
>  /**
> --=20
> 2.25.1

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYyhTQwAKCRAw5/Bqldv6
8q4tAKC/cyYt1Stb41DnnO2ozIRjSjgz5wCgk3wuQeK/GQk9V6AFLmrLUCB21IQ=
=XYeq
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
