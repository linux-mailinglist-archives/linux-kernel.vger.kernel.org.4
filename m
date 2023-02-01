Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE673686AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjBAPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjBAPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:55:09 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA97751C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:54:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id dr8so31139543ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXWqBgMOKv5SnbTsUMFlWPl1mxwCaGFXLbhg+69mJBo=;
        b=Sqps5nHkF4vfpjGc70sbUfCvx2Zc88TDnLNGyx0VmKmTxcv6JhSgWBbqee2E0+Q0KH
         yEM4HUxIchphwRzb5/SMvgThKH7jdGa7pafz04o1GUcvwGaMyejbgk4PWSeN+stZoGUm
         XTcTPqYBDzKAwpYXi5GPegLxK/7GH8Bf2kmv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXWqBgMOKv5SnbTsUMFlWPl1mxwCaGFXLbhg+69mJBo=;
        b=oo+Qe1+6I3Nu9nA4hhxy+VdsqJGwTGm6r+bbELCMg/UkdkYz3FMbVB3C6723+aiB+z
         BtVETH2mkh922UxlB9MrmeIeF4xPm5IOKUgf7KW2ygiQ0BEClmjQipVIsWRylPbbjuBE
         k5QAxhFHX3TseyLTgtprE8GEf46Tk7q3h4Nw+uIaUUiIdzssErEekS2TUqI/AVg+vMgz
         OqInKVLl1CgFyvS6SN1LJRo4bZvi+t/1YqXq0l+usjLenSrsJ0XjDfQxQzguGWRiR8ok
         5Vxiy5wTb9gedovYmOC2dXyS70vp6siuJLPt7d9v+AHI2w8mrQrjC28Dvj4ln+Q3mrOT
         bv6w==
X-Gm-Message-State: AO0yUKXse01D/RM/UKZDOJjrqRoMa5NJeiY7qbIsgdJ+tQe0itMB+g3I
        pjN4Vpk+3QhjBOHnFGxAm376tQrEagZfPiS86LR7J2I5Hq4pKA==
X-Google-Smtp-Source: AK7set8r8OoF7qrGxnNKdUpD+LKehxKmaT8vY+FzeL9YI2CliNZodxhhagWUKTRdSPk3WuV2thOqVJYqKrXrhfb22XI=
X-Received: by 2002:a17:906:709:b0:88d:5c5d:6a6f with SMTP id
 y9-20020a170906070900b0088d5c5d6a6fmr855247ejb.236.1675266872159; Wed, 01 Feb
 2023 07:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20221111093702.80975-1-zhangjiachen.jaycee@bytedance.com> <CAFQAk7isS3AgkU_nMum8=iqy8NgLdGN5USq4gk_TE8SUzRr4tQ@mail.gmail.com>
In-Reply-To: <CAFQAk7isS3AgkU_nMum8=iqy8NgLdGN5USq4gk_TE8SUzRr4tQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Feb 2023 16:54:21 +0100
Message-ID: <CAJfpegtqGDt4fnDsLtLEhg3ysw5TtfPamJ18TGSpSJve94KNzQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: initialize attr_version of new fuse inodes by fc->attr_version
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 at 09:52, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> On Fri, Nov 11, 2022 at 5:37 PM Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
> >
> > The FUSE_READDIRPLUS request reply handler fuse_direntplus_link() might
> > call fuse_iget() to initialize a new fuse_inode and change its attributes.
> > But as the new fi->attr_version is always initialized with 0, even if the
> > attr_version of the FUSE_READDIRPLUS request has become staled, staled attr
> > may still be set to the new fuse_inode. This may cause file size
> > inconsistency even when a filesystem backend is mounted with a single FUSE
> > mountpoint.
> >
> > This commit fixes the issue by initializing new fuse_inode attr_versions by
> > the global fc->attr_version. This may introduce more FUSE_GETATTR but can
> > avoid weird attributes rollback being seen by users.
> >
> > Fixes: 19332138887c ("fuse: initialize attr_version of new fuse inodes by fc->attr_version")
>
> Ping..., and the Fixes tag should be:
>
> Fixes: fbee36b92abc ("fuse: fix uninitialized field in fuse_inode")

Do you have a reproducer?

Thanks,
Miklos
