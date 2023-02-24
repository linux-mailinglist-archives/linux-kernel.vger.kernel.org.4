Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21536A24EA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBXXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXXOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:14:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5258B17161
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:14:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d30so3473963eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDST2wkPRWvHQ65nOtR6NGENXRjzl9toU3LAW8CGWC4=;
        b=CyDDFTt/F3/H13vGxJ3s6LwCojFc9mpfq17dldA6sEdum7g624H4R0/TVod34xyoHV
         SlhlxV/4VNMr6VdCjFsAxcV9WeVp3/5AgPek1VC/0fQFV2gORxj7n5mQ+ikq5wjNjjF3
         dAXFLPG/o7wtN6HbK645i2DBtB5EXJBeFbQzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDST2wkPRWvHQ65nOtR6NGENXRjzl9toU3LAW8CGWC4=;
        b=vU4fLGpUh0GiKCJqAalkplKqU4QVlAbW5uQXpvRc91ET6bphtoZWi33Lrn4IWGNl6A
         1dGw6kS60FvmQMmkCJ7DDcwpQ7B19hj4jOouzsEdJE5amgf+MPAhJ6mxw97ogdCZyZMS
         7oEmquL3DKAvnIzMkT3iT4iudPoJgxkmYbhj9symBK6xXHvQ/6gFpNv3B82tS9wNWAgb
         90iN+A8wLvbK2wEbxmRr1oGO1R9zu7xJ0X/XnNRASMwLK0AuGrdNCoCCdb+V4LdNkek1
         OW5bIP88aSl4aCqlbvPmQRW3aU6ku13W/pL0zlILh0423JBwyYBJyrNn2EchDrbCEzao
         wqyQ==
X-Gm-Message-State: AO0yUKWAUmu1oFJeufguix3w7Q7fxXJXVAErDcayLkTEurvPHzVMMiMV
        3WY5oVMNp6vmZq2etl0+j+qFFnPKou86z2QtZwkt5Q==
X-Google-Smtp-Source: AK7set/vO3zysQjUkFNyxek4xJo6n5YPr0n4cNSw6p0YxzzI0JWdyEx87OTzNnf38LsZGM3b+n/NRQ==
X-Received: by 2002:a17:907:3fa0:b0:8b1:2d7f:ed57 with SMTP id hr32-20020a1709073fa000b008b12d7fed57mr30092065ejc.42.1677280479628;
        Fri, 24 Feb 2023 15:14:39 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id r4-20020a50c004000000b004af6f37d25bsm232184edb.76.2023.02.24.15.14.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 15:14:39 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id s26so3320780edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:14:38 -0800 (PST)
X-Received: by 2002:a50:f694:0:b0:4ad:6d57:4e16 with SMTP id
 d20-20020a50f694000000b004ad6d574e16mr8362677edn.5.1677280478558; Fri, 24 Feb
 2023 15:14:38 -0800 (PST)
MIME-Version: 1.0
References: <Y/SGAafMEGBn4fWy@8bytes.org> <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
 <Y/k1pGjjRIznCIu2@8bytes.org>
In-Reply-To: <Y/k1pGjjRIznCIu2@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 15:14:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
Message-ID: <CAHk-=wg__gUh4gSVzCJqoCFMDiiQRDRuBaX=Yhra3=mxb7uSHA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 2:09 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> Aside from the conflicts with upstream, which I resolved in the merge
> commit, the only other conflict that Stephen reported for linux-next was
> in the rdma tree, iirc. So fingers crossed that this is the only one.

I suspect you mean rpmsg, not rdma. Because I just pulled the latter
with no conflicts that I can tell.

            Linus
