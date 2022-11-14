Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4F6282E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiKNOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiKNOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:40:30 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284CD2C66C;
        Mon, 14 Nov 2022 06:40:29 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id cl5so18638913wrb.9;
        Mon, 14 Nov 2022 06:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjVZf+mxWBKV9Vk3O4dkAv2lEuk8DHfwjrkqwLaDClY=;
        b=i6R6Axha3UyoAPy8lq+mc1P2kGiqku5nX6EDpPsOdNOGNbTLAS9LaUshfAi/TUzMYv
         NAbeZIBNIZuFzrzN8YEulOVRbXgmNZNwvYRaSnbommxDYr1JsKf+oEFxiAT6aqqH2D7v
         at0djkB4cJaAye2fhgbQciFLDBR+wyJG5FkHUr+VPbn2MroNvheFX4sdClnXXkwCCE9L
         VFS3fgQKtZJEmxMgt3B+3Z1qtkVV9WuqVsNfb8v+2AY0l/Y+bQoNqL4wczqCAMGDu6zv
         MgfuS3P360g3tejCHvOqPVg9mKkeZ+Bx1pcu+N9CwCUmNIW1LH/vjl3bg6dFSwJhtp+z
         kizg==
X-Gm-Message-State: ANoB5pkND2Kg0sRA0Tll05lhipmU7gHXQxZi9QjOSZK6qDkz3kQ/xv1M
        XkZW7cMtyMXS5SBq0ARmE/0=
X-Google-Smtp-Source: AA0mqf4DmpPoVZ+6HRIr/baXFhrgBeJ+cJztZuX+npz6FixFFaPWN2PaoUw6Sx6YigXPZt8cJlTMRA==
X-Received: by 2002:adf:e80e:0:b0:22e:3e28:f8de with SMTP id o14-20020adfe80e000000b0022e3e28f8demr7995940wrm.157.1668436827721;
        Mon, 14 Nov 2022 06:40:27 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b0022ac672654dsm9618991wrx.58.2022.11.14.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:40:27 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:40:25 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 01/28] rust: prelude: split re-exports into groups
Message-ID: <Y3JTWdYNijRZmwUi@liuwe-devbox-debian-v2>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-2-ojeda@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:13PM +0100, Miguel Ojeda wrote:
> Split the prelude re-exports into groups: first the ones coming
> from the `core` crate, then `alloc`, then our own crates and
> finally the ones from modules from `kernel` itself (i.e. `super`).
> 
> We are doing this manually for the moment, but ideally, long-term,
> this could be automated via `rustfmt` with options such as
> `group_imports` and `imports_granularity` (both currently unstable).
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
