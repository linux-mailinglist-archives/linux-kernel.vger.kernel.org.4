Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B706DF522
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDLMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:25:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ACB6EB4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:25:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e127so11452294ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681302347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzEJi/6tk5pX3rvqtM/K9Qaj9JOxZrENkpR1kkXBZPQ=;
        b=kDnPZlvLJSZYe+hwhFyhgyU32uWIOLpQi4A56nIKAoa1TeQBve/7lDXHLvTG784CeG
         Vum5wVuUUHMtNCC1+3G7ULX+l+U2e1rqxjktNitrhPFLIefGdDKOWeFxPtUJlWhqziSF
         tmmTtW958l3xW8+nIS4PXrh2a6TRG0Sxl3uM0oe31mOXB7XZp1Qr7ZSJLRp7g5YJWv9W
         d3heyP/d2SdvPwRDEK4oC9Mk3ZXw9UP0LYH8UJrYaL5qlatHEbSsCjj4IDeoJmI9QgX3
         XujJ4E/VnJeLq6vts00w8m9WN/kRTEfTMhPpCR77OIOStX3OVqYl7X+bjatx+AILlp80
         n3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzEJi/6tk5pX3rvqtM/K9Qaj9JOxZrENkpR1kkXBZPQ=;
        b=nU/KChOyYTpzSgSUIqgC32n0TGqyH2h2NuEh3GifxATYvhv6Uy4Y9TriCxSjrwrKgs
         XGHDV8VKvtgF5eZXMkgX2dSDkhqYcMRcYzS7K0ZjihgY4c31gpNNxmOXF8QvB0IzbSMe
         9nBMJ9mONnioQjrKnkFS31xPn2y/9Y7cUINp43OK+Zy4fLELaWxEMn2SJq/OcQDNtDqT
         HkJBkgq04cDx/WowEabLt1WHmk+GclTFZtH9LLHlzTe94zE2IPQmgMe/KMr7wjffi+6M
         tGPPbuJgrTQKMs6kxo/kJ74ut4HivFQD+x8aOIK7S1P0O+638GsIblkESah3AcKY5Fae
         o4lA==
X-Gm-Message-State: AAQBX9eoFpu/SXYlFkrGp81VKb3vufTlgxBGTcCHmbBlVLUrjbnyX+0u
        y/EFOOCb66Ml6rOqdZlXbmrfrB/4hNMOziX62H6H+w==
X-Google-Smtp-Source: AKy350Z57GqlLPmgNyWi6f+oWxoeGVJGf2h3wEN6OCQUkS1SjB47iWQWadUytlSXX6mM/d+2zS38SfwgnSiHTAw2iZI=
X-Received: by 2002:a25:7347:0:b0:b8f:892:3967 with SMTP id
 o68-20020a257347000000b00b8f08923967mr4301303ybc.4.1681302347611; Wed, 12 Apr
 2023 05:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkda8qTuCmF_RDjtp26k_DMpME=0wAPjejh4ODkUr9SxVqg@mail.gmail.com>
 <20230412024406.62187-1-haibo.li@mediatek.com>
In-Reply-To: <20230412024406.62187-1-haibo.li@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Apr 2023 14:25:36 +0200
Message-ID: <CACRpkdaYcdjkXpUZywK=oyFQdp0FWeD2sjz2ZrSYtjrBo6u+sw@mail.gmail.com>
Subject: Re: [PATCH] ARM:unwind:fix unwind abort for uleb128 case
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     a.anurag@samsung.com, alexander.sverdlin@nokia.com,
        angelogioacchino.delregno@collabora.com, ardb@kernel.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux@armlinux.org.uk, matthias.bgg@gmail.com,
        rmk+kernel@armlinux.org.uk, xiaoming.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 4:44=E2=80=AFAM Haibo Li <haibo.li@mediatek.com> wr=
ote:

> > Since we're decoding a 32 bit unsigned long maybe break the loop after =
max
> > 5 bytes (35 bits)? Or are we sure this will not happen?

> in case of some corrupted memory containing say 0xff 0xff 0xff ...,the lo=
op breaks after
> max 4 bytes(decode as max 28 bits)

You're obviously right, I must have been too tired to understand the
=3D=3Dsizeof() break;

Thanks!
Linus Walleij
