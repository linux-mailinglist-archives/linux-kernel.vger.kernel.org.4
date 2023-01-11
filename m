Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87A665611
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAKI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjAKI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:27:32 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27C62CF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:27:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673425643; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WLttTbe0OBLBKXhG1AwbZOb/pNTqzUvwxt0Cn2mqy9o0TOdEUC2atWwjaJGzx7bLby31b3sb/nGBDDPXzhulZHHch00VuIRNuWzAmoWKvA8AEdcnBzF3OEfX6i+w5N/mzC3QTv1rdl4P3Yi5cmuGKyZR2zr1Ti5N+RFkzreWu4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1673425643; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AL3B+qazQnfPgbRbDFoqG8kIkUv3Qr7A1092cen/5qM=; 
        b=AANaiGaCYai4MhVvesABElebPkJb8sXBouhGXxLGh7OWgIQRjI4rg8rXyc2iQnA4Ef0zbeAaRxJaX4W/qGjjKcfyaH0Z3T22fDQxAnuZXZxt0HeHwRe7YC8I4cdD1iWTa1D/9uq6Qiw1DlhOIXLm0NAQKka6beYXt6pIsDQNcMI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673425643;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=AL3B+qazQnfPgbRbDFoqG8kIkUv3Qr7A1092cen/5qM=;
        b=PRTSRCeh66gJ/SJ30Mf/fWTok2aasxx7yIaHMbtogLNRmkjoi1JtfP4VrEhhd44l
        HnLBjP0jFz4Jp/OaJtxi4wMJbTA6HQSO70A5Euh8dcwksK4gUbl2aa16K+x/1nPlrwl
        K6cuKweeNJWI03BGlgPM75Sskbl0xijWzZJc2qpw=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1673425640907374.3181655991632; Wed, 11 Jan 2023 00:27:20 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:27:20 +0800
From:   Li Chen <me@linux.beauty>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "rafael j. wysocki" <rafael@kernel.org>,
        "li chen" <lchen@ambarella.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1859ff0ddb8.d9ed321d977156.553326609923116766@linux.beauty>
In-Reply-To: <Y75odDyZXMzigoaL@kroah.com>
References: <20230111072130.3885460-1-me@linux.beauty> <Y75odDyZXMzigoaL@kroah.com>
Subject: Re: [PATCH v2] debugfs: allow to use regmap for print regs
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
 ---- On Wed, 11 Jan 2023 15:42:44 +0800  Greg Kroah-Hartman  wrote ---=20
 > On Wed, Jan 11, 2023 at 03:21:29PM +0800, Li Chen wrote:
 > > From: Li Chen lchen@ambarella.com>
 > >=20
 > > Currently, debugfs_regset32 only contains void __iomem *base,
 > > and it is not friendly to regmap user.
 > >=20
 > > Let's add regmap to debugfs_regset32, and add debugfs_print_regmap_reg=
32
 > > to allow debugfs_regset32_show handle regmap.
 > >=20
 > > Signed-off-by: Li Chen lchen@ambarella.com>
 >=20
 > Do you have an actual in-kernel user for this new function?  We can't
 > accept new apis without users for obvious reasaons.

Actually, both the old debugfs_print_regs32 and the new debugfs_regmap_prin=
t_regs32
have only one user: debugfs_regset32_show located inside debugfs/file.c.

The difference is currently all users(device drivers) only use debugfs_regs=
et32->base,
and none of them use debugfs_regset32->regmap, which is provided by this pa=
tch.

I'm not sure whether it violates the kernel's "no user, no new function" ru=
ler or not.

I use this regmap locally on our SoC driver, but it is still not ready to u=
pstream, really sorry for it,
and it is not a good idea to change existing non-regmap users to regmap hah=
a.
=20
If you think it does matter, please tell me and I will upload v3 with our S=
oC driver in the future.

 > And can you provide more documentation in the changelog text as to what
 > the new function is and how it should be used?

Ok, I think it would be better to provide documentation in Documentation/fi=
lesystems/debugfs.rst,
just like what debugfs_print_regs32 did.

 > > ---
 > > Changelog:
 > >=20
 > > v1 -> v2:
 > >=20
 > > Suggested by Greg, provide a new function for regmap instead of trying=
 to overload old function.
 > > ---
 > >  fs/debugfs/file.c       | 46 ++++++++++++++++++++++++++++++++++++++++=
