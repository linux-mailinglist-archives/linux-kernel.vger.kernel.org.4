Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3A6BA7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCOGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCOGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:25:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F236699
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEEA3B81C9E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDA8C433D2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678861484;
        bh=uV/dYcPxviEPK8suAKKY5aQlnpDH5xf1rWRm2uPCZeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0L+nQ+4PLEUob9s/h3wpLgZ58j24Bz2oktexPvvlan1NdceCncHKBtxyd3E1lncR
         kMdTwfLGtDGZeAplPSao3Vr7OMJGcjI4uKskvwWxXg2wHQNSqHZF6+EFlAWfwnP1pT
         YhFhi9yzi28h0VKQUm4HpXEc23NmgXESnGe7A8DIp7VuCl35x8KqnPk5FJkgRzaAmt
         MGM/Mv4AzqzYolj7gPqkrtyce65jlW0XC+lqkmAxxFBUXOBpihBy0eEEWJis45An0q
         MvX62uEzTv44ottTCn/+awXoLP8uvPlHLX4m/pVqi6qxeAi1dVt2q1xjvvJiD3+Uf7
         flEkz169ceJew==
Received: by mail-ed1-f41.google.com with SMTP id y4so41845013edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:24:44 -0700 (PDT)
X-Gm-Message-State: AO0yUKVJg8saYcIiQhHsFbeD9IXbrFpjJoVHhARFfwxq/wFIYj+C4vMi
        unTN9KgzZjdyvb2I4YqQVS49KSnkzyhDajxi0Bk=
X-Google-Smtp-Source: AK7set/GAMXa78ng/EUpmQM7sIJlEHtCP1vFcVRYsJ+wRps4Gv2FZRiSij4+wXU5HaDyHN2aGORALIUj7OPgZu4lZLY=
X-Received: by 2002:a50:cdd2:0:b0:4fc:1608:68c8 with SMTP id
 h18-20020a50cdd2000000b004fc160868c8mr817481edj.1.1678861482668; Tue, 14 Mar
 2023 23:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230315004450.508486-1-chenhuacai@loongson.cn> <0f07fc368ef9a365f4928f97819f203e45deb345.camel@xry111.site>
In-Reply-To: <0f07fc368ef9a365f4928f97819f203e45deb345.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 15 Mar 2023 14:24:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6j1iCujsXFRCic0LS=cwkwSDz+8_YMWz9ZO+tZ4y3K3w@mail.gmail.com>
Message-ID: <CAAhV-H6j1iCujsXFRCic0LS=cwkwSDz+8_YMWz9ZO+tZ4y3K3w@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Make WriteCombine configurable for ioremap()
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:33=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
>
> On Wed, 2023-03-15 at 08:44 +0800, Huacai Chen wrote:
>
> /* snip */
>
> > +config ARCH_WRITECOMBINE
> > +       bool "Enable WriteCombine (WUC) for ioremap()"
> > +       help
> > +         LoongArch maintains cache coherency in hardware, but when pai=
red
> > +         with LS7A chipsets the WUC attribute (Weak-ordered UnCached, =
which
> > +         is similar to WriteCombine) is out of the scope of cache cohe=
rency
> > +         machanism for PCIe devices (this is a PCIe protocol violation=
, which
> > +         may be fixed in newer chipsets).
> > +
> > +         This means WUC can only used for write-only memory regions no=
w, so
> > +         this option is disabled by default, making WUC silently fallb=
ack to
> > +         SUC for ioremap(). You can enable this option if the kernel i=
s ensured
> > +         to run on hardware without this bug.
>
> 'You can override this setting via writecombine=3Dyes/no boot parameter.'
OK, thanks.

>
> /* snip */
>
> > +static int __init setup_writecombine(char *p)
> > +{
> > +       if (!strcmp(p, "on"))
> > +               pgprot_wc =3D PAGE_KERNEL_WUC;
> > +       else if (!strcmp(p, "off"))
> > +               pgprot_wc =3D PAGE_KERNEL_SUC;
>
> else
>         pr_warn("Unknown writecombine setting \"%s\".\n", p);
OK, thanks.

Huacai
>
> Otherwise LGTM.
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
