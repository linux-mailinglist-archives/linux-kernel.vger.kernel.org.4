Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF75F3D87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJDH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJDH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:56:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50702CC86
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:56:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f1so9586373ejw.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=AnRaD8cZwZzUZYQwQncZ2kdHEdAMidRcvswvYT/oaDE=;
        b=wtDLPKC1lldsUJFHyjlMtUK0XxjA2RyhxCSjdiHY038DvaVqB1moZnXrhzHZLsT/QV
         wwGoF2/zwQ1w5UaRBuQsAQj1dt1fl4/SZXp9ixgA7tSQNuL4vc0QObCToeV0V4QDhKOJ
         MKBCa1VpM8ZKIhrkJYggvJwlbsDt8jZfifBBg8LG88rbW5grJvhaNPEoQfFHNg86MVnr
         vJTtHWym5l1CV+yhcCBvpy10294q3nXwwixQpGuuqpYCDz5enq3ahwJRfBzcA67mXNIz
         Tt3f4VlTFPOLSK+1Nor3r28XSY/z1xUURUPBOtGK7y8GIvx+3YBDwp7jyvNVXqGciHuc
         yeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AnRaD8cZwZzUZYQwQncZ2kdHEdAMidRcvswvYT/oaDE=;
        b=DGfeBoPJCS99f2mGl7WSAW5I/Lv2ogJ3P3GvighmTmt7hsUV4r2YUKbXN/xYzFP9+T
         yeqwzRTOd4sJ4tXNsbMGfsJqMWx4Cqayw2JDYj2x9m8+UFRVfsXAZ56M5vqZxJPw/Ykn
         LEHdLgaxC8KgShVgOcE1+f/xwy4izkUtI4EVGWWhZH7BDnqYsGaS/J7iO7lg7X4S2eGN
         osideQhe9fyF47VqkRQIjVYxnPJHrY49Abh6VHH2pGB1HyZ9Mwks5e4Y6hPRG629VfCl
         9QpkX1Vf2lPXkOE2H+7BXJhirAw7OWqbCHOFwht9YgIo9YzB5K/neRDURABswXOf9ulI
         wAUw==
X-Gm-Message-State: ACrzQf0RBJLgvdD+pxAm54O3v5h//fdNp6F/P54Eb/KuE2Shdl95ZVh2
        fhPYjsCa6OOMg+KZRKH+kD+ytFH6Pp2SFuyGAtOMIp9yeRA=
X-Google-Smtp-Source: AMsMyM7bQDbG7SjnKLzK/O4QQzgSckuGKQ95AS4C9dLpwWU5GtjJieo6d/bvFO3Uz0GDkn1dtH/8FdizJ+0v85r4zWo=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr18154143ejc.440.1664870189177; Tue, 04
 Oct 2022 00:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220928122539.15116-1-pali@kernel.org>
In-Reply-To: <20220928122539.15116-1-pali@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:56:18 +0200
Message-ID: <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 2:25 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() macro f=
or
> accessing PCI config space.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

I have no way to evaluate this change in my head, once the kernel test robo=
t is
happy I can test the patch on IXP4xx.

Yours,
Linus Walleij
