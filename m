Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB56772A669
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjFIW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjFIW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:59:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCA30D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 15:58:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f7359a3b78so23795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 15:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686351535; x=1688943535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhSuAAYkjO4mSfTM7j2Zrn+Ge99zKCVDXuALbQ64GlM=;
        b=aWAYDSz9kYHjivc5EPQCAcnNIQ7EsxbZzXWVqRidl3AzqgBVql3teVbl5ctpRNVQBR
         ZwBStvD1xYwTCB6hcgdnP7Qh+kVAAj/vhRhdH6KOE7mVRHzIsC5jWQxqmQ06LdBhp5Mo
         wDECzvNZeUvBgN3BgXU2RiU3qpl85v5XshXPq7sSEZAFXH+7ToDeQJ/3kwIYzE1UeIq1
         uB4TAPqNKbW3e09X+80Nfq6HWYvhGp5+mcD92iwq0TUepbI425D+SlrIhSBJv64+0gBw
         U3UpYfN+g5pDsGTtgWaWmCTkXoqCdaWFc6IgRzHUbsPDr7ZwmcRy9SU96i5ZC6VdO6+v
         B8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686351535; x=1688943535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhSuAAYkjO4mSfTM7j2Zrn+Ge99zKCVDXuALbQ64GlM=;
        b=MEeejMfW+PukpuZ4JJ5ZH5GvYFBg8aKFA9WP3yvarqMki+6rP+4z2Y+Vte6T4CWbVQ
         Sy8Mw0uxZ6iABKG0p2F1xV2A6vAiAlHrljIA8BLWVWMcdySUmA/zUxCRi/LhsjJx2+8T
         KI+2I7nY9MkjcKGjp9OztZlxTo0QcPj4KqyNEKuassynEXsXCvLdcTEuBXuMWYMHS2tn
         z31vMO3P9E7XFnT3MHgMeSzPy8z8z+hQuwlzZwfEjHh5lEudnY2+fYkphHr2qf10MEPe
         ldWOeltmp5NRK9g7Vjn3HuDtMGocirOEYewB4zGMRD9X8gkINYISS+WL6LF0MqU1Z/cs
         znWg==
X-Gm-Message-State: AC+VfDzKff2NNPkcXpA4VyWG9iA0m8G5TmojCp18xJGq6UURc6Nckg1i
        naWh+okOAOYXAX/DcvAQrf36ISOer6Xl7P416QXrCWQv+kP69q2j7DYPSrtG
X-Google-Smtp-Source: ACHHUZ6tFSQ3jSKz6Gn6QifMsxKaOHFdz2lMG9AU9FIAwd4NiFOYvnPz9hTFf3gOv0EaPRSzfnvu1VJ8Vby/ABDofdg=
X-Received: by 2002:a05:600c:46c6:b0:3f7:e59f:2183 with SMTP id
 q6-20020a05600c46c600b003f7e59f2183mr26384wmo.5.1686351535398; Fri, 09 Jun
 2023 15:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230608220558.39094-1-ctshao@google.com> <20230608220558.39094-4-ctshao@google.com>
 <878rctnkqg.wl-maz@kernel.org>
In-Reply-To: <878rctnkqg.wl-maz@kernel.org>
From:   Chun-Tse Shao <ctshao@google.com>
Date:   Fri, 9 Jun 2023 15:58:44 -0700
Message-ID: <CAJpZYjVcDAU94Abx7BUV-nZeTJ88ggYs=n8gBUyRUGQ=iQWPvw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] KVM: arm64: Using rcu_read_lock() for kvm_pgtable_stage2_mkyoung()
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, yuzhao@google.com,
        oliver.upton@linux.dev, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ben Gardon <bgardon@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:44=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 08 Jun 2023 23:05:41 +0100,
> Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > Access bit is RCU safe and can be set without taking kvm->mmu_lock().
>
> Please explain why. What happens when the page tables are *not* RCU
> controlled, such as in the pKVM case?
>
> > Replacing existing kvm->mmu_lock() with rcu_read_lock() for better
> > performance.
>
> Please define "better performance", quote workloads, figures, HW setup
> and point to a reproducer. Please add a cover letter to your patch
> series explaining the context this happens in.

Thanks for the suggestion, we are currently working on the performance
test in parallel and will update after gathering more data.

>
> Also, I'm getting increasingly annoyed by the lack of coordination
> between seamingly overlapping patch series (this, Yu's, Anish's and
> Vipin's), all from a single company.
>
> Surely you can talk to each other and devise a coordinated approach?

Sure, I will start internal meeting as needed.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
CT
