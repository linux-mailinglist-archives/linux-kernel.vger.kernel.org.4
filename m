Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403D969E866
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBUTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBUTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:35:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7792E0E5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A94B2611AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF94C4339B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677008142;
        bh=gihScliDYCA7ShI1M3RnyVH99dXA4xhil44xklbmE6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bl764SPN0ShNUXyzrzjW04s2PxfIvL3Ew59b38yd5zM5dOuvKTVmGj+2DOYZYayKi
         zFyd74xiS/BX0+M04bkW7iIFiujuhZwv+tdAWxVQx8Igqs2iL0llW44apsPmXb/Dbb
         Vo3RPPASvAWbA8CP+8zj1LOxP1d9HfgQMnEJP5o4FTpfoXLGNol31VF0+1aH6c5ZoK
         pUVVqzY61nv8yxKbQQkFqRla2OrRsYcRa2GHahSk1vzzBwdqSZ03DC5hmG8uqFWVZs
         1S0kQ4QG/ThnHClECrubGKRZERJgz5tHLwlf74vxrhpWXrAPaKf5VQ4ZAgZ6hysofc
         1MCGPAdWzM4UA==
Received: by mail-ed1-f41.google.com with SMTP id ec43so21132636edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:35:42 -0800 (PST)
X-Gm-Message-State: AO0yUKWVFXBOaPOxXhar2/VZrx47tnvN6MCmlUpHUazojWhiZeMTNRlz
        31RwRdrWojhaMPiv8BMQiL0MqC2yNxeBaiRjUeFKkQ==
X-Google-Smtp-Source: AK7set/zg2dm0oZVcnbW8qXyngwNC4dMlaIq364k9b8EUXUZy0ZD5M9avqN21XBqoDA8VXmbX6iAgL2u9ZHhZkCuh3I=
X-Received: by 2002:a17:906:13d9:b0:8de:c6a6:5134 with SMTP id
 g25-20020a17090613d900b008dec6a65134mr1698483ejc.15.1677008140357; Tue, 21
 Feb 2023 11:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20230221184908.2349578-1-kpsingh@kernel.org> <Y/UbqiHQ2/aczPzg@kroah.com>
In-Reply-To: <Y/UbqiHQ2/aczPzg@kroah.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Feb 2023 11:35:29 -0800
X-Gmail-Original-Message-ID: <CACYkzJ7pLhJ+NfUq36PaMxadkgv-cPtO60TW=g_Nh7vU1vEWqA@mail.gmail.com>
Message-ID: <CACYkzJ7pLhJ+NfUq36PaMxadkgv-cPtO60TW=g_Nh7vU1vEWqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/speculation: Allow enabling STIBP with legacy IBRS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        jpoimboe@kernel.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        corbet@lwn.net, bp@suse.de, linyujun809@huawei.com,
        jmattson@google.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:29 AM Greg KH <gregkh@linuxfoundation.org> wrote=
:
>
> On Tue, Feb 21, 2023 at 07:49:07PM +0100, KP Singh wrote:
> > Setting the IBRS bit implicitly enables STIBP to protect against
> > cross-thread branch target injection. With enhanced IBRS, the bit it se=
t
> > once and is not cleared again. However, on CPUs with just legacy IBRS,
> > IBRS bit set on user -> kernel and cleared on kernel -> user (a.k.a
> > KERNEL_IBRS). Clearing this bit also disables the implicitly enabled
> > STIBP, thus requiring some form of cross-thread protection in userspace=
.
> >
> > Enable STIBP, either opt-in via prctl or seccomp, or always on dependin=
g
> > on the choice of mitigation selected via spectre_v2_user.
> >
> > Reported-by: Jos=C3=A9 Oliveira <joseloliveira11@gmail.com>
> > Reported-by: Rodrigo Branco <rodrigo@kernelhacking.com>
> > Reviewed-by: Alexandra Sandulescu <aesa@google.com>
> > Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=3Dibrs option to =
support Kernel IBRS")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 33 ++++++++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 11 deletions(-)
>
> Why isn't patch 2/2 for stable as well?

It should be. I actually forgot to remove stable from the first one as
there are still ongoing discussions and people kept having to "drop
stable".  I can send a v3 with stable Cc'ed. Should it have a fixes
tag too?

>
> thanks,
>
> greg k-h
