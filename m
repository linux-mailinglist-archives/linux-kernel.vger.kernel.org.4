Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE05A707481
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEQVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQVsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:48:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75489559D;
        Wed, 17 May 2023 14:48:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso1143612a91.0;
        Wed, 17 May 2023 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684360102; x=1686952102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FStjf9C3WAEWXLqC6o0Who1T5bvYtIEGryJ/iVLlrM0=;
        b=AC9jzisVW8MFHxu7vJg4gBMsQyCMhJgz8aL2Y6dD29NXcqJfdot/KWUc41EBB9WCYy
         XxUz0HJOc4js3aTYnmwHr+z3xqHtpSp1lIHvD2kiq0xlRIlDDu1kH04RRqTtbV74ZHWQ
         YhLd2PT+w5huyT2CQu6thlNr5yox+ZIKGLw5wmQvxj++XeCIpup4RTfO2wIwTPAfZh1u
         gsKPVg9QSMnoKPKgKEfoHpCMTgRugvSusdvgs9Pq084gfGa9ntFKQG3PgjaL49GnKfMY
         NlLS16gxgTIQ4YsmRbu7yJynAJOnq8nlZaonCLymc6P099hu5XAJo2ZnRL7bffHsFrY8
         jajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360102; x=1686952102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FStjf9C3WAEWXLqC6o0Who1T5bvYtIEGryJ/iVLlrM0=;
        b=Atu2743ga18X/hgGhKp7uEyKVWpAUiI2spP7iDRWVc8TKMXf8ymCZCTo7L8ks+QHdq
         GCYxu0r/HRif7+mWgnZ35GlV6+vdmXaiNsKLBvxItd9pu0sQoIakiYrsj1d8henLbxI7
         Qwegq/ozLk0IZ6SiB0u5zJkbPkqBaO2vvmZS9U/grku3ob1A0JomKdkSmIrD5TKWMaz/
         /n8WXB3yQR8hocjimxlymsBo0xTtadpXLkq7/bAKHnty98PGUnuBqvS+6WZcQALrpuYa
         oirBtOhxE3UTY/bMdPr5syYrY+y2zix5W+DHWq0iW1gcP/iZ1sGpR1y5WB8HgPXN2QvP
         enIQ==
X-Gm-Message-State: AC+VfDxtXn4YQXMnnLotQ+M8CD78z4gbGjKpoIC0rKEmE6Z95vkQWfLH
        1SgsWz7o2w1zG3GNFHJvS6Q=
X-Google-Smtp-Source: ACHHUZ6652DzpGfHOi7OAYBq+TgOZQNW0wXBYSOttt6rDSYXPr3C1VNh7PjvQlrvz/zDcwGJQ1spKQ==
X-Received: by 2002:a17:902:ee42:b0:1ac:753a:7933 with SMTP id 2-20020a170902ee4200b001ac753a7933mr205075plo.39.1684360101434;
        Wed, 17 May 2023 14:48:21 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090341d000b001a98f064a2asm18129670ple.48.2023.05.17.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:48:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 May 2023 11:48:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 0/7] Bindings for the workqueue
Message-ID: <ZGVLo1V4kjx_lep5@slm.duckdns.org>
References: <20230517203119.3160435-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517203119.3160435-1-aliceryhl@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alice.

On Wed, May 17, 2023 at 08:31:12PM +0000, Alice Ryhl wrote:
> This patchset contains bindings for the kernel workqueue.
> 
> One of the primary goals behind the design used in this patch is that we
> must support embedding the `work_struct` as a field in user-provided
> types, because this allows you to submit things to the workqueue without
> having to allocate, making the submission infallible. If we didn't have
> to support this, then the patch would be much simpler. One of the main
> things that make it complicated is that we must ensure that the function
> pointer in the `work_struct` is compatible with the struct it is
> contained within.
> 
> This patch could be significantly simplified if we already had the field
> projection bindings. However, we have decided to upstream the current
> version that does not depend on field projection first - the PR that
> introduces field projections will then include a commit that simplifies
> the workqueue implementation. (In particular, it would simplify the 5th
> patch in this series.)
> 
> The first version of the workqueue bindings was written by Wedson, but
> I have rewritten much of it so that it uses the pin-init infrastructure
> and can be used with containers other than `Arc`.

I tried to read the patches but am too dumb to understand much. Any chance
you can provide some examples so that I can at least imagine how workqueue
would be used from rust side?

Thanks.

-- 
tejun
