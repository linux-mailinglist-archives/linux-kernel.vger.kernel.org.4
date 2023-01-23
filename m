Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA167830E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjAWR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjAWR0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:26:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD36590
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:26:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghVXmnR+gkDkraqZSAGhSTTIapsSy71UwToX/RAgW9XpWt+jqZFMEZVMx+k+8/Dl0RI1VWDfy0HDe2qJOEbxbnKs5podQ4JVDB5Z1LXmHOk+aGrCL2XIcXGaDdNEnf2kCm5ihUZ8aCVp9ySr7BfQEvfvEv80LK2/+yV3wz+3kwKWvU5fMdENqJHtKMuSY35VG/DtC/eA1aG1rk43Xio6hF0lYweEo/yfGLdGnZQ7nQ+OTQpd945WyuMsK8oVSacr17bbmHBxTTKnahY/6/rsmB8X0S5IG4X2nXSptE2xU0N1vOpouXIEP507GhjahBwcp4FTaPlDBZGjJPqj0Tdzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ08OtxY7DaAhRg5UDkW6dubvK3Xtq8Ke1SB3vz7R7Y=;
 b=hgh0Jv7gAxvd157iZ3N/1lip6OSfXIuTxh9o9Vs2lT3vNgyLUrojvd62eOmGXwwSlS8YUwX8N7JJ2p926OsnTY4Ey3RF7FK3+ooScq+4zaycS++uZWAPF9s8Z+H5C4IW+0+lrP4rM8QV0kEx/VgFTkl1ZTbwdfGb9bGe3bHurN3WBGqgA3hwyR99kh7i7TgNESl9roQOysPHEg7Dw7cVo9AR92bhm63XSIpXfka1lLDqcovV5Rn+sxvDByFkvh7vGYMqSlYnVy1fFJ1lnHaPGLvnCadh9N8yPa6hC13ZGZfpDTa+S74vdCA/HgP801HuuiH6L4TTs2CwL83EjUsBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ08OtxY7DaAhRg5UDkW6dubvK3Xtq8Ke1SB3vz7R7Y=;
 b=S1zeQ+dNra9YWX5AckPq4AA4eI/oHrQs94GtQLh0sfHsz69uzvxHU7LbmG4Hq0yiShQo+r8pRxELLQs+9fu2XmC3/idNhm2fF6Qyd66O33MRjZ2b1JfjBKuVyQBYuXSyiQeVknVj0y/V1IDPjtSTVibyJkcxCLTFhdoIqQDhcydaWHFR4Vzsm8sYFQdRdOhUYbZ4k8o2AY4NVx0AS3ScDcg7tW9gKiOOLc2EH9AZtl49n4b1TI/X/f1xIHnExhEVIy4lTUHzbTihbHBEIBkzKr/B6ETaxbJ6XyayaWfn/ntrCJXUT2vfTSyrjctsg0Y6YqzEkhB0jGv0xFX0bb8/7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 17:26:22 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%5]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 17:26:22 +0000
Date:   Mon, 23 Jan 2023 18:26:13 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mohan Kumar D <mkumard@nvidia.com>, will@kernel.org,
        dmitry.baryshkov@linaro.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
Message-ID: <Y87DNf1tnB8aaKJS@orome>
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
 <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
 <cfb9b0f2-a8fa-9bee-a04d-d195d69e4918@linaro.org>
 <Y8rHzJpEg7bMzYM6@arm.com>
 <fbeff3da-e03b-aa82-1a53-d92f95b63770@linaro.org>
 <Y86uw7QF/hMrIvbs@orome>
 <2c6deeff-bf5f-24e5-4cf2-2640ea1e7402@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O//JUppp0jKn8+fa"
