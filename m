Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64007497DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGFJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:03:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D201BD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:03:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso378169f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688634188; x=1691226188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybQ/CZNAG22pD3nH7OaccSop7ti/KICGWdaCbCpWb14=;
        b=SPRuhrsU4TSIm81nyIGiQJOxNSGVrgc2ZnWi4srtTkZ0wWkAx3AXtw/nFgSNPwXheH
         UBhUkZjxKYkzswW+UnUCuciCyPkB2pKklhz0ldSLRLlZL29npRWKBX/tZeOCgkfkan8I
         NyaM7QtBrB3wVE4d1I+p6eri/YCF1nSQkXixTTKRW7OHMLF5DGPAUwfmIp+a9kQFi+QZ
         dwrZuwue0Nsv/nLw6+5+pnn+yLGBJvolGR5UH6bhotiRs7gsW3XV7zLLa6rU26uSG3NA
         PaP4+xsD8moXD9ofLXVV5AnVmq43PoQuefdVLnuLRA2O7E2LgY9jYwFMyX1q0lBIwmUW
         dO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688634188; x=1691226188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybQ/CZNAG22pD3nH7OaccSop7ti/KICGWdaCbCpWb14=;
        b=k75sVBfhoASrrNIQ1N6Blq9vTjIQF0OrjmFCeNPutjHUj7yuQuedOzcZoRLkPAhzrB
         NWiXJWl5qyJfwWEHS80FlHWyIsGID74MwxrEsYt2hFB/V8s7T5mB5rxe9uoeINeAUt3R
         v90HyqWzuc4ohIxgJJ7nfoAq15nk5d5ADwTSEwOdjNjBElnDvbJ1wHP6yq69NXK7c1uL
         z0gWTfY3HJ5w1ubMJ/ij23vkvuktE63MPpS7JVGjVVB7NjdsR+pGnxDUg5O5vTBJQYxo
         DOpRwEh/QF0bnSADIMhIoHUHxSi2sSTOGnhRcmD8bWV/N0H05QuRnQvXeAn4FA24NWPz
         zthg==
X-Gm-Message-State: ABy/qLawUuJCWF9V/dhxPJHIdZsvCdt5q817kxl1Ed5ceSWSxKEdA690
        dzB7wwgxZTOJ8LpBKO9S7rehMl0FQy3kniBtm/B4jA==
X-Google-Smtp-Source: APBJJlF97KD9nLAou+VLQkV6g+z36j8hSfywgVoYBVe0e6ASGIqI6D+7x6tZL67ba1/M8KAZyS4Nqzkvo9nQIHhhqzA=
X-Received: by 2002:a5d:6047:0:b0:313:e8f9:803 with SMTP id
 j7-20020a5d6047000000b00313e8f90803mr891587wrt.3.1688634187925; Thu, 06 Jul
 2023 02:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <20230705114251.661-5-cuiyunhui@bytedance.com>
 <20230705-oblivious-unstuffed-8e028a5b243c@spud> <CAEEQ3wmG1OiE3GFqQp9SP+oKUbTfuTPx=rNGd-sjKsW7vv3bew@mail.gmail.com>
 <20230706-syndrome-wise-c1097518f2c6@wendy>
In-Reply-To: <20230706-syndrome-wise-c1097518f2c6@wendy>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 6 Jul 2023 17:02:56 +0800
Message-ID: <CAEEQ3wk5AnesBhgHVkCqQbjC=ALShzJnRnppmFQfSeAxZ-51pw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 4/4] dt-bindings: firmware: Document
 ffitbl binding
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sunilvl@ventanamicro.com,
        ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Jul 6, 2023 at 2:45=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Thu, Jul 06, 2023 at 11:43:55AM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wro=
te:
> > On Wed, Jul 5, 2023 at 11:07=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > > On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
> > > > Add the description for ffitbl subnode.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++=
++++
> > > >  MAINTAINERS                                   |  1 +
> > > >  2 files changed, 28 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/firmware/ffit=
bl.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt =
b/Documentation/devicetree/bindings/firmware/ffitbl.txt
> > > > new file mode 100644
> > > > index 000000000000..c42368626199
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
> > >
> > > Firstly, new dt-bindings need to be done in yaml, not in text form.
> > > Secondly, you didn't re-run get_maintainer.pl after adding this bindi=
ng,
> > > so you have not CCed any of the other dt-binding maintainers nor the
> > > devicetree mailing list.
> >
> > Re-run get_maintainer.pl and added maintainers into the maillist.
> > emm.. There is some *txt in
> > Documentation/devicetree/bindings/firmware/, isn't it?
>
> There might be, but that's not an excuse for adding _new_ ones, sorry.

Okay, I'll update it on v4.


> > > > +FFI(FDT FIRMWARE INTERFACE) driver
> > > > +
> > > > +Required properties:
> > > > + - entry             : acpi or smbios root pointer, u64
> > > > + - reg                       : acpi or smbios version, u32
> > >
> > > Please go look at any other dt-binding (or the example schema) as to =
how
> > > these properties should be used. A "reg" certainly should not be bein=
g
> > > used to store the revision...
> >
> > Okay, If so=EF=BC=8CI'll add a property "version" into the dts instead =
of
> > "reg", just like, WDYT?
> > ffitbl {
>
> Firstly, I'd much rather you spelt this out, like "ffi-table".
>
> >     smbios {
> >         entry =3D "";
>
> I still don't understand why "entry", which is an address, is being
> represented by an empty string.
> I also don't really get why you have not used "reg" to describe its
> start address and size.
>
> >         version =3D < 0x02 >;
>
> Probably missing a vendor prefix, and the spaces are unusual, but better
> than it was, yes.

Based on your review, I plan to modify it as follows:

ffi-table {
#address-cells =3D <2>;
#size-cells =3D <0>;
        smbios@entry1 {
                compatible =3D "smbios";
                reg =3D <entry1>;
                version =3D <2>;
        };
        smbios@entry2 {
                compatible =3D "smbios";
                reg =3D <entry2>;
                version =3D <3>;
        };
        acpi@entry {
                compatible =3D "acpi";
                reg =3D <entry>;
                version =3D <6>;
        };
}

The reason why #size-cells is 0 is because only one item is needed,
#address-cells =3D <2>; because two u32 are needed to express the 64-bit
address.
The memory for the SMBIOS table itself will be preserved in "reserved
memory" , so we don't have to worry about this piece of memory getting
corrupted. ACPI as well. WDYT?

> >     }
> >    acpi {
> >          entry =3D "";
> >          version =3D < 0x06 >;
> >   }
> > }
>
> Thanks,
> Conor.

Thanks,
Yunhui
