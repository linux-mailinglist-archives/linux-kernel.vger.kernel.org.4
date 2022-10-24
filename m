Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D160B00B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiJXQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiJXP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:59:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01159FC1C7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:54:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w3so5721611qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snHhLpRnzMiuF/FkUzYYR4DW/a0NGNwApchz9Ej8VRU=;
        b=YUEP9XyILJspEjolrjqp2Z9GjGMOMTrP45EmxEXsZljfkkiRMJwaEfnshgsJfs8X7M
         KNgjsXqTJhQmhXRI0AaougoHAd1ZM5MiWxlHgU+f83ikUw0WIaE3xD0cU+/ICFuviutI
         UJybqMEFZMf18o+q3wwUtI9WhD34rpMrCVBhcSmx57RZ817mZdAPNb+TaZE1IZTtVnfc
         J13VQwN6Gk7ZemBPqfi8E/tAo+RfA+q8XHsf4hBGrvHN/lBiR+F+CGw1SWxmvIaiCsec
         /9nmLcA7UkmseebRG5d3ZSiAUd+x0xYiFAU0DNreRXfO+w3UcrZtidnRR9zNPUXAXshz
         KjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snHhLpRnzMiuF/FkUzYYR4DW/a0NGNwApchz9Ej8VRU=;
        b=uXsWvi9DxPYg4MKmjSvEgkYrlq25wINakm6nIS8XfgOuvQ/kJK3cxWSTmEqxCnTeIe
         JsX0VWnRheuwIKmHqU3FSj0aeEhU2FoqzMEaCerKNr/Jcjl18VV4CZZJmYJxB1WhBOkv
         gHhUsS0DrRZwdTpTq1vB3+5GOla+XiVnxsa0UcSviWo3SN8MsbaziUVcpyEJ5WK3n7DD
         E3uXJzaLeIevhWJ4XXUO35icU0CHo+vAaa4kY63wOsHwBrmR7+Oo6+GJqnfq9OK/Ki7x
         QHVAItsapuT72SgTnFtneKNVQsf2K2G9WDjo8Aj+MURX8OEe4va5JppCWlgl+qXc3BKa
         3nsw==
X-Gm-Message-State: ACrzQf2RgZdqSKM3Q3Kjq8arEO94WcbInsRneMLBb5IkC891EtVtautQ
        3NpnTOkrnFbIBSdcOkpZfsjWZH8pSg==
X-Google-Smtp-Source: AMsMyM4x20N5g0CnTk189WOms1Rpbivdne8Eg7opnisvbRX7j+9LVguQi1ENkMDNfK6SBGQThtJoxA==
X-Received: by 2002:a05:620a:12ac:b0:6ec:55bf:1d79 with SMTP id x12-20020a05620a12ac00b006ec55bf1d79mr22630933qki.598.1666621252246;
        Mon, 24 Oct 2022 07:20:52 -0700 (PDT)
Received: from serve.minyard.net ([47.184.185.126])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a414b00b006ce9e880c6fsm4141qko.111.2022.10.24.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:20:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8f12:af97:5f5:1273])
        by serve.minyard.net (Postfix) with ESMTPSA id 9F91E180044;
        Mon, 24 Oct 2022 14:20:49 +0000 (UTC)
Date:   Mon, 24 Oct 2022 09:20:48 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ipmi: ssif_bmc: Use EPOLLIN instead of POLLIN
Message-ID: <Y1afQOKvgUzOLPph@minyard.net>
Reply-To: minyard@acm.org
References: <20221024075956.3312552-1-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024075956.3312552-1-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:59:56PM +0700, Quan Nguyen wrote:
> This fixes the following sparse warning:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/char/ipmi/ssif_bmc.c:254:22: sparse: sparse: invalid assignment: |=
> >> drivers/char/ipmi/ssif_bmc.c:254:22: sparse:    left side has type restricted __poll_t
> >> drivers/char/ipmi/ssif_bmc.c:254:22: sparse:    right side has type int

Thanks, you beat me to tracing this down.  It's in my for-next queue.

-corey

> 
> Fixes: dd2bc5cc9e25 ("ipmi: ssif_bmc: Add SSIF BMC driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202210181103.ontD9tRT-lkp@intel.com/
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  drivers/char/ipmi/ssif_bmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
> index a7bb4b99000e..2d8069386398 100644
> --- a/drivers/char/ipmi/ssif_bmc.c
> +++ b/drivers/char/ipmi/ssif_bmc.c
> @@ -251,7 +251,7 @@ static __poll_t ssif_bmc_poll(struct file *file, poll_table *wait)
>  	spin_lock_irq(&ssif_bmc->lock);
>  	/* The request is available, userspace application can get the request */
>  	if (ssif_bmc->request_available)
> -		mask |= POLLIN;
> +		mask |= EPOLLIN;
>  
>  	spin_unlock_irq(&ssif_bmc->lock);
>  
> -- 
> 2.35.1
> 
