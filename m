Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325361A581
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKDXOW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Nov 2022 19:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDXOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:14:19 -0400
X-Greylist: delayed 519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Nov 2022 16:14:18 PDT
Received: from mail.lixid.net (lixid.tarent.de [193.107.123.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F25F5C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:14:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.lixid.net (MTA) with ESMTP id 2B297141234;
        Sat,  5 Nov 2022 00:05:38 +0100 (CET)
Received: from mail.lixid.net ([127.0.0.1])
        by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
        id t6OYJSqX3xUN; Sat,  5 Nov 2022 00:05:32 +0100 (CET)
Received: from x61w.mirbsd.org (vpn-172-34-0-14.dynamic.tarent.de [172.34.0.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lixid.net (MTA) with ESMTPS id 34E4A141142;
        Sat,  5 Nov 2022 00:05:31 +0100 (CET)
Received: by x61w.mirbsd.org (Postfix, from userid 1000)
        id B6FA761E89; Sat,  5 Nov 2022 00:05:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by x61w.mirbsd.org (Postfix) with ESMTP id B1FDC6006C;
        Sat,  5 Nov 2022 00:05:30 +0100 (CET)
Date:   Sat, 5 Nov 2022 00:05:30 +0100 (CET)
From:   Thorsten Glaser <t.glaser@tarent.de>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     linux-kernel@vger.kernel.org, ardb@kernel.org, arnd@arndb.de,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v2] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
In-Reply-To: <20220203161243.3955547-1-mark.rutland@arm.com>
Message-ID: <fcafd6d9-7d3e-67b0-3176-5fb8e9c322ef@tarent.de>
References: <20220203161243.3955547-1-mark.rutland@arm.com>
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022, Mark Rutland wrote:

> -	smp_store_release(&(v)->counter, i);
> +	if (__native_word(atomic_t)) {
> +		smp_store_release(&(v)->counter, i);
> +	} else {
> +		__atomic_release_fence();
> +		arch_atomic_set(v, i);
> +	}

Shouldn’t this also update Documentation/atomic_t.txt which
currently states:

| The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
| implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
| smp_store_release() respectively. Therefore, if you find yourself only using
| the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
| and are doing it wrong.

With this, direct use of atomic64_set_release() and atomic64_read_acquire()
is (IIUC) not “doing it wrong” any more?

bye,
//mirabilos
-- 
Infrastrukturexperte • tarent solutions GmbH
Am Dickobskreuz 10, D-53121 Bonn • http://www.tarent.de/
Telephon +49 228 54881-393 • Fax: +49 228 54881-235
HRB AG Bonn 5168 • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg

                        ****************************************************
/⁀\ The UTF-8 Ribbon
╲ ╱ Campaign against      Mit dem tarent-Newsletter nichts mehr verpassen:
 ╳  HTML eMail! Also,     https://www.tarent.de/newsletter
╱ ╲ header encryption!
                        ****************************************************
