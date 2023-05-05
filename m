Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F66F8A08
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjEEUKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEEUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:10:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D2110
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:10:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso390636066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683317449; x=1685909449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ntx9kUf7coInpGr8/n+akUF1hqzZ8aZiwMO9QZmnpQA=;
        b=UiTt2cXGgNc4ozOmAct2VvdRD/943At/akt3JQrDQQ0Y92EZH5OlYDeN0SG+b6vPNJ
         c52mRmyAfPlRbgejI+ogXfkrIhgPiAofkV+qaIbrW30CZNjLjVZG9Abm8pMG1FK6RUoJ
         7ZV/W4z4PBErA4w8v+c7NGRNmqabvX6TOh+wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683317449; x=1685909449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ntx9kUf7coInpGr8/n+akUF1hqzZ8aZiwMO9QZmnpQA=;
        b=jjWVCShwrBKiTU/fJfxx0zxgLvxg7ZnqRn2Tp7JK0QmvYPCt3J3llOzoZNHskNbIpJ
         ENYHOXdwQK2pMHmfUZOYB+HcjLyFyKzNFOJhBRJ4isqdKSMrJoT2NGwDx5pRXo+rKenN
         PYhAPP7qJFPQGBz8rAIXl2L4qMHt6LtA4jmxPhQLLGBYc6UxYAIQQMjaixOTRwXOGu57
         CC0n8fUOB1H4jF1EBM3vAr/06hkN/fqkRHwPMFF+UE293QrSejBcY2MKB9QNao+/JGaG
         6aRMU1QIo82LLQQGH7PfQ9Pf0SHbXu+ML/rljYCowYGdeLjxmWYwQKPV3Fln5wbyQhvg
         NT3w==
X-Gm-Message-State: AC+VfDyRg9GPGEEtuk5hOIjADtegQOp99YdF5ShotHtomOjOpMeF7HzQ
        S0MkSqdKiED6y6pMPXoRRQt+WX7X2e1HfyzwNCnlQA==
X-Google-Smtp-Source: ACHHUZ6nBv2+vPqtBLolgrUtvI/l/hG7V0ADzUtqPMPBBqdyp+HRU2GZi/wsKXxs5/L1NBHtyUDomA==
X-Received: by 2002:a17:906:ef0e:b0:965:c2ab:7014 with SMTP id f14-20020a170906ef0e00b00965c2ab7014mr2143042ejs.35.1683317448802;
        Fri, 05 May 2023 13:10:48 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id jz19-20020a17090775f300b00965c6c63ea3sm1330962ejc.35.2023.05.05.13.10.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:10:48 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso4245125a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:10:48 -0700 (PDT)
X-Received: by 2002:a17:907:7e9c:b0:94e:afa6:299f with SMTP id
 qb28-20020a1709077e9c00b0094eafa6299fmr2387046ejc.22.1683317447827; Fri, 05
 May 2023 13:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org> <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
 <ZFUMja5MpRPWCRXw@8bytes.org> <CAHk-=wjW4CzM9YZqwB3jU9mt7FKdctLWAbOcBQAwJ0_2eRmP=g@mail.gmail.com>
 <ZFVfncB76TrB+c4K@ziepe.ca>
In-Reply-To: <ZFVfncB76TrB+c4K@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 13:10:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvonKjgyY1-Mc9POg1euT68wX3Z5+wqBckN+_j=pOaAw@mail.gmail.com>
Message-ID: <CAHk-=wjvonKjgyY1-Mc9POg1euT68wX3Z5+wqBckN+_j=pOaAw@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 12:57=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> At least with the current situation CONFIG_INTEL_ENQCMD might be an
> appropriate name, split out from the IOMMU kconfig and put in arch
> kconfig?

That would at least somewhat clarify the use. I find IOMMU_SVA to be a
particularly opaque name.

Admittedly I probably find it opaque because I come at it as somebody
much more familiar with the MM side, not from the IOMMU side (and the
_other_ conditional fields there make sense from that standpoint), but
even so I think it would be good to clarify.

Of course, making clear it's architecture-specific would also be an
argument for having an actual architecture-specific part of 'struct
mm_struct' (the same way we have 'struct thread_info' in task_struct),
but with only one single field I suspect that's just not worth it.

And who knows - maybe other architectures will pick something like this up?

But yes, it might be good to really pin down what the rules are. Right
now IOMMU_SVA has *no* real help-text (there's a comment saying "#
Shared Virtual Addressing"), and is also enabled by ARM_SMMU_V3_SVA,
which apparently doesn't actually want pasid support at all.

I dunno. I don't think this is a huge deal, but it did cause some
confusion during the merge.

                 Linus
