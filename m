Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1F69EEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBVGw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBVGwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:52:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2095.outbound.protection.outlook.com [40.92.18.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C35360A9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:52:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZqStlG+G/fewvqiD96bCXKrMSLXVxv07VViYWlS10FO9rOGE9fucLg5cahaPOBYiut0oPYr4yc5hVg17inZ5QH1D1OhNS+izD8w2UK5Czpzajcyt/uKjj2brdJaOPcIUxWrFOsWkMQnSVz/zQ4L6eL8NMw73J8cADddbsBLT9+IpQizmCpffiXYOhSg5m4IqWTotAYUSr5P5RYUttefRhv2LxfU1af3iU7Yb+U1QoXwDaXZejMgTfiqJGax9zTw2EScKUE74Ounooh8AOL7YwKHR61JMspuiTQmEPH5OnMQdxwU11jZlz/LWXWoKjMKcHuzYj8FaQO+7p4RBs7R9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKiSS1g2bCeRqQUXb79PfSb3Muys02BwGigTQbwVEA0=;
 b=gDZm6O0Xcgy0wi5EucomWxi58mDf2d96nIVN2DoLrF1YKtsr5gC6sM1E2E9yk9Ph02SpezweTjTPCqE+gvoSSRzIPP8SABuVFEzKVORnX5axAkPz8D4bYHDKClO3EHMUX6G/5oXH3Z6pHr7GRVi28oQZnuAuXuOwWYXcczfgq37/Pzb3QHmR3qysEbHZseEhG3Gi3OqQsa+2PWld64JaRtBgQggUSCXUBLgcT/PaQC3CGJDSYjb7NDXtXumaMHZhgSjOT/Rs1m0Sd/6U+ckBeBzPp1wXGE/uxZ/a2MJqcrPgofSxKHzLWV9Lho+veImO2EAbvcWVIYMx5pLa/pRq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKiSS1g2bCeRqQUXb79PfSb3Muys02BwGigTQbwVEA0=;
 b=AUKGnhWkjW4ndjDhXpJdO4DuE7jTlU7mT5QQ0YNQxa3NkeRltIW4qAG+SYI85V4/QAW31N+jwjAk1JYmVP9L8t7FqFGxLEbLcEa1guFXREp4RHEEw2kZVpI2FMIa2a67Pv0b3P5LN4Wr1DO+QCBLgwcQ59vyJRhqBlftFSE4prIrB+LK9xvqhanxzq25aoYECXkA9qHoh89YPvdz7qD3l62K3vzKDHTSFk0/TZyI9tpQO1jc5SXIWpkVKuMBusCtZrs7I4xyPH3I1+VD2wn+O1FFvNy9KpvHS3hftaYFo4MAT8tg8PH1+C81poyAKs6xY2aNqjVf/Oz84pH5/hFlow==
Received: from BY5PR19MB3333.namprd19.prod.outlook.com (2603:10b6:a03:188::23)
 by SN7PR19MB6784.namprd19.prod.outlook.com (2603:10b6:806:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 22 Feb
 2023 06:52:20 +0000
Received: from BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::636:8c3f:3c95:5f69]) by BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::636:8c3f:3c95:5f69%4]) with mapi id 15.20.6086.024; Wed, 22 Feb 2023
 06:52:20 +0000
From:   "katiyar26@outlook.com" <katiyar26@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Mellanox interrupts are not load balanced
Thread-Topic: Mellanox interrupts are not load balanced
Thread-Index: AQHZMjMkUEeiz2tn4ECAxfc0bz4HOq62b/ZKgAABt+CAAAVmY4AkOGMh
Date:   Wed, 22 Feb 2023 06:52:20 +0000
Message-ID: <BY5PR19MB3333B097E28CBCFBEEE22A16A5AA9@BY5PR19MB3333.namprd19.prod.outlook.com>
References: <BY5PR19MB3333BC15B1D33E89A679D7A7A5CC9@BY5PR19MB3333.namprd19.prod.outlook.com>
 <BY5PR19MB333326E6CB47FA6946DAF7DDA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
 <BY5PR19MB333337F4EF2491D440453F74A5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
 <BY5PR19MB333362AF364F23C398DC351BA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB333362AF364F23C398DC351BA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [1IBINLNndNa4APvVxGxzG3SLZ84M/WKo]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3333:EE_|SN7PR19MB6784:EE_
