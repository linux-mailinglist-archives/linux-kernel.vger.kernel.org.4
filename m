Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D69072AC73
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjFJPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjFJPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:04:03 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623923588;
        Sat, 10 Jun 2023 08:04:02 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbb3a013dso1698367a12.1;
        Sat, 10 Jun 2023 08:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686409442; x=1689001442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+2DK6e0ExwNggdgQrYc3qCt4Ssgi+vxV8OCcu+bbSs=;
        b=lPMithFBpiUQDFD5jZ5tlqr+fJOn87UxuGVH/+yaJA431UMlh8E4iusRY5K8XO16mH
         n5fV3FVH2ryQxk75E3jAKqNz92oWUFBnBfjYi83YsjEXn9V6SYwJ/7WRA7uME3mB60ov
         lYmmqHZJEpXPNaD2neYgHkDlwPcAA1zs75EDX58Ls0bQeZIV+vvhD5zbLjNDITxlazbd
         /J5szCblSNbw5CebTLgAIY13JrCqsd4+ECeU76cYo6xT3tzbLFbh06ra/GA32RDV/NYE
         gGiIoAg426p0LrCAWw7A39UXvUw9CAeDYq6+Zx/hwD4eEaH5eSBUv2cmxa2JnJU9SOjG
         PJjA==
X-Gm-Message-State: AC+VfDzY+/NXzZrueNXLr2g5T+bF2ZqLpiILg4WpcJtHvtgN0TkwYfro
        mNNwXtqbInBdj1a7o0osZko=
X-Google-Smtp-Source: ACHHUZ5t/ck9Yx8w0Ts2mCKfu3UlWc1gun1eU3jLZdNKvdus7uTM+1aYKzQpak5qo25X7YqamCyyBg==
X-Received: by 2002:a17:903:3293:b0:1af:9b8a:9c79 with SMTP id jh19-20020a170903329300b001af9b8a9c79mr2086591plb.34.1686409441578;
        Sat, 10 Jun 2023 08:04:01 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902bf4a00b001b2063d43a7sm5073944pls.249.2023.06.10.08.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 08:04:01 -0700 (PDT)
Message-ID: <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
Date:   Sat, 10 Jun 2023 08:03:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Damien Le Moal <dlemoal@kernel.org>
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 06:27, Bagas Sanjaya wrote:
> On 6/10/23 15:55, Pavel Machek wrote:
>>>> #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bug.cgi?id=217530
>>>> #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
>>>>
>>> The reporter had found the culprit (via bisection), so:
>>>
>>> #regzbot introduced: a19a93e4c6a98c
>> Maybe cc the authors of that commit?
> 
> Ah! I forgot to do that! Thanks anyway.

Hi Damien,

Why does the ATA code call scsi_rescan_device() before system resume has
finished? Would ATA devices still work with the patch below applied?

Thanks,

Bart.


diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 6a959c993dd8..be3971b7fd27 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1629,6 +1629,20 @@ void scsi_rescan_device(struct device *dev)
  {
  	struct scsi_device *sdev = to_scsi_device(dev);

+#ifdef CONFIG_PM_SLEEP
+	/*
+	 * The ATA subsystem may call scsi_rescan_device() before resuming has
+	 * finished. If this happens, prevent a deadlock on the device_lock()
+	 * call by skipping rescanning.
+	 */
+	if (dev->power.is_suspended)
+		return;
+#endif
+
+	/*
+	 * Serialize scsi_driver.rescan() calls and scsi_driver.gendrv.remove()
+	 * calls.
+	 */
  	device_lock(dev);

  	scsi_attach_vpd(sdev);

