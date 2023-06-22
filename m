Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBD739471
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFVB0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFVB0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:26:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B731BD4;
        Wed, 21 Jun 2023 18:26:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LK8YNp030147;
        Thu, 22 Jun 2023 01:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=WaJksFiFzKHHvI7H5XkVEQKMVuRHQooxoeYInp40MTQ=;
 b=j2Qk693y9+RTVJbpv3TKb1DL+cnbQ55p2kqvkEqEoA1MtQAZigUHfydg3Dx/uJz9XVJc
 8E2jZpQ2IohLAduAGOcZomvLbSkhlCGVJSAjrpDPx3w1DrLdtb8NbwY5Yd+0+uWEoBKP
 /2bYkhAMs7vsq/p9+hw/OmO3L4CFNfiN3+Q4Vhts8nCxzYM4ny/bm2mW3Yjg4YpTgDZe
 5/5ojz1to0Z3xters8sipCv0J3Sb7V8Zicrs0nY2k/XR6IUQybGAuDw5o4zq523EUSr6
 rf1KIfEsAqZ6xZdoxK8C4EuM85+W2sVw1axi696jcTnbNhiaJJkX5PBWmKoRXUqORA6f oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbrtr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:26:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LMowhV038607;
        Thu, 22 Jun 2023 01:26:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396thyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:26:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35M1QXax038374;
        Thu, 22 Jun 2023 01:26:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r9396thxp-5;
        Thu, 22 Jun 2023 01:26:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Peter Wang <peter.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lu Hongfei <luhongfei@vivo.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v5] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
Date:   Wed, 21 Jun 2023 21:26:23 -0400
Message-Id: <168739587257.247655.6782085819901834666.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613022240.16595-1-luhongfei@vivo.com>
References: <20230613022240.16595-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=330 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220009
X-Proofpoint-ORIG-GUID: rAJWTnGKdS1Dojz7T8c70DAwpKObtzIS
X-Proofpoint-GUID: rAJWTnGKdS1Dojz7T8c70DAwpKObtzIS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 10:22:34 +0800, Lu Hongfei wrote:

> There are three flags that control Write Booster Feature:
> 
>     1. WB ON/OFF
>     2. WB Hibern Flush ON/OFF (implicitly)
>     3. WB Flush ON/OFF (explicit)
> 
> In the case of "Hibern Flush", one of the conditions for flush WB buffer is
> that avail_wb_buff < wb_flush_threshold.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
      https://git.kernel.org/mkp/scsi/c/e3d55626cff3

-- 
Martin K. Petersen	Oracle Linux Engineering
