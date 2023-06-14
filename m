Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E573031E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbjFNPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbjFNPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:13:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7221FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:13:19 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EFBoDZ003837;
        Wed, 14 Jun 2023 15:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=Mz2KQR85MA3ivsjUGKFXVR0RQZqiN2ptLegdweRusYU=;
 b=ab1eNIDJKCN8qVhW5/RUvD0BKSr+Z3LdD7tuRoS6Rse6mGke3UpvcrWoXwuSeM0r223O
 /uNrrPinSNvAmJYD+tt/sWftjyuohH/OIf2ZwtXcgOQ5njawqm1QwsQCZ9+Myls0VN/T
 o4GW2ct9qJON8Xor8sRtfG82cDgM2xhBdBMU88NKzZqXJxErupbNwQKuSw7t+wBNidaD
 JqF4x46BMQED9ELZ+0tdaH+T6CI2YdzyFom18gvNx8zCKKAIgaeWZ+oslizfEk4QJ9X9
 2HWYn5oPTq1dAzgY1oyOvN/O1wJr6GjD2krT4UgGZ7SaeaduyGQhjq7ZSuH5Y1sQ2b7E XA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7fpv8fdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:13:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35DNn0Zt004159;
        Wed, 14 Jun 2023 15:12:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt52y7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:12:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EFCs0D40567308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 15:12:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 626E52004B;
        Wed, 14 Jun 2023 15:12:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A957020043;
        Wed, 14 Jun 2023 15:12:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.50.25])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jun 2023 15:12:53 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: [6.4-rc6] Crash during a kexec operation (tpm_amd_is_rng_defective)
Message-Id: <99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com>
Date:   Wed, 14 Jun 2023 20:42:42 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, jarkko@kernel.org
To:     open list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WVqw1At0AqErYVQS9WEpJXOqsE6dqKwa
X-Proofpoint-GUID: WVqw1At0AqErYVQS9WEpJXOqsE6dqKwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=905
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following crash is observed during a kexec operation on=20
IBM Power10 server:

