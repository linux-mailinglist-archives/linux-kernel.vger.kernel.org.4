Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB35B78B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiIMRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiIMRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:47:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421D2679;
        Tue, 13 Sep 2022 09:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEd/myrM+QkCUuK+lu0zz+v/r5rN7HzLWsC6+2WSYHXUo6I+77A2O+yX5qf1JEDIBBsS/84BYHPs/04CY8iImcMWmT6S5kUcHpW+EiICr5PblVZradAvr7U9f0ZhduzdsSL2RWBoAvDcn473PyF54BzfevTFxKVHshEZ/rowocJk4SzYK+x0nzAKXOQwKzzdELXZteVQO1VVwipeLvu+L6CCqMVyIRcbvJ0+Fp3+/8A8FfccRNqtw0gU4siOfxKHYqqbYMfoIuRM585CK4qNFukGap2LzLdMwbGpzr9CtC2jZgHBdkAiea/8vYXclWucVVRYE0m3NjScGUrBlA0BHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0lE7kIVBH0xcMQpqhmRSvQr07U6TKb6gYPfcpeYfrc=;
 b=UzMNC+RIt10X0kSVbGaTHr/dXKO80qJbU+aVnpPYAOc17m6IJ9pzV/Qk5iByJJl2p/yCTiTs3AeckvPYbJMbsBb+oXZUxzo7AmuxWN6htX4oXwIa9oi9IolTxEVfWBUTAC0mF5uHgthrwk8U077rbRvLo8vkVRFyzA4e3BduVyDe8TB3bQAipG4d/SST0xe/uEoiLXdkPscMsyVsPpqkZvky1KO94cuhtOD/oqYl290vvuJRXVNppvAzIfhpS7ss4R+o6YyE9BYdEtXNnXGKxrm4dPPXo/dWyve2pehh6uJ7xCbQ4UwNdonw8GCzDi7wt9539BqjP50tkMP0yT/ezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0lE7kIVBH0xcMQpqhmRSvQr07U6TKb6gYPfcpeYfrc=;
 b=az1v0NbtBUSxjN0bzmHN7GIYV7Um177jJWyJQ5i1dwaurn5fDrORK8pajm0ZOn3jdBpnS/XgLCxpf+tS8Gt+jzOMO78EJxdgiPavcsGV0LXY5fKXp1shpa4xIQGreF7hPn050Jn6j0vp2QmDdHYT89JXgIHS3zTLCAQEqaP5vpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BY5PR10MB4355.namprd10.prod.outlook.com
 (2603:10b6:a03:20a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 16:44:56 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::dcf2:ddbd:b18d:bb49]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::dcf2:ddbd:b18d:bb49%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 16:44:55 +0000
