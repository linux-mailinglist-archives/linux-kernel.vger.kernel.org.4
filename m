Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969B6DF09A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjDLJjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDLJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:38:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECCF6A6F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:38:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s12so1748020wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1681292321; x=1683884321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYgoJ5W1lm2h+WEkZDuXfLaD3rVO4vR6JV6PPTTeq7c=;
        b=CLjKS7jrFc9YFmn7lkcsGSXUdAVtLh6kO2+KjKW07v8CxR34OQjJD1O3IggOoFcxW0
         OpHP/0kjKdKeyO7B6zv2wi3vDM2rkFr+9lCtIIEwKPOQgCLVPwoHBicte4vxq8Z/qlYQ
         jux9UTehoSVOIlbZ835Vr6KV/qkGc0C16mEJniuA0R+2QQduJofHnr74gr43j8Z3nAyy
         Uae180F88fahqvjOW1YkyOPgdNoGO0uUyh8AxG8PekIjqnDDU423bXux7ke0GBUhqs1b
         76a6rLG3/VyhcjjrU4usy6eZofj7hIhiW0F9lWaszyHEXadXkfW+z3sZBdzvn3p8cvYj
         yjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292321; x=1683884321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYgoJ5W1lm2h+WEkZDuXfLaD3rVO4vR6JV6PPTTeq7c=;
        b=6QYiHQt2gubDSwyfGYfqIEbVIjerjN7gm9r601Z9a3TasPYSZulVrSjKpc29dIMaMO
         m4xRP3/8II4A9tEFm/956O/OWXpS+PIusM8Hf2FbnN9F+JtC1fyVABnk1XpPmd61VUvo
         D8cozFnevZDTpUh7Jwy5pIzyytMS7FUFE0VJaPNxHyPFMOIscMqjNyoBYXbabmDiqZBF
         DaxW+bFIL+drBWLX9xnqmsstroaqyaZPfkqYArM833BBaNB/5nJuAx4G3TrZyEKds446
         AibFRTOotTlBRjYLiuDQ1cy2n9iB2HBRb4EV/1n0OI8kptFQaaWslF7NQYB5YC82RxXN
         s8UQ==
X-Gm-Message-State: AAQBX9fpCfREmaFNfPsDlrkkhPdHCx6Ef1Nn4HRq7IqzsWDHcrcCmPkf
        mxfOsp4Fo8BXgLhPX4MW69aQJ2xfRIghfZS5DRGEcA==
X-Google-Smtp-Source: AKy350Z6Kgwh2a/YcvNcQGVBjoHjDEUOQELTs9q5jCK+CGbMZMcBDrwNxAgHcuWcKDQKeK9W/M/VW28W2tXkwzIOJ+4=
X-Received: by 2002:adf:f7ce:0:b0:2e8:4519:ee98 with SMTP id
 a14-20020adff7ce000000b002e84519ee98mr3077767wrq.13.1681292321429; Wed, 12
 Apr 2023 02:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-3-pierre.gondois@arm.com> <20230412-cone-mousiness-23326e149592@wendy>
 <3eac7e96-f3b3-ff66-d3f9-afb21fe17921@arm.com>
In-Reply-To: <3eac7e96-f3b3-ff66-d3f9-afb21fe17921@arm.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 12 Apr 2023 11:38:30 +0200
Message-ID: <CAHVXubixJ3BZuUD3Rdc+fD1+XJx2JmvXwhvVP4cyZ-Bu0_5kng@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cacheinfo: Check cache properties are present in DT
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre, Conor,

On Wed, Apr 12, 2023 at 10:12=E2=80=AFAM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
> Hello Conor,
>
> On 4/12/23 09:55, Conor Dooley wrote:
> > Hey Pierre!
> >
> > On Wed, Apr 12, 2023 at 09:18:05AM +0200, Pierre Gondois wrote:
> >> If a Device Tree (DT) is used, the presence of cache properties is
> >> assumed. Not finding any is not considered. For arm64 platforms,
> >> cache information can be fetched from the clidr_el1 register.
> >> Checking whether cache information is available in the DT
> >> allows to switch to using clidr_el1.
> >>
> >> init_of_cache_level()
> >> \-of_count_cache_leaves()
> >> will assume there a 2 cache leaves (L1 data/instruction caches), which
> >> can be different from clidr_el1 information.
> >>
> >> cache_setup_of_node() tries to read cache properties in the DT.
> >> If there are none, this is considered a success. Knowing no
> >> information was available would allow to switch to using clidr_el1.
> >
> > Hmm, w/ this series I am still seeing a:
> > [    0.306736] Early cacheinfo failed, ret =3D -22
> >
> > Not finding any cacheinfo is totally valid, right?
> >
> > A basic RISC-V QEMU setup is sufficient to reproduce, for instance:
> > | $(qemu) \
> > |     -m 2G -smp 5 \
> > |     -M virt -nographic \
> > |     -kernel $(vmlinux_bin)
>
> Sorry I forgot to remove the:
>    pr_err("Early cacheinfo failed, ret =3D %d\n", ret);

I have just tested it and the messages "cacheinfo: Unable to detect
cache hierarchy for CPU" disappear, I'll add my tested by on the next
version. And just to make sure we agree: this fix should go into
-fixes (for 6.3).

Thanks again Conor and Pierre,

Alex

>
> I ll wait until tomorrow to send a v3 with this fixed.
>
> Thanks for testing,
> Regards,
> Pierre
>
> >
> > Cheers,
> > Conor.
> >
