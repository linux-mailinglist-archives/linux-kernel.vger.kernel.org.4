Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622CC67DB1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 02:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjA0BMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 20:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjA0BMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:12:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481550840;
        Thu, 26 Jan 2023 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4li8EqnqSTnx1d7CO/b/vL4I87sOQhY49XfTNCTRj0A=; b=Mg9u+WYhHciOxQ8zud7hLB9wLG
        pmOk/ySfXKPE8YbfreaimjAB0kY4Dbt/q+mL1v0jtTd3gby6kmeGmEFFEQTKPudoQgfjy1e8R62/c
        bRopvhAqgpt0z0nBYKddDZ4Vsx2xjnYjcCCX1+fK+gxrzFBf7ul9WP1/hvPqYYWiemo1bK4OLZ85g
        w5c3dFMq+Q6qP4UHXlxYJH5ekS2O67U7RsFmdPRpmggA97LjsQa70UXjJU0WrcUJWXa65nZJT/0Pj
        nQjdg/aC+0V8tIsrsT7Y6CbCWAPlnOLocC7FEnjndTHbZarkONNoVsIScLNsmq6/axrRalUtuMjaU
        Y9LslHEg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLDHo-00D3ft-01; Fri, 27 Jan 2023 01:12:12 +0000
Message-ID: <641836b3-2378-c728-696a-03a42ab11bc8@infradead.org>
Date:   Thu, 26 Jan 2023 17:12:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] printk: Document that CONFIG_BOOT_PRINTK_DELAY
 required for boot_delay=
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20230126225420.1320276-1-helgaas@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230126225420.1320276-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/23 14:54, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Document the fact that CONFIG_BOOT_PRINTK_DELAY must be enabled for the
> "boot_delay" kernel parameter to work.  Also mention that "lpj=" may be
> necessary.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes from v1 (https://lore.kernel.org/all/20230123180440.901793-1-helgaas@kernel.org/):
> - Clarify use of "lpj=".  Reword consequences of delay larger than 10000.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..814e58487239 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -480,8 +480,10 @@
>  			See Documentation/block/cmdline-partition.rst
>  
>  	boot_delay=	Milliseconds to delay each printk during boot.
> -			Values larger than 10 seconds (10000) are changed to
> -			no delay (0).
> +			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
> +			and you may also have to specify "lpj=".  Boot_delay
> +			values larger than 10 seconds (10000) are assumed
> +			erroneous and ignored.
>  			Format: integer
>  
>  	bootconfig	[KNL]

-- 
~Randy
