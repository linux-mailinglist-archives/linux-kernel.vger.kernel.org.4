Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02076A2601
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBYAu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBYAu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:50:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6068C1D90C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:50:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s26so3929976edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rznQ2Ogm4D33TB32Lv+pmA0yIC9Of9RuAOzuizAtFv4=;
        b=Rr+6dYF3riKD9r0sRAOHImobEYlinle0qvRckkGJ549mYTdkcVZgg/0D09XCsiv5aq
         G8/EV4kPzZLAxDdirBmS8S8vDUGp72l//4wUpHrMtlF8UqO2PuWy6W5P+ycHUDqcMkkq
         gnY/oUveByG76GpK8/M1c+X5wIh2noGzGZWGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rznQ2Ogm4D33TB32Lv+pmA0yIC9Of9RuAOzuizAtFv4=;
        b=WeV9W5FjPoyQKN+JLFKfxAqNsoatnrG/h6R5wxuzwGOYPOLpkxDrgBx8MgKCpK4e94
         Ovd1yHOtH2+WX4Ad9nMoVWyMRs0J596n0N82tSJSVzgbmr47MbpKpkti9Wtu1XzEgXFq
         2DHjFn5OyBINQL3U+C57lgeA/I2P58uvchKOmIf4ojoaMKEjUpMT56A4wKmpJjLUixKm
         NnJPccl2rax/aHvStXl46+9jHrl1ZaeG++b4/0BKtTJeDCsMffRb+qI7QjvWEoL70s5E
         pRMNTTD+vhx5DBHGXloZ1D7E49BEaBZNFJpSt/qViXNSJnsaI1dgGHDFZTdDMrpex3Dc
         QXOw==
X-Gm-Message-State: AO0yUKUqzoKE2bn5UunNl+RS6nGEw86lBfwMi+Q3JV0BQU+FqWspV2vK
        UhVpxWp50wj+Dcr1MACyOTQRpgHmTSXewdDgeroWWw==
X-Google-Smtp-Source: AK7set8U4M21rxFEtGl8gv7uRD0uhNJNYy2Om5gZaK9aLWMRqV0tfRjoBp/GgOYU6NpwkdCU3KYTsw==
X-Received: by 2002:a17:906:364b:b0:8b1:1f2d:ecf1 with SMTP id r11-20020a170906364b00b008b11f2decf1mr23023932ejb.67.1677286224419;
        Fri, 24 Feb 2023 16:50:24 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906970900b008be996c1630sm201202ejx.39.2023.02.24.16.50.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 16:50:23 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id o12so3978667edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:50:23 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr9236553ejx.0.1677286223336; Fri, 24 Feb
 2023 16:50:23 -0800 (PST)
MIME-Version: 1.0
References: <Y/Tlx8j3i17n5bzL@nvidia.com> <CAHk-=wiy2XRdvxchyuVYJJ618sAcGiPPam14z8yAW+kyCzgPmA@mail.gmail.com>
 <Y/lQIwcha1DFq2om@nvidia.com>
In-Reply-To: <Y/lQIwcha1DFq2om@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 16:50:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjM+p5K_MkM6COZou-u3S=6p1U4UsBHCaKximm5tT-Arg@mail.gmail.com>
Message-ID: <CAHk-=wjM+p5K_MkM6COZou-u3S=6p1U4UsBHCaKximm5tT-Arg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 4:02 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Do you like this sort of explanation in the email or the tag?

Either works, I really don't have a strong preference. Some people do
one, others do the other. And some people (like Rafael) do both - with
the summary list in the tag (and thus also as part of the pull
request), but an overview at the top of the email.

> Honestly, after 5 years (wow time flies) of sending PRs for rdma I'm
> still a bit unclear on the best way to write the tag message.

Heh. Probably because there isn't any "one correct" way. Whatever
works best for you.

The thing I personally care about is just that there _is_ an
explanation, and that it makes sense in the context of a human reader
who looks at the merge later.

So no automatically generated stuff that you could just get with some
git command anyway, but an actual overview.

And I'll edit things to make sense in a commit message anyway, so I'll
remove language like "This pull request contains.." because that
doesn't make sense once it's just a merge commit and no longer is a
pull request.

So I'll generally edit that kind of laniage down to "This contains.."
instead or something like that.

I also try to *generally* make the merge commit messages look roughly
the same, so that when people use wildly different whitespace (tabs vs
spaces) or use different bullet points - "-" vs "o" vs "*" etc) I
generally try to make those kinds of things also be at least
*somewhat* consistent.

And for that, it can certainly make my life easier if you look at what
merge messages look like, and don't try to make your pull request
message wildly different. But it's really not a big deal - I do that
kind of reformatting as part of simply reading the message, so it's
all fine.

Finally - remember that the merge message is for humans reading it
later, and not everybody necessarily knows the TLA's that may be
obvious to you as a maintainer of that subsystem. So try to make it
somewhat legible to a general (kernel developer) public.

And then if I feel like the message doesn't cover all of the changes,
I'll prod you, like I did in this case.

               Linus
