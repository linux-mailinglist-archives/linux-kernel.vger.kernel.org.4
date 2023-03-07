Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5D6AD51E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCGC6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCGC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:57:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333142697;
        Mon,  6 Mar 2023 18:57:52 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326NwsuW024457;
        Tue, 7 Mar 2023 02:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=p4nGdLCKpXQ5iIfc/erFrIsfuZ6KAXNNSQSV/wwY81g=;
 b=1KiKYa00DsK7822OA0l6kzJT19Oh1fZqtcnBo8/vB3UhBvtgZUSZWS4oxx6s/fltmEFx
 CmTXEQkDlYapEnbLKkX61YgwNSNTVS4J5ZmI+V8+es5gStPLAeUYzNfsfPIrfObuDN3y
 CKoZKcBXT8sfZfg2GzVh0uCJfpuMsDMt+zmMX7ay7gDPm8eJUiF51mWF1nJP5ef95lJi
 jMpTlDJIrGJ0u48xlXCVeuMPVID2RpFACyA2GKPZgvEgPso8btWM2kfQcoK4jA/Sbh9v
 vLdjNgz+V1Ch4R4IcyfS3Rjs+MbgztjPdFPnY5J/iprgzNlqzKAWt9wZtCUhnZH3w6w1 oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wmgr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:57:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3270hBrc037537;
        Tue, 7 Mar 2023 02:57:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txdvjkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:57:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3272vY2O009567;
        Tue, 7 Mar 2023 02:57:41 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p4txdvjhj-8;
        Tue, 07 Mar 2023 02:57:41 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     quic_cang@quicinc.com, linux-scsi@vger.kernel.org,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ufs: mcq: qcom: Fix passing zero to PTR_ERR
Date:   Mon,  6 Mar 2023 21:57:25 -0500
Message-Id: <167815780209.2075334.14673618232448098943.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
References: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=826 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070025
X-Proofpoint-GUID: wfCDcqvgeC5zKXOkx1OArp9XpEWMUziK
X-Proofpoint-ORIG-GUID: wfCDcqvgeC5zKXOkx1OArp9XpEWMUziK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 17:41:06 -0800, Asutosh Das wrote:

> Fix an error case in ufs_qcom_mcq_config_resource(), where the
> return value is set to 0 before passing it to PTR_ERR.
> 
> This led to Smatch warning:
> drivers/ufs/host/ufs-qcom.c:1455 ufs_qcom_mcq_config_resource() warn:
> passing zero to 'PTR_ERR'
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] ufs: mcq: qcom: Fix passing zero to PTR_ERR
      https://git.kernel.org/mkp/scsi/c/c8be073bd2bc

-- 
Martin K. Petersen	Oracle Linux Engineering
