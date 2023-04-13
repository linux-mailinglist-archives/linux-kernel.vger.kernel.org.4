Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B56E0A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDMJVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:21:15 -0400
Received: from a11-129.smtp-out.amazonses.com (a11-129.smtp-out.amazonses.com [54.240.11.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F7D19AF;
        Thu, 13 Apr 2023 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gwkuid74newif2lbp44dedrl2t4vmmbs; d=benbenng.net; t=1681377673;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
        bh=iCGZGKi5slX3+1EbZTs0K5lMxThH+s23lVBYdgse0I4=;
        b=dlXM0RiS+bkfvggjXjPyBfra2Ys+k+cPbgT4qIBDtC9qV7H8zF0wgVzGG0/nJfRA
        LxR8YxEr2hW86KQYAzg+NDcj2ZJi/dSwj5OEjtIcHVr9imYmF/QZVAEpBB7BHhF1Jrc
        yRzzUaNovUpPZ4qeQfpcgSfNq0v6g3iWyckCfifIBu7vwuEVFAS3KoxK+aJkTqacubu
        2Y3xtkdqp6Z6MLlcIsuZx4Iij9oPVmxmSlbiypjCn8HP3vUxdamXbnZwXMnDnLxgxpd
        tKhGWmm2rbjM1kdaMYFNILIV1D7q0hLTsDbu5W/4e5lS+o0vdTHExkzku7K8yPJrHr7
        8pEdPHNA4A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1681377673;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
        bh=iCGZGKi5slX3+1EbZTs0K5lMxThH+s23lVBYdgse0I4=;
        b=O5xpWDesy/hJag71jGjX6AgswpCtnGJulyPR0BS0RRk+bCsgMW/CnnteBDlOoNHh
        0kAjpSf6xKrUhzfCsQYCuy4FYY2Z3YGJ2iLQ1+dJ2hyfCHtMxwikL6SmQFV8TMdKzKy
        jm5wIM89DS99ICEu30a1OGlfYn20ugayypjSMF88=
Subject: [PATCH] Initialization of read buffer for dib3000_read_reg
From:   =?UTF-8?Q?Kernel-Development?= <kdev@benbenng.net>
To:     =?UTF-8?Q?mchehab=40kernel=2Eorg?= <mchehab@kernel.org>
Cc:     =?UTF-8?Q?linux-media=40vger=2Ekernel=2Eorg?= 
        <linux-media@vger.kernel.org>,
        =?UTF-8?Q?linux-kernel=40vger=2Ekernel=2E?= =?UTF-8?Q?org?= 
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?skhan=40linuxfo?= =?UTF-8?Q?undation=2Eorg?= 
        <skhan@linuxfoundation.org>,
        =?UTF-8?Q?linux-kernel-mentees=40lists=2Elinuxfoundation=2Eorg?= 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        =?UTF-8?Q?syzbot+c88fc0ebe0d5935c70da=40syzkaller=2Eappspotmail=2Ecom?= 
        <syzbot+c88fc0ebe0d5935c70da@syzkaller.appspotmail.com>,
        =?UTF-8?Q?Kernel-Development?= <kdev@benbenng.net>
Date:   Thu, 13 Apr 2023 09:21:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20230413091841.22000-1-kdev@benbenng.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHZbelJ3+E1CTjNR3uk6Rz3nyFiTw==
Thread-Topic: [PATCH] Initialization of read buffer for dib3000_read_reg
X-Original-Mailer: git-send-email 2.39.2
X-Wm-Sent-Timestamp: 1681377672
Message-ID: <0100018779eb40dc-cee9e39d-5d87-4733-83db-eca5218fcc8f-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.04.13-54.240.11.129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch that fixes a bug:=0D=0AKMSAN: uninit-value in dib3000mb_a=
ttach (2)=0D=0A=0D=0ALocal variable u8 rb[2] is not initialized as it is =
used as read buffer=0D=0Afor i2c_transfer(). It is expected that i2c_tran=
sfer() should fill in=0D=0Athe buffer before the target function returns =
rb's content. However=0D=0Aerror handling of i2c_transfer is not done, an=
d on occasions where the=0D=0Aread fails, uninitialized rb value will be =
returned.=0D=0A=0D=0AThe usage of this function, defined as macro rd() in=
=0D=0Adrivers/media/dvb-frontends/dib3000mb_priv,h, does not expect any e=
rror=0D=0Ato occur. Adding error handling here might involve significant =
code=0D=0Achanges.=0D=0A=0D=0AThus 0-initialization is done on rb. This m=
ight affect some logic on=0D=0Aerror case as the use of the return value =
is used as boolean and flags.=0D=0A=0D=0AReported-by: syzbot+c88fc0ebe0d5=
935c70da@syzkaller.appspotmail.com=0D=0ALink: https://syzkaller.appspot.c=
om/bug=3Fid=3D2f4d19de8c9e9f0b9794e53ca54d68e0ffe9f068=0D=0ASigned-off-by=
: (Ben) HokChun Ng <kdev@benbenng.net>=0D=0A---=0D=0A drivers/media/dvb-f=
rontends/dib3000mb.c | 10 +++++++---=0D=0A 1 file changed, 7 insertions(+=
), 3 deletions(-)=0D=0A=0D=0Adiff --git a/drivers/media/dvb-frontends/dib=
3000mb.c b/drivers/media/dvb-frontends/dib3000mb.c=0D=0Aindex a6c2fc4586e=
b..0dd96656aaf4 100644=0D=0A--- a/drivers/media/dvb-frontends/dib3000mb.c=
=0D=0A+++ b/drivers/media/dvb-frontends/dib3000mb.c=0D=0A@@ -50,15 +50,19=
 @@ MODULE_PARM_DESC(debug, "set debugging level (1=3Dinfo,2=3Dxfer,4=3Ds=
etfe,8=3Dgetfe (|-a=0D=0A=20=0D=0A static int dib3000_read_reg(struct dib=
3000_state *state, u16 reg)=0D=0A {=0D=0A+=09int errno;=0D=0A =09u8 wb[] =
=3D { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };=0D=0A-=09u8 rb[2];=0D=0A+=
=09u8 rb[2] =3D { 0, 0 };=0D=0A =09struct i2c_msg msg[] =3D {=0D=0A =09=09=
{ .addr =3D state->config.demod_address, .flags =3D 0,        .buf =3D wb=
, .len =3D 2 },=0D=0A =09=09{ .addr =3D state->config.demod_address, .fla=
gs =3D I2C_M_RD, .buf =3D rb, .len =3D 2 },=0D=0A =09};=0D=0A=20=0D=0A-=09=
if (i2c_transfer(state->i2c, msg, 2) !=3D 2)=0D=0A-=09=09deb_i2c("i2c rea=
d error\n");=0D=0A+=09errno =3D i2c_transfer(state->i2c, msg, 2);=0D=0A+=09=
if (errno !=3D 2) {=0D=0A+=09=09deb_i2c("i2c read error (errno: %d)\n", -=
errno);=0D=0A+=09=09return 0;=0D=0A+=09}=0D=0A=20=0D=0A =09deb_i2c("readi=
ng i2c bus (reg: %5d 0x%04x, val: %5d 0x%04x)\n",reg,reg,=0D=0A =09=09=09=
(rb[0] << 8) | rb[1],(rb[0] << 8) | rb[1]);=0D=0A--=20=0D=0A2.39.2=0D=0A=0D=
=0A
