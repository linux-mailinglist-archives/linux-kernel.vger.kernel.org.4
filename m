Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEE6FB567
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjEHQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjEHQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:42:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DF6E9E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:42:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso8688250a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683564156; x=1686156156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR27B1v/nsW7Z6zgeZwIrFb522oCHrgCRwmb//arvhc=;
        b=EpcLZ1oQJ8+aC840qc2t2HuiudFqTZCzbaYTdFJ7JBgQ1kNQfz852Ia2VJFQUgSEu6
         hCfFehWELMbroXf50TOnh1EKtJPnAuRSynrXDR8W91NXzDHziU36RefH7JPh4JH9Nz8x
         GqOvXpT1bSuiR11UuG3kFvE8U7MJDEWngNqpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564156; x=1686156156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR27B1v/nsW7Z6zgeZwIrFb522oCHrgCRwmb//arvhc=;
        b=apT//QWd5lsCaCcu3LtbFdgx0PfrV7V+ywbDxFx+SvVUf/hMIdsPqRJfUysBYfJ8QI
         pVTEINDxlIRCIBA7nc6ngVX96ieZATNpXY/2P2m+v4GoxPfHMkjvTBG/kM201V/+9ZHI
         +rX/5T8hV1/thVSFVqHX1mk3ZOChNbBSZ+/w+Zo+W2oCyg105+OkvIBsidU6dl9C2OTz
         5j5g7D5MJLEHS1pc+AP885aV9xbBeKVlMXVJJ1EFaionEmcOFTdjfYUQgk7GvcPlS+5O
         VhdiSKAMQO7koK9M53arGsTF+8o4iRVv65nGDrQqFztsQ4eDSZ7VyowC8VoqMbYqG6V2
         F4Hg==
X-Gm-Message-State: AC+VfDxGAycla70AcFSKWmJV5JNLArjv4UzKBJsP/xpVpfrEbo0vgEhz
        5GJVesyV19bpK3/XkolJghXtZoSWu/mOYZzrPU/NiQ==
X-Google-Smtp-Source: ACHHUZ6ba7bqxn22mCODIiuTYyys3xPmzF0LKoMkIdzzr//6mCRs7yg1s1fQf2Hq6WEVIdOPYEc75A==
X-Received: by 2002:a17:906:4784:b0:94f:7486:85a7 with SMTP id cw4-20020a170906478400b0094f748685a7mr10362300ejc.31.1683564156290;
        Mon, 08 May 2023 09:42:36 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id i24-20020a1709067a5800b00965aee5be9asm171130ejo.170.2023.05.08.09.42.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:42:35 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94a34a14a54so951882066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:42:35 -0700 (PDT)
X-Received: by 2002:a17:907:842:b0:94e:c8c:42ec with SMTP id
 ww2-20020a170907084200b0094e0c8c42ecmr9098645ejb.20.1683564154924; Mon, 08
 May 2023 09:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder> <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder>
In-Reply-To: <20230508094014.53913cf3@jacob-builder>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 May 2023 09:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
Message-ID: <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
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
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
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

On Mon, May 8, 2023 at 9:35=E2=80=AFAM Jacob Pan <jacob.jun.pan@linux.intel=
.com> wrote:
>
> Conversely, we could also have some part of PASID that is not about SVA.

If that's the case, then we should *definitely* have that IOMMU_PASID
kind of config option.

Then IOMMU_SVA - that needs PASID - can "select" it, but any other use
- that doesn't bother about SVA but might want PASID for its own
nefarious purposes - can also select it.

This is why we have config options. Not just for legibility, but also
for "there are different scenarios".

                Linus
