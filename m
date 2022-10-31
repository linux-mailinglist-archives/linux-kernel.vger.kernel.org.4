Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D10613B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiJaQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJaQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:22:34 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 09:22:30 PDT
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8A1F5AD;
        Mon, 31 Oct 2022 09:22:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 17F9A660F6;
        Mon, 31 Oct 2022 16:13:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo07-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo07-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6y2a7YFjl0Ol; Mon, 31 Oct 2022 16:13:33 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id A928666047;
        Mon, 31 Oct 2022 16:13:33 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id DCBF63EEDD;
        Mon, 31 Oct 2022 10:13:31 -0600 (MDT)
Message-ID: <f3cae093-6acf-35e5-8411-789383f93337@gonehiking.org>
Date:   Mon, 31 Oct 2022 10:13:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Reply-To: khalid@gonehiking.org
Subject: Re: [PATCH] scsi: BusLogic: remove variable adapter_count
To:     Colin Ian King <colin.i.king@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221031160512.872153-1-colin.i.king@gmail.com>
Content-Language: en-US
From:   Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <20221031160512.872153-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 10:05, Colin Ian King wrote:
> Variable adapter_count is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/scsi/BusLogic.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Looks good to me.

Acked-by: Khalid Aziz <khalid@gonehiking.org>


> 
> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
> index f2abffce2659..f7b7ffda1161 100644
> --- a/drivers/scsi/BusLogic.c
> +++ b/drivers/scsi/BusLogic.c
> @@ -2198,7 +2198,7 @@ static int blogic_slaveconfig(struct scsi_device *dev)
>   
>   static int __init blogic_init(void)
>   {
> -	int adapter_count = 0, drvr_optindex = 0, probeindex;
> +	int drvr_optindex = 0, probeindex;
>   	struct blogic_adapter *adapter;
>   	int ret = 0;
>   
> @@ -2368,10 +2368,8 @@ static int __init blogic_init(void)
>   					list_del(&myadapter->host_list);
>   					scsi_host_put(host);
>   					ret = -ENODEV;
> -				} else {
> +				} else
>   					scsi_scan_host(host);
> -					adapter_count++;
> -				}
>   			}
>   		} else {
>   			/*

