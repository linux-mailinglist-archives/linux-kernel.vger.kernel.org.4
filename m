Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA17466FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGDBuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGDBuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:50:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1576E54
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:50:50 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 74CF83F19A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688435448;
        bh=xRjzAE0n5uIgT1izeqo8Qt3qb3EDeNKGoRxIM7nbkoA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eYRB9ymFWvP4l1f3DIYXJm6h3CjvKssUan205Z10JGaWiTc4a9zxnvawFj7MKCnJz
         ZrrzPbgr4mspT+y2PuYzsyfjFJzBrgPMzazRg1rC9clALYNTfdIEymMOYZv1lADpV7
         QeGASqTDQ1CYn1aEOQQ8WrYXS4hdPLNzkmkOxtqqNXRECesTLTAmHY74KGpNLBNYNJ
         hz8MuI7BjJgv0N9k9wMuyGM4m9ZI7hkOAXq2EvQV2B6X4ac6feee6xmydDeYFGvAlu
         mhMw6zPNCoSDTrBMNUHyyatWtrq9H2PUecVKbVLFixTtZAFXUKMV9CY1hAoGGx6VGV
         OcnrWwmD2EYgA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6686e4499b1so5143885b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 18:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688435446; x=1691027446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRjzAE0n5uIgT1izeqo8Qt3qb3EDeNKGoRxIM7nbkoA=;
        b=c0wcUMmO1C5QDHUMce65PaMc9re/3WGJ7sJqz61mBDMh26Lt7G6Z5bqv9RL3IVxC5s
         ZRM8gmlZOfkdS6EhZPeLlgCATc3ck794/c+SwpyA8S4nrJ2ufyDpKxf1vRVj5AyM0rET
         tgLTye9xOniwzi6U4ew7caFCHXfvgkHNFTjmH4ybtlOCO/MPKmhrCBmj6Jh9PzN0wkyL
         0ETHcI3qWKaxR+zh4hE+Di+xKQ56UpxMilFgUlWDucVqDvHnodvEhQ7j7aKuPj6Wqacr
         XbEmCI9W8szR3sjRuI3D/1ggKz7CPU8j1+4Gz15dMjSxVsQTiizrs2ELiu9YFuOadvYT
         ka1A==
X-Gm-Message-State: ABy/qLbjbMm19d6A4yLkpNC1v/YR6N1RmkjBeBLig81+ZtbVJM47aufd
        YHPXqaZYITANVsoDvbx7t+Ew68e6A6/7KpjJTX921uIGiCp+eifgL2yZKAnOCMDzwoyG84Ua8KQ
        VRI6XwsSgMZ5A64KmptH2jKaZd9J4tW5yrAhUt4VbufU4Dpg8WJ/QFLrtTw==
X-Received: by 2002:a05:6a00:c91:b0:657:f26e:b01a with SMTP id a17-20020a056a000c9100b00657f26eb01amr12396882pfv.26.1688435446043;
        Mon, 03 Jul 2023 18:50:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHX437TWfJBK7YTXwsR6fw6ywkRfC1jA00N3tmzfj+k09vE6RLFcxGk2IJ0KTcV5UzDvOiDWYCDWDyp3EUiYP8=
X-Received: by 2002:a05:6a00:c91:b0:657:f26e:b01a with SMTP id
 a17-20020a056a000c9100b00657f26eb01amr12396872pfv.26.1688435445547; Mon, 03
 Jul 2023 18:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 09:50:33 +0800
Message-ID: <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 5:51=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> > > UBSAN complains this error
> > > ~~~
> > >  UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
> > =E2=80=A6
> > > ~~~
> > >
> > > when get rows, cols and ranks, the returned error value doesn't be
> > > handled.
> > >
> > > check the return value is EINVAL, if yes, directly return 0.
> > =E2=80=A6
> >
> > * Please improve this change description further.
>
> To be specific. Initially you reported this because of the UBSAN error
> report. But, after community discussion you now know that the problem
> is that one or more of the rows/cols/ranks has a value that the EDAC driv=
er
> doesn't expect and probably can handle.
>
> So, in V2, the commit message should start with the information these
> values are out of range and mention this was discovered when UBSAN
> put out a warning about a negative shift. No need to include the whole
> of the UBSAN stack trace.
>
> Then describe the two fixes that this patch includes. One is to change th=
e
> edac debug message into a console error message to enable further
> debug of this issue. The other is to skip the unrecognized DIMM.
>
> > * How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?
>
> This is a good idea.  Use git blame, or dig into the GIT history to
> find the commit where this code was introduced (hint .. git blame
> says:
> 88a242c98740 ("EDAC, skx_common: Separate common code out from skx_edac")
> but that obviously just refactored code, so you should dig back more into
> the history.
>
> > > V2: make error-print explicitly
> > > ---
> >
> > Would you like to avoid a misplaced marker line here?
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.4#n686
>
> That's an excellent resource.

Thanks for your advices and I will modify.
here's part of dmesg enabled EDAC_DEBUG
~~~
[    4.032332] EDAC DEBUG: skx_register_mci: MC#1: mci =3D 00000000799db99e
[    4.032334] EDAC DEBUG: i10nm_get_dimm_config: dimmmtr 0xffffffff
mcddrtcfg 0xffffffff (mc1 ch0 dimm0)
[    4.032335] EDAC DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xffff=
ffff)
[    4.032337] EDAC DEBUG: skx_get_dimm_attr: bad rows =3D 7 (raw=3D0xfffff=
fff)
[    4.032338] EDAC DEBUG: skx_get_dimm_attr: bad cols =3D 3 (raw=3D0xfffff=
fff)
[    4.032339] EDAC DEBUG: i10nm_get_dimm_config: dimmmtr 0xffffffff
mcddrtcfg 0xffffffff (mc1 ch0 dimm1)
[    4.032340] EDAC DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xffff=
ffff)
[    4.032341] EDAC DEBUG: skx_get_dimm_attr: bad rows =3D 7 (raw=3D0xfffff=
fff)
[    4.032341] EDAC DEBUG: skx_get_dimm_attr: bad cols =3D 3 (raw=3D0xfffff=
fff)
[    4.032343] EDAC DEBUG: i10nm_get_dimm_config: dimmmtr 0xffffffff
mcddrtcfg 0xffffffff (mc1 ch1 dimm0)
[    4.032344] EDAC DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xffff=
ffff)
[    4.032345] EDAC DEBUG: skx_get_dimm_attr: bad rows =3D 7 (raw=3D0xfffff=
fff)
[    4.032346] EDAC DEBUG: skx_get_dimm_attr: bad cols =3D 3 (raw=3D0xfffff=
fff)
[    4.032347] EDAC DEBUG: i10nm_get_dimm_config: dimmmtr 0xffffffff
mcddrtcfg 0xffffffff (mc1 ch1 dimm1)
[    4.032348] EDAC DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xffff=
ffff)
[    4.032349] EDAC DEBUG: skx_get_dimm_attr: bad rows =3D 7 (raw=3D0xfffff=
fff)
[    4.032349] EDAC DEBUG: skx_get_dimm_attr: bad cols =3D 3 (raw=3D0xfffff=
fff)
~~~

I shared the whole dmesg through g-drive.
https://drive.google.com/file/d/1epnDZNezGiJsK1eT4UNOi8_igcBSXtiF/view?usp=
=3Dsharing

>
> -Tony
