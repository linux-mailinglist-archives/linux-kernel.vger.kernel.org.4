Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F35623065
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKIQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:45:46 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4C2316D;
        Wed,  9 Nov 2022 08:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrDJTTAaWUhGo1bjOVQ8Bze3MprESNeHz4yRp/ceBo71fPXs3LVDRlLV41KuBJF4nGl+ECEsq16aHTF87KvUuW8JUJt3ICrKtFXvFEDBwZ2P+reHiofXmA9eNzEbDi+YuvDfqtndsMCMnaxek8NW2msxpyFmiYDF6LtwhCHpLeI6CzqMp05zhfBxrUKex1Jl4Bav1mGQpQZC8WMmS4DSXBVz7Zl4AdaxjCUIQs9AHoM7Qd+gVW0jzBpOaFqBE47Z+hjsTmSN2OrYAJOx1Gkq7oA3TpU1ldLgwrT8RT18hvOzM3yudO7y8pwHcfX0G6G9awtai521JGWFcnrHZA32Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoMihoniglv7Y1/5KUqa1ybTNcKsX6BNmr/kl7oOxi8=;
 b=J20BzSesbAVDFw+YGuKFunZnOKdmar3SReF9qahxXjfUcFdZRM0fKc9MrIdsIB2J+OiIjhCTryugL+cFArDV3K+13rZQFW1tWq+kSy/rpv1Gg70W0m07Xugze+ep863t380+RF8JdO/JS6+65iyEDpM07/5qJFil1F9AJLqkAixxWJwhg6FCWTETxCd6HcA/BGfFLpR6i8EgSbvF3kzJT4aTQcG/w4n5aNRbLb5dP4EadFgZpVJZwpjnofhpTOYSnpFeEmfggmxc2TL86sD0Um+0KutMG79ImTxo/RU2EDmykS0/F2/DSDAQ++qP0koxAW4WZfwb5tV6VgkrL07O9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoMihoniglv7Y1/5KUqa1ybTNcKsX6BNmr/kl7oOxi8=;
 b=BhBADb3xPxaRhesJ/K5rbJS2DIABbhxSySCOXqnTtxtuq9u0ycJKZgns0sjEkYrFjVbIHWB7DLCvg4OY2wPYcxJ51d+ei1ARL34qNDouT8OOzMnz4LH8rQMtP1GnAFznDR5WQU6PwUP2YE2dQTIL52DyKlpZgyDj12be4XsCv4nIxJl5bIdULjscFQxmR62CwvSTN7Q9ap/uFgj3oY0ueWd4PxEYm1wveIqdF8Fkx5qjsiHE+T+JbAf7Cw13gBPllp5OYCP31v+pSdCQ4kHwpS1Opka2FfZW15wkyyOJ3tWiUjkayYDrn698UCBk7vfbTAYc/5xa9zlw+J1urYu5Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DBBPR04MB7804.eurprd04.prod.outlook.com (2603:10a6:10:1e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 16:45:41 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9%4]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 16:45:41 +0000
Date:   Thu, 10 Nov 2022 00:45:25 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y2vZJaoWThP2aipE@linux-8mug>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-2-clin@suse.com>
 <CACRpkdY-uaQ--vFM+vVPbwa-q9nbSU0rQB+qbL=9m0wVMwA3Aw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY-uaQ--vFM+vVPbwa-q9nbSU0rQB+qbL=9m0wVMwA3Aw@mail.gmail.com>
