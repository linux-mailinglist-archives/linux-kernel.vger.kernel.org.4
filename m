Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD746AA033
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCCTjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCCTi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:38:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9822A03
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:38:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5RDhTtNFQ/cj/KNlLr5m3mXPZES1GSpntXh/lxEL6wyBCjm3i2XIy9hLG/Mg2paSwk8Kor8QodOKMdxZ6qd9ZBD4GVavRG1usLSqJa9mWKYgrJEompiyWBBH0dBgN5XaAhUIu8oHLioi4rOC3EM/2ayUHsBrRFhPwx0y98sDToJYRmnBABVlTNISygvFAiKxL/iY/37bwWmHsdad8F4hIX1gZcqdPoy3TZ/DtgWBZ6HLEa4Mq/20FH3k/sUGSR4uIRCyL3MVY7AtcFux9PL66o74u/aPNTfXt3BOqcPiboH6lQ376wCSUMEF2psP4vOjrJjMSLmlrjo5rxhCpL+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB+ErEfGblOPC3aauP0LOAD1zVssVWuLS942zEPekUs=;
 b=DYuiBLbE7dZ5ZCluyF1KXUqoUgvZ/NS5JiJogcSwzKphd8stPtRlzCnyPeFI3d2D4L3p1bznghta60IzGKpUhZUjPomnk8Xi49QMZm8cJiBYlAGaJVX7sRC/GtviIvT3AxIYxiMdQEqOghABelwz8U89NoeArpvFGM5UNgbRIPGWfJCrvaqCQuTOliKUHmq99hojQWjBhMF70lTRT6qHudiI+UrlTTFneK5VSXeAOkoxi//QHjSRCA6botRCMyIa+yBRcaD3jDNXorb/7Hj3zEAn+mGjpfrPqvb5J3jQmqPizhmI6eZXDJ9xSoScR+XTFYQMEfQ+c4EoKlfNn/HXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB+ErEfGblOPC3aauP0LOAD1zVssVWuLS942zEPekUs=;
 b=nKol6K9whI8vA0yeUPf+RDJpMKh0+MdjKPohmffSRz3ucnlnt/JMJ1W4C/+yJ651fa7RCoxGTUC2dfBnHWBjHiIlUtGa3zCnls+HadZYq19Tqhd6UYvRegBxxCPaZaDYdqDm8dlcae4XZQE1U9UEFz5u8Rj6cT1z1qImS/l0+sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 BL0PR0102MB3539.prod.exchangelabs.com (2603:10b6:207:19::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.10; Fri, 3 Mar 2023 19:38:42 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf%4]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 19:38:42 +0000
Date:   Fri, 3 Mar 2023 11:38:40 -0800
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Aristeu Rozanski <aris@redhat.com>, linux-kernel@vger.kernel.org,
        "D. Scott Phillips" <scott@os.amperecomputing.com>
Subject: Re: Error reports at boot time in Ampere Altra machines since
 c733ebb7c
