Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D86AE012
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCGNMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCGNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:12:02 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650087DA7;
        Tue,  7 Mar 2023 05:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO+FLlvsCjxMk0wrrrCWidqELr+SwIvCl9LpkbRs3Csjp4vN8OCVe4S79nnuGojedyMBg/ck34iA8Vm3yRtYjluBBaUv3G3Vb8dyPFg27WyUfh2Ov5lubVZ3J1L/HHsP+K1wWJ4U6JM4t5mNcSD+ipKYjOS05sv99zhK8wwEADfejfZomc3CzZMdoCQ0vQoyoY3M3zHnoAqdwRdp4OpsCFCcb8NkvDNKlFnXnxwbHNfGO00FWiX6sqkivq1VbIa9mz4kFhOyjadQiqzgdFoU9YACQjNfpBwvDQE990hUB93pcIQ9zqDHv9zdwBpuk2VTxV/a+dSK8ZDOf9z0BcPg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGQeh1JUZeB6K9waOOJEqw6W5uvOnktLWWDpAMzIwLQ=;
 b=UVo7pmoYhMKN0FIfblIo9elBAQ9b+HqIDWXNQWbLEp74HS/8/wekRGfMvbur80w94uRCS+m9S9ztwDpNcq29+8/8bOV2CkrJ8IN5gul5iO0c2MBzotm+LhTKheGGkpC43v3n0zbS5tvuX06AnJc+QC5xUUWt9WYWV1IEUnLFJ6o4ZkGomNGpKFjstw7QJMLSZg105+14CeCdp2lpZpcRbaNjzA/dA8SYrDboF7qTOxcual1wlHSfZBQtYjCJvgNCnPGeTpsM9Yb51VkMOkK39PZklzYHj0OMhirkEnPqnoD26j/KfTFNIqCG0zFWB++VuCLORX6PkpVwwe8LLxkkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGQeh1JUZeB6K9waOOJEqw6W5uvOnktLWWDpAMzIwLQ=;
 b=ilT48FomgTbR8s65RPoxOAMlPNoQZgPLpxnMvjbjZ6cTwliUknDCKb8CCQSqX67/zlWQJhD97Azc5T56++R5hVs0jUyV0JEtSMjwRDDZa1Mn03SGL5kje6KzH7B7yIxHkfEMz40CA6oPfHZroFfqtEVdt0DuE/5OHz+tSNnZTPEjV45XSlfvwh2SOcMw0KYeepSbjdQ1il02UGYZaun7xCDzHMDytu1H2g6w8B8pyn91bUZ5es3SAyULLBgLpMcd+FHMyxjsGnNg0dScf7AQtnq1lJZVyUL5diUCgW7HWQ4/UMim4DDcf5F2wEiVyPLdU/zhMRpbgnPqcjZL7VdLxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DB8PR04MB7098.eurprd04.prod.outlook.com (2603:10a6:10:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:09:59 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 13:09:59 +0000
Date:   Tue, 7 Mar 2023 21:09:48 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v5 0/3] Add pinctrl support for S32 SoC family
Message-ID: <ZAc3nKEiYbUEX2xv@linux-8mug>
References: <20230220023320.3499-1-clin@suse.com>
 <CACRpkdYknZo3Q7_CeSkOL2XwwAmKERskx24o-toaVy=rs0Yf5Q@mail.gmail.com>
 <ZAZ3JZQ4Tuz5vyH1@surfacebook>
 <CACRpkdbksZ59ndrRAQpTGa01GTq4c_2EcOQ2mtz1PLjqU8_nug@mail.gmail.com>
 <CAHp75Vf3ve-NdMG6iti-KSs=tGGgGf9tNj=aK7Jofk9233WocQ@mail.gmail.com>
 <CACRpkdaCZSoem31GmDC97LPYcZqRjkyf=6VGtXdXK0iwrV74qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaCZSoem31GmDC97LPYcZqRjkyf=6VGtXdXK0iwrV74qA@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DB8PR04MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: ba07354f-893c-4778-4620-08db1f0d4133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyHp5Ftaa8jpzAXSB+aHYORUv83NgWlU4Xl+Y9U6whHxLEMacGsM1KSYapi4H5JeM+BhZsIi++hpg7+Jqb7+h/8s0hWuVHMDUABbVCRDGc/AKWHY1d3/bFjE7/BEZ3j5OAp43LXNvfJ2bCE0OS9uNOs1y9xVXO5eLgOcy6JFP+AAKgslnVBxZNuzS+JbYmf9cS0+1/WHQJ60f0tT9++Iog5yr6CsimkLtJtOBuRgdoezMBbX/kgbKS2HdiIuPqfLn+jD+hZx7azqIfUr6QRr4B+a9AhNauBP4cOMWBZpYUpXRL/NGQVZ4QOe+k6VumNG3fMx5VM3gzA9tin/jSX3Uy3Yk9wLg7rKaopqgCZlo9gghP7+dk1WyjUr7RjP1UTcMU8fbYoH+D0WqgFxcf8mf5E5HwYsx6AhniLCHOvR0vmjhVxo9c1St+QQvCIYYz1JnyNradzaElUw06HgQUDo2gdqaFnD8ysGAiz/kyLxx7/k+0bLM/zAJo/y8pHv0Q/3qPYonsjTDiAwXsqmU1XeE03rNBeeiTy0SX3vmSRl460vE9WOm8hhHBWjw4xIAJqPbahp6hd7ap4oMHDeKBen4iVlju/nRPx/5tQRRPza4y4bLIkbd7m8kdm1g+ia+9rUdHn7wTzcPxPn3bvzkqHhGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199018)(2906002)(83380400001)(33716001)(66946007)(7416002)(4326008)(6916009)(66476007)(66556008)(8676002)(5660300002)(186003)(6512007)(9686003)(26005)(41300700001)(8936002)(6506007)(53546011)(6666004)(107886003)(38100700002)(478600001)(6486002)(54906003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9jTlA1V3JHQVlaalE1azlhZXVYTVkvTStBYmIzUE9oUStzZzFJV3NRc2pq?=
 =?utf-8?B?bE0vMFo1dkJWWlR3alNuSCt2SFEwM0FJWmM0WXdSNHBibnlVay96RlZHVisr?=
 =?utf-8?B?RlhrVDRYL0lYVFVvVkdhQzZjWFJkQVQrQUc5Y21IbHpud3N0ZlcwRDJ1V1Zh?=
 =?utf-8?B?ZGJ3aHN4YVk0ekkzdGJYR09GYStHaHB4ZVlvaE9NcFI4T3VMeUR4Z29kVmlB?=
 =?utf-8?B?eHlvZmRBZWcvUWd1VE1GM1BYai9VSGxVSU5QZmJzYXpCZnp0WUVxTzZUVmpM?=
 =?utf-8?B?cmJ4dXhKRGNwNko2Z3NYQXFEQWZiYmhaM1ZXU0EvWW9XWDR1U012dnRWVGpt?=
 =?utf-8?B?d2w0TTZVUThVSjR1SFNZejZxVThGZ2NRS2MwdmRFRUVPWk0wa0R4WXdPL1pM?=
 =?utf-8?B?aXc1dnk3VS9oci96S0ZZQURsMkd3ZnY1SlFhQXhIYVpER3pKOVZYditVN1JQ?=
 =?utf-8?B?NlNRc1lvVy9ZdjczcjhaUU9XdkdoczA3N0xUYmlqMXJsYXF0SGtuMkdQY0JH?=
 =?utf-8?B?aGdOZUg2RTNIUEhsWjZnYlRNc2s3YTdQTzdoUzNXc1BtSlZWUTRnSEFvQit4?=
 =?utf-8?B?elUzWjliSmZUclFGV2RSeWNVS1dOY3QySmp2VkttUTlxN1BFNnh3a1lwVnJx?=
 =?utf-8?B?SUhrSi8xckJaTjVDUGFOeFd2dkJNVk9vNzFkbFV3SXdRL1E3K3ppdng0Ky9s?=
 =?utf-8?B?MHVIdWg5VVdKczRGOThnZmdoWW93MkU2alhBaW5TVHJmMzN2eHVlbmVSVkpI?=
 =?utf-8?B?S2pOTmZmZ2U5V0JuNHFtbmVKQzlieDFUdFYzSkc1VE1Qd2EwSXV1UzFYOEZU?=
 =?utf-8?B?RmhwUjE5Qk9lSWxRK1IvSXhaem5mRzRPd1BBV0Zjd3VUY0VmT21HNUx4Tkc2?=
 =?utf-8?B?a3U3Mm5sc1NjcG92S1BYdE1udzk5WU43eWE3TDBMMGhySzZ1RndkZlc5UUVG?=
 =?utf-8?B?ZFJGcjIvaDhqQjJHbnBPRE0wZ1FsSklwYWdUcWdnWnQvMzR1ZlgvOS8wcnJX?=
 =?utf-8?B?VDZLV1ZjR0ZFbDgwR281SkRZWGVsR1I1cHdYSjQ0QlhJdXA0YVNha1dVcDN6?=
 =?utf-8?B?QThhSWJVKzRYWWtwSzAxK2RmUHVIOXdYSVZLQXd1REV5Z1QvemVZK05xclMx?=
 =?utf-8?B?cWtjSGZNMGM1OU8rZnF5S2plb3ZWMStwd3h5NnhmQkVSVGpDQnErbHJlKzNX?=
 =?utf-8?B?cVRqeTlnRTRPMHZxMHZEYTI0a0R4cjg2QWQ1K2VYRlh6SVlHZkZtaG9aa29S?=
 =?utf-8?B?dnl3NWxSb01BeG5WekZMQ1BMMzdIdStwK2VHV0g0ZFBTeFhFQmxRbUJiME5R?=
 =?utf-8?B?RVFkNWkwQWtLdVgraXFrbmU3NTdRcnZIcWdJNDMvTWF0aVZGaUlwTlpheFAw?=
 =?utf-8?B?Ny95T0x0OXJnQXc0NWp5K1ZYbUdHKzNuclczeTU2K0djZEx3Q2xZMWkzOVRi?=
 =?utf-8?B?YWRpbWh4empLbFlrcWs1TjNvN1dvTjRwYWxab09md0VqMXFDQVl6ZGRjWUFF?=
 =?utf-8?B?VFo1OXdzSnBybXd1YVE1Z25WdjBmeGd3WVQwWnFwTU85NWFzZ0l2Zmtxd3BM?=
 =?utf-8?B?ZDZZV3NpdTFyeWdlWWd0cGxsdWJLVFZMZThCVnVNRncxSXlkcDBDakZ1NmQ4?=
 =?utf-8?B?dFFtdTIrK0V4WVBTazBQdmF2WnBWNUtkRlZ2Rm5uZXJHQzVUU3ZDQzFJWC8r?=
 =?utf-8?B?YmdINnhQUDVSQVBDWHdjUTdZc3gwdEJyeU5pUTFlSnNtS2RuR2NkVXpvZ0VC?=
 =?utf-8?B?NWpkZjRscUZoTytmNGdYck9kWjVqbmJjeUhUWkxKQW1WU1dJbVVPc0VUendU?=
 =?utf-8?B?Ukw0d0VQRXdaVGIwQkt4VFVrVFg0U1E3T2VNWmxZZ296Qkc5OVFLOWV2bWwz?=
 =?utf-8?B?ZmROTkpOYzlOL1VKODFVdjkrcnJoUlI0QUYycWtHVUlIcHk1Z3pJTDFWcWhv?=
 =?utf-8?B?bExvWnFMMVlsWXI4N3BtaHIzOVRiV0ZZb2YrZ2U5SHBoeXN6dmJJSjZWRURu?=
 =?utf-8?B?ZldNdk9JckxodUxiSXR5aXV3aHJtUmpscUl0dzhnMWhmTW5qaVAyMUw3M3M5?=
 =?utf-8?B?dk1ROGhnZ2dXSnJnSGpuQVAwK0RITEJCdU01bWZ5UVRhaFo3Ym5YRmtad0I4?=
 =?utf-8?Q?pIR8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba07354f-893c-4778-4620-08db1f0d4133
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:09:59.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qbyPEb7k8EYtnmA6dVhvBWi1tk+GhjFska7DAapNM6vj9Ap7PGzn16nbrymOKvc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Andy,

On Tue, Mar 07, 2023 at 01:49:00PM +0100, Linus Walleij wrote:
> On Tue, Mar 7, 2023 at 10:56 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Mar 7, 2023 at 11:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Tue, Mar 7, 2023 at 12:28 AM <andy.shevchenko@gmail.com> wrote:
> >
> > ...
> >
> > > > Can you unpull this?
> >
> > > If need be.
> > >
> > > Are there serious issues with the patch set such that they cannot be fixed
> > > by add-on patches?
> >
> > There are a few absent error checks, some error code shadowing, etc.
> > I can't tell if these all are serious, but the amount of them is like a dozen.
> >
> > I reviewed the patch, so you can look into that yourself and decide.
> 
> I looked at it and some of the comments are pretty serious and need
> addressing ASAP.
> 

Thanks for reviewing the patch.

Please kindly leave review comments if it doesn't take too much time for you.
I just want to ensure that I won't miss anything.

> However it only affects this hardware so it's not like it's breaking the
> world. I generally prefer in-tree development over too many big patch
> iterations, it gets more focused.
> 
> I think if Chester can follow up with a patch or several addressing the
> comments in the next week or two that's fine.
> 

I will do my best to solve it.

Thanks,
Chester

> However if we get closer to -rc6 and nothing has happened I would
> not be so happy and then I might just revert the driver patch.
> 
> Yours,
> Linus Walleij