x-ms-office365-filtering-correlation-id: a6575c0c-e7c6-40f5-379a-08db14a1580d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Soc7BGe2wMypnKfvbsqH1BPr/ig502mJlqRjvJ93UePpv+fvGAdsy9ybotAm+eybs3NCG4eB6jnaL8KesywieD4vQAUPAtzhY6QdhiI8zb+stgZ7ODtDF1I0Qfhc7qs23Mg2gZDc/U1dxweLVY36tXCLd7/cCBcWlzxCIgReXs0mzLkqKXmU6mECxcdbPeHIjHtw8Gx4dIbKohToE9AP9IPHRhT//4qdSsnXmqDM2bA8fyQX69Lw+kXf+Y3hYlySaoRTVoL4lzMaDIRrHZtXUquGih1wFdsZXjrHPckBaSIF+yV0Sf+Xn0nEfO5hcxLq/8S9wM9m2AacqCVRg2o0QS0UPlpeBH8oWn1vAuujKiIpurF1xbahx298xJHrtgSUfOPRKEPLJmuDT+4IZUXX1gcewVVEDrj7XNrFf0ZIePyZ9yRPTMUOWlTLgNwSvYjsbbv5OaHQ4k0l063sVLNkV0EFKy3IGjDtdQG/rkzBmrUQopLidB/16a86nplaetMIfSmpD2QuRJinHi2XhV//gnqDhb+BmC8BwgCjBYR6SzlaVA8F3XEfSK4s3PXVGhjDEGf4ttwPZrM3MqbVOdE5yXWPl2IMGJnhMIbyQvb9xgPZVtzGgZ+S76MWzDfBsCR+5YFF4l/L5YzUZALtEot74Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CyZA59Gkfld7YaieOL+kx7D9gqQnIOB2W6gNtXSPg3s+HIpylieZrK3Rv5?=
 =?iso-8859-1?Q?eoslaa72wOUn81ALHryd2deVOxlrGXClomgpHx8J5Iw4NyEOTJ4ZGU3n27?=
 =?iso-8859-1?Q?c+GuLgqm8YgNLVP2zwg0EXUAOwHJ7sIhRQW+A9wqd38wuC1rD0o3OUFP7g?=
 =?iso-8859-1?Q?HgVnklSSyMkWSo4U1VLNKXdnwix3+3ExKA7lnINjl2kyr/upgNEB+Uyw/f?=
 =?iso-8859-1?Q?k6Ur3b9fk3tfYdsOn1T2XrPIJnBdbxhdHRd60LAH//j+YiE+JU92Ng4GiI?=
 =?iso-8859-1?Q?fafy2qIgyWZBYcUJLxrTaP+t22G1hyhWCSIfURqCAoJUWl5hltizseGFht?=
 =?iso-8859-1?Q?3yIL55ljl65PjSZplxl0Mld1EBqi5TpRJ8SHxSfSLe31g5PvHbKG8XRDX9?=
 =?iso-8859-1?Q?sjLGRNzbgeZCWqQHvmOmWLPaintrljqOfUtX4K4ArkAF2RFO/va8uB2iOL?=
 =?iso-8859-1?Q?F54D5xb51FG6hLnGUmN/Dcc8VtM3eZTy+uTiwEncEI/0MuhgRf0f018e0y?=
 =?iso-8859-1?Q?Lunu7IOv9Fvjw7q/EDJL+URtMqdMx5hjTByB6Be7Dsl/hB5nX8GQqa9SJ9?=
 =?iso-8859-1?Q?A2+OqjhofLvd5WWfNwpfqM/lZAmwJvlsTSuo/23H0RLNEfdYto8ZO0mqVx?=
 =?iso-8859-1?Q?6YaGUBSbXWnI1i+zWFNKFvjietFcKnBlI43f2IOvuEgKkUTCC9HWNntYkq?=
 =?iso-8859-1?Q?xhxrH2JlVBNelHdG5CPwBbZppFg+NdDhp26Y0LnSpXPVXJeE8gAhOCzvdK?=
 =?iso-8859-1?Q?FhGyzV5p0O1BhLNga53MfCB8XuvQgxVGOP1HavgPEAZRRlgMiQSJTHc3o2?=
 =?iso-8859-1?Q?aQXWgAcgpwmjtfO/sXuo8RDmrdrnIqtvyhK/DV8591xFN3dlUOgD0JiDSz?=
 =?iso-8859-1?Q?h5mIhjCl/X+JOsMq4XRdESTHN52nMciFYAjh6+2oyLpKPMX04ObyxWo0zm?=
 =?iso-8859-1?Q?VsTOnuskuN2uNqlyaG8SZhtQAS44mfVhsQFftP1TJXJw6RjvGghv73NoZB?=
 =?iso-8859-1?Q?XYYh/ZttGI3CeYuFTc2dLXG/NIuiZDoLY9ea19EmzqoaLwg+8FpVAoVT+G?=
 =?iso-8859-1?Q?V0OlBuq9ps0WCVO6foE895diTMSU1EppaiLMpqonLbI8gKbTD5CvhGSebA?=
 =?iso-8859-1?Q?Haw+0B41HmSJ8kqgVLPgJ5JoeDvqOpNT3tZw2RcVpV3ODme2Mb98yiWvol?=
 =?iso-8859-1?Q?PLzwF89RXbkZGbhQBZAiUktLFg6q2oonda+Fl9eHTa/v1UMWYbTzjFvJCF?=
 =?iso-8859-1?Q?LxHXhjeDTj39CwbHn2BHth81IZLah5Fa7yCk4/IoOtkHUEtsvhbB1VqY4T?=
 =?iso-8859-1?Q?4EWI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3333.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a6575c0c-e7c6-40f5-379a-08db14a1580d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 06:52:20.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6784
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
Any suggestions/comments on this issue.=0A=
=0A=
regards,=0A=
Nitin=0A=
=0A=
=0A=
From: katiyar26@outlook.com <katiyar26@outlook.com>=0A=
Sent: Monday, January 30, 2023 11:14 AM=0A=
To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject: Mellanox interrupts are not load balanced =0A=
=A0=0A=
Hi,=0A=
I am running centos 7.7 VM in azure with Mellanox (mlx5_core) driver for NI=
C. It is running customized 3.10.0-1062.18.1.el7 kernel image with some min=
or changes in net directory. =0A=
=0A=
It has created as many queues and irqs as the number of CPUs in VM but all =
the interrupts are being processed by CPU0 only. Irqbalance service is also=
 running and smp_affinity is set differently for different irqs. I tried se=
