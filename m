Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10E678519
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAWSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjAWSlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:41:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194F233C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:41:23 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so9134624pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmlRiT9KV+phAJhVbeU2MK7l26rsSidNpPrjEHuIhmw=;
        b=htX2k/N3Q9Wdfoocx7NEDGxZpBehW/5iUVrl5uYUJh08puTE7YWTggNTfbdMnxB8JB
         FL92QmLqtlrtzNwy/W149aKppxG8JL91n7TwQVQdeok9bKI+qX3tPjGarm1QNwxEM9tH
         Qmsmkdn4PMu+hAnE9r6lWc27wqPsyXUWMo3rbIkWRFTOQViao8kI2ypjfISzGEcb+O1U
         gtmay3w2tB8EuzVEvx1yZAxa9ZIC0tteNpzup9T8YtSOJuSWxVmXerdA0bq7qX6u8kIB
         2v/Pf+JaFHk7UZN7cd0gleQp2hydDJfowBGjSd2QGPBOpollcG2bNidf3R7HSQUIvpWF
         bAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmlRiT9KV+phAJhVbeU2MK7l26rsSidNpPrjEHuIhmw=;
        b=ZMCqLreDwSpj9wwFvpL4fxWVvLAeR4EdSoI5MykgEkBHMvQyJ0FKO5VemrDI9KXPLQ
         /v+o0NQ2zgaClNkX4BHqcUM4kdwz89iwAFMdQt2zxff5dAUahoZP1drBSQmByWz22tTx
         Jw3meB2/JCG3ODQkb89jmLvUd6QWLNfiVqvsXd9K05FLkYeEXxObrziwLVeQzRPtyK/2
         EUClHCjKXNmZyqOxSfUpOaeDvZygrGOT62ahInuE20htBRGjn7RZ9IbAoxx/vMcLE1MQ
         Ua7k3K1/aq//IBeo7KTWwi1VaP2BvfFDg/xAdsJM8/M8Tw3am0X0d+8ma3p5bKXPaQzn
         Vm+w==
X-Gm-Message-State: AFqh2kqoQBpAYee8F6s5cFo80p3M2Mu8oMmxu4ywjMPF6X7UB/EuyD5n
        pRmU4Fszi/73ZKzoCrJW46vp3Ohv2BQFca1ps30=
X-Google-Smtp-Source: AMrXdXsKHGfJWy80MXupDdl+PNc1DsrR21pZYoWODp7mUxRldE/jy2FgcvWo7ARk95ZkzK7Q6LNqPQ==
X-Received: by 2002:a17:903:286:b0:192:751c:6e8d with SMTP id j6-20020a170903028600b00192751c6e8dmr25676883plr.58.1674499282518;
        Mon, 23 Jan 2023 10:41:22 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b001947738ec7fsm20482plp.158.2023.01.23.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:41:22 -0800 (PST)
Date:   Mon, 23 Jan 2023 10:41:18 -0800
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Ricardo Koller <ricarkol@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 2/2] selftests: KVM: Add page splitting test
Message-ID: <Y87UzmpCg9hXO2NI@google.com>
References: <20230119212510.3938454-1-bgardon@google.com>
 <20230119212510.3938454-3-bgardon@google.com>
 <Y8nKerX9tDRHkFq+@google.com>
 <CANgfPd8B_0w39d7V+c4GnUxdqrc8qN78r8Pq0Con3Mx9WO0hkQ@mail.gmail.com>
 <Y8qj1QS1VadgaX7A@google.com>
 <CAOHnOrzKBh2Cq7ZQece+6f6P5wS6gZ1R2vjEQ5=QLTy7BmUvFQ@mail.gmail.com>
 <CANgfPd_B0q6uU1Be7A-QOj5_YoWi8z9g9LO63mc+=136hO5K4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_B0q6uU1Be7A-QOj5_YoWi8z9g9LO63mc+=136hO5K4Q@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:04:04PM -0800, Ben Gardon wrote:
> On Fri, Jan 20, 2023 at 6:34 AM Ricardo Koller <ricarkol@google.com> wrote:
> >
> ...
> > > > > > +
> > > > > > +     run_test(&p);
> > > > >
> > > > > Use for_each_guest_mode() to run against all supported guest modes.
> > > >
> > > > I'm not sure that would actually improve coverage. None of the page
> > > > splitting behavior depends on the mode AFAICT.
> > >
> > > You need to use for_each_guest_mode() for the ARM case. The issue is
> > > that whatever mode (guest page size and VA size) you pick might not be
> > > supported by the host. So, you first to explore what's available (via
> > > for_each_guest_mode()).
> >
> > Actually, that's fixed by using the default mode, which picks the
> > first available
> > mode. I would prefer to use for_each_guest_mode() though, who knows and
> > something fails with some specific guest page size for some reason.
> 
> Okay, will do. I wasn't sure if we did eager page splitting on ARM, so

Ricardo is in the process of upstreaming eager page splitting for ARM:

https://lore.kernel.org/kvm/20230113035000.480021-1-ricarkol@google.com/

> I was only planning on making this test for x86_64 initially, hence it
> being in that directory. If ARM rolls with the same behavior, then
> I'll add the for_each_mode bit and move the test up a directory.

In addition to for_each_guest_mode(), KVM/ARM will need to expose page
size stats so the test can verify the splitting (yet another reason to
have a common MMU).

Ricardo, if you're interested in adding page size stats to KVM/ARM ahead
of the Common MMU, e.g. to test eager page splitting, let me know. I
want to make sure we align on the userspace-visible stat names to avoid
churn down the road. Specifically, do we want to expose neutral names
like pages_{pte,pmd,pud} or expand the KVM/x86 list to include all of
ARM's possible pages sizes like pages_{4k,16k,64k,...} (or both)?
