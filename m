Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7F6F0633
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbjD0Mwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjD0Mwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F519F;
        Thu, 27 Apr 2023 05:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B880863D3F;
        Thu, 27 Apr 2023 12:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2124DC433A0;
        Thu, 27 Apr 2023 12:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682599959;
        bh=8nCNeq6AXVBJ5EROWgVt9eA0zo+3/yxMzOW0CgJVVkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9Jr6LinDCp6loRDPYjnwFahHKlZBM0EppmUJaEtSplytrgAKoTIssQ8IiJaZIhJR
         DO+uJZh9Oi8Jbf6tTg0krQWH+hWRFCuH39VCwzIh5W57KXwglXMW4qLFqYz5QEi0AZ
         CeENXRSE7b4Kmi6t5jeLiS6YlxSF8cFyMnklZZouaYeS1I0IEErQgyTn9/woNtlfuf
         hxSpEYDCGom5bps2STBCdfJGx+02xE+L74FSFDW/bfi01aMGyh3AGDJDJxp8xEIdIn
         HyscRKkNvl6h8pgBCg0VKbSl40jPtxR5RlOrxs/zrlPSK/wNX7Qc+uWqq0Zj855WpZ
         WPUJ3fgr/2oZA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so78988101fa.1;
        Thu, 27 Apr 2023 05:52:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDwpESBzebk+b5Mru0vYZR7APrlbeDsVVvTVcaAPou+8mkjcGHC6
        MoYljJ3AKOqH7igEugY57kXE1h0jSbFbWsaeVLE=
X-Google-Smtp-Source: ACHHUZ4+lYEuTXfjergJTdbMtNMgSriOLZbeijoQ4dGgmQDMSaO3US5u2CA9Mh1ZsvJuvg/NwtJVHJ245d5LFh40jwM=
X-Received: by 2002:a2e:9c81:0:b0:2a7:9cd3:3cc4 with SMTP id
 x1-20020a2e9c81000000b002a79cd33cc4mr517784lji.15.1682599957062; Thu, 27 Apr
 2023 05:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com> <ZEpbTE4gcsf8meXc@FVFF77S0Q05N>
In-Reply-To: <ZEpbTE4gcsf8meXc@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 27 Apr 2023 13:52:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
Message-ID: <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     ron minnich <rminnich@gmail.com>,
        =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 at 12:24, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Apr 26, 2023 at 09:04:56PM -0700, ron minnich wrote:
> > The device tree is self describing data. Adding new information is easy. If you
> > add new information to a node, and older software does not know about it, it is
> > no big deal.
>
> It's true that it's easy to add fields to an extensible format, but that wasn't
> my point of contention. The *semantic* (e.g. all of the relevant DT bindings)
> and *consumption* of that data is the important part, and that's what I was
> referring to, though I appreciate my wording did not make that clear.
>
> > So I can't agree with this comment: "We'd have to create entirely new ways to
> > pass that information, which is not
> > very desirable."
> >
> > The whole point of the dt is that you can always add new ways to pass
> > information, by design.
> >
> > Adding memory attributes would be quite easy.
>
> I don't disagree that is physically possible, and in isolation adding
> properties to a DT is trivial, but the approach proposed is not "easy" unless
> you ignore the cost of specifying analogues for all the EFI portions that you
> plan to omit, ensuring that those stay functionally equivalent to their EFI
> analogues as EFI and ACPI evolve over time, developing and maintaining the code
> which must consume that, avoiding the issues that will arise due to novel
> interactions (as e.g. DT and ACPI are mutually exclusive today, by design),
> etc.
>

Indeed. Currently, Linux/arm64 supports two boot methods

- direct kernel boot
- EFI boot

and two types of hardware descriptions

- device tree (DT)
- ACPI

and the only combination we do not support is ACPI without EFI, as
ACPI on arm64 depends on the EFI memory map.

What this patch seems to be proposing is a combination of all of
these, i.e., doing a pseudo-EFI direct kernel boot where the EFI
dependencies of ACPI are being fulfilled by ad-hoc descriptions passed
in via DT.

I am concerned that this will result in a maintenance burden for Linux
with very little gain, so I feel we should not go down this road.
