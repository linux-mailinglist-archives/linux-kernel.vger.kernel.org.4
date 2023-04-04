Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977B26D6460
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjDDN7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjDDN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:59:10 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D52F4EE9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:58:47 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17ab3a48158so34643254fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680616645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=99pMET9eEiHv7TnrlGIJFN/Zw12Mm5RkOtgW6hbaBL0=;
        b=EFx+OOBD1GSU1qy1i+LWeBJ4mNtkfKzOPP+ejUEnJyY6Kw6tfQH7Jw1W9JZnCtJMr/
         FOepLka3NMBfPxe+kUoiJLI6nG0ifx3AjlWzCJ13nW8A0YO3Ss4ye1CKp37OVyeimNyN
         a8fg0XqUsPiLFWPdkqfWNvEnz/OpfzqxVvDFffQQu7HdP/SGmp4exaULulYhrlUYGPCr
         WyPr5UQjfxWKTIUFjyZtyCo4bnLguaixt9dW6j+cmz28iPvK6RenGOxkUBJy0MmaxJ8O
         j+eV1sM1+t/rKOsOAlY26Dz1ZAZVQRpESKxeULg+r8XfCSVu92XRH8aSLOD1fm8/oq6R
         O6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99pMET9eEiHv7TnrlGIJFN/Zw12Mm5RkOtgW6hbaBL0=;
        b=JQ0/De4Rs7kvlbPHfJuHpyouhghedXKZEd45q18mePtPp8K2eDNaR32Bs8V1r1DVcG
         SBx3jtb2C4yw7c5nDvIQGKFTOfTT7cAA7gCdy9/5dM0kj8Nn7oYoUjeC0YkP6gQB1JdG
         sZGOEpl3e26LRJUM1Fb/UrCzqIzdK8KPkEhw4EUGEUtkqYpFEpMrtmxzakE5QaPEsYvq
         q9fDfyKlzs4AhH4+vQkMmZtEoGlngJwlmDB8S/qyyrvKgMeVLYN1Xmh2PJUbIRmXF/60
         qVMHgDgg82swufcopWMQj2jxBbfITZYOdO2MyQN0NWipBmmbNvJMqsheeEjp8ukrZ808
         JD+w==
X-Gm-Message-State: AAQBX9cLCteFZvXlCtc6sGLNEHorto6sQ19SCE5285nlbqjZrv0vnO7+
        26mX+oYk01P6VGeJBgkgJ/I=
X-Google-Smtp-Source: AKy350bZQh779iuf0dmEPPpEs27J6Ub1TPHnlL9pwsFC+H/meD/PoBQBkzafRnXpP7wo+aHl/DKUpg==
X-Received: by 2002:a05:6870:8201:b0:177:badc:6777 with SMTP id n1-20020a056870820100b00177badc6777mr1507931oae.44.1680616645522;
        Tue, 04 Apr 2023 06:57:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id tb5-20020a05687186c500b0017255c79736sm4654711oab.43.2023.04.04.06.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:57:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <84895fbe-1a8c-2ea8-9b49-d9b37f031881@roeck-us.net>
Date:   Tue, 4 Apr 2023 06:57:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] driver core: class: remove struct class_interface *
 from callbacks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Jean Delvare <jdelvare@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Cai Xinchen <caixinchen1@huawei.com>
References: <2023040244-duffel-pushpin-f738@gregkh>
 <2023040250-pushover-platter-509c@gregkh>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023040250-pushover-platter-509c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/23 10:58, Greg Kroah-Hartman wrote:
> The add_dev and remove_dev callbacks in struct class_interface currently
> pass in a pointer back to the class_interface structure that is calling
> them, but none of the callback implementations actually use this pointer
> as it is pointless (the structure is known, the driver passed it in in
> the first place if it is really needed again.)
> 
> So clean this up and just remove the pointer from the callbacks and fix
> up all callback functions.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Alexandre Bounine <alex.bou9@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Doug Gilbert <dgilbert@interlog.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang Weiyang <wangweiyang2@huawei.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Jakob Koschel <jakobkoschel@gmail.com>
> Cc: Cai Xinchen <caixinchen1@huawei.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, subsystem maintainers, this should go through my driver-core tree
> as it's part of a larger cleanup of 'struct class' handling.  I'm cc:ing
> you all to get reviews to verify I didn't do something foolish, but it
> has passed 0-day bot build testing already (which caught many foolish
> mistakes of mine...)
> 
> 
>   drivers/base/class.c                     |  4 ++--
>   drivers/base/core.c                      | 10 ++++------
>   drivers/hwmon/drivetemp.c                |  4 ++--

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

