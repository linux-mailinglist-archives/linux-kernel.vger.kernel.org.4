Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011B872F3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbjFNEtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFNEth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7F10CC;
        Tue, 13 Jun 2023 21:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2D361466;
        Wed, 14 Jun 2023 04:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA4CC433C0;
        Wed, 14 Jun 2023 04:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686718175;
        bh=pbzb0xFNNW0u7m7s+rM8lFJaPjyJzD071PFKZTs/J/A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UM+oe/97PR4O1Hi+cZGwPwSNt6JUCfiE0bw7oltchUs+diqjB6VVn5/4KeuRMLMW5
         eUFtHPKWelJK+r2aHwtBq09I25HiWUdOozz+lP6D5dllb/jaFQiUFmVnE4JGDX3i7O
         V9Guu6jdin8C0KNJLS6+pY8ZRnyiuS6MPiFbSVd5tgODhFUFx4VI7awcPZHsPi5EOn
         gY9GM4zxSgnsFeejG8HRUT5k9I8EyDII6Jb6Maxp1kYDsWXm2+ggVd3W1as3saiYXU
         ZlG8QGUno+oWcR/VCGccifklYfE0TVqlQMWERcIFK172T/QTr44xLm54qIkWnD0EHU
         th6NT0EiQQ/Dg==
Message-ID: <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
Date:   Wed, 14 Jun 2023 13:49:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
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
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
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

On 6/11/23 18:05, Joe Breuer wrote:
> I'm the reporter of this issue.
> 
> I just tried this patch against 6.3.4, and it completely fixes my
> suspend/resume issue.
> 
> The optical drive stays usable after resume, even suspending/resuming
> during playback of CDDA content works flawlessly and playback resumes
> seamlessly after system resume.
> 
> So, from my perspective: Good one!

In place of Bart's fix, could you please try this patch ?

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b80e68000dd3..a81eb4f882ab 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
ata_port *ap)
        /* tell ACPI that we're resuming */
        ata_acpi_on_resume(ap);

-       /* update the flags */
        spin_lock_irqsave(ap->lock, flags);
+
+       /* Update the flags */
        ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
+
+       /*
+        * Resuming the port will trigger a rescan of the ATA device(s)
+        * connected to it. Before scheduling the rescan, make sure that
+        * the associated scsi device(s) are fully resumed as well.
+        */
+       ata_for_each_link(link, ap, HOST_FIRST) {
+               ata_for_each_dev(dev, link, ENABLED) {
+                       struct scsi_device *sdev = dev->sdev;
+
+                       if (!sdev)
+                               continue;
+                       if (scsi_device_get(sdev))
+                               continue;
+
+                       spin_unlock_irqrestore(ap->lock, flags);
+                       device_pm_wait_for_dev(&ap->tdev,
+                                              &sdev->sdev_gendev);
+                       scsi_device_put(sdev);
+                       spin_lock_irqsave(ap->lock, flags);
+               }
+       }
        spin_unlock_irqrestore(ap->lock, flags);
 }
 #endif /* CONFIG_PM */

Thanks !

-- 
Damien Le Moal
Western Digital Research

