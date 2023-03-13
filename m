Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225EA6B6F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 06:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCMFkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 01:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMFkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 01:40:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6E252B2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 22:40:11 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D41USO028145;
        Mon, 13 Mar 2023 05:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CEMEn5xU/hcip4qcQk+HObQQfXCrf8JlegGfm/tEbjU=;
 b=pdrPPCIJPjWbzKLb3W2d5LlnAtFdTB3Y9z71JYBB4C+SsgzAv3PlW6+F4kpMFTNuiZqW
 4+7FQLdAuMByMSM2dr0yTkJXZfBHGeIWL6qOB403thT1GxnPwlLnRLd09MIx6F88bJBm
 Vukn3iY1e6yUcBqTdebzWEIbmINiu1PqU5+3nkmOnMmkps3SlCuyymvMrAVV2UhZNQ9V
 ep/jDJbtIhXm72rA+WEwfmcfXTCSvtJo9WHFHbogm3P9BdxA7Qf2U50pyD5eP5MR5lTO
 jmdzC6A2vyPCSfrU5h3AV4Hoi4eG0hO2Zg/MAIyiTUX3L0ue1wNTQHoyiYfdIUw3T8+k Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p933kbqsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:39:58 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32D5BlJR006720;
        Mon, 13 Mar 2023 05:39:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p933kbqs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:39:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D28A5e001023;
        Mon, 13 Mar 2023 05:39:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96ju1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 05:39:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32D5dpsg2556634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 05:39:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA20420049;
        Mon, 13 Mar 2023 05:39:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D13F20043;
        Mon, 13 Mar 2023 05:39:49 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.10.87])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Mar 2023 05:39:48 +0000 (GMT)
Date:   Mon, 13 Mar 2023 11:09:46 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Improving calls to kvmppc_hv_entry
Message-ID: <ZA63IhDoObdIKwTj@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230306123740.3648841-1-kconsul@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306123740.3648841-1-kconsul@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7EBhg-JkqRb8WKmJMI97J5hvoBu0oI1J
X-Proofpoint-ORIG-GUID: xL5rn295wxARhyAEdxquoS8bQg_tuk1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=772 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Anyone interested in reviewing this small patch-set ?
I tested it on P8 and it works fine.

Thanks.

On 2023-03-06 07:37:38, Kautuk Consul wrote:
> - remove .global scope of kvmppc_hv_entry
> - remove r4 argument to kvmppc_hv_entry as it is not required
> 
> Changes since v1:
> - replaced .global by SYM_INNER_LABEL for kvmpcc_hv_entry
> 
> Kautuk Consul (2):
>   arch/powerpc/kvm: kvmppc_hv_entry: remove .global scope
>   arch/powerpc/kvm: kvmppc_hv_entry: remove r4 argument
> 
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> -- 
> 2.36.1
> 
