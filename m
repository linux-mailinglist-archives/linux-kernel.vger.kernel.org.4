Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0581A72447D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbjFFNdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjFFNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC2118
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686058368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbOwRzmPQ0iAJYo3VfuHKdp9hqtbyOifH3hu5Ap+J9c=;
        b=Fcy0B4ZSaFWdeDkZHCn6Lht5BHR7ljrsV+3tlfgMD00FCDAYg7yxwyhkyjD1Xn+GHL+CnK
        RG/KXWDkAbBLGrJg6SAk/kfpg9tNXXW+hn3QOPrzyzknUnhn9EpJQvlY8Wj7PTEgaOXS0M
        L11Ck6gh8u2RkwI0Y5noRlc0QTdXkGE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-AeeUT85oPpeKTc-3gvoMaw-1; Tue, 06 Jun 2023 09:32:47 -0400
X-MC-Unique: AeeUT85oPpeKTc-3gvoMaw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-53ba38cf091so3941562a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058366; x=1688650366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbOwRzmPQ0iAJYo3VfuHKdp9hqtbyOifH3hu5Ap+J9c=;
        b=lwzwZtLhCV689Fj7TxMHR2BgAXj87R39tyyhZyGAjm+Q/ZcZE7ednOra2jfQZ046dZ
         5JioyazNMtd9bAkPI9aRmmRqq9hLtgRL4Yeg27ltKESZoVPcwLIP5qxyhhk7FuSOnn3w
         cD8KskR29YZMUbw/qo5Z6KmaTQGG98XFBR0l/qUCPMCxmoI0RSOFUJ1pGPm6pp5BUGEq
         tg1B/rg+3DYEhApPebSMBnkN9PZDgua3TpeFCEsrJqHSqSx9pz3RpLYFwfzxzdidKzZI
         qI5g4/4YEz/tpKTpca6dzoxpBQR2pQ8+cAnDOu8yl+jJ0UavM+zl5306+LXZNXotFBlU
         4yBg==
X-Gm-Message-State: AC+VfDwRMfLBFV6abxz6bkcx51537R/dRv761SQMqsKdt1SjKONsXoe4
        E4avFLl385bSIpMN5cm/P09g/K+gubIGLuIqT2BRvMISFmlpA+T9YUKnzScOriD1iRZGy4h/pnT
        3XR5iuNE5PGs2Qx4cOc2Vht1peABDjHIMaAzZ2PCk
X-Received: by 2002:a17:902:c949:b0:1b0:3d03:4179 with SMTP id i9-20020a170902c94900b001b03d034179mr2465168pla.6.1686058366378;
        Tue, 06 Jun 2023 06:32:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73rnlqqx/XsMWnWSX+E7IpatchnCGLGqyhgWVjBmyWLA/5l2n5ItAgVcqnz88C2iL+ihJ3U+zGY+1+7npgNe4=
X-Received: by 2002:a17:902:c949:b0:1b0:3d03:4179 with SMTP id
 i9-20020a170902c94900b001b03d034179mr2465159pla.6.1686058366041; Tue, 06 Jun
 2023 06:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230606124800.1151665-1-agruenba@redhat.com> <CAHk-=wi_P4tOWCbZYo11u5vbB+tTxCSGwKC9m71y-QdbZP8zKA@mail.gmail.com>
In-Reply-To: <CAHk-=wi_P4tOWCbZYo11u5vbB+tTxCSGwKC9m71y-QdbZP8zKA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 6 Jun 2023 15:32:34 +0200
Message-ID: <CAHc6FU7e-ZwFg71S4a6UqdW5aagFPJAqGRhwwov+OMUHcY4UPA@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 2:55=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 6, 2023 at 5:48=E2=80=AFAM Andreas Gruenbacher <agruenba@redh=
at.com> wrote:
> >
> > - Don't get stuck writing page onto itself under direct I/O.
>
> Btw, is there a test for this DIO case?

The previous test case I wrote for these kinds of page faults is:

  "generic: Test page faults during read and write"
  https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3Dd3cbd=
abff

I've added a check for this specific case, but this change hasn't been
posted/merged yet:

  "generic/728: Add mmap + DIO write test"
  https://gitlab.com/agruenba/xfstests/-/commit/8c37de03

> We've had the deadlock issue on t page lock (or for inode locks or
> whatever) for normal IO when faulting in the same page that is written
> to, and we have as pattern for solving that and I think there are
> filesystem tests that trigger this.
>
> But the DIO pattern is a bit different, with the whole "invalidate
> page cache: issue, and the fact that you send this patch now (rather
> than years ago) makes me wonder about test coverage for this all?

Yes, this case wasn't covered so far. The other page fault issues are
covered since 2021, and were fixed in gfs2 back then.

Thanks,
Andreas

