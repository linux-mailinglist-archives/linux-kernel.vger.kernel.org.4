Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EE6F71F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjEDS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjEDS1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:27:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D776AE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:27:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965a68abfd4so154745466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683224833; x=1685816833;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=VIMgKLx654jhHRx4qIRTthK1ysjXXrrNqdoOVgSmOeE=;
        b=qU+Ug89ilc6WN9TDAJzjO2f/60V8+1eXF/EYEp3lE+kxcCO8muY745qsFg4YsxdLhM
         GFFdVNRZ2FzIT711c0qNXBZAs2ZsygMEjKETMcJC0wwNakwNctVl1INHAPzh7fC1LrMM
         tsyDEWeNJvvUTUwdmwd0RVxd1f1JvD/Wjz4SlJ6JL3WtA3sYNzVrm6pWpQ0q70dMNaR/
         HtvRLiiprdATGWlPxlk8i1r7DAaOmkgXfgl0Kk5tQAK1q5oMK7JWE4mGTEHSf7dh8bFa
         8z7Eq1g2UFrwsaFNvu+DQNyVcJCNQnRbbFq6u8q1J6YbU3wb/U047orn+37qTQXJfP60
         fMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224833; x=1685816833;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIMgKLx654jhHRx4qIRTthK1ysjXXrrNqdoOVgSmOeE=;
        b=QrHYgbsPvrQtHecRXmy9AVNuJY5X/3sMFRP1v07pWbAV8f8j9YVgqifiKrC/Kr38jZ
         HPna+tbt5nXl7M94P5hUJip9gSFWjqnlB13/m4Qa/5/LsQebSUHPU/dBUyDxCFCVztNw
         1Rrco4oxsFXlf350Z8TUYeO+yB8w0dDJT2iwtbHfZLHchdzRtljrmLLclm/JMKcIT4J5
         mTruxE6pSKVpzhFE+fvIU6hJIYiEnUMGO24mGifO8N2ekXbp1njKfn8TXqmW4FepuTvU
         nYrdmxmlFtv7faWy0TkZq74JG93VU3LhUxU1Vx2TxAkzVyfidjCBtCH1jk1b40mPFmpJ
         LLLQ==
X-Gm-Message-State: AC+VfDwYZQdKbBhwHUGKBoyPiKspA2nMonClrBWZ0XBfLbUGXvA/Uo9k
        appaNM4/putWZ6Gm9BizCeWgqg==
X-Google-Smtp-Source: ACHHUZ5dFQ2scibNXes6IJDnR0tdDuJuLNmlk0EA0qORzsVLoMVrcrrTq8YUAiE1JBAp9pWLKJIeyg==
X-Received: by 2002:a17:907:62aa:b0:961:a67:29c with SMTP id nd42-20020a17090762aa00b009610a67029cmr6647365ejc.70.1683224832922;
        Thu, 04 May 2023 11:27:12 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b009572db67bf2sm17304971ejc.89.2023.05.04.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:27:12 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Thu, 04 May 2023 20:15:23 +0200
In-reply-to: <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
Message-ID: <87jzxot0jk.fsf@metaspace.dk>
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


Hi Bart,

Bart Van Assche <bvanassche@acm.org> writes:

> On 5/3/23 02:06, Andreas Hindborg wrote:
>> This is an early preview of a null block driver written in Rust.
>
> It is not clear to me why this effort was started? As far as I know the null_blk
> driver is only used by kernel developers for testing kernel changes so end users
> are not affected by bugs in this driver. Additionally, performance of this
> driver is critical since this driver is used to measure block layer performance.
> Does this mean that C is a better choice than Rust for this driver?

I take it you did not read the rest of the cover letter. Let me quote
some of it here:

> A null block driver is a good opportunity to evaluate Rust bindings for the
> block layer. It is a small and simple driver and thus should be simple to reason
> about. Further, the null block driver is not usually deployed in production
> environments. Thus, it should be fairly straight forward to review, and any
> potential issues are not going to bring down any production workloads.
>
> Being small and simple, the null block driver is a good place to introduce the
> Linux kernel storage community to Rust. This will help prepare the community for
> future Rust projects and facilitate a better maintenance process for these
> projects.
>
> The statistics presented in my previous message [1] show that the C null block
> driver has had a significant amount of memory safety related problems in the
> past. 41% of fixes merged for the C null block driver are fixes for memory
> safety issues. This makes the null block driver a good candidate for rewriting
> in Rust.

In relation to performance, it turns out that there is not much of a
difference. For memory safety bugs - I think we are better off without
them, no matter if we are user facing or not.

If it is still unclear to you why this effort was started, please do let
me know and I shall try to clarify further :)

Best regards,
Andreas
