Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB82864F4AC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiLPXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLPXIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:08:43 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F873B00;
        Fri, 16 Dec 2022 15:08:20 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso2792302wmp.3;
        Fri, 16 Dec 2022 15:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JVjqU+NFsqoOx1nzHqvzhNnXugzS2QyOypn5WZoD0A=;
        b=nCTmxAgxMQvB8XeqdKkj2z0IVx9wr1wfiCxvySdtKPZzjfhp0fc3DnASLL7IY9I1+2
         ax8zifHJ6WuubbRmO/fU2jfXQugqju81grhYL19LsuuBK98CHVR3swZpGcVD+jaYGuwk
         5nAIrMaRXZud0QG3oUlp1hT3JNR4w8DSC46a0vnOl52YPlA6/HuhcKDuX0473AVawafB
         nd+EbJxJW6/N240y1UPYGjbeEDbak1Nfwukialcb1BE5e3y/z0Qy910cSIC3PC/4ageo
         nSNFFzudsylDIp7JDbt2hDI7qgMgFrLYUB6Xyc0bAbTwoWX3PwGVM15VgxBM4dAGm1S6
         0Oqg==
X-Gm-Message-State: ANoB5plV/7txV06Zrq9SUPMum5WhLG7AxXly7E/HhOXSkvWvTb5gbosD
        vANSIntbHNukf7NAzXn45aMc/nWvSgw=
X-Google-Smtp-Source: AA0mqf7pXX5nf4ZMcFLoWjSxv5fNIvhqkY0jg8OrnBf5pQAEHpHppz99V+lAVjsfu4pYA4/DUSsLjw==
X-Received: by 2002:a7b:c84f:0:b0:3d2:389a:50aa with SMTP id c15-20020a7bc84f000000b003d2389a50aamr10230189wml.36.1671232098546;
        Fri, 16 Dec 2022 15:08:18 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003d01b84e9b2sm4023385wms.27.2022.12.16.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:08:17 -0800 (PST)
Date:   Fri, 16 Dec 2022 23:08:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>, rust-for-linux@vger.kernel.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH] rust: kernel: drop repetition in offset_of macro
Message-ID: <Y5z6YKNojBqoN5OD@liuwe-devbox-debian-v2>
References: <20221216174927.1008629-1-wei.liu@kernel.org>
 <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqo2qKUnyh6XVkBHyAcVjvN9NKJ9sb9bTzkHq7jC1C-B0w@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 06:26:57PM +0000, Wedson Almeida Filho wrote:
> On Fri, 16 Dec 2022 at 17:49, Wei Liu <wei.liu@kernel.org> wrote:
> >
> > It doesn't make sense to allow multiple fields to be specified in
> > offset_of.
> 
> Why do you say it doesn't make sense?
> 
> Here's what I had in mind:
> ```
>     struct Y {
>         z: u32
>     }
>     struct X {
>         y: Y
>     }
>     offset_of!(X, y.z)
> ```
> 
> Which is something very plausible.

You're right. I didn't consider that use case. This patch can be
ignored.

Thanks,
Wei.
