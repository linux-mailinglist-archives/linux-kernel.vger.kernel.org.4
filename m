Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E3624F55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiKKBOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiKKBOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:14:04 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21FAE4D5FB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:13:56 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 707E83E;
        Fri, 11 Nov 2022 02:13:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1668129235;
        bh=0kckHfo17/7CxxS3uU74bmVO2tWtQZd8qM2WTPZDjoc=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=KvOYeYyf4R08Vzi6NMJT5zJQ0D3fVkYp8mStu1m+acRHG2dA2VPtn13CE9PV8OTld
         d/WKEmGkD7wrMCwb2HyhNRevVbKW5Fl7dkR3Mb3glaIsAWj8IXU2PHhClE2dgHO7GK
         BOMvt6fnHAhrmmgygJWcLa4NEpdW19AOW8/Njn5NuPNGIylAzcvUqoMjutk9O/Rfv1
         /jN+khTui7ZzAs1Cefzk49MlPGA9qyk4U3X7lqkHgQCtPu4LiedNOn9zKfFuaiFv0x
         opQ5VptNI5sgCBAKqIYCvLx3OqSjQVC9ZvNuoQf3mTXms8RgVhINr3Mp7C/+2GAJ3e
         lQX049droUA4Q==
Date:   Fri, 11 Nov 2022 02:13:54 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] pcmcia: synclink_cs: remove dead paranoia_check,
 warn for missing line
Message-ID: <6632531db322b3b2ca8088088ad6c685cf0f8983.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gtskmfwf2b3a3zvv"
Content-Disposition: inline
In-Reply-To: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gtskmfwf2b3a3zvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

MGSLPC_PARANOIA_CHECK has never been defined automatically, and devices
with null driver_info can't happen, since we reject the open in that case.

Move the log statement from dead code to the check, and log the state
inconsistency like we do above for the line count ("invalid line #%d.").

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/char/pcmcia/synclink_cs.c | 69 ++-----------------------------
 1 file changed, 4 insertions(+), 65 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/syncli=
nk_cs.c
index 262f087bfc01..5aecb5e5cf18 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -644,25 +644,6 @@ static int mgslpc_resume(struct pcmcia_device *link)
 }
=20
=20
-static inline bool mgslpc_paranoia_check(MGSLPC_INFO *info,
-					char *name, const char *routine)
-{
-#ifdef MGSLPC_PARANOIA_CHECK
-	static const char *badinfo =3D
-		"Warning: null mgslpc_info for (%s) in %s\n";
-
-	if (!info) {
-		printk(badinfo, name, routine);
-		return true;
-	}
-#else
-	if (!info)
-		return true;
-#endif
-	return false;
-}
-
-
 #define CMD_RXFIFO      BIT7	// release current rx FIFO
 #define CMD_RXRESET     BIT6	// receiver reset
 #define CMD_RXFIFO_READ BIT5
@@ -694,8 +675,6 @@ static void tx_pause(struct tty_struct *tty)
 	MGSLPC_INFO *info =3D (MGSLPC_INFO *)tty->driver_data;
 	unsigned long flags;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "tx_pause"))
-		return;
 	if (debug_level >=3D DEBUG_LEVEL_INFO)
 		printk("tx_pause(%s)\n", info->device_name);
=20
@@ -710,8 +689,6 @@ static void tx_release(struct tty_struct *tty)
 	MGSLPC_INFO *info =3D (MGSLPC_INFO *)tty->driver_data;
 	unsigned long flags;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "tx_release"))
-		return;
 	if (debug_level >=3D DEBUG_LEVEL_INFO)
 		printk("tx_release(%s)\n", info->device_name);
=20
@@ -1476,9 +1453,6 @@ static int mgslpc_put_char(struct tty_struct *tty, un=
signed char ch)
 			__FILE__, __LINE__, ch, info->device_name);
 	}
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_put_char"))
-		return 0;
-
 	if (!info->tx_buf)
 		return 0;
=20
@@ -1508,9 +1482,6 @@ static void mgslpc_flush_chars(struct tty_struct *tty)
 		printk("%s(%d):mgslpc_flush_chars() entry on %s tx_count=3D%d\n",
 			__FILE__, __LINE__, info->device_name, info->tx_count);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_flush_chars"))
-		return;
-
 	if (info->tx_count <=3D 0 || tty->flow.stopped ||
 	    tty->hw_stopped || !info->tx_buf)
 		return;
@@ -1546,8 +1517,7 @@ static int mgslpc_write(struct tty_struct * tty,
 		printk("%s(%d):mgslpc_write(%s) count=3D%d\n",
 			__FILE__, __LINE__, info->device_name, count);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_write") ||
-		!info->tx_buf)
+	if (!info->tx_buf)
 		goto cleanup;
=20
 	if (info->params.mode =3D=3D MGSL_MODE_HDLC) {
@@ -1600,9 +1570,6 @@ static unsigned int mgslpc_write_room(struct tty_stru=
ct *tty)
 	MGSLPC_INFO *info =3D (MGSLPC_INFO *)tty->driver_data;
 	int ret;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_write_room"))
-		return 0;
-
 	if (info->params.mode =3D=3D MGSL_MODE_HDLC) {
 		/* HDLC (frame oriented) mode */
 		if (info->tx_active)
@@ -1632,9 +1599,6 @@ static unsigned int mgslpc_chars_in_buffer(struct tty=
_struct *tty)
 		printk("%s(%d):mgslpc_chars_in_buffer(%s)\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_chars_in_buffer"))
-		return 0;
-
 	if (info->params.mode =3D=3D MGSL_MODE_HDLC)
 		rc =3D info->tx_active ? info->max_frame_size : 0;
 	else
@@ -1658,9 +1622,6 @@ static void mgslpc_flush_buffer(struct tty_struct *tt=
y)
 		printk("%s(%d):mgslpc_flush_buffer(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_flush_buffer"))
