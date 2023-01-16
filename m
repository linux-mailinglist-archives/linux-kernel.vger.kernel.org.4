Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E966CF3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAPS6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjAPS6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:58:20 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ACE234D5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:58:16 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id d13so20065974qvj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C63mgoRdAtz/YJMR7biI6szW2IE2U19fGXKnn72cZo=;
        b=L2HXL4cnvlLjL83N5xUbSr+EK6yWGpxzHl3ZGFmGE+GNP3/4yoW1NKAdekC061eGZ0
         cmx3idM8ioMI7UDqqEECrdX2rzEyuiea/jdKvOD4eniJdHb98Hhzhh5mOQCzw1/Ob3v4
         9dBP3LyzcytS6pFdyXdBtl1ocFAljciJinO8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C63mgoRdAtz/YJMR7biI6szW2IE2U19fGXKnn72cZo=;
        b=4PlgVQbTN7OorxO4uX9nh3uSrjHAl9j7owJjS0C0hEg/plsSi0McpdKlYYSpQt9P+i
         4K5QeiuvIvYf1KxkCOUJDWGoQ/Z0xPDyN+7TWMcaHzX/9sS0hSYvE64Y4wi0wvWJSt4c
         s6L+2u0Bf3Xe56ZtbisK3Yqic6Ui+iDTsvO8hb9yezvFvyxL0q/F5bORz7JlU6yD2TNK
         H+e6/CqqCaaeAAOVe2M2TuHrr2Xef3u5Spz7+VihJ7pHF9wfKUW31tF7OzbpNnF4EvV5
         gT6f5si2bJSRHnaKWoD7fDTiNHTPr6I9/gZ76F9MpttV1WEAuoU6gdIqtle33wEFNQar
         xkCA==
X-Gm-Message-State: AFqh2kqC2McOocx0VLCVbsAArTEtPIagF42StBvJfbtUCzjgwEY0y8AK
        rT3ySDdDXIQTU3sIjlx8kW5lAThOwGergnDX
X-Google-Smtp-Source: AMrXdXve02hvHhtVuY9XMelwvLZ6d8Vb+YQbDRp9qXXm0J4ExDSjjf9i/2mD93Uht7WloztC+VVdYA==
X-Received: by 2002:a0c:fa08:0:b0:532:1caa:3402 with SMTP id q8-20020a0cfa08000000b005321caa3402mr839693qvn.12.1673895495714;
        Mon, 16 Jan 2023 10:58:15 -0800 (PST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a454f00b006ce76811a07sm18989439qkp.75.2023.01.16.10.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:58:15 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id g9so10709584qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:58:15 -0800 (PST)
X-Received: by 2002:ac8:7252:0:b0:3b2:d164:a89b with SMTP id
 l18-20020ac87252000000b003b2d164a89bmr876qtp.452.1673895495062; Mon, 16 Jan
 2023 10:58:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com>
 <20230116185212.GA2127972@roeck-us.net>
In-Reply-To: <20230116185212.GA2127972@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jan 2023 10:57:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgHNt2dmrwmCfNqherZegVcAo1Nin6EpydnW+fm=D79g@mail.gmail.com>
Message-ID: <CAHk-=whgHNt2dmrwmCfNqherZegVcAo1Nin6EpydnW+fm=D79g@mail.gmail.com>
Subject: Re: Linux 6.2-rc4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jan 16, 2023 at 10:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 155 pass: 155 fail: 0
> Qemu test results:
>         total: 502 pass: 502 fail: 0
>
> ... and no runtime warnings.

Lovely. Fingers crossed that we can keep it this way for the reset of
the rc series.

I suspect I'll make this a "rc8" release regardless - not because we
have any particular problem areas, but simply because of the
effectively lost week or two over the holidays.

               Linus
