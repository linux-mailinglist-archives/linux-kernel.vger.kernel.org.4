Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5B965B849
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjABXyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjABXyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:54:01 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4133060DE;
        Mon,  2 Jan 2023 15:54:00 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C62372C8;
        Mon,  2 Jan 2023 23:53:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C62372C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672703639; bh=avP7SOJdHkgVb2BCcWl6rx6zsHzyw9Bd6lyElnyQWOM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gz3B5hm3TeOraHRKWG6FsC7XiGNBc4bA09r1Gj8iDH5nt19gd+TlPX//MhQTbNERV
         tYtFEJCk+kXdFmCx3qcnFn9eN2gVvyRcT3bpLResS87vWLl0X4H3rnYc9GIBJrArH3
         3hRqIGkyuqMaPD19JUa/G/RjQjQr4S3Y3ffOSlq9qbCxogtmg4kKQC4XEyrHKOGulJ
         e4qZLd/Puo/5LEuSSLWQgvZeEcfiIvmeKPuLL18fJpbz7ISXi8HV6rOZ3I2JmIygdw
         6GvXns3XolOJ8/5dxjCoWzJAHWn3YPf47lob/9g5JtZilw4Q8nnQ+VotyZHbGwItlV
         +Oo63s6zO86yw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        akiyks@gmail.com, jani.nikula@linux.intel.com,
        rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v5 0/2] docs: Integrate rustdoc into Rust documentation
In-Reply-To: <20221228174623.144199-1-carlos.bilbao@amd.com>
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221228174623.144199-1-carlos.bilbao@amd.com>
Date:   Mon, 02 Jan 2023 16:53:58 -0700
Message-ID: <87wn64fq7d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

OK, so I just gave this a try...

- It forces the generation of a kernel configuration, something that the
  docs build has never done until now.  What are our changes of
  eliminating that?

- It did a bunch of other building, starting with objtool - again, never
  needed for the docs build before.

In the end, it died with:

> BINDGEN rust/bindings/bindings_generated.rs
> Failed to run rustfmt: No such file or directory (os error 2) (non-fatal, continuing)
>   BINDGEN rust/bindings/bindings_helpers_generated.rs
> error: Found argument '--blacklist-type' which wasn't expected, or isn't valid in this context
> 
> 	Did you mean '--blocklist-type'?

Perhaps this is because I ignored the warnings about my Rust toolchain
being too new? (Rust 1.65.0, bindgen 0.63.0).  I get that only one
version is really supported, but it would be nice to fail a bit more
gracefully if at all possible.

Anyway, I've unapplied these for now; thoughts on all this?

Thanks,

jon