tting it manually after stopping the irqbalance service but still all the i=
nterrupts were targeted to CPU0 as can be seen from below output.=0A=
=0A=
> cat /proc/interrupts =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0=A0=A0=A0=A0=A0=A0 CPU1=A0=A0=A0=A0=A0=
=A0 CPU2=A0=A0=A0=A0=A0=A0 CPU3=A0=A0=A0=A0=A0=A0 CPU4=A0=A0=A0=A0=A0=A0 CP=
U5=A0=A0=A0=A0=A0=A0 CPU6=A0=A0=A0=A0=A0=A0 CPU7=A0=A0=A0=A0=A0=A0 =0A=
=A0 0:=A0=A0=A0=A0=A0=A0 9881=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 timer=0A=
=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 9=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 i8042=0A=
=A0 3:=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0=A0=A0=A0=A0=A0=A0 25=A0=A0=A0=A0=A0=
=A0=A0=A0 13=A0=A0=A0=A0=A0=A0=A0=A0 19=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0 8=
56=A0=A0 IO-APIC-edge=A0=A0=A0 =0A=
=A0 4:=A0=A0=A0=A0=A0=A0=A0=A0 68=A0=A0=A0=A0=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=
=A0=A0=A0=A0 25=A0=A0=A0=A0=A0=A0=A0=A0 22=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0=
=A0=A0=A0=A0=A0=A0 10=A0=A0=A0=A0=A0=A0=A0=A0 19=A0=A0=A0=A0=A0=A0=A0 360=
=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 serial=0A=
=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 rtc0=0A=
=A0 9:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-fasteoi=A0=A0 acpi=0A=
12:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 5=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 i8042=0A=
14:=A0=A0=A0=A0=A0=A0=A0 602=A0=A0=A0=A0=A0=A0=A0 318=A0=A0=A0=A0=A0=A0=A0 =
226=A0=A0=A0=A0=A0=A0=A0 232=A0=A0=A0=A0=A0=A0=A0 278=A0=A0=A0=A0=A0=A0=A0 =
205=A0=A0=A0=A0=A0=A0=A0=A0 69=A0=A0=A0=A0=A0=A0 8917=A0=A0 IO-APIC-edge=A0=
=A0=A0=A0=A0 ata_piix=0A=
15:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 ata_piix=0A=
24:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_pages_eq@pci:8b76:00:=
02.0=0A=
25:=A0=A0=A0=A0=A0 19694=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_cmd_eq@pci:8b76:00:02.0=0A=
26:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_async_eq@pci:8b76:00:=
02.0=0A=
28:=A0=A0=A0=A0 123648=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp0@pci:8b76:00:02.0=0A=
29:=A0=A0=A0=A0 152455=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp1@pci:8b76:00:02.0=0A=
30:=A0=A0=A0=A0 102308=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp2@pci:8b76:00:02.0=0A=
31:=A0=A0=A0=A0=A0 89403=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp3@pci:8b76:00:02.0=0A=
32:=A0=A0=A0=A0=A0 86793=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp4@pci:8b76:00:02.0=0A=
33:=A0=A0=A0=A0 107817=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp5@pci:8b76:00:02.0=0A=
34:=A0=A0=A0=A0 117091=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp6@pci:8b76:00:02.0=0A=
35:=A0=A0=A0=A0=A0 59714=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp7@pci:8b76:00:02.0=0A=
36:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_pages_eq@pci:83a4:00:=
02.0=0A=
37:=A0=A0=A0=A0=A0 12427=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_cmd_eq@pci:83a4:00:02.0=0A=
38:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_async_eq@pci:83a4:00:=
02.0=0A=
40:=A0=A0=A0=A0=A0 35520=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp0@pci:83a4:00:02.0=0A=
41:=A0=A0=A0=A0=A0=A0=A0 576=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp1@pci:83a4:00:02.0=0A=
42:=A0=A0=A0=A0=A0 34139=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp2@pci:83a4:00:02.0=0A=
43:=A0=A0=A0=A0=A0 19951=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp3@pci:83a4:00:02.0=0A=
44:=A0=A0=A0=A0=A0 41038=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp4@pci:83a4:00:02.0=0A=
45:=A0=A0=A0=A0=A0 36569=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp5@pci:83a4:00:02.0=0A=
46:=A0=A0=A0=A0=A0 42023=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp6@pci:83a4:00:02.0=0A=
47:=A0=A0=A0=A0=A0 12610=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp7@pci:83a4:00:02.0=0A=
NMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Non-maskable interrupts=0A=
LOC:=A0=A0=A0=A0=A0=A0 1536=A0=A0=A0=A0=A0=A0 1224=A0=A0=A0=A0=A0=A0 1240=
=A0=A0=A0=A0=A0=A0 1107=A0=A0=A0=A0=A0=A0 1299=A0=A0=A0=A0=A0=A0 1379=A0=A0=
=A0=A0=A0=A0 1171=A0=A0=A0=A0=A0=A0 2152=A0=A0 Local timer interrupts=0A=
SPU:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Spurious interrupts=0A=
PMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Performance monitoring interrupts=0A=
IWI:=A0=A0=A0=A0=A0=A0=A0 726=A0=A0=A0=A0=A0=A0=A0 143=A0=A0=A0=A0=A0=A0=A0=
 776=A0=A0=A0=A0=A0=A0=A0 309=A0=A0=A0=A0=A0=A0=A0 780=A0=A0=A0=A0=A0=A0=A0=
 370=A0=A0=A0=A0=A0=A0=A0 748=A0=A0=A0=A0=A0=A0 1047=A0=A0 IRQ work interru=