Content-Disposition: inline
In-Reply-To: <2c6deeff-bf5f-24e5-4cf2-2640ea1e7402@linaro.org>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: BEXP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::25)
 To DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: ea24a584-766c-4098-6b83-08dafd66f25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeQcfXHme+A5E9BL9RHmELo8xSdTKROkya9QJdDX8eQMvl+E1FdfGoHs03872uRZQW5hmb5/95J3JmhW29uXR7/0CFuMlNar0EAnTm3VCUo6xFVCkyEWALoiQiLCQgwtMoC6jWdCgMS2hOrtMlkeww03FwGeS2OQjJKmLisnKW0ZprMc0J2b4M9nuxxFaNCZvCaRd66qTITDunC27LL5SKE7ivGtvDsyhEERLLohM84YdqNxwh5+ThtY0vMjcKYhVJx61whG1ISb0kLd4vXzGXXenmik4KPk/Fb8x0IDuLfHEc+8FCCCFL0J1t5dbtUkJevbTUGdf1Xbg6TDifIa6VSgXBsHRPyNztf9pLgK1c3BJgpW2+wHUZTeBr7kGOvlPiA+Mz3Eh2fh7esKV82Ha1XQPwrB92P9rDdFtsigLZHR2y7+q471pd1Rpuc0fVCnMqOQTUTOp1/u1mnPs7a2KUlJbJ1eMJvSdkqkUKzxoMwD0GRQGMRay4CQSSpUaTZtwau+tibxkfdeIxObUx6xI93C+BUmzFriOQe7EPYpS5nByTiPX///PGonZ+RCRSJSyY91LjGgdnEeRwmg/eT6Odpa+19jiyQMhYiqX3r7tcvl1JFLRA7GAEFLIYpgX8FpN++6rHG7f7MyqAFDxeLcvrFGMOjdJdam6GnMZEDGUJ8eUJTs8+2KT+wX4gZ/RB/I5IHrtgewVMM+c0w+ppvmFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(41300700001)(86362001)(5660300002)(8936002)(4326008)(2906002)(83380400001)(38100700002)(478600001)(6486002)(8676002)(6916009)(53546011)(44144004)(6506007)(9686003)(186003)(6512007)(33716001)(316002)(66946007)(54906003)(107886003)(6666004)(21480400003)(66476007)(66556008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bkjUdoJryVc/r4mm0y+SVGqhKtYCJM9VCGnvJQLZbdYnol6aEH7svJYuZ0it?=
 =?us-ascii?Q?aAOZscu4Wk2+zKwJtFxFsSqdAq+X5uTR9VyuSoOLnpeDDeV6HS6eC3u//uQF?=
 =?us-ascii?Q?1R0VJo4ed/nrYvWKuVjVacpdlOAwef0GV1d9eyasBuLQhOMF2/lqFjtj2H44?=
 =?us-ascii?Q?kbVHEw3WdFqUmCjmIBIKiYfFWHrC0FAIW9DJUMPe8A0rk7oLimFnJpM0XDEN?=
 =?us-ascii?Q?VbUfqDKBAZdlaLh/mycJqwxLg83nzXsDoJYNToSCJMmAfQioK0TBR+RvfSHo?=
 =?us-ascii?Q?RnD+z6cnHWSAgdjn+5XW82QCQUSeGRe0fZZfUCSg9mYaYPbhsH6QELra8IjA?=
 =?us-ascii?Q?+edyAqCm++5WO4YDqKElNR3640JiP8RIuAfidInWPjVrUD//90yBp/3Zsu1C?=
 =?us-ascii?Q?uBh8MARYos7VnkTE/JMDjAvf4FhANRm+Icrwzwq8uuENRiCR/E7rPIkmsX7L?=
 =?us-ascii?Q?Y8HQ309GTvjFOG028G6upoD9H3iap63xIS9fzcuf4pcSrIX6GQGrVs/BqOEm?=
 =?us-ascii?Q?U3kAz9h8hsVsDcGkqJ1RdR9CpWs32Zb7ydEX6pTVipxxs8DpsjW4CIjemVxG?=
 =?us-ascii?Q?XCJMXk32zJ8GtOwDUHZY3EenwEAma3M1aKBrBJqKSK7dN/6TJJpYS2Cpf+5k?=
 =?us-ascii?Q?4SxMIypyMyTDxHFqSfVi7RZ1/XVkxX3tm7q4Jge8NAgBG8Gy1xTkmekMGhEb?=
 =?us-ascii?Q?68gB6RwIXgmmkrY3g64tMvQ79kwt1iHP5wv9CEimswrnYhepb+uoh0uW4ekw?=
 =?us-ascii?Q?NVIWiMBXEDapO1sjHamLiyn6emaNtZwQrQt5eslk4000EdXe6ZKJsUnZHdrB?=
 =?us-ascii?Q?LZk9SzH6E2F++Y2cl3jzW7zk/u77DZK8X5np80fU0mbSAR4I8lxkjPiFSBQ0?=
 =?us-ascii?Q?8QNwbjdIrvmtjpj/Xh9mvT79N1nj4doecBJTHjGHGnJAfY6qkmQpKYZnElPV?=
 =?us-ascii?Q?8HyCGY6MsgUrdRDVbbdTOopGajWrUzqM1zVhbPrc0qRKXYZZa+9by7fe/oIo?=
 =?us-ascii?Q?eFV4tmJNpDx0z3bh3JRXIKagK9er7u214AUvLEESnXj2mf9z2HSM8ocw/NX9?=
 =?us-ascii?Q?4umK2lRwuH+31f2Hd6NLXmPUXrlg6EmXhR0mRuabxCL/sFPrQGnb7IVmP5xB?=
 =?us-ascii?Q?Drt8JpQkKYg8KaWJOekam2VhqNAduZ0G8e9QrgsQaXG3/QeE+4pL+HaD86DT?=
 =?us-ascii?Q?ddDtqamj6LbPBEYIZwB8uGhrTMU41wPYAm3bzpBAd56KulrxvRb41m4POUNU?=
 =?us-ascii?Q?lIZifQIMPBpIcKN+/dM0fAmqoZLp1Z4hOQ/eYG/MGAXFsDz6+0apGkz2Ihjd?=
 =?us-ascii?Q?bIOuekwp4EbOyVgB513pwr0+Im4qExRlcxeUZOCPaISERj5XAhz1kT3XF9mI?=
 =?us-ascii?Q?sk8fMxKflSqj+8D3C528PYBh2LKZCpmUW9bcXeqMkmSCYYNIRkVQ2AnAqf+k?=
 =?us-ascii?Q?FX4GcdAbF39fUrlD9+M0s/tjCaN3cV1MC5aOQnd3AEDmSMzsJPfrWHXVW1wj?=
 =?us-ascii?Q?xwhRk8PwhaDwcNFuBF9xX7GkzRoGvku51GwlpqQZaDYdJdZToKXL3eEIhre3?=
 =?us-ascii?Q?ef+8LlBK4W1d3hTwVdRI+qTXA4tiEozqRGyYGTh9USyJmTTO8ATUzc0ZUHur?=
 =?us-ascii?Q?83m++CKAmG/7ctY82k5RCEnvv8CAo0DEUrAMrYqA1uXP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea24a584-766c-4098-6b83-08dafd66f25b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 17:26:22.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP8E1kozszrAA3qA6WRvKVHuvQoYaGRYjgwy+2OMjeP3GwGVAFkf6KqAZi+9G05lqsPZv2bPx90XZ8iva4RQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--O//JUppp0jKn8+fa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 05:05:08PM +0100, Krzysztof Kozlowski wrote:
> On 23/01/2023 16:58, Thierry Reding wrote:
> > On Fri, Jan 20, 2023 at 06:00:25PM +0100, Krzysztof Kozlowski wrote:
> >> On 20/01/2023 17:56, Catalin Marinas wrote:
> >>> On Fri, Jan 20, 2023 at 07:20:01AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 20/01/2023 06:48, Mohan Kumar D wrote:
> >>>>> On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
> >>>>>> External email: Use caution opening links or attachments
> >>>>>> On 18/01/2023 12:46, Mohan Kumar D wrote:
> >>>>>>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
> >>>>>>>> External email: Use caution opening links or attachments
> >>>>>>>> On 17/01/2023 19:16, Mohan Kumar wrote:
> >>>>>>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound=
 card for
> >>>>>>>>> ARM64 based platforms as Intel PCI driver was used for register=
ing the
> >>>>>>>>> sound card.
> >>>>>>>> It's not a part of SoC, not a common device used during debuggin=
g or
> >>>>>>>> development, so I don't think it is reasonable to enable it. We =
do not
> >>>>>>>> enable driver just because someone uses them. Otherwise please c=
larify
> >>>>>>>> which board has this device embedded (not pluggable by user, but=
 embedded).
> >>>>>>> This change is required for enabling HDA sound registration for N=
vidia
> >>>>>>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Pl=
atforms.
> >>>>>> You can plug anything to PCI slot and we do not enable every such =
PCI
> >>>>>> adapter.
> >>>>> Without this config enabled, the Intel hda audio driver won't be bu=
ilt=20
> >>>>> and dGPU won't be able to register sound card. Do you have any=20
> >>>>> suggestion here?
> >>>>
> >>>> Without hundreds of other drivers they also won't be built and won't=
 be
