Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6F749567
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjGFGMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjGFGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:12:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAFA1BF1;
        Wed,  5 Jul 2023 23:12:01 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3665qOFB014118;
        Thu, 6 Jul 2023 06:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=pp1; bh=8s3LiBVJk2TeWKpIorMcxcgmK6XqXRlBqUwLpsB4f8c=;
 b=dql3W9GzgktG5QhSFa1etX8kQzp+zvpLBAgXpIql7u8B8KAqJtH4YtgHBUzOI8Dj5ILs
 DYcBX+qRUa+yuYuOZYmg5y3/gg98q8v8B4oSE+tWvoeLpRD/H4RhdRKWL5PUKBtRi52n
 CPSMRD+oXEW6kwNeL7e4MyqkdYShifv/58kYZIG+glLT1o1VOb3kkCGV4R2CYTidI3TL
 9YuckCfGxOndqtVYDAOat7OpCzSphVMupcdcTEtRPbHrJJfWaqiJLuytahoRttLgO4qO
 blmRRNisqvvaPHV98xRMMRKySiJos1ud7m7pz1/vCBA8aGRb8HblZ1XD4RmhLt4SC8tb dQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnqudgj03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 06:11:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3665eYCX004705;
        Thu, 6 Jul 2023 06:11:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4tagh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 06:11:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3666Bo8j61866354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jul 2023 06:11:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95B802004B;
        Thu,  6 Jul 2023 06:11:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B6E20040;
        Thu,  6 Jul 2023 06:11:49 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.67.187])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jul 2023 06:11:49 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: [next-20230705] kernel BUG mm/memcontrol.c:3715! (ltp/madvise06)
Message-Id: <7DF50AC5-83AC-4EE1-9422-62D1EA378EE9@linux.ibm.com>
Date:   Thu, 6 Jul 2023 11:41:38 +0530
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mhocko@suse.com
X-Mailer: Apple Mail (2.3731.600.7)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ne3jsF4ogbyrGwafi5T6z_TcMbW-0b4x
X-Proofpoint-ORIG-GUID: Ne3jsF4ogbyrGwafi5T6z_TcMbW-0b4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP tests (madvise06) on IBM Power9 LPAR booted with
6.4.0-next-20230705 following crash is seen

