Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B693B5B549B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiILGiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiILGiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:38:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFAE205C1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:38:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so13183962lft.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6MMFOsdik3pOVxza5iFw67+zQvf/yIVZHtdOoLDh9XA=;
        b=WBHyt8tStNEomzn+/msR7XqF/ADGnzCqlpOgYyuTl9iS4felZamXZBRCDP0wkg8l4R
         fV0ajIesocWpV+qkZk7ucUVPVljcFmi1gppGcQ39zw/MdY3OaKKpXa2+KAEzcCDsWJCb
         YBFw+HGsnM+pYVt73fG5IHj4mit/jgCc+fc82ai5AYNJ6x38I5qethpk/vJg07qVRFs8
         HZC1Ev/RjvySyWmKUC46gT5n+2+94pblkCEqx98gZ6P4t1Cvz3eLBfjp37QJqhEkr4Zx
         +YlPi400FroQQTn0yRA7lE9kfYLTg7gd4xDoXrAn56m7jJac34t5p/lCI9l10F4KwMHz
         z4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6MMFOsdik3pOVxza5iFw67+zQvf/yIVZHtdOoLDh9XA=;
        b=Wp99ZCt8Gezr4tUsmS3+zXBwnuA++5lDak8XaVta9i7tM6Vw76b/+4C+AhEWIlDHXu
         0BYAoMUyDGrq+VGKwvEcUC9nZMVBYARwQ4j8/Z5W4UXLZ8ykcbhkOdl4CB6pa6Zw2qsM
         uJegtnK6Qs932qaX+92i1fYJuNCc1veK5FuQaA0ppVsZqR/+PdIa1nrYNtj0UNnUIhet
         trnWq959Mj9s8BaZqd56WMBIwwglQUGNhd4U32xv2MnYgMkaumetbYWKAGcoh097sIhy
         TgIGl5w3ON+vd8yCTqO09pu4nsuwZ9q2tFO2V6e2Nm1dHoXkx1/ZYCPQdwWfR8FHXP4T
         +aKQ==
X-Gm-Message-State: ACgBeo12v1a8xL/2EBznlaxnq28YZBpKA/lXp9gSApXuExVbvI/133wM
        gTEyCKJRi/FhB6hSu4ULB87Jabsx465/RZyN7IXXeA==
X-Google-Smtp-Source: AA6agR4TNG/RUu6QvTb9n6GXwBlk0k8cBa5EHKOtjXVmvbElP2VBINK++CQPC2Fa7/4D5YPELdVxUs9VgUcSmTm1/68=
X-Received: by 2002:ac2:5681:0:b0:498:f58f:c006 with SMTP id
 1-20020ac25681000000b00498f58fc006mr5016032lfr.428.1662964679707; Sun, 11 Sep
 2022 23:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220908144424.4232-1-zong.li@sifive.com> <20220908144424.4232-4-zong.li@sifive.com>
 <632b2853-1543-e3ba-b34f-39f3f4fdaddc@microchip.com>
In-Reply-To: <632b2853-1543-e3ba-b34f-39f3f4fdaddc@microchip.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 12 Sep 2022 14:37:48 +0800
Message-ID: <CANXhq0rUzyFOF_pShoPf18VrN2YH8AfgKRg438ak_3iMcRfSGA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] soc: sifive: ccache: determine the cache level
 from dts
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, bp@alien8.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 2:28 AM <Conor.Dooley@microchip.com> wrote:
>
> On 08/09/2022 15:44, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Composable cache could be L2 or L3 cache, use 'cache-level' property of
> > device node to determine the level.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  drivers/soc/sifive/sifive_ccache.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
> > index 949b824e89ad..690c19489317 100644
> > --- a/drivers/soc/sifive/sifive_ccache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
> > @@ -38,6 +38,7 @@
> >  static void __iomem *ccache_base;
> >  static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
> >  static struct riscv_cacheinfo_ops ccache_cache_ops;
> > +static int level;
> >
> >  enum {
> >         DIR_CORR = 0,
> > @@ -144,7 +145,7 @@ static const struct attribute_group *ccache_get_priv_group(struct cacheinfo
> >                                                            *this_leaf)
> >  {
> >         /* We want to use private group for composable cache only */
> > -       if (this_leaf->level == 2)
> > +       if (this_leaf->level == level)
> >                 return &priv_attr_group;
> >         else
> >                 return NULL;
> > @@ -215,6 +216,9 @@ static int __init sifive_ccache_init(void)
> >         if (!ccache_base)
> >                 return -ENOMEM;
> >
> > +       if (of_property_read_u32(np, "cache-level", &level))
> > +               return -ENODEV;
>
> I think ENOENT or EINVAL are more comment patterns here?
>
> Either way,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>

I will fix it in V4 patch. Thanks

> > +
> >         intr_num = of_property_count_u32_elems(np, "interrupts");
> >         if (!intr_num) {
> >                 pr_err("CCACHE: no interrupts property\n");
> > --
> > 2.17.1
> >
>
