Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23860696A78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjBNQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjBNQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:57:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B815BB3;
        Tue, 14 Feb 2023 08:57:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGXnJi018990;
        Tue, 14 Feb 2023 16:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=dz81OhsNO6aG2TXXZVXYeGU00TuEu+Wx+1CJuDXwkc0=;
 b=lojJrtpfrq3UMSWB+ypaBVRgGsKQhZ+me8O/jwd6k8FAOGX+MD8K7PZPEJoOengEDC9N
 Qn/UUTy2+IU52B35vbkUgrl08zcUSW5VLfqxefC2eSMGlPQSWJO/1JaxF3ZASIeO1cYX
 V7j4zzcH0KA/Oc7+pM6Bwi5z65+ozCaJbYQMGDuESNLTp1hu5Z8LKwrbVIwxrKyDf4DD
 JIFCtlYoLuhzB6r5Qj8KBT+0hxfoBsw8bMhz43Ql+Q4wyKQQDlL7fWzhIkNYjKzLzVJD
 oIXQEdaKrxKrkL+eOW7RJHqXaU9AXK9YR2j2U9sdFkvAhOYht1EaqaIo5rQiZOB+pRuc 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3dxmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EGr8Bd009572;
        Tue, 14 Feb 2023 16:57:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5uuft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31EGuHob039739;
        Tue, 14 Feb 2023 16:57:40 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f5uuff-1;
        Tue, 14 Feb 2023 16:57:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] ufs: host: ufs-qcom: Add support for SM8550
Date:   Tue, 14 Feb 2023 11:57:27 -0500
Message-Id: <167639371072.486235.1047022414059999681.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119151406.4168685-1-abel.vesa@linaro.org>
References: <20230119151406.4168685-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=854 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140144
X-Proofpoint-GUID: r0qb58Ac7h194BwyVh0X3fL_401ZDmc5
X-Proofpoint-ORIG-GUID: r0qb58Ac7h194BwyVh0X3fL_401ZDmc5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 17:14:04 +0200, Abel Vesa wrote:

> This patchset adds UFS HC support for the new Qualcomm SM8550 SoC.
> 
> The v1 was here:
> https://lore.kernel.org/all/20221116121732.2731448-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * replaced REG_UFS_PA_LINK_STARTUP_TIMER with REG_UFS_CFG0 and added a
>    comment saying that the older version use the first name as reg name
>  * moved QUNIPRO_G4_SEL in a separate section dedicated to CFG0 bits
>  * forces the update_link_startup_timer condition to be skipped in case
>    of HW version 5.x
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/2] scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW version major 5
      https://git.kernel.org/mkp/scsi/c/9c02aa24bf40
[2/2] dt-bindings: ufs: qcom: Add SM8550 compatible string
      https://git.kernel.org/mkp/scsi/c/b8c203891121

-- 
Martin K. Petersen	Oracle Linux Engineering
