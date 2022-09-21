Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA25C0463
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiIUQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIUQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:38:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351A222515
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:24:48 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1278624b7c4so9813452fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IIhmePtQyz8T33+pbjoIxj/dwgnHGLvrBq+uOaeYXY8=;
        b=U/VqAntmt8ExRWsNRYhZR0oaZfqMSxDhubxnGHZSPRrgQiW26iLuvsTs6LtUI+90KI
         MR/9+tEfV6l2HZz9PKe9QcXt27cEbSot0ICn2vHp+Scu+p4Z4fCvFnfO7cPiR7YB20w6
         ICE2BcrAD9m6xArawiTjvB6dFxpzWP+B9KTgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IIhmePtQyz8T33+pbjoIxj/dwgnHGLvrBq+uOaeYXY8=;
        b=6DcP7r9zwtOb11/irrFhzw6E7szh+a5Bb93Gk9+JUM2RZi6medXTtqk0bkl9lIP4Uw
         UA60H++2zSbCYJdUAOgtGbUi7Nn+4avSwq2CjcIf5hnKsmxcE2GX4FM9sRVGIPP2w60+
         HEiNMMO0Mdg/TB4onij86aHdhYgtDFl7VtY/FbS4x0gKVCBQvJkqBajBOBO0xnjeixKL
         aFVxFzVt3zIA6lyy7UMzpcBRif1rhmDAepK+7AhIj09o4DEAfbF4hKdfvJ0UZAxUKcK6
         GIM7Q1e4hdVf0V7gYq+Mf64CNdxWL1g7QaN4ZzYTszC/SzVaFDAGaOyuHm6dPyJwQSyr
         N/pA==
X-Gm-Message-State: ACrzQf205HMdS8U3oAgBOcET6OX8hv9O4UNsxmkJsqHWv8xYGWXZL9LI
        JiVV2CYPyoBJspBOuD3+MlDKLGROjmQN5w==
X-Google-Smtp-Source: AMsMyM55hghA/XeqLfklYfTRYiAf8kz5kPoHs4naBK0bnJ64qO2OwLvVLa5H7iC4PImq7zktLEjAtA==
X-Received: by 2002:a05:6870:f213:b0:12d:6a9d:3fb2 with SMTP id t19-20020a056870f21300b0012d6a9d3fb2mr4029264oao.78.1663777487705;
        Wed, 21 Sep 2022 09:24:47 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id t12-20020a056870e74c00b0012752d3212fsm1734295oak.53.2022.09.21.09.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 09:24:45 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id j188so8790390oih.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:24:45 -0700 (PDT)
X-Received: by 2002:a05:6808:11cf:b0:34b:8f4f:314b with SMTP id
 p15-20020a05680811cf00b0034b8f4f314bmr4299822oiv.126.1663777485133; Wed, 21
 Sep 2022 09:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
In-Reply-To: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Sep 2022 09:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com>
Message-ID: <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Optimise PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 21, 2022 at 5:53 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
> PCI SAC address trick") and its subsequent revert, this mechanism no
> longer serves its original purpose, but now only works around broken
> hardware/drivers in a way that is unfortunately too impactful to remove.

I was going to test this, since the previous version failed for me.
But it's based on linux-next, and I didn't want to fight the conflicts
(including - but not limited to - the header file being moved) so I
dropped that plan.

If you think it's worth testing on the setup that used to fail, and
you send me a version that applies on my current tree, I can do so.

               Linus
