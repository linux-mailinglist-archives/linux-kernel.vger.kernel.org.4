Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854265E1F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjAEAtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjAEAsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:48:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805230576;
        Wed,  4 Jan 2023 16:45:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 592ECB81716;
        Thu,  5 Jan 2023 00:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D286C433EF;
        Thu,  5 Jan 2023 00:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879474;
        bh=WH4x6VZKnbwZlnPEWcHvQT9ihrLtRVqakgjvyj7uwNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6g9ioP2ZK+RKiubpiaLTESRzMdvdQyEeSmjcOTYqjnHOqbHQFu5fNU+Ti1xMl+7g
         wLhV+Mdav4WV+IswAu0GaQYKMR5EXACs2E1qhIRA2yr7eKa470X1IgWGSSEZqcYSSz
         axrDrCP5KY8EPubHhqg+O6DLorDamc3caADmXp7hcRXpr71RZnTirbJdT6NhTf3HxV
         MnFnUigvZTqKwBEJswhwOq3V9ssOXk6+EScDX16Ou/mx9rJiHCXD0wQe5/3XwIS/bw
         DcGiJ2pqmUQFT3CwKYPMkFHil381Mc0Ajw8T6FHvYKkYAWNK6QcMqcTceLRuKz3J0W
         6rZmQacc5W/qQ==
Received: by mail-lf1-f43.google.com with SMTP id g13so52904014lfv.7;
        Wed, 04 Jan 2023 16:44:33 -0800 (PST)
X-Gm-Message-State: AFqh2kq0wFXF19rL0Kiekb7JR88RBY7e3Xtjx2ftrxvH4f0oarQP5+/O
        wIvd+q1L0vh8Hp5ZnYNBg3aJu4+Ke2xgZSLITpw=
X-Google-Smtp-Source: AMrXdXtprpsBrqI3b3IFTlFhxNSRfwqsK8W3eL1jzaanesPzAA6Cg+EmGpeS+vdg9VSSspb9DeFkw6mWAHBLV8d6UoM=
X-Received: by 2002:a19:640f:0:b0:4b6:e71d:94a6 with SMTP id
 y15-20020a19640f000000b004b6e71d94a6mr3543316lfb.476.1672879472160; Wed, 04
 Jan 2023 16:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-14-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-14-paulmck@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 4 Jan 2023 16:44:19 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6g4g_02iK3YwpkRQMwr8DBQSdVWnrOx0oYdaNWAWcX5g@mail.gmail.com>
Message-ID: <CAPhsuW6g4g_02iK3YwpkRQMwr8DBQSdVWnrOx0oYdaNWAWcX5g@mail.gmail.com>
Subject: Re: [PATCH rcu 14/27] drivers/md: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 4:38 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: <dm-devel@redhat.com>
> Cc: <linux-raid@vger.kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 998a5cfdbc4e9..5f1e2593fad7e 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -6,7 +6,6 @@
>  menuconfig MD
>         bool "Multiple devices driver support (RAID and LVM)"
>         depends on BLOCK
> -       select SRCU
>         help
>           Support multiple physical spindles through a single logical device.
>           Required for RAID and logical volume management.
> --
> 2.31.1.189.g2e36527f23
>
