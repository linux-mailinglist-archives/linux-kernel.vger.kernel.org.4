Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE6A6F886D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjEESJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEESJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:09:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276EB1CFCB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:09:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso3798092a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683310144; x=1685902144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhOBd9eyIHjYJojvwmT6dMwYds6GmWgjJtMpNnQft7I=;
        b=WGzGqn1QjEUqa0QRJopVl9UbMEjN/POIagPEDljMo5stI2DkbKz556Xd74bsRYda43
         bZnt07r8b12fyu86Z4XAi2Kswm92M7uUtC58z2tjEE27IpY6a9QPQZ5AnRzl3ZwFPRgX
         7qgX08Vf/BvQ2xiE+yMLlD0mo5wf+Xu6NfvRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310144; x=1685902144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhOBd9eyIHjYJojvwmT6dMwYds6GmWgjJtMpNnQft7I=;
        b=Sj5bvgPxyiTF8adAOTD4UbUrMjH4smZ1qbfXVd2hFQN55j60au/dZ56FpomniOil/+
         T/iCcvioVVQDP09YBZQhkVsmyWP2fUPsIB7sU/V2DaAtYUGzYBJWVzHa9PY1gU21wX5W
         zEcS8Rh35IfzDv53q764oWvPb00aQfFc7obmNG6jYeEJ9D0OI6TZF1QHC9eECTgfIrcv
         o2cCot25Ogreaam3LY4MrT7StceDKeCK818tQecxdQjRF5PYRfJXL/R/PQyny/Aj2TKA
         ZRcY0W93w82pvhUu9whc5/K7DPrYPtZRe4juMx57/jm9ttyDkeLS+4MbbeIY9DM8/fxL
         hGOg==
X-Gm-Message-State: AC+VfDyahxDXdnkvYIAB8EG3+Dmu5IUiKx4cEu1vFB4GSUCaSMw84TZ9
        ShXnE9r0GZVq3tFebW6I6EV6HZV2m+X8ssiyBfUSuA==
X-Google-Smtp-Source: ACHHUZ7qEOTvoLVe6MeqN5sjhFcaz5HHVaQO4x7d8dqnX9mkDGfBo56QXKyyTpxrZO+t1WEeU+fZ8g==
X-Received: by 2002:aa7:cd82:0:b0:50b:c8a0:1247 with SMTP id x2-20020aa7cd82000000b0050bc8a01247mr1889258edv.40.1683310144355;
        Fri, 05 May 2023 11:09:04 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id y25-20020aa7d519000000b0050b57848b01sm3106975edq.82.2023.05.05.11.09.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:09:03 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-965a68abfd4so395787666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:09:03 -0700 (PDT)
X-Received: by 2002:a17:907:783:b0:862:c1d5:ea1b with SMTP id
 xd3-20020a170907078300b00862c1d5ea1bmr2184397ejb.8.1683310143215; Fri, 05 May
 2023 11:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
 <20230504012914.1797355-4-mathieu.desnoyers@efficios.com> <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com> <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
 <190e5f92-f386-77a4-21c3-7f07b15ac4a3@efficios.com>
In-Reply-To: <190e5f92-f386-77a4-21c3-7f07b15ac4a3@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 11:08:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaGe_MO_Fk8MOr2KNwbWw3J0MS1j8G-FRKYaauCYY43g@mail.gmail.com>
Message-ID: <CAHk-=wjaGe_MO_Fk8MOr2KNwbWw3J0MS1j8G-FRKYaauCYY43g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 7:23=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Is a list iteration position absolutely required to be a local variable,
> or can it be a dereferenced pointer ?

Well, it was certainly the intention, but while the member name
obviously has to be a member name, the iterator *could* be any lvalue.

Many of the "foreach" kind of loops would actually prefer to have
entirely local variables, but C syntax rules didn't allow that (now
with C11 we can do that variable declaration in the for-loop itself,
but we're still limited to just _one_ variable which can be a
problem).

So if we had started with C11, that 'list_for_each()' wouldn't have
had an external 'pos' declaration at all, it would have done it
internally, but that's not the reality we're in today ;/

              Linus