pts=0A=
RTR:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 APIC ICR read retries=0A=
RES:=A0=A0=A0=A0=A0 59746=A0=A0=A0=A0=A0 34162=A0=A0=A0=A0 150579=A0=A0=A0=
=A0=A0 45146=A0=A0=A0=A0 149421=A0=A0=A0=A0=A0 87954=A0=A0=A0=A0 149095=A0=
=A0=A0=A0=A0 47137=A0=A0 Rescheduling interrupts=0A=
CAL:=A0=A0=A0=A0=A0=A0 2562=A0=A0=A0=A0=A0=A0 2717=A0=A0=A0=A0=A0=A0 2601=
=A0=A0=A0=A0=A0=A0 2590=A0=A0=A0=A0=A0=A0 2577=A0=A0=A0=A0=A0=A0 2649=A0=A0=
=A0=A0=A0=A0 2572=A0=A0=A0=A0=A0=A0 2557=A0=A0 Function call interrupts=0A=
=0A=
Mellanox driver version is :=0A=
version:=A0=A0=A0=A0=A0=A0=A0 5.0-0=0A=
license:=A0=A0=A0=A0=A0=A0=A0 Dual BSD/GPL=0A=
description:=A0=A0=A0 Mellanox 5th generation network adapters (ConnectX se=
ries) core driver=0A=
author:=A0=A0=A0=A0=A0=A0=A0=A0 Eli Cohen <eli@mellanox.com>=0A=
rhelversion:=A0=A0=A0 7.7=0A=
srcversion:=A0=A0=A0=A0 7D9FFD656B0EB1000804CB2=0A=
=0A=
Same kernel with different NIC driver (in AWS) and igb driver in physical s=
erver works fine.=0A=
I tried centos7.9 (3.10.0-1160.76.1.el7) available in Azure market place an=
d there I don't see the issue.=0A=
=0A=
Please help in debugging/resolving this issue.=0A=
=0A=
Please CC to katiyar26@outlook.com while replying.=0A=
=0A=
regards,=0A=
Nitin=
