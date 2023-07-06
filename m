Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E987674A389
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGFSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGFSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:02:38 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9861995
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:02:37 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso1176367276.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688666556; x=1691258556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp1EjdfHH9ncfytaq28XNjejcIMtxhJK6i4hsIXtgIA=;
        b=EmlH79ozm2XgthEqgBNVDrr2M9UVj+56g2QJxcexPnshrwIa94OTVYqHURw0LsOQOi
         dnz3xfKGqeZt7NstoTNHyEygGHkEvfbQUh5ER8c+jQQ4jG+uQxfnk6r+Yh5O0HCJCIPM
         ESiJNiIpRUsyizu7/KtHsmd+5hEucwHO/KUpmrcxJNsS7MyRMlPspbff5r3QIl4eXZd5
         UsnGupp9DU5vFXmWo03i7s8uCVckMCGoGxaKXinKu8Tbxuql4apgDJ41NVxX2Hn1v6Vh
         YmzIUzM30vCa5vMfdk3jywRZXrUaKdnsFrX0OS/E3B7dES3f+n8Ss7IRtadEy1jnLoVQ
         xkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666556; x=1691258556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp1EjdfHH9ncfytaq28XNjejcIMtxhJK6i4hsIXtgIA=;
        b=ldIAdmPFZE7D0qKi4qs8kuAzWyXN1ovJTokzAfUsWFbwFUG2+NRbUQzIOs85HaWSTl
         +zdAK/uQQzI5MPRrqHgHj6hNBr+I9dD5O8gxchglN6rJxwdteWS2fU5u7t/ONRGw338+
         p6+LMbh/NmpKwX7sKc7oAS9JLgswmi08Un8hsm5LJEbCshpDHS7qOmX0bMuE9YDXIaRh
         hiUZhimuxRXyBGJJh9vbz3R7DHyAeObqIDWsUviZ4Bz9EBOYTnV9NnUKlEOzRqvwwIak
         ESyfT6Tc4FSouVjG7NncK/gigOmZetdyUlOI5CaZGS0qR+xg6b+EHEaREoposUvdnSf0
         73lg==
X-Gm-Message-State: ABy/qLb++4DkFt1HvviqvuaqpJefpmtR9Z9U1WQPJFgQ2TrkhmJfQILy
        GaTiXJtP3KBkKknfi+pENzC3GxWlkfcnO2gZfWueiw==
X-Google-Smtp-Source: APBJJlFTDtlGJPqhjR7lEZ+O3t1RJwP4VvxGhySPQ373Ogt5DrEeq71+OvxsxcK2TUQvLsYAd9BLjj/nxyedC330u5c=
X-Received: by 2002:a25:b7d3:0:b0:c4d:c258:7ad with SMTP id
 u19-20020a25b7d3000000b00c4dc25807admr3607123ybj.64.1688666556569; Thu, 06
 Jul 2023 11:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230706124239.23366-1-frank.li@vivo.com> <20230706124239.23366-7-frank.li@vivo.com>
In-Reply-To: <20230706124239.23366-7-frank.li@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Jul 2023 20:02:24 +0200
Message-ID: <CACRpkdZkdhtTG0BZpGzyJp50iF+81StNPq8EDQec7N7Ev_ibNw@mail.gmail.com>
Subject: Re: [PATCH 7/8] ata: pata_ftide010: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 2:43=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
