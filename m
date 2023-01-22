Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A106771BD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAVTNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVTNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:13:18 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2216ADA;
        Sun, 22 Jan 2023 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674414786; bh=SBqVqS4LKg/DS4+t9zAGPsAMuWTf8+G8D2fmWn+PcNg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ErXFIzwPiZZgfb9vTAHzbq4oNJyAb1x+waP5zaT+j9gWeVJ9Yle+nV6thIO99lwgX
         U/g83SdMIYE6aObgOss6dHf/zJI7FQEljj3bu+op8XxYk9T+XB+VJeCSnL17CXag/U
         EaM483nKvLy9m/rq4er/hqi1cU2AELtxDOZTJdJs=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 20:13:06 +0100 (CET)
X-EA-Auth: l140IjyIAec0AOtVEwHQCkfNdmmJ8jtxInQPV5dv0mDGpfmeWEAzqlWnFeYAZW4JqJQuaa4HR/sGQl/DmyU4R+3CFWwvtuJ1
Date:   Mon, 23 Jan 2023 00:43:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH v2] scsi: ipr: Convert ipr_probe_ioa_part2 as void
Message-ID: <Y82KvqXU9bX04jut@ubun2204.myguest.virtualbox.org>
References: <Y7rvQyMOGcPKPTv8@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7rvQyMOGcPKPTv8@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 09:58:51PM +0530, Deepak R Varma wrote:
> Convert function ipr_probe_ioa_part2() to return void instead
> of int since the current implementation always returns 0 to the caller.
> The transformation also eliminates the dead code when calling
> ipr_probe_ioa_part2() function.
> Issue identified using returnvar Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v2:
>    - retain and update Return value comment in function documentation

Hello,
May I request a review and feedback comments on this patch proposal please?

Thank you,
./drv

> 
>  drivers/scsi/ipr.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index 2022ffb45041..dfb759fbbd87 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -9505,11 +9505,10 @@ static pci_ers_result_t ipr_pci_error_detected(struct pci_dev *pdev,
>   * This function takes care of initilizing the adapter to the point
>   * where it can accept new commands.
>   * Return value:
> - * 	0 on success / -EIO on failure
> + *     none
>   **/
> -static int ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
> +static void ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
>  {
> -	int rc = 0;
>  	unsigned long host_lock_flags = 0;
> 
>  	ENTER;
> @@ -9525,7 +9524,6 @@ static int ipr_probe_ioa_part2(struct ipr_ioa_cfg *ioa_cfg)
>  	spin_unlock_irqrestore(ioa_cfg->host->host_lock, host_lock_flags);
> 
>  	LEAVE;
> -	return rc;
>  }
> 
>  /**
> @@ -10568,12 +10566,7 @@ static int ipr_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>  		return rc;
> 
>  	ioa_cfg = pci_get_drvdata(pdev);
> -	rc = ipr_probe_ioa_part2(ioa_cfg);
> -
> -	if (rc) {
> -		__ipr_remove(pdev);
> -		return rc;
> -	}
> +	ipr_probe_ioa_part2(ioa_cfg);
> 
>  	rc = scsi_add_host(ioa_cfg->host, &pdev->dev);
> 
> --
> 2.34.1
> 
> 
> 