Injecting memory failure for pfn 0x3f79 at process virtual address =
0x7fff9b740000
Memory failure: 0x3f79: recovery action for clean LRU page: Recovered
madvise06 (133636): drop_caches: 3
------------[ cut here ]------------
kernel BUG at mm/memcontrol.c:3715!
Oops: Exception in kernel mode, sig: 5 [#1]
LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D8192 NUMA pSeries
Modules linked in: brd overlay exfat vfat fat xfs loop sctp =
ip6_udp_tunnel udp_tunnel dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 =
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct =
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bonding =
ip_set tls rfkill nf_tables libcrc32c nfnetlink sunrpc pseries_rng =
vmx_crypto ext4 mbcache jbd2 sd_mod t10_pi crc64_rocksoft crc64 sg =
ibmvscsi scsi_transport_srp ibmveth fuse [last unloaded: init_module(O)]
CPU: 10 PID: 133636 Comm: madvise06 Tainted: G O 6.4.0-next-20230705 #1
Hardware name: IBM,8375-42A POWER9 (raw) 0x4e0202 0xf000005 =
of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
NIP: c00000000054ea88 LR: c00000000028b2a8 CTR: c00000000054e8d0
REGS: c00000029dd7b890 TRAP: 0700 Tainted: G O (6.4.0-next-20230705)
MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE> CR: 28008288 XER: 00000000
CFAR: c00000000054e904 IRQMASK: 0=20
GPR00: c00000000028b2a8 c00000029dd7bb30 c000000001431600 =
c0000002bc978000=20
GPR04: c000000002b3b288 0000000000010192 0000000000000000 =
0000000000000001=20
GPR08: c0000000f9abb180 0000000000020000 c0000002bc978580 =
0000000000000000=20
GPR12: c00000000054e8d0 c00000001ec53f00 0000000000000000 =
0000000000000000=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
GPR20: c00000001b2e6578 0000000000400cc0 000000007fff0000 =
fffffffffffff000=20
GPR24: c00000029dd7bd30 0000000000000000 c00000029dd7bd58 =
c00000001b2e6568=20
GPR28: c00000029dd7bde0 0000000000000001 0000000000000001 =
c00000001b2e6540=20
NIP [c00000000054ea88] mem_cgroup_read_u64+0x1b8/0x1d0
LR [c00000000028b2a8] cgroup_seqfile_show+0xb8/0x160
Call Trace:
[c00000029dd7bb50] [c00000000028b2a8] cgroup_seqfile_show+0xb8/0x160
[c00000029dd7bbc0] [c000000000673ba4] kernfs_seq_show+0x44/0x60
[c00000029dd7bbe0] [c0000000005c4238] seq_read_iter+0x238/0x620
[c00000029dd7bcb0] [c000000000675064] kernfs_fop_read_iter+0x1d4/0x2c0
[c00000029dd7bd00] [c00000000057fbac] vfs_read+0x26c/0x350
[c00000029dd7bdc0] [c00000000058077c] ksys_read+0x7c/0x140
[c00000029dd7be10] [c000000000036900] system_call_exception+0x140/0x350
[c00000029dd7be50] [c00000000000d6a0] system_call_common+0x160/0x2e4
--- interrupt: c00 at 0x7fff9eb41484
NIP: 00007fff9eb41484 LR: 0000000010008540 CTR: 0000000000000000
REGS: c00000029dd7be80 TRAP: 0c00 Tainted: G O (6.4.0-next-20230705)
MSR: 800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> CR: 28002282 =
XER: 00000000
IRQMASK: 0=20
GPR00: 0000000000000003 00007fffc33de7d0 00007fff9ec27300 =
0000000000000013=20
GPR04: 00007fffc33e0aa0 0000000000001fff 0000000000000000 =
0000000000000013=20
GPR08: 00007fffc33e0aa0 0000000000000000 0000000000000000 =
0000000000000000=20
GPR12: 0000000000000000 00007fff9ecca3a0 0000000000000000 =
0000000000000000=20
GPR16: ffffffffffffffff 0000000010035520 0000000010035b90 =
00000000100347a8=20
GPR20: 000000001002fb68 0000000010063900 0000000000002000 =
000000001002fb68=20
GPR24: 0000000000000000 000000000000004c 000000001002fa78 =
00007fffc33e0aa0=20
GPR28: 0000000000000013 0000000000000000 0000000000001fff =
0000000000001fff=20
NIP [00007fff9eb41484] 0x7fff9eb41484
LR [0000000010008540] 0x10008540
--- interrupt: c00
Code: 7fa34800 409effc4 7c0802a6 38600001 f8010030 4bfffdfd e8010030 =
786383e4 7c0803a6 4bffff6c 7c0802a6 f8010030 <0fe00000> 7c0802a6 =
f8010030 0fe00000=20
---[ end trace 0000000000000000 ]---
pstore: backend (nvram) writing error (-1)

Kernel panic - not syncing: Fatal exception
Rebooting in 10 seconds..

Git bisect points to following patch:

commit 29bf1eb7d2abbdfc24c4ef7acf7a51b72dc43d2b
    memcg: drop kmem.limit_in_bytes

Does the testcase madvise06 need an update?

90         tst_res(TINFO, "\tCached: %ld Kb",
91                 SAFE_READ_MEMINFO("Cached:") - init_cached);
92      =20
93         print_cgmem("memory.current");
94         print_cgmem("memory.swap.current");
95         print_cgmem("memory.kmem.usage_in_bytes=E2=80=9D);  <<=3D=3D =
this line.=20
96 }

If I comment line 95 from the testcase, it completes successfully.

- Sachin

