Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C86E5D32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDRJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjDRJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:18:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8A59E8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:18:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66e7a52d3so10410095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681809534; x=1684401534;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrBel9VmErqN2OPaaHAV0utOVb/mmRc6SBAQB70vwno=;
        b=Bdl7FFc9A5g7PJmtM2hdvmr5f4fiKgHBy987wROvEbdZRh5hbM3EIQNKZEfRktBTNF
         fzSZYmeKmdXqH0Hl2TaISkKXAaC9/MVbtlTVfYlcF4eFURDUyZOvxEM1VMv+RzQ6TToU
         DC0KH2wAoplzJk7IF6Km5HkLi28uNlr0TLkyGM7VPXAcKQIxqygRx07Lh/fg74Dj6opN
         NmbO4ELDxgCqsdRyRvy+XIo0UtaxvUco16iAYgtat/tBRs6sxMh2l5XCBiQ09gHzCVVt
         iVSh3X1PydAQcNp9DB5uBdPcPWjcwkvG/As8ETso9AByTKan8sAR/EK0/iJjR+HSvL+c
         IYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809534; x=1684401534;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrBel9VmErqN2OPaaHAV0utOVb/mmRc6SBAQB70vwno=;
        b=CvjH6szfcZ7Me2Pq5ogb4aavWL77YpgCM6Iys9DXK3y4yLyplEaTxZo4sIDDYp7oYY
         zc8ma0RmoA9dQCSZ7Q/9Qaan/+TkrsKTi89s06pmvs8TihbBghb3igYS/G0jQwgP7Bkr
         SoP/MHw9KbYgxLJ/bvsj9Pq5sFlRnhOm8K8HMdHiU2ZWmrALs8jtMYJ+8Z2hwo/TxCaM
         exmm4x38/MxRK59enwSPjFFRuxGYyiR6RXx69KV1CWEipoOdP5SNmMP7c99zuY3fDxag
         pmBpei/OABQyGTOE2nZ15SQN7tahx0vpgVOxGkY3wPxKCLhkoZhjyhPcnBVu5VasUVN5
         kVeQ==
X-Gm-Message-State: AAQBX9f3jeIGCt3vaT9DqEyF12ewlrUTxPzBAxfAZEpt9cJD2QGbzYSk
        MAuo8mftdat1i2zm+fiGBQ85GA==
X-Google-Smtp-Source: AKy350b9IUUSKcJnOOJStiK+r1dMMfusxcH9aPrmASSRMh3rsBU7aAByAEn6T24WPQa9uAbCWnD8TA==
X-Received: by 2002:a17:903:2cc:b0:1a6:b52a:b00b with SMTP id s12-20020a17090302cc00b001a6b52ab00bmr1674666plk.29.1681809534392;
        Tue, 18 Apr 2023 02:18:54 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a4fecf79e4sm9122546plr.49.2023.04.18.02.18.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2023 02:18:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
Date:   Tue, 18 Apr 2023 17:20:51 +0800
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDB3D138-7AB5-4166-9167-134784AF90D5@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8818=E6=97=A5 =E4=B8=8A=E5=8D=8811:58=EF=BC=8CChait=
anya Kulkarni <chaitanyak@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>> - It is not backed by performance improvements, but more importantly
>> does not cover any potential regressions in key metrics (bw/iops/lat)
>> or lack there of.
>>=20
>=20
> I've already asked for this, without seeing performance numbers
> and any regression for general usecase it is hard to justify this.
>=20
> -ck
>=20
>=20
>=20

Hi ck & sagi,

There are more io pattern results.

# ENV
[root@Node81 vhost]# uname -a
Linux Node81 5.10.0-136.28.0.104.oe2203sp1.aarch64 #1 SMP Thu Apr 13 =
10:50:10 CST 2023 aarch64 aarch64 aarch64 GNU/Linux

[root@Node81 vhost]# lscpu
Architecture:           aarch64
  CPU op-mode(s):       64-bit
  Byte Order:           Little Endian
CPU(s):                 96
  On-line CPU(s) list:  0-95
Vendor ID:              HiSilicon
  BIOS Vendor ID:       HiSilicon
  Model name:           Kunpeng-920
    BIOS Model name:    HUAWEI Kunpeng 920 5251K
    Model:              0
    Thread(s) per core: 1
    Core(s) per socket: 48
    Socket(s):          2
    Stepping:           0x1
    Frequency boost:    disabled
    CPU max MHz:        2600.0000
    CPU min MHz:        200.0000
    BogoMIPS:           200.00
    Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 =
atomics fphp asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp asimdfhm
Caches (sum of all):
  L1d:                  6 MiB (96 instances)
  L1i:                  6 MiB (96 instances)
  L2:                   48 MiB (96 instances)
  L3:                   96 MiB (4 instances)
NUMA:
  NUMA node(s):         4
  NUMA node0 CPU(s):    0-23
  NUMA node1 CPU(s):    24-47
  NUMA node2 CPU(s):    48-71
  NUMA node3 CPU(s):    72-95
Vulnerabilities:
  Itlb multihit:        Not affected
  L1tf:                 Not affected
  Mds:                  Not affected
  Meltdown:             Not affected
  Mmio stale data:      Not affected
  Retbleed:             Not affected
  Spec store bypass:    Not affected
  Spectre v1:           Mitigation; __user pointer sanitization
  Spectre v2:           Not affected
  Srbds:                Not affected
  Tsx async abort:      Not affected

