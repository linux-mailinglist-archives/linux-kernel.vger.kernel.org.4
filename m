Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBA6D0855
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjC3O33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjC3O32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:29:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE59114;
        Thu, 30 Mar 2023 07:29:27 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UDwCuZ001613;
        Thu, 30 Mar 2023 14:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vAJbS5/a+lyQTEOIx+8F7yJCVx2VLOAAsawZaDWelcA=;
 b=iuZUfdh8iJH8/ZVPApZuE2/F24zo9grVV8u9loj9A10vvWDZE3yi44lRzV7ONJ41XKkq
 nuCm3Mzu/QlU1sBB4wA7hg1unFk3RkMzJzTSH5coGg4fQosP8SJNgihJNZxsGVQDruFw
 vbow7e5g/yceDz++xe9dcbyIUJa5jwWV2RorrX93q9wNlQL9YpXY+BmzdI0zU97uIkO4
 9cUrUQjYetxdYk4FFdxbRcMBG6SKVonzn4UHY8zpOEiTh6zDWboBe4jlaRu6SSqiTw/e
 rP8oetJuWfpcRd2klB1C4jgfMLINGcU+JNpg3b2nDWW1m9Jzpn1CucL/glD8ZaK+noB5 Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmp7k31mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 14:29:20 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32UDNfcw004799;
        Thu, 30 Mar 2023 14:29:19 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmp7k31gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 14:29:19 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32UBLh2V030969;
        Thu, 30 Mar 2023 14:29:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3phrk6cw9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 14:29:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32UET6Xv19595644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 14:29:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 500C920049;
        Thu, 30 Mar 2023 14:29:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D90820043;
        Thu, 30 Mar 2023 14:29:06 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.191])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Mar 2023 14:29:06 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1phtGz-002tcJ-2m;
        Thu, 30 Mar 2023 16:29:05 +0200
Date:   Thu, 30 Mar 2023 14:29:05 +0000
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Tom Rix <trix@redhat.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: scsi_transport_fc: remove unused desc_cnt variable
Message-ID: <20230330142905.GC10558@t480-pf1aa2c2.fritz.box>
References: <20230326003222.1343671-1-trix@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230326003222.1343671-1-trix@redhat.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8f0qs-GbdrqlkCN6nQLAHbW_01uxQQtu
X-Proofpoint-GUID: q2DXUZWSd_Er_yRTQIqg94g-xhUzTY19
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300106
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 08:32:22PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/scsi/scsi_transport_fc.c:908:6: error: variable
>   'desc_cnt' set but not used [-Werror,-Wunused-but-set-variable]
>         u32 desc_cnt = 0, bytes_remain;
>             ^
> This variable is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/scsi/scsi_transport_fc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Looks good to me.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
