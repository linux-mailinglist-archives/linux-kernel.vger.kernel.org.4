Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D15FD397
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJMDlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMDli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:41:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBD102DC1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:41:37 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D0QQZF027777;
        Thu, 13 Oct 2022 03:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=mgyXLCoiiSx/Yh4HFM+raXZWjsQK3XYcd/JUJpwF8sU=;
 b=LnP/8+BR9uB43LXwgl12S6V8zFnoyrYpC8nR3RTawFz4fumc07FhUeXvHRQFle0H4WXi
 7bhIXyeKYedeMAau4+j66tERPXvX9NFO71WQtGuR1w/s8/A8TochtKCMJ2bg3RHrJ9ly
 BNPt/yWHVx71GmCpRjzFLbi52Raje1qJNrygjKByDj5sE6DemmpGHL8QquK4FFCwqx3o
 nbGxjUexPFO5qxuVs0F1eqfFHAUPvKKtVwncU9WJ2k0iZP1LjsPE+cqTD+BxbRqSj44x
 wNhzf5ltvrO/+7UvhX6LlvOHXVeaq8/oPfwcJFCREdCif1twWnRf2EtQ2ZJvMbjTENxV xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k684jbr43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 03:41:06 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29D3ZgmK024652;
        Thu, 13 Oct 2022 03:41:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k684jbr3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 03:41:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29D3b0hN014224;
        Thu, 13 Oct 2022 03:41:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9ewt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 03:41:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29D3f1OZ7275028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 03:41:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7952A11C04C;
        Thu, 13 Oct 2022 03:41:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB78111C04A;
        Thu, 13 Oct 2022 03:41:00 +0000 (GMT)
Received: from localhost (unknown [9.43.102.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Oct 2022 03:41:00 +0000 (GMT)
Date:   Thu, 13 Oct 2022 09:10:59 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 00/16] objtool: Enable and implement --mcount option on
 powerpc
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     aik@ozlabs.ru, chenzhongjin@huawei.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mbenes@suse.cz, mingo@redhat.com, npiggin@gmail.com,
        peterz@infradead.org, rostedt@goodmis.org,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <20221002104240.1316480-1-sv@linux.ibm.com>
        <1665401892.qmrp2qjj9t.naveen@linux.ibm.com>
        <notmuch-sha1-66fb111b87471c685a53b80a0502d959f90d07a7>
In-Reply-To: <20221013000548.d2m65fozzdvdsj5u@treble>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1665632217.kgyce54pc4.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hjQMm_07R5dNed5iEFJyZDHzQlcXNATv
X-Proofpoint-GUID: MFeyBumg44kJLYJT8szIPsp7HQWhOgXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_02,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=787 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf wrote:
> On Tue, Oct 11, 2022 at 01:20:02PM -0700, Josh Poimboeuf wrote:
>> On Mon, Oct 10, 2022 at 05:19:02PM +0530, Naveen N. Rao wrote:
>> > All the above changes are down to compiler optimizations and shuffling=
 due
>> > to CONFIG_OBJTOOL being enabled and changing annotate_unreachable().
>> >=20
>> > As such, for this series:
>> > Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> > Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> >=20
>> >=20
>> > Josh,
>> > Are you ok if this series is taken in through the powerpc tree?
>>=20
>> Yes, it looks ok to me.  Let me run it through a round of testing.
>=20
> The testing looked good, so:
>=20
>   Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks!

FYI: your previous reply (that you would be testing it) didn't hit my=20
inbox and it doesn't seem to have hit the list either.


- Naveen
