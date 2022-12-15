Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D964E23E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLOUQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:16:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FA32B86
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:16:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b12so373903pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E4naCWagDDNWcJfZ4giahWBUN8Tiu/D+CnkJXaoCn4I=;
        b=LjjqHVVBowUybQjG82rnjJe+F8hs1qicEYul58tnTyt23xDcn2E0r4inwVLRfydSHc
         C9a35wJ651tp7QQB6uOkFi1wXA3qIIVZsmH4XubLF9bUEItPe3bhh260zxE239dBYUsJ
         VHKmhzKdkZT134gwNk1FjGgMrA9+Ol2xZI9q/yijm65h4F8Tzhjn3bMpb9shazrkhK6+
         RiBLxadlYztFtdvqO918dlZwLjdUjkP8I5E6QfcmX1fFyJydKoh9WKRCVuRlnVpUXyeP
         SWfIb/hAmtfXHvdZQSJWQid0+pfH9b7T8KGxZP4h++RtfdqcnufOc9PpXDGUs2fuSPjy
         xFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4naCWagDDNWcJfZ4giahWBUN8Tiu/D+CnkJXaoCn4I=;
        b=uj1Ef311puePAnwrYsdM1QBa3tw5OjR12objnLYnPPgUTV2s8mZ7E8I1JDwhWTy4bQ
         jG4PljhA48KWFaKBf2PXQIAUsZz5Bd0OgVOjZtuVfH6szespZe1O1uPBPRr7fOQShHsy
         2OTkt5ZGrofG3cWbecud2bQo3aVBTgV7xEQsVf3wBnZO1+xvWqCwDeSm1UubK8ABKv2G
         LwL05TNzzS8ClYQAGk7RmVThC8jtWdayXMuMBXKTC4cRmdXx+gU8NQ28ipBdRhdT1NFm
         npUX8zJKk3f6cZkHvmz7lYqH1OlXpXn6XQToYUExbd82Nz3eQ2psnMkotM+sZFMDCRqI
         COkQ==
X-Gm-Message-State: ANoB5pmPW9WY37L11K2TNUIDjo+LpUSIoZQkTS3Jx1RON449IK6IwZwx
        3pFRNp2SiwPdEe1+l+mlblRHAyVaB7ULoAECNXkqvBw+RrAt
X-Google-Smtp-Source: AA0mqf5S7JAbYH8Ih4fAgPVXpRLUfWfQlEXzX7kbt3sla7bqd90TNHKutCodLt3485BYMP/dTMYGw8FGwkcr9dLI+2A=
X-Received: by 2002:a63:64c5:0:b0:479:2109:506 with SMTP id
 y188-20020a6364c5000000b0047921090506mr1313297pgb.92.1671135374221; Thu, 15
 Dec 2022 12:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20221209195453.never.494-kees@kernel.org> <20221212211319.GA15511@mail.hallyn.com>
 <202212132006.F29BB81A@keescook>
In-Reply-To: <202212132006.F29BB81A@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 15 Dec 2022 15:16:03 -0500
Message-ID: <CAHC9VhQ7DWQWqiMqHXQO==axnHr3qaxzD22wbK4R78saJt=P2w@mail.gmail.com>
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:06 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Dec 12, 2022 at 03:13:19PM -0600, Serge E. Hallyn wrote:
> > On Fri, Dec 09, 2022 at 11:54:57AM -0800, Kees Cook wrote:
> > > LoadPin only enforces the read-only origin of kernel file reads. Whether
> > > or not it was a partial read isn't important. Remove the overly
> > > conservative checks so that things like partial firmware reads will
> > > succeed (i.e. reading a firmware header).
> > >
> > > Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > Seems reasonable.
>
> Thanks!
>
> > So the patch which introduced this was
> > 2039bda1f: LSM: Add "contents" flag to kernel_read_file hook
> > It sounds like the usage of @contents which it added to ima still
> > makes sense.  But what about the selinux_kernel_read_file() one?
>
> I think those continue to make sense since those LSM may be sensitive to
> the _content_ (rather than the _origin_) of the file.

Agreed.  When @contents is false SELinux does a permission check
between the calling process and itself, but when @contents is true it
performs a check between the calling process and the file being read.

-- 
paul-moore.com
