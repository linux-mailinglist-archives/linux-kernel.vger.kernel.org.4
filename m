Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D676E9B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjDTRoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDTRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:43:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017D4ED2;
        Thu, 20 Apr 2023 10:43:38 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KHY3AJ013300;
        Thu, 20 Apr 2023 17:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ohRA5xQp84/7gj+nbFshkI9cTNC4RTACQM3OzbAEp9c=;
 b=Fg4/YPDPBOfxG+kvhkJClgRThWL6dI71nSBt7+dUYctIdBwwqR0z4+O9OWJyfFsaTc86
 CWuN4sx4g44oIB0dw/Kb8wo7vuWRYCmLgBFe/U/BAYdyKNski/IN4PpExHH1QUURf1Mg
 yhmJjDPlUSE1rR8Q0yXFzm/5AOpe+fz1qHxXxzFsRym9k9wDSbgVE/6KHWI9ubWoxSQm
 wZOpfcFPz18MZabh+Zr1QLBARvkdNxgm73bj0njFkpRCRgBN8UDSoW5iN+gbLrVs0w9N
 e8cUfjMih7mvoKaH8TQflaLQEz3Z5cD6TpInUpzy8RCQOfHKeB5Y230k0YJg3hADMgde Tg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q39wfrj8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 17:43:27 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33K1MQVd017940;
        Thu, 20 Apr 2023 17:43:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pykj6jxym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 17:43:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33KHhMjl66191780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 17:43:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A80A2004D;
        Thu, 20 Apr 2023 17:43:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0638020043;
        Thu, 20 Apr 2023 17:43:22 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.171.85.7])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Apr 2023 17:43:21 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1ppYJV-004RkS-1g;
        Thu, 20 Apr 2023 19:43:21 +0200
Date:   Thu, 20 Apr 2023 17:43:21 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        acelan.kao@canonical.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Avoid doing rescan on suspended device
Message-ID: <20230420174321.GA123094@t480-pf1aa2c2>
References: <20230419054112.269734-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230419054112.269734-1-kai.heng.feng@canonical.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FiuplC5Y8z5W0DKhabnZidjDFNIZ9op2
X-Proofpoint-ORIG-GUID: FiuplC5Y8z5W0DKhabnZidjDFNIZ9op2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_13,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=737 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 01:41:12PM +0800, Kai-Heng Feng wrote:
> During system resume, if an EH is schduled after ATA host is resumed
> (i.e. ATA_PFLAG_PM_PENDING cleared), but before the disk device is
> resumed, the device_lock hold by scsi_rescan_device() is never released
> so the dpm_resume() of the disk is blocked forerver.
> 
> That's because scsi_attach_vpd() is expecting the disk device is in
> operational state, as it doesn't work on suspended device.
> 
> To avoid such deadlock, avoid doing rescan if the disk is still
> suspended so the resume process of the disk device can proceed.

I'm no expert on suspend/resume, but wouldn't you then potentially miss
changes that have been done to the LUN during suspend?

What takes care of updating the VPDs, scsi-disk re-evaluation and such
in this case, when you block it initially during wakeup?

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/scsi/scsi_scan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index d217be323cc6..36680cb1535b 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1621,6 +1621,9 @@ void scsi_rescan_device(struct device *dev)
>  {
>  	struct scsi_device *sdev = to_scsi_device(dev);
>  
> +	if (dev->power.is_prepared)
> +		return;
> +
>  	device_lock(dev);
>  
>  	scsi_attach_vpd(sdev);
> -- 
> 2.34.1
> 

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
