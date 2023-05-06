Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B36F92CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjEFPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEFPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:43:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC010191D3
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:43:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965a68abfd4so550882866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683387808; x=1685979808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K3NrRKSl6ilP3fnwAsx1m0nufJ3hRrCfj2tW9kJ2I4=;
        b=cNHsQzXSao6X/wk9U6KihmpRMqFP2Sfqsi/L9isQaky1hkNSYdfj2+gatBunP3MVwC
         FXLtbUt8neuWVpCETu9eDbvBElbLf2EXwsbks4xEMHEQ3MJ1BPHXpkjPly0n9WRzJmZI
         Dfjr4u9V0DIfUoKNctpgvCXZu72Hvzx8ShDhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683387808; x=1685979808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K3NrRKSl6ilP3fnwAsx1m0nufJ3hRrCfj2tW9kJ2I4=;
        b=jR9cxlfDeL1upJ87AHGa7Mm6Zgu3rasWU4gWb9W1o27Clzb72EZztWN/88jRJKIjAg
         /P06PaeA1ls8FmpT9I0XT7QPUHkOpMbncgiN4FHERpmAtUuFztYAvTJXHZAwG0Arpd5U
         F0jpn4absfPtYWqq9UfV7rbSFAljQtcQz9rjze5RdmxNDsXvAN6s1IeJH+kg8DegLI27
         U6wzajPa0qZz+tPZB5O9U3paCJBulm+LPYs+0sOLLl5KRgK7A9v/QGjvu2rf1DKcIdke
         ZScQ5jMHru7wz/QOeJurD3VJMT7ey0AzCDfdbdrAYu1RRsAj1j5OL0J6R7OSoioiAqh0
         N/OQ==
X-Gm-Message-State: AC+VfDxQMGKDT8zY2c+t5D7SelCR7Z8VzMoU69iI/CKefT62QvLDzHDq
        T5Tly0d4oO+bgt212kNr8ZNMi/ljnjmpfVb9RxQF0g==
X-Google-Smtp-Source: ACHHUZ771l8Jyf7AnzC206Hgl4QMM1lV+9SwOiJmmr6YmPpkHQBskqleBX3B0xDkSViphttJlzz62w==
X-Received: by 2002:a17:907:2cc7:b0:94e:d7b0:64d4 with SMTP id hg7-20020a1709072cc700b0094ed7b064d4mr5039977ejc.47.1683387808075;
        Sat, 06 May 2023 08:43:28 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7cb5a000000b0050c03520f68sm3116446edt.71.2023.05.06.08.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 08:43:26 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so5284385a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:43:25 -0700 (PDT)
X-Received: by 2002:a17:907:74c:b0:953:37eb:7727 with SMTP id
 xc12-20020a170907074c00b0095337eb7727mr4516381ejb.43.1683387805125; Sat, 06
 May 2023 08:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 08:43:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
Message-ID: <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
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

On Sat, May 6, 2023 at 6:27=E2=80=AFAM Jacob Pan <jacob.jun.pan@linux.intel=
.com> wrote:
>
> Shared Virtual Addressing (SVA) is not immediately intuitive to people
> who work outside IOMMU subsystem, add some explanation to make it less
> opaque.

So the patch has at least two problems.

The first is that you corrupted the SPDX line.

But the second is that the change from

-       bool
+       bool "Shared Virtual Addressing"

means that now Kconfig *asks* about this thing, which was never the
intent. The other Kconfig options that need it all do a

        select IOMMU_SVA

to get it picked.

I suspect that's why it then causes errors - because now the test
robot can enable the option even in situations where it makes no sense
and doesn't work.

So no, it's not that the option needs a help entry that can be queried
at Kconfig time. It's that the option needs a name that makes sense
and isn't some random jumble of letters that is only understandable to
people who already know exactly what it is.

               Linus
