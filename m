Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266CA746643
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGCXzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGCXzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:55:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614F113D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:55:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99342a599e9so279442066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688428543; x=1691020543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSdK1dgSw1SsTFoY2n1BvPJHJg9tmlm/zjsLZax/LHE=;
        b=YIKk2hkUEwIAbsouvS+5c3+ZWwKym376ZSAzg0gkg70GEfDkTHJwb3N0DXfmjbdf89
         Uv/wVsdyYapNJkvZbAtFyxuy2BNyoZbBT1Ptgf2TaveApq6acv2FlmV9bAJPaqBzWy8n
         YkU83lSo10d3Um1S/25b1qKis/oLlyxKEHdfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688428543; x=1691020543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSdK1dgSw1SsTFoY2n1BvPJHJg9tmlm/zjsLZax/LHE=;
        b=D8ouwGL1moLh4Ds4rNvNeknP7dBf8H5nVrov/ggFb9ZNUI86vYoYQrjWdDK9wOoO4x
         hPsT30IVtkr3wVwBJckCur+zmQEVCPRvP8g64IXEiSwcb8ikTqjtQCwI40Bf+gNVRv0a
         tCgc7+JQ+DEEOulaQh5AG4SD3VvUzn/bn6u1DEgwwgYImU4oV1Ahq8sfWPHWaioYCEad
         rzeJFZ3dE9gsqQ/4nU/7kpobBLd3HsnZBwrgbKgRMYOLM0OxbYBkEmMLgF7EmGL/22qZ
         57lgHbkfG3Q50CzdgK5YClsNe16Qaofz+bwaYScvhktxv1mpzyoXqaBcWbrPWLXmOmMK
         9NFQ==
X-Gm-Message-State: AC+VfDxVT0FL12c9SibhoG/qeSxd3etk4qD6ZRo7LW+9r1mtulvNxOKo
        cf/NCuWluJ1jb/WZY4Rua7kite04eUZcXOgY75VkFMDX
X-Google-Smtp-Source: APBJJlEuqd2o2VhkvElrRKP2/nN8dO2XDBVKGMzA262vAv49YjZNknNClKg4V+Q0XevL0AP5lXMO3Q==
X-Received: by 2002:a17:906:6a19:b0:992:462d:e2af with SMTP id qw25-20020a1709066a1900b00992462de2afmr11356663ejc.75.1688428543613;
        Mon, 03 Jul 2023 16:55:43 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id sb22-20020a170906edd600b00982a92a849asm12596369ejb.91.2023.07.03.16.55.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 16:55:43 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so6423720a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:55:42 -0700 (PDT)
X-Received: by 2002:aa7:d502:0:b0:51d:d1ca:eab9 with SMTP id
 y2-20020aa7d502000000b0051dd1caeab9mr8690475edq.32.1688428542685; Mon, 03 Jul
 2023 16:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230703113025.356682-1-arnd@kernel.org> <20230703133242.GB32152@unreal>
In-Reply-To: <20230703133242.GB32152@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 16:55:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ2S9rrz6+aVv88ct7vZjZW8O02MFxXkCUmOXcx9em6w@mail.gmail.com>
Message-ID: <CAHk-=wiJ2S9rrz6+aVv88ct7vZjZW8O02MFxXkCUmOXcx9em6w@mail.gmail.com>
Subject: Re: [PATCH] RDMA: fix INFINIBAND_USER_ACCESS dependency
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 06:32, Leon Romanovsky <leon@kernel.org> wrote:
>
> Linus, can you please apply this patch directly as it is overkill to
> send PR for one patch?

Done.

                  Linus
