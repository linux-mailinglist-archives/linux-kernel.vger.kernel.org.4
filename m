Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC82B70CAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjEVU3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjEVU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B524B5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC11D6270C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF737C433D2;
        Mon, 22 May 2023 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684787332;
        bh=bGU6saSjKLHRGrxa9d+ZLVwV/rjNtkPuPdSib3psZA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bCTwi6wOM3T/5BM17n6r42tiV2BU9to0RAZrCsCPcb6ttCyDtYMWZtVt4NQdNEkdy
         pSLmlDfhzxsqRfkkGUqWlN2oUQRMlc5MCC1uhH5YC9q0kHrxucNOJwramUAvPKU4va
         4AfwmaD5HPOjsBd1scfVKU6DK1FEKE8BOtWqCTn8=
Date:   Mon, 22 May 2023 13:28:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap: refactor mlock_future_check()
Message-Id: <20230522132851.ccc9fafac91d7eb9ba922e94@linux-foundation.org>
In-Reply-To: <20230522082412.56685-1-lstoakes@gmail.com>
References: <20230522082412.56685-1-lstoakes@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 09:24:12 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> In all but one instance, mlock_future_check() is treated as a boolean
> function despite returning an error code. In one instance, this error code
> is ignored and replaced with -ENOMEM.
> 
> This is confusing, and the inversion of true -> failure, false -> success
> is not warranted. Convert the function to a bool, lightly refactor and
> return true if the check passes, false if not.

Yup.

I don't think the name does a good job of conveying the
function's use.

> -	if (mlock_future_check(mm, vm_flags, len))
> +	if (!mlock_future_check(mm, vm_flags, len))
>  		return -EAGAIN;

	if (!may_mlock_future(...))

or

	if (!mlock_future_ok(...))

?


