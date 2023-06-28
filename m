Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B67741846
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjF1SwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjF1Sve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:51:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75962694
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=lI2tg1GnlinJyvRIAEmAI51EovH7MwFyKO06irrJ0rE=; b=arERCPNnSQbvk/W9vqqLIsVrwf
        cqJSPEgNbHk7B+6gAS6Ez6WQPYuSzz+GmWsF5RkEgEqvSs3sLRbOPn0MQoUEMnT8ZZQgkRLDoXCyr
        oeB3Snrb8DxiIpw4RAX/2SpjcPs2OZOCSXqBazZAa027ExGRNCi90M5sdtCeJuIap4Vg1vJ0SmmvV
        hif46q7Ar2eLTXL++UtOv2a8lThm2eRu7zYKhDmrjG1pwtmJLbHa/L4d/rjXTEEPfH5sTffJCGP+i
        dfgY5s8UtxQ4j+elXtGke9OX826DZ7O7mqLyWofla+yIGyIfhiwMkAaPsxItykW8IUZXl3bptJ1tG
        qJ19Hcpw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEaGK-00GRGs-3B;
        Wed, 28 Jun 2023 18:51:33 +0000
Message-ID: <fd34114d-d2e4-0d10-475c-61585753a639@infradead.org>
Date:   Wed, 28 Jun 2023 11:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] workqueue: add cmdline parameter
 `workqueue.unbound_cpus` to further constrain wq_unbound_cpumask at boot time
Content-Language: en-US
To:     tj@kernel.org, frederic@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net, zwp10758@gmail.com, fuyuanli@didiglobal.com
References: <20230628111722.GA31661@didi-ThinkCentre-M930t-N000>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230628111722.GA31661@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/28/23 04:18, tiozhang wrote:
> Motivation of doing this is to better improve boot times for devices when
> we want to prevent our workqueue works from running on some specific CPUs,
> e,g, some CPUs are busy with interrupts.
> 
> Signed-off-by: tiozhang <tiozhang@didiglobal.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 +++++++
>  kernel/workqueue.c                            | 20 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7cd5f5e7e0a1..29e8254edd63 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c

> @@ -6129,3 +6135,17 @@ void __init workqueue_init(void)
>   */
>  void __warn_flushing_systemwide_wq(void) { }
>  EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
> +
> +static int __init workqueue_unbound_cpus_setup(char *str)
> +{
> +	int ret;
> +
> +	ret = cpulist_parse(str, &wq_cmdline_cpumask);
> +	if (ret < 0) {
> +		cpumask_clear(&wq_cmdline_cpumask);
> +		pr_warn("workqueue.unbound_cpus: incorrect CPU range\n");
> +	}
> +
> +	return ret;
> +}
> +__setup("workqueue.unbound_cpus=", workqueue_unbound_cpus_setup);

__setup() functions don't return 0 for success or errno/other values
for error. They return 1 if the parameter is handled and 0 if it is
not handled, as documented in include/linux/init.h.

And "handled" basically means "recognized" as a kernel parameter,
not that the value(s) passed to it are correct.
I.e., they should usually return 0.

-- 
~Randy
