Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D066AC440
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCFPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCFPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:00:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E842FCF1;
        Mon,  6 Mar 2023 07:00:41 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326E6Tac005397;
        Mon, 6 Mar 2023 15:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Q+ADkhKV8TCAE3cRbBl6R2j2QCeaIunY9V+mUsTM86k=;
 b=IQWnVK6rWw7wNS8LcAROI/2MMVcuveKKtYJNtZVYAcJT3YDjPws2kdoE9UYv7+ssZX4T
 Zez2p7h6YzFRWDJll59V3RaYjsuXPcGVdRVXCGLciLwZztDdwWsb8esBZTGamt9Uneqt
 dL/efOSNHKyvCWAO2/F1h/w6D04GSLsATMT0xFs+QXf3ThzI6AvNtSDtgqa0126jeMBg
 pIU2IbWK7a+zKiK8AKsviZr7eCRruFbQumwjltcYXjUfflpQZnpJYMQrKZDgA6POyXNO
 ACPmPBtBi2lDVgafC1eflAKikabwMmBCYMqlRgvybrcbeZuoQ+b5wmHFe+3WHm6dO2n5 /g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50n46bgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:00:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326BPUoq006237;
        Mon, 6 Mar 2023 15:00:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p418ctv5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:00:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326F0CqS32244210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 15:00:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E47720049;
        Mon,  6 Mar 2023 15:00:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 066AE2004B;
        Mon,  6 Mar 2023 15:00:12 +0000 (GMT)
Received: from [9.152.212.247] (unknown [9.152.212.247])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 15:00:11 +0000 (GMT)
Message-ID: <f9649d501bc8c3444769418f6c26263555d9d3be.camel@linux.ibm.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (2)
From:   Julian Ruess <julianr@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        jack@suse.cz, yukuai3@huawei.com, hch@lst.de,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Date:   Mon, 06 Mar 2023 16:00:11 +0100
In-Reply-To: <87lekfne28.fsf@oc8242746057.ibm.com>
References: <87lekfne28.fsf@oc8242746057.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KvpZrPuQACqJDcHSPKSqMGA98-cpb2g0
X-Proofpoint-GUID: KvpZrPuQACqJDcHSPKSqMGA98-cpb2g0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-02 at 20:33 +0100, Alexander Egorenkov wrote:
>=20
> Hi,
>=20
> we are seeing a similar problem on s390x architecture when
> partitioning
> a NVMe disk on linux-next.
>=20
>=20
> =C2=A0 [=C2=A0=C2=A0 70.403015]=C2=A0 nvme0n1: p1
> =C2=A0 [=C2=A0=C2=A0 70.403197] ------------[ cut here ]------------
> =C2=A0 [=C2=A0=C2=A0 70.403199] WARNING: CPU: 8 PID: 2452 at block/bdev.c=
:845
> blkdev_put+0x280/0x298

...

> The problem appeared about a week ago.
>=20
> Regards
> Alex

Hi all,

I bisected this to:

commit e5cfefa97bccf956ea0bb6464c1f6c84fd7a8d9f=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Author: Yu Kuai <yukuai3@huawei.com>=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Date:   Fri Feb 17 10:22:00 2023 +0800=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
    block: fix scan partition for exclusively open device again=20=20=20=20=
=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
    As explained in commit 36369f46e917 ("block: Do not reread
partition table=20=20=20=20=20=20=20=20
    on exclusively open device"), reread partition on the device that
is=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    exclusively opened by someone else is problematic.=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
    This patch will make sure partition scan will only be proceed if
current=20=20=20=20=20=20=20=20=20=20
    thread open the device exclusively, or the device is not opened=20=20=20
    exclusively, and in the later case, other scanners and exclusive
openers=20=20=20=20=20=20=20=20=20=20
    will be blocked temporarily until partition scan is done.=20=20=20=20=
=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
    Fixes: 10c70d95c0f2 ("block: remove the bd_openers checks in
blk_drop_partitions")
    Cc: <stable@vger.kernel.org>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    Suggested-by: Jan Kara <jack@suse.cz>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    Signed-off-by: Yu Kuai <yukuai3@huawei.com>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    Reviewed-by: Christoph Hellwig <hch@lst.de>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    Link:
https://lore.kernel.org/r/20230217022200.3092987-3-yukuai1@huaweicloud.com
=20
    Signed-off-by: Jens Axboe <axboe@kernel.dk>=20=20=20



Regards
Julian

--=20
Julian Ruess
Linux on IBM Z Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen,
Vorsitzender des Aufsichtsrats: Gregor Pillen, Gesch=C3=A4ftsf=C3=BChrung: =
David
Faller
Sitz der Gesellschaft: B=C3=B6blingen, Registergericht: Amtsgericht
Stuttgart, HRB 243294
IBM Data Privacy Statement - https://www.ibm.com/privacy