>   drivers/net/rionet.c                     |  3 +--
>   drivers/ntb/hw/mscc/ntb_hw_switchtec.c   |  6 ++----
>   drivers/pcmcia/ds.c                      |  6 ++----
>   drivers/pcmcia/rsrc_nonstatic.c          |  6 ++----
>   drivers/rapidio/devices/rio_mport_cdev.c |  7 ++-----
>   drivers/rapidio/rio_cm.c                 |  8 ++------
>   drivers/scsi/ses.c                       |  6 ++----
>   drivers/scsi/sg.c                        |  8 ++++----
>   include/linux/device/class.h             |  4 ++--
>   kernel/time/alarmtimer.c                 |  3 +--
>   13 files changed, 28 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index ad8b9f163fd2..ac1808d1a2e8 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -486,7 +486,7 @@ int class_interface_register(struct class_interface *class_intf)
>   	if (class_intf->add_dev) {
>   		class_dev_iter_init(&iter, parent, NULL, NULL);
>   		while ((dev = class_dev_iter_next(&iter)))
> -			class_intf->add_dev(dev, class_intf);
> +			class_intf->add_dev(dev);
>   		class_dev_iter_exit(&iter);
>   	}
>   	mutex_unlock(&sp->mutex);
> @@ -514,7 +514,7 @@ void class_interface_unregister(struct class_interface *class_intf)
>   	if (class_intf->remove_dev) {
>   		class_dev_iter_init(&iter, parent, NULL, NULL);
>   		while ((dev = class_dev_iter_next(&iter)))
> -			class_intf->remove_dev(dev, class_intf);
> +			class_intf->remove_dev(dev);
>   		class_dev_iter_exit(&iter);
>   	}
>   	mutex_unlock(&sp->mutex);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 64d188be4df9..7a42d1b6b721 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -541,8 +541,7 @@ static struct class devlink_class = {
>   	.dev_release = devlink_dev_release,
>   };
>   
> -static int devlink_add_symlinks(struct device *dev,
> -				struct class_interface *class_intf)
> +static int devlink_add_symlinks(struct device *dev)
>   {
>   	int ret;
>   	size_t len;
> @@ -591,8 +590,7 @@ static int devlink_add_symlinks(struct device *dev,
>   	return ret;
>   }
>   
> -static void devlink_remove_symlinks(struct device *dev,
> -				   struct class_interface *class_intf)
> +static void devlink_remove_symlinks(struct device *dev)
>   {
>   	struct device_link *link = to_devlink(dev);
>   	size_t len;
> @@ -3647,7 +3645,7 @@ int device_add(struct device *dev)
>   		/* notify any interfaces that the device is here */
>   		list_for_each_entry(class_intf, &sp->interfaces, node)
>   			if (class_intf->add_dev)
> -				class_intf->add_dev(dev, class_intf);
> +				class_intf->add_dev(dev);
>   		mutex_unlock(&sp->mutex);
>   		subsys_put(sp);
>   	}
> @@ -3805,7 +3803,7 @@ void device_del(struct device *dev)
>   		/* notify any interfaces that the device is now gone */
>   		list_for_each_entry(class_intf, &sp->interfaces, node)
>   			if (class_intf->remove_dev)
> -				class_intf->remove_dev(dev, class_intf);
> +				class_intf->remove_dev(dev);
>   		/* remove the device from the class list */
>   		klist_del(&dev->p->knode_class);
>   		mutex_unlock(&sp->mutex);
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 8e5759b42390..86171031ddc5 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -550,7 +550,7 @@ static const struct hwmon_chip_info drivetemp_chip_info = {
>    * The device argument points to sdev->sdev_dev. Its parent is
>    * sdev->sdev_gendev, which we can use to get the scsi_device pointer.
>    */
> -static int drivetemp_add(struct device *dev, struct class_interface *intf)
> +static int drivetemp_add(struct device *dev)
>   {
>   	struct scsi_device *sdev = to_scsi_device(dev->parent);
>   	struct drivetemp_data *st;
> @@ -585,7 +585,7 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
>   	return err;
>   }
>   
> -static void drivetemp_remove(struct device *dev, struct class_interface *intf)
> +static void drivetemp_remove(struct device *dev)
>   {
>   	struct drivetemp_data *st, *tmp;
>   
> diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
> index fbcb9d05da64..4eececc94513 100644
> --- a/drivers/net/rionet.c
> +++ b/drivers/net/rionet.c
> @@ -662,8 +662,7 @@ static int rionet_shutdown(struct notifier_block *nb, unsigned long code,
>   	return NOTIFY_DONE;
>   }
>   
> -static void rionet_remove_mport(struct device *dev,
> -				struct class_interface *class_intf)
> +static void rionet_remove_mport(struct device *dev)
>   {
>   	struct rio_mport *mport = to_rio_mport(dev);
>   	struct net_device *ndev;
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 88ae18b0efa8..d6bbcc7b5b90 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -1470,8 +1470,7 @@ static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
>   	return rc;
>   }
>   
> -static int switchtec_ntb_add(struct device *dev,
> -			     struct class_interface *class_intf)
> +static int switchtec_ntb_add(struct device *dev)
>   {
>   	struct switchtec_dev *stdev = to_stdev(dev);
>   	struct switchtec_ntb *sndev;
> @@ -1541,8 +1540,7 @@ static int switchtec_ntb_add(struct device *dev,
>   	return rc;
>   }
>   
> -static void switchtec_ntb_remove(struct device *dev,
> -				 struct class_interface *class_intf)
> +static void switchtec_ntb_remove(struct device *dev)
>   {
>   	struct switchtec_dev *stdev = to_stdev(dev);
>   	struct switchtec_ntb *sndev = stdev->sndev;
> diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
> index c8087efa5e4a..d500e5dbbc3f 100644
> --- a/drivers/pcmcia/ds.c
> +++ b/drivers/pcmcia/ds.c
> @@ -1335,8 +1335,7 @@ static struct pcmcia_callback pcmcia_bus_callback = {
>   	.resume = pcmcia_bus_resume,
>   };
>   
> -static int pcmcia_bus_add_socket(struct device *dev,
> -					   struct class_interface *class_intf)
> +static int pcmcia_bus_add_socket(struct device *dev)
>   {
>   	struct pcmcia_socket *socket = dev_get_drvdata(dev);
>   	int ret;
> @@ -1369,8 +1368,7 @@ static int pcmcia_bus_add_socket(struct device *dev,
>   	return 0;
>   }
>   
> -static void pcmcia_bus_remove_socket(struct device *dev,
> -				     struct class_interface *class_intf)
> +static void pcmcia_bus_remove_socket(struct device *dev)
>   {
>   	struct pcmcia_socket *socket = dev_get_drvdata(dev);
>   
> diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
> index ad1141fddb4c..471e0c5815f3 100644
> --- a/drivers/pcmcia/rsrc_nonstatic.c
> +++ b/drivers/pcmcia/rsrc_nonstatic.c
> @@ -1200,8 +1200,7 @@ static const struct attribute_group rsrc_attributes = {
>   	.attrs = pccard_rsrc_attributes,
>   };
>   
> -static int pccard_sysfs_add_rsrc(struct device *dev,
> -					   struct class_interface *class_intf)
> +static int pccard_sysfs_add_rsrc(struct device *dev)
>   {
>   	struct pcmcia_socket *s = dev_get_drvdata(dev);
>   
> @@ -1210,8 +1209,7 @@ static int pccard_sysfs_add_rsrc(struct device *dev,
>   	return sysfs_create_group(&dev->kobj, &rsrc_attributes);
>   }
>   
> -static void pccard_sysfs_remove_rsrc(struct device *dev,
> -					       struct class_interface *class_intf)
> +static void pccard_sysfs_remove_rsrc(struct device *dev)
>   {
>   	struct pcmcia_socket *s = dev_get_drvdata(dev);
>   
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index deb96c3160a7..a115730ebf14 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -2536,10 +2536,8 @@ static void mport_cdev_remove(struct mport_dev *md)
>   /*
>    * mport_add_mport() - Add rio_mport from LDM device struct
>    * @dev:		Linux device model struct
> - * @class_intf:	Linux class_interface
>    */
> -static int mport_add_mport(struct device *dev,
> -		struct class_interface *class_intf)
> +static int mport_add_mport(struct device *dev)
>   {
>   	struct rio_mport *mport = NULL;
>   	struct mport_dev *chdev = NULL;
> @@ -2559,8 +2557,7 @@ static int mport_add_mport(struct device *dev,
>    * mport_remove_mport() - Remove rio_mport from global list
>    * TODO remove device from global mport_dev list
>    */
> -static void mport_remove_mport(struct device *dev,
> -		struct class_interface *class_intf)
> +static void mport_remove_mport(struct device *dev)
>   {
>   	struct rio_mport *mport = NULL;
>   	struct mport_dev *chdev;
> diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> index acaf9cda014c..49f8d111e546 100644
> --- a/drivers/rapidio/rio_cm.c
> +++ b/drivers/rapidio/rio_cm.c
> @@ -2087,13 +2087,11 @@ static int riocm_cdev_add(dev_t devno)
>   /*
>    * riocm_add_mport - add new local mport device into channel management core
>    * @dev: device object associated with mport
> - * @class_intf: class interface
>    *
>    * When a new mport device is added, CM immediately reserves inbound and
>    * outbound RapidIO mailboxes that will be used.
>    */
> -static int riocm_add_mport(struct device *dev,
> -			   struct class_interface *class_intf)
> +static int riocm_add_mport(struct device *dev)
>   {
>   	int rc;
>   	int i;
> @@ -2166,14 +2164,12 @@ static int riocm_add_mport(struct device *dev,
>   /*
>    * riocm_remove_mport - remove local mport device from channel management core
>    * @dev: device object associated with mport
> - * @class_intf: class interface
>    *
>    * Removes a local mport device from the list of registered devices that provide
>    * channel management services. Returns an error if the specified mport is not
>    * registered with the CM core.
>    */
> -static void riocm_remove_mport(struct device *dev,
> -			       struct class_interface *class_intf)
> +static void riocm_remove_mport(struct device *dev)
>   {
>   	struct rio_mport *mport = to_rio_mport(dev);
>   	struct cm_dev *cm;
> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index b11a9162e73a..57feb0cae896 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -663,8 +663,7 @@ static void ses_match_to_enclosure(struct enclosure_device *edev,
>   	}
>   }
>   
> -static int ses_intf_add(struct device *cdev,
> -			struct class_interface *intf)
> +static int ses_intf_add(struct device *cdev)
>   {
>   	struct scsi_device *sdev = to_scsi_device(cdev->parent);
>   	struct scsi_device *tmp_sdev;
> @@ -869,8 +868,7 @@ static void ses_intf_remove_enclosure(struct scsi_device *sdev)
>   	enclosure_unregister(edev);
>   }
>   
> -static void ses_intf_remove(struct device *cdev,
> -			    struct class_interface *intf)
> +static void ses_intf_remove(struct device *cdev)
>   {
>   	struct scsi_device *sdev = to_scsi_device(cdev->parent);
>   
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 4997f880d4a4..037f8c98a6d3 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -96,8 +96,8 @@ static int scatter_elem_sz_prev = SG_SCATTER_SZ;
>   
>   #define SG_SECTOR_SZ 512
>   
> -static int sg_add_device(struct device *, struct class_interface *);
> -static void sg_remove_device(struct device *, struct class_interface *);
> +static int sg_add_device(struct device *);
> +static void sg_remove_device(struct device *);
>   
>   static DEFINE_IDR(sg_index_idr);
>   static DEFINE_RWLOCK(sg_index_lock);	/* Also used to lock
> @@ -1488,7 +1488,7 @@ sg_alloc(struct scsi_device *scsidp)
>   }
>   
>   static int
> -sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
> +sg_add_device(struct device *cl_dev)
>   {
>   	struct scsi_device *scsidp = to_scsi_device(cl_dev->parent);
>   	Sg_device *sdp = NULL;
> @@ -1578,7 +1578,7 @@ sg_device_destroy(struct kref *kref)
>   }
>   
>   static void
> -sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
> +sg_remove_device(struct device *cl_dev)
>   {
>   	struct scsi_device *scsidp = to_scsi_device(cl_dev->parent);
>   	Sg_device *sdp = dev_get_drvdata(cl_dev);
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 53287aa105b8..9deeaeb457bb 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -219,8 +219,8 @@ struct class_interface {
>   	struct list_head	node;
>   	const struct class	*class;
>   
> -	int (*add_dev)		(struct device *, struct class_interface *);
> -	void (*remove_dev)	(struct device *, struct class_interface *);
> +	int (*add_dev)		(struct device *dev);
> +	void (*remove_dev)	(struct device *dev);
>   };
>   
>   int __must_check class_interface_register(struct class_interface *);
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 7e5dff602585..82b28ab0f328 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -81,8 +81,7 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
>   }
>   EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
>   
> -static int alarmtimer_rtc_add_device(struct device *dev,
> -				struct class_interface *class_intf)
> +static int alarmtimer_rtc_add_device(struct device *dev)
>   {
>   	unsigned long flags;
>   	struct rtc_device *rtc = to_rtc_device(dev);

