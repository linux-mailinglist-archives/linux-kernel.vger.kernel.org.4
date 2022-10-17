Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7728600FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJQNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:11:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A4EBF7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:11:23 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HCaI3r032261;
        Mon, 17 Oct 2022 13:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : mime-version : content-type; s=pp1;
 bh=wGni4anYGDMFeOWw67B7tVqs5WY+oVOJ3zjzgkfkhjw=;
 b=TbB2uFW0LmTe4WDo9AwHtmxDUSIZg+7ScH/hQz3uc04hS04ParotAVX0TeUKORU44E73
 AP6hmpT9zOXx/rmN5bayOc0+x49dnenhaQKYFSLqUOxQexPJdGhdYkI839hkngXebQDC
 1/UQ4PHsrnmBTZGBc+aMmhcGhKhvZAUfV9IBBVIEgnuPHAXv72haDniKLLmAcfdcpEeB
 aA3XGBbjGKI2xAUMIEY03xUwPSbJ2tnV+BaIb2qciZlt9cRzyA4bVfT08iWkIj0N0PRs
 SK2RLjowFVFbLhoynf2EzjV9UOd9M0pgI/oGOZhNGl4KkND2vYfuvNx7Gi4i6YuigiWw qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86x8hk1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:11:10 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29HCq8in024886;
        Mon, 17 Oct 2022 13:11:09 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86x8hk09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:11:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29HD79I6017474;
        Mon, 17 Oct 2022 13:11:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg930yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:11:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29HDB5NK57213398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 13:11:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A11011C04C;
        Mon, 17 Oct 2022 13:11:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE96C11C04A;
        Mon, 17 Oct 2022 13:10:55 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com (unknown [9.43.101.162])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Oct 2022 13:10:55 +0000 (GMT)
Date:   Mon, 17 Oct 2022 18:40:49 +0530
From:   Vishal Chourasia <vishalc@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, srikar@linux.vnet.ibm.com,
        sshegde@linux.ibm.com, vishalc@linux.vnet.ibm.com
Subject: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
Reply-To: vishalc@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JhDjz6quxxsziCVW"
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6BmKeQSKoH_1QcJ_PAWEsosIxgckrlTM
X-Proofpoint-GUID: 0o3f-kB6TjZN_4PxUsnSwTzqikMiuRtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_09,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JhDjz6quxxsziCVW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

smt=3Doff operation on system with 1920 CPUs is taking approx 59 mins on v5=
=2E14
versus 29 mins on v5.11 measured using:
# time ppc64_cpu --smt=3Doff

Doing a git bisect between kernel v5.11 and v5.14 pointed to the commit
3b87f136f8fc ("sched,debug: Convert sysctl sched_domains to debugfs"). This
commit moves sched_domain information that was originally exported using sy=
sctl
to debugfs.

Reverting the said commit, gives us the expected good result.

Previously sched domain information was exported at procfs(sysctl):
/proc/sys/kernel/sched_domain/ but now it gets exported at debugfs
:/sys/kernel/debug/sched/domains/=20

We also observe regression in kernel v6.0-rc4, which vanishes after reverti=
ng
the commit 3b87f136f8fc

# Output of `time ppc64_cpu --smt=3Doff` on different kernel versions
|-------------------------------------+------------+----------+----------|
| kernel version                      | real       | user     | sys      |
|-------------------------------------+------------+----------+----------|
| v5.11                               | 29m22.007s | 0m0.001s | 0m6.444s |
| v5.14                               | 58m15.719s | 0m0.037s | 0m7.482s |
| v6.0-rc4                            | 59m30.318s | 0m0.055s | 0m7.681s |
| v6.0-rc4 with 3b87f136f8fc reverted | 32m20.486s | 0m0.029s | 0m7.361s |
|-------------------------------------+------------+----------+----------|

Machine with 1920 cpus was used for the above experiments.  Output of lscpu=
 is
added below.

# lscpu=20
Architecture: ppc64le
Byte Order: Little Endian
CPU(s): 1920
On-line CPU(s) list: 0-1919
Model name: POWER10 (architected), altivec supported
Model: 2.0 (pvr 0080 0200)
Thread(s) per core: 8
Core(s) per socket: 14
Socket(s): 17
Physical sockets: 15
Physical chips: 1
Physical cores/chip: 16

Through our experiments we have found that even when offlining 1 cpu, funct=
ions
responsible for exporting sched_domain information took more time in case of
debugfs relative to sysctl.

Experiments using trace-cmd function-graph plugin have shown execution time=
 for
certain methods common in both the scenarios (procfs and debugfs) differ
drastically.=20

