Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342B45B36AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIILqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiIILqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:46:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238C12FB84
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMs59QmN1lQ3QwA2DYux0HPVIpQt32ifK7MUGcEIwukSO89d46CtPMeXy0r7+n5QPuSGM4/HxablRjt6YrHIMaaHYi6ymcm24aVjk+XWzhOyQkLVPXb1MQirAdDbOd/fHkLYZkn45JEBPNMwdsQprDL6jvEAUWL623pgPpwet1DLpeQm1fo//9qUpdliJ4mo/C9DifphMYSGR5f0DxabudwTE3VldzEjIYWCu2YtjIs+4WsqitPZGdsA3dTqQ04i6dtWTy4TPJwE9rnpymMTOokPUgyKTsrRJUFdCNISHqntnYU401/SWGR67frm1OTMTeGFNsGhSny/GzLegGR3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0/zs8bEFqOxpXuwsUu3fmp63NbhIpPojvi6jBbP69o=;
 b=T79FfYD4zTVXRYAINLjL2bvA7KZkH9HCt+89Fz/5VzlcbsPKPkoR78t4HWRVl+ROnu0JuKrFEZGKqbZVcOs1tD4RWbxsZyBsCLYHWByZxmI8GazIzLibk2uz8szrn/ZZVXqfjlDBERUrdASX3QrmGgKum5ijkvcaucoKw3ShEJKPE0yPf5MlyAcSSYuD3hput5o1IDYaJSKh3u/wUEXcagwUs1K/txpDMKl0TYG3aCRAQ92T9pVUmN73bjqmOzfX1zvID3Xkp1o0+2ucQR6wDJaLz/X43tiRykdBulr4XhPmjeb3gmglRA2C/tNfXm3uR48GBvVIvV/wzEemj+r2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0/zs8bEFqOxpXuwsUu3fmp63NbhIpPojvi6jBbP69o=;
 b=dPzqS/RDBq1bT4/w81dpbXNXeBNTMzahO0595r+I0Otwbrl1wGUx7IosuAjbwx0oHvgjC6nfCIvL0xy9fAeBXaYMjVZ00cnEW+PLuPwW9BQaP6gQjaKhPX15IoViKUuGCN7Hk2pd7xkaAjGLVTQU/XeZl0fuD6lP4r6Lcqpox0w=
