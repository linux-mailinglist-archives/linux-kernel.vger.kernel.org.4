Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559DB73E383
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFZPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFZPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1146E73
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687793792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Veur/EKeEucIQvMxKWii3PHeDlJfVrEb91ZCZfO5tlg=;
        b=RvXdNclURqj1Di6TdgnUxry9f9iTK0VVBRpgjP0cS0Hj2FLeKRpCzlWxCI/q7lDDatNGg9
        lgmuYr8D6/VK8rq4Al5ve+g+9BqM0wH+IzU6Ewo3TNLZ/Ol9mfLWOF46KrK5txivzD6xtM
        g7Ou8scBtvyER4gK1yAQFE+fn+6KhzE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-Zh6pMpoPMzilqsGeGQc9SQ-1; Mon, 26 Jun 2023 11:36:29 -0400
X-MC-Unique: Zh6pMpoPMzilqsGeGQc9SQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa83859fa4so11539155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793788; x=1690385788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veur/EKeEucIQvMxKWii3PHeDlJfVrEb91ZCZfO5tlg=;
        b=dq9ySAB+75MnNH9Wg7u8wx6f34v/c6eWkyuL8UALNvseD1l/A0TXqM5QFrVHd9NVzm
         UHBshvEwaNGn7oT/kxWaKRwVLZT2cW2CKh2Q0UuR9E7oc0QcpfUvsIG3ld5qg0RqC/if
         QY5A3wGY4lyQdis84q44WTiyW7Bm4rEpW2oWhtj5/7lyyq0O/QgCyVrtt1JmILi6SkyP
         HflvxJMFRepCoBJniRxqIdaUcuoiIArbMgC+6A3l5Pi+kCssXHLL+vcqJOhVAuSN+Bhh
         szfzGZ3F3ExERwR2r3oVDXEzLgW/RYFQtjlZN4KmBpTXJkwbP1h7wy/+M1YH+T3NZK+e
         Jlvg==
X-Gm-Message-State: AC+VfDxoWM+a9L5qXuhcJdtmEpBXiNKsZo3WAHpAfAp9SxVlvm/z7idp
        OL51jyc4POKHKcEJpm6Ju8E9e12FPVBAKBpH5noWyEEfRveytEHdwEtqht094uDSofrTLIRG/t2
        yryUk1XWzovfbCNP6jIhetMc/
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id p1-20020a05600c204100b003fa78083e16mr7954058wmg.29.1687793788106;
        Mon, 26 Jun 2023 08:36:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JE+Pa90hkEnWZ1VrQhlMmSsls+KtMOsA3+quZnWIop516YIwu6zTpA6a8rTt6waN7qNK4uA==
X-Received: by 2002:a05:600c:2041:b0:3fa:7808:3e16 with SMTP id p1-20020a05600c204100b003fa78083e16mr7954040wmg.29.1687793787831;
        Mon, 26 Jun 2023 08:36:27 -0700 (PDT)
Received: from redhat.com ([2.52.141.236])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bcb98000000b003f727764b10sm8134888wmi.4.2023.06.26.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:36:27 -0700 (PDT)
Date:   Mon, 26 Jun 2023 11:36:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     syzbot <syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com>,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read
 in __vhost_vq_attach_worker
Message-ID: <20230626113540-mutt-send-email-mst@kernel.org>
References: <000000000000df3e3b05ff02fe20@google.com>
 <20230626031411-mutt-send-email-mst@kernel.org>
 <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216718d1-1e32-9ebc-bd5e-96beab3fdc1b@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:03:25AM -0500, Mike Christie wrote:
> On 6/26/23 2:15 AM, Michael S. Tsirkin wrote:
> > On Mon, Jun 26, 2023 at 12:06:54AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    8d2be868b42c Add linux-next specific files for 20230623
> >> git tree:       linux-next
> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12872950a80000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8ac8dd33677e8e0
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=8540db210d403f1aa214
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c1b70f280000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122ee4cb280000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/2a004483aca3/disk-8d2be868.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/5688cb13b277/vmlinux-8d2be868.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/76de0b63bc53/bzImage-8d2be868.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit 21a18f4a51896fde11002165f0e7340f4131d6a0
> >> Author: Mike Christie <michael.christie@oracle.com>
> >> Date:   Tue Jun 13 01:32:46 2023 +0000
> >>
> >>     vhost: allow userspace to create workers
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130850bf280000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=108850bf280000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=170850bf280000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+8540db210d403f1aa214@syzkaller.appspotmail.com
> >> Fixes: 21a18f4a5189 ("vhost: allow userspace to create workers")
> > 
> > Mike, would appreciate prompt attention to this as I am preparing
> > a pull request for the merge window and need to make a
> > decision on whether to include your userspace-controlled
> > threading patchset.
> > 
> 
> Do you want me to resubmit the patchset or submit a patch against your vhost
> branch?

Resubmit pls.

> The bug is that vhost-net can call vhost_dev_reset_owner and that will
> free the workers. However, I leave the virtqueue->worker pointer set so
> we end up referencing the freed workers later on. When I handled a
> review comment between v5 and v6, I deleted that code thinking it was
> also not needed.
> 
> So the fix is:
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ab79b064aade..5a07e220e46d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -607,6 +607,10 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  
>  	if (!dev->use_worker)
>  		return;
> +
> +	for (i = 0; i < dev->nvqs; i++)
> +		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).
> 
> 