[ 34.381548] Kernel attempted to read user page (50) - exploit attempt? =
(uid: 0)
[ 34.381562] BUG: Kernel NULL pointer dereference on read at 0x00000050
[ 34.381565] Faulting instruction address: 0xc0000000009db1e4
[ 34.381569] Oops: Kernel access of bad area, sig: 11 [#1]
[ 34.381572] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA =
pSeries
[ 34.381576] Modules linked in: dm_mod(E) nft_fib_inet(E) =
nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) =
nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) =
nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) =
nf_defrag_ipv4(E) bonding(E) tls(E) rfkill(E) ip_set(E) sunrpc(E) =
nf_tables(E) nfnetlink(E) pseries_rng(E) aes_gcm_p10_crypto(E) drm(E) =
drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) sr_mod(E) =
t10_pi(E) crc64_rocksoft_generic(E) cdrom(E) crc64_rocksoft(E) crc64(E) =
sg(E) ibmvscsi(E) scsi_transport_srp(E) ibmveth(E) vmx_crypto(E) fuse(E)
[ 34.381613] CPU: 18 PID: 5918 Comm: kexec Kdump: loaded Tainted: G E =
6.4.0-rc6-00037-gb6dad5178cea #3
[ 34.381618] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 =
0xf000006 of:IBM,FW1030.20 (NH1030_058) hv:phyp pSeries
[ 34.381621] NIP: c0000000009db1e4 LR: c0000000009db928 CTR: =
c0000000009eab60
[ 34.381625] REGS: c00000009742f780 TRAP: 0300 Tainted: G E =
(6.4.0-rc6-00037-gb6dad5178cea)
[ 34.381628] MSR: 800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> CR: =
44488884 XER: 00000001
[ 34.381638] CFAR: c0000000009db19c DAR: 0000000000000050 DSISR: =
40000000 IRQMASK: 0=20
[ 34.381638] GPR00: c0000000009db928 c00000009742fa20 c0000000014a1500 =
c0000000081d0000=20
[ 34.381638] GPR04: c00000000d842c50 c00000000d842c50 0000000000000025 =
fffffffffffe0000=20
[ 34.381638] GPR08: 0000000000000000 0000000000000000 0000000000000009 =
c008000000785280=20
[ 34.381638] GPR12: c0000000009eab60 c00000135fab7f00 0000000000000000 =
0000000000000000=20
[ 34.381638] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[ 34.381638] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[ 34.381638] GPR24: 0000000000000000 0000000000000000 0000000000000000 =
c000000002e21e08=20
[ 34.381638] GPR28: c00000000d842c48 c000000002a02208 c00000000321c0c0 =
c0000000081d0000=20
[ 34.381674] NIP [c0000000009db1e4] tpm_amd_is_rng_defective+0x74/0x240
[ 34.381681] LR [c0000000009db928] tpm_chip_unregister+0x138/0x160
[ 34.381685] Call Trace:
[ 34.381686] [c00000009742faa0] [c0000000009db928] =
tpm_chip_unregister+0x138/0x160
[ 34.381690] [c00000009742fae0] [c0000000009eab94] =
tpm_ibmvtpm_remove+0x34/0x130
[ 34.381695] [c00000009742fb50] [c000000000115738] =
vio_bus_remove+0x58/0xd0
[ 34.381701] [c00000009742fb90] [c000000000a01ecc] =
device_shutdown+0x21c/0x39c
[ 34.381705] [c00000009742fc20] [c0000000001a2684] =
kernel_restart_prepare+0x54/0x70
[ 34.381710] [c00000009742fc40] [c000000000292c48] =
kernel_kexec+0xa8/0x100
[ 34.381714] [c00000009742fcb0] [c0000000001a2cd4] =
__do_sys_reboot+0x214/0x2c0
[ 34.381718] [c00000009742fe10] [c000000000034adc] =
system_call_exception+0x13c/0x340
[ 34.381723] [c00000009742fe50] [c00000000000d05c] =
system_call_vectored_common+0x15c/0x2ec
[ 34.381729] --- interrupt: 3000 at 0x7fff9c5459f0
[ 34.381732] NIP: 00007fff9c5459f0 LR: 0000000000000000 CTR: =
0000000000000000
[ 34.381735] REGS: c00000009742fe80 TRAP: 3000 Tainted: G E =
(6.4.0-rc6-00037-gb6dad5178cea)
[ 34.381738] MSR: 800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> =
CR: 42422884 XER: 00000000
[ 34.381747] IRQMASK: 0=20
[ 34.381747] GPR00: 0000000000000058 00007ffffad83d70 000000012fc47f00 =
fffffffffee1dead=20
[ 34.381747] GPR04: 0000000028121969 0000000045584543 0000000000000000 =
0000000000000003=20
[ 34.381747] GPR08: 0000000000100000 0000000000000000 0000000000000000 =
0000000000000000=20
[ 34.381747] GPR12: 0000000000000000 00007fff9c7bb2c0 000000012fc3f598 =
0000000000000000=20
[ 34.381747] GPR16: ffffffffffffffff 0000000000000000 000000012fc1fcc0 =
0000000000000000=20
[ 34.381747] GPR20: 0000000000008913 0000000000008914 000000014b891020 =
0000000000000003=20
[ 34.381747] GPR24: 0000000000000000 0000000000000001 0000000000000003 =
00007ffffad83ef0=20
[ 34.381747] GPR28: 000000012fc19f10 00007fff9c6419c0 000000014b891080 =
000000014b891040=20
[ 34.381781] NIP [00007fff9c5459f0] 0x7fff9c5459f0
[ 34.381784] LR [0000000000000000] 0x0
[ 34.381786] --- interrupt: 3000
[ 34.381788] Code: 5463063e 408201c8 38210080 4e800020 60000000 60000000 =
60000000 7c0802a6 fbe10078 7c7f1b78 f8010090 e9230728 <e9890050> =
2c2c0000 41820020 7d8903a6=20
[ 34.381800] ---[ end trace 0000000000000000 ]---
[ 34.384090] pstore: backend (nvram) writing error (-1)

Git bisect points to following patch

commit bd8621ca1510e6e802df9855bdc35a04a3cfa932
    tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call =
site

Reverting the commit allows a successful kexec operation.

- Sachin

