Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647D69BFEA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBSJ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:58:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7AEDBE2;
        Sun, 19 Feb 2023 01:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 778DEB8095A;
        Sun, 19 Feb 2023 09:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2216AC433D2;
        Sun, 19 Feb 2023 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676800101;
        bh=z9cSiSOXGaPdxie5ep3YBFQbolXD2v1I5QU9+yqyPCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OEQL6VBDRnVguQ4suP6veS2kHVfG0QW/tJuAg6OGCkuJ2dGTts+0phoazysI7u/fI
         zy+rP2zOzLW6wvRgmfAzt4vl5wsCDSZ1jpT/bRj20PNU8aQo+OgsFwWM6cplXxpUm7
         Ew0fEvrCkKTX7tjEvmboAGe17Toth7Iu/S3TcOJxU35qiJonTIbiM9QUxHvxXJtzYo
         jN7uT1UBGhY+MUZtLKyKwRx/XiJtwfN+y/mvJiO1bL5xx34Ed0Q4GaJRiIPJxIx1Yi
         lQq5/sD9ovAaHEIrNmr+4zgQUPOeULveufqdvyqN8NL0Fv3OKGRzV1o4SCyOXux9tp
         DlP/0tEYl5haw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-171dc352442so209919fac.7;
        Sun, 19 Feb 2023 01:48:21 -0800 (PST)
X-Gm-Message-State: AO0yUKUCSbxrKIM+tNr96hz1hI38K3CjtZVglowsdfSjTkFHmyBWYqap
        zohb69iMCcxKhPJeiqWCiawPPbilyaP7PnVMV/8=
X-Google-Smtp-Source: AK7set/ROx1Z0/HbxofW3EgBKaW957avBtR8LJ5rn3tOFlQN4n7jmg/XN2s8awVrOcI+haII5/iltq648CW/63vCeS0=
X-Received: by 2002:a05:6870:c1ce:b0:16e:9431:5c2e with SMTP id
 i14-20020a056870c1ce00b0016e94315c2emr441406oad.56.1676800100244; Sun, 19 Feb
 2023 01:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
In-Reply-To: <20230217202234.32260-1-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Feb 2023 18:47:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwzvsGPLWJ_QJFw+KjHQM9ZpaWqZFQNS60K9Kb9TU8Rw@mail.gmail.com>
Message-ID: <CAK7LNASwzvsGPLWJ_QJFw+KjHQM9ZpaWqZFQNS60K9Kb9TU8Rw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/1] Validating UAPI backwards compatibility
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 5:23 AM John Moon <quic_johmoo@quicinc.com> wrote:
>
> + linux-arm-kernel and Greg KH
>
> Hi all,
>
> The kernel community has rigorously enforced a policy of backwards
> compatibility in its UAPI headers for a long time. This has allowed user
> applications to enjoy stability across kernel upgrades without
> recompiling.
>
> In the vendor driver community (out-of-tree modules), there's been a
> lack of discipline when it comes to maintaining UAPI backwards
> compatibility. This has been a maintenance burden and limits our options
> for long-term support of older devices.
>
> Our goal is to add tooling for vendor driver developers because the
> upstream model of expert maintainer code review can be difficult to
> replicate in-house. Tools may help developers catch simple UAPI
> incompatibilities that could be easily overlooked by in-house review.
>
> We see in the kernel documentation:
> "Kernel headers are backwards compatible, but not forwards compatible.
> This means that a program built against a C library using older kernel
> headers should run on a newer kernel (although it may not have access
> to new features), but a program built against newer kernel headers may
> not work on an older kernel."[1]
>
> How does the kernel enforce this guarantee? We would be interested to
> learn about any tools or methods used by kernel developers to make sure
> the above statement remains true.
>
> Could the documentation on UAPI maintenance (from a developer's point of
> view) be expanded? Internally, we have a set of guidelines for our kernel
> developers regarding UAPI compatibility techniques. If there's interest
> in supplying a document on this topic with the kernel, we'd be happy to
> submit a draft detailing what we have so far as a jumping off point.
>
> Additionally, I've attached a shell script we've been using internally
> to validate changes to our UAPI headers are backwards compatible. The
> script uses libabigail's[2] tool abidiff[3] to compare a modified
> header's ABI before and after a patch is applied. If an existing UAPI is
> modified, the script exits non-zero. We use this script in our CI system
> to block changes that fail the check.
>
> Currently, the script works with gcc. It generates output like this when
> a backwards-incompatible change is made to a UAPI header:
>
>  !!! ABI differences detected in include/uapi/linux/acct.h (compared to
>  file at HEAD^1) !!!
>
>      [C] 'struct acct' changed:
>        type size changed from 512 to 544 (in bits)
>        1 data member insertion:
>          '__u32 new_val', at offset 512 (in bits) at acct.h:71:1
>
>  0/1 UAPI header file changes are backwards compatible
>  UAPI header ABI check failed
>
> However, we have not had success with clang. It seems clang is more
> aggressive in optimizing dead code away (no matter which options we
> pass). Therefore, no ABI differences are found.
>
> We wanted to share with the community to receive feedback and any advice
> when it comes to tooling/policy surrounding this issue. Our hope is that
> the script will help all kernel UAPI authors (even those that haven't
> upstreamed yet) maintain good discipline and avoid breaking userspace.
>
> [1] Documentation/kbuild/headers_install.rst
> [2] https://sourceware.org/libabigail/manual/libabigail-overview.html
> [3] https://sourceware.org/libabigail/manual/abidiff.html
>
> P.S. While at Qualcomm, Jordan Crouse <jorcrous@amazon.com> authored the
> original version of the UAPI checker script. Thanks Jordan!


If you want to express the authorship of the original,
it is possible to add the "Co-developed-by" tag,
which is mentioned in
Documentation/translations/sp_SP/process/submitting-patches.rst


It depends on how much code you rewrote, though.





>
> John Moon (1):
>   check-uapi: Introduce check-uapi.sh
>
>  scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100755 scripts/check-uapi.sh
>
>
> base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