Received: from PH0PR05MB8448.namprd05.prod.outlook.com (2603:10b6:510:cb::13)
 by DS7PR05MB8973.namprd05.prod.outlook.com (2603:10b6:8:87::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Fri, 9 Sep
 2022 11:46:09 +0000
Received: from PH0PR05MB8448.namprd05.prod.outlook.com
 ([fe80::4458:b9c:3671:358e]) by PH0PR05MB8448.namprd05.prod.outlook.com
 ([fe80::4458:b9c:3671:358e%5]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 11:46:09 +0000
From:   Manikandan Jagatheesan <mjagatheesan@vmware.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "bp@suse.de" <bp@suse.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Kodeswaran Kumarasamy <kkumarasamy@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Performance Regression in Linux Kernel 5.19
Thread-Topic: Performance Regression in Linux Kernel 5.19
Thread-Index: AQHYxD76FSnznGGLrEKJhYfY7fdHzA==
Date:   Fri, 9 Sep 2022 11:46:08 +0000
Message-ID: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8448:EE_|DS7PR05MB8973:EE_
x-ms-office365-filtering-correlation-id: 42ceb30f-229f-40e6-84ce-08da9258e300
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZFm7MBopCItVVHpL99vUHOA/clSe61D7yJFgG7GHbe9fr1FhCovN3Vcr9BaNhHrOAw9r8IxOmjHKlopjloPsfN5/h1Vh/BLs5uWbtAYr821t2GzdISl5syM4bl1bqUMiRK9ZdrP1B+FAOq9yC+b+gV2QC0glE0y65nbVl8PrMfzIKpjLozyIjJI2eE7GXgL61yDbrk9b6p2awO+KtauRTg96i5siYu5gUToFDX8vftKKGpZJpJpCPZwQvRDmfy8aE/i2Lh8hAjo36EUf00J1iVtBqUuCwTXz7fSW7qCeE8ZdVVw5L2UhTICnDweo2JIJvNS2XkG6txpBqbv/ERF0C69gJAPL0hC5K/BLZEJIFc4WrvsUnScbLLzDwDKt1MJuyWtqnO+eeygkhnOaRqfRYC7FsKTA+p7ZRjgoDDrCZGNbTIJoJILomXqUZVWYnlsH3qX3bncvSVrg191GTNcpv75krbvXmlYRR3xpDDdvEBSJ0lZYduqzrW7Dcf3z8uqyOH21w1xP8ijx0HkPasii02pWuBmhM+Lfo9F9UC8KoKhH+Nh8uvdc1cwGd2K3hIi1yiJ+eLuDDu/pRNyTeiIO/V1kWQ9BbYFO7rAd+gFp+abJIdUDP7178/TmMM2m8qzFkVYqVtYBi/ot7KBUB1tB8hFoFiL2HtKBx9lmE018JopP+4JClA8GU1Wb5jmf7wLt4NismMA7JUdjOcne93zrJKvetgrbJ6F+2ntAqVDlhlSN0JwSKfcs4tSqdiRQojd/3Sj48/qUzi2hHXXqt+dfr5Vi+cwDXEHD2ST128fh7RxyGu2avA5kwUEg0mIvVDN9W+kSIJ/dcsCgYB0uXqYJb1quA+5mWdBay4ykzuvVkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8448.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(9686003)(76116006)(54906003)(7696005)(186003)(55016003)(83380400001)(41300700001)(71200400001)(478600001)(26005)(110136005)(966005)(6506007)(2906002)(66556008)(38070700005)(91956017)(64756008)(66946007)(33656002)(107886003)(86362001)(66446008)(122000001)(66476007)(316002)(4326008)(38100700002)(52536014)(8676002)(7416002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?H1/fXXGc7/V/PP4yypHo+rHXYlRos1B+65/Lh4UpE/Lua0mvb1k2wECb?=
 =?Windows-1252?Q?lC4g9cImfdh68J8saP77AM9vE8wAeG1GjIU/+kLFtx4PxWy1MYyTC8FC?=
 =?Windows-1252?Q?rg7EBu8QoIeXuXmDeNqCAiwf3WfetWEMlp5VKkyXqjI3j/8PwTnOFiKK?=
 =?Windows-1252?Q?CQfxOnAmVlof3N5aJ1FMRDHTIepDQ/s5a3mvX4etsl38F2vqFgbg8Yz2?=
 =?Windows-1252?Q?6uCEUd3MDe188SsKR8WHoL6oXbhHii4I6IMFSAQQ+tqXgN+9UAmCj+qO?=
 =?Windows-1252?Q?lf8w/RAbIdovS2gtQ/kSeJFxRHTD/735h2etgW+bx3uVvvZCzY7q+BEw?=
 =?Windows-1252?Q?0oG9A3ivWI9147qVuLWq2c6p9E9Kvq0v4/W/uBodNbp0RdE7KWM+v7/R?=
 =?Windows-1252?Q?1eIVbiJAvP/e9TBD5koGfalmi27RTJBZKo75WesSY3YWnm2nn44ognKJ?=
 =?Windows-1252?Q?vq4NOyXp9zW2KUQehLVqJQdwhW2erGEfxkXI4HH6OmyDVRX+ov2+1U3t?=
 =?Windows-1252?Q?vXpaxhobbZHqgvtRupsQZpKOMPyZemukyfRaE1lz4cqYeZsc+jzt8GiN?=
 =?Windows-1252?Q?5Yz4Poib+tSphEFPX5VJVERVHkC9sMqBSAJHbv4CN5X5A8HfdhLX7/b1?=
 =?Windows-1252?Q?sIQ0h7ubv7h3PDqC1MSwc1WekeI2ho8jR/UtXNMF1jZj68ipFMRXBcs4?=
 =?Windows-1252?Q?ccacCcCm3VKUnIS/92ztzGBClpUD4iPGQCc1JafhnTLTek1w9anseZ1T?=
 =?Windows-1252?Q?A2O6tOn9zBQYMeD6WRDqGfSmG2SU+pVROTqOU7X/GO2Ib4rB0bjeE4Ge?=
 =?Windows-1252?Q?rq1F/VsXqd4TWgCr0iC3vibikIyipQmNZ7Zc+m5eLlxNqpUrSrwVNDgV?=
 =?Windows-1252?Q?YPOvd3nlWxsDvtWDc/evTtC5QHPUlblGCoU7Miz5iwOxwb1IZVDYdzWE?=
 =?Windows-1252?Q?eWK1ESveUL0EuMfVFwHGTCQ6OOaoLRdnvqunTqi84FxKXL0Wlk6TsHty?=
 =?Windows-1252?Q?J7++Q3p0WfRXgr3puI0d6lQtzLRBbV3jJ4dLZR2/kQwtMpaOnQfdHMLT?=
 =?Windows-1252?Q?XpxAI5Q+6TXkorJ9FWN+ccxBDWSk/URcFn4oe1A2/izRBe+aYvO9c2xY?=
 =?Windows-1252?Q?CqHyTeFQZilCsDQcQ5GlVoLECj1DF+bn3JCu1v8tM6m1ahxtl9/VLk/V?=
 =?Windows-1252?Q?JQfVrVamn256jFI61YFtaAONcnEtRdbQ07+uM4FRWvTrBdne1YoSAtsC?=
 =?Windows-1252?Q?RgQYzCz4Glpshd4F1sn+Jn2Lv8ddBPNTGGqrnWNYiMo/6nHmoQZfp4Fp?=
 =?Windows-1252?Q?wtu/5wn5TYvf255W6Nl9X3+ChbAqjfhinzUyroZVikgQC2zU7xR7ZvJq?=
 =?Windows-1252?Q?3MrjcBlsAr9KTBx5s1DT3zMc5c10U2bqfbxexsP5j+OTiIJgp3fgC0Je?=
 =?Windows-1252?Q?368m1vPNEus7kusAqGVh6WtRFaVtuDdo/yYF0NyJXlIg4IOY5C3dBPbY?=
 =?Windows-1252?Q?B5GvdzfSmRq0xx2vXxopVMvA1GX6VikNnrbGR/MUXg30OtlJ6PrLkUBf?=
 =?Windows-1252?Q?NSA24b0ceNG1inThBBcdZvhOBe3W7ZSpi51B2ntkCoYh+vISsgpwF4ao?=
 =?Windows-1252?Q?gY3AYuaAqhtDgMyNZASAax8Nn8o5Okh8TgGVDhFjVam5rH4QKWHAHB5G?=
 =?Windows-1252?Q?ErNehlOoTka3lnftCmTojWg2JS/xVycn?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB8973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of VMware's performance regression testing for Linux=0A=
Kernel upstream releases, we have evaluated the performance=0A=
of Linux kernel 5.19 against the 5.18 release and we have =0A=
noticed performance regressions in Linux VMs on ESXi as shown =0A=
below.=0A=
- Compute(up to -70%)=0A=
- Networking(up to -30%)=0A=
- Storage(up to -13%) =0A=
 =0A=
After performing the bisect between kernel 5.18 and 5.19, we =0A=
identified the root cause to be the enablement of IBRS mitigation =0A=
for spectre_v2 vulnerability by commit 6ad0ad2bf8a6 ("x86/bugs: =0A=
Report Intel retbleed vulnerability").=0A=
 =0A=
To confirm this, we have disabled the above security mitigation=0A=
through kernel boot parameter(spectre_v2=3Doff) in 5.19 and re-ran=0A=
our tests & confirmed that the performance was on-par with =0A=
5.18 release. =0A=
 =0A=
Performance data and workload details:=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A=
Used Linux VM on ESXi host: Ubuntu20.04.3=0A=
 =0A=
ESXi Compute workloads:=0A=
----------------------------=0A=
Server configs: 112 threads, 4 sockets Skylake with 2TB memory=0A=
1. Boot-halt test:=0A=
- Configs: Single VM with different CPU and Memory configurations=0A=
                 (1vCPU_32gb, 28vCPU_256gb, 56vCPU_512gb, 84vCPU_1024gb=0A=
                 & 112vCPU_1433gb)=0A=
- Test-desc: Measures the time taken by the Guest to boot up and =0A=
                   shut down itself. We have "shutdown -h now" in =0A=
                   rc.local for Linux. Boothalt time is calculated by =0A=
                   using timestamps of following patterns from vmware.log.=
=0A=
                   * Begin Pattern - " PowerOn"=0A=
                   * End Pattern - "VMX exit"=0A=
- Boothalt time =3D Timestamp(End Pattern) - Timestamp(Begin Pattern)=0A=
- Highly affected case: Lower vCPU config is affected (1vCPU_32gb=0A=
                                    up to -12%)=0A=
- Metric: Secs=0A=
- Performance data:=0A=
      * Immediate before commit: 14.844 secs=0A=
      * Intel retbleed/IBRS commit: 16.29 secs (absolute diff ~2 secs)=0A=
 =0A=
2. Kernel Compile test:=0A=
- Configs: Single VM with different CPU and Memory configurations=0A=
                 (1vCPU_4gb, 28vCPU_64gb, 56vCPU_64gb, 84vCPU_64gb,=0A=
                 112vCPU_64gb & 126vCPU_64gb)=0A=
- Test-desc: A CPU intensive benchmark. Measures time taken to compile =0A=
                   Linux kernel source (4.9.24).=0A=
- Highly affected case: Higher vCPU configs - 112vCPU_64gb (up to -10%)=0A=
- Command: make -j 2x$VCPU. This uses all the available CPU threads to =0A=
                     achieve 100% CPU utilization.=0A=
                     Timestamp is recorded in the vmware.log before and aft=
er =0A=
                     compiling the source.=0A=
                     * Begin Pattern - "VMQARESULT BEGIN"=0A=
                     * End Pattern - "VMQARESULT END"=0A=
- Metric: Secs=0A=
- Performance data:=0A=
      * Immediate before commit: 21.316 secs=0A=
      * Intel retbleed/IBRS commit: 23.824secs (absolute diff ~2 secs)=0A=
 =0A=
3. OSbench test:=0A=
- Configs: Single VM with 1vCPU_4gb config=0A=
- Test-desc: This is a collection of benchmarks that aim to measure =0A=
                   the performance of operating system primitives, such as =
=0A=
                   process and thread creation and it is publicly available=
.=0A=
                   (https://www.bitsnbites.eu/benchmarking-os-primitives)=
=0A=
                   git- https://github.com/mbitsnbites/osbench#readme=0A=
                   To build the benchmarks, we need a C compiler, meson =0A=
                   and ninja.=0A=
- Highly affected case: 1vCPU_4gb (up to -70%)=0A=
- Command: To run - ./create_threads =0A=
- Metric: Milliseconds=0A=
- Performance data:=0A=
   i) create_threads =0A=
      * Immediate before commit: 16.46 msecs=0A=
      * Intel retbleed/IBRS commit: 27.97 msecs (absolute diff ~11 msecs)=
=0A=
   ii) create_processes=0A=
      * Immediate before commit: 69.03 msecs=0A=
      * Intel retbleed/IBRS commit: 83.20 msecs (absolute diff ~14 msecs)=
=0A=
 =0A=
ESXi Networking workloads:=0A=
------------------------------=0A=
- Server config: 56 threads 2 sockets Skylake with 192G memory=0A=
- Benchmark: Netperf 2.7.0=0A=
- Topology: A Linux VM on an ESXi host is connected to a Bare Metal =0A=
                   Linux client using back to back direct connection withou=
t =0A=
                   involving a physical switch.=0A=
- Test-Desc: We measure bulk data transfer and request/response=0A=
                    performance using TCP and UDP protocols.=0A=
- Highly affected case: Single VM on 8vCPU with TCP_STREAM RECV=0A=
                                     Large packets(256K Socket & 16K Messag=
e size) =0A=
                                     up to -30%=0A=
- Netperf command: (TCP_STREAM_RECV large packets)=0A=
netperf -l 60 -H DestinationIP -p port -t TCP_STREAM -- -s 256K =0A=
-S 256K -m 16K -M 16K=0A=
Linux VM on the ESXi host act as RECEIVER and Bare Metal =0A=
Linux host act as SENDER. =0A=
We initiate netperf from Bare Metal Client Linux host and start =0A=
netserver from Linux VM on the ESXi host with 16 parallel netperf =0A=
streams. =0A=
- Metrics: TCP_STREAM(Cpu/Gbits, Gbps), UDP_STREAM(Kilo packets per=0A=
                second), TCP_RR(ResponseTime in microseconds)=0A=
TCP_STREAM_Throughput - Capture Throughput from netperf output file.=0A=
TCP_STREAM_CPU - Capture CPU/Gbits from Total CPU spent in all=0A=
                                 of the threads in given duration divided b=
y =0A=
                                 respective throughput Gbps.=0A=
UDP_STREAM Msgs - Capture from netstats & netperf out files.=0A=
TCP_RR RespTimeMean - Capture output from netperf out file.=0A=
- NIC Model used: Intel(R) Ethernet Controller XL710 for 40GbE QSFP+=0A=
- Performance data:=0A=
      * Immediate before commit: 11.932 Gbps=0A=
      * Intel retbleed/IBRS commit: 8.56 Gbps (~3.5 Gbps of throughput drop=
)=0A=
 =0A=
ESXi Storage workloads:=0A=
--------------------------=0A=
- Server config: 56 threads 2 sockets Skylake with 192G memory=0A=
- Benchmark: FIO v3.20=0A=
- Test-Desc: We measure how much read/write I/O operations can be=0A=
                    performed at a given period of time, average time it=0A=
                    takes to complete the I/O and the total CPU cycles=0A=
                    been spent.=0A=
- I/O  Block size: 4KiB, 64KiB & 256KiB=0A=
- Read write Ratio: 100% read, 100% write & 70/30 mixed readwrite=0A=
- Access Patterns: Random & Sequential=0A=
- # of VMs: Single VM (1VM_8vCPU) & Multi VMs(16VM_4vCPU)=0A=
- Devices under test: Local device and SAN=0A=
- Local device: Local NVMe (Intel Corporation DC P3700 SSD)=0A=
- SAN connected: QLogic QLE2692 FC-16G (connected to DELL EMC=0A=
                             PowerStore 5000T array)=0A=
- Highly affected case: 1VM-cpucost_64K_seq_7030readwrite (up to -13%)=0A=
- Throughput and latency tests are not affected.=0A=
- Command: fio --name=3Dfio-test --ioengine=3Dlibaio --iodepth=3D16 --rw=3D=
rw =0A=
         --rwmixread=3D70 --rwmixwrite=3D30 --bs=3D65536 --thread --direct=
=3D1 =0A=
         --numjobs=3D8 --group_reporting=3D1 --time_based --runtime=3D180 =
=0A=
         --filename=3D/dev/sdb:/dev/sdc:/dev/sdd:/dev/sde:/dev/sdf:=0A=
         /dev/sdg:/dev/sdh:/dev/sdi --significant_figures=3D10=0A=
- Metrics: Throughput (IOPS), Latency (milliseconds) and Cpucost=0A=
                (CPIO - cycles per I/O) t=0A=
                The new CPIO (internal tool) is implemented simply as a =0A=
                python script, that uses a processor=92s performance counte=
rs =0A=
                to arrive at the CPU cycles used in a given duration.=0A=
- Command: python3 /usr/lib/vmware/cpio/cpio.pyc -i 25 -n 5 -D all =0A=
                    -v -d -o outputDir=0A=
                     here, 25 is the interval of collection=0A=
                     5 is the number of intervals=0A=
                     all is the device for which we intend to collect data.=
=0A=
- Topology: A standalone server(ESXi image) with local NVMe disks and=0A=
                   FC-16G HBA is connected to an =93DELL EMC PowerStore 500=
0T=94=0A=
                   array for Storage I/O performance measurements.=0A=
- Performance data:=0A=
     * Immediate before commit: 269928 cycles/io=0A=
      * Intel retbleed/IBRS commit: 303937 cycles/io (absolute =0A=
                                                      diff 34009 cycles/io)=
=0A=
 =0A=
We believe these findings would be useful to the Linux community and=0A=
wanted to document the same.=0A=
=0A=
=0A=
Manikandan Jagatheesan=0A=
Performance Engineering=0A=
VMware, Inc.=0A=
