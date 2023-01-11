Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5295665768
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbjAKJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjAKJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:27:12 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31661BC12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:26:25 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so10475907ila.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1bwp68gAWsUOZW4RECodPiofiO1XXH/Q4722U5Mfno=;
        b=oLe3uKAoWzj3xbBMKLeCkkFJ5f7VMl2S4puwkpLzAN0EwHytup/KMrxBbrjQlkQtWB
         VVmtpWRdo6VVff7s7Crc3jVwMQwWorGXFeXdVonlKO0YOhrFKVMRbL8xd/Icgms2XBVh
         kdOhuXXifY3DSX2Rbckd+UQkKeO7Qdr4Ti6Tf+KiCdKPaIsjJLfWnf0cXUbo65cOP6ZT
         8M6THS5ZpVOgjKCbXxQd3Ja2CMHb35KTffEkps8e98dGN1QrgyKlUsnrBsqWru0SzCKP
         USraOJOk9DPEOsBTJkY4lrMR8lSHjWUPnn8QwUyNadiBLidrw1B59K09POIZl7JjtdPK
         jT3Q==
X-Gm-Message-State: AFqh2krB0DteIfKfLs0rWFqCSHPkZo2femY5RopGx3c7fKwbpZ6QMsRk
        LR1yaC119FpIHLTMc8DHuvWIRXes5SbfkWely84YH7GkPI6P
X-Google-Smtp-Source: AMrXdXuddnLe3VxVd5wsclm0js7M5hizTyAyr0FScpDsPnEyue1zmnnsi6cQwd0NWKMW3xemr8q9qKa1g0hxSlUBxAiVn5MJfTa+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f18:b0:38d:30a7:2ae0 with SMTP id
 ck24-20020a0566383f1800b0038d30a72ae0mr7083175jab.234.1673429184700; Wed, 11
 Jan 2023 01:26:24 -0800 (PST)
Date:   Wed, 11 Jan 2023 01:26:24 -0800
In-Reply-To: <2263420.1673429178@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c6a5505f1f99893@google.com>
Subject: Re: [syzbot] kernel BUG in rxrpc_put_call
From:   syzbot <syzbot+4bb6356bb29d6299360e@syzkaller.appspotmail.com>
To:     dhowells@redhat.com
Cc:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

want 2 args (repo, branch), got 5

>
> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index 3ded5a24627c..f3c9f0201c15 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -294,7 +294,7 @@ static void rxrpc_put_call_slot(struct rxrpc_call *call)
>  static int rxrpc_connect_call(struct rxrpc_call *call, gfp_t gfp)
>  {
>  	struct rxrpc_local *local = call->local;
> -	int ret = 0;
> +	int ret = -ENOMEM;
>  
>  	_enter("{%d,%lx},", call->debug_id, call->user_call_ID);
>  
>
