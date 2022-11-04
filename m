Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66384619DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiKDQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKDQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:52:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E0D4387A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:51:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t4so3354163wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6M+OWPG9pQ7QDBVx4HXZB7dQsnWZ/+0hVJPytBaqX8=;
        b=NiO//xj3RwfjICe4KvK2YRFF1MRJKgA4pa+8uNvpnG0iT5gxeQMTFKGBD1zff1pFuE
         UhK1zS359zpQ3clDX79OexHOGlOSPw6yE87NGOEVQoN7wo7zYhxvTNAw7dMMcXeDSz+k
         1zWUdUK+NG9GCqiOgxXxUPXIOMjrM5cDAtHQd8bAL8oPX/MW6ab7LUJI04lgjcazfMAX
         g69CT1eESCEFv5BPYC57PVJzEwBs3rYkI2/035ZRznXDbAfuGIiyoBkb9lW9LLXb7vn5
         vsVe1/twpPN21M2tVgxE35o+So+JDFQVQhVRrk1ysMBfvBeCdkeby7Nsb9ouCQlpa29M
         L/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6M+OWPG9pQ7QDBVx4HXZB7dQsnWZ/+0hVJPytBaqX8=;
        b=kAxfE832y+bU5fMz0diabI1sgBX+c/chbh+1isCWxewxH3jL72x2VDwcm2qktWrq2E
         56Q+UMkMio+i6NBHEWmpkb296yJg+GOmg6rfxGRvrLW0sMU6Ud74aEQAeCz9Y2HoED4X
         jhykqZ+eS+GZBj+AiAuyCsQbse9EaZF2smigesD8q/n+C2FpkAEnM/MKbc22L6rwkbR4
         Bd4/Yzklvg7o773liwCNw8/xnDUZxx/Yc/DCuLVCn0DYpAbM/A8NDvkqJHHLGXKTStA4
         gMKChfjakmw83tk6ix9pv0beaz+HWJ046pgMfXFcVZ67CgDPSB6yMZCR9BHJvhyEpl8q
         Sldw==
X-Gm-Message-State: ACrzQf3VtqhdCoHDKZzBXTDJ/eP2iElADUTk4Il2JZY6Xs0zCI9PJ3cA
        fotuQ/ayE8NUYFRFpxquUASf1iZAQpqmCOrqJ6aqiAv9QG0=
X-Google-Smtp-Source: AMsMyM4pyLhjryvRl/uo3LPJYIMQS6c0378nctUklF10kUuQOkFjpLvgxKywM0iO72jr1OO+I3NviuE8jFqixNKM4Tw=
X-Received: by 2002:a05:600c:3208:b0:3cf:92a6:30b4 with SMTP id
 r8-20020a05600c320800b003cf92a630b4mr5073317wmp.148.1667580685479; Fri, 04
 Nov 2022 09:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210913233325.23263-1-pcc@google.com> <CAMn1gO6WUATuQhVQRUgDYbytk0ohVytD_-fvOoP16xVZGJfhgg@mail.gmail.com>
In-Reply-To: <CAMn1gO6WUATuQhVQRUgDYbytk0ohVytD_-fvOoP16xVZGJfhgg@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 4 Nov 2022 09:51:14 -0700
Message-ID: <CAMn1gO7pF3td6Gmxu=JYq-ZuwWc8C0PuiYX0p3YGq6V7Qu2wzg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: use correct gitroot when running from
 non-top-level dir
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:32 PM Peter Collingbourne <pcc@google.com> wrote:
>
> On Mon, Sep 13, 2021 at 4:33 PM Peter Collingbourne <pcc@google.com> wrote:
> >
> > My workflow usually requires running checkpatch.pl from a subdirectory
> > of the kernel source tree. This works for the most part, but the script
> > will be unable to find the .git directory and will therefore refuse to
> > run any git commands (so, e.g. commit ID verification will fail). Fix
> > it by prepending $root to $gitroot when a root is set.
> >
> > This also requires fixing one root directory assumption in a git
> > invocation.
>
> Ping.

Ping^2.

Peter
