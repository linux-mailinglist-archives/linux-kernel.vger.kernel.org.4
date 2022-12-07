Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43F645D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLGO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLGO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC66361BA9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670425035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qgLLD1AmPKqAai8Ygo30PiMsV/3lKBgVy2t7StpKc5Q=;
        b=H57hPGnK1rRdYVIBO5+ONvQ2bRSdmm05nmHqozq2GN2WysU388Rr/0ekwOla9y3xXDJDC/
        OABTTWGZ80HtqfrylHLWmG6ziTk2zrD7q2K2OKScwnekk1EY5v/b6nAQUIuKHegyyX2qBH
        AiZmh5vdbl1jLyo2xDpxIBC1+sKOeGQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-XRo0L6sHPpS0uyB8cQkovA-1; Wed, 07 Dec 2022 09:57:14 -0500
X-MC-Unique: XRo0L6sHPpS0uyB8cQkovA-1
Received: by mail-il1-f199.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso10338464ilj.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 06:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgLLD1AmPKqAai8Ygo30PiMsV/3lKBgVy2t7StpKc5Q=;
        b=xDih3pm+vJyq5dhIGU4fMrAru7+ikQ+WcrwyVSAqQLCckSeyMRHkzi33zoIR0hq+mr
         LzsUByceEz34P78OKsqFbVhDCCfX9caBEtjPnEYrMXihZ1H41eLjt355tZjjVaLKElFg
         ilkh+EsqnR1QBlBHeqZ8Wv2G+NsbRoOSBvcwfJ96hKUQlbDNaIjCNteGirGwlR7d1DWk
         DunBitQEB0KhE/UADyo1dPpjmKr1uOhOnlBAQxdPYfIn2wD3dYSiTgXgFHsdXkbcWLbz
         9eLsY/nNI7PnDK2aS4Ug6BNqqbTRdF+3Lj0pWRJxZZeoPWKM4fQmNFHTASDQleSBrDIA
         UXfg==
X-Gm-Message-State: ANoB5pmQNpe8vHn9LCd4eBFLw9mrOC8g5aCR5JSFfOfwUN9Mj7oXgkFv
        yGi9zH4r0csHJhz4YuL4h90CHOoU59Z2y4lz8kY9cefRQQyFfucN332KqMsXEQm37kJ9AzN5tpl
        hPY8npxyKr3NEE+HlUQRb3fEAjNmGJgkvy/A2I47A
X-Received: by 2002:a05:6602:3945:b0:6df:bfeb:f15d with SMTP id bt5-20020a056602394500b006dfbfebf15dmr14207517iob.122.1670425032753;
        Wed, 07 Dec 2022 06:57:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7tglNnK6fahWd5fgDVfEgUNwOxoaL7Bt8CugO23uz1Bqs430ygY9Cbsjf5rhZQaMlEETOG7Rtw94u5g+0ay4g=
X-Received: by 2002:a05:6602:3945:b0:6df:bfeb:f15d with SMTP id
 bt5-20020a056602394500b006dfbfebf15dmr14207508iob.122.1670425032518; Wed, 07
 Dec 2022 06:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20221206145936.922196-1-benjamin.tissoires@redhat.com>
 <20221206145936.922196-2-benjamin.tissoires@redhat.com> <CAADnVQKTQMo3wvJWajQSgT5fTsH-rNsz1z8n9yeM3fx+015-jA@mail.gmail.com>
In-Reply-To: <CAADnVQKTQMo3wvJWajQSgT5fTsH-rNsz1z8n9yeM3fx+015-jA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 7 Dec 2022 15:57:01 +0100
Message-ID: <CAO-hwJJAGkcJnZ-q28zKBCX49cvSmp5b1qWJ33i0Ma-zZAi8ZQ@mail.gmail.com>
Subject: Re: [PATCH HID for-next v3 1/5] bpf: do not rely on
 ALLOW_ERROR_INJECTION for fmod_ret
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 9:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 6, 2022 at 6:59 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The current way of expressing that a non-bpf kernel component is willing
> > to accept that bpf programs can be attached to it and that they can change
> > the return value is to abuse ALLOW_ERROR_INJECTION.
> > This is debated in the link below, and the result is that it is not a
> > reasonable thing to do.
> >
> > Reuse the kfunc declaration structure to also tag the kernel functions
> > we want to be fmodret. This way we can control from any subsystem which
> > functions are being modified by bpf without touching the verifier.
> >
> >
> > Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> BPF CI couldn't do its job because of a merge conflict.
> CI only tries to apply the whole series.
> But I tested the patch 1 manually.
> Everything is green on x86-64 and the patch looks good.
>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
>
> Please send the set during the merge window.
> If not we can take just this patch,
> since the series from Viktor Malik would need this patch too.
>

Thanks a lot for the quick review/tests Alexei.

I have now taken this patch and the next into the hid tree.

I actually took this patch through a branch attached to our hid.git
master branch so compared to Linus, it only has this one patch. I also
tagged (and signed) that very same branch with "for-alexei-2022120701"
in case you also want to bring this one in through the bpf tree too.

Full path is at
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/tree/?h=for-alexei-2022120701

Cheers,
Benjamin

