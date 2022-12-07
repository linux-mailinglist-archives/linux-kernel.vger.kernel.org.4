Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB96454EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLGHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLGHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:53:11 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF268FAF3;
        Tue,  6 Dec 2022 23:53:06 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B77hhsg003329;
        Wed, 7 Dec 2022 07:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=/7CXYLz3u4HJx/Z7y0XwhGBZo9UmJExy91Xo/NQ3lI0=;
 b=OhwzJkJLjcGcreAZtpqwAZh5pMs6yM5hLUy22lmnsxtFz0aqYMD0q6bAPedXxnersTBg
 0jf0YLwVa3IsJvEhOyxsLs0BlUwRcQrrTAfsyqZ9JUjrbm3kKCDnC7EcA+CFm/yCA4kn
 OsXQQKIJlfFEYZwRaGea87aIxyfrwsRPiITr2cSq8NAdZtcfv7ylG1FDfRWjn5wcwApi
 AMx9cjhcw3PUM6Y7l2xpbdZOXpJNmIlOIpMkxXVjK/y4mZmQkIX5xYKnquHgmCdsV0oP
 VelfUkC7sVrIusfUZOe4Uxs+E2x3TkEpr/uj8x0c9BENSu9LS9Fr7VgShuLZaOAJnHpK VQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mappjr696-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 07:53:02 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B6CwAl5016442;
        Wed, 7 Dec 2022 07:53:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3m9m6y1w7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 07:53:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B77qwrx43450744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2022 07:52:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9728620043;
        Wed,  7 Dec 2022 07:52:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86B0B20040;
        Wed,  7 Dec 2022 07:52:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Dec 2022 07:52:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 3790EE0213; Wed,  7 Dec 2022 08:52:58 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/1] crash in tty layer when specifying invalid console=ttyX
Date:   Wed,  7 Dec 2022 08:52:35 +0100
Message-Id: <20221207075236.23171-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Y3ytL-QKJ2wQbxC-un0u4FAolC0NDCO
X-Proofpoint-ORIG-GUID: 3Y3ytL-QKJ2wQbxC-un0u4FAolC0NDCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 mlxlogscore=749 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212070061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we had a user specifying 'console=tty3270' assuming that this will use the
tty3270 driver from s390 as console device. However, it will try to open
tty number 3270 as tty which is not what the user expected. That alone
isn't really a problem, but the kernel crashes while dereferencing invalid
memory with this option.

I tested this with qemu on x86, and it crashes in the same way. I never
worked in the tty layer, but it looks to me like there's some out-of-bound
checking missing in tty_driver_lookup_tty(). If this fix is wrong or
there's a better place to do that, let me know.

Sven Schnelle (1):
  tty: fix out-of-bounds access in tty_driver_lookup_tty()

 drivers/tty/tty_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.34.1

