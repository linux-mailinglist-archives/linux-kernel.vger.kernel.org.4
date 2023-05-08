Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9C6FB5D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEHRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjEHRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:18:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E06A6A71
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:18:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965d2749e2eso631516166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683566291; x=1686158291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPLrilJOpAfCtWH73NaWni8pY2sG/Rz0VNe7OUxyQPg=;
        b=QBa5klLYRx6s5xUdv17wPOIXHSVMOnDCRRV+kMDzkp10mpOn414lUE7CKd2DD5xOlG
         TEDhSJgzAMKYbKS0U31N33AjJY6Yiwr0vbD2vo93Z1FHmSMqjtWDTXsrR4Jnoq2ooFvj
         v5sCzUMeR+r8Gj8N3ozf7y2nYwYqTJ44YIFS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566291; x=1686158291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPLrilJOpAfCtWH73NaWni8pY2sG/Rz0VNe7OUxyQPg=;
        b=KKHYxEIj0gHd1Mq52PSE6m0k2MkEk9S5AU2ec0fW9bWy8orjYmayPvXOG8UJGahTw5
         maQrTceHa6/aZAs8yq+n2A+OyeDhjd2RQAkdrxE6yJag66HeBOoXy/kbCWUORw2/sgk5
         FnhQbu/x+iwNJd3nDYZLaKbafs9SxrOqAdklasPHYkmUf0cOrWFJ47n59DTcIkPNWuJ+
         ukZCvKokE7nhihNZBr4UDcTGBTrroXF50RcCv2kc8/zdEyoJ5uCYOKqBbW9bWS9DfItW
         vN1AB1nZPVEPfYygGglLhfPzHs/mF+SmXtIFUWRfh+4696dOy3EcF57hBKvbJHFy0NE+
         hyNw==
X-Gm-Message-State: AC+VfDyZ4oiUs1OlfDSkmVergl0029AVf6FcJETQVsCNniv9jKh9yiLN
        Iuy4S3QlvwqLwllXjIisa1aAyDWFSKOaK5ge+gh1xA==
X-Google-Smtp-Source: ACHHUZ4Ul6gx/73kWBmqSBe7N/AkNAeoQZzcp6jY1Q6sIoA5Lmz61QLa12x3ajFMZ6s/MW9MUVsP8Q==
X-Received: by 2002:a17:907:5ca:b0:965:6cb9:b768 with SMTP id wg10-20020a17090705ca00b009656cb9b768mr7747964ejb.31.1683566291589;
        Mon, 08 May 2023 10:18:11 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170907761a00b0096629607bb2sm213746ejc.98.2023.05.08.10.18.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:18:11 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so7648165a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:18:10 -0700 (PDT)
X-Received: by 2002:a17:907:2cc4:b0:94f:3338:12a2 with SMTP id
 hg4-20020a1709072cc400b0094f333812a2mr9978465ejc.33.1683566290229; Mon, 08
 May 2023 10:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder> <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder> <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
 <ZFkpk8y8mUZuZjkV@nvidia.com>
In-Reply-To: <ZFkpk8y8mUZuZjkV@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 May 2023 10:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Message-ID: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
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

On Mon, May 8, 2023 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> CONFIG_IOMMU_MM_PASID perhaps? Says what it does without a clue about
> why it does it. x86 arch code could select it ideally?

Maybe we don't even need the "IOMMU" part. It's a core x86
architecture feature. Maybe it usually (always?) gets used within the
framework of some IOMMU work, but I guess ENCQCMD could be used in
some hardwired way even without that (ie is it possible to have just
some "basic PASID set up by VMM environment" thing?)

I don't actually know who uses it and how, so I'm probably not the
right person to name it, but just looking at the x86 code that sets
it, the PASID code technically has no connection to any iommu code,
it's literally a core CPU feature with an MSR and some magic faulting
thing, and seems to be possibly usable as-is.

That existing

    #ifdef CONFIG_IOMMU_SVA

in the x86 traps.c code just looks odd, and making it be
CONFIG_IOMMU_MM_PASID sounds better to me. I'm just not sure about the
"IOMMU" part either. Just "MM_PASID"?

That said, the arm-smmu-v3-sva.c code clearly *also* uses pasid,
except it seems to really want to call it "ssid".

So "having a per-mm ASID for IO" is clearly a common feature. But
naming seems hard, with x86 calling it PASID, arm64 seemingly calling
it "SSID".

Right now the only user *does* seem to be through the IOMMU SVA code,
but that may or may not be fundamental.

Now, "SSID" is a completely horrible name, as I immediately realized
when I tried to google for it. So arm64 is just wrong, and we're most
definitely continuing to call it PASID.

I'd lean towards just "CONFIG_MM_PASID" or something, but at some
point this is bikeshedding, and I don't know about any possible
non-iommu direct uses?

           Linus
