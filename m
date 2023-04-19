Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B176E70C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjDSBhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDSBg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:36:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25602100
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:36:58 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fe3cd445aso176407757b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681868217; x=1684460217;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnOVojuWZvjCGvKm6g2ZvT3BFVBOe3FpgKuoK70Vuw8=;
        b=5s+OJ9T9UsUhZ7DfeIrljal3DDwwl9lStbUBW/eV2Oo3pQ6TguokiFUdiPo9WmlSzv
         U619T1L2qQXjvKytIr5XDq7TWW+taW8XItZISk3jEe6pIAUddKt7h0zfYLVdj1UfaTHV
         GQGCMnAoVazHwzX85do2aJI/7gJaJMCcaR23sQZZHlwNGbElriM2ExyUp4+tTieSDmsy
         mxpl1pUa043IcVai65aZ1+oJRNSvNDXzZOQJ5+n5Lisai4CfAB5bR8ubvWJK9P5tjL89
         4PZGEtQvuvP6ORl7WFDdaWnwrTgyIEQaf28rjUt9xzB1YJejS+8bRfDt3TRsMEDRZ+Tq
         8Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681868217; x=1684460217;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnOVojuWZvjCGvKm6g2ZvT3BFVBOe3FpgKuoK70Vuw8=;
        b=CpSqU7Je2MP0SuMbh+1/pGPVz8c/H477Tib+tNI6CG1dKcVDgKcef4yiv9SXskf7fO
         hAKut48DtrwExOKEJsYUAx35WIJ5OyI1P2YOc78FRCHA4pPxua7wlCrWMtiVkDeheAhY
         f8pXwFtur4epZIdieq85XQla6e1SjdkEyTVJCXw9ET9ijI/M7qu45pBS3kVMkQbJoKry
         V259VQKympFzNX//DrcQpCcuasRYMIWMyaCFmajWqUb+8OgWNGLu6FJDfBG7IwCoY9sC
         0qR1YMe0VZFPthaMsoKAt19muR16mmEGkE7MnEgREMggw0dGw/P9biqGYzCT+QJaEmoW
         Jrxg==
X-Gm-Message-State: AAQBX9dSzk5kWoMlAXxpHGJi3vV8ruOxXdohYEgQBYWz+dalM0id8oNv
        EuNRdy5ZsxQIFdy8Kkspz/AawA==
X-Google-Smtp-Source: AKy350Y1HpjyFvNoanRn8jl5X5F27JdYIEha60PvD72lMQbkfwEtMRv9nSrEYo/6ZDyok87hqZtS2A==
X-Received: by 2002:a81:918c:0:b0:552:ae45:6e0f with SMTP id i134-20020a81918c000000b00552ae456e0fmr1837025ywg.26.1681868217241;
        Tue, 18 Apr 2023 18:36:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l72-20020a81704b000000b0054f88e5858esm4195396ywc.78.2023.04.18.18.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 18:36:56 -0700 (PDT)
Date:   Tue, 18 Apr 2023 18:36:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Waiman Long <longman@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
In-Reply-To: <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
Message-ID: <cffc7454-614-1939-f235-7b139dc46b41@google.com>
References: <20230418210230.3495922-1-longman@redhat.com> <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org> <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-397833526-1681868216=:9821"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-397833526-1681868216=:9821
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 18 Apr 2023, Waiman Long wrote:
> On 4/18/23 17:18, Andrew Morton wrote:
> > On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> wro=
te:
> >
> >> One of the flags of mmap(2) is MAP_STACK to request a memory segment
> >> suitable for a process or thread stack. The kernel currently ignores
> >> this flags. Glibc uses MAP_STACK when mmapping a thread stack. However=
,
> >> selinux has an execstack check in selinux_file_mprotect() which disall=
ows
> >> a stack VMA to be made executable.
> >>
> >> Since MAP_STACK is a noop, it is possible for a stack VMA to be merged
> >> with an adjacent anonymous VMA. With that merging, using mprotect(2)
> >> to change a part of the merged anonymous VMA to make it executable may
> >> fail. This can lead to sporadic failure of applications that need to
> >> make those changes.
> > "Sporadic failure of applications" sounds quite serious.  Can you
> > provide more details?
>=20
> The problem boils down to the fact that it is possible for user code to m=
map a
> region of memory and then for the kernel to merge the VMA for that memory=
 with
> the VMA for one of the application's thread stacks. This is causing rando=
m
> SEGVs with one of our large customer application.
>=20
> At a high level, this is what's happening:
>=20
> =C2=A01) App runs creating lots of threads.
> =C2=A02) It mmap's 256K pages of anonymous memory.
> =C2=A03) It writes executable code to that memory.
> =C2=A04) It calls mprotect() with PROT_EXEC on that memory so
> =C2=A0=C2=A0=C2=A0 it can subsequently execute the code.
>=20
> The above mprotect() will fail if the mmap'd region's VMA gets merged wit=
h the
> VMA for one of the thread stacks.=C2=A0 That's because the default RHEL S=
ELinux
> policy is to not allow executable stacks.

Then wouldn't the bug be at the SELinux end?  VMAs may have been merged
already, but the mprotect() with PROT_EXEC of the good non-stack range
will then split that area off from the stack again - maybe the SELinux
check does not understand that must happen?

Hugh
---1463760895-397833526-1681868216=:9821--
