Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF86F2A91
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjD3UIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjD3UII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:08:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90710CE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:08:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc34b98edso1084645a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682885283; x=1685477283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAT/2iwDABQLtvre5aF/VZoih+/bS832V3Wecs87BJg=;
        b=L5mpwGfOFJz6YY/vGsnF4UITWfh+2BWeOEBTOsyKP2AIAruKAzlw0xc7u6MT1ayRpU
         4vcYy6VXBmOLkohuxRI6N1zNfDGUJbE5n6LjPOsn0zoovS5fAiSjBGSFaJ7I/lZJ1f74
         7hiAtZjnfDUhgj7XZj4tr6doEiZBnwV5lKeac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682885283; x=1685477283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAT/2iwDABQLtvre5aF/VZoih+/bS832V3Wecs87BJg=;
        b=c2iq6pPkfiLqQz7Ir7JQ5G337HsJG4MqgeZooNHNHJEpG/IQ6x9nh6nmqlfLMWVc0n
         6vPEXhKD6HxC0u66rAjLn66giffk8s+BCe4BYuTkaeR4idyUZi1kIPr1UKSvfiKgGsCx
         B0SiTLmkW7z13r2QZWbARMR03k+0lKRf9RoV3hkLXXOp3z+ZgWgB/xr3k2kuQKVkEhwW
         YMTqAlKbHQGqv5gSRclvw5AFQCjh2Loh3deDiMp4f5r+HvRnrZva8sIGQ2O2UxHtrqiq
         bxDALr4XSOaWN5DyLKCegBRSvR45gXPmQtxG/WseUmuwiMu7i0end4z4hv13BhgbbHEK
         aESA==
X-Gm-Message-State: AC+VfDzenkjWfUWjXe32DZhgCeEsaYi+OXLtVnlZ43tn546A9qukpRdO
        kpmL6tql6OO/+Ko/15PRUHF1GvcGhcB0L8DBfov6uw==
X-Google-Smtp-Source: ACHHUZ6Y25tA+ljpDirThzeZOMFXr4WP5cW+fFq8aM7CqphkrDl7KyJRgoBPL3KkEIqC13LuOJjvFg==
X-Received: by 2002:a05:6402:47:b0:509:c10d:b53d with SMTP id f7-20020a056402004700b00509c10db53dmr4121131edu.23.1682885283386;
        Sun, 30 Apr 2023 13:08:03 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d22-20020aa7d696000000b00504a7deefd6sm11524040edr.7.2023.04.30.13.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 13:08:02 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-953343581a4so272253566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:08:02 -0700 (PDT)
X-Received: by 2002:a17:906:9c82:b0:957:862a:9e6e with SMTP id
 fj2-20020a1709069c8200b00957862a9e6emr13699469ejc.73.1682885282026; Sun, 30
 Apr 2023 13:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
In-Reply-To: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Apr 2023 13:07:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
Message-ID: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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

On Sun, Apr 30, 2023 at 4:13=E2=80=AFAM Joerg Roedel <joro@8bytes.org> wrot=
e:
>
> this pull-request is somewhat messier than usual because it has a lot of
> conflicts with your tree. I resolved them in a test-merge and sorted it o=
ut
> for you to compare your solution to mine (mine is also mostly similar to
> the one in linux-next).

Your resolution is different from mine.

Some of it is just white-space differences etc, but some of it is meaningfu=
l.

For example, you have

                if (mm->pasid < min || mm->pasid >=3D max)

in your iommu_sva_alloc_pasid(), which seems to have undone the change
in commit 4e14176ab13f ("iommu/sva: Stop using ioasid_set for SVA"),
which changed it to check for

           .. mm->pasid > max)

instead (which seems also consistent with what ida_alloc_range() does:
'max' is inclusive).

You also seem to have kept the deleted <linux/ioasid.h> header file.

I'm also a bit unsure about what the intent with mm_valid_pasid() is.
In commit cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")
that helper (under the previous name) got moved to a different header
file, but in the process it also got done unconditionally as

  static inline bool pasid_valid(ioasid_t ioasid)
  {
         return ioasid !=3D INVALID_IOASID;
  }

and didn't have a "ioasid is disabled in the config, so have an
alternate helper that always returns false".

But in your merge, you ended up splitting it into two versions again.

I don't think that's technically the "right" merge (it basically
changes things wrt the two branches), but I do think it's nicer.

So I edited my merge to follow that lead.

Finally, I'm not happy with the Kconfig situation here. Commit
99b5726b4423 ("iommu: Remove ioasid infrastructure") removed
CONFIG_IOASID, but left the

        select IOASID

in the 'config INTEL_IOMMU' Kconfig case. I removed that as dead, but
now we have that

        select IOMMU_SVA

in the 'config INTEL_IOMMU_SVM' case instead. So it's a very different
Kconfig setup.

Anyway, I'm not super-happy with how this all turned out. The example
merge seems to be wrong, and the Kconfig situation is confusing.

Somebody should double-check my result, in other words.

                Linus
