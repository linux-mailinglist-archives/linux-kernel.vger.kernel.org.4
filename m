Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031772B5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjFLDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjFLDKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E4170B;
        Sun, 11 Jun 2023 20:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0003C60B67;
        Mon, 12 Jun 2023 03:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C3DC433D2;
        Mon, 12 Jun 2023 03:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686539373;
        bh=m7heADEhyArv8WhRnVIeKrsbQux5pXrM8PZQfuvp/1I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=igo6QEWLIt9O3QrvGCvgaUhH0LpB2exG9vZLb1FpGB7+B3lpunb1oOGvciTN9PaXb
         nU2vEka/mpnDgv2o6PM1h535AMc0fpeSc4Mn2rnJTuhxwfpV8z1bCqYUSyc8ZsgIf9
         tlMQdzGIr6QmhXuVOg/7ZvvVPjEfCyHctG9gS2vODHAjBSP1/E5dm1QJj+eQD8/zKN
         gJudIir1oDDNEZ+d4Q7vIIi3T9UgW4ByTCiOBW7SMbWJFQWlC41wkJWOdc57S5RzE1
         SPY9HgWQAgvzoEa0KU7E2BYIaM9ZtfE5iIpO3ezmG4bDM/eQmaanP4wV7dQ04fsmv7
         e1MWLKbLyjEYA==
Message-ID: <4005a768-9e45-0707-509d-98ce0d2769bd@kernel.org>
Date:   Mon, 12 Jun 2023 12:09:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/23 00:03, Bart Van Assche wrote:
> On 6/10/23 06:27, Bagas Sanjaya wrote:
>> On 6/10/23 15:55, Pavel Machek wrote:
>>>>> #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bug.cgi?id=217530
>>>>> #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
>>>>>
>>>> The reporter had found the culprit (via bisection), so:
>>>>
>>>> #regzbot introduced: a19a93e4c6a98c
>>> Maybe cc the authors of that commit?
>>
>> Ah! I forgot to do that! Thanks anyway.
> 
> Hi Damien,
> 
> Why does the ATA code call scsi_rescan_device() before system resume has
> finished? Would ATA devices still work with the patch below applied?

I do not know the PM code well at all, need to dig into it. But your patch
worries me as it seems it would prevent rescan of the device on a resume, which
can be an issue if the device has changed.

I am not yet 100% clear on the root cause for this, but I think it comes from
the fact that ata_port_pm_resume() runs before the sci device resume is done, so
with scsi_dev->power.is_suspended still true. And ata_port_pm_resume() calls
ata_port_resume_async() which triggers EH (which will do reset + rescan)
asynchronously. So it looks like we have scsi device resume and libata EH for
rescan fighting each others for the scan mutex and device lock, leading to deadlock.

Trying to recreate this issue now to confirm and debug further. But I suspect
the solution to this may be best implemented in libata, not in scsi.
This looks definitely related to this thread:

https://lore.kernel.org/linux-scsi/7b553268-69d3-913a-f9de-28f8d45bdb1e@acm.org/

Similaraly to your comment on that thread, having to look at
dev->power.is_suspended is not ideal I think. What we need is to have ata and
scsi pm resume be synchronized, but I am not yet 100% clear on the scsi layer side.

> 
> Thanks,
> 
> Bart.
> 
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 6a959c993dd8..be3971b7fd27 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1629,6 +1629,20 @@ void scsi_rescan_device(struct device *dev)
>   {
>   	struct scsi_device *sdev = to_scsi_device(dev);
> 
> +#ifdef CONFIG_PM_SLEEP
> +	/*
> +	 * The ATA subsystem may call scsi_rescan_device() before resuming has
> +	 * finished. If this happens, prevent a deadlock on the device_lock()
> +	 * call by skipping rescanning.
> +	 */
> +	if (dev->power.is_suspended)
> +		return;
> +#endif
> +
> +	/*
> +	 * Serialize scsi_driver.rescan() calls and scsi_driver.gendrv.remove()
> +	 * calls.
> +	 */
>   	device_lock(dev);
> 
>   	scsi_attach_vpd(sdev);
> 

-- 
Damien Le Moal
Western Digital Research

