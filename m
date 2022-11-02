Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00098616620
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKBP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKBP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:28:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B01DDF9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djqmXNuHBJ3LhQXZGEoXN/lr3y7n4eWzd4OH8ZnUGJE6GSgjj9xoO5Wc+FQnqtstPqEtrFpEyBB6hc96p/wJpjUScWzsb9zhvqU41V7WOm+CL8vd950A0PspZGM5QNka4n1PwrnBzozgMiJAJI8TP0prOSPNhMHAECjRwIqF+Sl0vA6VYwtHSmZItHnmt4X+ALeCK8RjZhcifBQrEBABZlPG/YGtj1XmwQyKAS1I5vHIz2mPzwXF7M6njfI8tzQRR4SmehT7+wurybVmLf9zJO8l3beE/22TGvqdF8Ib6rvYtpTr7PZLutarphOX5TvRYvM8X0rof+j9mDBUi/QD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tegK65dZbB3Y5mL2eHnljm4Wlj6aB4PBC/8FJKZeXQ=;
 b=FTvP9yylAAwGa8mAwqQmgzHNMtAizZX0B7s1VBQMunDhlP7+Q7CYNAnh1JZdT8jqxWtetrlUveUKOXslodMVM7Jl6/j6YBYZehpsPwIlhDrTthg5xw7CpKPEihFViX/wf9Qe0rzGGrnD3KgnOaC+yJjJpxh8Xgno8MaKn8K32FwgD/sMIWAf7XUgXeiHVrdMgYioIafPjAntqg8vCpjVFtjmF2sqLvgtYF3xcMGty/gkXHXZc6P6vAJDLFf4hAc8q7R0H0aAmPXON3TywHtTgnv14Yd0kULkqpJm1l0x3ocukbU4wgjAOot6kKnGF5/D7HGAc4POH+8sBaMpeQyL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tegK65dZbB3Y5mL2eHnljm4Wlj6aB4PBC/8FJKZeXQ=;
 b=EYlvpF+d9zz2I9Mu3RvpHgk8GJzAam39WwUyG8+c08rzHimxJG4xBZSCBtDXvHwj3nEVSqIsb5NJo705kkZ4DYj6L8GdYIcXFFBthnWrd53FDkLX/OkH2qtYgin6Zaw5xthdR9yVWv0g6jHG4cLLX93e2uSsfvMrQTZ6ZjAOQZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY8PR10MB6874.namprd10.prod.outlook.com
 (2603:10b6:930:85::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 2 Nov
 2022 15:28:38 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::a8ed:4de9:679e:9d36]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::a8ed:4de9:679e:9d36%4]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 15:28:38 +0000
