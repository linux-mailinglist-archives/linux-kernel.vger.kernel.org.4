Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6768E5E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjBHCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBHCKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:10:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09D410AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:10:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-527ba5d5459so75137207b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 18:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dI1dLE9c0JEJEHlQtU3MKKZat0zt/lT6+w1+UkGkAE=;
        b=YZxmxsiCjTwKgEXmwcQRVkB9LyAmgXdGNaVmcI1mSK+azpNl/HdLoIo5PY0lYcoBFj
         sdgFOH4b7EdFyNoErgokiWHe2rncSI8IoRp74kh8v+zSYm3nuTShKbw81sOrlz4YvAGP
         tj6FJ9Pa/a6GUV8WBW5PsSNiLIT/x6PugFUDmS/aTBDGmbggdfUqzg4WztX+Ha/aI4v+
         vGLMmJI0lCRJpNiqZumYLQKuDZ5sAYGaTZIZcUNJPDnWQcOGv1fP2/lWfFRqNNVyK374
         GQy7Akg64bwh0xQGMwnidbfTXcmgOPAB8IiCafF6TWqKSbmtpLiF6gFztau2lYEmpoYa
         qbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dI1dLE9c0JEJEHlQtU3MKKZat0zt/lT6+w1+UkGkAE=;
        b=H2B8PU0l2rXrxE9qcR4zRnHDGK1He5sLrhcOBJijdmx+Uu62DgZr9+SaeInSgjtszt
         vK6q4WktBmIGMeSXZNK1R/UcICLHUb/HK86VyLcmRlEr+oIun9ib7buJUj7ScZgjuN72
         ++uBCsob4JgfuAfPib3VvcjqXpFDmHrGNnBBRQKgcIOiGLp4DepjGjzJ53HtN1RyrCXh
         KmFLZkj13j6YmNml0j8C3eZWeo8S9VgHzhmlPL7mzq0bjVKC1qjEYT5Gpkr8xE8zmY/M
         AcBtQozRpJUXLQfjA6drgDWiMlihFi+f0sEKVqj5M80wRCTxDjHyRRlmKIGrNe9y6U2h
         kcsg==
X-Gm-Message-State: AO0yUKW21nghwGGiIKtydlC+v4ecj4FDZx0Dr9ozC9j3jPtwwWV10Si2
        S/DlS8A+LHwIfWJqPSLBFmHVyIdDYtQ=
X-Google-Smtp-Source: AK7set9ko8ei1F48HvQladxcXhFwkQty+XkBNKk2Z7vG69UAELA8QCDoLV8nrjwwkd1gJb0P/bITYW2lfBM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d794:0:b0:509:e6b6:3491 with SMTP id
 z142-20020a0dd794000000b00509e6b63491mr711776ywd.341.1675822244973; Tue, 07
 Feb 2023 18:10:44 -0800 (PST)
Date:   Wed,  8 Feb 2023 02:07:32 +0000
In-Reply-To: <20230111183408.104491-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230111183408.104491-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <167582135970.455074.533102478332510041.b4-ty@google.com>
Subject: Re: [Patch v2] KVM: selftests: Make reclaim_period_ms input always be positive
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        bgardon@google.com, Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 10:34:08 -0800, Vipin Sharma wrote:
> reclaim_period_ms use to be positive only but the commit 0001725d0f9b
> ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
> validation") incorrectly changed it to non-negative validation.
> 
> Change validation to allow only positive input.
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Make reclaim_period_ms input always be positive
      https://github.com/kvm-x86/linux/commit/4dfd8e37fa0f

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
