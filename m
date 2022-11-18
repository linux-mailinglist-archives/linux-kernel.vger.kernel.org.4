Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E384962FDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiKRT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiKRT1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:27:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EB7342D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:27:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIJF0Ce004228;
        Fri, 18 Nov 2022 19:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=WG4VBL4ZuRiv6wC97V5Zl/MsOWxUu0YNOhK28GWBWH498SLxKN3gFN2NTYR5rhYna+pv
 QBiZzhfxrDp9lzTs0z+7PzPNy6r6jrUxHB2KuKVTzOJ4PQDUD6E7LWT7YbBTiFJhyHI4
 AwFREoNkVb9CV6ZrwXQnGYAHtMeNoy6IKsCm4TcRiVMCek5gekAI969DNBtPcYXzNyQr
 wxTGx/KTJTlew/VTYFHWGaMZAaxfzzcA4VRknnstuopD1tgaWWTJk0pIuv/Weo55UrSh
 oB05HNRI16pmLq+uu09FBKIdQu5exTSIsYOB7w3/6/8zICghd1mrpqWXNUS6njaywTGb 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxg1gr0r5-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:27:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIItEbC016333;
        Fri, 18 Nov 2022 19:10:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xaya1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:10:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIJARln003224;
        Fri, 18 Nov 2022 19:10:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xaya0k-1;
        Fri, 18 Nov 2022 19:10:26 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     anjali.k.kulkarni@oracle.com
Subject: Re: [RFC] Add a new generic system call which has better performance, to get /proc data, than existing mechanisms
Date:   Fri, 18 Nov 2022 11:10:24 -0800
Message-Id: <20221118191024.2357643-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: 
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=681 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180114
X-Proofpoint-GUID: rDj78x0QM0e8GE-WkO_MnF65EfP5hkqs
X-Proofpoint-ORIG-GUID: rDj78x0QM0e8GE-WkO_MnF65EfP5hkqs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

