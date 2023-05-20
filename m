Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119AC70A84D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjETNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjETNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:19:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF13BE
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 06:19:50 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3667B3F125
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684588788;
        bh=NzthO7BMG0Z86lKTG5pcPZLaqdSgk8GzDOcuVAlDI3A=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=wXdF+c8Wfz0aZ5OVDhy/iU5/99nBsm6BwOUXsQcP1y9sUr6EX3Q4TeZgZ7E68MX0q
         SqXk7gt/X3w4OdZsA8exzwIiY3dlqb/F+dB9cif5Dkd1FfuKwKFqUZQvNqEZI+6jdv
         U68XxTLZmDG8QWSBIfU8wg0AgeP3fbUh5O7mNo8yKJIUpbA3uLbOt4DhwclFCiKuu2
         lO1F1zzsOc9yG4Hcc2ytSShVaykTukmfu7JS8EKNTtfEfgB1XZ1qfVuZjR+VxWZz4U
         l5mng90Xez039mv6AM0lL94G9TimmwbkwqCsrlpVTlfb5TvFcZagJAWWJKKVnfMXhI
         DwbEAlugFnXWw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fa4c724fdso38266066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 06:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684588787; x=1687180787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzthO7BMG0Z86lKTG5pcPZLaqdSgk8GzDOcuVAlDI3A=;
        b=QpaftydVJL5uXMgHxYEjXovBaKzuJemi/XAM2Puf3vgmQoSaVE1SdEAcMbU2iFbYGJ
         i3nHs/7M8Oj0tVRtRFQj8MVvZEFfR53tWL/4GufypVj4coIJxFebAva/VwOB45Av2iCz
         asonWCDzV3adaimiKpXGXrgFVHQ0ff4ZJJ9pdMcFJvSYF3WaAvAtb/1zg1Kke1lECsvo
         4tARCTjnQhd3Q9piTKDlzZcvh6RDF6QbYwI334BrOVMNOwHyKlFX0dUPL63Ztkug1K+I
         /gs+VfCy8ZbnQVYXP+9G/aTWO+KlTbLDeI8PVL4m6V1lZwyfw/5JiM1zVk3fw/BHYV9k
         Y/eA==
X-Gm-Message-State: AC+VfDzaaLsHiaQhYDflavIjXuSGlb7LgnNV02pU83zwKqZeqjwpEIp5
        hEnMcQcJjjR8TpMW5D3L1PolihWYC07udfmg8M3c/yC2+92N6TwGARsOCUG/fTCx8mkjUVxYOMn
        EaA/acyHVjSmyLAGrNNyY0pudtszt396caD/SbC31VA==
X-Received: by 2002:a17:907:360c:b0:969:9c0c:4c97 with SMTP id bk12-20020a170907360c00b009699c0c4c97mr4345923ejc.1.1684588787745;
        Sat, 20 May 2023 06:19:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7du0+pcc/ypA6rXudHicfHbFFFlQPmbDMyIlAS1D42x2hBvPlKAhnw6o02K4eWbFkgkHqzhA==
X-Received: by 2002:a17:907:360c:b0:969:9c0c:4c97 with SMTP id bk12-20020a170907360c00b009699c0c4c97mr4345910ejc.1.1684588787417;
        Sat, 20 May 2023 06:19:47 -0700 (PDT)
Received: from localhost (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906c30e00b0094f410225c7sm770863ejz.169.2023.05.20.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 06:19:47 -0700 (PDT)
Date:   Sat, 20 May 2023 15:19:44 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovl: make consistent use of OVL_FS()
Message-ID: <ZGjI8Hutt9JwuN/i@righiandr-XPS-13-7390>
References: <20230520120528.339680-1-andrea.righi@canonical.com>
 <CAOQ4uxjOgWDqufLcabkkPcxvFcrehzoDuO0d6kdJZuoiRBKStw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjOgWDqufLcabkkPcxvFcrehzoDuO0d6kdJZuoiRBKStw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 03:33:32PM +0300, Amir Goldstein wrote:
> On Sat, May 20, 2023 at 3:20 PM Andrea Righi <andrea.righi@canonical.com> wrote:
...
> > @@ -97,6 +99,8 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
> >
> >  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
> >  {
> > +       /* Make sure OVL_FS() is always used with an overlayfs superblock */
> > +       BUG_ON(sb->s_magic != OVERLAYFS_SUPER_MAGIC);
> 
> 1. Adding new BUG_ON to kernel code is not acceptable - if anything
>     you can add WARN_ON_ONCE()

OK, but accessing a pointer to a struct ovl_fs that is not really a
struct ovl_fs can potentially have nasty effects, even data corruption
maybe? I'd rather crash the system now rather than experiencing random
behaviors later...

> 2. If anything, you should check s_type == s_ovl_fs_type, not s_magic

Hm.. is there a fast way to determine when sb->s_type == overlayfs?
Using get_fs_type() here seems quite expensive and I'm not even sure if
it's doable, is there a better way that I don't see?

> 3. It is very unclear to me that this check has that much value and OVL_FS()
>     macro is very commonly used inside internal helpers, so please add a
>     "why" to your patch - why do you think that it is desired and/or valuable
>     to fortify OVL_FS() like this?

Sure, I can send a v2 explaining why I think this is needed. Basically I
was debugging a custom overlayfs patch and after a while I realized that
I was accessing the sb->s_fs_info of a real path (not an overlayfs sb),
using OVL_FS() with a proper check would have saved a me a bunch of
time.

Thanks for looking at this!
-Andrea
