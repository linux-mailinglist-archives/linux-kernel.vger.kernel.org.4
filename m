Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E373267B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbjFPFEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFPFEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F38269D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3301619D2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1382C433C0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686891843;
        bh=80QkVl+dt31i6iqcDzhy8sWS6Kv4Y0R7HM/LYiUY49k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFuiB30iyO42j/JXKGDWucKVkPwqq5r1z1RdEG+Lywg+kXn553zudt9/N99RcfX74
         vwECinP+PzskqbnjYu1T6M+Lx06XTrdNomt6oUNmJ1rSekfHyiIYl4KOBll768WjYa
         f3CFSFalT80zWAeTXXsoNrauplKn79x/OZpuZDa8wknq1vO4UAali9SR1ttmcOpngx
         5dyRkpROAk7RQh4E5rHkyXoxpIm3twEwvKT4SxIunValzkw8M7lkVVbNk8dADilVeK
         EwjL15Pu5Bof3cTe44YzNLii/vGkhbng8QZ0HyrX1rTJb6G7VBhFr+vOd4LsiV/GPs
         IuiSEcJgfsE2g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-55b78f40301so188508eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:04:03 -0700 (PDT)
X-Gm-Message-State: AC+VfDwuhEp0G0Cvt1LDQ8l8APJ/NSS/y/fYm6DyMrCeDMCzJOuW1TTg
        +yvagweMSg8dle6mrmLNgzxOZEGIkrFUX7C2o+I=
X-Google-Smtp-Source: ACHHUZ5UeobCq0L1QhAous1X74CB8QQx4r1NuucsLTGgun93B5fL80oWBNHtZtwoBFcebpgBvBAhCztZ/3QhYFs1kfQ=
X-Received: by 2002:a4a:bc87:0:b0:555:2ba8:a75b with SMTP id
 m7-20020a4abc87000000b005552ba8a75bmr1161300oop.1.1686891843222; Thu, 15 Jun
 2023 22:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230604042557.900590-1-masahiroy@kernel.org> <20230604042557.900590-2-masahiroy@kernel.org>
 <20230615140010.GE3635807@google.com>
In-Reply-To: <20230615140010.GE3635807@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 16 Jun 2023 14:03:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjYQSMjNb4Cn_8NVxGhsJ96-JBeNChVzLjefQZ82aKVg@mail.gmail.com>
Message-ID: <CAK7LNAQjYQSMjNb4Cn_8NVxGhsJ96-JBeNChVzLjefQZ82aKVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: rsmu: turn rsmu-{core,i2c,spi} into
 single-object modules
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:00=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Sun, 04 Jun 2023, Masahiro Yamada wrote:
>
> > With the previous fix, these modules are built from a single C file.
> >
> > Rename the source files so they match the module names.
>
> Should this be part of the previous patch?


I do not know. It is up to the maintainer's preference (you).

If you want me to send a squashed patch, I will be
happy to do so.


Masahiro






--=20
Best Regards
Masahiro Yamada
