Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EE639E46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiK0XsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK0XsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:48:10 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FAD85
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 15:48:08 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n188so6523479iof.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 15:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx2NDaAEXNAUQ6X3OF+HlDwRPMVGMq2q4DWYkOynsK0=;
        b=kKpH4F+fBEPb28DdSNlIzAygMBB+2JBfMa1S6oz0L5lIDFlTIHhd/bR7SKihyP21cX
         kD7RnW1HLO0kLaruY/fQSDd7EsAX/UFo4sFQnoDCKvTz1RKvSC+MGXWOkdx1JxMSp1DK
         Xwi6ONNK8hmBRSRskXz3CHXpk5Lr/gisWszztg7afTW3lizSKS3VUeCaVnsCDMIdHMQ1
         p9KyrqlmzbyCCqr4BFSGCN7NCEnVClpY5qnyatxFXq1kne3ufttDy7s7OHh/M1EajNsB
         7ZLeWCwpmPiCNsfffFbMVnFyIS41GT+XLREQPbSzf8hzYTEb+7a2keSbuJsZ+zhjzRcc
         LLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fx2NDaAEXNAUQ6X3OF+HlDwRPMVGMq2q4DWYkOynsK0=;
        b=YWOKDH5VgaqZRMRWujBzknVPpO0yw7RYTTysvMjHMrDtkmLK2y1I9zh3YbaatlmxLu
         SKkvL0nFNjTTIkZUWXV1mLutLA/whxW1A9tQ4kn77rvECkioJRBay4W4xfojawpNgmET
         NYvdivo2G2x3BQkbQ+r+72MCsva0UCSkUkBheU5u8SfjM+zVMYj4MPeswG1mJuPGf1Jz
         ddfBinSbO12Z+Pwk/RgUE1dYbAh6E5psVHgmHeRUwtmXwc7hsQuqPR5S3kClFl82ZBNy
         Rr9ZMczr/j0ie5YNTrx7q09oi3xGy4EC1y0gAnPL2OPPw8D+jydrpgRZkMehzhRrLzGG
         MgiQ==
X-Gm-Message-State: ANoB5pk9L5gXcxs4WN0r6QS+qrBzdrtrZ8QEgwPLf5jMYF+/et/q9zHK
        oVYKmBQv+FWcgMwgiM7gWYYN+EF17oQT1VqCzqD26A==
X-Google-Smtp-Source: AA0mqf5+h2VMLuOKliEIFUxnjb4b8A+nnbEWmXC7DXBTw5Fd5mRn17SKamuEgkCT4sp5dQFzG5gI8JC3GyhwLwVmAyg=
X-Received: by 2002:a02:7a06:0:b0:374:c658:2141 with SMTP id
 a6-20020a027a06000000b00374c6582141mr20924671jac.210.1669592888076; Sun, 27
 Nov 2022 15:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20221124003505.424617-1-mizhang@google.com> <CABgObfYpn98X2NFhoWNAPuyu_NtmovKD5MHoon0gtVP08Su0eA@mail.gmail.com>
In-Reply-To: <CABgObfYpn98X2NFhoWNAPuyu_NtmovKD5MHoon0gtVP08Su0eA@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Sun, 27 Nov 2022 15:47:57 -0800
Message-ID: <CAL715W+QrvkhWgxQ5h_=fadJGO_Epqg_fdojnEpNuEz2dcFKpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] KVM: x86/mmu: replace BUG() with KVM_BUG() in
 shadow mmu
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>
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

On Wed, Nov 23, 2022 at 5:17 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > v1 -> v2:
> >  - compile test the code.
> >  - fill KVM_BUG() with kvm_get_running_vcpu()->kvm
>
> Nope, the zapping code paths will run often with no running vCPU, for
> example drop_parent_pte <- kvm_mmu_unlink_parents <-
> __kvm_mmu_prepare_zap_page <- kvm_zap_obsolete_pages <-
> kvm_mmu_zap_all_fast <- kvm_mmu_invalidate_zap_pages_in_memslot <-
> kvm_page_track_flush_slot <- kvm_arch_flush_shadow_memslot <-
> kvm_invalidate_memslot <- ioctl(KVM_SET_USER_MEMORY_REGION).
>
> Paolo

Make sense. Will plumb through the kvm parameter in the next version.
