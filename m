Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F806C97A7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCZTvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 15:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZTvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 15:51:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764AF46AF;
        Sun, 26 Mar 2023 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=budMwMqW8tIuFTIfePqvZbV0rAEQ+HiaEFGnaM9O8SA=; b=AUYfY4kAEcGeAfh53LuHc4dHqt
        PH1KTT9M0FEEbntpKkczLb5/r2ticvR+B4PFq4FGK8xR8OUTTxdianF/FBkQWgmeJ2S/eln4U8LP7
        cpvvHUXS3SsXiKWaXO/ONIcu6JVtD5BK9FR4mlyBxKrePYCKHYfdGwwM1zZB+8+RTgodemMnzcnPQ
        xQm1kBuVjoR0DE99q1GX9COPjXaCBGfu98axD+v7PyIjYuhGWuqN8p9Pv4WOdXjQsqbsBd+pc8Bmy
        +ZfZ1Ca7A57Vx5n4OEtr0hPbXdRA4juMdufcrYKKjq34ZmfHwrvz5piLsD6LNZYMG/Cm3zPk50YJH
        E33h3Rnw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgWOx-00980k-2M;
        Sun, 26 Mar 2023 19:51:39 +0000
Message-ID: <4de7483e-2240-5a81-e3e8-af7b658695eb@infradead.org>
Date:   Sun, 26 Mar 2023 12:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ELF: document some de-facto PT_* ABI quirks
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 3/26/23 09:49, Alexey Dobriyan wrote:
> Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
> program headers are slightly different.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> 	v2: integrate into documentation build system
> 
>  Documentation/ELF/ELF.rst   |   32 ++++++++++++++++++++++++++++++++
>  Documentation/ELF/index.rst |   10 ++++++++++
>  Documentation/index.rst     |    1 +
>  3 files changed, 43 insertions(+)

I'm not sure that ELF merits its own subdirectory or that each item here
should be a chapter,  but this fixes all of the issues that I pointed out. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> new file mode 100644
> --- /dev/null
> +++ b/Documentation/ELF/ELF.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================================
> +Linux-specific ELF idiosyncrasies
> +=================================
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
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/ELF/index.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===
> +ELF
> +===
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   ELF
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -113,6 +113,7 @@ to ReStructured Text format, or are simply too old.
>     :maxdepth: 1
>  
>     staging/index
> +   ELF/index
>  
>  
>  Translations

-- 
~Randy
