Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4FA61FB34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiKGRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiKGRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:24:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2072124D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:24:37 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id d20so17327214ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nMbyX3MqszrbcsGtBhTgiGAwzJTeEdIb9t0B7nyorBU=;
        b=Ptht3syHZeOUew2HlM4prrnn1aDaHC4QTa5jJUqw5rtrb6FDzeiaPQsUolv10LANJg
         vWMWJEs8EnIm6eOegle26LtUVcuY+Uy3/fuaRkQagly2RbFHrH7P4cRNZHwp2Ovf8WfY
         HmdSTbvYrQInrNQPitbg3aJGuVz52jwtJO9At8/TQnsK5So2UYhv6z1ow87kioxLRtlG
         TX2UlUwvMy//GoL5pD1qb2sUhU5IoGCDt06xCb2qWb64Vkh+zUfsVJ64frTsNFbIPvOw
         mvI6P7trCGoUDINKJUgCu8VEOG/oTAHSxKIXjpbjzi7o2SuvJdI2qBd07rr6xCuXBUlB
         5uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMbyX3MqszrbcsGtBhTgiGAwzJTeEdIb9t0B7nyorBU=;
        b=uzwi/It64FBSAw5qDBCQ9GPkwcmeON7KYmp1Qa20HRPktVT2frcyqmHsP3FJrQAN2Z
         9bKETzxyxotyyRXP6HPiNKLtDFHfivd/IN+H1fbUp64mmGm0q6T5wW2qDs9LkNZ8mV6X
         92M8iPIcMUyNEwj/l6/m5d/2TVPKj+8rIg0zEOzA0asZVtbJ2mYQ2ROXYgbNxOcRAspK
         7+5WRSq2gICbqtqbJQDG+XWpcaihYGcjXCNBH2SePNRbJ+VXkzDDgySh8QbKIHHQ4hRI
         AttIkDpB8ENthglbJINkUqr8mBNV5esRAQnywnngX8qG/ebFst3p5EdKxnC1DgqSbpqh
         08WQ==
X-Gm-Message-State: ACrzQf3Ef3UKzf27EshXnF9hbGeYJrMMoFJD73hk8KeswMcSnLtymb9/
        n3kuZzuESlTs6kkZUqe+LYBjqnizJC5rCUEznK3M9g==
X-Google-Smtp-Source: AMsMyM7Y//ecfdfBduVRe+XCcqV3dMVh46wMXTjLZRCRPV1qwmHcEtKp5wbziACPXKDcFtPYb+2k5P6kceklZVbRMQA=
X-Received: by 2002:a05:651c:104e:b0:277:10b2:47e5 with SMTP id
 x14-20020a05651c104e00b0027710b247e5mr5564675ljm.502.1667841875085; Mon, 07
 Nov 2022 09:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-5-dionnaglaze@google.com> <CAMkAt6rS15hAWMYpZB_RxR3k+g1dPCK43rxRnv54+k=QgGqweQ@mail.gmail.com>
In-Reply-To: <CAMkAt6rS15hAWMYpZB_RxR3k+g1dPCK43rxRnv54+k=QgGqweQ@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 7 Nov 2022 10:24:23 -0700
Message-ID: <CAMkAt6pqq=2Yv1pkB9Qz1F93unwWgMa8NH3VcMSfWtpS-O31qA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest request
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
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

On Fri, Nov 4, 2022 at 7:33 PM Peter Gonda <pgonda@google.com> wrote:
>
> On Fri, Nov 4, 2022 at 5:01 PM Dionna Glaze <dionnaglaze@google.com> wrote:
> >
> > The GHCB specification states that the upper 32 bits of exitinfo2 are
> > for the VMM's error codes. The sev-guest ABI has already locked in
> > that the fw_err status of the input will be 64 bits, and that
> > BIT_ULL(32) means that the extended guest request's data buffer was too
> > small, so we have to keep that ABI.
> >
> > We can still interpret the upper 32 bits of exitinfo2 for the user
> > anyway in case the request gets throttled. For safety, since the
> > encryption algorithm in GHCBv2 is AES_GCM, we cannot return to user
> > space without having completed the request with the current sequence
> > number. If we were to return and the guest were to make another request
> > but with different message contents, then that would be IV reuse.
> >
> > When throttled, the driver will reschedule itself and then try
> > again after sleeping half its ratelimit time to avoid a big wait queue.
> > The ioctl may block indefinitely, but that has always been the case
> > when deferring these requests to the host.
> >
> > Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> > Cc: Peter Gonda <pgonda@google.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Liam Merwick <liam.merwick@oracle.com>
> > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > Cc: Haowen Bai <baihaowen@meizu.com>
> >
> > Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
>
> Reviewed-by: Peter Gonda <pgonda@google.com>

Tested-by: Peter Gonda <pgonda@google.com>

Tested with the host throttling patches you shared offlist. Used a
pretty restrictive rate limit to ensure I the hit the limit during
testing.
