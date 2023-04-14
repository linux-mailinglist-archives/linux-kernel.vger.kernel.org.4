Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565176E256D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDNOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNOR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:17:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F48F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:17:53 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f6a796bd0so232201867b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681481872; x=1684073872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqCYABRUHXP49kVUIqWSLxFZcuUvKNMUVvMTRcIbVhI=;
        b=L1fri7xLRASJUiwlkiFrLMXseYhq8ueQrhMk6usnBChZJP7Miv+H/1T6+ontoEtR+v
         JbfoRg1lX5W6lhheRin2wnGAx3TkASOaxlbytL7P5mCIAWqx/vnEb6G3GK3F8F0XkG8B
         J/3+d65lDD7HT5T2VQwkRkNz4Kg4+YiKJZtCZBHAW6FJW0pW8XZzhYmQG8PHbf1xPsWF
         fNHbXoAMukz6UyAkVFQ+HSz7jNFEExpvEU1gv1lAUQVsNPuCDSAU0rUc+eYPt4q0/L+B
         o7J3xGgm/HB1U/DExEK8Cwi9sWI7wsJ8T8zNue0QN/Q1bXkMrqfRgGxTJ7OUmbEv3Tml
         IHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481872; x=1684073872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqCYABRUHXP49kVUIqWSLxFZcuUvKNMUVvMTRcIbVhI=;
        b=OapVTSYfsVqnkHKPxqsExuocZCvUnoOFV+jb3pT/CrtT/fqe3V+yLeFhNyQBC1V8n/
         BtXJwHzaDXFHKTokHoiVkazjZAYQnARuRQogXe/D+qrHaVWGHbCEGNKSIyCXgPS+3g/E
         rxQWrIlhzeNb6uQIPrDLTBc8ijJQKAvPvJrlGSW2C/b1FwqrF4f1bfiRrA3xVSPaNqrV
         2ucU3CNRHqoeAYepgato0LKQpJG51GW2dXw+R2svYm7EB6HvI+uS2IZujkhPDqMZRlo+
         VZKElpIGeXzIe84UppMiJHmmM4iaeSsGBi1XmHhRJqvX3fz/ohFKw+KTUAl3SL5oPAts
         v7mg==
X-Gm-Message-State: AAQBX9fD8+GG8ZrJbyxmffuB6jjhFjSfHD1t6NRkIN0/ryn2SO/YB3g0
        6EmqT+OXMgZbTQt0W6B3XTS6BqRVrLwnXwaSx+U0Iw==
X-Google-Smtp-Source: AKy350ZIUgwB9SgTWJiyybQ6NIriSMeE1EvERD7MPWyroMLKlXPtGwQ6p+5KOetV0qr8AnChNdx3J9biOdgBUVTCUGo=
X-Received: by 2002:a81:e549:0:b0:545:1d7f:acbf with SMTP id
 c9-20020a81e549000000b005451d7facbfmr3530526ywm.10.1681481872332; Fri, 14 Apr
 2023 07:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230413171918.GX17993@unreal> <20230414022736.63374-1-bobankhshen@gmail.com>
In-Reply-To: <20230414022736.63374-1-bobankhshen@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Apr 2023 16:17:40 +0200
Message-ID: <CANn89i+k9Qn_8bpJb+Cgh_b4VYYVNArSGG3LmR+d3sxjxdxxbw@mail.gmail.com>
Subject: Re: [PATCH net-next] lib/win_minmax: export symbol of minmax_running_min
To:     Yixin Shen <bobankhshen@gmail.com>
Cc:     leon@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ncardwell@google.com,
        netdev@vger.kernel.org, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 4:27=E2=80=AFAM Yixin Shen <bobankhshen@gmail.com> =
wrote:
>
> > Please provide in-tree kernel user for that EXPORT_SYMBOL.
>
> It is hard to provide such an in-tree kernel user. We are trying to
> implement newer congestion control algorithms as dynamically loaded modul=
es.
> For example, Copa(NSDI'18) which is adopted by Facebook needs to maintain
> such windowed min filters. Althought it is true that we can just
> copy-and-paste the code inside lib/win_minmax, it it more convenient to
> give the same status of minmax_running_min as minmax_running_max.
> It is confusing that only minmax_running_max is exported.

This is needed by net/ipv4/tcp_bbr.c , which can be a module.

> If this patch is rejected because the changes are too significant,

Well, this path would soon be reverted by people using bots/tools to
detect unused functions,
or unused EXPORT symbols.

So there is no point accepting it, before you submit the CC in the
official linux tree.