Message-ID: <ZAJMwLMNizPMPzS3@fedora>
References: <20230302201732.pwnhg46mum6st2bv@redhat.com>
 <865ybizqfi.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865ybizqfi.wl-maz@kernel.org>
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|BL0PR0102MB3539:EE_
X-MS-Office365-Filtering-Correlation-Id: e83576fe-bc4f-46fc-4355-08db1c1ee4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGAXgFQfjcdRFifCHLgvZB4t4zwYwa/S60H1RjogNpWut4UmmauCWtP6F0rSJzlkF6EjHvr2RfDkTjdae3ArBozFsZtnC4MYUw5lF+XU/5sDVWVJO4K5lO13X4/wW3QpfgKIhmbeiAbW5/U9JLCGQrVhtMz4PZ9N0lMw65YQYyGvSw+eZQVRiyS24rpKm2VgWeVB5nNjsD78dtCe1atzcZYKJU7Tz3AIerqORUIAGBBVL84be6t/tJO3nnSVVHiUwUFR/7+7q1BrMyqUDctRh86HH+W7ZXrsKlye++K9UOfjQT+WZ1NFTFbRCnDX9GESxWJ/NtPiqXVfENF7y4AOODEI0LWYWjCbmYa9nKJQlAia5nNdwRGz4GL3ggd0H9Yr9s2otuumQBm6cIOPuK0os8/b2GiahGjBF/bKTaWBc2HYUsfHaAHaaIVTC1RYO7qYnZCMq/Isr9/DgLpTPOub9bjkYpcg/iwElK0oVFNFg03jNXA0UT4BYhfIB/a1TOIan9/D3j7UChzUewz9IsSqqMOZT2DezuxWwRtEXxyXE9WztvvwQcZqvlAqSvnUXHFp514gqnSsi8oSDiPhbJbnqFxzZlVO9y8XCKfzG9ojBLMZNrXVEiwIV1TIfio8tYrscL0QAirQTBjDLoDuxlUbsJRDNy3gC8dM/hlbLv6i2UpdiW75J6+JHHP3qrg8oxmawrEwND0dWDomCVcf3APu0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39850400004)(396003)(376002)(136003)(346002)(366004)(451199018)(41300700001)(6916009)(8676002)(4326008)(66476007)(66556008)(83380400001)(54906003)(107886003)(316002)(8936002)(5660300002)(66946007)(6512007)(186003)(9686003)(26005)(478600001)(6486002)(52116002)(6506007)(2906002)(38100700002)(38350700002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DO2NcKRBHv4g16uPwHBdBfFzyLjaLQP/LI//pWcoDkFmJCOMnnEonrYRWOp4?=
 =?us-ascii?Q?N6cva5M2TQ7raTSiF5xXnS0y03oC9IsancYRFcIs6BenVqKRNVOcScLdG3yM?=
 =?us-ascii?Q?Lg0x6H+c1sJzdi+5wpqZoZWHe82BlDyYqnmrydqItTa2hxkGveR8hR79JCy9?=
 =?us-ascii?Q?e7hkE3WvL/E9jC1BYMNTD8lXkMtXOKLi3HYARXgsBHjQOpv06OquH2XvWE+x?=
 =?us-ascii?Q?WYIL/p0629PgrAtJaLCoocfTDc5/UuDs101W9TVTK0oG25A3wJ/MBlghSXk9?=
 =?us-ascii?Q?ivuQXTiEZgWRRrD0tBP2JiOlmtjwhpShv2oMAMhVAzkElmDyb6+NNeIwxMTo?=
 =?us-ascii?Q?pA6owTIje9AsG//HI0/GZP+mL2Co8rFQ7Oc8+7xgKqmWtyJ+vGxFRrLWQDmA?=
 =?us-ascii?Q?ItQGR6GaEP9ugLDRIbvk/AqJUwwos3fwi/U2e8AuJWXzl2C+JlA1iUzUh3Bd?=
 =?us-ascii?Q?jqpO4vOUCbwYO7pckgCHUoJN1/x4dVp55yk4XADKYH3l5nK/gNM/SrHSTWoS?=
 =?us-ascii?Q?aCcJgl1lvSMGhp2ot4ws2dBALXLur7gDsMoAbh3LKe+vPWWimQ2cxZqyxmTx?=
 =?us-ascii?Q?8P+cayGVYRsUvapWOWqpTshtbHC4DIqK+x7LDfiXX1sgsFjS0/KobGoIP6nN?=
 =?us-ascii?Q?hqvSL+PpAcQjxsyxeiyeKh62nIzufeyts87EkBsHP4+LlvRaPfW3NWWLnT9A?=
 =?us-ascii?Q?d8uejl+sMjNZ6Km4CNDp6Y5RS9XeDD6ozNar/jYZb1pRlK7rH54Xgkde/WNZ?=
 =?us-ascii?Q?/TGw2gLMjknvsO644Bz9jgmh+5SqhPbh8iZNVtJkcYOdyVYaTr7onh7fxCzO?=
 =?us-ascii?Q?nWaJRGf8Z3yqZ2xOO2y7pEd9AfCyw0qKUHrG2wdDFwkVIUJx2+zgFpPFQXHH?=
 =?us-ascii?Q?Cay58XrSkSeO4zH1smYT5DotDEUt17FpF84Nu8aMGV7Po884n/Is84wVjsvR?=
 =?us-ascii?Q?cCXEYCdPdME127j/N9WB3dxuM9hj4YDpxzS6cAVaGcw2eTW0QeOfGQIfXqpi?=
 =?us-ascii?Q?suVfAdSE+F/h/57mN9B5ZvIjHnPtVQdLD/+Qju0ljqlQNmEwwlKW7Qr30tOF?=
 =?us-ascii?Q?CsIEa0e+nEP1VxRVNLpQfOzp+Uwx6ip1/kp7iBabTBITKb4XGvVdB8NURMhl?=
 =?us-ascii?Q?WqGFF3otfia0azC09Z/roaJQm7oYcyV3wKe2WOr5XzPuciTvJ3lewAKvm7U6?=
 =?us-ascii?Q?/pg+vXZYuqRWnOZH0WC+7ymuxukagSAZuARZuiUFSLhF3wxcvb3mihg1I3cx?=
 =?us-ascii?Q?S35BS9IoG7AD9I2Be/3T0KJuo0brYMw6Ms97JLrDUrofySLa6/YQen+JklRM?=
 =?us-ascii?Q?Xs5D+uSTM5tkfJVabLjD4aX1CSziJLPuBfqFdxfDxKrmWiuiPuRfKfwar9XB?=
 =?us-ascii?Q?ic1+jUFfdId/DGlBsUvbFyeCtefie6mndtj230iSvO9h4E/7lLpvJg96yNzF?=
 =?us-ascii?Q?EIENfJnevwr7jTijoOyGbfAohi77r4133NFqcZf0DrGyJc6lT78wb1lT0kbN?=
 =?us-ascii?Q?qxm1C4zILwh4Zmav+obwEryfKl4xuDDdGDiP5RNOjYD/5beqpKYYx0g5rCtn?=
 =?us-ascii?Q?4iqUHv2vsTMoO4mEsRtoKDfE5qYbbrsu/f7RjiJ0K1hwlzxSLM+akY64FASv?=
 =?us-ascii?Q?6NmcoP/qZsz1S0M99V5jpug=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83576fe-bc4f-46fc-4355-08db1c1ee4e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 19:38:42.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5oW5MBpzNWVRQkXko6ApZjlk5r5m5mKib5/d5lDducMuqqVBG4qlWkbTU5f0SpPGB1wTwRWFqpD01L0bYLljgV6d9D2A9SgHrTP8upOTxpjcbhCIZWKiweUIXx7TTZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3539
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:25:37PM +0000, Marc Zyngier wrote:
> On Thu, 02 Mar 2023 20:17:32 +0000,
> Aristeu Rozanski <aris@redhat.com> wrote:
> > 
> > Hi Marc,
> > 
> > Since c733ebb7cb67d ("irqchip/gic-v3-its: Reset each ITS's BASERn
> > register before probe"), Ampere Altra machines are reporting corrected
> > errors during boot:
> > 
> > 	[    0.294334] HEST: Table parsing has been initialized.
> > 	[    0.294397] sdei: SDEIv1.0 (0x0) detected in firmware.
> > 	[    0.299622] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
> > 	[    0.299626] {1}[Hardware Error]: event severity: recoverable
> > 	[    0.299629] {1}[Hardware Error]:  Error 0, type: recoverable
> > 	[    0.299633] {1}[Hardware Error]:   section type: unknown, e8ed898d-df16-43cc-8ecc-54f060ef157f
> > 	[    0.299638] {1}[Hardware Error]:   section length: 0x30
> > 	[    0.299645] {1}[Hardware Error]:   00000000: 00000005 ec30000e 00080110 80001001  ......0.........
> > 	[    0.299648] {1}[Hardware Error]:   00000010: 00000300 00000000 00000000 00000000  ................
> > 	[    0.299650] {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > 	[    0.299714] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
> > 	[    0.299716] {2}[Hardware Error]: event severity: recoverable
> > 	[    0.299717] {2}[Hardware Error]:  Error 0, type: recoverable
> > 	[    0.299718] {2}[Hardware Error]:   section type: unknown, e8ed898d-df16-43cc-8ecc-54f060ef157f
> > 	[    0.299720] {2}[Hardware Error]:   section length: 0x30
> > 	[    0.299722] {2}[Hardware Error]:   00000000: 40000005 ec30000e 00080110 80005001  ...@..0......P..
> > 	[    0.299724] {2}[Hardware Error]:   00000010: 00000300 00000000 00000000 00000000  ................
> > 	[    0.299726] {2}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > 	[    0.299912] GHES: APEI firmware first mode is enabled by APEI bit.
> > 
> > Because the errors are being reported later in boot, it's hard to
> > pinpoint exactly what's causing it without decoding the error information,
> > which I currently don't know how to do it.
> 
> + Darren
> 
> Hopefully someone at Ampere can decode this and tell us what is happening.

Hi Marc,

+ D Scott

Thanks for the connection.

This is reporting that something attempted to access GITS2_BASER2, the base
register for the gicv4 vcpu table. Altra doesn't support gicv4. Is c733ebb7c
assuming GITS_BASER2 should be accessible on gicv3?


> 
> > There're no problems other than of course triggering tests because of
> > the warnings.
> 
> It says "Hardware Error". In my book, that's pretty bad. Do you see
> this on more than a single machine?
> 
> > Do you know what's going on here?
> 
> No idea. I haven't seen this on the Altra I have access to so far,
> 
> It could be related to firmware and/or things like power management,
> but again, someone needs to help us with the error report above.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

-- 
Darren Hart
Ampere Computing / OS and Kernel
