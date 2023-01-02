Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7A65B35D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjABOdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjABOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:33:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9EF6578
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:33:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so32280645lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=atXZV86P+fGXv0u3oCyx2+4h7KUKzLmQY9crWqXb5jI=;
        b=D1JJNiZTRRj3U7jzc1dbQpOzrMNw6MYNth9eQE7UGeSpTNgqiJfETRa5HUsQNF2ths
         D5JTj/piaT6SZwqpTh+qSSymEPMfkb1z/sAAWjG/AczCcB/6u1ygzYCz7wq0cvVRJwza
         eopjy8RpZg4+K/L/o9eg2+9V2YFz1n6xYfwyi6dnvlWxHEu1YlsoR0StR8OCsOwgmdUz
         rvZBgaaaO4F00SaqkuRs75bNwIDXC6jquDUMf/NxmU/FSYvPORWdFkp/2XRy9u1jzqlJ
         Tc4ViDvULTcuSDPnDyufJzI4iLC6hw3X6L1+ekPZq4qWzyM88es0UFBdRFCi8rID4n2R
         peSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atXZV86P+fGXv0u3oCyx2+4h7KUKzLmQY9crWqXb5jI=;
        b=wn3sI45uems09zRLKh3fSndnzGqdN2w7Y1N0x7vuUCe3XO7DLHcRtPZX7TPIk2Euil
         nRy2U3XBdpX2ZElT6DV/tuamkDlieTvbX3xdLTs2xUTv7HTNVIEPS6FafMf28MPmbDyR
         y6L62B2CRyNpArgjv++bgUvrtBdWYdqrUzZnImNvRtCLPRm4mZ9COwlnOvGF12J9Ss1b
         4KuimeiKGzq/H/8Urff1Aip+6uAsgbuyjkeJ6ESZfkTJPAmpn5PIdpq78Mu8kMKw2JOx
         pSPo3RbHbOvVaUn7gCX2T5wrRt5bsO2QS174fFR0MzY/tS26X2lUS8Y7CqiI8vMjXBYO
         fgdw==
X-Gm-Message-State: AFqh2kq31kSiV5uxOgb/8+etjgKvmrKpt+DuivjUS3+64mWtOI1/bFa8
        3t7haKdZ94m7/NEDK8wexQN4P+JuQAcJBSbTRLaxqw==
X-Google-Smtp-Source: AMrXdXvk7+FpVj4RB56wf+NZAJqo0WkOuGexMQ30M8g8KcHZQy3qjj7QOvhzWKYw2STvlGq702wtUHVP3hbksGZo6Ho=
X-Received: by 2002:a05:6512:c14:b0:4b5:7d6e:5fe7 with SMTP id
 z20-20020a0565120c1400b004b57d6e5fe7mr1661109lfu.469.1672670013399; Mon, 02
 Jan 2023 06:33:33 -0800 (PST)
