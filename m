Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BCF68CAC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFXpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBFXpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:45:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291D1303E5;
        Mon,  6 Feb 2023 15:44:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4A7EB8167D;
        Mon,  6 Feb 2023 23:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E32AC433A0;
        Mon,  6 Feb 2023 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675727073;
        bh=+VS0T7saKGxXpafCOxelveBrW5g7V/bi82d9i0jTJOw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Mefy5tCBU30U2vgPjHQ7NT0ziRYCnzZIx9vft/xTFg2vhJlUt6LHSYKLSoGkXCWYd
         R08UlnTuVBLXJgpsldZISrLKoWp1+BTS7RzEahS7i0yztNYFj1N9c+xeioDxRrQJp7
         u2fxlEXTGZfG0qx88czFSgAoPEEEW7vv10J/K0etpfvWOzMvpURkF17K3wvEKfW6EN
         Nb+iqGn6Tp1etLPp/X3m9/1KiOQc4CxSau7PA7n90aLIzATln0Bqv9o31ZvaqkagUo
         gYO0sQrVuSzk30yAmsgZBhxyU5XNY3gx83c9e5XVE+k/7Kb9st3MrC/HmSCTshFEqO
         C49rnhzyT028A==
Received: by mail-oi1-f173.google.com with SMTP id 20so10436454oix.5;
        Mon, 06 Feb 2023 15:44:33 -0800 (PST)
X-Gm-Message-State: AO0yUKUe1Qpn1DkPv+VbgK0Qbj4RG09MXHQlgiQZU8aT0ExjSSOknS0N
        1a1/cgS6VhMNOgLQRmI/j3bSxHnD3QWS4W5Eip0=
X-Google-Smtp-Source: AK7set+239NZEdy9JC4+houRK9nVQSewhMxnSxX0ik41Ipo6URjzwhlruxeiBMQvMt0MG9ioy/nceY43s38Zk6g68O0=
X-Received: by 2002:a05:6808:10:b0:378:57fb:de1f with SMTP id
 u16-20020a056808001000b0037857fbde1fmr1019860oic.215.1675727072447; Mon, 06
 Feb 2023 15:44:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Mon, 6 Feb 2023
 15:44:31 -0800 (PST)
In-Reply-To: <20230206023630.9457-1-hbh25y@gmail.com>
References: <20230206023630.9457-1-hbh25y@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 7 Feb 2023 08:44:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9c1Cm=3vbqTO6V=mwfu=YUEwEiGYZFc0mBfeSuH4phyQ@mail.gmail.com>
Message-ID: <CAKYAXd9c1Cm=3vbqTO6V=mwfu=YUEwEiGYZFc0mBfeSuH4phyQ@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fix possible memory leak in smb2_lock()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        lsahlber@redhat.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-02-06 11:36 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
> argv needs to be free when setup_async_work fails or when the current
> process is woken up.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>
> v2: avoid NULL pointer dereference in set_close_state_blocked_works()
>
>  fs/ksmbd/smb2pdu.c   | 5 +++++
>  fs/ksmbd/vfs_cache.c | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index d681f91947d9..177a24704021 100644
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
> @@ -7072,6 +7073,8 @@ int smb2_lock(struct ksmbd_work *work)
>  						spin_lock(&fp->f_lock);
>  						list_del(&work->fp_entry);
>  						spin_unlock(&fp->f_lock);
> +						kfree(argv);
> +						work->cancel_fn = NULL;
>  						rsp->hdr.Status =
>  							STATUS_CANCELLED;
>  						kfree(smb_lock);
> @@ -7096,6 +7099,8 @@ int smb2_lock(struct ksmbd_work *work)
>  				spin_lock(&fp->f_lock);
>  				list_del(&work->fp_entry);
>  				spin_unlock(&fp->f_lock);
> +				kfree(argv);
> +				work->cancel_fn = NULL;
This doesn't seem so simple... You have to consider the racy issue
between this change and smb2_cancel(). Also, how are you testing this
patch?

>  				goto retry;
>  			} else if (!rc) {
>  				spin_lock(&work->conn->llist_lock);
> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
> index da9163b00350..eb95c16393b7 100644
> --- a/fs/ksmbd/vfs_cache.c
> +++ b/fs/ksmbd/vfs_cache.c
> @@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct
> ksmbd_file *fp)
>  		list_del(&cancel_work->fp_entry);
>  		cancel_work->state = KSMBD_WORK_CLOSED;
>  		cancel_work->cancel_fn(cancel_work->cancel_argv);
> +		kfree(cancel_work->cancel_argv);
> +		cancel_work->cancel_fn = NULL;
>  	}
>  	spin_unlock(&fp->f_lock);
>  }
> --
> 2.34.1
>
>
