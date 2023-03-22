Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816CE6C4F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCVPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCVPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:12:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BEC59E4C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=H46fc+UgiTMX/b3f90naW56UKVe5bC0EWkSvGxwamfc=; b=SzmrgpUGjbjY5PMen3uKU5eSl7
        d9BtkM6J+BCtpzt+oH/2ezC8psZmFRK1pPy2v35PezUYniRXN0rWJGFkSDnj7HXu4xQsdE0eSWBAW
        /M+v+VYKSgW1zHySIEpZsk8JqWW8709151PPsC/6YAVULxvBEsIuBHtkQfE9a+QHal9+a9INukIIk
        oTkgL+Ix0RsKeQW3w1c1nOg6iiUlfh8DRIOXweIlTZH6LNtTKW58kx0/PATjjvfSPbdtA7zhd8Mjr
        TsYx1sQ4spamdnsXwWiyXVWAaz8RQ/PneCvnq+IXa0fH7lqF99zf7omYpcfa8VmtRHICZvrxuVP75
        3POSEVHg==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pf08Y-00GSWY-0K;
        Wed, 22 Mar 2023 15:12:26 +0000
Message-ID: <061a2fea-b3da-551d-f6d2-0da30b0ac879@infradead.org>
Date:   Wed, 22 Mar 2023 08:12:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] staging: most: fix line ending with '('
Content-Language: en-US
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/22/23 08:01, Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl

Note that checkpatch is not always correct. It's a simple advisor.

> Move the function parameters right after the '(' in the function call
> line. Align the rest of the parameters to the opening parenthesis.

coding-style.rst does indeed say:

  A very commonly used style
  is to align descendants to a function open parenthesis.

That may be poorly worded. What it is trying to say is to align
the rest of the parameters to the first parameter immediately after
the open parenthesis, like this example from kernel/fork.c:

	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
				     VMALLOC_START, VMALLOC_END,
				     THREADINFO_GFP & ~__GFP_ACCOUNT,
				     PAGE_KERNEL,
				     0, node, __builtin_return_address(0));


And FTR, I still haven't found anything in coding-style.rst that says that
lines should not end with an open parenthesis.  Did I overlook it?

Thanks.

> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> 
> Changes in v2:
>  - Changed the description
> 
>  drivers/staging/most/dim2/hal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
> index a5d40b5b138a..6abe3ab2b2cf 100644
> --- a/drivers/staging/most/dim2/hal.c
> +++ b/drivers/staging/most/dim2/hal.c
> @@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
>  		dim2_clear_ctr(ctr_addr);
>  }
> 
> -static void dim2_configure_channel(
> -	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
> -	u16 packet_length)
> +static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
> +				   u16 hw_buffer_size, u16 packet_length)
>  {
>  	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
>  	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
> --
> 2.34.1
> 

-- 
~Randy
