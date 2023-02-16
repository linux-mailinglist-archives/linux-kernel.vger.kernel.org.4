Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB188698EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBPI07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBPI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:26:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEA728F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:26:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso964464wmo.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOIWYd8BLDoyQEOPcZt4Svqq+LpSVhiHkQEJPlmTjCU=;
        b=gQQYrG/1mNO98m/E2eyHzHqpo6XYMXhiLOQXglwZ4h8TDlIFXOZpm4yAFQplmmC41D
         7XiDwxsE0b/FzKA82rMi+AzPmyHSjEijKHHqAmtPv+/Ovv+IBObjW3kmdbH4+3GuGnJm
         K7VLjrmQewjjs1wo+Dy8A5pFVsV4oIHkbxjTdraSyS00/H5KensGE7N68jN0qciAzlWN
         2dslCN6QYjBdqMHZbnqkZ1Cg9t49kvOXErNX5LX5yVNR0LYZEbppgpasq5gO3toLKOlN
         qnV/wi4O1TY/2Up0xfgyGO6IV9+rZ77xL9WDMRH0iFYz1Hhxwpf/2SG8fVmn/5+V2FUE
         DJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOIWYd8BLDoyQEOPcZt4Svqq+LpSVhiHkQEJPlmTjCU=;
        b=3ktfsHG5GGrZYoe1DX0zw61JXnpkU9/LQ8xJFtZMs0MuQR9cQc3TVTckfNd15YfYON
         8kereu7LnSI7Hsx43dIuqPuv7y08ER7vB96nbjMEiBnQ5aGR0M1Oj3KB1YLbcQlends4
         rp8jB3SkkZGdjM1XybECrJEZA/CxDXvRP4kDtr8NGQVAg7gRJG47Nc5V3tZrEuACm1Cy
         imte9LEziA4xFSQ2K9XPNGyUH2BjT2CGUIOJh/4VBb8U8J/hrKRlWYMzltAaKTCPcfCT
         IY4kWPDgHhE501Z8UxiKgu4j1q+naowHb1r3GiE9viJ3S7zSb4GesYtYoLH6jiCPeZ6O
         slBg==
X-Gm-Message-State: AO0yUKWW26OGW7+wpv1MWOdAGWAzId1DC7CQdG3RzT7+1cG1okaBNmWd
        6W5BYgPPzXB3ArhAfChC6nI4jJLYQgFhbw==
X-Google-Smtp-Source: AK7set9/pDvtB0jb0WFogLcLbNy5p3XJ4qGM2jDVG+gk/LL8mu9qravOWh3Dr7k1FeiVRIAHBXWc3A==
X-Received: by 2002:a05:600c:3ba1:b0:3dc:1ad6:55fd with SMTP id n33-20020a05600c3ba100b003dc1ad655fdmr4362575wms.32.1676536014935;
        Thu, 16 Feb 2023 00:26:54 -0800 (PST)
Received: from suse.localnet (host-79-49-12-231.retail.telecomitalia.it. [79.49.12.231])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003dff870ce0esm5099595wmq.2.2023.02.16.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:26:54 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING in usb_tx_block/usb_submit_urb
Date:   Thu, 16 Feb 2023 09:26:53 +0100
Message-ID: <2277739.ElGaqSPkdT@suse>
In-Reply-To: <00000000000039636e05f4cc5da3@google.com>
References: <00000000000039636e05f4cc5da3@google.com>
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

On gioved=EC 16 febbraio 2023 08:44:18 CET syzbot wrote:
> Hello,
>=20
> syzbot tried to test the proposed patch but the build/boot failed:
>=20
> drivers/net/wireless/marvell/libertas/if_usb.c:865:43: error: expected ';'
> before ':' token
>=20
>=20
> Tested on:
>=20
> commit:         f87b5646 dt-bindings: usb: amlogic,meson-g12a-usb-ctrl..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/
usb.git
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D355c68b459d1d96=
c4d06
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls
> for Debian) 2.35.2 patch:        =20
> https://syzkaller.appspot.com/x/patch.diff?x=3D1414acf0c80000

Sorry for this syntax error :-(

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git=20
f87b564686ee

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/
wireless/marvell/libertas/if_usb.c
index 20436a289d5c..e03a5dcf6dab 100644
=2D-- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -859,6 +859,7 @@ static void if_usb_prog_firmware(struct lbs_private *pr=
iv,=20
int ret,
                        j++;
                        msleep_interruptible(100);
                } while (cardp->bootcmdresp =3D=3D 0 && j < 10);
+               usb_kill_urb(cardp->tx_urb);
        } while (cardp->bootcmdresp =3D=3D 0 && i < 5);

        if (cardp->bootcmdresp =3D=3D BOOT_CMD_RESP_NOT_SUPPORTED) {
=2D-

=46abio



