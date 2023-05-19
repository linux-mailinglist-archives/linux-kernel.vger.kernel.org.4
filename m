Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1541709E60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjESRkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjESRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:39:51 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA07110;
        Fri, 19 May 2023 10:39:32 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2533a03388dso2487217a91.2;
        Fri, 19 May 2023 10:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517971; x=1687109971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlT8GEH5lbEwlZ4d5mlGb7rM37FNi1N4tAe26jo88Zc=;
        b=BXU8Rw/DXYCMFiHJnx/pnGqaBnyzRvOVloAx3kJsEfgLrZR3n0H+/Nld/l51RVqRM/
         nSyR+zRYtIHcmzjU5AxDghclRAVstChUkFPTOHFb3fgQNYEq/TiFQ8rSvmxK6XirtAYH
         4gEw3/ZniK7ulD9ySpnIPvPyuJ17Nuaafl6WPIBNwxtIzPuRs+LEkD2BSN5A/JAUL/H5
         DDN35ynP8djmELpwYlmmF7cMwvnLFEQwjTn+4rjjoDBJvuY4y2cIfJRbF5h4BsBwgDj6
         wkBz2pst1rlejR9SucklkTkqKxTCWGVqXI3IOrHXLGKKZrZh2HUp4SmUrrw3v48s1huV
         //eA==
X-Gm-Message-State: AC+VfDxPE/p1DiqaSqrxrnt/NdYyTF/kec3BA1ANGTeygTFbrJNSswMp
        uY3K0xNgWc0WSCxfE/DujQU=
X-Google-Smtp-Source: ACHHUZ51XtrJSl7wsMLkDn77hps4d2yG8e3x+ZPqzfxBT5MH+8vJneXhdKo5F/AjLJQRSPYR2VVETg==
X-Received: by 2002:a17:90b:180e:b0:250:85ba:6c3d with SMTP id lw14-20020a17090b180e00b0025085ba6c3dmr2732038pjb.6.1684517971305;
        Fri, 19 May 2023 10:39:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090adc1600b002471deb13fcsm1787730pjv.6.2023.05.19.10.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:39:30 -0700 (PDT)
Message-ID: <ff04d098-17cc-42c5-cf72-2128fb43114e@acm.org>
Date:   Fri, 19 May 2023 10:39:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
 <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
 <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
 <611e1210-d89b-9046-ac3f-68a89af6159e@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <611e1210-d89b-9046-ac3f-68a89af6159e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 10:12, John Garry wrote:
> If only we could pass the actual scsi_cmnd sense buffer to the caller...

How about something like the totally untested patch below?

Thanks,

Bart.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7bb12deab70c..7ff8d5c263f0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -379,15 +379,14 @@ static int ata_get_identity(struct ata_port *ap, struct scsi_device *sdev,
  int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
  {
  	int rc = 0;
-	u8 sensebuf[SCSI_SENSE_BUFFERSIZE];
+	u8 *sensebuf = NULL;
  	u8 scsi_cmd[MAX_COMMAND_SIZE];
  	u8 args[4], *argbuf = NULL;
  	int argsize = 0;
  	struct scsi_sense_hdr sshdr;
  	const struct scsi_exec_args exec_args = {
  		.sshdr = &sshdr,
-		.sense = sensebuf,
-		.sense_len = sizeof(sensebuf),
+		.sense = &sensebuf,
  	};
  	int cmd_result;

@@ -397,7 +396,6 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
  	if (copy_from_user(args, arg, sizeof(args)))
  		return -EFAULT;

-	memset(sensebuf, 0, sizeof(sensebuf));
  	memset(scsi_cmd, 0, sizeof(scsi_cmd));

  	if (args[3]) {
@@ -469,6 +467,7 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
  	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
  		rc = -EFAULT;
  error:
+	scsi_free_sense_buffer(sensebuf);
  	kfree(argbuf);
  	return rc;
  }
@@ -487,15 +486,14 @@ int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
  int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
  {
  	int rc = 0;
-	u8 sensebuf[SCSI_SENSE_BUFFERSIZE];
+	u8 *sensebuf = NULL;
  	u8 scsi_cmd[MAX_COMMAND_SIZE];
  	u8 args[7];
  	struct scsi_sense_hdr sshdr;
  	int cmd_result;
  	const struct scsi_exec_args exec_args = {
  		.sshdr = &sshdr,
-		.sense = sensebuf,
-		.sense_len = sizeof(sensebuf),
+		.sense = &sensebuf,
  	};

  	if (arg == NULL)
@@ -504,7 +502,6 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
  	if (copy_from_user(args, arg, sizeof(args)))
  		return -EFAULT;

-	memset(sensebuf, 0, sizeof(sensebuf));
  	memset(scsi_cmd, 0, sizeof(scsi_cmd));
  	scsi_cmd[0]  = ATA_16;
  	scsi_cmd[1]  = (3 << 1); /* Non-data */
@@ -557,6 +554,7 @@ int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
  	}

   error:
+	scsi_free_sense_buffer(sensebuf);
  	return rc;
  }

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6bc1a9380e69..8197023e9077 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -210,9 +210,6 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,

  	if (!args)
  		args = &default_args;
-	else if (WARN_ON_ONCE(args->sense &&
-			      args->sense_len != SCSI_SENSE_BUFFERSIZE))
-		return -EINVAL;

  	req = scsi_alloc_request(sdev->request_queue, opf, args->req_flags);
  	if (IS_ERR(req))
@@ -248,8 +245,10 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,

  	if (args->resid)
  		*args->resid = scmd->resid_len;
-	if (args->sense)
-		memcpy(args->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
+	if (args->sense) {
+		*args->sense = scmd->sense_buffer;
+		scmd->sense_buffer = NULL;
+	}
  	if (args->sshdr)
  		scsi_normalize_sense(scmd->sense_buffer, scmd->sense_len,
  				     args->sshdr);
@@ -1825,6 +1824,12 @@ static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
  	return ret;
  }

+void scsi_free_sense_buffer(u8 *sense_buffer)
+{
+	kmem_cache_free(scsi_sense_cache, sense_buffer);
+}
+EXPORT_SYMBOL_GPL(scsi_free_sense_buffer);
+
  static void scsi_mq_exit_request(struct blk_mq_tag_set *set, struct request *rq,
  				 unsigned int hctx_idx)
  {
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index ec093594ba53..7c37ef11c71a 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -217,4 +217,6 @@ static inline bool scsi_status_is_good(int status)
  		(status == SAM_STAT_COMMAND_TERMINATED));
  }

+void scsi_free_sense_buffer(u8 *sense_buffer);
+
  #endif /* _SCSI_SCSI_H */
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index f10a008e5bfa..9f713fcb150e 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -460,8 +460,7 @@ extern void scsi_sanitize_inquiry_string(unsigned char *s, int len);

  /* Optional arguments to scsi_execute_cmd */
  struct scsi_exec_args {
-	unsigned char *sense;		/* sense buffer */
-	unsigned int sense_len;		/* sense buffer len */
+	unsigned char **sense;		/* sense buffer */
  	struct scsi_sense_hdr *sshdr;	/* decoded sense header */
  	blk_mq_req_flags_t req_flags;	/* BLK_MQ_REQ flags */
  	int scmd_flags;			/* SCMD flags */

