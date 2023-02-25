Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5656A26EA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBYDRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYDRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:17:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE82332B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:17:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id eg37so4697953edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LmNBVo7uMw1aKq2gIrda4qCIdgm1A6fpKV1+5VP6zB8=;
        b=CNsccW8tA+8ig58sm067TPguHm1dqrGdvdIfAPEzz6ALh36vuJuyTUG5qKT+eU4uM/
         7fMH3gXsZbB4TC8buks/zia2MSzAQQ6lVZy35U+/aMqF/7piRqQ0lU6oHnGJQfOSwGLu
         QjsHiGsYCvsFkN/7u71yE9bcCEGRxqLZw1Vwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmNBVo7uMw1aKq2gIrda4qCIdgm1A6fpKV1+5VP6zB8=;
        b=XwsiWBaLlmMxPlzjXYxDLt4dck942DRjbeiVCsFOx/TA/VJl064Ub9n/lrWp+eyBDY
         Sw5YtsSIpZAJ4xfMY2XsaWNpbNWWXMI/oglBz1btm/egwHuRQLVJrmmCuFPB65V1dnZ/
         PGYMuswY7PjIJxBMAWg/KFUn/db/NzHu0IWB1mCkt6PCLSy37YH5HM0ujHmAh9NVvdCl
         LTJi6UtjUJjKhJ7I4ZKDJVhmUXQR8giHbkzYSmK7SC1Is2VmikStvY6Ql1t5VRBKB87O
         qXsHc/uDIuTMIJWppltq55x51MQXAW5oNB0rQ1G35q/E7WmZRf9FhnQJVwGmf+Ko/R8l
         Z05g==
X-Gm-Message-State: AO0yUKW4JzXuUvdr6TDw8pXrQBy8Q/v49vfnjfH2Wdawunf9MVY38pNB
        LyWz3nHt7i0dhqPHFaQ5WpCDIIGsGnfOeJd/oiI5XA==
X-Google-Smtp-Source: AK7set8lNc+yqS0flJLmevlYsEoNCrZV8IkNIMh8+qnHHkMpJhUpAKWljThO5uY29ZE/boq9adIW5Q==
X-Received: by 2002:a17:907:60d4:b0:8e1:cc38:6e78 with SMTP id hv20-20020a17090760d400b008e1cc386e78mr19584558ejc.39.1677295054427;
        Fri, 24 Feb 2023 19:17:34 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709064b0400b008e125ee7be4sm314047eju.176.2023.02.24.19.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 19:17:34 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id ee7so4920891edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:17:33 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr11483974ejc.0.1677295053168; Fri, 24
 Feb 2023 19:17:33 -0800 (PST)
MIME-Version: 1.0
References: <Y/gvQh5+4k8y+IdF@ZenIV>
In-Reply-To: <Y/gvQh5+4k8y+IdF@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 19:17:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwFeuahxGxCidcaaZ-Xawh2drJV6WFwhs7ujDZGNGV4Q@mail.gmail.com>
Message-ID: <CAHk-=whwFeuahxGxCidcaaZ-Xawh2drJV6WFwhs7ujDZGNGV4Q@mail.gmail.com>
Subject: Re: [git pill] vfs.git alpha fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
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

On Thu, Feb 23, 2023 at 7:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  FEN fault fix deals with a really old oopsable braino

My old alpha architecture manual doesn't even list "clrfen" as a
PAL-code instruction.

It does have "wrfen", but that's privileged.

I have no idea when clrfen became a thing. But it's clearly a later
addition that somebody didn't think through.

             Linus
