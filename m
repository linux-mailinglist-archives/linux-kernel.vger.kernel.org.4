Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAA6F9B05
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjEGSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEGSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:52:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB71311575
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 11:52:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-966287b0f72so210885466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683485557; x=1686077557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsECona4C2RMdk3QW+3sdWBFtOEdxVYIeVifcSTdEsg=;
        b=f3T3Ss59UYf1A43P0XnpjLpdzh/a4SHNSrMbQ65KI7KjixLSd+OHBp0Gu7iKCOREKK
         TQ3y6pKxYRDsui4RmRJOTIYQN2KpowovI/UEinQNlL7vGTN63/PkzuicIXJpLjgnL9is
         OlEHm6vZxizfz2V1FXJFZJptZghw9u1ndKIj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683485557; x=1686077557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsECona4C2RMdk3QW+3sdWBFtOEdxVYIeVifcSTdEsg=;
        b=M6JcBx4aOQcHTqgpylTG5USOoGXThWQ3Ray8juSjjyk+P1+b7jKwZrB6gy5kp5VkVq
         J/6LqlqOKkjjkXYnF/CfLmRWzHaXkthw9oeynHF+XmvUV0yCIu0kqfuSeLPtY/WtwPzQ
         0wRyTlyn0JVX6GRT7V/w18QRq6W+8hNea84fPmduVSyjhn65OCGC3XDV1KEvkZunGczG
         3Ta+4BOR/sCfVamB50sadbjSXUwyWdXp21yXtOoGDdcb8zippPjOrX1d/3Tbmjs4ndWS
         0klbrywiwgU4Ni+UurC/q1VfYxgSZq5YcrJY8V9v/+Hs05CGR9UJ+fCeR7RO0QNLVloW
         8Ihg==
X-Gm-Message-State: AC+VfDyc7I1SP9IpGHjnckW+Mb+xISrnJxT3kF98BeAGj4RBv7tVBAF+
        IEHT/QhDUbkVxviSuxxXHDJxbS+HXfSZOlxyyDhZaA==
X-Google-Smtp-Source: ACHHUZ7auicqhEBiYJJVwiz26sVErxIaJKHX0gPmjNSYgSuEP17HH0AIjc/z06JjikkUsGtxfeF5UA==
X-Received: by 2002:a17:907:9304:b0:94a:7716:e649 with SMTP id bu4-20020a170907930400b0094a7716e649mr6956393ejc.13.1683485557215;
        Sun, 07 May 2023 11:52:37 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090632cd00b00957dad777c1sm3952997ejk.107.2023.05.07.11.52.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 11:52:36 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-965e4be7541so496836866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 11:52:35 -0700 (PDT)
X-Received: by 2002:a17:907:7da7:b0:94f:764e:e311 with SMTP id
 oz39-20020a1709077da700b0094f764ee311mr6746310ejc.16.1683485555608; Sun, 07
 May 2023 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com> <20230506150741.2e3d2dcc@jacob-builder>
In-Reply-To: <20230506150741.2e3d2dcc@jacob-builder>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 May 2023 11:52:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
Message-ID: <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 3:03=E2=80=AFPM Jacob Pan <jacob.jun.pan@linux.intel=
.com> wrote:
>
> Right, how about IOMMU_SHARING_CPU_PGTABLE?

I think from a VM / process angle, I'd actually prefer calling the
"pasid" part just that: IOMMU_PASID.

The VM code certainly understands about address space IDs, even if
people have called them different things: normal people called them
ASID's long ago, then Intel at some pointed decided that "PCID" made
sense as a name (narrator: "no it didn't"), and then you got that
combined "PASID" thing.

Now, it may be that this then goes hand-in-hand with other IOMMU code
that isn't *about* PASID itself, but that depends on PASID's being
present, and so I'd just expect IOMMU_PASID to be one of those options
that are selected by other options.

So maybe there is some part of IOMMU_SVA that is not about PASID
itself, but I really think that the PASID code itself should just have
that CONFIG_PASID around it.

End result: from a legibility standpoint, I think it could be as
simple as having that

    config IOMMU_SVA

option have a "select IOMMU_PASID".

Then make the VM/process PASID code depend on that. Maybe the "struct
device *" stuff makes more sense under CONFIG_IOMMU_SVA, ie things
like iopf_queue_add_device() and friends.

How does that sound? Maybe those two options then always end up going
together, but even if that is the case, I think from a VM/process
standpoint it makes a lot more sense to simply have a "PASID enabled"
option. It's much more understandable in that context, while something
like "IOMMU_SVA" really is just a random jumble of letters to a VM
person.

And while the individual words in IOMMU_SHARING_CPU_PGTABLE all make
sense, it's not clear what the combination means, and why it should
have anything to do with then having an address space identifier for
it.

                  Linus
