Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C67630B06
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiKSDR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiKSDR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:17:26 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140756ED0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:17:24 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso4215556otr.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9GKJELz9hlq7SEorzsKIdePS+NjjsI9OrIc6tbxZWc=;
        b=jiyHLzBQNnhIzXJo50eGw5kVJVZatjv0zR6+Gx+qpU6FyYaoBBZd5/6pV2X48iA3fj
         XFBxpKTHyaqe4NHWWtAV0YGr6euSGY9OtYLFqTFSF5HW5c+eb93LnsZe1zlYVyiZPINv
         8LLf2O6PFnBbdSFDgzWMIYP8myUon5hlfnCLDx4+WR+L2qmNPvxKalBq5MqvRuE4iDW6
         qCsuzJgWCNANFhQnkq9yPjxGEGnXh6vh0gSO5WZ7NCJBGZV+2mXr6eakjFcHaCXz0O8i
         2oBO1RzMDb8Jtt2lhn/g7Db4UtedkZO0rU7XYPiknfPeVojvL/+6MJxHmUqC8zWYAmxl
         A8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9GKJELz9hlq7SEorzsKIdePS+NjjsI9OrIc6tbxZWc=;
        b=w3x+78UN89eCWBCfkQwDZ0xeOMwsJr16IB+r/Pctx03V7c4WWq1Lci+BidSl8TUlfB
         ozYCp9pVf6b4aDPsFwD6I68RxDUFgNx6VRaCf+zZC1eDx2/8gNTtlIYAcZPxM6ReKhyA
         akoqzQgRjN6G+C8oWLnkRYBUw3PeC5NSJPPlQP7fwSDYiYhw+aYobOXRMuMREBX60KiB
         coVPwn8WgF03Zb4BUadOPXMpS7d04G/ttKpNv2bU1bfT4UYoChO9enxMq9Q+lU8ZGz6A
         LKHl4cC1XrYoNcjTHTDZzsz47qdVR7HBbQsIkX6jWPxEGiniXk3OMcAUkzlDU+1TPmY5
         I0CQ==
X-Gm-Message-State: ANoB5pkBqQkW5fePMb70CbY27CXGTS/is+vTdObLqViAMtL4wQXzRXta
        qIlL/7DihjGwsuv1Uq5Y20IEirVt/qDAr6HP5Z9zTA==
X-Google-Smtp-Source: AA0mqf4qntLR1waIJQmhZDzPWfM0Iq537cuh8ZJhshdLnZc/MjN2XmsoyqQP/DEzgpStD/fBH8WndN6iHCr9jK3sLZ4=
X-Received: by 2002:a9d:2aa:0:b0:66c:44be:cf1d with SMTP id
 39-20020a9d02aa000000b0066c44becf1dmr5091739otl.267.1668827843739; Fri, 18
 Nov 2022 19:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20221119003747.2615229-1-seanjc@google.com>
In-Reply-To: <20221119003747.2615229-1-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 18 Nov 2022 19:17:13 -0800
Message-ID: <CALMp9eRnS_wXZ9XXg+yvCMOCLRPrAgQPvyAz_m5Jk9DOAYXZkw@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Access @flags as a 32-bit value in __vmx_vcpu_run()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
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

On Fri, Nov 18, 2022 at 5:33 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Access @flags using 32-bit operands when saving and testing @flags for
> VMX_RUN_VMRESUME, as using 8-bit operands is unnecessarily fragile due
> to relying on VMX_RUN_VMRESUME being in bits 0-7.  The behavior of
> treating @flags a single byte is a holdover from when the param was
> "bool launched", i.e. is not deliberate.
>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
