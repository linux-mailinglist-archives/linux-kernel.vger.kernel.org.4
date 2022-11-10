Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018F5624155
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKJLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:24:30 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5753EDA;
        Thu, 10 Nov 2022 03:24:30 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso919605otq.11;
        Thu, 10 Nov 2022 03:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M/bfkY3he+z+54lCAwGOvId+BMfqdZ1/lFx/xUS+yX4=;
        b=Kge9KkGpGIjiOCRlbWdZnt3Tp398py3Z/sQgzSTP/8EhYFNkjV3Ycjr2dgN5crbGfG
         qNJVu/hxqFSigFzNaXOERuEXwVq9nrwMjBCQjpEw3o5vmER+pQQpWg4l/xJABvJyWF5J
         dYdu1IvzGWLnh+13kvTR8c/3yfTnBoxQ1U/oQ9f5zwzSpXNFiGxZMkW4sJ0M8EEiKvcz
         7kbCEklSDPtFfgDOf/EiOdGn4m+sqBi2eFwFy0kB7oohdJFe6txXF9C2U6vWEvo62nEd
         C1e9gNzW9xVBr3d7ESQqa1fjXoYeYLf0b8WkWI08vaWUs5pq6wY9k+38qD84ICz7wZpu
         mM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/bfkY3he+z+54lCAwGOvId+BMfqdZ1/lFx/xUS+yX4=;
        b=Q8hGMiLGoHFuNfNQiAbdzu5QX80Yt+ETScOBB3zfrfEKbW43EH+Tor+7fYco2jhY0/
         BZxxHE17sSIJBaX0ZjKUPTG4Qj3fM7mJW7HsVuht0NQYhJDgRRLaUvrKypE28uAdymBK
         ePD37cJbt+Qy/Pk6Dh57RUAZ11j3TdotFO3x9xsMNFaCPndSEf/QLQYpWLUjdDWbgugK
         k9q71Otgzi1ONWhM85GlEXdSv3oDppYXiBPnhHitrez0gHO5oL20+6vZmsdul43bmUA5
         6g+JvqDmTIznsijeulDu/vmVVkmawUH8CRaJVzqzKOr1veGsOHVA4olO6vLDxKQbsSA3
         Um8A==
X-Gm-Message-State: ACrzQf0dWytYRMFVIhu5AxlQgrQE+zTNXfrPkkO6xpoplgTTy8/l+DHi
        /a96dqHhRNIaY+EolQwcDYYPshPlOSDMBd/34XJ90eyYxdc=
X-Google-Smtp-Source: AMsMyM71O/HADyhZkimMI2U/ebjnQ8Et8U/VKA8S8mQhz1ae6NXizy2ERgFMlf9PYKVzbYdirUgsnnCFcjqD98EyNP8=
X-Received: by 2002:a9d:6aca:0:b0:655:e3c3:f66c with SMTP id
 m10-20020a9d6aca000000b00655e3c3f66cmr1304816otq.344.1668079469730; Thu, 10
 Nov 2022 03:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20221110031311.1629288-1-linmq006@gmail.com> <67a1782c-9b7d-055a-5e62-456294cb4401@redhat.com>
In-Reply-To: <67a1782c-9b7d-055a-5e62-456294cb4401@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 10 Nov 2022 12:24:16 +0100
Message-ID: <CAOi1vP8fuke7zYyAi0AEdf+Kav1f5WfEaktcUE_2wMb2-X5deg@mail.gmail.com>
Subject: Re: [PATCH] ceph: Fix NULL vs IS_ERR checking in ceph_getattr
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 6:45 AM Xiubo Li <xiubli@redhat.com> wrote:
>
> Hi Miaoqian,
>
> Thanks for your patch. This has already been fixed by Dan Carpenter
> weeks ago and already in the ceph-client's testing branch, please see [1]:
>
> [1]
> https://github.com/ceph/ceph-client/commit/ffc4d66a34bb5bd76d0a3f83bebf500d96a8e37c

It's also present in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ffc4d66a34bb5bd76d0a3f83bebf500d96a8e37c

Thanks,

                Ilya
