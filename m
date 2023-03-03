Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69BB6A9E46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjCCSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCCSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:16:59 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FC10ABF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:16:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i34so13773328eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677867415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqRrVLgMIMIB9xLPs1e1XFCSR/JA8mZb93K6qXJ/mvQ=;
        b=LJLfbF2Fhdt1y/uL0FDupsfJTOH2GWKuRK+3R0vP84Z33EShdaS6Y73PxeufvlYxxD
         1isiI5ff40hoL7HNv1/uxe7YBb8737fxuPQvjmlNFcEUhuW/4UcE0Ubu7DTks7dBm0tw
         QneYVjdVGgOmD1W6sU9TFhAg1EqvsXQSxctNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqRrVLgMIMIB9xLPs1e1XFCSR/JA8mZb93K6qXJ/mvQ=;
        b=GdQZf680SAZ28AB+98IeNhhsytQCyuwIMq58vqGp0P6KK05WS5hvB7WnBLwsElj8cK
         FFMEHuXlflG0+NnXB0KwT8DZX+9rq6FGrGc8SSmqJJ6hdniNZLNp9aa0fg0GLOTMVnwl
         Hc62VmIcHMLb1eO068FDH25BTIcdSt8w4bCb2etcuuU7RlR6Uq4MxUYGFDvcPMO2kt/7
         RGEptMlZBM5bH8kLUhTA61mPUkLsDUpww6aakp8HrRLezc3PujH7cJBFYcY13MdOB0LX
         PPYQOIlwkOC5G/LzcWjectWel1VbLErfcEZkJp4T6KmrHjdGBLQQV1wYD9MnQHcEViYH
         ZzOw==
X-Gm-Message-State: AO0yUKUc8k7CnqKVwFFpDqZ/UeAVMvREMQkB0NoTG+DJQjLIlj1yrC0u
        Ptzlh5gOw0NDaf+eNO8VKnNO+zXo+j8KH66j6onBkw==
X-Google-Smtp-Source: AK7set8pB62eMzb3kjJ9sewpqKaIGjNJeabx0ItOdGY5DU03o3P3elQqIrtnipiQvcTqN0hpzwUX3w==
X-Received: by 2002:aa7:d644:0:b0:4ad:7481:c2fe with SMTP id v4-20020aa7d644000000b004ad7481c2femr2841749edr.22.1677867415078;
        Fri, 03 Mar 2023 10:16:55 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090665cf00b008de729c8a03sm1207161ejn.38.2023.03.03.10.16.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:16:54 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id i34so13773055eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:16:54 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr1340444ejb.0.1677867414220; Fri, 03 Mar
 2023 10:16:54 -0800 (PST)
MIME-Version: 1.0
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
 <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com> <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
 <2B90FACE-74EB-47C8-91FD-62E3F77B95EC@meta.com>
In-Reply-To: <2B90FACE-74EB-47C8-91FD-62E3F77B95EC@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 10:16:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9xdS8hR1NWC8ZuvR2M35kHe9Tz5ERr5m9B=BUaPNv0Q@mail.gmail.com>
Message-ID: <CAHk-=wj9xdS8hR1NWC8ZuvR2M35kHe9Tz5ERr5m9B=BUaPNv0Q@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 10:03=E2=80=AFAM Nick Terrell <terrelln@meta.com> wr=
ote:
>
> What do you prefer I do with my current tree? I guess I can either:
> - Leave the merges in and keep a stable tree
> - Fix up my tree and clean up the merges, but break the stable tree

In this case, since I'm not taking it during the merge window anyway,
just reset and rebase and basically start a new fixes branch that can
get pulled next week after it's been in that form in linux-next.

All of the actual real commits (ie the non-merge ones) seem to be
fixes, so let's just treat them as such.

And for sanity reasons, don't start the branch at a "random commit of
the day". Particularly not during the merge window. You want the
starting point to be something that doesn't have random issues that we
may not even know about yet - simply because you want *your* branch to
be as stable as possible, and you should aim to have to worry about
issues with zstd, not some random "oops, that particular base had a
random bug because of some merge window thing that wasn't found until
-rc3".

So start the fixes branch at a reasonable stableish point (in this
case presumably just 6.2).

Of course, the same thing is true of new development branches too, not
just fixes branches.

It's a bad idea to build a house on quick-sand, and it's a bad idea to
start new development on some unstable source base.

(One special case of "start development at a stable point" is to
simply continue off some old point of your previous development. Then
it's stable not because it was some known release, but simply because
it's what you used previously and had no issues with).

That whole "pick a stable point" thing is worth noting also for the
case when you _do_ decide that yes, you do need to rebase or
back-merge, and you have a good reason to do so. Don't merge a random
commit of the day. Merge a _specific_ commit that you can explain why
you picked _that_ point to merge.

Of course, things like tagged releases aren't necessarily stable by
definition - we find things to fix after release too. But at least
they are hopefully "we at least tried to make sure it wasn't a bad
point".

              Linus
