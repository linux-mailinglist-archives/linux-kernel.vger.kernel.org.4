Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76AB728D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjFICEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFICE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C230D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 336C563F78
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E639C4339B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686276267;
        bh=R8OkAj6OIkdcUXTCmDhI7Jf2XQIKaCplXivoSkeLxc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eoCa+EplOc9QFhELnU3lDHZgCBC4dl6iAIYucHhu4MZ0w94r160zwlDPygePm23Z3
         CfuN5VaStVkuaKOsWVbi6/iwNxzWWNSQO0fJvL3+o+/u1KshjV/zgdIFMTj0/FJYDB
         +9zohW0Hyl9iW2BEfi98hPRunCujDIVBzMXVS519Tigk0kBeuQtMaDWh9QClFIG5N8
         7Gxv3K07Z19e24Hly8Me7mYYMHxVMHsquA60NdB+upL+jwxSfi/nsel1OVcyPHoKM0
         EZNdNW6LkO43t1SwuCEvkKZ/eLNDL5bB4ICzmLyJfi+F7QOJR1yWoKui0G+BBXvLFr
         DWtAHRai9k8CA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so2277447a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:04:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDypk8pVqeYH6c9PmGTAXpZlzXLkJJ4QvkVDJXzeSQtNW/WjeGfz
        ONFPGMyvV6YksI6yNd6B8KHVcR9GDtOo1qqGwic=
X-Google-Smtp-Source: ACHHUZ6ruALU7GHn4PiFGkCL/kfW8XviX1EpOnZUIyrYeeP7EGXmHWTPIQh/1nrOTXfq/5zb3NIyawAHwi2Xjneh91c=
X-Received: by 2002:a17:907:c15:b0:94e:48ac:9a51 with SMTP id
 ga21-20020a1709070c1500b0094e48ac9a51mr343743ejc.4.1686276265775; Thu, 08 Jun
 2023 19:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230608130157.5871-1-zhangqing@loongson.cn>
In-Reply-To: <20230608130157.5871-1-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 9 Jun 2023 10:04:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7yLgM7WAnubjkBx27E7UUTpMC+x93y=t6YkcEWBafFGQ@mail.gmail.com>
Message-ID: <CAAhV-H7yLgM7WAnubjkBx27E7UUTpMC+x93y=t6YkcEWBafFGQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Avoid uninitialized alignment_mask
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Colin King <colin.i.king@gmail.com>
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

Queued, thanks.

Huacai

On Thu, Jun 8, 2023 at 9:02=E2=80=AFPM Qing Zhang <zhangqing@loongson.cn> w=
rote:
>
> The hardware monitoring points for instruction fetching and
> load/store operations need to align 4 bytes or 1/2/4/8 bytes respectively=
.
>
> Reported-by: Colin King <colin.i.king@gmail.com>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/kernel/hw_breakpoint.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kerne=
l/hw_breakpoint.c
> index 2406c95b34cc..021b59c248fa 100644
> --- a/arch/loongarch/kernel/hw_breakpoint.c
> +++ b/arch/loongarch/kernel/hw_breakpoint.c
> @@ -396,6 +396,8 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>
>         if (hw->ctrl.type !=3D LOONGARCH_BREAKPOINT_EXECUTE)
>                 alignment_mask =3D 0x7;
> +       else
> +               alignment_mask =3D 0x3;
>         offset =3D hw->address & alignment_mask;
>
>         hw->address &=3D ~alignment_mask;
> --
> 2.20.1
>
>
