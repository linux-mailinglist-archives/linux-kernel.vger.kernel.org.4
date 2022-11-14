Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC206282E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiKNOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiKNOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:41:05 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75C2B242;
        Mon, 14 Nov 2022 06:41:02 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso8062732wmo.1;
        Mon, 14 Nov 2022 06:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2XGpRVkoLcHrK4SdNeUCfF/+fZQfRpvuPV7B8PRXUk=;
        b=aAVYK1NU68CCVIwRWErurCNYrbOGtOIlKJkOGphkNudkh1AwburO+HOqwlgzjPC69u
         S73Ys4wN1AZ5jbSJ9pShuoHNZkjh9lqqROUfIkr95Pd+KR3N3eFLzsBAruVC5JuWj42X
         lOuDB4QYUveFkXfzd9Yc3bIZXoFGH8GLtAqdfgybYZjt77BLQXni51Ph45MdlTipXDib
         f93x6AwKuHEvmA+LxC/gYBLRRJ05n5nq983C1O3kVBYwvmbIwSQhNyJ7NAOR9DuQ3ovR
         he6LiIqsgARY/+x8InX6Qj8A0JveZv4AMSu8Afg49edXzfxwTxNpM+89zyITvfqOd9LD
         2AQw==
X-Gm-Message-State: ANoB5pkT3q1IeQh9RLNAiGsts9uCc/bQ0pC4evPvQepiWiu/N8pwGmUh
        Z+zdUJ4IDFhRQ6ojxlnGtsg=
X-Google-Smtp-Source: AA0mqf6K7lETjAus41mGe4n7aRQ1xnrRmdVD376b1yWbbN5z6Pazk7VE7IAy5LFXcnMYzW/bcIE3fg==
X-Received: by 2002:a05:600c:1c06:b0:3c3:77c2:cfff with SMTP id j6-20020a05600c1c0600b003c377c2cfffmr7978664wms.171.1668436861234;
        Mon, 14 Nov 2022 06:41:01 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0022e344a63c7sm9760993wrp.92.2022.11.14.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:41:00 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:40:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 03/28] rust: print: add `pr_cont!` macro
Message-ID: <Y3JTelPR1zXgaDV8@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-4-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-4-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:15PM +0100, Miguel Ojeda wrote:
> This level is a bit different from the rest since it does not
> pass the module name to the `_printk()` call.
> 
> Thus add a new parameter to the general `print_macro!` to
> handle it differently.
> 
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
