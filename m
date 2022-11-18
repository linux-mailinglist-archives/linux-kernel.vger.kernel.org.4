Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3962FDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiKRTSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiKRTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:18:52 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B586155
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:18:48 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b131so6726345yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46Lq8zuv/x+zWGVVLn8B9wakNtwzIPndWxRzWrLURwI=;
        b=MGOXMi+29GCwoeEFPsCLzpqC6GQd1fnoo6yb4wXlQh/IPqXLDzUy42z8COoPDR7RNl
         n1wa3LjO0IdKfcUjxJ1Yj5HXaWdIIjI5zLXfW+7kS1tJvj6oEejbNd6fQEnNv857kjPr
         P1Qh2dfNfoegYVnhRUAClhh6v8XimaujhUs/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46Lq8zuv/x+zWGVVLn8B9wakNtwzIPndWxRzWrLURwI=;
        b=FmrQVwpB+oTuZ0GsVdZXDOmZDgnaN6znknsvHDiQBrdRR9gqQQGPJg8vF7Q34ELeUa
         P3ECi/VaTiRtdKM76Jd2+NJtvmyHHDaEMJumD/cx8C/u5pQWBVPj4T1GILa8RZ4JO/aM
         lYjDnWTE+4N08uUm9lWdHJK9ABZQghDFwpn+pIiLmAjfQYCq+dENTwRHPMQ3MX0znMMW
         tJ6KqVvMzq1h7YL0HTveAPTbAsuLKw4p20Fp2OvDAtPwOsnEqpyR1/ATcNLdrqRWFZ3H
         CNlAsdAA9L780PvM9fPnK3njKT3YOuDQF2AbjS9xKkoYbtEHkeBrIMZBGgFdpsHJulNq
         rZ0A==
X-Gm-Message-State: ANoB5pmhahokkNRKJIoaYdZ/+FOUiOVmyUx4ymuE49PMouzvZ6nx62xG
        YZ91hlm6NBN2SgPsLNFcimxCJ/u2wfN9v+62gKk6Bw==
X-Google-Smtp-Source: AA0mqf44IaTG9JRuJ4BfeMH36lPl0NsucVN67sIumTK1NMJiMlkLhTK59DrmL7nZfAiIze+ZiOs31YW0mSz90zBAM5k=
X-Received: by 2002:a25:3c07:0:b0:6c3:f821:4d0b with SMTP id
 j7-20020a253c07000000b006c3f8214d0bmr7823680yba.201.1668799127612; Fri, 18
 Nov 2022 11:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20221024173140.30673-1-ivan@cloudflare.com> <Y3fYu2VCBgREBBau@bfoster>
In-Reply-To: <Y3fYu2VCBgREBBau@bfoster>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 18 Nov 2022 11:18:36 -0800
Message-ID: <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for /proc/pid/fd
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> > +                     const struct path *path, struct kstat *stat,
> > +                     u32 request_mask, unsigned int query_flags)
> > +{
> > +     struct inode *inode = d_inode(path->dentry);
> > +     int rv = 0;
> > +
> > +     generic_fillattr(&init_user_ns, inode, stat);
> > +
>
> Sorry I missed this on v3, but shouldn't this pass through the
> mnt_userns parameter?

The mnt_userns parameter was added in 549c729 (fs: make helpers idmap
mount aware), and it's not passed anywhere in fs/proc.

Looking at other uses of generic_fillattr, all of them use "init_user_ns":

$ rg generic_fillattr fs/proc
fs/proc/proc_net.c
301: generic_fillattr(&init_user_ns, inode, stat);

fs/proc/base.c
1970: generic_fillattr(&init_user_ns, inode, stat);
3856: generic_fillattr(&init_user_ns, inode, stat);

fs/proc/root.c
315: generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);

fs/proc/generic.c
150: generic_fillattr(&init_user_ns, inode, stat);

fs/proc/proc_sysctl.c
841: generic_fillattr(&init_user_ns, inode, stat);
