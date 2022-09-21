Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486065BFC20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIUKR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiIUKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465495AFE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663755437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXJHoz876JXyWdIzmz4FeK1YaPw2FwSEN3I5pptho3c=;
        b=EKjXB1gu2N1EJQsc0nJYGs488iwnT7UeLBYH/R47A7YK5zUPD3MM6CD0YgaWGj0J5Fk2/A
        M0D7DTtn5pPJ2R3i6b8tKfpmW0E0EyVUtcW/Kpecl9qBLeveryQFPLlsZ4VV7UJN1GmBFE
        G7gdwq7wm6XSHEkUZpX3v9A0HaDTccE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-UpUffXoLOHOugyt1w4IE2w-1; Wed, 21 Sep 2022 06:17:16 -0400
X-MC-Unique: UpUffXoLOHOugyt1w4IE2w-1
Received: by mail-io1-f70.google.com with SMTP id x22-20020a6bda16000000b006a123cb02beso2831954iob.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tXJHoz876JXyWdIzmz4FeK1YaPw2FwSEN3I5pptho3c=;
        b=CaU6Yyp5T9jjchd6hxzulpGqf5hz0pPcLzdNEE53yafoZTK0xPNkN3fn0Ys3t+QXvo
         9hO30AI6NeykvWTDcvpK7/Ej2HM/b+1KUIHYn1k7M4FDzpNQ4zG1y286sNy4EBxH3E8w
         +u+Ol5hFHQMmzKep10SXH2NOINKx/D5NVtDx4HbFdLGmcSFULOfcB40CPQWTbJX2TMHV
         ABkOuizqSOt1MIBMk8MhIYQh0pnQqhZF73EvrhVthXulE+eAwBlyYTH+Cbxr0ihy5B5j
         B+wfpFIqVk/zNQ7Hs4pZkkS8d5srxAo8FnkGvJOO4XUAm48y0ErpUl1Blsme5Oyc7YeK
         4mTw==
X-Gm-Message-State: ACrzQf2GMLanLASJpelRRwLVzBkicNcEqAujXRpf8lGuPxiJ50wNWBb+
        NnWsNCqXSoSW6+lz/G8HIiVg6LehOeuXqxZht+3ZSaindbvMh/ArfQ3ouAcufRwKxvuBnh8Uq6F
        ouOLHNxzJNGx5xN99a/PZaOEcz0t48n9NbhhD4eBy
X-Received: by 2002:a05:6638:25d3:b0:35a:41e1:bb6a with SMTP id u19-20020a05663825d300b0035a41e1bb6amr13596405jat.36.1663755435558;
        Wed, 21 Sep 2022 03:17:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM688ewOCyJLZ/txeb59b05RRH+aUBqA1+qGDipJrnApOiSoUL2NrJFNlfnTCiqiiwvpKfPTErDMDcjRgo3gi9I=
X-Received: by 2002:a05:6638:25d3:b0:35a:41e1:bb6a with SMTP id
 u19-20020a05663825d300b0035a41e1bb6amr13596395jat.36.1663755435297; Wed, 21
 Sep 2022 03:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
In-Reply-To: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 21 Sep 2022 12:17:04 +0200
Message-ID: <CAO-hwJJY+sRiHX9KWqTAuR7Q8=3J8vu=FneusRago87uQYSxfw@mail.gmail.com>
Subject: Re: linux-firmware signed commits; does anyone care?
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Peter Robinson <pbrobinson@fedoraproject.org>,
        Takashi Iwai <tiwai@suse.com>, contact@laurentcarlier.com,
        mpagano@gentoo.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jared Dominguez <jaredz@redhat.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 3:33 PM Josh Boyer <jwboyer@kernel.org> wrote:
>
> Some time ago, we went back to doing ~monthly releases for
> linux-firmware primarily to help distributions package firmware in a
> simpler manner.  We GPG sign the tarballs, as is good practice, but as
> part of reintroducing the tarballs we also started having a
> linux-firmware maintainer GPG sign *every* commit done by a
> maintainer.  The intention there was that because we're dealing with
> binary blobs we really have no recourse to see changes unlike a source
> code repo.  The signed commits at least provides a measure for
> interested people to ensure the repo itself is only being committed to
> by a recognized maintainer and it isn't compromised (in theory).  The
> downside is that pull requests are merged non-ff and we wind up
> signing the merge commit.
>
> The question at hand though, is does anyone care about the GPG signed
> commits?  It's not clear to me this practice is even noticed nor if it
> is bringing any value to this project.  Since we've started this
> practice, I am literally the only one committing to the repo and while
> it isn't hard to do I want to know if it's actually useful to anyone.
>
> I ask for two separate reasons.  The first is that a group of
> interested firmware submitters is looking at modernizing the workflow
> for the linux-firmware project and moving to a merge request workflow
> instead of submitting giant binary blob patches via email.  This would
> allow us to put some CI in place for simple checks to the WHENCE file,
> etc.  Doing this while still having GPG signed commits isn't
> impossible but it certainly complicates things a bit, and would likely
> require a trusted bot to sign commits.  That has implications on
> secret storage and changes the dynamic on trust levels that make the
> whole thing even more questionable.

People already are saying that they do not see value in GPG signed
commits, but I'd like to add a few bits here.

As Josh said, the idea is that we modernize the workflow for
linux-firmware by automating what can be automated.
The first thing that seems to be possible is automatically merge
submitted MR assuming:
- the general CI tests are passing (Mario already has a few sanity ones)
- the commits do not touch WHENCE (so we have a reference on who is
responsible for what)
- the commits are signed by the maintainer of that said blobs (which
would be matched against the WHENCE file)

The idea is that if a maintainers of a blob submits a commit and signs
it, there is no real reason to not merge it ASAP, given that we can
always say: "well, it's the fault of X who is responsible of this file
and who signed it, so we know it's actually X".

Then comes the question of maintainers signing commits. If we ask
submitters to sign their commits to have a fast track, it makes IMO
sense to also ask the maintainers to sign their commits to show the
way it is supposed to be done. I wouldn't care much about the
automated bot that would merge the commit. If we need to have it sign
the merge commit, we can do it, and this will only give the
information that the process was followed.

>
> The second reason is that even if people are validating the GPG signed
> commits, it's not exactly user friendly.  I've been looking at
> sigstore and recor and that might be a better solution in the long run
> if we do want to utilize something like the current scheme.

TBH, do we ever need to validate signed commits besides in the CI case
or if something wrong happens?

To make a parallel, Linus requires people to sign their PR, but he
doesn't need to sign his commits. Because whatever goes into his tree
is from him, obviously him. However, he requires maintainers to send
signed PR to ensure this is coming from a trusted source. So he is the
only one caring for signed PR, and we just trust him.

So in our case, if signing for maintainers is not too much of a pain I
would say:
- to automate inclusion of blobs, we should ask vendors to sign their commits
- to show the way, maintainers should still sign their commits (even
if no one cares)
- the CI should verify who signed what and if the signature is valid
- end users only care about the signed tarball, that they trust the
maintainers will build from a tree that is trusted

OTOH, dropping the signing of the merge commit from the maintainers
would allow them to just hit the merge button in the UI, which might
be a simpler thing than having to forward that MR to a bot.

>
> I'll still GPG sign the tarballs, but I'd like to propose dropping our
> current self-imposed requirement that all commits are GPG signed.
> Thoughts?
>

I hope I didn't add too much confusion :)

Cheers,
Benjamin

