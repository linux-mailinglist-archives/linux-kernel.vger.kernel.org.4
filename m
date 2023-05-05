Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D336F7C10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjEEEtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEEEtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:49:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45049124B7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 21:49:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so1970907a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 21:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683262159; x=1685854159;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=N2zbrHcUouESPVHay4P1zwvcufLarr7zD3QUsuo1w5w=;
        b=wbp07luU05fSmqRdPobU4v9TaDXxVfm1rWwZNPQ69qtS+IYU+QsZfB0/iDd0RCiiu8
         8GVUTu7fizsoncqab9+xKjms+K7WqCKsDWxrfK8x/jFHoRtDpYqj5BE0kqryuFc8hdd6
         ZR/y9KcDxPJaYWrAHUCBz4bUHEZLTn73LgkQp5/7GpEeoji2LCJg+z1R/Qo/0EYkZf8N
         8X37WJEvm7XMujz9AwalhAAshGPlvfqDNjOSqkYFCIvh3OFlIPCmpHP4Rp7qLzk70Bu+
         B1yh0oBBAu2JNUvssZMgMVsg8TsuCRXVf6WonHmgwipgWt+nFHKlIoZCRw5S0uvWd63S
         en/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683262159; x=1685854159;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2zbrHcUouESPVHay4P1zwvcufLarr7zD3QUsuo1w5w=;
        b=TOFQDgcEIkblCtexgvbvEacQ0FFbriJNvv0GHiJcDnsA87+qVmxDvPGEjkfnzD5WAW
         a9azMJROS8mwFBliuuc9YQBlL5nCbyn/SEERiniJch9XxXAHZP/66g9uJ3T2HVmCu6Zx
         LlxKu/xanHjBvC0XgR4RX9so6ZdPz7ZlFo9r+IiLFmzXsVBT8muz8j3e1YYYQ4wpPRqu
         KKq+aahu/vHuS+3VSibtPnHnsDZo/ZDwWWGd+5GRs6C3AjGa3BgE6lLF//fGuA53osOx
         zZMAWlSlBnpuqIeKx24e7g522/M2by7GF4A1y5AX2b0EgLeSXyR+V6XMptbPPxeAUN2i
         cwEw==
X-Gm-Message-State: AC+VfDx2hQEY97KDG5Hy6tvrY5xIwGIjdvWYbkvuaDgTgSsq7k+21LE6
        RsdpS4cJkgnt28iIN3vzPXuuNw==
X-Google-Smtp-Source: ACHHUZ5rINGkrwWOV4HU8/PXlCJtfo5e3MvkAmxVTmSWGvISLqXMtwmSPP6+uHg6Be3H3bKM/eUoGg==
X-Received: by 2002:a05:6402:414:b0:50b:c0ce:d55 with SMTP id q20-20020a056402041400b0050bc0ce0d55mr275206edv.3.1683262158712;
        Thu, 04 May 2023 21:49:18 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id h13-20020a50ed8d000000b0050504648fc4sm2545633edr.80.2023.05.04.21.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:49:18 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-3-nmi@metaspace.dk>
 <ZFSBkFuvJOiz600W@casper.infradead.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 02/11] rust: add `pages` module for handling page
 allocation
Date:   Fri, 05 May 2023 06:42:02 +0200
In-reply-to: <ZFSBkFuvJOiz600W@casper.infradead.org>
Message-ID: <871qjvtmb5.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Wed, May 03, 2023 at 11:06:59AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> This patch adds support for working with pages of order 0. Support for pages
>> with higher order is deferred. Page allocation flags are fixed in this patch.
>> Future work might allow the user to specify allocation flags.
>> 
>> This patch is a heavily modified version of code available in the rust tree [1],
>> primarily adding support for multiple page mapping strategies.
>
> This also seems misaligned with the direction of Linux development.
> Folios are the future, pages are legacy.  Please, ask about what's
> going on before wasting time on the past.

I see, thanks for the heads up! In this case I wanted to do an
apples-apples comparison to the C null_blk driver. Since that is using
kmap I wanted to have that. But let's bind to the folio_* APIs in the
future, that would make sense.

Best regards
Andreas

