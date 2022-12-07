Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB17645D58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLGPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiLGPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:11:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839F961B84
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:11:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h193so16617905pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lN+y24HtPTtYsU4nJrvB6CVlWdApjZBrH5S1DCC2kXg=;
        b=IFcVuLFIXQyhqB7xwRNHbt8wlXk/GKwZ+NAtI2ye9vGnU3euJUumbJIKXGyssRypFI
         /xeN15jHdNFC+Nznb5rWm+oOs14M/9PXLMCqWXEa/mcxJyZp6a+XNMIG8ImuXsDpyl50
         fByLpxnsTKAZu7FCkhxvobLNcqkoQHxtpIC7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN+y24HtPTtYsU4nJrvB6CVlWdApjZBrH5S1DCC2kXg=;
        b=TfNhgRMGZrmb4TZ7iFK47aT+3MuJMgQuq7U0kp+HuZbCnk/tv1sAuDf13ogv3uJ/vd
         yEoFH9ErV0c9H7JvHGSu/SNf5GKtH0A5D42EKSNqJenHZtyR7dhPB8dDdKIoLJn7lpfG
         PUD9EzhKriojhzdZEGCq/sA8ptsV7tlaBd/TOEvWjnWe2nTIzBvqeHtQTKN2X4g60MEB
         OKTfKHJx7iCRJr5PiD/kKxDNId2d5oNpyet7mf6HL8OErj4caYberuof1dTymd2uITgs
         0Y0kxY8wMIHfDxoEYGiKuBBOlvnWde4swSV0A6VJfE6Vke1sqODHTB178JYHnum8oSCR
         etaA==
X-Gm-Message-State: ANoB5pkGP6NG/TT/LxPe4r3h8zRfsHKp0lfGQq94bh6c2Yhdh2Jn2GIq
        NhdwDHPPwtFCvYEkwUfgmzqNXQ4UQscfxVCyGh6WvA==
X-Google-Smtp-Source: AA0mqf7aWAEOQCVyJoQT+sLcmLykvW+jmp5tFrVTULLQMFDGR0lVkdnDP5crGEOtMJ5nf8lGxlhb53dFKh5Q0j7rRrA=
X-Received: by 2002:a63:180a:0:b0:470:63e5:5c59 with SMTP id
 y10-20020a63180a000000b0047063e55c59mr63840166pgl.172.1670425910989; Wed, 07
 Dec 2022 07:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20221206145936.922196-1-benjamin.tissoires@redhat.com>
 <20221206145936.922196-4-benjamin.tissoires@redhat.com> <CAO-hwJJq23V+ceJvX8zz-wGB6VgByuMY-xGu8VukiOmP+FfXHA@mail.gmail.com>
In-Reply-To: <CAO-hwJJq23V+ceJvX8zz-wGB6VgByuMY-xGu8VukiOmP+FfXHA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 7 Dec 2022 16:11:39 +0100
Message-ID: <CABRcYmL_hAyH0QY7bP1Eh7atXeFDYg3-orht=KK1Zjcj9RNpqg@mail.gmail.com>
Subject: Re: [PATCH HID for-next v3 3/5] HID: bpf: enforce HID_BPF dependencies
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 3:58 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Dec 6, 2022 at 3:59 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > As mentioned in the link below, having JIT and BPF is not enough to
> > have fentry/fexit/fmod_ret APIs. This resolves the error that
> > happens on a system without tracing enabled when hid-bpf tries to
> > load itself.
> >
> > Link: https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com
> > Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > no changes in v3
> >
> > changes in v2:
> > - dropped ALLOW_ERROR_INJECTION requirement
>
> Florent, can I keep your reviewed-by on this patch?

Yes! :)
Reviewed-by: Florent Revest <revest@chromium.org>

Thank you for the updated series, I think it's cleaner than relying on
error injection indeed.

I still believe that, in the future, BPF should offer a proxy config
to expose if BPF tracing is supported because 1- the implementation of
BPF tracing could someday change 2- to be exactly correct, ftrace
direct call isn't _really_ a sufficient condition either: the BPF JIT
also needs to implement the arch_prepare_bpf_trampoline function.
Currently, there is no config to check if that feature is available.
But as agreed in a previous thread, that consolidation can be done
separately. For now your patch looks good enough to me already.
