Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14C762FDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiKRTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbiKRTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:12:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E412F668
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:12:08 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIIuEfF021023;
        Fri, 18 Nov 2022 19:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=SKrf53yyfwUhvMiXJVyeNJr+UJV2E1bdQY/HAA7o7VA=;
 b=Lu0BdQdwWRf7t1hhDxRwRpAvFWr2OyT7KrvVgGNoNklUmSenMs9jo6t76IU+70NjzFyW
 O4N/es7/kfT8c7FDIejSl4y/53d0xGdKZjxOIFLeY8+m6XYxJeqYmJdZrUzDjIxcsgKC
 yt7KvTtCuqcNfAUqxBRHnjMxcn/xBngIz8stKqYd/HSXVqnaLF3M6lF+wkTneby6B78+
 ulV+SsQbvSd12LVO+a4NKs9AK0/KDLpLG7hkybed2Gj1aKtaS95d2J+s1c+2kRWybFlh
 Q0lHznErP5v42MzCP31RLyUG43IJoDa1CqWtqKooy6tJm5l7plkwZGFmU0CoVdWGRuuk wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kx7kjhm2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:12:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIIKASY002620;
        Fri, 18 Nov 2022 19:12:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kbut4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:12:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIJC5oZ002967;
        Fri, 18 Nov 2022 19:12:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kbut3f-1;
        Fri, 18 Nov 2022 19:12:04 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     anjali.k.kulkarni@oracle.com
Subject: Re: [RFC] Add a new generic system call which has better performance, to get /proc data, than existing mechanisms
Date:   Fri, 18 Nov 2022 11:12:02 -0800
Message-Id: <20221118191202.2357801-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=716 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180114
X-Proofpoint-GUID: fn8a1ddeFmJHqsHXEsciyLvbq-ENq3_T
X-Proofpoint-ORIG-GUID: fn8a1ddeFmJHqsHXEsciyLvbq-ENq3_T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
I was looking up your readfile() system call and this seems something useful to us - is this something expected to go into mainline any time soon?
Thanks
Anjali
