Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4A703B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbjEOSDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242652AbjEOSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:03:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F019BEC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:00:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so2198303466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684173634; x=1686765634;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv44/oK7XAF3kNs9Hd3WVTKEAoxAVlltHbODTzVPgm0=;
        b=wVxuHi3JGUdKZWHcPplYc3dLd+E6j45iHTX2VumJoo56zKFS2xdKCGuDV/70lEKk35
         8NdcbP40UUakOoeAjdvDkRU06v8XqvPKD4Apj3s8IQwMBHSKWuBVjdlzeVKN6yClCsOY
         4fPY7h+OfjkvbKEzWkFr557O85ya0BWeaBZsN3dCtOGhVrIxhC6JQCd3CLNg/i1a4Hnv
         p5K7q0o7zEdu//6B5RsyTEdYUxg+SLBBLoRhdDeNT/QW4jd+O3vhGTN76thNn7Iy8cMA
         MXLISuQWoTAFq5iDQFlZ8wC9J7AbqjlZgW8NbPrW/zeY4aSP7fliXrFDOsctP/sdvuGA
         UUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173634; x=1686765634;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cv44/oK7XAF3kNs9Hd3WVTKEAoxAVlltHbODTzVPgm0=;
        b=RVK4x31AyLcrs09busc9F9DIhVWxeDfBkOlIsAfHg7dDT1ZoHJOwIrSHGMZ11rtTQI
         swuBU+kGgYC3C+DUywWx4OgSyjqWy+JTNw1OYTZCqlc83tH+MO6pSsCBTx71S0QJ2Vce
         iHzTq6+UP7aWyspF4VMnvgHSyRTZVl5zrViSitUeDdiHTBDqTxjjQxBfkfsrlFz/ah0s
         rMTe1xHMXsqoAXkrTKVZqktzmGVNs6sMYMpettS0p8k0YiQAgWjtUTOVw401/g8dPTmT
         G3qd48PoLZ3dwkgXZRcGboe0jY4m+PpzUt9Tq0nBm5z03pRMtrVKJH/kmFV8vVr/JDRh
         MAVQ==
X-Gm-Message-State: AC+VfDyozMNdnl0PzL0WgFkjE+nbTAE8LoAVOGZxUT0YhjcPzvwNbYVy
        mmyDAryGbr3NUOdg/Pqs31g48Q==
X-Google-Smtp-Source: ACHHUZ4WT1UAlsxx5OXxwKYq1+o3pEblQqSQiYai7Baqo00KRgYm1nJbLdJPZSjPzQMONfZn4ODqbg==
X-Received: by 2002:a17:907:70e:b0:965:6b9e:7ded with SMTP id xb14-20020a170907070e00b009656b9e7dedmr30999391ejb.42.1684173634592;
        Mon, 15 May 2023 11:00:34 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0095ed3befbedsm9843257ejf.54.2023.05.15.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:00:33 -0700 (PDT)
References: <20230507152232.803-1-ben.gooding.dev@gmail.com>
 <CANiq72n-swO1L1zsPNDz=ZMMm=Ox5MOJHzXBbxgX0f_vWFWDmg@mail.gmail.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ben Gooding <ben.gooding.dev@gmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: lock: Add intra-doc links to the Backend trait
Date:   Mon, 15 May 2023 19:59:34 +0200
In-reply-to: <CANiq72n-swO1L1zsPNDz=ZMMm=Ox5MOJHzXBbxgX0f_vWFWDmg@mail.gmail.com>
Message-ID: <87a5y5eapr.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Sun, May 7, 2023 at 5:23=E2=80=AFPM Ben Gooding <ben.gooding.dev@gmail=
.com> wrote:
>>
>> Also fix a minor typo in one of the comments
>
> "iff" is not a typo. Even if it were, it is best to avoid mixing
> different types of changes in commits, to keep them as small as
> possible (though sometimes there are exceptions).

We should change the wording to "if and only if" to avoid confusion.

BR Andreas

