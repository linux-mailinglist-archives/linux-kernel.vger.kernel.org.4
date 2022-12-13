Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E199164AE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiLMD3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLMD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:29:19 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5F1B9CA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:29:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id jr11so10253712qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zp0U9Kl4wDERv8LP4SRbd+OyzbRFeaPhMPOi3/LSHe4=;
        b=VrN+0XdiySagFbzfZT3HDYXIZ9s7TWs9LITr1N9EkXfEoqvxLaPWUJn0CCF0lzpS2q
         mn6sM/KMo0sAcPdY48YkP/E8319NigCboqyj9OXDaOzw+vBHk9hMdOxiptzyzMQuGQO5
         b4Un4hq68aqroz/YhO57TR4fQjc/VNj8lkZm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp0U9Kl4wDERv8LP4SRbd+OyzbRFeaPhMPOi3/LSHe4=;
        b=37A4Nudv1i1uPlV5xY9pBc/TN1p+M2KSVobBUbc4Sbq18wsvO7Zpdmtk5HV+DZQR01
         Labu7Lby3VX70TP5j/LbqCNUxVsmk78GSRF2mks5Zh10GW3pqcpxrMU3Ewg+r/mXEYCR
         a7Mzr4fUQV6uFHCw4U9avnrx0wDEtGZvWLYtokj19475CGteK1J6T8UQ2sFudmp7pwcX
         xeyMiqubbZAq0F0SAi6zfQnFrLXrwHvXKzsuCkHuGlFW4TVjcTmCWNNM+a1swEWx7V29
         kY0PQJQp8Hx1HvpDU7N51NjAG5aDsfvcZuypApsszdAJbfLDAte44DVDAlWGFDYCOPsW
         PERg==
X-Gm-Message-State: ANoB5pnO2+ETVLhfDWJ3j2OFKRYim0+yo4V72mFq8RxoT0bT9XTIQfFU
        Yat11DxDt43F7xwa28J72LQbfkGt79621c8T
X-Google-Smtp-Source: AA0mqf51ptQ9HR5O12blZDua7vucABtSQpfDFstBM5Kd1E5U2fuCxmO5EnOiItKWW/wXQD24Xzr4oA==
X-Received: by 2002:a05:622a:581b:b0:39c:da1f:f817 with SMTP id fg27-20020a05622a581b00b0039cda1ff817mr25414089qtb.61.1670902156940;
        Mon, 12 Dec 2022 19:29:16 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a13f300b006fcab4da037sm6900109qkl.39.2022.12.12.19.29.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:29:16 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id pe2so3530799qkn.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:29:15 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10633201qkg.594.1670902155636; Mon, 12
 Dec 2022 19:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20221212123348.169903-1-brauner@kernel.org>
In-Reply-To: <20221212123348.169903-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 19:28:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
Message-ID: <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
Subject: Re: [GIT PULL] vfsuid updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 4:34 AM Christian Brauner <brauner@kernel.org> wrote:
>
> This pull request converts all remaining places that still make use of non-type
> safe idmapping helpers to rely on the new type safe vfs{g,u}id based helpers.
> Afterwards it removes all the old non-type safe helpers.

So I've pulled this, but I'm not entirely happy about some of those
crazy helpers.

In particular, the whole "ordering" helpers are really not something
that should be used in general, I feel. I'm talking about
vfsuid_gt_kuid() and friends - it's an entirely insane operation and
makes no sense at all.

Yes, yes, I understand why they exist (those crazy IMA rules), but I
feel that those functions *really* shouldn't be exposed to anybody
else.

IOW, making those insane functions available in <linux/idmapping.h>
really seems wrong to me. They are crazy special cases, and I think
they should exist purely in that crazy ima_security file.

Again - I've pulled this, but I'm hoping to see a future commit that
limits that craziness to the only user, in the hope that this disease
will never spread.

                Linus
