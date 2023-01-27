Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7638967DCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjA0DXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjA0DX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:23:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE971647;
        Thu, 26 Jan 2023 19:23:21 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0O1g3019401;
        Fri, 27 Jan 2023 03:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=HL8WYkQvLO0YNFWNqYPepfhle6GAhKACxkNdCCuJbQ4=;
 b=Uzb9XTdk6Kfd/xf928+x8oNYWxwjE7bGst6bk4uYky5h7dYXbTP7eljtj3iKdFcpG8+P
 8Q2M0j1b8QG5rU0ElQLyY7vqZSC/H4uxZq8bCl71K4cyKEY1MAWmBc5K8zVR3KE96o3j
 p3eWsyoaJ5wSNr7xlWZXDpVeMI+e4vGV1cIlL3DZS7sVIxMK4/urz+1ji61pjmHAcTJf
 pjKXzonbhxJzw7d24snxAxh5iCHdII4aVxjnI386uvWRiMVh5W5e54mAMeE5WkdRPPK3
 yLm73CVU4vC85l370sXn3HeOQrcxWhtUdjqMHx4ZQ3ZMNpKiVPiiQ5H+44fI3cAAMmvf fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku3sy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QNrJhU006632;
        Fri, 27 Jan 2023 03:23:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8nxrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30R3N7eo036358;
        Fri, 27 Jan 2023 03:23:13 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g8nxpp-6;
        Fri, 27 Jan 2023 03:23:13 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Add flexible array member for SGLs
Date:   Thu, 26 Jan 2023 22:22:59 -0500
Message-Id: <167478863281.3972592.13981423399363284186.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230106053153.never.999-kees@kernel.org>
References: <20230106053153.never.999-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=760 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270029
X-Proofpoint-GUID: 0p9jFL192k_IX8d-xQLOLEtRVYJDLy7D
X-Proofpoint-ORIG-GUID: 0p9jFL192k_IX8d-xQLOLEtRVYJDLy7D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023 21:32:00 -0800, Kees Cook wrote:

> struct MPI2_RAID_SCSI_IO_REQUEST ends with a single SGL, but expects to
> copy multiple. Add a flexible array member so the compiler can reason
> about the size of the memcpy(). This will avoid the run-time false
> positive warning:
> 
>   memcpy: detected field-spanning write (size 128) of single field "&r1_cmd->io_request->SGL" at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326 (size 16)
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: megaraid_sas: Add flexible array member for SGLs
      https://git.kernel.org/mkp/scsi/c/a9a3629592ab

-- 
Martin K. Petersen	Oracle Linux Engineering
