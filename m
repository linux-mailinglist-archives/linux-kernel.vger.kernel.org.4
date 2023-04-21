Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EBA6EA873
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDUKjf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 06:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:39:32 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACA9EF4;
        Fri, 21 Apr 2023 03:39:30 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ppoAm-001O5I-Af; Fri, 21 Apr 2023 12:39:24 +0200
Received: from p57bd9bea.dip0.t-ipconnect.de ([87.189.155.234] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ppoAm-001A7x-3T; Fri, 21 Apr 2023 12:39:24 +0200
Message-ID: <a4ddd8fd24247d660a4a7cbedd4de94228c59bc0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: sq: Use the bitmap API when applicable
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-sh@vger.kernel.org
Date:   Fri, 21 Apr 2023 12:39:23 +0200
In-Reply-To: <a51e9f32c19a007f4922943282cb12c89064440d.1681671848.git.christophe.jaillet@wanadoo.fr>
References: <a51e9f32c19a007f4922943282cb12c89064440d.1681671848.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.234
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-20 at 21:19 +0200, Christophe JAILLET wrote:
> Using the bitmap API is less verbose than hand writing it.
> It also improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2:
>    - synch with latest linux-next because of 80f746e2bd0e which fixes a bug
> ---
>  arch/sh/kernel/cpu/sh4/sq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> index 27f2e3da5aa2..d289e99dc118 100644
> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> @@ -372,7 +372,6 @@ static struct subsys_interface sq_interface = {
>  static int __init sq_api_init(void)
>  {
>  	unsigned int nr_pages = 0x04000000 >> PAGE_SHIFT;
> -	unsigned int size = (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
>  	int ret = -ENOMEM;
>  
>  	printk(KERN_NOTICE "sq: Registering store queue API.\n");
> @@ -382,7 +381,7 @@ static int __init sq_api_init(void)
>  	if (unlikely(!sq_cache))
>  		return ret;
>  
> -	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
> +	sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
>  	if (unlikely(!sq_bitmap))
>  		goto out;
>  
> @@ -393,7 +392,7 @@ static int __init sq_api_init(void)
>  	return 0;
>  
>  out:
> -	kfree(sq_bitmap);
> +	bitmap_free(sq_bitmap);
>  	kmem_cache_destroy(sq_cache);
>  
>  	return ret;
> @@ -402,7 +401,7 @@ static int __init sq_api_init(void)
>  static void __exit sq_api_exit(void)
>  {
>  	subsys_interface_unregister(&sq_interface);
> -	kfree(sq_bitmap);
> +	bitmap_free(sq_bitmap);
>  	kmem_cache_destroy(sq_cache);
>  }
>  

Applied to my for-next branch for 6.4.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
