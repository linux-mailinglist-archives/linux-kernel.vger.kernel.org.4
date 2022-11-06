Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7787561E33D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKFPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKFPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:51:13 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D016DED9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:51:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 352822010B;
        Sun,  6 Nov 2022 16:51:10 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zKeRytKHzjnZ; Sun,  6 Nov 2022 16:51:10 +0100 (CET)
Received: from begin (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 85C4520107;
        Sun,  6 Nov 2022 16:51:09 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1orhvR-00DuLc-0S;
        Sun, 06 Nov 2022 16:51:09 +0100
Date:   Sun, 6 Nov 2022 16:51:09 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     wangkailong@jari.cn
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix warning comparing pointer to 0
Message-ID: <20221106155109.wh5ivhk2zc7cumn5@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        wangkailong@jari.cn, w.d.hubbs@gmail.com, chris@the-brannons.com,
        kirk@reisers.ca, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
References: <1de9cab8.c1.1844d7bdf4b.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de9cab8.c1.1844d7bdf4b.Coremail.wangkailong@jari.cn>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wangkailong@jari.cn, le dim. 06 nov. 2022 23:07:54 +0800, a ecrit:
> Fix the following coccicheck warning:
> 
> drivers/accessibility/speakup/utils.h:39:15-16: WARNING comparing
> pointer to 0

You're replacing it with the contrary of what it should be...

> ---
>  drivers/accessibility/speakup/utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
> index 4bf2ee8ac246..5803b521df2b 100644
> --- a/drivers/accessibility/speakup/utils.h
> +++ b/drivers/accessibility/speakup/utils.h
> @@ -36,7 +36,7 @@ static inline void open_input(const char *dir_name, const char *name)
>  	else
>  		snprintf(filename, sizeof(filename), "%s", name);
>  	infile = fopen(filename, "r");
> -	if (infile == 0) {
> +	if (infile) {
>  		fprintf(stderr, "can't open %s\n", filename);
>  		exit(1);
>  	}
> -- 
> 2.25.1
