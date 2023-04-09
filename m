Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B196DC0EE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDISPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 14:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDISPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 14:15:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A17272D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 11:15:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ud9so7773335ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681064150; x=1683656150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD3RZUvLZHpvi4CUPf6nNhzEy/3YaB47ya/lNwCpn3M=;
        b=aOAtSbHUxCzk/rxXeEt7ujQNOj+vykmabzzyNZ7s60SGTT6kcWaGZKzJ+Lf06UgEAW
         xfOa7B+0cE0k+Dhwo1jd3kNvzSVku+njvlLJWAGx/qbCIXZ9kEMhBf7RtqarxhU2B/+r
         B1dOlQqgV5qFJIXKEUA9EdjmdpXX7JNWWizjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681064150; x=1683656150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XD3RZUvLZHpvi4CUPf6nNhzEy/3YaB47ya/lNwCpn3M=;
        b=kLs3sfhnWzociGvi+REBpt2rJNIjFRwoRR3KyPDlmcw8vLrSU8R02Telu9PjIDd5ZI
         lCqQ38rWyJvGz8s8KsP14TvATABz30T628LGhVZsBXfbXDAf5/Z2L58uKY1I1HBar98F
         6JEG2Bj5XsxF2QPBfGUKfVOa2hCE3zZsM7arsGjMGhq/YVl6YZiuqSn23CSUqXm6i7bN
         X2IkkyIdcLAEDnjYMN/1OU8Z18K9axER0/oDb2VMKfGJU8PUy1W5eVluzeel1sXI27rz
         msgvdth7dMGb90pgMlmQhJiKSTbvhNx4wFpVc6WfSjbJVNd5rTHu3oQqFbg8AaH0jYJQ
         ZI/A==
X-Gm-Message-State: AAQBX9cDGT/kdB7ouuYhFdrZvQGkRUTDlAyb/XBqrK/s5FNwBKkJw4EJ
        AXCASiwMF9xQRBAZT7DNZWZlSbNUleqd7M5Ek+rSFw==
X-Google-Smtp-Source: AKy350b4ghRhJ+SpwWmSos96lW7aatgNYmrC0vnFK3Noh0K7DpytI1BB78gJvBjKPOV4COlpfPztwQ==
X-Received: by 2002:a17:907:25c8:b0:94a:6c9c:77ba with SMTP id ae8-20020a17090725c800b0094a6c9c77bamr2465781ejc.58.1681064150241;
        Sun, 09 Apr 2023 11:15:50 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id ht18-20020a170907609200b0094a93f75e6esm99655ejc.15.2023.04.09.11.15.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 11:15:49 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94a34d38291so57246966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 11:15:49 -0700 (PDT)
X-Received: by 2002:a50:a417:0:b0:4fb:482b:f93d with SMTP id
 u23-20020a50a417000000b004fb482bf93dmr3606156edb.2.1681064149030; Sun, 09 Apr
 2023 11:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <168106197596.1411382.4633915108737130144@leemhuis.info>
In-Reply-To: <168106197596.1411382.4633915108737130144@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Apr 2023 11:15:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCoBmY2cOdyRFGzEPetAk4ULnd_0N4-OEV6RvrLC3BeA@mail.gmail.com>
Message-ID: <CAHk-=wgCoBmY2cOdyRFGzEPetAk4ULnd_0N4-OEV6RvrLC3BeA@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-04-09]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 9, 2023 at 10:41=E2=80=AFAM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> There is another fix for a media regression (that due to backports is
> present is a few stable trees as well) that looks somewhat stalled, but
> I'm not sure if it is ready for merging. If you want to judge yourself,
> take a look at this thread:

Seems to be just a warning in some situations, so not something that
I'd expedite a patch for.

               Linus