-
 > >  include/linux/debugfs.h | 10 +++++++++
 > >  2 files changed, 55 insertions(+), 1 deletion(-)
 > >=20
 > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
 > > index b54f470e0d03..f204b27f757f 100644
 > > --- a/fs/debugfs/file.c
 > > +++ b/fs/debugfs/file.c
 > > @@ -1137,14 +1137,58 @@ void debugfs_print_regs32(struct seq_file *s, =
const struct debugfs_reg32 *regs,
 > >  }
 > >  EXPORT_SYMBOL_GPL(debugfs_print_regs32);
 > > =20
 > > +/**
 > > + * debugfs_print_regmap_regs32 - use seq_print to describe a set of r=
egisters
 > > + * @s: the seq_file structure being used to generate output
 > > + * @regs: an array if struct debugfs_reg32 structures
 > > + * @nregs: the length of the above array
 > > + * @regmap: regmap to be used in reading the registers
 > > + * @prefix: a string to be prefixed to every output line
 > > + *
 > > + * This function outputs a text block describing the current values o=
f
 > > + * some 32-bit hardware registers. It is meant to be used within debu=
gfs
 > > + * files based on seq_file that need to show registers, intermixed wi=
th other
 > > + * information. The prefix argument may be used to specify a leading =
string,
 > > + * because some peripherals have several blocks of identical register=
s,
 > > + * for example configuration of dma channels
 > > + */
 > > +void debugfs_print_regmap_regs32(struct seq_file *s, const struct deb=
ugfs_reg32 *regs,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0  int nregs, struct regmap *regmap, char *prefix)
 > > +{
 > > +=C2=A0=C2=A0=C2=A0=C2=A0int i;
 > > +=C2=A0=C2=A0=C2=A0=C2=A0u32 val;
 > > +
 > > +=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < nregs; i++, regs++) {
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (prefix)
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0seq_printf(s, "%s", prefix);
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_read(regmap, r=
egs->offset, &val);
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_printf(s, "%s =3D=
 0x%08x\n", regs->name, val);
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (seq_has_overflowe=
d(s))
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0break;
 > > +=C2=A0=C2=A0=C2=A0=C2=A0}
 > > +}
 > > +EXPORT_SYMBOL_GPL(debugfs_print_regmap_regs32);
 > > +
 > >  static int debugfs_regset32_show(struct seq_file *s, void *data)
 > >  {
 > >  =C2=A0=C2=A0=C2=A0=C2=A0struct debugfs_regset32 *regset =3D s->privat=
e;
 > > +=C2=A0=C2=A0=C2=A0=C2=A0void __iomem *base =3D regset->base;
 > > +=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap =3D regset->regmap;
 > > +
 > > +=C2=A0=C2=A0=C2=A0=C2=A0if ((regmap && base) || (!regmap && !base)) {
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_puts(
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0s,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0"You should provide one and only one between base and regmap!\n");
 >=20
 > So you report the error in the debugfs file itself?  While interesting,
 > that's not a normal way of reporting problems.
=20
Sorry for this, do you think the kernel log buffer(pr_err) is a good place =
for the error message?

 > Also your formatting here is really not normal, please fix that.

Ok, clang-format's bad haha.=20

 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
 > > +=C2=A0=C2=A0=C2=A0=C2=A0}
 > > =20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0if (regset->dev)
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_runtime_get_sync(r=
egset->dev);
 > > =20
 > > -=C2=A0=C2=A0=C2=A0=C2=A0debugfs_print_regs32(s, regset->regs, regset-=
>nregs, regset->base, "");
 > > +=C2=A0=C2=A0=C2=A0=C2=A0if (base)
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debugfs_print_regs32(=
s, regset->regs, regset->nregs, base, "");
 > > +=C2=A0=C2=A0=C2=A0=C2=A0if (regmap)
 >=20
 > Can't this just be an "else"?

Sure, will be fixed in v3.

Regards,
Li
