Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02958742F42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjF2VFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF2VFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:05:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105601BF3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:05:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so3295a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688072727; x=1690664727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtqC5U06rpgElL+2bahbcyOiaEJkZ6SnNFt7jo/MOuI=;
        b=rOm8Rha28FTOFOHSJ4pnBUfd88CBGxDDkHvCX9orLeRV9Nhd/sglXEJd9xFznwQwHd
         5VlVBjdmO2LahD1b6cH3urkETtnXQfY/PbKiucJ5ryGf2a6JyzHzZEvRRXX4lmUUj7Yt
         3Ua2g9qSC0sJjbtn1YD0JRohiBcpvGdV38pmMwau+r/H8ubR7PjdpvEeCKtsU6Yjwqck
         XqKuFnhUZod82aios1qhFvFAHUziSU8mO29aziPIaf34KZcJJwoSdwZr/EOzJ6YOYyI7
         j1sqKAOtQND52d+TYHNgKyFWag50AjMTuFYSYOL3uOXYYoV7VSCOU/H2qn6tiR53l3n6
         9tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688072727; x=1690664727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtqC5U06rpgElL+2bahbcyOiaEJkZ6SnNFt7jo/MOuI=;
        b=kIdiDxspmvSrbgRBgE86oqjb1qES9Epwm7gTlT2EefsrmHHQhfm78Y4AJg52mlf/Iq
         k/cXeVRGs2+dEE80esyr71dD+80/Dg9/iTqMQY4isJ36WJc/VfyEIKEewmgeK0cQSZdt
         MlrexBRj6/Cwu4qUxYk9pGPg0Jurh5Y9Wxbnvo8Ch6Ufe0BkFPj4g/AFuUXGb7RMBEDK
         YhEyW2DhVFlIhyRNepkZi5tVy65UdbYcjkFKzigNWONrHNA4nRIXwMMmP9cBLm5lwBUF
         46wU9kUoWvOkhuC4KXjc7/SFDa7WozZhDoRtkkISRhPS42lnjuvGm5oazZb/WQ8KNYFt
         +lLg==
X-Gm-Message-State: AC+VfDx6zx3DpH6i7PR21ojaz0zKozK/uwcLcpWSIdtDIwEY12a4FrWK
        qD3USJzGkHB2QVnyClcOUqeOkCnjgh29xB7ZY46eCQ==
X-Google-Smtp-Source: ACHHUZ7GbEWD4nWGsAzJazQOkKf5PEoLuhvKRiEGkpHOQkEqtf1+QVWBi7bo8ZkwYTh5iQe+Oky1ZmARdNPs7TuWi+w=
X-Received: by 2002:a50:9f85:0:b0:51a:1d77:e69d with SMTP id
 c5-20020a509f85000000b0051a1d77e69dmr166118edf.3.1688072727376; Thu, 29 Jun
 2023 14:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221215001205.51969-1-jeffxu@google.com> <20221215001205.51969-4-jeffxu@google.com>
 <ZJwcsU0vI-nzgOB_@codewreck.org> <ZJyKeeqRJxzwlMhk@codewreck.org>
 <CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com> <ZJ1dGvWkJVAbBPn7@codewreck.org>
In-Reply-To: <ZJ1dGvWkJVAbBPn7@codewreck.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 29 Jun 2023 14:04:50 -0700
Message-ID: <CALmYWFv=bmO3_SfojE0W0Lt4ZS6M-t3=sswncq+gwD7w8HLNhQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Xu <jeffxu@chromium.org>, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
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

Hello

On Thu, Jun 29, 2023 at 3:30=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jeff Xu wrote on Wed, Jun 28, 2023 at 09:33:27PM -0700:
> > > > BTW I find the current behaviour rather hard to use: setting this t=
o 2
> > > > should still set NOEXEC by default in my opinion, just refuse anyth=
ing
> > > > that explicitly requested EXEC.
> > >
> > > And I just noticed it's not possible to lower the value despite havin=
g
> > > CAP_SYS_ADMIN: what the heck?! I have never seen such a sysctl and it
> > > just forced me to reboot because I willy-nilly tested in the init pid
> > > namespace, and quite a few applications that don't require exec broke
> > > exactly as I described below.
> > >
> > > If the user has CAP_SYS_ADMIN there are more container escape methods
> > > than I can count, this is basically free pass to root on main namespa=
ce
> > > anyway, you're not protecting anything. Please let people set the sys=
ctl
> > > to what they want.
> >
> > Yama has a similar setting,  for example, 3 (YAMA_SCOPE_NO_ATTACH)
> > will not allow downgrading at runtime.
> >
> > Since this is a security feature, not allowing downgrading at run time
> > is part of the security consideration. I hope you understand.
>
> I didn't remember yama had this stuck bit; that still strikes me as
> unusual, and if you require a custom LSM rule for memfd anyway I don't
> see why it couldn't enforce that the sysctl is unchanged, but sure.
>
> Please, though:
>  - I have a hard time thinking of 1 as a security flag in general (even
> if I do agree a sloppy LSM rule could require it); I would only lock 2
>  - please make it clear, I don't see any entry in the sysctl
> documentation[1] about memfd_noexec, there should be one and you can
> copy the wording from yama's doc[2]: "Once set, this sysctl value cannot
> be changed"
> [1] Documentation/admin-guide/sysctl/vm.rst
> [2] Documentation/admin-guide/LSM/Yama.rst
>
Thanks for the suggestion.
Yes, it would be good to have some documentation.
I will send patch to update Documentation/admin-guide/sysctl/vm.rst

>
> Either way as it stands I still don't think one can expect most
> userspace applications to be converted until some libc wrapper takes
> care of the retry logic and a couple of years, so I'll go look for
> another way of filtering this (and eventually setting this to 1) as you
> suggested.
> I'll leave the follow-up up to you and won't bother you more.
>
Not bothered at all! and thanks for reporting the bug to improve the
quality of memfd_noexec !

Much appreciated.
-Jeff


> Thanks,
> --
> Dominique Martinet | Asmadeus
