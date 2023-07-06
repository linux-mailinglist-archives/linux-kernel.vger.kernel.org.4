Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5553374946F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGFDog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjGFDoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:44:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3431BCF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:44:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so2191415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688615047; x=1691207047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpdCKCp+dEsXjUfnxgC7qSAJV2eBz4qj2jsssqk1txs=;
        b=iXDH/ghPLGc9raD3qKetKj/KUpmZePX4PNAORCoaQYBdMqKXKCtW+TZPJcAOk1rTdP
         IMbnwpoopc+i6RQjurWxU6VrAHS5NHNETEIVvcpDgwgx6haEvQm3f0TippJsoFEqHGDJ
         U0IZLzlFg0hsymvDvlzb7UPmM4EnnN/bBfCOVyWncse42TgvyXSe75LL0DKn2bB+0WXa
         Bt1mRQJ4UVbaCZpyIQx+FNpuSXh9xFFQmjEPoUzQIjzZR50g+r1hTHedz/ejAr4Znn4U
         8z9HU/kunrrK0MZ+synCMg9CKp0+SMKz5l29beFS2JK6ifjnmeVpDw24dWb7pP++BTdG
         nwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688615047; x=1691207047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpdCKCp+dEsXjUfnxgC7qSAJV2eBz4qj2jsssqk1txs=;
        b=V9CawRabR4XW0fa/eE4ypz5IpclLwTGbcpR2H2+V77YwHfIeQWIAdjX+qGx90fI16m
         OPZ4699HT1Scs8I1UtlD5Czx909BsaOAICR+6uVbdYusFfdEHkkDRH2KVrjlhGC9xWVO
         86jEcFl8HkXRGHT+r13cRsg2g2eZCfkqhfaPG0wlBzHBnZP4kwqQkQouzBaxDoBbG6m0
         udibPNepAJATH57PzicUwiKR/Bq7fWCKM+3kCfUO9GWYd8HtsxIIrs7/ExrAzPi9k+PC
         4AtW8mGUovwcHjqZd2k+tUnBCbh6ANhymPatF+4PYuZTuql+1Y4hiqR6r2hHXZVJzIa8
         vrlA==
X-Gm-Message-State: ABy/qLbSTJIw9Mlj+dsaLwvcLlf4+TpLbJjn2IpC+vXXzKfUw5nYLiBA
        WkFOohoUL5NDWXKodz4HHq2/mOGKkuAhv4VmnVIqrQ==
X-Google-Smtp-Source: APBJJlG8oJJ/0Lw6qO1wtxj2L3BYTTBuF2LIPDKZd3AA7ZMseFgpU0K2z+5nLIryFaJlkLROHdg8KF/EMX8q/u/r47c=
X-Received: by 2002:adf:e34c:0:b0:314:3b17:d7c5 with SMTP id
 n12-20020adfe34c000000b003143b17d7c5mr382795wrj.43.1688615046885; Wed, 05 Jul
 2023 20:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <20230705114251.661-5-cuiyunhui@bytedance.com>
 <20230705-oblivious-unstuffed-8e028a5b243c@spud>
In-Reply-To: <20230705-oblivious-unstuffed-8e028a5b243c@spud>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 6 Jul 2023 11:43:55 +0800
Message-ID: <CAEEQ3wmG1OiE3GFqQp9SP+oKUbTfuTPx=rNGd-sjKsW7vv3bew@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 4/4] dt-bindings: firmware: Document
 ffitbl binding
To:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     sunilvl@ventanamicro.com, ardb@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, rminnich@gmail.com,
        mark.rutland@arm.com, lpieralisi@kernel.org, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Added dts Maintainers,

On Wed, Jul 5, 2023 at 11:07=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey,
>
> On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
> > Add the description for ffitbl subnode.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.t=
xt
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt b/Do=
cumentation/devicetree/bindings/firmware/ffitbl.txt
> > new file mode 100644
> > index 000000000000..c42368626199
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
>
> Firstly, new dt-bindings need to be done in yaml, not in text form.
> Secondly, you didn't re-run get_maintainer.pl after adding this binding,
> so you have not CCed any of the other dt-binding maintainers nor the
> devicetree mailing list.

Re-run get_maintainer.pl and added maintainers into the maillist.
emm.. There is some *txt in
Documentation/devicetree/bindings/firmware/, isn't it?

>
> > @@ -0,0 +1,27 @@
>
> > +FFI(FDT FIRMWARE INTERFACE) driver
> > +
> > +Required properties:
> > + - entry             : acpi or smbios root pointer, u64
> > + - reg                       : acpi or smbios version, u32
>
> Please go look at any other dt-binding (or the example schema) as to how
> these properties should be used. A "reg" certainly should not be being
> used to store the revision...

Okay, If so=EF=BC=8CI'll add a property "version" into the dts instead of
"reg", just like, WDYT?
ffitbl {
    smbios {
        entry =3D "";
        version =3D < 0x02 >;
    }
   acpi {
         entry =3D "";
         version =3D < 0x06 >;
  }
}

>
> Cheers,
> Conor.
>
> > +
> > +Some bootloaders, such as Coreboot do not support EFI,
> > +only devicetree and some arches do not have a reserved
> > +address segment. Add "ffitbl" subnode to obtain ACPI RSDP
> > +and SMBIOS entry.
> > +This feature is known as FDT Firmware Interface (FFI).
> > +
> > +Example:
> > +     ffitbl {
> > +
> > +             smbios {
> > +                             entry =3D "";
> > +                             reg =3D < 0x03 >;
> > +
> > +             }
> > +             acpi {
> > +                             entry =3D "";
> > +                             reg =3D < 0x06 >;
> > +
> > +             }
> > +     }
> > +
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9b886ef36587..008257e55062 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7874,6 +7874,7 @@ F:      include/linux/efi*.h
> >  FDT FIRMWARE INTERFACE (FFI)
> >  M:   Yunhui Cui cuiyunhui@bytedance.com
> >  S:   Maintained
> > +F:   Documentation/devicetree/bindings/firmware/ffitbl.txt
> >  F:   drivers/firmware/ffi.c
> >  F:   include/linux/ffi.h
> >
> > --
> > 2.20.1
> >

Thanks,
Yunhui
