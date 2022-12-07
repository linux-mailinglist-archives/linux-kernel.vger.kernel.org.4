Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16368644FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLGAGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLGAG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:06:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAC131;
        Tue,  6 Dec 2022 16:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=p1wOiIfc+a4pCzMjBOs4Bm1NL5HxcZtXMxPYcz1MUfc=; b=IJ5v6Yh54UMyU/IzKFFJkP5IpC
        RzgDR5aPwuvnOeyuYigSl9SEBhA6VBUxZUQ2Em5l3u3scY8WOe4XMhRvZkXGs/DiwTmQi1X718cO1
        CHLU29OqKGdwR6RuN4uKW4RUGN3jeaAbxKMO2Uh0KrN8IdYQQf9lwOK5Ci3vO7EAvpk7aQ2/Yv6JW
        uAGRcQitj1/Nkv+S/XD7xfQR5WqbbWPCbPeUvNLGmXLuF2UlDiciv21G1TslnqB2T5/TKjEfhjCfJ
        3WmzzA91AT6y2i+9z02pahJoWFdrtBNaeTZr3J+gCcVd7fM4mcRw8Nkiw7qmciIHAOL8IxqVo+9do
        0Hm+xb0w==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2hx3-00623S-Am; Wed, 07 Dec 2022 00:06:17 +0000
Message-ID: <0ac78a21-1fa3-8bbd-83c5-efdada189983@infradead.org>
Date:   Tue, 6 Dec 2022 16:06:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] docs: Integrate rustdoc generation into htmldocs
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-3-carlos.bilbao@amd.com>
 <6079a282-c802-9836-1ae7-d67526a205c9@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6079a282-c802-9836-1ae7-d67526a205c9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/22 15:11, Akira Yokosawa wrote:
> On Tue, 6 Dec 2022 09:31:51 -0600, Carlos Bilbao wrote:
>> Change target `make htmldocs` to combine RST Sphinx and the
>> generation of Rust documentation, when support is available.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  Documentation/Makefile | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 64d44c1ecad3..f537cf558af6 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>>  	fi
>>  
>>  htmldocs:
>> +# If Rust support is available, add rustdoc generated contents
>> +ifdef CONFIG_RUST
>> +	$(Q)$(MAKE) rustdoc
>> +endif
>>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>>  
> 
> What about patch below on top of this?
> This way, it is possible to skip rustdoc generation by saying:
> 
>     make CONFIG_RUST=n SPHINXDIRS=doc-guide htmldocs
> 
> The reordering is to complete Sphinx runs even if rustdoc generation
> ends up in error.
> 
> With this applied on top,
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> 
>         Thanks, Akira
> 

Oh yes, I like both of those changes.
Thanks.

> ------
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2cf3e0fd7839..4d334468aaaf 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -92,12 +92,12 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	fi
>  
>  htmldocs:
> +	@$(srctree)/scripts/sphinx-pre-install --version-check
> +	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>  # If Rust support is available, add rustdoc generated contents
> -ifdef CONFIG_RUST
> +ifeq ($(CONFIG_RUST),y)
>  	$(Q)$(MAKE) rustdoc
>  endif
> -	@$(srctree)/scripts/sphinx-pre-install --version-check
> -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>  
>  texinfodocs:
>  	@$(srctree)/scripts/sphinx-pre-install --version-check

-- 
~Randy
