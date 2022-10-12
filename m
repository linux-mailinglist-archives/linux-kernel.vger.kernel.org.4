Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6245FC351
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJLJxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJLJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:53:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AAA9243
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:53:43 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C8v6eo011853;
        Wed, 12 Oct 2022 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=glxJRmcbch9XZrNGMqSkC0NjkzIix0j7J8ANO0eiw4k=;
 b=B9+p9qnSXfPKWiHP+lc+o9ke8+edrs9sdl7KW3aWb8q7DbWUXQPqJPbTLQOvvkVqsDcM
 S2YvkzuWJkyhe9cUnQGrgo0Q3FOuPA244vcERf6qJplL6R7KlP7rBsjTe7kySTkiSoqp
 rn3zssJzNbpN2DIC6KuPQsb8xg9QrwDJdd1wh2ylQ7N+nVk9nsi+eLkz79Nvehr5ig3Y
 SEI1Z8mF6NDVFxAmJxIQN9d50ufXfnpA/2MzToDDkGm1NckHScXuNqMdSU46jCCCANrW
 Z+MgMYNHp6m3RwwOo2mmoOpeZwUXLePZN6zegFvYkJe9oklQYHwbm3AKUkT0hAE3MG7P Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5th81fkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 09:52:58 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29C9ho5M016423;
        Wed, 12 Oct 2022 09:52:57 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5th81fk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 09:52:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29C9onn7004138;
        Wed, 12 Oct 2022 09:52:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3k30u9dsjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 09:52:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29C9m8hl48693742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 09:48:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE67D4C040;
        Wed, 12 Oct 2022 09:52:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42AD94C044;
        Wed, 12 Oct 2022 09:52:53 +0000 (GMT)
Received: from localhost (unknown [9.199.196.199])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Oct 2022 09:52:53 +0000 (GMT)
Date:   Wed, 12 Oct 2022 15:22:51 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kprobes: Fix null pointer reference in
 arch_prepare_kprobe()
To:     jniethe5@gmail.com, Li Huafei <lihuafei1@huawei.com>,
        mpe@ellerman.id.au
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mhiramat@kernel.org,
        npiggin@gmail.com, peterz@infradead.org, rostedt@goodmis.org
References: <20220923093253.177298-1-lihuafei1@huawei.com>
        <1664530538.ke6dp49pwh.naveen@linux.ibm.com>
        <de8e524d-02b3-c2d0-45c3-5cc1e5556660@huawei.com>
In-Reply-To: <de8e524d-02b3-c2d0-45c3-5cc1e5556660@huawei.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1665565982.bae3snm0nx.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i-9rOK29ulhgXMgnGji_u1iwPxOEaoOV
X-Proofpoint-ORIG-GUID: tPLdGK9qbPJVRZkR1oPNfWvGsspHRvsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_04,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Huafei wrote:
>>>
>>> =C2=A0 # echo 'p cmdline_proc_show' > kprobe_events
>>> =C2=A0 # echo 'p cmdline_proc_show+16' >> kprobe_events
>>=20
>> I think we should extend multiple_kprobes selftest to also place
>> contiguous probes to catch such errors.
>>=20
> Yes. But each architecture implementation is different and it looks a
> little difficult to decide which offsets need to be tested.

I don't think we need to be accurate here. A test to simply try putting=20
a probe at every byte within the first 256 bytes of a kernel function=20
should help catch many such issues. Some of those probes will be=20
rejected, but we can ignore errors.


- Naveen