Below table list the execution time for some of the symbols for sysctl(proc=
fs)
and debugfs case.=20

|--------------------------------+----------------+--------------|
| method                         | sysctl         | debugfs      |
|--------------------------------+----------------+--------------|
| unregister_sysctl_table        |   0.020050 s   | NA           |
| build_sched_domains            |   3.090563 s   | 3.119130 s   |
| register_sched_domain_sysctl   |   0.065487 s   | NA           |
| update_sched_domain_debugfs    |   NA           | 2.791232 s   |
| partition_sched_domains_locked |   3.195958 s   | 5.933254 s   |
|--------------------------------+----------------+--------------|

Note: partition_sched_domains_locked internally calls build_sched_domains
      and calls other functions respective to what's being currently used to
      export information i.e. sysctl or debugfs

Above numbers are quoted from the case where we tried offlining 1 cpu in sy=
stem
with 1920 online cpus.

=46rom the above table, register_sched_domain_sysctl and
unregister_sysctl_table_collectively took ~0.085 secs, whereas
update_sched_domain_debugfs took ~2.79 secs.=20

Root cause:

The observed regression stems from the way these two pseudo-filesystems han=
dle
creation and deletion of files and directories internally. =20

update_sched_domain_debugfs builds and exports sched_domains information to=
 the
userspace. It begins with removing/tearing down the per-cpu directories pre=
sent
in /sys/kernel/debug/sched/domains/ one by one for each possible cpu. And t=
hen
recreate per-cpu per-domain files and directories one by one for each possi=
ble
cpus.

Excerpt from the trace-cmd output for the debugfs case
=2E..
             |  update_sched_domain_debugfs() {
+ 14.526 us  |    debugfs_lookup();
# 1092.64 us |    debugfs_remove();
+ 48.408 us  |    debugfs_create_dir();      -   creates per-cpu    dir
  9.038 us   |    debugfs_create_dir();      -   creates per-domain dir
  9.638 us   |    debugfs_create_ulong();   -+
  7.762 us   |    debugfs_create_ulong();    |
  7.776 us   |    debugfs_create_u64();      |
  7.502 us   |    debugfs_create_u32();      |__ creates per-domain files
  7.646 us   |    debugfs_create_u32();      |
  7.702 us   |    debugfs_create_u32();      |
  6.974 us   |    debugfs_create_str();      |
  7.628 us   |    debugfs_create_file();    -+
=2E..                                          -   repeat other domains and=
 cpus

As a first step, We used debugfs_remove_recursive to remove entries for eac=
h cpu
in one go instead of calling debugfs_remove per cpu. But, We did not see any
improvement whatsoever.  =20

We understand debugfs doesn't concern itself with performance, and that smt=
=3Doff
operation won't be invoked much often, statistically speaking. But, We shou=
ld
understand that as the CPUs in a system will scale debugfs becomes a massive
performance bottleneck that shouldn't be ignored.

Even in a system with 240 CPUs system, update_sched_domain_debugfs is 1600 =
times
slower than register_sched_domain_sysctl when building sched_domain directo=
ry
for 240 CPUs only.

# For 240 CPU system
|------------------------------+---------------|
| method                       | time taken    |
|------------------------------+---------------|
| update_sched_domain_debugfs  | 236550.996 us |
| register_sched_domain_sysctl | 13907.940 us  |
|------------------------------+---------------|

Any ideas on how to improve here from the community is much appreciated.

Meanwhile, We will keep posting our progress updates.

-- vishal.c
--JhDjz6quxxsziCVW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyetz6oh8pzQ87ZNz8y5vG2Pik+wFAmNNVEwACgkQ8y5vG2Pi
k+wgQQf/cmDlk5vKomX3Pk5hnhZt3qyNyJ+0aTWRtxYZGHc7V05tpBiOObOq8T0k
fIV175/eN7SSxFWPBYiUceQYrhl3mAYVZwQwZYaZVm1RZvQqvrdga40saE2bfBfJ
8Tqw2knMUnLKi49ce+DlrYxA2c1dnyU7mARy3Ppx9F1nO/Tr0h6WHBHbCeh4Djv0
nm/vZS1tdNeCZU8e6IoJNV0NP12wLBhXIrLSyKkIBch7cdlIXhHgMBG5cnIWiEt3
rTwsP2AMm4o7U6h0N4Pa8V0D7FEfVdaKuRixQ4S+EiSdabEzFDLv4LNETEGTn+SR
DPznQqk5eN/+lLgjKXm+PNqamjRPdg==
=Naoj
-----END PGP SIGNATURE-----

--JhDjz6quxxsziCVW--

