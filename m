Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2575464F98E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLQPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 10:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLQPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 10:01:54 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C815F21
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671289299; bh=PzcmbX93Mhv02rTi0UT4iZqjIgiQekuMzEPjyVID9HA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=H+lQ6VBtXY7+f7uGty+boaOq19XG9kYn8HLpIv+dzsVOz1NMHafkYcUsvuuoQh9we
         Hq0jLjy4HtXYfcueK58urYOg8Y/gsWDhNhnUuPdcpEu/dSkr4iqMMyrNblKO55lf/9
         /gpzadTndFz75b5Ea58VCCUf3h0ihRIwbRpiQu1M=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 17 Dec 2022 16:01:39 +0100 (CET)
X-EA-Auth: XJGa/qaodCmS38qMyr05c8pGA+mWusuUp8iwI3bn/i0KNsDoRDDT7/P3MJZy1xweEKLrmpZuq6SMZNwR2vkGhV8B9RWVx0AT
Date:   Sat, 17 Dec 2022 20:31:33 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: Re: [PATCH] scsi: pm8001: Use sysfs_emit in show function callsbacks
Message-ID: <Y53ZzSvDz8w7fZyr@qemulion>
References: <Y5JE/xI2NNbnox/A@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5JE/xI2NNbnox/A@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:41:43AM +0530, Deepak R Varma wrote:
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit instead
> of sprintf family functions.
> Issue identified using the coccinelle device_attr_show.cocci script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello All,
Just wanted to follow up on this patch submitted earlier. May I please request
a review and feedback on this patch.

Thank you,
./drv

>  drivers/scsi/pm8001/pm8001_ctl.c | 48 +++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 73f036bed128..8cfdf9b412c9 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -61,10 +61,10 @@ static ssize_t pm8001_ctl_mpi_interface_rev_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id == chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%d\n",
> +		return sysfs_emit(buf, "%d\n",
>  			pm8001_ha->main_cfg_tbl.pm8001_tbl.interface_rev);
>  	} else {
> -		return snprintf(buf, PAGE_SIZE, "%d\n",
> +		return sysfs_emit(buf, "%d\n",
>  			pm8001_ha->main_cfg_tbl.pm80xx_tbl.interface_rev);
>  	}
>  }
> @@ -86,7 +86,7 @@ static ssize_t controller_fatal_error_show(struct device *cdev,
>  	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  			pm8001_ha->controller_fatal_error);
>  }
>  static DEVICE_ATTR_RO(controller_fatal_error);
> @@ -107,13 +107,13 @@ static ssize_t pm8001_ctl_fw_version_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id == chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>  		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 24),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 16),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 8),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev));
>  	} else {
> -		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 24),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 16),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 8),
> @@ -138,7 +138,7 @@ static ssize_t pm8001_ctl_ila_version_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id != chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 24),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 16),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 8),
> @@ -164,7 +164,7 @@ static ssize_t pm8001_ctl_inactive_fw_version_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id != chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 24),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 16),
>  		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 8),
> @@ -191,10 +191,10 @@ static ssize_t pm8001_ctl_max_out_io_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id == chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%d\n",
> +		return sysfs_emit(buf, "%d\n",
>  			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_out_io);
>  	} else {
> -		return snprintf(buf, PAGE_SIZE, "%d\n",
> +		return sysfs_emit(buf, "%d\n",
>  			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io);
>  	}
>  }
> @@ -215,13 +215,11 @@ static ssize_t pm8001_ctl_max_devices_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id == chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%04d\n",
> -			(u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16)
> -			);
> +		return sysfs_emit(buf, "%04d\n",
> +			(u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16));
>  	} else {
> -		return snprintf(buf, PAGE_SIZE, "%04d\n",
> -			(u16)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl >> 16)
> -			);
> +		return sysfs_emit(buf, "%04d\n",
> +			(u16)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl >> 16));
>  	}
>  }
>  static DEVICE_ATTR(max_devices, S_IRUGO, pm8001_ctl_max_devices_show, NULL);
> @@ -242,13 +240,11 @@ static ssize_t pm8001_ctl_max_sg_list_show(struct device *cdev,
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>  	if (pm8001_ha->chip_id == chip_8001) {
> -		return snprintf(buf, PAGE_SIZE, "%04d\n",
> -			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF
> -			);
> +		return sysfs_emit(buf, "%04d\n",
> +			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF);
>  	} else {
> -		return snprintf(buf, PAGE_SIZE, "%04d\n",
> -			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl & 0x0000FFFF
> -			);
> +		return sysfs_emit(buf, "%04d\n",
> +			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl & 0x0000FFFF);
>  	}
>  }
>  static DEVICE_ATTR(max_sg_list, S_IRUGO, pm8001_ctl_max_sg_list_show, NULL);
> @@ -315,7 +311,7 @@ static ssize_t pm8001_ctl_host_sas_address_show(struct device *cdev,
>  	struct Scsi_Host *shost = class_to_shost(cdev);
>  	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
> -	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
> +	return sysfs_emit(buf, "0x%016llx\n",
>  			be64_to_cpu(*(__be64 *)pm8001_ha->sas_addr));
>  }
>  static DEVICE_ATTR(host_sas_address, S_IRUGO,
> @@ -336,7 +332,7 @@ static ssize_t pm8001_ctl_logging_level_show(struct device *cdev,
>  	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -	return snprintf(buf, PAGE_SIZE, "%08xh\n", pm8001_ha->logging_level);
> +	return sysfs_emit(buf, "%08xh\n", pm8001_ha->logging_level);
>  }
>
>  static ssize_t pm8001_ctl_logging_level_store(struct device *cdev,
> @@ -517,7 +513,7 @@ static ssize_t event_log_size_show(struct device *cdev,
>  	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size);
>  }
>  static DEVICE_ATTR_RO(event_log_size);
> @@ -604,7 +600,7 @@ static ssize_t non_fatal_count_show(struct device *cdev,
>  	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>  	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -	return snprintf(buf, PAGE_SIZE, "%08x",
> +	return sysfs_emit(buf, "%08x",
>  			pm8001_ha->non_fatal_count);
>  }
>
> @@ -884,7 +880,7 @@ static ssize_t pm8001_show_update_fw(struct device *cdev,
>  	if (pm8001_ha->fw_status != FLASH_IN_PROGRESS)
>  		pm8001_ha->fw_status = FLASH_OK;
>
> -	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
> +	return sysfs_emit(buf, "status=%x %s\n",
>  			flash_error_table[i].err_code,
>  			flash_error_table[i].reason);
>  }
> --
> 2.34.1
>


