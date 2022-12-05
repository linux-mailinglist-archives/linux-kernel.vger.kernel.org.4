Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B03642E44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLERFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiLERFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:05:33 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A94167CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:05:31 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id e205so13723966oif.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UukjrTH+IshIqfcDpBTnIyMeTh3NYMcnhERp1C5DHII=;
        b=nNR8ekjlD1wLymKr9zcw3gIGTUFR3FyouYzo94ItCEPxN5pR8LbiKU7RhyvGGeePTx
         F4l7gXVWuu0+lAPlbWpZA1TyExD7cvxEnOKwQfpyctebGXO6lxA5nDjMoJbL0CWAvrIJ
         0qwxwsGQIJUnspZVN8aHavaxxjqXipm0qrXTjBn2io24ayuBcK+ud2HFz4oSCRT33pTU
         ZmKjZVjIkbkcD8VJqZMX0UALHsAr/lJs12H85PK92rqlvEMaUy5m4RzrGRpp5Us82GbL
         KWS9c9f2sRD1VuW1cr0H4sQNhp2rCUGjMuSQQCQlH9xmPeCY1ODrcAQlAiBpDM8FW1cg
         cwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UukjrTH+IshIqfcDpBTnIyMeTh3NYMcnhERp1C5DHII=;
        b=6nm6zGI7ZkEmNU18kYJ8IJXg3V7H1tj/zIQW3tX/ywIuiJT/lgdhpP2xp4jQZSydIC
         O86D5vx4wtIyER3S4VocRKQbGUveJH00lm6rYWcTGX4p/gk5Ld68bPzarR1l5ki7u386
         5NvOOFHwCorMBC95Q/IN9Xs8OVrPfEw7xzUNg2Z2Tktv/cd77uyOPUxVzlWikxteUxfE
         166/CaC9PLMtb5Oiez8pLYXjy2AnKWPqDcgXV1uOseNXt8/ebsYQ0xL8TXzY4hfOG+p7
         zRdEE69CFLKyrZ6+JZj3ffM1wU265mSYq+EJYLmtHPkxxWRr0JzHJCkYqd3GHGrqf49V
         T2uQ==
X-Gm-Message-State: ANoB5pnh40xNsCwdZBo878dF2Y3PMZIWNuHQmtuWBJwcGgWFl6plUpBK
        wF1bqW9U5o7XfD6jYMPCBXOh7WjlgB5fDDFi42aydg==
X-Google-Smtp-Source: AA0mqf5o0/sxPkRVD/JKCzkxOkjlHFtLt+lVu4g7bVxgKe5WLy3Ao4YJLulcAF0HzrcrfxbIZzeKrSnUrOGHqz0GCtg=
X-Received: by 2002:a05:6808:bd5:b0:35b:d4a2:c4f3 with SMTP id
 o21-20020a0568080bd500b0035bd4a2c4f3mr11649874oik.279.1670259930676; Mon, 05
 Dec 2022 09:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-2-dionnaglaze@google.com> <Y4tAX580jEGHOU9d@zn.tnic>
 <CAAH4kHYz-46syE4wKPzo1N9P34wLHcs85obOCjqb6eQ=iv=n3w@mail.gmail.com> <Y4ulj38eMr1NiRdX@zn.tnic>
In-Reply-To: <Y4ulj38eMr1NiRdX@zn.tnic>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 5 Dec 2022 09:05:19 -0800
Message-ID: <CAAH4kHbZM9YW0BvwxrQNFysHwB8JkPJzFRN9RdwhmixhbtsCyw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
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

