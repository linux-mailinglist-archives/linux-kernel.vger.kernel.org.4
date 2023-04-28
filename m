Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71CC6F19F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjD1NtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbjD1NtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:49:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA11FEB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:49:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso7942497276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682689748; x=1685281748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K1hIAJ3PDs1STD5Nf5EOLfCuqukCGdV5NWCw8Nh61NE=;
        b=f3+M7QDLI2K3jtQKfqNELdarX3fK2oxPoOnWILM3KM+kk/9ndNXsaH8G0Tq2fIon1k
         lscXXpxJfHhxZVJ756aRWAUl2uKFfaBBccBkxMukat/IgzIMi49CwVd9kyPf39VnX6z5
         8soeywYZ6HvEirTn/Qu0bQ9bt2NCVZYCMsDGhwbzv5bdUUTng5abmcUZOgGi6XUgwW4F
         nvjF4onfIXm7+rK+HgvEICQocWjQaAfZVl/hN3wAil7RUq2cMDnLIUFu/45OPvPbeR+R
         fZ+dEFnacgszupM2mF/H4X6nBsNg4cG1pIs0PprvKCNf1WhHB50fou5fy2LP0IDO3970
         MS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682689748; x=1685281748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1hIAJ3PDs1STD5Nf5EOLfCuqukCGdV5NWCw8Nh61NE=;
        b=M4q9r5YuY9zqXzB25za+JCzrfxAeP4ym8X/ygA/7FsiZI05MDB6im/Srdyn843QH0Y
         Xe7cEsgJZLeCWa4zU1yEckWznDAkIJteDoMSTN3o7y3kfxpFEqXzJ8Ht2Q1MVBZv6MWz
         TWo/mM/CiOgMptQGFfFZ/UBEdtEMRouze5t4rsaBAByPOAE21AYYVDaS5/Ysv++rBoPA
         zWSXdkcMSVBqbQPaWHXnTAf4I9RXisHH7fmx4DQQs1hoWMqmNlYv0iDMOlC76FKDpTsi
         Rl3Yvz73bwHHn4MdFJ2O0kA6GkNBGSABQQPt6rx2OG5N4Y7uea1MI4AXelMuvQkDUeN/
         NcLQ==
X-Gm-Message-State: AC+VfDwOI4Hc91vu7suoU+VeQQDekwoJk39WIQySHuwh4VwNHLokoJEo
        37mGfuE3MgA3+DIq8twogBI8BtHszvlx41+tz2wcTA==
X-Google-Smtp-Source: ACHHUZ508x2WD1jBRaH4gJwp/r4tHTq2TpEEorzeTmIyqrBXR0wvHIDDbxq7i6hmjQN14qjhYXF9mp1hen2Dor5rac4=
X-Received: by 2002:a25:2843:0:b0:b9a:38b2:8067 with SMTP id
 o64-20020a252843000000b00b9a38b28067mr3442325ybo.12.1682689748091; Fri, 28
 Apr 2023 06:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230424112313.3408363-1-glider@google.com> <6446ad55.170a0220.c82cd.cedc@mx.google.com>
In-Reply-To: <6446ad55.170a0220.c82cd.cedc@mx.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 28 Apr 2023 15:48:28 +0200
Message-ID: <CAG_fn=UzQ-jnQrxzvLE6EV37zSVCOGPmsVTxyfp1wXzBir4vAg@mail.gmail.com>
Subject: Re: [PATCH] string: use __builtin_memcpy() in strlcpy/strlcat
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, andy@kernel.org,
        ndesaulniers@google.com, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I *think* this isn't a problem for CONFIG_FORTIFY, since these will be
> replaced and checked separately -- but it still seems strange that you
> need to explicitly use __builtin_memcpy.
>
> Does this end up changing fortify coverage?

Is fortify relevant here? Note that the whole file is compiled with
__NO_FORTIFY.