X-ClientProxiedBy: AS9PR06CA0653.eurprd06.prod.outlook.com
 (2603:10a6:20b:46f::33) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DBBPR04MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 733d373e-51d2-490d-57e1-08dac271d50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRby164aKxfZDqsvnljQwMhc8iUo0ww4t5HFtGypuG8OF+j3ZAhyAxMfak59YnDzRZzxEQH/UFFO8UOPrZw14NpccFsHcAHu3FCvAK37rMZTXupFOx1/zHKl6rsMqEw5kncVahL6kMvB4cZ3GwWxK0jfAauTNg7xLp0D3YqKpbmDCy2EOkjpVEdrU/bj5k3xvHxtInmKpkXLfGhlEFylBdnZdru2dR/Tpp2kf/i4e4ObWczYTcDwhEUO3iN6vRrn+yb2BD0unxahl/3jmlflk+NfjILqBcl/FR32883Eg23JHbKYbnTGyeyggVIcQ3sxC/KzRzTAAVbuk5r/vIKNF5uJ5waLflfcODM8CSH1GRfgBhpLnsJTn3sLaLu7zVypCmSm4Pz+lZNuSb+UOHRKYy//5Zn9OkTRkmYP1kdV01ztI8fNldLy+MOzr04p8MphFYaIi6JuGZxihi62ToOfdhgVWq0bewOGHPYgBBfIQfTL7qEQ51CEPHgvf4/z4rQE7VF6ABCzg9NekSpXiSGrPBg2kNvPnuBYc2pSrMQ3dnYFhZvRNdZhM2tOypK5LCsTvSBJx9uEiua6ndNlwoyYRYim6N/0GEQoO1TcMZBlbwCY407iMkM0osJkIfxcqB/+tCcd77ZLRoe9WbjX+jDhEAmLTq03lltOjvAAzSXs8T/NyQ4PFEnuAaVzgUaJdg9r9OYGL9QvJDTyprrl0eMiMh/+Zi5ECUc3MJ27u5PyerA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(6666004)(53546011)(26005)(83380400001)(6512007)(107886003)(186003)(38100700002)(9686003)(54906003)(6506007)(2906002)(7416002)(33716001)(66946007)(966005)(5660300002)(41300700001)(6486002)(8936002)(8676002)(4326008)(66476007)(316002)(66556008)(478600001)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OJDusVB0MYMJSXOHfgs5r1vuTsUpPeWnq6Ubnn909EIoEz1JS/DOudIfu4kl?=
 =?us-ascii?Q?EMXMjPKS4VzLTavCTlXdUHKCTDYEhgl99i02/ZC+WiFnXU2bMHrZ2k3E4JCw?=
 =?us-ascii?Q?kM1rtEmdAgHFHQguTMd93uzq2qi5n+NfPZnvpp1jqipSJMyKN34D/oGVAt+3?=
 =?us-ascii?Q?qZWpTpB1XxL1afwOJ3lOqThxCrl4wDFVAVRzeyq6a2Aa9Il6SrTLwnhOdPlm?=
 =?us-ascii?Q?1INNnb8SR+lQ2d9Wifd8R0jZ5dfiXWjEQCfDAkT7wZLYa4d5r+rqwverqgKf?=
 =?us-ascii?Q?eSF4QV8r/E1nXGPmDCMVR0DvmMhyfs5D0Jz/wwwX6CfJYfyJUgc8k+sUUXcn?=
 =?us-ascii?Q?OGRtXKPX9DPMolCM6kNuHoW8eT6HhYaBpolWhkK1CTIByKz9IdjRUyGYqH4s?=
 =?us-ascii?Q?9tbg3cFSRCxLwCGf8gsWPKYdbVvjZjWxTjhcxW53jPN7yraIkfWE+RlXnl+L?=
 =?us-ascii?Q?6IywRXidF/HHUS2CNw7i0xp/ITsBjhbGexhjJiol1LHe8iyfSjxYVU4g5CY4?=
 =?us-ascii?Q?afHbzUoPc8XmsR7GwNYegmck51dSEKwtEEvxyg+hxyalvu/5Ubrd4OS06ZOH?=
 =?us-ascii?Q?z3jV13VKTwYaIn1f0z2WPef1i/5q6bUogeIsXqOh1/gkF0p5oVYRS3F61IfC?=
 =?us-ascii?Q?jqOfHyvSw19G8Yol/GccSagv4uVcxPXXhC0fAT22kI/Px2Btgw3kjE3RJNh+?=
 =?us-ascii?Q?w2yNmAvh+aC1EChGS0H93zLvk1gXBY7At6udOh7tNbkBfWzKkD5CNrahZcfP?=
 =?us-ascii?Q?ibSEt77pT/xI9sRa1Q7yzri4+nMI5XyGvjn0sQyQpVNIaP+wKn0uwmv9/wd6?=
 =?us-ascii?Q?/2qyoj11phuZ5i7FOo/REFOLCDTXbEXPEPC2gTom6kmnfzQvnph7NfXDHYZ1?=
 =?us-ascii?Q?evSig+hnfHe6l/5y0POJcLmq9i9JV0oRFpL3ZqIUcI3PPuDipuemVn+7Cg7r?=
 =?us-ascii?Q?GFzucqDlHZvENvZ1wkEwwxgqcw9sQ8QJxuehYDw24Q3p9Nyh9qkHdVw2TULS?=
 =?us-ascii?Q?PTXeGvvL7YCF2rPTsioc47GZXfgk8eGQ3wdv1IEgCHS85wxZIfPINdCgTgZY?=
 =?us-ascii?Q?pHnwpYh2fx1xaJD4CQ6wJ/X2tBGglFVTaOk3VQ63NPdcmgmZtODqzY76teoP?=
 =?us-ascii?Q?CLVCPmZ2SLyQyWDUJdFI16dwUbAVVVfV8DZaN5eABoVkok8Iea39fWfZ9EOM?=
 =?us-ascii?Q?9Cy16rziilZ7QfTSDUXnUkNWgqGqJYiIJ21e9wTw3Qka6ilQAchklZGFkEjl?=
 =?us-ascii?Q?c3ib9zCnqmqbUqij37O56yhDCQq8l9jCER5wAC44XuPs4/sRIXjtkxLeHYa3?=
 =?us-ascii?Q?T+ettzdbyIBWdnxgcYfcugANB5FIHlGqeB6FiDMuxoRrXmj98qTsVOWWSOe6?=
 =?us-ascii?Q?3CpVXEJjszbAv2yoKJ56/VwyRfZ4Ygo4ZNVhMOqPdF5HhVLLi7G9Q4U/cDb2?=
 =?us-ascii?Q?w+psTqGKngaa9fkdTLvmm+SAUsq4eDIZ4nYgcGiPol+bM03I96UCm26Ys7aB?=
 =?us-ascii?Q?bntVekb8RbbmeQzcjrzmNTgSdnTQA32TuuWvl2O/xp/29A+HJvi+gMLPQeJI?=
 =?us-ascii?Q?fsVQ+Q9MCWn4H3h3hos=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d373e-51d2-490d-57e1-08dac271d50c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 16:45:41.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsqpQggptyZg9OM8ufhRddL84uJBkdDDKpFluBqzdYjOAjF5EbW65HRyloJsTBTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Nov 08, 2022 at 01:31:16PM +0100, Linus Walleij wrote:
