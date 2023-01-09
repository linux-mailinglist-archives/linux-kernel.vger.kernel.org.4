Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E43662C55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjAIRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjAIRKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:10:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E94D723;
        Mon,  9 Jan 2023 09:09:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1996D61221;
        Mon,  9 Jan 2023 17:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D39C433D2;
        Mon,  9 Jan 2023 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673284158;
        bh=2nQaI7Jt8+dS1/K4JwljCX/V5m1hrZch0m+SlDMkERA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONxwBl0y0KWmwBNXYdpvOf7F6tca/Gadpdze7ah7QCG6Q0ErBZQgQt0ZOSa5TJOTw
         98MChJ34JEYVFLqN2cguPCATTTMou3LdKiVoc7qdojpZKLPL5W5q6glc4o3Jbh/G7v
         9tZFatWxspvsNMr4OQxFqHE1saNFupcqJLDjqxGSO1NwQQdcP+OASIKMiztNOaD1yU
         FUvYUnau7AHeZt6kv2nSSGl1sWy/IvxfldGdbcwg89Wkgv7idTW1kbv1anJe5r0Qw4
         93AaiAV7uFOfdsBc+lRVR+Kwz5i0U43rdGUeEiBUB0GT8nnh9rHmp0xXSGC3nV4IEs
         /kgDpkAhV1FIQ==
Date:   Mon, 9 Jan 2023 10:09:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>,
        Michael Matz <matz@suse.de>
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <Y7xKO8IYINf9CcNI@dev-arch.thelio-3990X>
References: <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
 <Y67IlthBqaX69RwN@zn.tnic>
 <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com>
 <Y7dZwWsiUfHKxN3S@zn.tnic>
 <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com>
 <Y7lSZerjPghqllWp@zn.tnic>
 <08115444-73a3-b9b0-dbeb-2a0cf374290e@huawei.com>
 <Y7v/ZVTeQCw7Hv8g@zn.tnic>
 <88dbc59d-1a33-26be-7fd3-0fcdfef33b3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88dbc59d-1a33-26be-7fd3-0fcdfef33b3a@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:32:09PM +0800, Miaohe Lin wrote:
> On 2023/1/9 19:49, Borislav Petkov wrote:
> > On Mon, Jan 09, 2023 at 09:48:50AM +0800, Miaohe Lin wrote:
> >> Oh, sorry, I miss-read that. My compiler is gcc-7.3.0 which contains many
> >> in-house codes from our company in it. That might matters. Thanks a lot for
> >> your guidance. :)
> > 
> > Yah, next time, before you report something like that, try to reproduce it with
> > an official compiler (gcc from the upstream repo, SUSE, Debian, RH-built etc).
> > 
> > If it doesn't reproduce, go complain to the folks who hack your in-house
> > compiler.
> 
> Sorry, my bad! I thought my compiler is just as same as upstream one... Many thanks for your time.

Just for the future, in case you were not aware of it, Arnd provides
vanilla GCC toolchains, which can be really helpful for ruling out
(or blaming) downstream compiler patches as the cause of problems:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

You might not run into this problem again but if you do, it might save
some time :)

Cheers,
Nathan
