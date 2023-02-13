Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0DF6954D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBMXfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:35:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE4AD3C;
        Mon, 13 Feb 2023 15:35:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56BC66130C;
        Mon, 13 Feb 2023 23:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9607C433A1;
        Mon, 13 Feb 2023 23:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676331319;
        bh=/Ji09aDanjBQjhtjCe/XRna1C3DDnXOqIdSGkEE3PVk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nX7h1Vo1eZWt5dmMzKA/Ws+AGVjDmNh7emYRpeeB557yfFC8FLl9H/h3WJaIq7XC5
         +plZ7ST6JQbuQy05XatEQJlLBXg07Z5U9SMvd7USkxiw7cOaOxSe+LH5EGoQuZbKgc
         onXqOR3Mf9lKhcIBEtPH9ioMbLd3qWrJLwJerQL3PqsT12xEivoN81rpbo9pkwnChS
         5qOrXwynL0zBJNIyRjP5gGOj7QM/FlJbbjFx1HANm3sJRB0RxETyTR4VURvt8624bf
         up5hS3k1auuIBUKAvf6bQ6CGl3aBKIyXTsQc9XUVIGOX4pxLd1iVRyNM/OfjA1bPGF
         /d8osp0837emg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-16aa71c1600so17056772fac.11;
        Mon, 13 Feb 2023 15:35:19 -0800 (PST)
X-Gm-Message-State: AO0yUKUI/4tFA6ncOM2rWZ5IWLgUf+cujuMQxkAfbCaMhn5Egadv7ky3
        p7E7eg9FJ8G3aBcmSCpZ3CBK6tqQ3iybQN+qM9g=
X-Google-Smtp-Source: AK7set9RFb/d0kHJyXl7tLftzSvGggC3zgXDkG6YDKzJA317PkqaWfBHk4lAWOgTXZMK0LFGz8PLb3WYm2OEeBYhbNY=
X-Received: by 2002:a05:6870:8189:b0:163:5449:2b22 with SMTP id
 k9-20020a056870818900b0016354492b22mr3935107oae.189.1676331318815; Mon, 13
 Feb 2023 15:35:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Mon, 13 Feb 2023
 15:35:18 -0800 (PST)
In-Reply-To: <20230207080728.15725-1-hbh25y@gmail.com>
References: <20230207080728.15725-1-hbh25y@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 14 Feb 2023 08:35:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-0oHPS4ca4j7rPTe6i4EgZqvx2ukYkJ0NqaFh2gmkK3Q@mail.gmail.com>
Message-ID: <CAKYAXd-0oHPS4ca4j7rPTe6i4EgZqvx2ukYkJ0NqaFh2gmkK3Q@mail.gmail.com>
Subject: Re: [PATCH v3] ksmbd: fix possible memory leak in smb2_lock()
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

2023-02-07 17:07 GMT+09:00, Hangyu Hua <hbh25y@gmail.com>:
> argv needs to be free when setup_async_work fails or when the current
> process is woken up.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>
> v2: avoid NULL pointer dereference in set_close_state_blocked_works()
> v3: avoid race condition between smb2_lock() and smb2_cancel()
>
>  fs/ksmbd/smb2pdu.c   | 23 ++++++++++++++---------
>  fs/ksmbd/vfs_cache.c |  2 ++
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index d681f91947d9..f4079518eaf6 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -6644,7 +6644,7 @@ int smb2_cancel(struct ksmbd_work *work)
>  	struct ksmbd_conn *conn = work->conn;
>  	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
>  	struct smb2_hdr *chdr;
> -	struct ksmbd_work *cancel_work = NULL, *iter;
> +	struct ksmbd_work *iter;
>  	struct list_head *command_list;
>
>  	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
> @@ -6666,7 +6666,9 @@ int smb2_cancel(struct ksmbd_work *work)
>  				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
>  				    le64_to_cpu(hdr->Id.AsyncId),
>  				    le16_to_cpu(chdr->Command));
> -			cancel_work = iter;
> +			iter->state = KSMBD_WORK_CANCELLED;
> +			if (iter->cancel_fn)
> +				iter->cancel_fn(iter->cancel_argv);
>  			break;
>  		}
>  		spin_unlock(&conn->request_lock);
> @@ -6685,18 +6687,12 @@ int smb2_cancel(struct ksmbd_work *work)
>  				    "smb2 with mid %llu cancelled command = 0x%x\n",
>  				    le64_to_cpu(hdr->MessageId),
>  				    le16_to_cpu(chdr->Command));
> -			cancel_work = iter;
> +			iter->state = KSMBD_WORK_CANCELLED;
>  			break;
>  		}
>  		spin_unlock(&conn->request_lock);
>  	}
>
> -	if (cancel_work) {
> -		cancel_work->state = KSMBD_WORK_CANCELLED;
> -		if (cancel_work->cancel_fn)
> -			cancel_work->cancel_fn(cancel_work->cancel_argv);
> -	}
> -
>  	/* For SMB2_CANCEL command itself send no response*/
>  	work->send_no_response = 1;
>  	return 0;
> @@ -7050,6 +7046,7 @@ int smb2_lock(struct ksmbd_work *work)
>  						      smb2_remove_blocked_lock,
>  						      argv);
>  				if (rc) {
> +					kfree(argv);
>  					err = -ENOMEM;
>  					goto out;
>  				}
> @@ -7061,6 +7058,10 @@ int smb2_lock(struct ksmbd_work *work)
>
>  				ksmbd_vfs_posix_lock_wait(flock);
>
> +				spin_lock(&work->conn->request_lock);
> +				list_del_init(&work->async_request_entry);
It is called again in ksmbd_conn_try_dequeue_request().
> +				spin_unlock(&work->conn->request_lock);
> +
