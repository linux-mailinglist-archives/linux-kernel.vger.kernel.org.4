Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB826B35C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCJExG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJExE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:53:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862A102;
        Thu,  9 Mar 2023 20:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7pC1iFoKJeODKrdXQNEXQ2vdZiceo2NJsfdE8APVmhQ=; b=dpOTUfgxmIGcV8l02ShWupqS+J
        ekQP3T6mmK4PXZw8lwQnGYQHM63kPJY8ltWg+47CG2BoUJ+IX5ry4/GiN2GU/jupahfiHqIDdxtx9
        xpyGBUXAK5i1/AKfs8jS5yGWebF6r/+Xrv5xx3gewpP/Md//rNw5QslnEldPJOFSl176egt8PzwfM
        DnaoqSTPVatHfCrobBkKnIlYqk9fXsMi7laTT4VpM67hRC9lBDJapY/7Ht4b6aXo2KFAN4IjbGwOV
        8u4t6D4Kd4Gz17p38HYewmptlsDTSabMy8TatVF/TvKJ/DYWoKUK1k36i/O4oBxLZEXdn2phi/6Xc
        A131gStw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paUkV-00D37l-UJ; Fri, 10 Mar 2023 04:53:00 +0000
Message-ID: <b8e8e51e-1ccf-e413-0831-ae5f70da539b@infradead.org>
Date:   Thu, 9 Mar 2023 20:52:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] of: fix htmldocs build warning
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
 <20230310113258.463f836c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230310113258.463f836c@canb.auug.org.au>
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



On 3/9/23 16:32, Stephen Rothwell wrote:
> 
> Fix this htmldoc build warning:
> 
> include/linux/of.h:115: warning: cannot understand function prototype: 'const struct kobj_type of_node_ktype; '
> 
> Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creation functions")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

After this patch, there is another warning for this function:

../include/linux/of.h:118: warning: Excess function parameter 'phandle_name' description in 'of_node_init'

> ---
>  include/linux/of.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> This is actually untested, but seems pretty straight forward.
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0af611307db2..814d33f3835a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -100,6 +100,9 @@ struct of_reconfig_data {
>  	struct property		*old_prop;
>  };
>  
> +extern const struct kobj_type of_node_ktype;
> +extern const struct fwnode_operations of_fwnode_ops;
> +
>  /**
>   * of_node_init - initialize a devicetree node
>   * @node: Pointer to device node that has been created by kzalloc()
> @@ -111,9 +114,6 @@ struct of_reconfig_data {
>   * whether to free the memory will be done by node->release(), which is
>   * of_node_release().
>   */
> -/* initialize a node */
> -extern const struct kobj_type of_node_ktype;
> -extern const struct fwnode_operations of_fwnode_ops;
>  static inline void of_node_init(struct device_node *node)
>  {
>  #if defined(CONFIG_OF_KOBJ)

-- 
~Randy