> >>>> usable. Anyway, this is just defconfig, so it does not matter. You c=
an
> >>>> always enable it in your setup, why is this a problem?
> >>>>
> >>>> Again, we do not enable drivers for every PCI card.
> >>>
> >>> I don't think we have any set rules for what goes in a defconfig. If =
one
> >>> has a real use-case, we tend to enable stuff in defconfig, especially=
 if
> >>> it's a module.
> >>
> >> There will be always an use case for every PCI and USB card. It's not
> >> related to storage or networking which could justify device bringup
> >> (rootfs). It's really not needed for any board operation. defconfig is
> >> not for marketing products but for our development and reference platf=
orms.
> >=20
> > If defconfig were only for boot-critical drivers, it's terribly bloated
>=20
> We enable drivers for devices present in our platforms. Everything which
> is on such platforms. For pluggable USB/PCI/whatever third-party
> devices, then comes the argument as boot-related.
>=20
> > as it is. We enable things like multimedia, infrared and audio. None of
> > those are critical to booting a system. Heck, we also enable most of
> > DRM/KMS, which are useful for boot on consumer devices, but are rarely
> > critical on development and reference platforms.
> >=20
> > Besides, a PCI board can be considered a development platform depending
> > on who you are.
> >=20
> > I've always looked at defconfig as more of a guideline as to what's a
> > useful baseline configuration for an architecture.
>=20
> Yep and this one here is nowhere near that architecture. It's pluggable
> card, not related to hardware nor arm64 (If I understood correctly). Why
> you do not enable it on x86? Or multi_v7? or hundreds of other defconfigs?

My understanding is that the code behind SND_HDA_INTEL, despite the
name, is in fact generic PCI HDA code and is compatible with a number of
non-Intel devices. It's also nothing x86-specific because this code
works on any PCI-enabled platform (it's for driving generic PCI HDA
controllers).

It's quite common for people to hook up PCI cards on NVIDIA Jetson
platforms (which are arm64). Often these will be NVIDIA GPUs, but they
can be any brand of GPU, really (SND_HDA_INTEL supports hardware from a
large number of vendors).

