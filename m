Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375C6BDFED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCQEFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCQEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:04:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE95FA5E;
        Thu, 16 Mar 2023 21:04:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H1tBAM014693;
        Fri, 17 Mar 2023 04:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=hVZC6MazAfM5Hm+DKxFEeicCuSWe4kOc+B2JCPBvQ98=;
 b=STWHT4rpYcxinAKqXUOXpcbUecKV/u7aT/aydos5JHOhq75dGzpncpqnUX8oZ1zeNljk
 NSKywui+9ThjMMtlRnxvxy7yRYr4zrbRZPK7LZRvBAggA7b+91uGiLFXrZ38wSdfhdmx
 HuSakG/PHm4Cp2TA5iplY1adSAZDXfCMvjmDDBIyl0AoPibuIrqmXsIoyapC8my3tvJA
 4wcUNBmrHsxaVWfp3xzTVc0J6abUExWlsfNqEuLEsFRibXnM0J8uVhzrGA4SfE+O6jvu
 pdk/bxALNepUm2ZrON4tRVU3jt0Z5/6TI7J16zaFrJ+8qbvu+hwyepH7ayu/3wVMgX8G aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs262xy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:04:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H1UmhN029652;
        Fri, 17 Mar 2023 04:04:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq66kj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:04:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H44Opo039895;
        Fri, 17 Mar 2023 04:04:27 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pbqq66kg0-3;
        Fri, 17 Mar 2023 04:04:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Don Brace <don.brace@microchip.com>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Raghava Aditya Renukunta <raghavaaditya.renukunta@pmcs.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com
Subject: Re: [PATCH 00/10] PCI/AER: Remove redundant Device Control Error Reporting Enable
Date:   Fri, 17 Mar 2023 00:04:17 -0400
Message-Id: <167902578904.2716271.10035362673649938554.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307182842.870378-1-helgaas@kernel.org>
References: <20230307182842.870378-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_01,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170023
X-Proofpoint-ORIG-GUID: rxiatanqFKx_3unMv5VaFJVPSADDyRgy
X-Proofpoint-GUID: rxiatanqFKx_3unMv5VaFJVPSADDyRgy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 12:28:32 -0600, Bjorn Helgaas wrote:

> Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
> which appeared in v6.0, the PCI core has enabled PCIe error reporting for
> all devices during enumeration.
> 
> Remove driver code to do this and remove unnecessary includes of
> <linux/aer.h> from several other drivers.
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[01/10] scsi: aacraid: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/b3e2bf9c967b
[02/10] scsi: arcmsr: Remove unnecessary aer.h include
        https://git.kernel.org/mkp/scsi/c/915b071a6f83
[03/10] scsi: be2iscsi: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/6574fb2580b0
[04/10] scsi: bfa: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/b54e1e47b5f5
[05/10] scsi: csiostor: Remove unnecessary aer.h include
        https://git.kernel.org/mkp/scsi/c/3afe8d64c4f5
[06/10] scsi: hpsa: Remove unnecessary pci_disable_pcie_error_reporting() comment
        https://git.kernel.org/mkp/scsi/c/b2bce40c5b81
[07/10] scsi: lpfc: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/e891681b1d5d
[08/10] scsi: mpt3sas: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/edf6722f4ad2
[09/10] scsi: qla2xxx: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/c5c440bbff86
[10/10] scsi: qla4xxx: Drop redundant pci_enable_pcie_error_reporting()
        https://git.kernel.org/mkp/scsi/c/d7ba106418d6

-- 
Martin K. Petersen	Oracle Linux Engineering
