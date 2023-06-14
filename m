Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3068710716
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbjEYIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEYIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14E1A1;
        Thu, 25 May 2023 01:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79213643A2;
        Thu, 25 May 2023 08:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C45C433EF;
        Thu, 25 May 2023 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685002456;
        bh=fJ0ImxHlk5vtkSx7zFqdK3Q8pgeQQrfYrqrZBkpl6x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzV+IGBSfB2AJXqMxyOrPVN+YDwI7XBpRFUjLfKpt3I5I8iED76YS6HRXR2Pf1Piz
         qiBd5AD/9Ic8ehfMgDhPsqd5tt1HuZB6DPM1RU4ykZHaaH96LxquxIPP1dKE/UQ/an
         3AzFDZ7rg2rAWOlGwB0GtzPVy3PdBLlf73AreD+gREDQ6t8Iy8bVyvXV4ednlDpWUn
         zATJSlFd0JzSDggonWR3+DWtOQmnY4DSxl47Pjy3UW49ww14oOedKKhbG4gtTczLVI
         eNxm0Z9Cn2qS0wo9PUeV9XAcgYq8hWnNKq+QSV7vJ/pmWR6CCe0BZQi1tuAQV8eE2e
         doJu8VbVukaJA==
Date:   Thu, 25 May 2023 10:14:06 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     bhelgaas@google.com, davem@davemloft.net, edumazet@google.com,
        haiyangz@microsoft.com, jakeo@microsoft.com, kuba@kernel.org,
        kw@linux.com, kys@microsoft.com, leon@kernel.org,
        linux-pci@vger.kernel.org, mikelley@microsoft.com,
        pabeni@redhat.com, robh@kernel.org, saeedm@nvidia.com,
        wei.liu@kernel.org, longli@microsoft.com, boqun.feng@gmail.com,
        ssengar@microsoft.com, helgaas@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        josete@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: hv: Fix a race condition bug in
 hv_pci_query_relations()
Message-ID: <ZG8YzuK/5+8iE8He@lpieralisi>
References: <20230420024037.5921-1-decui@microsoft.com>
 <20230420024037.5921-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420024037.5921-2-decui@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 07:40:32PM -0700, Dexuan Cui wrote:
> Fix the longstanding race between hv_pci_query_relations() and
> survey_child_resources() by flushing the workqueue before we exit from
> hv_pci_query_relations().

"Fix the longstanding race" is vague. Please describe the race
succinctly at least to give an idea of what the problem is.

> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> 
> v2:
>   Removed the "debug code".
>   No change to the patch body.
>   Added Cc:stable
> 
> v3:
>   Added Michael's Reviewed-by.
> 
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index f33370b756283..b82c7cde19e66 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3308,6 +3308,19 @@ static int hv_pci_query_relations(struct hv_device *hdev)
>  	if (!ret)
>  		ret = wait_for_response(hdev, &comp);
>  
> +	/*
> +	 * In the case of fast device addition/removal, it's possible that
> +	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
> +	 * already got a PCI_BUS_RELATIONS* message from the host and the
> +	 * channel callback already scheduled a work to hbus->wq, which can be
> +	 * running survey_child_resources() -> complete(&hbus->survey_event),
> +	 * even after hv_pci_query_relations() exits and the stack variable
> +	 * 'comp' is no longer valid. This can cause a strange hang issue

"A strange hang" sounds like we don't understand what's happening, it
does not feel like it is a solid understanding of the issue.

I would remove it - given that you already explain that comp is no
longer valid - that is already a bug that needs fixing.

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> +	 * or sometimes a page fault. Flush hbus->wq before we exit from
> +	 * hv_pci_query_relations() to avoid the issues.
> +	 */
> +	flush_workqueue(hbus->wq);
> +
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
