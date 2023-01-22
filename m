Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9F677185
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjAVS17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:27:56 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F140D1CAE0;
        Sun, 22 Jan 2023 10:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674412066; bh=qZ3pmVx9jjiN+mtqLHzTyU0zP6WvhyAtVVbIUyMvtyg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=S3kuEvYaO51qAEo7WXQGfAKlGqyfU41FC6DiOZ4jL7pOcBI6vkP8HYAcp9sEPobYt
         xdpynZsqzgOUAe/o6Ekixk6Hgwj5Z6L8fLVKdWq/oBRNg4L4s3rl/x5da+HqyGIvop
         eL2yJXDdZCmFL7gcQMzlM/2l/aBrWWubztG1vbwk=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 19:27:46 +0100 (CET)
X-EA-Auth: 8YSJMZbWSRZKr7E97az5CqhquX5gdK9RUIlh565GCeF8wWRLXu8Jkju/qZgI7aGVEM7Ofh8jM9ZbOyRqyy6ouOFV+NMCb+xj
Date:   Sun, 22 Jan 2023 23:57:42 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: megaraid_sas: Use a variable for repeated mem_size
 computation
Message-ID: <Y82AHjrNAaWq2yt2@ubun2204.myguest.virtualbox.org>
References: <Y78EP0Fznl8h4XVs@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y78EP0Fznl8h4XVs@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 12:17:27AM +0530, Deepak R Varma wrote:
> Use a variable to upfront compute memory size to be allocated,
> instead of repeatedly computing it at different instructions.
> The reduced instruction length also allows to tidy up the code.
> Issue identified using the array_size_dup Coccinelle semantic
> patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
May I request a review and feedback comments on this patch proposal please?

Thank you,
./drv

>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index fe70f8f11435..efb25af80664 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -5287,6 +5287,7 @@ int
>  megasas_alloc_fusion_context(struct megasas_instance *instance)
>  {
>  	struct fusion_context *fusion;
> +	size_t sz;
>  
>  	instance->ctrl_context = kzalloc(sizeof(struct fusion_context),
>  					 GFP_KERNEL);
> @@ -5298,15 +5299,13 @@ megasas_alloc_fusion_context(struct megasas_instance *instance)
>  
>  	fusion = instance->ctrl_context;
>  
> -	fusion->log_to_span_pages = get_order(MAX_LOGICAL_DRIVES_EXT *
> -					      sizeof(LD_SPAN_INFO));
> +	sz = array_size(MAX_LOGICAL_DRIVES_EXT, sizeof(LD_SPAN_INFO));
> +	fusion->log_to_span_pages = get_order(sz);
>  	fusion->log_to_span =
>  		(PLD_SPAN_INFO)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  						fusion->log_to_span_pages);
>  	if (!fusion->log_to_span) {
> -		fusion->log_to_span =
> -			vzalloc(array_size(MAX_LOGICAL_DRIVES_EXT,
> -					   sizeof(LD_SPAN_INFO)));
> +		fusion->log_to_span = vzalloc(sz);
>  		if (!fusion->log_to_span) {
>  			dev_err(&instance->pdev->dev, "Failed from %s %d\n",
>  				__func__, __LINE__);
> @@ -5314,15 +5313,13 @@ megasas_alloc_fusion_context(struct megasas_instance *instance)
>  		}
>  	}
>  
> -	fusion->load_balance_info_pages = get_order(MAX_LOGICAL_DRIVES_EXT *
> -		sizeof(struct LD_LOAD_BALANCE_INFO));
> +	sz = array_size(MAX_LOGICAL_DRIVES_EXT, sizeof(struct LD_LOAD_BALANCE_INFO));
> +	fusion->load_balance_info_pages = get_order(sz);
>  	fusion->load_balance_info =
>  		(struct LD_LOAD_BALANCE_INFO *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  		fusion->load_balance_info_pages);
>  	if (!fusion->load_balance_info) {
> -		fusion->load_balance_info =
> -			vzalloc(array_size(MAX_LOGICAL_DRIVES_EXT,
> -					   sizeof(struct LD_LOAD_BALANCE_INFO)));
> +		fusion->load_balance_info = vzalloc(sz);
>  		if (!fusion->load_balance_info)
>  			dev_err(&instance->pdev->dev, "Failed to allocate load_balance_info, "
>  				"continuing without Load Balance support\n");
> -- 
> 2.34.1
> 
> 
> 


