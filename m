Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7378767D98C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjAZXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjAZXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:20:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8A6A5F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:20:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640756197F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A8FC433D2;
        Thu, 26 Jan 2023 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674775225;
        bh=2bi/yWCYSEbTwdoD+ZRnucs0IxsKcEa74FkUlbYIl8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wfU526QeHtT25Dp80XTfipC5chr8bRteULrVAX3GXOkya9cbsZIy8wrbQ6brmYz0F
         vDGtdvSGZRQfERjweZU4px5C7Ix57ztsuDbAmmGFSywUjlhFzG0KOqtrvPm17eZhaV
         02GCDMBiwBb7OPcfnJtFBFIWpxTHuJ9C+PSjF7U4=
Date:   Thu, 26 Jan 2023 15:20:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] kasan: Fix Oops due to missing calls to
 kasan_arch_is_ready()
Message-Id: <20230126152024.bfdd25de2ff5107fa7c02986@linux-foundation.org>
In-Reply-To: <150768c55722311699fdcf8f5379e8256749f47d.1674716617.git.christophe.leroy@csgroup.eu>
References: <150768c55722311699fdcf8f5379e8256749f47d.1674716617.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 08:04:47 +0100 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> On powerpc64, you can build a kernel with KASAN as soon as you build it
> with RADIX MMU support. However if the CPU doesn't have RADIX MMU,
> KASAN isn't enabled at init and the following Oops is encountered.

Should we backport to -stable?  If so, can we identify a suitable Fixes: target?

Thanks.