-		return;
-
 	spin_lock_irqsave(&info->lock, flags);
 	info->tx_count =3D info->tx_put =3D info->tx_get =3D 0;
 	del_timer(&info->tx_timer);
@@ -1681,9 +1642,6 @@ static void mgslpc_send_xchar(struct tty_struct *tty,=
 char ch)
 		printk("%s(%d):mgslpc_send_xchar(%s,%d)\n",
 			 __FILE__, __LINE__, info->device_name, ch);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_send_xchar"))
-		return;
-
 	info->x_char =3D ch;
 	if (ch) {
 		spin_lock_irqsave(&info->lock, flags);
@@ -1704,9 +1662,6 @@ static void mgslpc_throttle(struct tty_struct * tty)
 		printk("%s(%d):mgslpc_throttle(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_throttle"))
-		return;
-
 	if (I_IXOFF(tty))
 		mgslpc_send_xchar(tty, STOP_CHAR(tty));
=20
@@ -1729,9 +1684,6 @@ static void mgslpc_unthrottle(struct tty_struct * tty)
 		printk("%s(%d):mgslpc_unthrottle(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_unthrottle"))
-		return;
-
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char =3D 0;
@@ -2160,9 +2112,6 @@ static int mgslpc_break(struct tty_struct *tty, int b=
reak_state)
 		printk("%s(%d):mgslpc_break(%s,%d)\n",
 			 __FILE__, __LINE__, info->device_name, break_state);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_break"))
-		return -EINVAL;
-
 	spin_lock_irqsave(&info->lock, flags);
 	if (break_state =3D=3D -1)
 		set_reg_bits(info, CHA+DAFO, BIT6);
@@ -2218,9 +2167,6 @@ static int mgslpc_ioctl(struct tty_struct *tty,
 		printk("%s(%d):mgslpc_ioctl %s cmd=3D%08X\n", __FILE__, __LINE__,
 			info->device_name, cmd);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_ioctl"))
-		return -ENODEV;
-
 	if (cmd !=3D TIOCMIWAIT) {
 		if (tty_io_error(tty))
 		    return -EIO;
@@ -2312,9 +2258,6 @@ static void mgslpc_close(struct tty_struct *tty, stru=
ct file * filp)
 	MGSLPC_INFO * info =3D (MGSLPC_INFO *)tty->driver_data;
 	struct tty_port *port =3D &info->port;
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_close"))
-		return;
-
 	if (debug_level >=3D DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) entry, count=3D%d\n",
 			 __FILE__, __LINE__, info->device_name, port->count);
@@ -2352,9 +2295,6 @@ static void mgslpc_wait_until_sent(struct tty_struct =
*tty, int timeout)
 		printk("%s(%d):mgslpc_wait_until_sent(%s) entry\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_wait_until_sent"))
-		return;
-
 	if (!tty_port_initialized(&info->port))
 		goto exit;
=20
@@ -2412,9 +2352,6 @@ static void mgslpc_hangup(struct tty_struct *tty)
 		printk("%s(%d):mgslpc_hangup(%s)\n",
 			 __FILE__, __LINE__, info->device_name);
=20
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_hangup"))
-		return;
-
 	mgslpc_flush_buffer(tty);
 	shutdown(info, tty);
 	tty_port_hangup(&info->port);
@@ -2468,8 +2405,10 @@ static int mgslpc_open(struct tty_struct *tty, struc=
t file * filp)
 	info =3D mgslpc_device_list;
 	while(info && info->line !=3D line)
 		info =3D info->next_device;
-	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
+	if (!info) {
+		pr_warn("%s: no device for line #%d.\n", __func__, line);
 		return -ENODEV;
+	}
=20
 	port =3D &info->port;
 	tty->driver_data =3D info;
--=20
2.30.2

--gtskmfwf2b3a3zvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNtodEACgkQvP0LAY0m
WPELUxAApJvq8HlMdbr9/QDABPW059MEgufGCDlnWbVEw3Q2/1YZV3XqvbVJZt+b
zkDdhZb0zAPCtUn7rrao7m+Ts2xGyEY+y/KigNtoHQG+Hy8FWjdoeBpTE04LS94o
1ZD6w9p6A7QnJ5z/TayGWFgU+IvNLPuyQh6kRGZ4Mr+Dlc26/q2g41cjmNS5js5+
4yak9Y7+nhUhctVKKM4a6rzIxZIINY5HPFjXZsZz+2AdEx3HEDbOcPTBiKVVzebA
Odx8abaE5aGc+wDl5Y/rcKXUnP57k5wkC3DqSHABocI5v7j8S+6XmA6Un86Ani7l
A8Aut8Qn8nwWRCJlDZBctHwSz5o0IJDNeaBDTqeb/DEpRYVhDwqS9EsbR57xZfWA
lYQ4sAlF16hBaHdfCBZ3ElQzzu9p3uTaSG/8KyKoLmNBizBKSLlfnE4JXvn8hvMl
SEeqb+WEHAqFGiOI9Y6z/cXhaGe9YQCdzaMnnuGAmOpYACbtLiXtG3W1Jg0gNS5n
s81wxVOItXDGKaAl3W7dN3Y8IVz37pJUFK90iHXkfzWiAg8MvyMQmUzy8OaYNsjl
AKXXbihnk5Zt/F+e+zqvT5FfP6IHVX3SQbZ5DaPnI/YwWAFNzRldS8/7zYb+89cM
GgTAQ1V9V4BkhU0qPgqRuMHh24AURPpxNDQpqBozufa2uDbQCzg=
=4/gu
-----END PGP SIGNATURE-----

--gtskmfwf2b3a3zvv--
