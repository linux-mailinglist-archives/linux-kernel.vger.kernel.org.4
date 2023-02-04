Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17A468A960
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBDKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBDKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:10:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16606ACBF;
        Sat,  4 Feb 2023 02:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B812860C14;
        Sat,  4 Feb 2023 10:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2920EC4339B;
        Sat,  4 Feb 2023 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675505410;
        bh=4+79HN82K/GSxwobn2mkx56PNGHsVdak0R+nzgDHfr8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tDZdNg2+BV3+pDfo94wXpr2GGiRW3meTpcm28GLkaFTCxYkFu4HqIjTdssOB/ZknS
         mylmA9rs55uAZFYxV8BYiNiSxOi7w/hjVjl+M2IdRhJTA0ZvWCL2p338lg5rJFYDS6
         QwUzvrNuNaeOm/mweNRFI5T2v2tBY5ADPuBtlmAQi1wXETcXhtTvykPIHCpC30N79P
         BQp0ZaWrxfOYM8aib8B20P82fsM8Cmemn5RE8J1WrOhRLUIEDtsuAnU3CfCKNV6Rui
         fIjxoBS8P7V+k0WoBZEcm5DRh9HNW/Trxdqak5E3yriTgx9pw0dJZIUw+oB5Q+GXU0
         uwPTfTg4rwqEw==
Received: by mail-oi1-f176.google.com with SMTP id r28so6189302oiw.3;
        Sat, 04 Feb 2023 02:10:10 -0800 (PST)
X-Gm-Message-State: AO0yUKVRnzOnA7dpxtBR9XDDzUsixG0g6xgTU8C0HTPp1fa/nnTU6P8F
        7TazqyIrnH054XU6qlATZu29LHtzged1WNmFd2Y=
X-Google-Smtp-Source: AK7set+Pl6xL4QH0Yb31JErlPBNcydSCP2kbAiwlC/EBy2cyeT8Luu05WrBU1b4D2Lpm6wNMU4hQOu8urBPU0s1IW50=
X-Received: by 2002:aca:6547:0:b0:363:a539:4f with SMTP id j7-20020aca6547000000b00363a539004fmr776037oiw.189.1675505409255;
 Sat, 04 Feb 2023 02:10:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Sat, 4 Feb 2023
 02:10:08 -0800 (PST)
In-Reply-To: <20230201081010.17446-1-hbh25y@gmail.com>
References: <20230201081010.17446-1-hbh25y@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 4 Feb 2023 19:10:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-hZ=7uiaN0khsUKw6wCxVo_kfxyUdy9advVro6hahaFg@mail.gmail.com>
Message-ID: <CAKYAXd-hZ=7uiaN0khsUKw6wCxVo_kfxyUdy9advVro6hahaFg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix possible memory leak in smb2_lock()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, lsahlber@redhat.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-02-01 17:10 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
> argv needs to be free when setup_async_work fails or when the current
> process is woken up.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  fs/ksmbd/smb2pdu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index d681f91947d9..5b7668c04f76 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -7050,6 +7050,7 @@ int smb2_lock(struct ksmbd_work *work)
>  						      smb2_remove_blocked_lock,
>  						      argv);
>  				if (rc) {
> +					kfree(argv);
>  					err = -ENOMEM;
>  					goto out;
>  				}
> @@ -7061,6 +7062,8 @@ int smb2_lock(struct ksmbd_work *work)
>
>  				ksmbd_vfs_posix_lock_wait(flock);
>
> +				work->cancel_fn = NULL;
> +				kfree(argv);
This change seems to causes a NULL pointer dereference issue in
set_close_state_blocked_works(). It is right to free it and set NULL
after removing entry from list.
>  				if (work->state != KSMBD_WORK_ACTIVE) {
>  					list_del(&smb_lock->llist);
>  					spin_lock(&work->conn->llist_lock);
> --
> 2.34.1
>
>
