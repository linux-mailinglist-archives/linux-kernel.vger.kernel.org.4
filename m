Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7468A0F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjBCR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjBCRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:55:58 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2C3EC56;
        Fri,  3 Feb 2023 09:55:48 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A32332E0;
        Fri,  3 Feb 2023 17:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A32332E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675446947; bh=VYi16ehBmyhfupPFd4/NkPorFNC2ZMFMOUZS5/YwQIs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D828BM4m95HbJCc5aytQ5d2iItwfjzbz7QhtSHVo7BJozDc5O70vpn0XURojqsc1C
         VkrfHsELQ2EmGMVYyUeWr3UV05n2JUAp6u9Q6fi6lrOd0doSMr5Td4JBe0fZsSJynI
         2Ct+9TFVSsOC9r/rHNCod7VhhstHlK+OWl7i0YSbpMGeKG8D4j6CUJR07q0HfFyPnV
         AmqrrMuCPDc4TxzNJ7GE4IJJdPNQohHpYhlJDmnx048A8PLf/kVK69bIG+vgFqnq0l
         asNimCUfdklVgBHsPsqjwPGA64RR8uOo81Q/O4YzGsoO3S29ryvatPqnOQDJp8D1sV
         K441V68eNGgAw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        jani.nikula@linux.intel.com, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, bilbao@vt.edu,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v6 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <20230127165728.119507-1-carlos.bilbao@amd.com>
References: <20230127165728.119507-1-carlos.bilbao@amd.com>
Date:   Fri, 03 Feb 2023 10:55:46 -0700
Message-ID: <87pmaqskf1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Include HTML output generated with rustdoc into the Linux kernel
> documentation on Rust.
>
> Carlos Bilbao:
>  docs: Move rustdoc output, cross-reference it
>  docs: Integrate rustdoc generation into htmldocs
>
So I spent a fair while messing with this, really hoping to get it
merged for 6.3, but I think it's still just too fragile.

- With a too-new version of bindgen it kills the htmldocs build
  entirely.  If we can't build the Rust docs successfully with the
  toolchain that the user has installed then so be it, but it shouldn't
  wreck the docs build entirely.

- It still throws the user into the "make oldconfig" process, which is
  unexpected for a docs build.  This happens even on a system with no
  Rust installed at all.

- I dumped my Fedora toolchain and did the curl|bash ritual to set up
  the proper versions with rustup.  It would be nice to have some better
  documentation on how to do that ... *how* to install bindgen may not
  be obvious to all users.  It also failed until I installed lld
  separately.

On a system with the right tool versions, and with a kernel already
configured to build the Rust support, it worked nicely, though.

I'd really like to see a solution that (1) doesn't kill the docs build
process if the tool versions are wrong, and (2) doesn't force the
creation of a kernel configuration.  What are our chances of getting
there?

Thanks,

jon
