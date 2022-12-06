Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CC6444DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiLFNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLFNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:47:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082086170;
        Tue,  6 Dec 2022 05:47:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9843161763;
        Tue,  6 Dec 2022 13:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C23C433D7;
        Tue,  6 Dec 2022 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670334462;
        bh=3qXkpQ5Oz7bpT3VEqA95fX8I1PdWWrzSQrVPTpdVTxg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RDoErpHdigi8RzIzdk5bfXc56IRDcO8lRF1hzBfEWlwYnrLHsjzKPhC8xwS5QVNj4
         F3KbRV5HBLSe7ig/35CwAK5w8Fsb4HxKyvWFQFLLZmQT2WIv+/kCYhv0lA8scfyuzp
         d8wEPfJjCvSWrYE04CHDkpFlKPxsWcP1JMOsh4QOeLV0BtH6SzCnBQ49A04qqClV9T
         +nn4r+yLsv2C+CDGU6/YLEqK9FVVxSg5nFt3DzdQejk14/FeLmm5zAG/22m9nw/bsW
         82qftxsgIv0LO+/t/erf4B2SlDmWDduK3mtQJBo7s+pyfyMFJYTONiBZitcVFAHgAH
         Iq5l11kIm1KoQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-14455716674so11289808fac.7;
        Tue, 06 Dec 2022 05:47:42 -0800 (PST)
X-Gm-Message-State: ANoB5pk3wOzX44UBbyXDknfR65GaHdtk5xRC91ObZrjuiNJB5anAbHm9
        zTnd5rncEfBr5OTshczAs1vlRgesCGduonTY4cI=
X-Google-Smtp-Source: AA0mqf73W498Ri/qiT/qJht092b6FijkvmmSJg9fAULL/8Z1IecqJX89gxsOn0GM0hCKElQlRsDM6UhLukn32RsCH9w=
X-Received: by 2002:a05:6870:430a:b0:13d:5167:43e3 with SMTP id
 w10-20020a056870430a00b0013d516743e3mr39872537oah.257.1670334462038; Tue, 06
 Dec 2022 05:47:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Tue, 6 Dec 2022 05:47:41
 -0800 (PST)
In-Reply-To: <202212051703254109015@zte.com.cn>
References: <202212051703254109015@zte.com.cn>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 6 Dec 2022 22:47:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd86zq=NHC56AduDaWR6yMoM1WGeJq8ThBkDy2vXRc+SOw@mail.gmail.com>
Message-ID: <CAKYAXd86zq=NHC56AduDaWR6yMoM1WGeJq8ThBkDy2vXRc+SOw@mail.gmail.com>
Subject: Re: [PATCH linux-next] ksmbd: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-12-05 18:03 GMT+09:00, ye.xingchen@zte.com.cn <ye.xingchen@zte.com.cn>:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  fs/ksmbd/server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
> index a0d635304754..b0da15377709 100644
> --- a/fs/ksmbd/server.c
> +++ b/fs/ksmbd/server.c
> @@ -433,7 +433,7 @@ static ssize_t stats_show(struct class *class, struct
> class_attribute *attr,
>  		"shutdown"
>  	};
>
> -	ssize_t sz = scnprintf(buf, PAGE_SIZE, "%d %s %d %lu\n", stats_version,
> +	ssize_t sz = sysfs_emit(buf, "%d %s %d %lu\n", stats_version,
>  			       state[server_conf.state], server_conf.tcp_port,
>  			       server_conf.ipc_last_active / HZ);
It would be great if you remove sz variable and return it directly.

Thanks.
>  	return sz;
> --
> 2.25.1
>
