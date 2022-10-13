Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B4F5FD548
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJMG4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJMG4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:56:10 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23A4111B2E9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:56:05 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29D6u3sr016637;
        Thu, 13 Oct 2022 08:56:03 +0200
Date:   Thu, 13 Oct 2022 08:56:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc/string: fix memcmp() implementation
Message-ID: <20221013065603.GB16609@1wt.eu>
References: <20221010113606.2329457-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010113606.2329457-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Mon, Oct 10, 2022 at 01:36:06PM +0200, Rasmus Villemoes wrote:
> The C standard says that memcmp() must treat the buffers as consisting
> of "unsigned chars". If char happens to be unsigned, the casts are ok,
> but then obviously the c1 variable can never contain a negative
> value. And when char is signed, the casts are wrong, and there's still
> a problem with using an 8-bit quantity to hold the difference, because
> that can range from -255 to +255.
> 
> For example, assuming char is signed, comparing two 1-byte buffers,
> one containing 0x00 and another 0x80, the current implementation would
> return -128 for both memcmp(a, b, 1) and memcmp(b, a, 1), whereas one
> of those should of course return something positive.

You're totally right of course, thank you for spotting this one! I'm
queuing it now.

Regards,
Willy
