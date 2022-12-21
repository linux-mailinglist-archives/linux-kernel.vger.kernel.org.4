Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6365320D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLUNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:52:44 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B42098D;
        Wed, 21 Dec 2022 05:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gha2nlP/U6w/YWr4ITW+PSU0phObrto371f3LSjKXRn+yeVLS06xuqjCSuKfk4HOKNU7hVnv4V+f9PtCLiVlWuUzTe/grlYMQ/tRfmJEj/dUZuvW6ium/BGlARh8ITldTNM1sSEmPfozl4608GQ0PPQcZogtJLPoY0IkVODPYj56qN7hBjODHMGjoa5+7TWD7IcXuIP98yq229i75WZvEnB4a9SqisppaBFd4mBB2StVoKdZThK/PfJmQaXWLIOqoxwbrsE3PYKCqPIrVcNxZ2uUr4+Pdl96FqFfrnpzp90frVLri/gDdoh4KYzQ0ktfCGI87bZTTp1f433S0tWMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvy3JSaaRgDLwJxVoYMmsmT7sIo43tf71LK+9gqv70s=;
 b=KwYjO5UJrtf1RZvMGuQ+Kp3Ap+CzY5x+bMQyeizGIbCIjEBcnmXU84vO1r/1ufZcuAtkXuesJTtXlHHAvV0dlasJbU+nR7e6RS+W2EMMQGTwfSeU1nZiH3D+t9MODEjxHpS2d/BK9c1ms5KWCHNq/A+KVj41W+boeJ0U/DSyCrVhGIT4Zpzy5FpRCR9VXXNQOXaAXnb8DXUsERTdxqESdlEc2oz2HQsu2CNWKZ9C7M2IJNoT4PRVtVt6Llq7ib7+fKvRfz1quxDgSUi7pHAW0yOu2TzPjG3VPvvzkjRIIi5A8GYjv6893rKy5DpknPZELN5xI7AMHw6bFg/uNZdvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvy3JSaaRgDLwJxVoYMmsmT7sIo43tf71LK+9gqv70s=;
 b=EZFwx/ec7pBzEUcYumHZnkkPyClhqcUTUhqgnJY2uicIb9E1nDFXYy45xWHaihT862KDQARgAK7cahJAkS4pyKMw7M6fc5xzPfwMU5nG+kNa9S2di6WA/OttlLQI96OuxsJ1zNTZhlBNBy8MgFLqFq9CBhCN4LWEMhxo43c3ai5fN2LH+f1YKYTZ2OeL65j44leNPt2Y0fOADp8zBo/xlDHKJrxP4kC286gIxLddCtkhKRlUrFD1/X1X+KY0EsxbkAiyiYc/Nm1dtAng5c2dzw2MjJY9P022UJ0ilZMCUJavN33muSPQO1tOtT/ZiySnLObYny0ac/2urztFtH45YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7542.eurprd04.prod.outlook.com (2603:10a6:20b:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 21 Dec
 2022 13:52:39 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 13:52:39 +0000
Date:   Wed, 21 Dec 2022 21:52:28 +0800
From:   Chester Lin <clin@suse.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <Y6MPnJ27IKFiNltl@linux-8mug>
References: <20221221073232.21888-1-clin@suse.com>
 <20221221073232.21888-2-clin@suse.com>
 <AM9PR04MB8487286EC9EE4AE3F2FD382CE3EB9@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <5c0e7f2f-94e1-c6d4-d848-f90e29eead10@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0e7f2f-94e1-c6d4-d848-f90e29eead10@linaro.org>
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a13cb59-2fe9-4676-b03c-08dae35a9fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NfxUDjJQrPrRrYxxgyNwae3rQt+Nhdj/u7Vv8a4zUrgtzFfP4gpCMQf599kuSKzMDV3pi+RGtI/iRi5a6iFb8y+Fp9hZSOpj9+X6A2sxHDMY28D+HF73ficAnRV8XKfZUL5Ew9VejbeYxpTE1vUcqc6M7kJbFtjEs4ntSewhOACOrqA/8OItTTh3NkXK5jv+nUlSQQXLf9YkAPrNh2Mgou+RBnkP471kMqku0ClpJ/KZqNeMsKXAJ3LfEJxwDQoVJJu3TFk8nNgx8KCwF1y8eFxxppPA9VPrZhQ+yJgrHVeyj7SEjgUQeP1dVZrPQo12qF/1QP/OKvaQni44K7qGmvY3Hhp3sZSL6gCkg5wvRz/wxlmjN47L8B/YbEgduTjTGKhxIC4OlMaDHMmzcU1+pebfw9OGr1uJmgFHermyr9PF8oTwHZs4ecL3csUUa2Ps0qIidgKQls+Y3lOVQhjYkXm4Yfh9L2JpK/ik9cgiXLyhogbleEl9rRqVjw89ohjWrhD7LdsKYFZJ0sdcIreTlouRxZdaTw4IB9Qne68EARWPECjjNZp8Kgr129Q+p8wX+WL5+GIvnGNu7vwg2u/J7X0CQgtENA3Zkc1aNoB1z92tvlbCRBxypTfqL9cJ6boPd7+ncNCSUtocpPr+raKxbVuextYVVjFfFKO7tlEOzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(38100700002)(2906002)(33716001)(6506007)(4744005)(7416002)(8936002)(5660300002)(41300700001)(66476007)(66946007)(66556008)(4326008)(8676002)(316002)(54906003)(6512007)(26005)(186003)(53546011)(9686003)(107886003)(6666004)(6916009)(6486002)(966005)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCaXkKQahmWfhMI+92R4QKWFRZWZZSBn56dXmAw8e3FwFjAjkD/aiSOfteK7?=
 =?us-ascii?Q?BBkFp1KL/g8HzDip59wqwACi3+3Klkocaq8ddX7GEjYbq5RYUQEpZdfiSGke?=
 =?us-ascii?Q?Wbv42u+i4awirSKdz3pdZ+R0uWdcxCnT2TdZoaMgaOa6ln1/grPyfz2iFTij?=
 =?us-ascii?Q?Mm41eaNOFx+INQqPCQZ/RszgCruT9mh6DY2PsVmL1I6XAybH84P6lv9Dcg0d?=
 =?us-ascii?Q?6lPP9Ytyf787uOrZhkNqGDPJyGdkwMGBiI8GV27t+7gQsxWw9Knf+TcS2FbY?=
 =?us-ascii?Q?ocMQ5ser5rY/oIFL5e+c+y+1Jw10Bhw5PvK6mRKLXSF5fnF9jBiuksT8BO4r?=
 =?us-ascii?Q?4qYiaFVV9Fv51UNFdCNgloJiebrXYeCYcPTKqLNglOb7W/4UU3B1alZUTKEk?=
 =?us-ascii?Q?/QdxljRxk4a6BNopCs0KYxMXNbzEm8JqXcqOHawe6d+UgJn37Zw4oPzqaJA9?=
 =?us-ascii?Q?URGFULWXuWsiZMk+gxQt6zKBFr+rU3NgaO0ibN1PUfPcI8OIrWvpUoGjOqw2?=
 =?us-ascii?Q?EE5J8W6vIyhkNr4vJJ/H0ZadpikBESWHOqDJrAOdzPI0u7f3+FpFAPFYRPhy?=
 =?us-ascii?Q?FrAf/LvZxRkmCUfNzBRNranLl4wSbhe2x0QDAkQKaBkWqexLaWbISsAKIpiB?=
 =?us-ascii?Q?eHL6WLG6r1+ik5uOzdJ4E7FJMcTbC4su1hgx1vYj8PdkXogVqgbZqYGD/r6L?=
 =?us-ascii?Q?z/465Xs5dVYTSBvUCsWnHSIwpXDb/jg8o8cvVZ6hEgbQgAonJgRrsq3VNndT?=
 =?us-ascii?Q?AJ62cGf6gaaHGXTdtEbXGajdSX8RLxYCVa1Nkx+f6Sgcj6EsYWR/HohlqQED?=
 =?us-ascii?Q?kcfstO+8YXg1nLGXsrnuXDJWtIUgwUZONBjDjGAH7QhQTXMt5+rKarnBfzd4?=
 =?us-ascii?Q?Mxcqr7MHVgcJQDcXVcVKZoNL1jtLfIBzePPjGAWHWHZCq5fUERJx9B1ha2gK?=
 =?us-ascii?Q?znJzC5MUcXG4DmEKvcVYq4QqpwrwJb0TeAPLxzyhbhNunHXHAihueiwFTib+?=
 =?us-ascii?Q?VFRr1w7m64KykqiCh8C/DoTyqbH67eClqUtzBfEz4Y+w7imFJQ7c4SrlVw6J?=
 =?us-ascii?Q?ajhgvKynUFCrBJrEET2WYofUSN8cSN3awta+3R8tilk19Rg5q+jb+cBnETOs?=
 =?us-ascii?Q?gkj0DIN9Z/twkY6eB7HwC4kDsi7X48S25o3ik53jtTbhvOBK3YdZJvACs3c/?=
 =?us-ascii?Q?h59qTNQBSHmCoWMno/bvtDinEgSiY1oAFzNFZZtVAfnukctPdF4wC5GclZma?=
 =?us-ascii?Q?lZQObmGIe23mLFTHpMCc8nyJmTmEsrZ3n1bgGr3pHU99bwrzbFtYFMAg2tg4?=
 =?us-ascii?Q?P61HCSfnL4+vPn0Ur0ftqK1YDBnHtvm2LLtGlmVFpczF6yTES/xMt9OghIbl?=
 =?us-ascii?Q?GAqzZNGzVCYbxnMJoDr6CYIiKWfrRcVqCgfGAYpvOzJl4/bSokT9M8Jyw2HV?=
 =?us-ascii?Q?GT7+9wEZ38d0dyYsmgNUjiI/aba9T1gWwx/gJx/qgLQGR6iToPP7xwZIUtEx?=
 =?us-ascii?Q?rF6uAOKC0XkDpMuNoab5fcdug7MlrwWzVuJGEc8k5k/jaR2PYqIXWn1m7Lc4?=
 =?us-ascii?Q?chyBPh9rxv7hDT0NEKQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a13cb59-2fe9-4676-b03c-08dae35a9fae
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 13:52:39.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eeP3HInNqrBKiCGy36GMZ+WLujcpkEs+l44GoK/DNBVelAZKN4i9StCOdgquj05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7542
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Andrei,

Thanks for reviewing this patch!

On Wed, Dec 21, 2022 at 01:30:12PM +0100, Krzysztof Kozlowski wrote:
> On 21/12/2022 13:28, Andrei Stefanescu wrote:
> > Hi Chester,
> > 
> >> +patternProperties:
> >> +  '-pins$':
> > 
> > Sorry, I missed this in the previous versions. Could you change it to '_pins' (underscore)? In our .dts files we use underscore in the names for pinctrl configuration nodes e.g. i2c4_pins, usbotg_pins.
> 
> You cannot have underscores as node names, so what do you mean here? You

Krzysztof is right, and Rob also reminded me in his comments in v1:

https://lore.kernel.org/linux-arm-kernel/20221102154903.GA3726664-robh@kernel.org/

Regards,
Chester

> need to fix your DTS not introduce bad practices to mainline kernel.
> 
> Best regards,
> Krzysztof
> 
