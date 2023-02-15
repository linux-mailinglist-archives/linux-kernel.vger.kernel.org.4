Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB227697312
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjBOBFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjBOBFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:05:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A331E14;
        Tue, 14 Feb 2023 17:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82D2EB81F6F;
        Wed, 15 Feb 2023 01:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9773C433A0;
        Wed, 15 Feb 2023 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676423089;
        bh=uled5MfZw7XXOmCAyhiKVWBq9xrDfa7qOOH6kUCEpSw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=V3Zs6UHTvFXl6Arkr1bPeNii5d2YsAFtwRjzYd8PLEWDiE22fQB8zu4OqUW9In3Oa
         avaShsa5VhvPnp32F+j/zE/QNrh+mypHfv0P1KYnz5mJN0aRCgGwARBi7kCKy+ZX4w
         L1nL11iw9O5XB4qAVb4Ovw4SEbmaYRSOwlUQIl2ERQMuCVqVpDb7OUZ6ZY8/CrWta3
         tIUY415sy4WBbFE8+K5Clw7Gc9tgtNm0BqAJidiWMrQOe/4Qsq8aIbhQCvy5c0Imin
         QHgnzSHCWAhgWtnU7k4b8bOedN+6Y0SGIWz5bUDDvPj171KZHCjSqkJlrYzEWtll2N
         FHNTfdWmZYwaw==
Received: by mail-ot1-f49.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso5226939otp.1;
        Tue, 14 Feb 2023 17:04:49 -0800 (PST)
X-Gm-Message-State: AO0yUKVtI841eOe5R+y51Tt+ToXaIm2rgd3oFENJPvuNVsOHCbz5KSnf
        lGN5gtFZ8A+AUSruvTDEGKvmck4FfpbBzq13rbE=
X-Google-Smtp-Source: AK7set9wUqpsDoj+ooHpIw76d9VKqyoZsSF210x30QzBO51IAwNeiZ5LULDZHyqVvASPSwqjtNNnEI1ydJ6D3tp7NXk=
X-Received: by 2002:a05:6830:16d8:b0:68d:a306:4550 with SMTP id
 l24-20020a05683016d800b0068da3064550mr13061otr.91.1676423088974; Tue, 14 Feb
 2023 17:04:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:1a14:0:b0:49f:f8ae:2ce5 with HTTP; Tue, 14 Feb 2023
 17:04:48 -0800 (PST)
In-Reply-To: <20230214063650.12832-1-hbh25y@gmail.com>
References: <20230214063650.12832-1-hbh25y@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 15 Feb 2023 10:04:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9ua+wyXK5a7WQW7BfrkQ2wOu_MwBxLePFg-Jte=mdp4w@mail.gmail.com>
Message-ID: <CAKYAXd9ua+wyXK5a7WQW7BfrkQ2wOu_MwBxLePFg-Jte=mdp4w@mail.gmail.com>
Subject: Re: [PATCH v4] ksmbd: fix possible memory leak in smb2_lock()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, lsahlber@redhat.com, linux-cifs@vger.kernel.org,
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

2023-02-14 15:36 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
> argv needs to be free when setup_async_work fails or when the current
> process is woken up.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>
> v2: avoid NULL pointer dereference in set_close_state_blocked_works()
> v3: avoid race condition between smb2_lock() and smb2_cancel()
> v4: use another way to avoid race condition
>
>  fs/ksmbd/smb2pdu.c   | 20 +++++++++++++-------
>  fs/ksmbd/vfs_cache.c |  2 ++
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index d681f91947d9..1b517d3ca2ef 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -6666,7 +6666,8 @@ int smb2_cancel(struct ksmbd_work *work)
>  				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
>  				    le64_to_cpu(hdr->Id.AsyncId),
>  				    le16_to_cpu(chdr->Command));
> -			cancel_work = iter;
> +			if (iter->cancel_fn)
> +				cancel_work = iter;
You have freed ->cancel_argv in smb2_lock().  Wouldn't this cause UAF
issue the below?

        if (cancel_work) {
                cancel_work->state = KSMBD_WORK_CANCELLED;
                if (cancel_work->cancel_fn)
                        cancel_work->cancel_fn(cancel_work->cancel_argv);
        }
>  			break;
>  		}
>  		spin_unlock(&conn->request_lock);
> @@ -7050,6 +7051,7 @@ int smb2_lock(struct ksmbd_work *work)
>  						      smb2_remove_blocked_lock,
>  						      argv);
>  				if (rc) {
> +					kfree(argv);
>  					err = -ENOMEM;
>  					goto out;
>  				}
> @@ -7061,6 +7063,16 @@ int smb2_lock(struct ksmbd_work *work)
>
>  				ksmbd_vfs_posix_lock_wait(flock);
>
> +				spin_lock(&work->conn->request_lock);
> +				spin_lock(&fp->f_lock);
> +				if (work->state != KSMBD_WORK_CLOSED) {
I think that this check is not needed if we don't delete entry in
set_close_state_blocked_works().
> +					list_del(&work->fp_entry);
> +					work->cancel_fn = NULL;
> +					kfree(argv);
> +				}
> +				spin_unlock(&fp->f_lock);
> +				spin_unlock(&work->conn->request_lock);
> +
>  				if (work->state != KSMBD_WORK_ACTIVE) {
>  					list_del(&smb_lock->llist);
>  					spin_lock(&work->conn->llist_lock);
> @@ -7069,9 +7081,6 @@ int smb2_lock(struct ksmbd_work *work)
>  					locks_free_lock(flock);
>
>  					if (work->state == KSMBD_WORK_CANCELLED) {
> -						spin_lock(&fp->f_lock);
> -						list_del(&work->fp_entry);
> -						spin_unlock(&fp->f_lock);
>  						rsp->hdr.Status =
>  							STATUS_CANCELLED;
>  						kfree(smb_lock);
> @@ -7093,9 +7102,6 @@ int smb2_lock(struct ksmbd_work *work)
>  				list_del(&smb_lock->clist);
>  				spin_unlock(&work->conn->llist_lock);
>
> -				spin_lock(&fp->f_lock);
> -				list_del(&work->fp_entry);
> -				spin_unlock(&fp->f_lock);
>  				goto retry;
>  			} else if (!rc) {
>  				spin_lock(&work->conn->llist_lock);
> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
> index da9163b00350..761a8aa540ce 100644
> --- a/fs/ksmbd/vfs_cache.c
> +++ b/fs/ksmbd/vfs_cache.c
> @@ -372,6 +372,8 @@ static void set_close_state_blocked_works(struct
> ksmbd_file *fp)
>  		list_del(&cancel_work->fp_entry);
>  		cancel_work->state = KSMBD_WORK_CLOSED;
>  		cancel_work->cancel_fn(cancel_work->cancel_argv);
> +		cancel_work->cancel_fn = NULL;
> +		kfree(cancel_work->cancel_argv);
If we remove list_del, we don't need to do them here ? and we can
change _safe version to list_for_each().
>  	}
>  	spin_unlock(&fp->f_lock);
>  }
> --
> 2.34.1
>
>
