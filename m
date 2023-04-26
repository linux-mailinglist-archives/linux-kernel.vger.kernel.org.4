Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45066EF9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbjDZSNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjDZSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:13:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2E44B5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:13:03 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef36d814a5so484711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682532783; x=1685124783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJP2H7Tti7sCJqZuan3YjXjcNVzDWrJfL5H/TqIl9w=;
        b=AM3kUmvyQL4L6eAvdHifAGtM5Rz49bNhibzZQdo4AlO0c6tXICsIblPsgnmT9IzWGH
         zS2AbW3+hrG/clKEqD6s5meok9otDJbQXM2otLMaIdruVNtQDXJWCraoKj7di/rgU5Zg
         uDyxGKbbBUBfkyiNAj/CFknqS59twz+2kvRTvEPuT9HNmMYMI+mxAX9Hixm+kJdmq1Wz
         +OGCZMRtuSSiFPJnQIsNKF/WHpP4xPEUNJlRRLEZ2VGDu+zpVDFF1BzOTF1bbxWyo/s2
         lOTSuXgeW7uuao8PfskNIq2BzelnSrGWzIKzpNwRdjSOsDljfGBJfR3Ma2lpt0sAZxiU
         mZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532783; x=1685124783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNJP2H7Tti7sCJqZuan3YjXjcNVzDWrJfL5H/TqIl9w=;
        b=BF3J6NwKhL57UsoaHq/bINZXvK/fsPJvlF8SsKFMBba9cArgXi9JrxZrlIPrEdAdbw
         fninJzWoLix/6R35bWjFgg88cvlmABVrigTJ1JW7E6IziALjrktYcGuqU+zkbZsQnXTG
         zd5/unt3pzZdpO+VHeG1/7ZSmxF18UtsYJo8OSdJhwOqg447JyUep/j/zJyi+//by2hq
         jHrCSe7LYVWz46f6l0pTiBhk70EPpmh0dMcZWVr2vRCkoJffUR0D1cb9MZJpy7wYXODK
         Lyqb1ny5RXDE0RVE57txg7gfcdzXHglr8SKvhVx7vvfXtlJQ6OFUdzTivU+U4b6Q+chv
         +nRg==
X-Gm-Message-State: AC+VfDwHmVf8oR1kLyU9H2lqD5HdanSG3UwKJaH19YfywDOs9J/NxKss
        Bg2Mbykg6XaKKSNSzLSFI0VdMy/sHqEWuJG0K/xz
X-Google-Smtp-Source: ACHHUZ5+27EZ/liwNoh2uhKVoZv5KPyytWMmatTKKsKavw690/EnK9BLh6JIc0rvOhiu0BHKl4FQe1LAu7OgewSwRig=
X-Received: by 2002:ac8:7e84:0:b0:3ef:1c85:5b5e with SMTP id
 w4-20020ac87e84000000b003ef1c855b5emr397486qtj.19.1682532782954; Wed, 26 Apr
 2023 11:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <06df7b3cbd94f016403bbf6cd2b38e4368e7468f.1682516546.git.geert+renesas@glider.be>
In-Reply-To: <06df7b3cbd94f016403bbf6cd2b38e4368e7468f.1682516546.git.geert+renesas@glider.be>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 26 Apr 2023 19:12:51 +0100
Message-ID: <CANDhNCqjkaBKnTdRTumrZbvcmGterak1FpCBn-ZnkTm+fUoPXQ@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Fix references to nonexistent ktime_get_fast_ns()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
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

On Wed, Apr 26, 2023 at 2:43=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There was never a function named ktime_get_fast_ns().
> Presumably these should refer to ktime_get_mono_fast_ns() instead.
>
> Fixes: c1ce406e80fb15fa ("timekeeping: Fix up function documentation for =
the NMI safe accessors")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks sane to me.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
