Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B5704336
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEPCD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjEPCD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:03:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954B413E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3D8633B8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5EAC433A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684202604;
        bh=ycv+VEOGv9cbrchvl8jntmN5FDbyqDgaTPIMmjcdJ2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RfL+wE+ijp/vwxuUi8Oeoc58fXRtexJKKEwdzdM3jh8pj6jgmWY5R1kijJkO7rprd
         IFIs2MHseWek6U3oemMJvtq2nSSr6OO/F85mia6BQAFi+45SCUa7SePdsilXTUm1eP
         A42akmSQh1XZl4OFiXKSnmD6YhlBejLzUkazlXga0g4qsfAbiA0jvkWQFl+Y1uD7y3
         2GEuJJ0AutAoO3RPBZKJgwijad6mWMlzkXJjBVkfN1L8bb7LXvVUNMDNdu8RDLulwR
         W/u0cBu5Br8vFJkZ5Q2+NKEjtUDEhQVH6QRN9pjPUqe/1fmbTdjIMhbVJ2swcp+ESF
         3fHzTB4ntWCaQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9659f452148so2468843066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:03:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDxViEw6DjNCkRSCP5KXb4U1BDjX+6Smr3SNvLA6pKdN86XcTgts
        rrTiesITpPEyfrwtr/WX8zy+9UMO5MMbV0BHlk4=
X-Google-Smtp-Source: ACHHUZ5gTNUGfE3MSgIgdGoB5vnNs4BSJ48K7k49j26N3jMzpe/R2bH1dkkCHE3cFTF/AI5F8XyrKnjyB2clTp2SkcY=
X-Received: by 2002:a17:907:2685:b0:94f:3bf7:dacf with SMTP id
 bn5-20020a170907268500b0094f3bf7dacfmr30748735ejc.71.1684202602654; Mon, 15
 May 2023 19:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H48t8tDmWoZOSqx06HwwXKY1CR=X+hi0o_ok6gSu6dQSg@mail.gmail.com>
 <CY5PR12MB64558068B314942BA1B2ED2BC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB64558068B314942BA1B2ED2BC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 16 May 2023 10:03:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ep_A-7568zE2ggQUXpyhH=zS90TsHP8X0gn5s8LZ8iQ@mail.gmail.com>
Message-ID: <CAAhV-H6ep_A-7568zE2ggQUXpyhH=zS90TsHP8X0gn5s8LZ8iQ@mail.gmail.com>
Subject: Re: [PATCH v2] loongarch: fix debugfs_create_dir error checking
To:     mirimmad@outlook.com
Cc:     ivan.orlov0322@gmail.com, kernel@xen0n.name,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        mirimmad17@gmail.com, skhan@linuxfoundation.org
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

On Sun, May 14, 2023 at 2:44=E2=80=AFPM <mirimmad@outlook.com> wrote:
>
> From: Immad Mir <mirimmad17@gmail.com>
>
> The debugfs_create_dir returns ERR_PTR incase of an error and the
> correct way of checking it by using the IS_ERR_OR_NULL inline function, a=
nd
> not the simple null comparision. This patch fixes this.
>
> Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
>  arch/loongarch/kernel/unaligned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/un=
aligned.c
> index bdff825d2..85fae3d2d 100644
> --- a/arch/loongarch/kernel/unaligned.c
> +++ b/arch/loongarch/kernel/unaligned.c
> @@ -485,7 +485,7 @@ static int __init debugfs_unaligned(void)
>         struct dentry *d;
>
>         d =3D debugfs_create_dir("loongarch", NULL);
> -       if (!d)
> +       if (IS_ERR_OR_NULL(d))
>                 return -ENOMEM;
>
>         debugfs_create_u32("unaligned_instructions_user",
> --
> 2.40.0
>
