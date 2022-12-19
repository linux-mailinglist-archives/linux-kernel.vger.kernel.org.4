Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035A2651474
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiLSUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:53:22 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5AF95BB;
        Mon, 19 Dec 2022 12:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671483190; bh=p/gQJhr994QueR5DCQ02g1AeDDewrUyc8tKh6QiFUkY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=HoSm133nBavBRfcicEpLqQ+jRK961tUApRYIQ8pDgIxxofMXWkygWczd/fJE6+/ic
         Ddxwd4DaigF7a2OKLqu8uG3DH1G4Ie1WgT5+hTRRZLvzsvoSRcSmrP8ha5J5lGQ0Fz
         Zro/l0IX/xXdS5Dw+4yxv7SB4K3Yr3LxK9N9dP/M=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 19 Dec 2022 21:53:10 +0100 (CET)
X-EA-Auth: +h2tLTIwcg0ajAKuBXmzbKsnCnk2zDEhM6dJi882wT8DN3KzYR/3+5BACGCSRR5Q+YR5WyE8C8ku02eMcjcEXmrxEU07Owm8
Date:   Tue, 20 Dec 2022 02:23:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: Re: [PATCH] scsi: qla4xxx: Use sysfs_emit in show function callsbacks
Message-ID: <Y6DPMipC0V00uUu0@qemulion>
References: <Y5RF+PGBuiXu7UrX@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5RF+PGBuiXu7UrX@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 02:10:24PM +0530, Deepak R Varma wrote:
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit instead
> of sprintf family functions.
> Issue identified using the coccinelle device_attr_show.cocci script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Hello,
May I please request a review and feedback on this patch?

Thank you,
./drv

> ---
>  drivers/scsi/qla4xxx/ql4_attr.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/scsi/qla4xxx/ql4_attr.c b/drivers/scsi/qla4xxx/ql4_attr.c
> index abfa6ef60480..773b8dbe1121 100644
> --- a/drivers/scsi/qla4xxx/ql4_attr.c
> +++ b/drivers/scsi/qla4xxx/ql4_attr.c
> @@ -156,11 +156,11 @@ qla4xxx_fw_version_show(struct device *dev,
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
>
>  	if (is_qla80XX(ha))
> -		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
> +		return sysfs_emit(buf, "%d.%02d.%02d (%x)\n",
>  				ha->fw_info.fw_major, ha->fw_info.fw_minor,
>  				ha->fw_info.fw_patch, ha->fw_info.fw_build);
>  	else
> -		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
> +		return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
>  				ha->fw_info.fw_major, ha->fw_info.fw_minor,
>  				ha->fw_info.fw_patch, ha->fw_info.fw_build);
>  }
> @@ -170,7 +170,7 @@ qla4xxx_serial_num_show(struct device *dev, struct device_attribute *attr,
>  			char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ha->serial_number);
> +	return sysfs_emit(buf, "%s\n", ha->serial_number);
>  }
>
>  static ssize_t
> @@ -178,7 +178,7 @@ qla4xxx_iscsi_version_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "%d.%02d\n", ha->fw_info.iscsi_major,
> +	return sysfs_emit(buf, "%d.%02d\n", ha->fw_info.iscsi_major,
>  			ha->fw_info.iscsi_minor);
>  }
>
> @@ -187,7 +187,7 @@ qla4xxx_optrom_version_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
> +	return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
>  			ha->fw_info.bootload_major, ha->fw_info.bootload_minor,
>  			ha->fw_info.bootload_patch, ha->fw_info.bootload_build);
>  }
> @@ -197,7 +197,7 @@ qla4xxx_board_id_show(struct device *dev, struct device_attribute *attr,
>  		      char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "0x%08X\n", ha->board_id);
> +	return sysfs_emit(buf, "0x%08X\n", ha->board_id);
>  }
>
>  static ssize_t
> @@ -207,7 +207,7 @@ qla4xxx_fw_state_show(struct device *dev, struct device_attribute *attr,
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
>
>  	qla4xxx_get_firmware_state(ha);
> -	return snprintf(buf, PAGE_SIZE, "0x%08X%8X\n", ha->firmware_state,
> +	return sysfs_emit(buf, "0x%08X%8X\n", ha->firmware_state,
>  			ha->addl_fw_state);
>  }
>
> @@ -220,7 +220,7 @@ qla4xxx_phy_port_cnt_show(struct device *dev, struct device_attribute *attr,
>  	if (is_qla40XX(ha))
>  		return -ENOSYS;
>
> -	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_cnt);
> +	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_cnt);
>  }
>
>  static ssize_t
> @@ -232,7 +232,7 @@ qla4xxx_phy_port_num_show(struct device *dev, struct device_attribute *attr,
>  	if (is_qla40XX(ha))
>  		return -ENOSYS;
>
> -	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_num);
> +	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_num);
>  }
>
>  static ssize_t
> @@ -244,7 +244,7 @@ qla4xxx_iscsi_func_cnt_show(struct device *dev, struct device_attribute *attr,
>  	if (is_qla40XX(ha))
>  		return -ENOSYS;
>
> -	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->iscsi_pci_func_cnt);
> +	return sysfs_emit(buf, "0x%04X\n", ha->iscsi_pci_func_cnt);
>  }
>
>  static ssize_t
> @@ -253,7 +253,7 @@ qla4xxx_hba_model_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
>
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ha->model_name);
> +	return sysfs_emit(buf, "%s\n", ha->model_name);
>  }
>
>  static ssize_t
> @@ -261,7 +261,7 @@ qla4xxx_fw_timestamp_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "%s %s\n", ha->fw_info.fw_build_date,
> +	return sysfs_emit(buf, "%s %s\n", ha->fw_info.fw_build_date,
>  			ha->fw_info.fw_build_time);
>  }
>
> @@ -270,7 +270,7 @@ qla4xxx_fw_build_user_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.fw_build_user);
> +	return sysfs_emit(buf, "%s\n", ha->fw_info.fw_build_user);
>  }
>
>  static ssize_t
> @@ -278,7 +278,7 @@ qla4xxx_fw_ext_timestamp_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.extended_timestamp);
> +	return sysfs_emit(buf, "%s\n", ha->fw_info.extended_timestamp);
>  }
>
>  static ssize_t
> @@ -300,7 +300,7 @@ qla4xxx_fw_load_src_show(struct device *dev, struct device_attribute *attr,
>  		break;
>  	}
>
> -	return snprintf(buf, PAGE_SIZE, "%s\n", load_src);
> +	return sysfs_emit(buf, "%s\n", load_src);
>  }
>
>  static ssize_t
> @@ -309,7 +309,7 @@ qla4xxx_fw_uptime_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
>  	qla4xxx_about_firmware(ha);
> -	return snprintf(buf, PAGE_SIZE, "%u.%u secs\n", ha->fw_uptime_secs,
> +	return sysfs_emit(buf, "%u.%u secs\n", ha->fw_uptime_secs,
>  			ha->fw_uptime_msecs);
>  }
>
> --
> 2.34.1
>


