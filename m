Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19E6BA542
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCOCeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCOCeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:34:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456932332B;
        Tue, 14 Mar 2023 19:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7Vv4GgSfma1E5qLrWxU5RdcBiWgWp2FnAi3GPVQ18Ss=; b=SLmnrq2XsLK5/HI1e14JtHv48Z
        9lJI6Coc6TQxc8NkcClaWb5A1K493NFd59PGXwCuFktp80ltuHzl/U0BY/8DftGWL/DU3WGlgnGMZ
        epLWoP6vG7vB7TOq+z+G7Za8CJFBNxtfT6ZDVqXvk5yeqKRy820uEngUMmr2Dzfj+Av9QgYH/R3DT
        DUKka9wCjiZVrR6Ow8kx44gCjLqmO7aK7qyI2BrvINaU8Jv7GRDzC4cpkiOXL+p8yRQeCBVs/QPY7
        PzP8ToPUOedAPCEAvptxCUNg+kI8Em318hIevBNzbyZvuojMcsZaTa4pdbI127oAsyiFrvHGqWRtn
        GE2TaO7g==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcGxx-00C3uO-00;
        Wed, 15 Mar 2023 02:34:13 +0000
Message-ID: <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
Date:   Tue, 14 Mar 2023 19:34:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ELF: document some de-facto PT_* ABI quirks
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[adding linux-doc for other interested parties]


On 3/14/23 10:02, Alexey Dobriyan wrote:
> Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
> segment headers are slightly different.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  Documentation/ELF/ELF.rst |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/ELF/ELF.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0

According to Documentation/doc-guide/sphinx.rst, "=" underlines are used
for chapters (by convention).

And could the document have a title, like:

=========================
ELF header usage in Linux
=========================

(I just made that up. Feel free to change it. :)

Also, the .rst file should be added to some chapter in the current
documentation tree, such as under "Other documentation", so add this file name
to Documentation/staging/index.rst. In fact this file could live in
Documentation/staging instead of in Documentation/ELF/ (IMO of course).


> +
> +Definitions
> +===========
> +
> +"First" program header is the one with the smallest offset in the file:
> +e_phoff. "Last" program header is the one with the biggest offset:
> +e_phoff + (e_phnum - 1) * sizeof(Elf_Phdr).
> +
> +PT_INTERP
> +=========
> +
> +First PT_INTERP program header is used to locate the filename of ELF
> +interpreter. Other PT_INTERP headers are ignored (since Linux 2.4.11).
> +
> +PT_GNU_STACK
> +============
> +
> +Last PT_GNU_STACK program header defines userspace stack executability
> +(since Linux 2.6.6). Other PT_GNU_STACK headers are ignored.
> +
> +PT_GNU_PROPERTY
> +===============
> +
> +ELF interpreter's last PT_GNU_PROPERTY program header is used (since
> +Linux 5.8). If interpreter doesn't have one, then the last PT_GNU_PROPERTY
> +program header of an executable is used. Other PT_GNU_PROPERTY headers
> +are ignored.

Thanks.
-- 
~Randy
