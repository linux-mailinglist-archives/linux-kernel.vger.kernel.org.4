Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8CB65F721
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjAEW4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjAEW40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:56:26 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF7F4FCE7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:56:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D8F0F42137;
        Thu,  5 Jan 2023 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672959382; bh=04ixmJd54VU6rvGpT6Imyb3wvOAYUE4X1LMn+1eXZPc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f/E8UEJi76LAG3Psbqv77jbAAMG6z6546+StPcFc6oG/iVXmCDT/MtW11b7htLBKH
         J1yL1OcegqP/Yn6ZxtJMdRNuUoTJM2+lH/vCHucaouKuYOh74swbRo0B/u8jDmhml7
         n8rebT2SzjKgf0e9cjZz2E4aeBUIjYM3vhbMhSstwE4Q77Q7Fa9GVtj+g0Fy9GVtV7
         tSLtS0bo7CNIojiMcuPmQBoSFZKz/HSmQjv3eSn9Myqz28SBXFCzUzlKRGn7Y0Ni7X
         yIZ7i6CJFiR8NZGpnfnUoQdVgqYsO/HEjHk54wA3WuREZYWMX3hNZja9xxqFjMNwo+
         Mmzzw0V3QwRDw==
Message-ID: <1c670eb4-ad5b-94ea-1892-64a66fa0bae0@marcan.st>
Date:   Fri, 6 Jan 2023 07:56:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] firmware/psci: Don't register with debugfs if PSCI isn't
 available
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20230105090834.630238-1-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230105090834.630238-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 18.08, Marc Zyngier wrote:
> Contrary to popular belief, PSCI is not a universal property of an
> ARM/arm64 system. There is a garden variety of systems out there
> that don't (or even cannot) implement it.
> 
> I'm the first one deplore such a situation, but hey...
> 
> On such systems, a "cat /sys/kernel/debug/psci" results in
> fireworks, as no invocation callback is registered.
> 
> Check for the invoke_psci_fn and psci_ops.get_version pointers
> before registering with the debugfs subsystem, avoiding the
> issue altogether.
> 
> Fixes: 3137f2e60098 ("firmware/psci: Add debugfs support to ease debugging")
> Reported-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
>  drivers/firmware/psci/psci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..447ee4ea5c90 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -440,6 +440,9 @@ static const struct file_operations psci_debugfs_ops = {
>  
>  static int __init psci_debugfs_init(void)
>  {
> +	if (!invoke_psci_fn || !psci_ops.get_version)
> +		return 0;
> +
>  	return PTR_ERR_OR_ZERO(debugfs_create_file("psci", 0444, NULL, NULL,
>  						   &psci_debugfs_ops));
>  }

Reviewed-by: Hector Martin <marcan@marcan.st>

- Hector
