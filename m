Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4466C665052
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjAKASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjAKAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:18:28 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE06D100
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:18:27 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s5so8058372qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mkUelddT52dMhaIz46/bDTKpMbObeBPSL3ul3pn2Ees=;
        b=H0Tg9UtjN3Euh2L3KR4vJ3iNxhOkDwGVzmRsf6uKGrnPd8NYDrQouYnC4I0YSI5i1X
         BiLYdJDw+ihKaw7EFYU4AbEjGAC6NvCLwOMf7I1IvB4csdYDUc+RrOZIyyqbAOvDia5B
         /qgyu6eiSdI71j0UGGGx+S0AJvgTlwEv9Pzrs3/x7EXAQJ0SAin4VD37n/NcMLT/O6H/
         sUDt9jvDUfPslQnZc99goUncSh9k8m+FMcRECtxuUdGL/xVivoMpZbn+O01GJl60nleN
         YKs2r8Vq5BNa+k/6CgC3oUMOfA3nQ7b4hC4CJs5cQNAhCl1FRHWUTFhVS9/gX9AfW6vS
         RVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkUelddT52dMhaIz46/bDTKpMbObeBPSL3ul3pn2Ees=;
        b=Rpuj0/7ivYC9HcE9u7//Zw2VJzEzOO7m5j4bXg3xps9nNWrThwGsFtJGuYIa8EOs2R
         nk6Jpz/R8sEPGzjaWyPxRzdUF8868oN4kAsbi22llOg8CD64EgHPFfKZVn6MUkhd1EKc
         QyAWb9euOXbwAdl/8imTLxsxUZdr/+0VKOViYyzTl6Bk0q5n7iL1px7vMIEV2Opsh6cB
         q6LN+seI92Pn1nqAIbFy1Pvn4cLaeFo3z+NfKYxPTqHKyVcy9xIxmeBT7NCyvVYKQZBw
         Nrv3cn9YgRw4+8MLP2vreakk9SfGxmRvnotYrPriI/q4gvMP/Q02AqCWEr15/xApS9sa
         O7Uw==
X-Gm-Message-State: AFqh2krLRI+iizB+aUi8AnPnKTlny3ADeZcTat5Qnb76YTNNyHESnkJ+
        Xbwcafq5dGAC9Zhwm2nWtqmp8ldYXIJBv+a0zb0jQQ==
X-Google-Smtp-Source: AMrXdXuhgcUdH/AGtyPPRRardKfs4c4A9elwj8I8dGo1sRndHi0yVG3afsxaNVELH/dx/oGXvwStghvWf4Ykxv/PXDU=
X-Received: by 2002:ac8:6b8a:0:b0:3a7:e237:83dd with SMTP id
 z10-20020ac86b8a000000b003a7e23783ddmr3201868qts.219.1673396306122; Tue, 10
 Jan 2023 16:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20221228192438.2835203-1-vannapurve@google.com>
 <20221228192438.2835203-5-vannapurve@google.com> <Y7xbC+leVdO0TRVE@google.com>
In-Reply-To: <Y7xbC+leVdO0TRVE@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 10 Jan 2023 16:18:15 -0800
Message-ID: <CAGtprH_F-U799DT9OkrC=pEQJYt0=Tj2WWuKuczm6z2ftUZuQA@mail.gmail.com>
Subject: Re: [V4 PATCH 4/4] KVM: selftests: x86: Invoke kvm hypercall as per
 host cpu
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
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

On Mon, Jan 9, 2023 at 10:21 AM Sean Christopherson <seanjc@google.com> wrote:
>
> KVM: selftests: Use host's native hypercall instruction in kvm_hypercall()
>
> On Wed, Dec 28, 2022, Vishal Annapurve wrote:
> > Invoke vmcall/vmmcall instructions from kvm_hypercall as per host CPU
>
> () for functions, i.e. kvm_hypercall().
>
> > type.
>
> s/type/vendor, "type" is too generic.
>
> > CVMs and current kvm_hyerpcall callers need to execute hypercall
>
> CVM isn't a not ubiquitous acronym.  I would avoid it entirely because "CVM"
> doesn't strictly imply memory encryption, e.g. KVM could still patch the guest in
> a pKVM-like implementation.
>
>   Use the host CPU's native hypercall instruction, i.e. VMCALL vs. VMMCALL,
>   in kvm_hypercall(), as relying on KVM to patch in the native hypercall on
>   a #UD for the "wrong" hypercall requires KVM_X86_QUIRK_FIX_HYPERCALL_INSN
>   to be enabled and flat out doesn't work if guest memory is encrypted with
>   a private key, e.g. for SEV VMs.

Ack, this makes sense.
