Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA23628321
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiKNOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiKNOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:47:08 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506198E;
        Mon, 14 Nov 2022 06:47:07 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so996779wma.3;
        Mon, 14 Nov 2022 06:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cQ8NgfFgLSok/KaQcOLHXWKL1ciKqDLjAWu87KcMnU=;
        b=2VFjoIl1Olj3XZXngNZlwrdfJqj9VqV7ZTbvk22Kuee+zNNUcCO70Es2ayI1saqNhl
         fZwhtWLLKivwf45AU7r4k2+YYzvjxIUa6tDN0R7FGGljB9KTVyJWmfUM7vr9/+H6pRGy
         ru9F9LPA4zGrrhcflnP+flZUyRfuT8CmK23LjN1FYUIOoicUl5JvQuiJEn6EqDfwYzAR
         liGSNzjfQGOF8KzINFnuNScF+Zut4IyXCnOkgwQ7djXUB4hCBiDldGq6je73LuWtr2Dg
         fkRLdg4h85GiqAFbdwuHH5Fjdjwuzk7rJjdlgzBvwtZ4H5beI8UDbOS1WfMwx/YxWbQO
         Sitg==
X-Gm-Message-State: ANoB5plX4dFubTcbfvwTt5E+Nd6OedRTUpqnwABlrabhcjXw0QZFOjQ4
        2U+2LutTGKLrxeGMRcx8iRg=
X-Google-Smtp-Source: AA0mqf5wE1S5mLgKCd2OMeCBlex3zOQnN9+29JIVAUdfIe/x6QNmiCbJvOOyAEfXEYVKqCsMe8vcmg==
X-Received: by 2002:a05:600c:6006:b0:3cf:45ff:aca with SMTP id az6-20020a05600c600600b003cf45ff0acamr8119832wmb.53.1668437225787;
        Mon, 14 Nov 2022 06:47:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003c6f426467fsm20090378wmq.40.2022.11.14.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:47:05 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:47:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 07/28] rust: macros: take string literals in `module!`
Message-ID: <Y3JU5xAGv3bNG7q2@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-8-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-8-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:19PM +0100, Miguel Ojeda wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Instead of taking binary string literals, take string ones instead,
> making it easier for users to define a module, i.e. instead of
> calling `module!` like:
> 
>     module! {
>         ...
>         name: b"rust_minimal",
>         ...
>     }
> 
> now it is called as:
> 
>     module! {
>         ...
>         name: "rust_minimal",
>         ...
>     }
> 
> Module names, aliases and license strings are restricted to
> ASCII only. However, the author and the description allows UTF-8.

What's the rationale behind allowing UTF-8? Why not stick with ASCII
only?

Thanks,
Wei.
