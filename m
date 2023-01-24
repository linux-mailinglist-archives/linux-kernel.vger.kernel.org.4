Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0267963F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjAXLKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjAXLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5430F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674558560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DMRJfez60dbarODNUh7sHzp4Lsmr8FQDQTVuXe7R6M=;
        b=N2J0j5n/mptfwMd/gxlsBwOjpJjmo4Kx9MO+6brRQjXgl0nGggvpCSaR5nfE7yF2oeM5US
        dhxasxAtPPPiaCsCWx+/+TXilTjAWQHKqw2th4QaiAG+62uZuwYn0J/5s8EZyF33jb6oCI
        fBsQDZdCuZBmWQdYMrAnhtO1wT6oa7s=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-7kQv7BFRPAKEDjSo0rrl6A-1; Tue, 24 Jan 2023 06:09:19 -0500
X-MC-Unique: 7kQv7BFRPAKEDjSo0rrl6A-1
Received: by mail-vk1-f197.google.com with SMTP id x22-20020a1f3116000000b003c67dc01d12so5985539vkx.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DMRJfez60dbarODNUh7sHzp4Lsmr8FQDQTVuXe7R6M=;
        b=q+IxcQnLqE4b64lb73o2E87MsmD5gPzaI5jwGG3ugnn0k018gfIRUQNx3uRVHEARAm
         cp8SeEmfvF2iKKBleKlNhL5GFvI+1u9iofuD+9Mz0Vs6oBUFHSYG/sVNoFSLS53Chp5A
         o1UQdhl/kwAHy7Px8THaj63nfPCw/ngK0oEELd74mUPeA9BQDMXJGn9htEuX6YFEO+Vb
         my9BoMAY25amKu/U1wEn7+HfLeRdIXyXs3o7FAuodf3EONJluhC9GOT9AlqhGH7FcTOb
         VjY3NA4AxS0K51ic3XdJ9p2fUIqO0svPSWqsfCki0AK2q20NSy4rE8X6DfJXaEmbn7+7
         yoBQ==
X-Gm-Message-State: AFqh2krZWX+UPaI8mxdCJ35QDXnjGlkErxClOA1RoC+lo2U+eP/jNBj3
        X23C7t9aaSj6TuyOEZQbCKrICpQMx3YWANYYBRhTwL8hV2FMPTddCTMVZqDzXNIqp9dG1WlFpy6
        HAIjKm4QRSK5NW2BGZfzugp09dh0JB/6YQ/mHYuGz
X-Received: by 2002:a1f:e701:0:b0:3dd:f5ea:63a2 with SMTP id e1-20020a1fe701000000b003ddf5ea63a2mr3697203vkh.10.1674558558412;
        Tue, 24 Jan 2023 03:09:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvB4Kl48vzijkNT1iQDWORsxLD/4IdktHUPkydJbw9Rz+NmsbYKXiKwXzsVm5K8G1Rv8dZasY5bY7KqTqSMx1Q=
X-Received: by 2002:a1f:e701:0:b0:3dd:f5ea:63a2 with SMTP id
 e1-20020a1fe701000000b003ddf5ea63a2mr3697196vkh.10.1674558558172; Tue, 24 Jan
 2023 03:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20230124125515.7c88c9fb@canb.auug.org.au> <86a628mi9q.wl-maz@kernel.org>
In-Reply-To: <86a628mi9q.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 24 Jan 2023 12:09:07 +0100
Message-ID: <CABgObfZxjbG+ZofDPfOdiY_QP4j09XtTNwQVmGnbwoc+oaocxA@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the kvm-x86 tree
To:     Marc Zyngier <maz@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sean Christopherson <seanjc@google.com>,
        KVM <kvm@vger.kernel.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 9:47 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Stephen,
>
> On Tue, 24 Jan 2023 01:55:15 +0000,
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > The following commits are also in other tree(s?) as different
> > commits (but the same patches):
> >
> >   0b6639e8ed87 ("KVM: s390: Move hardware setup/unsetup to init/exit")
> >   0c2be59e0b53 ("KVM: x86: Use KBUILD_MODNAME to specify vendor module name")
> >   1334f214d19f ("KVM: s390: Unwind kvm_arch_init() piece-by-piece() if a step fails")
>
> [...]
>
> > I guess someone has rebased one of the kvm trees and it had already been
> > merged into another (like the kvm or kvm-arm trees).
>
> Huh, that's worrying. I'm carrying the kvm-hw-enable-refactor branch
> from the KVM tree, which I understood to be a stable branch[1], and
> which I merged to avoid conflicts to be propagated everywhere.

It wasn't 100% guaranteed to be stable because it was meant to be
tested and have fixes squashed in. But since I had no issues reported
from either maintainers or bots, I will indeed merge commit
9f1a4c004869 aka kvm/kvm-hw-enable-refactor into kvm/next. Sean,
please rebase to drop the duplicate commits.

Paolo

>
> Paolo, Sean: what is the *real* status of this branch?
>
>         M.
>
> [1] https://lore.kernel.org/r/4d73d1b9-2c28-ab6a-2963-579bcc7a9e67@redhat.com
>
> --
> Without deviation from the norm, progress is not possible.
>