Date:   Tue, 13 Sep 2022 09:44:51 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Message-ID: <YyCzg8Lh0RRsbhTk@colin-ia-desktop>
References: <20220911163715.4036144-1-colin.foster@in-advantage.com>
 <20220911163715.4036144-2-colin.foster@in-advantage.com>
 <YyCyeNq7kxx6C3sE@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyCyeNq7kxx6C3sE@matsya>
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|BY5PR10MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 281cde8d-eb67-4174-e54d-08da95a749ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIny2/uu3T5yLj6aZJCta6UiNgCx8GU+++W5fcdOvEhOr+rU/dzg09TxCvukQM/QKAqO/vRnU/Rr2TT6KXig+mWVaZ9lFyd9axN4DDsCkFMkD5ZccL4yyi8GURiuDqsixgagYnOHxNgUptK3NEcO+ysPGStRfLqwRSSve1Uafchhb7NwRnnkiBubf/l6OU5pYUIZY62ZXwrKu+iFPNcH+CPxWHG+3sntXogXNnKOyr2mTtRBUm0TeYP7iqJ9VrmVTN6mX+xsq7WYubvYPy7lQZ3Q9fkt9soah91sTCRurRpKSQVcGTwp/9nJ81imTNHpeeLctB6TxUrPoaV7zf3aVoBHhcJh0AP0w1oAWCMaaqZ+8vGIXmz4d679LcKMCEuUWbA2xJPS4Cp1C0pfT/Mwe7XGUH0gJysUEhFfHtSMKTNhV7g9WeOUB3FjIrSuiWm+/QZFovq7PaPInGPmgyASz3nzWmDPJf5LPY3MuhDGDAHyWlIJOQD0zHcx+dsjuWEHD3F6rC2WT9+4X8gasyOwi1SHZL1SkLM/02yE9bxuvBFPtVAN9Alw6vT8EZc0SP+LUauc4aeI5ZZOqvklh38Uhbvh1Cj1uwmxN5K/JDr1tkgDzXuW+mVG8HFnohJ4yOydJ6beW8Grd4D1X+BNJ6UTWvUhwRfqja+HvS9Sv5j3/hviCSi/zedwuj6GLcN3E5EdYEhjWXsR+A67CmjoaaIljA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39830400003)(136003)(366004)(396003)(376002)(451199015)(478600001)(66946007)(41300700001)(9686003)(26005)(4326008)(53546011)(2906002)(86362001)(33716001)(186003)(6512007)(6666004)(66476007)(6506007)(7416002)(8676002)(6486002)(54906003)(6916009)(316002)(66556008)(44832011)(8936002)(38100700002)(4744005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XKX/TxY0eSZ7HijFQiP1OwQu8VYXwyV3AX40NCKvKJi/iGHIPyPc2LfzZ32M?=
 =?us-ascii?Q?xnkEe9VX3lFxQT1kJ2BwtLgtXC6v0FuXjidCXk18kIVWGJt3rZjbgQxyQi5P?=
 =?us-ascii?Q?QAUrSZLkg7QHlZKjN8mYq8FwdLL6qLGFT5V+ETo6JxVRtEsO1/7HUYENvJRe?=
 =?us-ascii?Q?r3V5kmAF58pyICueSlObnrUEf65Oq+Elp+3jDJaBtto6uc5dQiOAxdfzSQbP?=
 =?us-ascii?Q?MwRkb0s/Yx/FQHaXSk/zE4xawzqf0ycFswCRxr9er8omkZLC4/nXI8520GiV?=
 =?us-ascii?Q?k5Ht0gK/T7X/Born2XrEqDLpGgQ4cUULwtkg5YXLq7Z5MnjBxjf6Zy8V65Q0?=
 =?us-ascii?Q?Ux4DqOzfRNoUlQMwHv32cPbxkdmrdh0eQ/UzLnjcYhmI7+VPxCpMrUIbu4lY?=
 =?us-ascii?Q?BeP13Hqx0/W2os9W2IlK6DnxxissRnTT/2mpaMKJthFXO7sfjEy/nFdS6WOC?=
 =?us-ascii?Q?ywX99MpdKCuTUylwOsr/2w88as71YskX1ft5rxt0/ekrGYgeFbUuY0rR2N/s?=
 =?us-ascii?Q?9FLv7OpHMmxSqK6oBqpCcD1BhKLOsZU/kHLlCjK7jbMyMcYG/mjpxusFIKBS?=
 =?us-ascii?Q?v19AonpQ60LDshuJTHt2K0aiFTHUyUNKENGcjQ4CYjr3hYWtg4rrhzBDeUB3?=
 =?us-ascii?Q?2AkfVEg7BIifRyDVLGfcRTLkat4TmbegFLDW/hVuBVD36ObpGDp74SoWzfj7?=
 =?us-ascii?Q?4yJOrqSz81NBwWf24ddaqZEaQwKeH6PDU0BFCTF4RxWB5opoET3wQiNsLP3u?=
 =?us-ascii?Q?LeHz0dqGBWmC2HXZPnhV2zfNbSQnIIMujAgeb51l+M1jB6uzDWR2Y3Aj17yy?=
 =?us-ascii?Q?rEsxIbKOwojcVi0jarA5/fUA6xl7r9f3S2ISj0HBWYPvkN5f8atPw2kCcw7F?=
 =?us-ascii?Q?zc6EE/g2EhRcRJ+GxKsNOusTKSE+vd4qX2XdxZYNXmc9d4hwkLv5C+j0hs1A?=
 =?us-ascii?Q?Ym1wSDnjnxULBshiaN4/2HgwpCZBsfg7TejHesriaW/OyKZ/6ZCb8HYRy4K8?=
 =?us-ascii?Q?fktXQMv4fCfVQBv4yNq6eFBDVYHSKls5Gpau5u4Vw6te26nXR2UI44zINBQS?=
 =?us-ascii?Q?S0julzU6krSYrKX6upsygDXtK5EaAmz6fU9xgI9PuO++BhE8hVxG6Q/CBTXP?=
 =?us-ascii?Q?IOYjhv+dCQJ+BNM2bEixWxC/ZMPx/QdlYPgY9nxw9tDkiOgS0gucNsbUHt0q?=
 =?us-ascii?Q?AZm68umafjpMJzVMeRt2QHkizTj7VAt7uUXHgIU2iTRiZM726oEB/7n46DzN?=
 =?us-ascii?Q?RMUPL2YdgO1U/KUoRHWI+4yTresPTJNpIMdlJxbMsNlHO21cg3CEsy/uNV7P?=
 =?us-ascii?Q?wFHCzBCbrSn30500UNDsMfalQT3bZFT3292bV0r9KJFETFJWLHtpxiWMlQ4C?=
 =?us-ascii?Q?YGwkkRwxUqJL3NhqrcNobcc16LYnze0I8mxp2Q16AhN5AyddFt3Fs0eq2Qo6?=
 =?us-ascii?Q?paHDnAZAuLvSPugvxbVcrHPo0C7XXuYNdLgA3pXR3LZ8lxNNC7tvqvyP0mDb?=
 =?us-ascii?Q?kfbHNYvfOzK7fOlBsXAd8SaeM/SqmOBCMGG56WxlT2moLK/cfZn4vR1oYHkL?=
 =?us-ascii?Q?2Y+9i9hRys0LUgyFmnmLSUKsbfwajrZ11J0bQ3SOIIvmqJFRlKHT1eLNBC4K?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281cde8d-eb67-4174-e54d-08da95a749ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 16:44:55.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUHczh+fj2FirumAdMwk82pxCkD4GSgJwdi2Zq14drdttH3EKW4861OOEaa9FA+KYE8VsWJOrXLUrd9t0sbQ91QC8/GrR3A+3wTYy6Ia4fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:10:24PM +0530, Vinod Koul wrote:
> On 11-09-22, 09:37, Colin Foster wrote:
> > Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> > 
> > Additionally, add the file to MAINTAINERS since the original file didn't
> > exist.
> 
> Applied, thanks

Hi Vinod,

I'll be adding to this document in an upcoming net-next patch set. What
would I need from you so that I can ask the netdev maintainers to bring
this in?

Thanks, and thanks Vladimir for getting this done so quickly!

> 
> -- 
> ~Vinod
