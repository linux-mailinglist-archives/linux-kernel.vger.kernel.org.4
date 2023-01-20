Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB85D674FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjATIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1297CCC3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674204215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ieVgb0wdTbUDgdUwiBcUCrz7AjasaHhJqwRtTkIp84=;
        b=ViGyrr9r9RuIq3OK2pb8ZkVSoTmzKFGBFv7Brluoaq/8+C8aKF4XoOEAJB5NEJYqOzP2y1
        0/f2Q9IHbHbyQrJIotWwMfNLvWdIvuSsRpNVsPigjA0f+oYOwkzpmayM/7L6rWDLU2tho1
        p0OB4rq3Mbfpk4wf5eMu4mdJSeXoKa0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-_2y19hoYM36dLV07yf79ag-1; Fri, 20 Jan 2023 03:43:33 -0500
X-MC-Unique: _2y19hoYM36dLV07yf79ag-1
Received: by mail-il1-f197.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso3354810ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ieVgb0wdTbUDgdUwiBcUCrz7AjasaHhJqwRtTkIp84=;
        b=VRLQqgoc6otOImPssLq9Tkz+reuPtI2LmWHrwrQLPH0V5Lz9A3pLgA+0qFAI/K05TN
         vtnV6i6YISLn/ygFeAztgVQU7oMRk8nt8syNqeK/yresYQGnzrMC74YG8E4HR5NkX78G
         odmDW2N6XNxgpliUFrdYRgyUOhiYfGAnqYaq3nJwolIWBdbCY6bTYEU3OCTelEWV3MrN
         CPsk7Ru/wRj/+CbW5Co3qN7pSIZBLv6EnO1M3yiOM+KAIau+90o2E6CNXOB4yz05p1v0
         8kDDqN//yszDTW+EcUkr7ic9CdXw03+bR/UPF5WUrsIz+77dv4wVZ8J7pHSQ0FUfoQMH
         YfTw==
X-Gm-Message-State: AFqh2kqP8gVhb8YP3v8dG8/imIbf5x1kGH5Ed1ykCgJU48hJSeCFbcFz
        1ilHiMm9rP5ycus2YDwCr+pUGxWgy9NubO3HzLS0duYZ/ir4tLdk5Z8yiZvvl8DEyprwuWvG2RP
        H6+Vna84rEP433X4VEcxsFOQD3GE8YbmwdMT7NDCW
X-Received: by 2002:a5d:884b:0:b0:704:d851:64ba with SMTP id t11-20020a5d884b000000b00704d85164bamr818293ios.135.1674204212930;
        Fri, 20 Jan 2023 00:43:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuqWj7kT7WAI3DeIVj9rztUM3R8UUxuRsEPXeV6XWDqUb5Yxgs99M9gWUoAq8V02mWEWfIaFyr9o0FeQ5PeRM0=
X-Received: by 2002:a5d:884b:0:b0:704:d851:64ba with SMTP id
 t11-20020a5d884b000000b00704d85164bamr818292ios.135.1674204212712; Fri, 20
 Jan 2023 00:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20230119211455.498968-1-echanude@redhat.com> <20230119211455.498968-2-echanude@redhat.com>
 <Y8m/ljQUJOefsD6O@ZenIV>
In-Reply-To: <Y8m/ljQUJOefsD6O@ZenIV>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Fri, 20 Jan 2023 09:43:21 +0100
Message-ID: <CAL7ro1EESqanEQnGnLqd_WvoxL0ybn0XJwtMAFxap=w-a=-Vig@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from namespace_unlock
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Chanudet <echanude@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Jan 19, 2023 at 04:14:55PM -0500, Eric Chanudet wrote:
> > From: Alexander Larsson <alexl@redhat.com>
> >
> > Use call_rcu to defer releasing the umount'ed or detached filesystem
> > when calling namepsace_unlock().
> >
> > Calling synchronize_rcu_expedited() has a significant cost on RT kernel
> > that default to rcupdate.rcu_normal_after_boot=1.
> >
> > For example, on a 6.2-rt1 kernel:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >            0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )
> >
> > With this change applied:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >         0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )
> >
> > Waiting for the grace period before completing the syscall does not seem
> > mandatory. The struct mount umount'ed are queued up for release in a
> > separate list and no longer accessible to following syscalls.
>
> Again, NAK.  If a filesystem is expected to be shut down by umount(2),
> userland expects it to have been already shut down by the time the
> syscall returns.
>
> It's not just visibility in namespace; it's "can I pull the disk out?".
> Or "can the shutdown get to taking the network down?", for that matter.

In the usecase we're worrying about, all the unmounts are lazy (i.e.
MNT_DETACH). What about delaying the destroy in that case? That seems
in line with the expected behaviour of lazy shutdown. I.e. you can't
rely on it to be settled anyway.


-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

