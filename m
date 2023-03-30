Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0C6CF8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC3BjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC3BjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:39:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F0F4EEB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:39:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y15so22581945lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680140351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY8yoI87Fw9sjvQOAcytic4aFldeDuP0KE7rLqC2tzA=;
        b=m+dHxMa0el4FJBFdtSzfkNiBgDSQwwDlzm0EI2e0xBVMRsG51xpgOfqs54kTHURZTo
         xh0uN6A+IPKjUxjgmLF33J5glnaIYQCRpHSHNTWDtxyXtDMCGKBeLHzeza3oSpHxejpY
         BLemhxxpmKcsYRbbZWFH2NeWVe+4CWyU9J+EHdqYSc/ncVXeofRs40x3LfuAzy4C80bA
         KfvxgqNtQagprilzWQ9P7GPTHREv9hLZRWdWesh/Or2ti87mb6UTw37gTgCFgyrQooFF
         /8RR2VKqFJKhOT8UGu88jFxrpZabuJB4VYjTBlDtUHMyebD+8WN0ra+oaokQ4XzTjgHv
         hJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680140351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eY8yoI87Fw9sjvQOAcytic4aFldeDuP0KE7rLqC2tzA=;
        b=HPCzc5aY8Z63wtXN7cag1UEPdbaAOPW30AgsSdZIuMlbuf//fShDG5LYr8+dOQNW8n
         NiCiDinxLmA2ii2CqQ7wA8DINm+1T+fhy/VbPfPudro/KuoGZxfhDs/1j4wa/KGBzYpz
         Dz5H8fa1xr8uOlH3aT42lrMa4JiSEMOvy88Et0Q1xztMA9z+ldrr35+BE3PShQx288/A
         s3lN8L+3oy62Kp9Jn/ppGJNEhgSF0K/MgCh0MRpirAPvouUgKVFvCenZ3GUA97E3RXMl
         TL2IuQspoPEkuouxegDyLwHeDJc1BOMDutBbAEseUib6v6IqzyoqWyeyV2vdEHcFo9tv
         6qTQ==
X-Gm-Message-State: AAQBX9dPh2uV4Cp+OaoO7Ntdi9m2p30QLp3jCYb/Bj6JaQMAjpJNOOar
        1Z8SRElVcscecI79gVdmAkFF64Ps21Q6wd5heuCjAHPP
X-Google-Smtp-Source: AKy350Ys+tRkZDDt8zOnNuJUAayRnaxn+bx32fPsSuqzbylKPXs526Qy3Ps4UQKgKBP7NvUs4Wg5QaaDV7vjBIegT8M=
X-Received: by 2002:ac2:4436:0:b0:4e8:9049:b640 with SMTP id
 w22-20020ac24436000000b004e89049b640mr6389757lfl.4.1680140350794; Wed, 29 Mar
 2023 18:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com> <ZCRRaHHKVt7fpvmD@cmpxchg.org>
In-Reply-To: <ZCRRaHHKVt7fpvmD@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 30 Mar 2023 09:38:48 +0800
Message-ID: <CAGWkznFRHbYv2ev3FU10zapka_6MDQ+g_-b0jufzqcAEAKUqFA@mail.gmail.com>
Subject: Re: [PATCH] mm: mark folio as workingset in lru_deactivate_fn
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:55=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Wed, Mar 29, 2023 at 06:47:35PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > folio will skip of being set as workingset in lru_deactivate_fn.
>
> Can you please elaborate why that's undesirable? What's the problem
> you're fixing?
If I am correct, folio will skip being set as workingset when moving
from active lru to inactive lru, which is performed on every folio in
shrink_active_list during normal reclaim.