MIME-Version: 1.0
References: <Y5JE/xI2NNbnox/A@qemulion>
In-Reply-To: <Y5JE/xI2NNbnox/A@qemulion>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 2 Jan 2023 15:33:22 +0100
Message-ID: <CAMGffEkk1ue7+37jJJLUT0Coir2Lz4p5jPdJrs40esyC05JMkw@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: Use sysfs_emit in show function callsbacks
To:     Deepak R Varma <drv@mailo.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 9:11 PM Deepak R Varma <drv@mailo.com> wrote:
>
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit instead
> of sprintf family functions.
> Issue identified using the coccinelle device_attr_show.cocci script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c | 48 +++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 73f036bed128..8cfdf9b412c9 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -61,10 +61,10 @@ static ssize_t pm8001_ctl_mpi_interface_rev_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id == chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%d\n",
> +               return sysfs_emit(buf, "%d\n",
>                         pm8001_ha->main_cfg_tbl.pm8001_tbl.interface_rev);
>         } else {
> -               return snprintf(buf, PAGE_SIZE, "%d\n",
> +               return sysfs_emit(buf, "%d\n",
>                         pm8001_ha->main_cfg_tbl.pm80xx_tbl.interface_rev);
>         }
>  }
> @@ -86,7 +86,7 @@ static ssize_t controller_fatal_error_show(struct device *cdev,
>         struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n",
> +       return sysfs_emit(buf, "%d\n",
>                         pm8001_ha->controller_fatal_error);
>  }
>  static DEVICE_ATTR_RO(controller_fatal_error);
> @@ -107,13 +107,13 @@ static ssize_t pm8001_ctl_fw_version_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id == chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +               return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>                 (u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 24),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 16),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 8),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev));
>         } else {
> -               return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +               return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 24),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 16),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 8),
> @@ -138,7 +138,7 @@ static ssize_t pm8001_ctl_ila_version_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id != chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +               return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 24),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 16),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 8),
> @@ -164,7 +164,7 @@ static ssize_t pm8001_ctl_inactive_fw_version_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id != chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
> +               return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 24),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 16),
>                 (u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 8),
> @@ -191,10 +191,10 @@ static ssize_t pm8001_ctl_max_out_io_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id == chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%d\n",
> +               return sysfs_emit(buf, "%d\n",
>                         pm8001_ha->main_cfg_tbl.pm8001_tbl.max_out_io);
>         } else {
> -               return snprintf(buf, PAGE_SIZE, "%d\n",
> +               return sysfs_emit(buf, "%d\n",
>                         pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io);
>         }
>  }
> @@ -215,13 +215,11 @@ static ssize_t pm8001_ctl_max_devices_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id == chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%04d\n",
> -                       (u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16)
> -                       );
> +               return sysfs_emit(buf, "%04d\n",
> +                       (u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16));
>         } else {
> -               return snprintf(buf, PAGE_SIZE, "%04d\n",
> -                       (u16)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl >> 16)
> -                       );
> +               return sysfs_emit(buf, "%04d\n",
> +                       (u16)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl >> 16));
>         }
>  }
>  static DEVICE_ATTR(max_devices, S_IRUGO, pm8001_ctl_max_devices_show, NULL);
> @@ -242,13 +240,11 @@ static ssize_t pm8001_ctl_max_sg_list_show(struct device *cdev,
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
>         if (pm8001_ha->chip_id == chip_8001) {
> -               return snprintf(buf, PAGE_SIZE, "%04d\n",
> -                       pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF
> -                       );
> +               return sysfs_emit(buf, "%04d\n",
> +                       pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF);
>         } else {
> -               return snprintf(buf, PAGE_SIZE, "%04d\n",
> -                       pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl & 0x0000FFFF
> -                       );
> +               return sysfs_emit(buf, "%04d\n",
> +                       pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl & 0x0000FFFF);
>         }
>  }
>  static DEVICE_ATTR(max_sg_list, S_IRUGO, pm8001_ctl_max_sg_list_show, NULL);
> @@ -315,7 +311,7 @@ static ssize_t pm8001_ctl_host_sas_address_show(struct device *cdev,
>         struct Scsi_Host *shost = class_to_shost(cdev);
>         struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
> -       return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
> +       return sysfs_emit(buf, "0x%016llx\n",
>                         be64_to_cpu(*(__be64 *)pm8001_ha->sas_addr));
>  }
>  static DEVICE_ATTR(host_sas_address, S_IRUGO,
> @@ -336,7 +332,7 @@ static ssize_t pm8001_ctl_logging_level_show(struct device *cdev,
>         struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -       return snprintf(buf, PAGE_SIZE, "%08xh\n", pm8001_ha->logging_level);
> +       return sysfs_emit(buf, "%08xh\n", pm8001_ha->logging_level);
>  }
>
>  static ssize_t pm8001_ctl_logging_level_store(struct device *cdev,
> @@ -517,7 +513,7 @@ static ssize_t event_log_size_show(struct device *cdev,
>         struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n",
> +       return sysfs_emit(buf, "%d\n",
>                 pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size);
>  }
>  static DEVICE_ATTR_RO(event_log_size);
> @@ -604,7 +600,7 @@ static ssize_t non_fatal_count_show(struct device *cdev,
>         struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
>
> -       return snprintf(buf, PAGE_SIZE, "%08x",
> +       return sysfs_emit(buf, "%08x",
>                         pm8001_ha->non_fatal_count);
>  }
>
> @@ -884,7 +880,7 @@ static ssize_t pm8001_show_update_fw(struct device *cdev,
>         if (pm8001_ha->fw_status != FLASH_IN_PROGRESS)
>                 pm8001_ha->fw_status = FLASH_OK;
>
> -       return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
> +       return sysfs_emit(buf, "status=%x %s\n",
>                         flash_error_table[i].err_code,
>                         flash_error_table[i].reason);
>  }
> --
> 2.34.1
>
>
>