[root@Node81 host3]# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 =
23
node 0 size: 0 MB
node 0 free: 0 MB
node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 =
44 45 46 47
node 1 size: 31619 MB
node 1 free: 30598 MB
node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 =
68 69 70 71
node 2 size: 0 MB
node 2 free: 0 MB
node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 =
92 93 94 95
node 3 size: 31219 MB
node 3 free: 29854 MB
node distances:
node   0   1   2   3
  0:  10  12  20  22
  1:  12  10  22  24
  2:  20  22  10  12
  3:  22  24  12  10

[root@Node81 vhost]# lshw -short -c network
H/W path          Device         Class          Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
/0/106/0          enp129s0f0np0  network        MT27800 Family =
[ConnectX-5]
/0/106/0.1        enp129s0f1np1  network        MT27800 Family =
[ConnectX-5]
[root@Node81 vhost]# lspci | grep MT
81:00.0 Ethernet controller: Mellanox Technologies MT27800 Family =
[ConnectX-5]
81:00.1 Ethernet controller: Mellanox Technologies MT27800 Family =
[ConnectX-5]

[root@Node81 vhost]# ethtool -i enp129s0f0np0
driver: mlx5_core
version: 5.0-0
firmware-version: 16.35.2000 (MT_0000000425)
expansion-rom-version:
bus-info: 0000:81:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

[root@Node81 vhost]# lspci -s 81:00.0 -vv
81:00.0 Ethernet controller: Mellanox Technologies MT27800 Family =
[ConnectX-5]
	Subsystem: Mellanox Technologies Device 0121
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 27
	NUMA node: 2
	Region 0: Memory at 280002000000 (64-bit, prefetchable) =
[size=3D32M]
	Expansion ROM at b0200000 [disabled] [size=3D1M]
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s =
unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ =
SlotPowerLimit 25W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ =
FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ =
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM not =
supported
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 128 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8
			TrErr- Train- SlotClk+ DLActive- BWMgmt- =
ABWMgmt-
		DevCap2: Completion Timeout: Range ABC, TimeoutDis+ =
NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, =
ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, =
EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- =
LTR- 10BitTagReq- OBFF Disabled,
			 AtomicOpsCtl: ReqEn+
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- =
Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- =
SpeedDis-
			 Transmit Margin: Normal Operating Range, =
EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB =
de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, =
EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ =
LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [48] Vital Product Data
		Product Name: CX512A - ConnectX-5 SFP28
		Read-only fields:
			[PN] Part number: MCX512A-ACUT
			[EC] Engineering changes: B7
			[V2] Vendor specific: MCX512A-ACUT
			[SN] Serial number: MT2211K02268
			[V3] Vendor specific: =
fe87176f019fec1180001070fd62e0e0
			[VA] Vendor specific: =
MLX:MODL=3DCX512A:MN=3DMLNX:CSKU=3DV2:UUID=3DV3:PCI=3DV0
			[V0] Vendor specific: PCIeGen3 x8
			[RV] Reserved: checksum good, 0 byte(s) reserved
		End
	Capabilities: [9c] MSI-X: Enable+ Count=3D64 Masked-
		Vector table: BAR=3D0 offset=3D00002000
		PBA: BAR=3D0 offset=3D00003000
	Capabilities: [c0] Vendor Specific Information: Len=3D18 <?>
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA =
PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 =
PME-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- =
AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- =
AdvNonFatalErr+
		AERCap:	First Error Pointer: 08, ECRCGenCap+ ECRCGenEn- =
ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- =
HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [150 v1] Alternative Routing-ID Interpretation =
(ARI)
		ARICap:	MFVC- ACS-, Next Function: 1
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration- 10BitTagReq- Interrupt Message =
Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+ =
10BitTagReq-
		IOVSta:	Migration-
		Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function =
Dependency Link: 00
		VF offset: 2, stride: 1, Device ID: 1018
		Supported Page Size: 000007ff, System Page Size: =
00000001
		Region 0: Memory at 0000280004800000 (64-bit, =
prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [230 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- =
UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- =
UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: mlx5_core
	Kernel modules: mlx5_core


# Before patch:
   2293 root       0 -20       0      0      0 R  68.6   0.0   0:23.85 =
kworker/0:1H+nvme_tcp_wq
  12504 root      20   0  476960  26280  20140 S  41.3   0.0   0:03.38 =
fio

pattern                        | bandwidth(MiB/s)     | iops       | =
latency(us)
:-                                 | -:                               | =
-:           | -:
4k-randread-q128-j1            | 308                  | 79086      | =
1617.33
256k-randread-q128-j1          | 1072                 | 4288       | =
29822.7
4k-randwrite-q128-j1           | 327                  | 83782      | =
1526.77
256k-randwrite-q128-j1         | 1807                 | 7228       | =
17700.8

# After patch:

[root@Node81 host3]# cat =
/sys/module/nvme_tcp/parameters/cpu_affinity_list
66-68

   1862 root       0 -20       0      0      0 R  56.6   0.0   0:59.37 =
kworker/66:1H+nvme_tcp_wq
  12348 root      20   0  476960  25892  19804 S  45.4   0.0   0:02.00 =
fio

pattern                        | bandwidth(MiB/s)     | iops       | =
latency(us)
:-                                 | -:                               | =
-:         | -:
4k-randread-q128-j1            | 451                  | 115530     | =
1107.1
256k-randread-q128-j1          | 1410                 | 5641       | =
22671.7
4k-randwrite-q128-j1           | 432                  | 110738     | =
1155.12
256k-randwrite-q128-j1         | 1818                 | 7274       | =
17591.4

4k-randread-q128-j1 means 4k randread, iodepth =3D 128, jobs =3D 1.

All nvme-tcp io queue is 1.

Fio binds to numa node 2 cpu 69-70 like this:
taskset -c 69-70 fio --ioengine=3Dlibaio --numjobs=3D1 =E2=80=A6...




