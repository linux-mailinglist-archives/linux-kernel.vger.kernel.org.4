Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9217025F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbjEOHV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbjEOHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:21:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E920E76
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:21:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f4234f67feso339605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684135278; x=1686727278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu3hDAbGl6HJftPaP2zd9YmTOFBhpgmb60DHeeqSWU4=;
        b=bGa5Diaj3pQHHQfFWaoJG2JWpF1v1vEk6B62v/9XOWFbenUFsbbXW5CnHpWNKzhOjT
         rrbtvfQiH2zCGD6SYDl7MigsjZ7IgIZBK/iO83C76qnq70m3sCmOrrdl+aseIQFsRWoK
         1u8C0YOQEjmiAks5TYSiPCt5uVRMbG61FmArKwy0tIw71koFITlAgUGubVlhNAdExYqd
         AjL4ldt3FXYr+CZ/DoJgyW6Om9N00X3omSScyk5WxuPM+xbfKjYLSeoQ9DWX00liQnTl
         k5L4RSc96Bo+vYwlQzDr6bYFMBHxnA73vmY9qFlNzwueZ3IAQSOtGR9WciZLICwhMv7Y
         /GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684135278; x=1686727278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu3hDAbGl6HJftPaP2zd9YmTOFBhpgmb60DHeeqSWU4=;
        b=kaI91ET1eO74MbGpXONHSlhKCvXPReZQeb71MKjSC5bMxBZ5C4O9VRrAyJYO9SMK70
         Vxb8LpgALga6Qrt1/WXnybHfVNbDN35hUG/z1YX3JAOBFLSZc7q2OEF1Bj66Y1HZbYqB
         7UzfTzc5TI6839GvavJLn+594BjrS6jMRefGnOoj7zc38GOWRkZAc7O+1yUjsNMMK+PH
         bFFNCP7X2kihIsq777Y2C+B3tg/a+OiZeY/TfZD1fI+j6shlBoHQxXfBTIx/KA9J68C7
         UhPU5zFxzDnZ3E9IBJrioF3h3vYLa8iY1RSxCmYaFO3GoDfxLQk7RzVI3BcALqGdjOgl
         k5dg==
X-Gm-Message-State: AC+VfDzNnJ6fSGXCmHZIzvLZaCp477jnh3X8cNv+7IaE6sG7856u77fp
        q4Dkc41QbnVEIhAY59WTcd0ZzVEFEpnz2SyzHBFRPA==
X-Google-Smtp-Source: ACHHUZ7tjmwMWHPqBXry7NtB6PsuS1/EDoxOqCq209J3AafhCRrw5MkONoPuu3c0G7v4oyy+WnR04mxGZhsqmK02950=
X-Received: by 2002:a05:600c:310f:b0:3f1:6fe9:4a95 with SMTP id
 g15-20020a05600c310f00b003f16fe94a95mr790926wmo.4.1684135277727; Mon, 15 May
 2023 00:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230506085903.96133-1-wuyun.abel@bytedance.com>
 <588689343dcd6c904e7fc142a001043015e5b14e.camel@redhat.com>
 <d2abfe0c-0152-860c-60f7-2787973c95d0@bytedance.com> <6b355d57-30b4-748d-87f4-d79a50fe5487@bytedance.com>
In-Reply-To: <6b355d57-30b4-748d-87f4-d79a50fe5487@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 15 May 2023 09:21:05 +0200
Message-ID: <CANn89iJqzE6r9dm2hoHxgYeLQvStZYvRhCxFVmpV_LczaO-4xw@mail.gmail.com>
Subject: Re: [PATCH] sock: Fix misuse of sk_under_memory_pressure()
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 15, 2023 at 9:04=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Gentle ping :)
>

I still do not understand the patch.

If I do not understand the patch and its changelog now in May 2023,
how will anyone understand it later
when/if a regression is investigated ?

I repeat :

Changelog is evasive, I do not see what practical problem you want to solve=
.


sk_has_memory_pressure() is not about memcg, simply the fact that a
proto has a non NULL memory_pressure pointer.

I suggest that you answer these questions, and send a V2 with an
updated changelog.

Again, what is the practical problem you want to solve ?
What is the behavior of the current stack that you think is a problem ?

Thanks.
