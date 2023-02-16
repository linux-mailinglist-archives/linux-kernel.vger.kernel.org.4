Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D54698FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBPJVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:21:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00A4C6C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:21:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y1so1190628wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5YZFhNivBYm3Ht4xP824TDdsqt5AmGz0c0Eznki7xA=;
        b=osM7EwObsg0gUvo/PhzvtOQjSPvS4WvLVpTP3aNm7l5zLnYcqhKbsjiFH9Q06jbZZi
         gniE7fcsB3jPLjXffTatNunTNl6XqsRNrqLACqYZy1CSZ3k9Aw6VvEEPAKlEg7O5pUZD
         UM61ECD2YqAPWhiUlEjVebBc22ZkdsgQ2fj2vbhX2bS6D9ofxgPomrPn+gvmnrA3v7lN
         USujo4J3CIziBhEeIKg8TB7k80qeM29lPmUJF+6Ce/vM8K8j0YP8iCeKuRAXE0YHzW8Y
         SRrtMqgsLZ4U8WX2utdb8K9gvNMGmpNSa8UOplciTbEYy3frmbbQl2duiHpkbOL3W+zT
         /TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5YZFhNivBYm3Ht4xP824TDdsqt5AmGz0c0Eznki7xA=;
        b=Qf2iZlz/aQTE7GP7O03z6z+1r9IJp9UDnZJLB9HvH/DjUxLPEhdqTl6G+kqXxK+y2Y
         hbNrMGb/u4ARJHQeTeA++2jZXbpLVY2E4Ggg6h3t0g/RRHPGk75UCI24Js/VoS0YHA/M
         2jV1fB9sNGnRdAms8jZQlMa5GEfJAzJmvu4z14sLiwZ9Dc89s1Q68mYf1eEawezOeC3V
         Y5axsWh/YlLUURBl30DSDZzv2OO9PhwX3pNsjEeiE4Ak3yUmdSCGDdUOI2sQwevULxeh
         d94kQMl37LnILNjQkXFCrVSuw5vSLtYTwm+9bFa1Y05bB0y4kZFU9YAM9YdWA2dWC8Vx
         sTyw==
X-Gm-Message-State: AO0yUKVYqr3AU7LdlhBLQ28DmMsDfZpn1W9+CSmVMH1fHSMq7+z6PzI7
        3Z47KN+iSA2YRmGmMC1LzAk=
X-Google-Smtp-Source: AK7set+cSpnX+0tiHM9OhttPEkEZ3z7tKVY0srvGkxWq9+7j5SrYLZB/9RF/7wtWFjuEkC/V2COKdQ==
X-Received: by 2002:a05:6000:1052:b0:2c5:54a7:363f with SMTP id c18-20020a056000105200b002c554a7363fmr3909111wrx.63.1676539294968;
        Thu, 16 Feb 2023 01:21:34 -0800 (PST)
Received: from suse.localnet (host-79-49-12-231.retail.telecomitalia.it. [79.49.12.231])
        by smtp.gmail.com with ESMTPSA id r9-20020a5d4989000000b002c560e6ea57sm993840wrq.47.2023.02.16.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:21:34 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING in usb_tx_block/usb_submit_urb
Date:   Thu, 16 Feb 2023 10:21:33 +0100
Message-ID: <2878263.e9J7NaK4W3@suse>
In-Reply-To: <20230216081834.1432-1-hdanton@sina.com>
References: <20230215110515.3833-1-hdanton@sina.com>
 <20230216081834.1432-1-hdanton@sina.com>
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

On gioved=EC 16 febbraio 2023 09:18:34 CET Hillf Danton wrote:
> Fabio!
>=20
> On Thu, 16 Feb 2023 07:54:08 +0100 Fabio M. De Francesco
> <fmdefrancesco@gmail.com>
> > >  	do {
> > >  =09
> > >  		int j =3D3D 0;
> > >  		i++;
> > >=20
> > > -		if_usb_issue_boot_command(cardp, BOOT_CMD_FW_BY_USB);
> >=20
> > Don't we need to call if_usb_issue_boot_command() in a loop in order to
> > retry
> > the command?
>=20
> Nope certainly because of no sense made by sending it again, given no
> response this round.
>=20

Your argument looks reasonable but...

=46or what regards subsystems/drivers whose I'm not expert I always assume =
that=20
the authors know what they do despite bugs. I mean that looks more probable=
=20
that they have reasons to issue several calls to if_usb_issue_boot_command(=
) /=20
usb_submit_urb in a loop. May be that those usb_submit_urb get lost in some=
=20
particular conditions, since they decide to try if_usb_issue_boot_command()=
 in=20
a loop (but forget to kill the URB before next iteration).

I have no reasons to think you are wrong. However I don't understand the=20
reason that made you leave the loops untouched (except the line with the ca=
ll=20
to if_usb_issue_boot_command().

I suppose that, if you confirm that we have no reasons to reiterate that ca=
ll,=20
you should also leave only one loop waiting for response.

Am I missing something?

Thanks,

=46abio



