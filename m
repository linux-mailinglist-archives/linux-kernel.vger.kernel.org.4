Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3270E89D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjEWWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjEWWFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:05:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CAC2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:05:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so25625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684879530; x=1687471530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WG7cm3SOeE/AEmJ5imPtVDm8ujtcFrQwX6MexQOiXA=;
        b=WgGqTH+fr7xzJ54Wv5q5B/fbZQtGZzIeF7zH10dyE2lfIyMWMk9Sa1co17wzGUEoO1
         zridCyqqqIDgZ/GPkIsmtLW73lTXaUibio0Nj0nTIPixvhE8xbHOX9EcN57b677hCZyV
         BL2LQrOmLTap/9v0APYz6LB1h+gj3FfLtp6VJ9v/0dG++AL5BDCC3e+4lmx4aZfPjLG/
         LVCOC+DO4OfGUk4GgGOFUlcnRMSrErNHsVvuOrUyXnjVuiX6BIuFOMdnyy8bSRtniSgy
         n1FSM9n3hxf/BsepoPBWGTx8515rjMph8knbc5T5yyM5tzMq+P+Rv0xIxWo2VHTkccHd
         U66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684879530; x=1687471530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WG7cm3SOeE/AEmJ5imPtVDm8ujtcFrQwX6MexQOiXA=;
        b=WCS9BpX2GACWiePmLlJKTHFljMaDcbVIe8h+rs7PtnTF2hrdAB/Scf/3H76SalETS7
         T9nHt7uH+bNAjXLHvf0LS3xBUr8IyxdIMA8tKJWVSiSElonto6lmECvvIIK07uhSQELi
         YDIof4ejT8aydjqSyPUU2r0p1ajsfOndBuf9JuZ/+Bn1AWBxrCZqfDDUwhrUOjOu4YG4
         Csgp96Vd/8mPgUhVq6OC4cDyJSZXtv35OogbL5PasL8rGcvbM7rEYErMn8MvfS57p+8Y
         lrGGm5oM+pvEO63OELiptWyecjT13cJ3E8qA4b2wfVvk9OY+3352GVTb0EhfM6S2FXkp
         vvcg==
X-Gm-Message-State: AC+VfDxwMCuPMAVa8wnsR2QBq7er+H/zYKn4oXSZGY3c9X84zP153UE1
        2j7IYWQkYRiu3+sLQSilmF7tk9yVi6nVTbt7dpdfZA==
X-Google-Smtp-Source: ACHHUZ6uGkm2EnvzV8wfnKBvB7qTrDSxdqvEltJbQAidg1jAdH//992ples+uIUAin3vmMaLJSN5IADG76zb82LC34Q=
X-Received: by 2002:a05:600c:1c87:b0:3f4:2594:118a with SMTP id
 k7-20020a05600c1c8700b003f42594118amr64682wms.2.1684879530132; Tue, 23 May
 2023 15:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230523205922.3852731-1-kaleshsingh@google.com>
In-Reply-To: <20230523205922.3852731-1-kaleshsingh@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 23 May 2023 16:04:51 -0600
Message-ID: <CAOUHufb88CBQibAx=jr7xX7y4Witw4HhCSAd-P4q2qoCKBLZSw@mail.gmail.com>
Subject: Re: [PATCH] mm-unstable: Multi-gen LRU: Fix workingset accounting
To:     Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
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

On Tue, May 23, 2023 at 2:59=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> On Android app cycle workloads, MGLRU showed a significant reduction
> in workingset refaults although pgpgin/pswpin remained relatively
> unchanged. This indicated MGLRU may be undercounting workingset
> refaults.
>
> This has impact on userspace programs, like Android's LMKD, that
> monitor workingset refault statistics to detect thrashing.
>
> It was found that refaults were only accounted if the MGLRU shadow
> entry was for a recently evicted folio. However, recently evicted
> folios should be accounted as workingset activation, and refaults
> should be accounted regardless of recency.
>
> Fix MGLRU's workingset refault and activation accounting to more
> closely match that of the conventional active/inactive LRU.
>
> Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>
