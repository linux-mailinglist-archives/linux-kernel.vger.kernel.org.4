Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE422602E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJROMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJROLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:11:36 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE97D78E;
        Tue, 18 Oct 2022 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j86gyI86b1ZCBfCx7LMeZ2ebnxH6k+wMdKl4XDSS43U=; b=JGiKivI9rOFU0nX92BHk01p0ZO
        tnzVZKP+YZFd2bNPGOkKSmXr5oH/8XIs+/y3U5M3zKAD2nG0jWezbwcZFmqoUs/Pli3e5Sqqp5QFN
        SJYsWCca1jAuUGuupyWk2e8eUXmmDUzbalU8W/ym/udYJ8+QzSWepguZYvMk1bRgHCFUeZ3wOOR+6
        XWCqDlPbRod/fMF46OxnbAH+zkBCg0bTqUjz3fhsDEDNKNNXJ0DLWtRHOn4GpENFIulckmDNUy70V
        jI4N5hLkUSZMY6cG6VNsCjeq0W20dSNNvC/E1DqVvhPG0Mp2kCf5I28COq33/QUDwYxxB1URbydT/
        /73I0g7Q==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oknJ6-0013bB-B1; Tue, 18 Oct 2022 16:11:00 +0200
Message-ID: <8d40dad4-4b20-2ec3-a8e1-706dd415f0d2@igalia.com>
Date:   Tue, 18 Oct 2022 11:10:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 0/5] pstore: Use zstd directly by default for compression
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221018020519.never.337-kees@kernel.org>
 <CAMj1kXGjF63wK7m8BqC=WX6sA425BTVwQWk9ERN3gG8s==4mjw@mail.gmail.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXGjF63wK7m8BqC=WX6sA425BTVwQWk9ERN3gG8s==4mjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 05:20, Ard Biesheuvel wrote:
> [...]
> So again, I suggest to simply drop this non-feature, and standardize
> on either zlib or zstd using the library interface exclusively. If
> someone present a compelling use case, we can always consider adding
> it back in some form.
> 
> As for the choice of algorithm, given the equal performance using the
> default compression level, and the difference in code size, I don't
> see why zstd should be preferred here. If anything, it only increases
> the likelihood of hitting another error if we are panicking due to
> some memory corruption issue.

I think it's a good argument - would zlib be simpler in code than zstd?
I've checked the zstd patch from Kees - not complex per se, but would be
great if we could have a simple mechanism, without the need of the ifdef
there for example...

Cheers,


Guilherme