Date:   Wed, 2 Nov 2022 08:28:25 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Roger Quadros <rogerq@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Pratyush Yadav <p.yadav@ti.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: Barebox / Kernel Omap ECC inconsistency?
Message-ID: <Y2KMmVUOxspp+1Xu@COLIN-DESKTOP1.localdomain>
References: <Y2FvB5D0K4MBii8N@COLIN-DESKTOP1.localdomain>
 <ec160658-e251-bfdc-05ac-631bd4c716dc@kernel.org>
 <20221102141400.31125365@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102141400.31125365@xps-13>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CY8PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c8eea7-43d3-47c2-7822-08dabce6e95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDbSPJ/PYIZvfT1uz9OFY3scMP33Ezd5UQSSEXSQsusDiQp6hFsYYCkc7gnYCE+8/0WnfuzP/jDdFSE65YNlvzwscYW3nz+FzxcvelMRADZ0fonmT/DPzACFDpzCo64R45RIyRtIHLOQVkCJGQsm8pkzwm5lxBTX/TMUTbOLpIneeqSfN4jZMBV/ezUeL102IxopvtPfGNhF3+CTy+p6TmyirJVYfdc9G2ob1bojYIPLejjjEMWcsafgmRIl24bCoIN2ZgW6vAMfwjoaEd21schTCRuQL7TSdUQMHHAqkmTzLew9dftSLnowZRV8dM6ZIFjUXfIb7DnWogvUIL/ioJTnazJynz0lkRjqfNDmMjw+N/x4u3zQl3yRi0SuuW6WhufitvyYg+lZ3HG4Z7A35DzQfs89c4KeLwcvUOyMu0gneLHVieB+hz1jHuKdCrNsHDTzeS5IxLVZ0xDE9q5CZ0qY0XVLpnw6MpqcqGGDuqJJNA8ykm4rOHOfz4DKDOhPFrxluUIxIkdQtxp8aCItqXmS3Kb0YN1EoUIA1UbHvNn2MKWO8xvx9gD9StU+x7I6ujIj84BCWf3MsrW/1iU0MeLyqE/jPbQVpa9v1TbkpdD/+70Sc5LE49p/VkRgYZ4zVBcCVbgSB5m3PqW6xn63gCtEzVZnnbfIUhlvk9XF6PpF9E7KLSRRY3uW/JjhcviJIsSQEMB3XLGZMhHCKXFaOofYUxVijqMTv9Mgbk4wrHHFaHBcFbv/Y8Pg68ieFcHyI/BBO20cC0D2Pqto7kngZjliki1rf6XRcZ5RjucWHhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39830400003)(136003)(346002)(366004)(451199015)(966005)(6666004)(478600001)(66946007)(8676002)(53546011)(6916009)(316002)(66556008)(54906003)(86362001)(66476007)(6506007)(9686003)(66574015)(4326008)(41300700001)(26005)(8936002)(6512007)(83380400001)(186003)(2906002)(6486002)(5660300002)(44832011)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGMyNnJEdFJ1bTB0ZUExakdqd0g5cnpNSnFtR1lBV0g4WGtXdG01QTIyRFNq?=
 =?utf-8?B?L0VxNVp0NXgyTHZMejRNUWRna3pCeTI2QlIza2E3RExyY2hES29KS0dqdVNq?=
 =?utf-8?B?SXVWYmN4b2VLSFgrOVJuNnRMRGRYNDBtNkxMSlJhdkQzTWd4eDE2RVdJeG1O?=
 =?utf-8?B?anp1S1FYR3FjWWc5NGk0YjlCVzAvTHdsVTJ0UFFYUDRRWi9mVzZLUmtQWTl4?=
 =?utf-8?B?U3ZycytGbmdSM2ZUTjh5YkpYc25SL3hxWXNtaVRIK2N6OXl0d3pZZFZyVmdH?=
 =?utf-8?B?Z3hFSStNSmw1RERtVG92Q08zTjdYK00raW5QYkpHa0IySFJhK294N2ZzNXVx?=
 =?utf-8?B?cHN3T2VGVmU4blQ1TTNDanlKb0k5RTUxcGFBK2RqczQ0VnNYZFV1WUhVanlH?=
 =?utf-8?B?ZTBJbmNaRVY3aDhFT1lkVWgvL3VaMFpBcnZQbEwyOVhJS0hGLzFWVUtYelRB?=
 =?utf-8?B?eXBWQktFcWZLblBHU2dhYkRJUkMvZWhHT2FTWVp6djBxS0QvVTZaUUtEYUhH?=
 =?utf-8?B?bWJrVUNUeWJZTmFNZkt5OG5oTFVtTEFSQ0lDYjNkWXMrVHV5N3FJdTN3UUs3?=
 =?utf-8?B?MnM0bEJtcy93WHN6c1FwN0k2cjdQQTVvMDVpRFRIaFVUdHRuS3I0RnUvL0pz?=
 =?utf-8?B?MEdqSkpDMUtIcEtWUElMMDdZeXNnRUhkMFMwZXFTQXRCYzVEaVJ2K09zeGtz?=
 =?utf-8?B?a2RQeEVLamdMT3JldTdIU0lyVG1ab1dhdXZwazdyTUd1RWdNNXc3N0RkRXNa?=
 =?utf-8?B?eGxKbDFiQjJPU0VGYXk1S0w0cEtPS01STmY5QVoxWjhMc1NQY2N4VGVVU250?=
 =?utf-8?B?Z0ZUYTAxL1c0c28rQ2tRQTBVbkgyT2xvQVJSK3NjZGJ3SVlUS2dxY21aNWVE?=
 =?utf-8?B?bUYzWUdaem5BVW4ydHRhWUZnQnFVemtXeHBOTUpDT091UHIrWEQ3QnIrRlk0?=
 =?utf-8?B?TExybHdOMFZLd3d4dDgybVczU05jOVBtcFZsUW5zSlU2RmlaamVoNVBXSUlx?=
 =?utf-8?B?MFpqanhxRHBuSnNUcGlmR3VneEFOZUtQWWl4YmZxdFdGNGEydkZGR1dVR2cv?=
 =?utf-8?B?WkVrN1RqdHZ4OUIrMldhTWs2bzUwU01VRFg0d0ZjNW14aHFITDNLZzJ5bTIw?=
 =?utf-8?B?anpVa3lNYUpCWWx3dEgwaWlnVWhNUzdUbnlXdW9vUkNWV1RXYzVGMklZSnlS?=
 =?utf-8?B?MlZHM3BDUzNVRitiMWx3b2wvYlZzNFkxcWdId2JCNWlyRmx4dWZmNmt5ek1j?=
 =?utf-8?B?ODRCZ2cxU1FydUR0TWgveGJVN3FOMjF0QW5oUy9BVkdZejU1OWJ1TFg1Y1l5?=
 =?utf-8?B?RnduZjFxbmhKUFE1ZkU4dXJ5WWVHK0I5MUtodGJ4TnRWOGFGT0wyOXNrak1Y?=
 =?utf-8?B?bVRUNzNreE4waWE0K0dyYmk5a1BWR2crVUEvckFOWU4zMGRYZDE3M2tOUnVv?=
 =?utf-8?B?NWR5dGk0SDZhdjdiK1ZkTGh6aGtyWHBIRnM3OEtLaEdXMnRmKzFSUURHSWlp?=
 =?utf-8?B?aHVaaE9QUjNtejUweWVDVnRTdExwOUFlRFdqdi9uSzgyS2VrRDBMSTdZMk1p?=
 =?utf-8?B?UHlBM1JJYUl6YVFmWnBxc1Q5NnAzNTIrcFZ4OGtzVThvV2VpNlY2RXRFS01h?=
 =?utf-8?B?QjNtTUNNemwwYThmMGFhL25sZnByekVvcnArMEYvSzZFdktyYk5UOHZ0WWpK?=
 =?utf-8?B?SXRKREVCV2Jvd3c4QjU0eU16cXl0b2FRL0t6YjZuYzV1Q2hlMnF1eWhnNndQ?=
 =?utf-8?B?bDYyYnpxbnB3U280NWxuanNScjBjVDNsYzFSNFpCWEVjeG5wNElRdUVOOFM0?=
 =?utf-8?B?Y2VDOUY2T1dEUG9uUllKY1VLdjJxTTZsbXN2cGVjNGg0Tm9YR0I5blJPT09t?=
 =?utf-8?B?SzhZNW1LSmp2L1ZSVUFDcWRIU2RMcFp3eTgxcFMweGNQTHdvRG5vZ0NTZ04v?=
 =?utf-8?B?eTA2QldXdVllZ29aNzBhRmR0YWlkQWFseUtsZWNINDhHbFdjTXN0STdGUytu?=
 =?utf-8?B?YjBZRTVxa1RGeHBYdjlBalJseEdsVWc2dUp6N1pYR0tRMkUzNWNkbURscWxI?=
 =?utf-8?B?L09NSzN3Nll6d2g2cytXV2lsWHNPMlkvQUtzZ00vRFY1VU9HOW1paGNuNytz?=
 =?utf-8?B?UDkwU1dha0VXdXFlelNEUVlQcm5KZkNLNk1CTmFyUkxxVFQxZ2ZFNU5mdndG?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c8eea7-43d3-47c2-7822-08dabce6e95c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 15:28:37.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IQiRSD5JHXcGojF6/fjSvYAl/G4HDokdRvkV+PyfG8ea/HFYo10hxxxysYmZGS5WPnNVcKYsBkaClzIUayi4LVRnNEQWpH4m2HcfiaNUbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6874
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:14:00PM +0100, Miquel Raynal wrote:
> Hi Colin,
> 
> rogerq@kernel.org wrote on Wed, 2 Nov 2022 09:12:27 +0200:
> 
> > Hi Colin,
> > 
> > On 01/11/2022 21:09, Colin Foster wrote:
> > > Hello,
> > > 
> > > I'm trying to revive a product that runs on a Phytec OMAP 4460 SOM. I
> > > submitted a .dts RFC a month or so ago, and plan to perform the
> > > suggestions and resubmit, but I'm up against one main hurdle that seems
> > > to be related to flash OOB/ECC. (get_maintainers on
> > > drivers/mtd/nand/raw/omap2.c is how I got this email list)
> > > 
> > > Barebox has "native" support for the Phytec SOM:
> > > https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/phytec-phycore-omap4460
> > > 
> > > It seems like Barebox is writing and expecting ECC bits to start at an
> > > offset of 12 bytes, while the kernel (and Barebox comments suggest) the
> > > ECC bytes should start at 2. I'm seeing this with
> > > `nanddump -n -o -l 0x41000 -f mtdxnanddump /dev/mtdx`
> > > 
> > > Barebox created partition with UBI (mtd3)
> > > ...
> > > 00000800  ff ff ff ff ff ff ff ff  ff ff ff ff 56 49 fd 17
> > > 00000810  b2 25 60 1a 42 1d eb 56  5d ff ff ff ff ff ff ff
> > > ...
> > > 
> > > Kernel created partition with UBI (mtd4)
> > > ...
> > > 00000800  ff ff 07 73 04 ac 57 6b  9b 1f 92 49 ab e0 b9 ff
> > > 00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> > > ...
> > > 
> > > 
> > > My question: 
> > > 
> > > Am I right to assume this is an issue in Barebox? Perhaps this is just a  
> > 
> > I'm guessing so. Both u-boot and Linux for OMAP put the ECC bytes right
> > after the Bad block marker which is 2 bytes.
> 
> Yep. I checked, this has been like that since at least 2014, I don't
> think we changed the layout in U-Boot/Linux "recently"... (I haven't
> checked earlier, by laziness).
> 
> > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/omap2.c#L1729
> > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/omap2.c#L134
> > 
> > > bug that has been fairly dormant for 15 years. If that is the case, I
> > > assume there's probably no hope in getting this mainlined, and "native"
> > > barebox support is just a ruse.
> > > 
> > > If that isn't the case, is there a hidden "shift OOB by 10" config
> > > option that I'm missing? Or am I interpreting this data incorrectly?
> > > 
> > > 
> > > Any suggestions would be greatly appreciated.  
> > 
> > You should fix the OMAP NAND driver/config in Barebox to match that
> > with Linux OMAP NAND driver if you want them to run on the same system.
> 
> Agreed.

Got it. Thanks a lot for the info Roger and Miquel. I think this should
be pretty doable, and I'll venture down that path.

> 
> Thanks,
> Miquèl
