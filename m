Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5468FD53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjBICtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjBICrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:47:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37761BB97;
        Wed,  8 Feb 2023 18:44:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3192IoRM029710;
        Thu, 9 Feb 2023 02:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=jonutzCUJeNDPH/zLzxf7GoxE/fiJHRRF9NYt77NKEY=;
 b=jp9ro+Kcu5YAECMZY7VpPaqaUUSAHLbjssKIK+30EIXqHCl++ITy6dkWnAkMYpP8ZmWw
 c7Rc071oCKjHMKKQTnKP9K+BhTHLpMLujfFDsIVp2irMu6n68AIvE2t8MquoBCUqRh+w
 FGrxmwCVp9oLW5WuTvM5pzBv9AZiHLPrBHTMdPKBrwh9FtyNk4dZ9XLwQAWFGq5mqmT6
 EIoud/8gD5vi2Vaemf8VmsOY/ZPg4gtRX/euX1CCKPy1vMOZF6KSUfgqVNUNlKgINUP1
 hYSR/PTdn9KYtvggRtwWm+nbUzGfvQprN1hWdg9l0zcN8TRlmyiXS92/swOH45w1tpZs JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdsr34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 02:43:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3191kimA006006;
        Thu, 9 Feb 2023 02:43:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt8knd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 02:43:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3192hs7J035240;
        Thu, 9 Feb 2023 02:43:54 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt8knbs-1;
        Thu, 09 Feb 2023 02:43:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: fix platform_msi_domain_free_irqs() reference
Date:   Wed,  8 Feb 2023 21:43:49 -0500
Message-Id: <167591059933.455022.10654647561650400323.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126211831.2274211-1-arnd@kernel.org>
References: <20230126211831.2274211-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=854 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090023
X-Proofpoint-ORIG-GUID: Bf0boW36cf8liDu0N6Ki59xYekEQAVpg
X-Proofpoint-GUID: Bf0boW36cf8liDu0N6Ki59xYekEQAVpg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 22:17:31 +0100, Arnd Bergmann wrote:

> The newly added MSI support is mostly hidden inside of an #ifdef,
> except for one line that now causes a build failure when MSI
> is disabled:
> 
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_remove':
> drivers/ufs/host/ufs-qcom.c:1698:9: error: implicit declaration of function 'platform_msi_domain_free_irqs' [-Werror=i]
>  1698 |         platform_msi_domain_free_irqs(hba->dev);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: ufs: qcom: fix platform_msi_domain_free_irqs() reference
      https://git.kernel.org/mkp/scsi/c/49f262bc3c7a

-- 
Martin K. Petersen	Oracle Linux Engineering
