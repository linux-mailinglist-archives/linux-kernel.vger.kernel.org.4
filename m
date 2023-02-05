Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68868AFA2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBEMDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 07:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:03:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52307E388;
        Sun,  5 Feb 2023 04:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE506068B;
        Sun,  5 Feb 2023 12:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4939BC4339B;
        Sun,  5 Feb 2023 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675598583;
        bh=6LA2DFSkcVUBBo8ioasIn2SLNkxzylCRyHkC/L6nLV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ffQoaU9GfeFkjTO8iv/gerIiCkPH2iXOCii4bvuvO+wKpwY8gP8uJ6QCciIhuCV1p
         4ssOrKqAl4AtfXCicK5BSCXig3frEV3jWOncTmUVbdKe5sbKcfX0L5OIKxFe9rM2Sv
         4yd1iE3Oeb+HKBl0LropEvRsaCg/BjwNNhLntGDTpzhMGdyuXwB5QR7jRiq0CqAEce
         MJ3VN5uXjR0fR0bt2lwGDKv6OcUCv+SOLCxBe9Qy2dMGvN1tCPFeLJlNH9tLppgjy+
         mGzGXidMPvJFPX2FyLbrHgocZSlDCDLH74SW57aVDA0UG5FX9MR//wIOkjUQ1wd+9V
         f0V53aEIHhAtg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-16346330067so12140756fac.3;
        Sun, 05 Feb 2023 04:03:03 -0800 (PST)
X-Gm-Message-State: AO0yUKW8wsswlCz+Ycodgm1x5yjuSFhd3z0qOp5Ue27q0t/T+6HRgEaK
        rYbDqPiWTvlFxMQJYpHprbiTFvpm0r75rPgFugc=
X-Google-Smtp-Source: AK7set8hy8XO+ARHNkAJBsg4eiRLu2xjb1gnPMCVQvSNXjuPlFfURboEluC5ycdnL8x4ptrO4vcopz4Lse2K0QtC/iY=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr1332023oaf.287.1675598582475; Sun, 05
 Feb 2023 04:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20230122141428.115372-1-masahiroy@kernel.org> <20230122141428.115372-4-masahiroy@kernel.org>
In-Reply-To: <20230122141428.115372-4-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Feb 2023 21:02:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-UCzDQ7QBUZosAKfiM3uj75fshdtEnXE7W=FNVjeMXQ@mail.gmail.com>
Message-ID: <CAK7LNAQ-UCzDQ7QBUZosAKfiM3uj75fshdtEnXE7W=FNVjeMXQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] setlocalversion: use only the correct release tag for git-describe
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 11:14 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Currently, setlocalversion uses any annotated tag for git-describe.
> If we are at a tagged commit, it will not append the commit hash.
>
>   $ git checkout v6.2-rc1^
>   $ make -s defconfig prepare
>   $ make kernelrelease
>   6.1.0-14595-g292a089d78d3
>   $ git tag -a foo -m foo
>   $ make kernelrelease
>   6.1.0
>
> If a local tag 'foo' exists, it pretends to be a released version
> '6.1.0', while there are many commits on top of it.
>
> The output should be consistent irrespective of such a local tag.
> Pass the correct release tag to --match option of git-describe.
>
> In the mainline kernel, the SUBLEVEL is always '0' but it is omitted
> from the tag.
>
>   version         tag
>   6.1.0      ->   v6.1        (mainline)
>   6.2.0-rc5  ->   v6.2-rc5    (mainline, release candidate)
>   6.1.7      ->   v6.1.7      (stable)
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


I will drop this patch,
and send an alternative one.









-- 
Best Regards
Masahiro Yamada
