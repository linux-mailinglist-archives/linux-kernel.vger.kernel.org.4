Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C215EE5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiI1T1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiI1T1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:27:11 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58627D7A8;
        Wed, 28 Sep 2022 12:27:10 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id s206so13101822pgs.3;
        Wed, 28 Sep 2022 12:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fi13tgaUqw4cLZkJIZHH5F/+Kj1zVWfq2Z8e4osB/qU=;
        b=0zU2HIySj7frGQNyGeg8RTBZQzZvq6D8JnqIT5hMxoKXMd7F2eFp/tmsnANZvDGklX
         lR/sQcDipyBkygoBsRBPPylk8ETmkEfPsCBQnRpKCnTFeidzvyNorFhN0Atr8CaBgjyK
         Goopw0grWFJvIsiVoK5Vv1O5Evv/q29VxkcZfg1Seu7HY/dz1LmC/DRujKtCCveqaBxq
         e4YkZstqLYMZ8wIIZJDdXtqAKfO9VfGgnGm72l2VxlySZFgqtZu9ly8uANq0ssAgO2Kp
         cYALGmGM6DHFwX8e/Fu7Cn0UqX27nzJ/zAdTNmFvfcTwilv3GftU48/MIjD6GWJXfdEN
         lIYA==
X-Gm-Message-State: ACrzQf0lUP9bXtpTAOmrRuvO6NeYe2m4i3uyL3sMOUO3T5j+x7/jPx5x
        b2gsNARySmIQG6WRRKeF67c=
X-Google-Smtp-Source: AMsMyM4Wq/ODU6oLlycsV/TSsGP3st5KOplktf0lq4S7Inz58H2pIA8EPZXkLTHsTxDYidYXSbH0fA==
X-Received: by 2002:a05:6a00:2314:b0:546:ce91:89a3 with SMTP id h20-20020a056a00231400b00546ce9189a3mr35734387pfh.77.1664393230024;
        Wed, 28 Sep 2022 12:27:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cba:f1a9:6ef8:3759? ([2620:15c:211:201:4cba:f1a9:6ef8:3759])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c20500b00176d347e9a7sm4090106pll.233.2022.09.28.12.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:27:09 -0700 (PDT)
Message-ID: <2acc2220-65dc-4af5-ffd3-997f779d41c0@acm.org>
Date:   Wed, 28 Sep 2022 12:27:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 6/7] module: Improve support for asynchronous module
 exit code
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <20220914225621.415631-1-bvanassche@acm.org>
 <20220914225621.415631-7-bvanassche@acm.org> <YzOe3pYmn5qO9lFb@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YzOe3pYmn5qO9lFb@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 18:09, Ming Lei wrote:
> On Wed, Sep 14, 2022 at 03:56:20PM -0700, Bart Van Assche wrote:
>> Some kernel modules call device_del() from their module exit code and
>> schedule asynchronous work from inside the .release callback without waiting
>> until that callback has finished. As an example, many SCSI LLD drivers call
> 
> It isn't only related with device, any kobject has such issue, or any
> reference counter usage has similar potential risk, see previous discussion:
> 
> https://lore.kernel.org/lkml/YsZm7lSXYAHT14ui@T590/
> 
> IMO, it is one fundamental problem wrt. module vs. reference counting or
> kobject uses at least, since the callback depends on module code
> segment.
> 
>> scsi_remove_host() from their module exit code. scsi_remove_host() may
>> invoke scsi_device_dev_release_usercontext() asynchronously.
>> scsi_device_dev_release_usercontext() uses the host template pointer and
>> that pointer usually exists in static storage in the SCSI LLD. Support
>> using the module reference count to keep the module around until
>> asynchronous module exiting has completed by waiting in the delete_module()
>> system call until the module reference count drops to zero.
> 
> The issue can't be addressed by the normal mod->refcnt, since user need
> to unload module when the device isn't used.

Hi Ming,

How about removing support for calling scsi_device_put() from atomic context
as is done in the untested patch below?

Thanks,

Bart.

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index c59eac7a32f2..661753a10b47 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -561,6 +561,8 @@ EXPORT_SYMBOL(scsi_report_opcode);
   */
  int scsi_device_get(struct scsi_device *sdev)
  {
+	might_sleep();
+
  	if (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL)
  		goto fail;
  	if (!get_device(&sdev->sdev_gendev))
@@ -588,6 +590,7 @@ void scsi_device_put(struct scsi_device *sdev)
  {
  	struct module *mod = sdev->host->hostt->module;

+	might_sleep();
  	put_device(&sdev->sdev_gendev);
  	module_put(mod);
  }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index a3aaafdeac1d..4cfc9317b4ad 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -441,7 +441,7 @@ static void scsi_device_cls_release(struct device *class_dev)
  	put_device(&sdev->sdev_gendev);
  }

-static void scsi_device_dev_release_usercontext(struct work_struct *work)
+static void scsi_device_dev_release(struct device *dev)
  {
  	struct scsi_device *sdev;
  	struct device *parent;
@@ -450,11 +450,8 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
  	struct scsi_vpd *vpd_pg0 = NULL, *vpd_pg89 = NULL;
  	struct scsi_vpd *vpd_pgb0 = NULL, *vpd_pgb1 = NULL, *vpd_pgb2 = NULL;
  	unsigned long flags;
-	struct module *mod;
-
-	sdev = container_of(work, struct scsi_device, ew.work);

-	mod = sdev->host->hostt->module;
+	sdev = to_scsi_device(dev);

  	parent = sdev->sdev_gendev.parent;

@@ -516,19 +513,6 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)

  	if (parent)
  		put_device(parent);
-	module_put(mod);
-}
-
-static void scsi_device_dev_release(struct device *dev)
-{
-	struct scsi_device *sdp = to_scsi_device(dev);
-
-	/* Set module pointer as NULL in case of module unloading */
-	if (!try_module_get(sdp->host->hostt->module))
-		sdp->host->hostt->module = NULL;
-
-	execute_in_process_context(scsi_device_dev_release_usercontext,
-				   &sdp->ew);
  }

  static struct class sdev_class = {
