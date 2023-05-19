Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4E709BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjESP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjESP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:59:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACE1703
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:59:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75788255892so174328385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684511940; x=1687103940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7PVCQ82ChE6f5eHv+/48kfdhR9GTtp24keOmF6gn3g=;
        b=MkxlrsoeJC/0hzrZsVGKgb4XOClz317JZBaMikI3mvvZIImsx70ykpHN/W9TqJLQbC
         tu5dPWPC4gPoXCkxhG5oeoVRX/rt2qVcKDIBTmkHqNQX2nBvO5K8aVNZ+enwy7H7PdES
         vJPu11K2nGsAPPTEbdiBkBwNYXc3zGiczP7suD+4FYxhJ15ihgVd22rwfBK0SV4xeWEJ
         3ZInrV2MkeunFv5i2khGo5cXOIrlfcUw9RnIvtQreft5Aglnd2QOeWcw8YA7Y+tEdwJW
         OCzlv6499/RSZ4b3ZllNqf8fGLm3gpWGNezJLdLMbuhpPuubi/IFAXi5aw9IuW/Rl9+M
         gfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684511940; x=1687103940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7PVCQ82ChE6f5eHv+/48kfdhR9GTtp24keOmF6gn3g=;
        b=ND4JGDvVUPg5PnAX9BmEZvIhBNvxYBK8b5bqWgyvItuYbyrfxC51Oz6HGElLn8c194
         rh7C7ZhIrBJJb/yP7xkHhE/a7quVtnF9TygiNbUBh0F8Dn3Pf7fTXmD6ytax+HK4tyxg
         mWKPq1Cb+s+12Baa5DTvc6Vi5/TSYW1sYP5KeWgTVQv+JD7HQRojf/vlxpsjD1lW1qEa
         GdjXQHT3Dp8a7ki5SaDEuyZ+LB1o2qR6lkQg3BTxtscBfzYVGYFfMfnyxX3StvYU7ZRV
         n8GZzhzC6j9aN9Nht4mWQKW03XRrRxwCbronhDZQrGwq/ugRLkRpTAu6YaurmKMzJQfY
         UVwQ==
X-Gm-Message-State: AC+VfDwe3U7fQqvIHU+WMWwxew547mpoZZR8JrmPcTES4DYorEY0OW8F
        73NGaYxcxAGKavZWn6X6SQEEoLQburpZ7S3fjfUWtw==
X-Google-Smtp-Source: ACHHUZ7ZcBx+r3AZx5hl4L2ezEki2WsxNHEoqfyNCQ3L/ZmMUgz3QZnyeFwOVeJ1HtgulleOxvpKE3+EeGFP+T5tS+k=
X-Received: by 2002:a05:6214:27e6:b0:61e:800b:4fcc with SMTP id
 jt6-20020a05621427e600b0061e800b4fccmr5107631qvb.25.1684511939869; Fri, 19
 May 2023 08:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230518035321.1672-1-angus.chen@jaguarmicro.com>
 <20230518130221.81e8e1f474cfbfd6c93712c5@linux-foundation.org>
 <CAKwvOdmtnpETT4P88NZKAtLNvj4kJ7MtotAwNJSdh7WVxa_xJA@mail.gmail.com> <TY2PR06MB3424AB7EAB6AEB779D6EAB1A857C9@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB3424AB7EAB6AEB779D6EAB1A857C9@TY2PR06MB3424.apcprd06.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 May 2023 08:58:48 -0700
Message-ID: <CAKwvOdkppYFVnnjBetUK=KVw5dg6_NcgX73mnjOSFpA_XtEd5w@mail.gmail.com>
Subject: Re: [PATCH] init: Add bdev fs printk if mount_block_root failed
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:34=E2=80=AFPM Angus Chen <angus.chen@jaguarmicro=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > Sent: Friday, May 19, 2023 4:36 AM
> > To: Andrew Morton <akpm@linux-foundation.org>; Angus Chen
> > <angus.chen@jaguarmicro.com>
> > Cc: masahiroy@kernel.org; vbabka@suse.cz; peterz@infradead.org;
> > paulmck@kernel.org; rppt@kernel.org; linux-kernel@vger.kernel.org; Al V=
iro
> > <viro@zeniv.linux.org.uk>
> > Subject: Re: [PATCH] init: Add bdev fs printk if mount_block_root faile=
d
> >
> > I wish the commit message showed an example of the panic after the
> > patch, to contrast the before vs. after.
> en ,Did a need to send a v2 or just let it go this time?

Nah, it's fine. LGTM

> The information is print:
> [    1.570841] VFS: Cannot open root device "vda" or unknown-block(253,0)=
: error -19
> [    1.571513] Please append a correct "root=3D" boot option; here are th=
e available partitions:
> [    1.572056] fd00          256000 vda
> [    1.572058]  driver: virtio_blk
> [    1.572525] List of all bdev filesystem:
> [    1.572780]  ext2
> [    1.572781]
> [    1.573027] Kernel panic - not syncing: VFS: Unable to mount root fs o=
n unknown-block(253,0)
>
> Or:
> [    1.510467] VFS: Cannot open root device "vda" or unknown-block(253,0)=
: error -19
> [    1.512033] Please append a correct "root=3D" boot option; here are th=
e available partitions:
> [    1.513724] fd00          256000 vda
> [    1.513731]  driver: virtio_blk
> [    1.514280] Can't find any bdev filesystem!
> [    1.514540] Kernel panic - not syncing: VFS: Unable to mount root fs o=
n unknown-block(253,0)

--=20
Thanks,
~Nick Desaulniers