On Sat, Dec 3, 2022 at 11:37 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Dec 03, 2022 at 10:58:39AM -0800, Dionna Amalie Glaze wrote:
> > It doesn't always overwrite psp_ret, such as the initial error checking.
> > The value remains uninitialized for -ENODEV, -EBUSY, -EINVAL.
> > Thus *error in __sev_platform_init_locked can be set to uninitialized
> > memory if psp_ret is not first initialized.
>
> Lemme see if I understand it correctly: you wanna signal that all early
> return cases in __sev_do_cmd_locked() are such that no firmware was
> called?
>
> I.e., everything before the first iowrite into the command buffer?
>
> But then the commit message says:
>
> "The PSP can return a "firmware error" code of -1 in circumstances where
> the PSP is not actually called."
>
> which is confusing. How can the PSP return something if it wasn't called?
>
> Or you mean those cases above where it would fail on some of the checks
> before issuing a SEV command? I think you do...
>
> So I see Tom has ACKed this but I have to ask: is the SEV spec not going
> to use -1 ever?
>

I'll confirm with Tom, since he's changing the GHCB spec for the
throttling value.

> Also, if this behavior is going to be user-visible, where are we
> documenting it? Especially if nothing in the kernel is looking at
> that value but only assigning it to a retval which gets looked at by
> userspace. Especially then this should be documented.
>
> Dunno, maybe somewhere in Documentation/x86/amd-memory-encryption.rst or
> maybe Tom would have a better idea.
>

Agreed it should be in both the Linux documentation and the GHCB spec.

> > That error points to the kernel copy of the user's argument struct,
> > which the ioctl always copies back. In the case of those error codes
> > then, without SEV_RET_NO_FW_CALL, user space will get uninitialized
> > kernel memory.
>
> Right, but having a return value which means "firmware wasn't called"
> sounds weird. Why does userspace care?
>

Arguably it shouldn't ever get this value. We're just not very
selective when we copy back the kernel copy of the ioctl argument.
In all cases user space should treat the value as undefined, but still
we don't want to leak uninitialized kernel stack values.

Host driver: only on platform init, should just see the negative error
value and not try to interpret the fw_err in the argument.
Still the data is copied back and therefore should not be
uninitialized kernel memory.
Possible name: SEV_RET_UNDEFINED, or a return value -1 anyway with a
comment that the argument is undefined.

Guest driver: The host is issuing a guest request on behalf of the
guest using patch 4/4 of this series.
The guest is responsible for keeping the sequence number in sync with
the PSP, so we want to track if the ghcb_hv_call completed
successfully to know we should continue with the incremented IV.
Otherwise we run the risk of the sequence numbers getting out of sync
and we lock down the VMPCK.

The guest driver actually sets exitinfo2 to  an undocumented 0xff
initial value just in case.
=If the host doesn't write back a documented EXIT_INFO_2 value like
invalid_len or throttled, then the kernel will emit a log with the
initial value 0xff (or -1 after this patch).

I've changed it to -1 to name the same kind of error across host and
guest: the communication with the PSP didn't complete successfully, so
the "error" value is not from the PSP.
This value can also get returned to user space during a -ENOTTY result.
We can call this NO_FW_CALL or UNDEFINED. I have no real preference.

Whatever value we set initially, the VMM can overwrite exitinfo2
during the ghcb_hv_call.
I'd rather that the "undefined" values were the same across both,
because the guest is merely receiving a value from the host's PSP
driver (or should be).
It keeps the enum for return values a bit tidier and not concerned
with whether the value is viewed from the host or guest.

I can see an argument for not using the PSP header for its enum type
and instead defining and documenting and using the separate the 0xff
value elsewhere, but this seemed as good a place as any.


> I mean, you can just as well return any of the negative values -ENODEV,
> -EBUSY, -EINVAL too, depending on where you exit. Having three different
> retvals could tell you where exactly it failed, even.
>

That's true, those values are already being returned to user space as
the result of the ioctl.

> But the question remains: why does userspace needs to know that the
> failure happened and firmware wasn't called, as long as it is getting
> something negative to signal an error?
>

I hope the above discussion is clear that it's purely a defined
"undefined" because being pickier about what to copy_to_user during
exceptional circumstances in order to not overwrite the user's fw_err
value seems an unnecessary amount of code.

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
-Dionna Glaze, PhD (she/her)
