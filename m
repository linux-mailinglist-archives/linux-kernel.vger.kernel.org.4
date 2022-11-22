Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1E6331E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiKVBJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiKVBJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:09:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062E51C3E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:07:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A081061511
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3139C433C1;
        Tue, 22 Nov 2022 01:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669079275;
        bh=FEHU+EA0QIJa2/Zyh7aNKFWHV9/Z3wyDKiYpKyAXro4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oHLX+xi6GPTX6AfGjrrOIE4Aauvnpyh/vYHM1v7YLLm4PiUoH5m6II9+WMHsKJAPA
         Vx7UUJuJkmf4CnARym4fpsszBg9S9EHQkkEZOAsZ0bpPJtlECj+lSe/+xqNBmR3erX
         9sUZvmebzTs++hvQpiaAlIPznHvgYM8A/jCgpghs=
Date:   Mon, 21 Nov 2022 17:07:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     <yang.yang29@zte.com.cn>
Cc:     <wuchi.zero@gmail.com>, <axboe@kernel.dk>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>
Subject: Re: [PATCH linux-next] relay: use strscpy() is more robust and
 safer
Message-Id: <20221121170754.b5f7f57960596a146832d189@linux-foundation.org>
In-Reply-To: <202211220853259244666@zte.com.cn>
References: <202211220853259244666@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 08:53:25 +0800 (CST) <yang.yang29@zte.com.cn> wrote:

> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.

I really see no benefit to this switch in this situation.  What am I
missing?

But I guess this:

hp2:/usr/src/linux-6.1-rc4> grep -r strlcpy . | wc
    400    1913   34402
hp2:/usr/src/linux-6.1-rc4> grep -r strscpy . | wc 
   2824   11990  266471

is a good enough reason for applying.