> >> The only argument behind this change is "I have a PCI card and I want =
it
> >> in defconfig", but why it has to be in defconfig in the first place?
> >> There is no reason. This is not distro...
> >=20
> > That's highly subjective and honestly that argument can go in both
> > directions. People can, after all, start from an allnoconfig and then
> > work their way up to something that's usable on their particular device.
> > Or they could start from an allmodconfig and work their way down.
>=20
> I am sorry, but adding new stuff does not require arguments against.
> Adding new stuff requires argument for it. You reverse the argumentation
> that I need to find proves that we do not need it in mainline platforms,
> if I got your response correctly.

Adding new stuff also doesn't require arguments in favour. At least
that's not been my experience in kernel development. If somebody spends
the time to write a driver, we don't tend to ask proof of why it's
useful, we trust that they wouldn't have spent the effort if they didn't
think it worth it.

Besides, this is to enable support for these various HDA controllers
that can be plugged into Jetson platforms, which very well are mainline
platforms.

> > The point of defconfig is to give you something that's somewhere between
> > the two extremes. Obviously if we start enabling everything, it defeats
> > that purpose. If we prohibit the enablement of new options, we equally
> > limit its usefulness.
>=20
> I don't think we discuss the same thing. There are no extremes here at
> all. The patch is about enabling arm64-unrelated PCI pluggable device,
> just because it came from @nvidia.com author. If you think some PCI

I think you're making this into something it's not. What would be the
benefit for NVIDIA to enable something that is unused? If there's
consensus that only boot-critical pieces should go into defconfig, then
that's fine with me. Currently that's not the case, so painting this as
some sort of marketing stunt is hardly fair.

> pluggable 3rd party device is suitable for defconfig, I will bring
> hundreds of other drivers I am also plugging over PCI to my boards, just
> because I want some audio.
>=20
> It's not reasonable path...

Well, then what is a reasonable path? We've had per-platform defconfigs
on 32-bit ARM and people weren't happy about those. But if the single
defconfig on 64-bit ARM doesn't generate a configuration that is useful
for many people, then we don't need it. People could then just keep
their own, local default configurations.

Surely I'm not the only one that gets annoyed if I have to tweak config
and rebuild multiple times until I have the right configuration.

Thierry

--O//JUppp0jKn8+fa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPOwzMACgkQ3SOs138+
s6HVRBAAnqpWg5tTvmv0jzdT0+wr3ICHoVNHkx80os6Y5EdOvAeWJhz/tTJup6fH
rNHKYtnyRV1Eewot7s9QAS0cEz/gXL7GiHHP7QF5bGdKcio39BMNV8tgj5l1bKz2
XwcDFY+nJ9X9HwTum5qxmFlYNqAbNtCnlAXdFUjFoRvl26N9b8kK/1XNVXWZzmkR
dhvLtAY9Hp+qsnn6noMphC/XYYTxTCU8RiFnSaju6BnKcckwM0+bqUykpYwSCvwW
AupQbgjftDKquGX5nM4r3bMIF5WfGkPRdnTLug07hujFKl88K7MjjHijcyEzu1My
v/GSKlD8Z5KEqEAVm4GbYC9cZQRPHQyW57Bom5j/aeiH5GSvZCgtApKxJv3wAj+5
HfI0WL9cnTbJxp6CedWi37v8+M7mB/Xn0sVqXgmYLc43q9E3Hi0LI4pYJp8OWQq8
Y7TUqoiihoB9Kqc5IUIpdPqSxV1loEgXuWu8AEDe0xpnzPCNCkD8yxrGlGM4L9bd
DwE3N3GhA7YEs3X93Gu7kX2f5rVSVFLjIQxj820qy20Mzi7HET3Nd8EMdJGnrxeM
jsT7fUkDkWogQaQCejZ+SdVBr7YzjLL9ym2dP44nYNwrkZS+SRVjsjzJA7ecU6GE
tt2oAkSfJJD9rJFDiOeMOVVhABsOzwk7xyveyAaeoxRSPnOaQVk=
=+gIA
-----END PGP SIGNATURE-----

--O//JUppp0jKn8+fa--
