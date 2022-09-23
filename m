Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF55E7F33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiIWP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIWP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:58:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848C11476B3;
        Fri, 23 Sep 2022 08:58:48 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NF2tmR016608;
        Fri, 23 Sep 2022 15:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=FsBCcJas74CxYs/IS4zHTgpISVSDZp2/LeMa0RYqubA=;
 b=bp3bcAFUI0EzWv071v+W4zoL4IUWfhGPWZQT4MwEwjDBYZxFJPEli7M8oR10Mi/nubY6
 +c9tXd86kwaYv329W5iL06iWpnf0hndGZkEnSjPs08qXp6+PmC3SAauudWK47VoJ/maS
 uTb1EhD7t2F5laAIjsa/6f4F+z2P/cmeFcgEvDaeLMNDrc6s0KhF1qUrmxITo8a4zRRY
 pvCJ+NQrGWMv0/iGZcRIJvsGuNiLD4VAWs+tgYFX3Zy2cvG44f4/xdVRt+XyuX+mojCw
 JJGKra0BuThlCYXcdJxq0AJ0dzz0LJy9PvpZTMIl3GeUcerJEwwQeAaivexdemSBh9Ug xg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js8nep5ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:58:36 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28NFqXoA007289;
        Fri, 23 Sep 2022 15:58:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3jn5vajp8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:58:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28NFwYlk4522692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 15:58:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04E2258059;
        Fri, 23 Sep 2022 15:58:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEE2858053;
        Fri, 23 Sep 2022 15:58:33 +0000 (GMT)
Received: from localhost (unknown [9.211.104.104])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 15:58:33 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc/pseries: block untrusted device tree
 changes when locked down
In-Reply-To: <CAHC9VhQG_jEh_H8pV-qJgX2oX_fyGjXoBV7_EJOgvOd4ndc+Xw@mail.gmail.com>
References: <20220922193817.106041-1-nathanl@linux.ibm.com>
 <20220922193817.106041-2-nathanl@linux.ibm.com>
 <CAHC9VhQG_jEh_H8pV-qJgX2oX_fyGjXoBV7_EJOgvOd4ndc+Xw@mail.gmail.com>
Date:   Fri, 23 Sep 2022 10:58:33 -0500
Message-ID: <875yheqdzq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PKz65p7FSPUnU9jDiIkaJSyQ69VbztD8
X-Proofpoint-ORIG-GUID: PKz65p7FSPUnU9jDiIkaJSyQ69VbztD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 7bd0c490703d..1ca8dbacd3cc 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -122,6 +122,7 @@ enum lockdown_reason {
>>         LOCKDOWN_XMON_WR,
>>         LOCKDOWN_BPF_WRITE_USER,
>>         LOCKDOWN_DBG_WRITE_KERNEL,
>> +       LOCKDOWN_DEVICE_TREE,
>
> I would suggest moving LOCKDOWN_DEVICE_TREE to be next to
> LOCKDOWN_ACPI_TABLES.  It's not a hard requirement, but it seems like
> a nice idea to group similar things when we can.
>
>>         LOCKDOWN_INTEGRITY_MAX,
>>         LOCKDOWN_KCORE,
>>         LOCKDOWN_KPROBES,
>> diff --git a/security/security.c b/security/security.c
>> index 4b95de24bc8d..2863fc31eec6 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -60,6 +60,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>>         [LOCKDOWN_XMON_WR] = "xmon write access",
>>         [LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
>>         [LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
>> +       [LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
>
> Might as well move this one too.

Yes, I can do that for v2. Thanks.
