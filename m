Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9320E698D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBPGyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:54:13 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F761F5E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:54:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso3363153wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj0QG8nvf21hIQsxvEw/yH0NICoBtXBJwbjm1rJDX4g=;
        b=GR7U/Owre8s0XiYTvIEUDjTSL9qJG1HtM6Q96Flz67RcIWcxn6EyZu2cr4KIy7SAGA
         nnA5K5ZbavE6J1U+bVh8n8Qa4q5g5pfiAXjmluOrBEmOd+5jGvM61sztIQCw4/ZISvbD
         mPYCqhfhaQ52pkjXJJDt0KqqiWOxd95iaYAJRPAoS+sJ4D6PpYKCy9aECN3h5ToDMqqX
         1aUHgakw1YFmBUutySraoFiZsk6SwMlPIcySrAMqNU0w6Q5wJdYbpEreKZY5x6rGJJs+
         YGYyIOPRhWlLVhzO3sFZjWmA7RB2lUA1k+s6YZzavohmR9QnJimke0ef5D3ySSoMw83q
         Tahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj0QG8nvf21hIQsxvEw/yH0NICoBtXBJwbjm1rJDX4g=;
        b=MsM4BPI4tKvJSBM95U6f/6CiBjf/+oELeEKnCBh5Shd+ICgIYLJlENa92bWnuKiazB
         2G3UbvxFYhn12yyCTFxSR0Z3JSXUzsvOWd3Dk8u95+jawStQbyXmvKGp8YSUBdivBcwF
         cLLapUdEH4p7XFzy9cycX1UCzSGp+H2ihgQVjQtEzrgNfYh3YcZRKmeY+IxoDuTB/ygv
         G9lTbTiYkPQAujh+cldlbdjXHg8YueqeJOPVH+1sPqA6+e+iRN0GbQmGPvqwokazfw5g
         aYfA5249dPYsAL3DUpJJamH/9HhZH2yEjnPMk8wu8bcWJSfW/T1VT8u4B1IZ+ue9V7ll
         7ryA==
X-Gm-Message-State: AO0yUKUEEPpVJM0p9atSXHrqG+/8z8mqCmJJzhM0l6jYUGHVzYEpgXej
        Jy/1W6mlnffV65ExBl5n1Qc=
X-Google-Smtp-Source: AK7set+8kwws3RW3mynoq97vnkutzu6opAd6GOoSaDXlmG7IlhZ3rKd7N74Ffm9xHSLOL3rXGRwbgA==
X-Received: by 2002:a05:600c:90f:b0:3df:3bd6:63e5 with SMTP id m15-20020a05600c090f00b003df3bd663e5mr3948253wmp.12.1676530450236;
        Wed, 15 Feb 2023 22:54:10 -0800 (PST)
Received: from suse.localnet (host-79-49-12-231.retail.telecomitalia.it. [79.49.12.231])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc009000000b003dc4a47605fsm4457083wmb.8.2023.02.15.22.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 22:54:09 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     syzbot <syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in usb_tx_block/usb_submit_urb
Date:   Thu, 16 Feb 2023 07:54:08 +0100
Message-ID: <2136128.irdbgypaU6@suse>
In-Reply-To: <20230215110515.3833-1-hdanton@sina.com>
References: <20230215110515.3833-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 15 febbraio 2023 12:05:15 CET Hillf Danton wrote:
> On Tue, 14 Feb 2023 23:00:47 -0800
>=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    f87b564686ee dt-bindings: usb: amlogic,meson-g12a-usb-
ctrl..
> > git tree:     =20
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-test=
ing
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1670f2b3480=
000
> Kill urb in flight after submitting it.
>=20
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git=
=20
> f87b564686ee
>=20
> --- x/drivers/net/wireless/marvell/libertas/if_usb.c
> +++ y/drivers/net/wireless/marvell/libertas/if_usb.c
> @@ -763,9 +763,7 @@ static int if_usb_issue_boot_command(str
>  	memset(bootcmd->pad, 0, sizeof(bootcmd->pad));
>=20
>  	/* Issue command */
> -	usb_tx_block(cardp, cardp->ep_out_buf, sizeof(*bootcmd));
> -
> -	return 0;
> +	return usb_tx_block(cardp, cardp->ep_out_buf, sizeof(*bootcmd));
>  }
>=20
>=20
> @@ -853,10 +851,12 @@ restart:
>  	}

>=20
>  	cardp->bootcmdresp =3D 0;
> +	ret =3D if_usb_issue_boot_command(cardp, BOOT_CMD_FW_BY_USB);
> +	if (ret)
> +		goto done;

I think that you are changing the logic here (please read below)...

>  	do {
>  		int j =3D 0;
>  		i++;
> -		if_usb_issue_boot_command(cardp, BOOT_CMD_FW_BY_USB);

Don't we need to call if_usb_issue_boot_command() in a loop in order to ret=
ry=20
the command?

>  		/* wait for command response */
>  		do {
>  			j++;
> @@ -864,6 +864,8 @@ restart:
>  		} while (cardp->bootcmdresp =3D=3D 0 && j < 10);
>  	} while (cardp->bootcmdresp =3D=3D 0 && i < 5);
>=20
> +	usb_kill_urb(cardp->tx_urb);
> +

I'm not an expert in the USB core, anyway calling usb_kill_urb() looks good=
 to=20
me, but I think we should call it after each call of=20
if_usb_issue_boot_command() in the above outer loop.

>  	if (cardp->bootcmdresp =3D=3D BOOT_CMD_RESP_NOT_SUPPORTED) {
>  		/* Return to normal operation */
>  		ret =3D -EOPNOTSUPP;
> --

Can the following work?

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git=20
f87b564686ee

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/
wireless/marvell/libertas/if_usb.c
index 20436a289d5c..626357d0c7b0 100644
=2D-- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -859,6 +859,7 @@ static void if_usb_prog_firmware(struct lbs_private *pr=
iv,=20
int ret,
                        j++;
                        msleep_interruptible(100);
                } while (cardp->bootcmdresp =3D=3D 0 && j < 10);
+               usb_kill_urb(cardp->tx_urb):
        } while (cardp->bootcmdresp =3D=3D 0 && i < 5);
=20
        if (cardp->bootcmdresp =3D=3D BOOT_CMD_RESP_NOT_SUPPORTED) {
=2D-

Thanks,

=46abio