> Hi Chester,
> 
> thanks for your patch!
> 

Thanks for reviewing this patch series as well!

> On Mon, Oct 31, 2022 at 11:09 AM Chester Lin <clin@suse.com> wrote:
> 
> > Add DT schema for the pinctrl driver of NXP S32 SoC family.
> >
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> (...)
> > +  nxp,pins:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      A list of [start, end] pin ID boundaries that correspond to each of
> > +      the register regions reserved.
> 
> That's an interesting approach.
> 
> But what about just hardcoding this into the driver instead?
> 
> If you have the compatible, surely you know these indexes from
> that compatible string?
> 

The nxp,pins property is more like a common language that both kernel and
u-boot can share with. Of course hardcoding indexes can be achieved as well
but that also means the index matrices in both kernel driver and u-boot driver
must be revised and synchronized if new boards may have different reg and
nxp,pins. IMHO, having these ID ranges in DT could be more intuitive, developers
can easily compare every pair with the corresponding reg entry in the same dts
file since reg maps are fragmented as I mentioned in Rob's code review[1].
Based on this approach, both kernel driver and u-boot driver can reuse the
same parser to acquire pin ID ranges from different boards, which can also
simplify codes and have less patches in the future.

Regards,
Chester

[1] https://lkml.org/lkml/2022/11/9/722

> Yours,
> Linus Walleij
