Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8D734686
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjFROOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFROOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6FAE5D;
        Sun, 18 Jun 2023 07:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F0E61272;
        Sun, 18 Jun 2023 14:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC87C433C0;
        Sun, 18 Jun 2023 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687097674;
        bh=p8gKT/yMYSRrguGgxKLyFlg91r2qcybVafBHuY1rckE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ML9VIt8G8WDKV9idRBSL+KHsshpncRDH6QAi728pxiTjlhfWK027td+1J7xeXUbV9
         xmwBY+o1YbiSUKyuJc/JPMw1y6neAKWEjjRcwJLzOmObNDYeeB0xXhexZVwqFnA510
         I/o234mv405IR5asPUSb2vYAgs5nVm1MnBwluB0XwBBD8QyYWrxxAQD1I7gvnJVWkx
         jrqkWk7ok2+eWNoP2z6u5T2kFxvAXZpNfXHVVVp6gvQAqu1neyZkPKzjNEvB9fn15g
         wKjeQh9GlFKGvtuSTFFwQ+JjKWt/+z/81+ISOW4TvJvda+FhZRAtgcJoVzejfPRrke
         IyGfjWSbjKzVA==
Date:   Sun, 18 Jun 2023 22:14:25 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: cdns3: Put the cdns set active part outside the
 spin lock
Message-ID: <20230618141425.GA1588566@nchen-desktop>
References: <20230616021952.1025854-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616021952.1025854-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-16 10:19:51, Xiaolei Wang wrote:
> The device may be scheduled during the resume process,
> so this cannot appear in atomic operations. Since
> pm_runtime_set_active will resume suppliers, put set
> active outside the spin lock, which is only used to
> protect the struct cdns data structure, otherwise the
> kernel will report the following warning:
> 
>   BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
>   preempt_count: 1, expected: 0
>   RCU nest depth: 0, expected: 0
>   CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
>   Hardware name: Freescale i.MX8QM MEK (DT)
>   Call trace:
>     dump_backtrace.part.0+0xe0/0xf0
>     show_stack+0x18/0x30
>     dump_stack_lvl+0x64/0x80
>     dump_stack+0x1c/0x38
>     __might_resched+0x1fc/0x240
>     __might_sleep+0x68/0xc0
>     __pm_runtime_resume+0x9c/0xe0
>     rpm_get_suppliers+0x68/0x1b0
>     __pm_runtime_set_status+0x298/0x560
>     cdns_resume+0xb0/0x1c0
>     cdns3_controller_resume.isra.0+0x1e0/0x250
>     cdns3_plat_resume+0x28/0x40
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  v3:
>   * Fix build error:
>     cdns3-plat.c:258:18: error: too few arguments to function call, expected 2, have 1
>      258 |         cdns_resume(cdns);
>   * use 'cdns_resume(struct cdns *cdns) { return 0; }' instead of 
>     'cdns_resume(struct cdns *cdns, u8 set_active) { return 0; }'
>     and add 'static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
>  		{ return 0; }'
>  v2:
>   * Fix build error: unused variable 'dev'
>   * delete unused 'struct device *dev = cdns->dev;' in cdns_resume()
> 
>  drivers/usb/cdns3/cdns3-plat.c |  3 ++-
>  drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
>  drivers/usb/cdns3/core.c       | 15 +++++++++++----
>  drivers/usb/cdns3/core.h       |  7 +++++--
>  4 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index 884e2301237f..1168dbeed2ce 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -255,9 +255,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
>  	cdns3_set_platform_suspend(cdns->dev, false, false);
>  
>  	spin_lock_irqsave(&cdns->lock, flags);
> -	cdns_resume(cdns, !PMSG_IS_AUTO(msg));
> +	cdns_resume(cdns);
>  	cdns->in_lpm = false;
>  	spin_unlock_irqrestore(&cdns->lock, flags);
> +	cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
>  	if (cdns->wakeup_pending) {
>  		cdns->wakeup_pending = false;
>  		enable_irq(cdns->wakeup_irq);
> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index 7b151f5af3cc..0725668ffea4 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
> @@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
>  	int ret;
>  
>  	spin_lock_irqsave(&cdns->lock, flags);
> -	ret = cdns_resume(cdns, 1);
> +	ret = cdns_resume(cdns);
>  	spin_unlock_irqrestore(&cdns->lock, flags);
> +	cdns_set_active(cdns, 1);
>  
>  	return ret;
>  }
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index dbcdf3b24b47..7b20d2d5c262 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -522,9 +522,8 @@ int cdns_suspend(struct cdns *cdns)
>  }
>  EXPORT_SYMBOL_GPL(cdns_suspend);
>  
> -int cdns_resume(struct cdns *cdns, u8 set_active)
> +int cdns_resume(struct cdns *cdns)
>  {
> -	struct device *dev = cdns->dev;
>  	enum usb_role real_role;
>  	bool role_changed = false;
>  	int ret = 0;
> @@ -556,15 +555,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
>  	if (cdns->roles[cdns->role]->resume)
>  		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
>  
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdns_resume);
> +
> +void cdns_set_active(struct cdns *cdns, u8 set_active)
> +{
> +	struct device *dev = cdns->dev;
> +
>  	if (set_active) {
>  		pm_runtime_disable(dev);
>  		pm_runtime_set_active(dev);
>  		pm_runtime_enable(dev);
>  	}
>  
> -	return 0;
> +	return;
>  }
> -EXPORT_SYMBOL_GPL(cdns_resume);
> +EXPORT_SYMBOL_GPL(cdns_set_active);
>  #endif /* CONFIG_PM_SLEEP */
>  
>  MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 2d332a788871..4a4dbc2c1561 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -125,10 +125,13 @@ int cdns_init(struct cdns *cdns);
>  int cdns_remove(struct cdns *cdns);
>  
>  #ifdef CONFIG_PM_SLEEP
> -int cdns_resume(struct cdns *cdns, u8 set_active);
> +int cdns_resume(struct cdns *cdns);
>  int cdns_suspend(struct cdns *cdns);
> +void cdns_set_active(struct cdns *cdns, u8 set_active);
>  #else /* CONFIG_PM_SLEEP */
> -static inline int cdns_resume(struct cdns *cdns, u8 set_active)
> +static inline int cdns_resume(struct cdns *cdns)
> +{ return 0; }
> +static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
>  { return 0; }
>  static inline int cdns_suspend(struct cdns *cdns)
>  { return 0; }
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen
