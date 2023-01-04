Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9383265CD8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjADHVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjADHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:21:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19957E99;
        Tue,  3 Jan 2023 23:20:58 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30453MQO023989;
        Wed, 4 Jan 2023 07:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=rDjGqkVgd6zk9OUmcD2sbF0qmef7zF+caei8zGo4y8w=;
 b=ZlVGfdJGNoiaMCf9rp/bm+kaOZnd3gP4LEZY82Q9V82suM2qNim87OEK0mDeF8QQl8ep
 HdgbwVbZx1Z2wUPVJQIn7mtRD/UOht7Ymwl9pbtk4jY1r3+Q45TavBDetDwVFA7SjlbT
 HfW37B2d8c+7oZTvje8hpJg0kKb0NGeXYivHQ6EnfYnop9BQp3VfF8Zhcr550lsfcXjy
 Yv+cU4aykEoUCePIaHiAoys8uVBT2idEs0rnaRgjj9fdcuJfNG0r6uILXzH6AJKeUIEw
 vnG3YYLYH4v3MnWknTcKllxJzvc45Awy5tFCQ0iiGZ4pc6qTUFKlVpY30LyKS8x4qYAA ew== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvhh51hu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:20:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303Mh0ID003741;
        Wed, 4 Jan 2023 07:20:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfcwak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 07:20:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3047KnEA33751328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 07:20:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C86F92004B;
        Wed,  4 Jan 2023 07:20:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABAA120040;
        Wed,  4 Jan 2023 07:20:49 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jan 2023 07:20:49 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix out-of-bounds access when specifying invalid
 console
References: <20221209112737.3222509-1-svens@linux.ibm.com>
Date:   Wed, 04 Jan 2023 08:20:49 +0100
In-Reply-To: <20221209112737.3222509-1-svens@linux.ibm.com> (Sven Schnelle's
        message of "Fri, 9 Dec 2022 12:27:35 +0100")
Message-ID: <yt9dh6x6n4tq.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UwaY8cH2TmC-LY2GUG3Jfnf0jygc6mif
X-Proofpoint-GUID: UwaY8cH2TmC-LY2GUG3Jfnf0jygc6mif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=458 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> Hi,
>
> these two patches fix a crash in the tty driver when a user specifies an
> invalid console like 'console=tty3000'. The first patch adds a check to
> tty_driver_lookup_tty(), the second one prevents that such a console gets
> registered in the vt driver.
>
> Changes in v2:
> - trim commit message in first patch
> - add second patch as suggested by Jiri Slaby
>
> Sven Schnelle (2):
>   tty: fix out-of-bounds access in tty_driver_lookup_tty()
>   tty/vt: prevent registration of console with invalid number
>
>  drivers/tty/tty_io.c | 8 +++++---
>  drivers/tty/vt/vt.c  | 6 ++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)

Gentle ping... I couldn't find that this was applied anywhere?

Thanks
Sven
