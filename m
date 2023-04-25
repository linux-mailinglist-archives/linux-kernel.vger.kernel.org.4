Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE036EE537
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjDYQDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbjDYQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:03:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9711BD;
        Tue, 25 Apr 2023 09:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqooh3oQHSgBvHItU1bVJz4lH/Syhb8RudbfQ9eotw7kvkThN7HL/0WQyZN5lmJgJGBXqUDI9MmNCEfyZl92JIsrmEVXXQKtON4V7Hojh+NXtYTciRpmdz7+SPF5v3W6mb0hv6Neem7v7ZeRgt8TnN0wfIxS5XMUPYs/aPzNX8Kp+dmiQtTh5uGciFddYW89upLi4Geb2jiPYCqBY1WK/YMKJOg1QUwI/1Zu+GwHuRJ4v85Y7+hMkFQWCVpLSQOjDSgKBpb8PQ2Rcem+R1czne2Q8YQq/MtccD1o2HY05DTLrycpzRRQ+imnLsdg0XIxZ16LJ6hy3sbsAZJS8f0fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxkqnhPZkOueppw9LQU5lI4g+XOpHp+0CYzyiuDgluo=;
 b=Fu24b/tVnoDJXlu3BbAt4y2ORaHKVWqiH2OOtUQ2Al8v1fXyP20Mnwmhf5fh2kqQrTNzsPnwclZBCh9Dj2pgy3rXuY2Tf8KSO9gzTA78rUaIe28emuK69+htjSMhClUrrE4w7ojactANtmU0wVIeuAAit0mVYBBkUTMUxxcCE0IwABGnimwOA7Xb04Hq+hZVDL0u80/kuirvbVsvN7DxDSL/42RJEOqJBd6z//NAlhNCjS5GSN216giMLgObU+DWC4EGuMgvXGg/27mSDqCdGqFwA31ZwvWjkjJ2lJWJcBT9dUr1VFtZxN9KSdiqUK0/TGNT8Qxv0RpVSvV4KFiyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxkqnhPZkOueppw9LQU5lI4g+XOpHp+0CYzyiuDgluo=;
 b=r5G9bTzeSSTinKr/bsMBmVnepkpDo30i/iLeNtwMKSJW0kXoyrhTeq7KEDmAYZiGINqJJLQPNfHFeOfvjSH3KaYyzHMzzLw9fTgXNAMoSQnGMZvcTTjEZBXbymVSes22tWs5AgSqFY/XKxo2klvvk2w025nW1bJUFVi8RlXyh+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB7522.namprd08.prod.outlook.com
 (2603:10b6:610:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:02:58 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 16:02:58 +0000
Date:   Tue, 25 Apr 2023 11:02:53 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <ZEf5rfzs22HtQivB@nixie71>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de>
X-ClientProxiedBy: SA9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:20::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH0PR08MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d2c1f3-df9d-4517-2c37-08db45a689d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elZwV5Z0fPGpS2JFXFIDi31WHwsVFqZCd75W5b2aoVX49LH/VANy356WYrSjlTNXl1iOritt2eXFfhNw+B0byHO97ZaC8syXtI1b30Peq2qoNobEjmZZK4cL4b18mxFYlPWU+0FKJky6mSTjcLn0EhyJJxi06bLBSeZbyMn/yVVeIwHO1rt/wTzx9G1rznqSRrgBExkCC3hE73zyCnMb5HJaOR8h6xoZbINsS/JDV7UshHkjFQAP9asWFr0yTqs9LfWsPTI6h2SJ6G8eUpswYegMl9cKHZgIrabC0QZhQ+O09Hn1IUv6cirT47vTV7ygdqkuRbf9Bs+fjJnG1h0XyApTFcRAfKQoQ/zmlIIC5wVClctZNoAkY+NSfaaKXgu+HNCwh6o+9qMWnB0n7WsOt1sEi7HZqbLz2W+4JZx2j1B3lTJsND8kNvV70v3GB7ftc7rKpORs06qtpcP7zoiqKg6xd2TvSVGl8kuIvE6bK0EYfCp5yrQ0HV6TvUDniuoiVt/3s6Ac403L7idBAgxjnPSRXVZHW2ejOVpKPCF9iBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(39830400003)(346002)(396003)(366004)(451199021)(966005)(6486002)(2906002)(6512007)(6506007)(6666004)(9686003)(186003)(66946007)(66476007)(8936002)(8676002)(66556008)(41300700001)(6916009)(4326008)(316002)(26005)(478600001)(7416002)(5660300002)(54906003)(38100700002)(33716001)(86362001)(83380400001)(66574015)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n/9c614YdgJgVLiu8rYPNEX2I0S4k+d9gGSK34Ys31pq6orfWB0caEOKeQ?=
 =?iso-8859-1?Q?CNfszY2lUFqrwh49I38flUJdhTVDF75vWrPU7Ie5RFDYjir6/jTQ9DL1wJ?=
 =?iso-8859-1?Q?XQxnYPedCNm/jVkodZwdQak6mMdrTF7Iu+Zw4hRcG78zV9KF44Sv4hUB6l?=
 =?iso-8859-1?Q?anzVh8GDe8SAxku45RDJCkRC7ZzFywLuAqMCGBcvIMfQGtyiobPFEgyvnP?=
 =?iso-8859-1?Q?/noDnPjyTor6YgxhbC0DmZBykmdcAS4OXqhLGXRBPYseb8Yvke9bu53kiH?=
 =?iso-8859-1?Q?WkYtZKwvNboXBM9+IuQDyRowq81m+99jhYm9GNyWNeU805dP1pbC7BaE5I?=
 =?iso-8859-1?Q?6rGSGG2ZQYkrghpN+4cCYc4bE93jAOkNNy/y1+3IDlIrGYfkePK/M5mdMs?=
 =?iso-8859-1?Q?74k8ElrpAftNs0HBbl2x125zwxezGTkSqZRig/A334q/mse8+S7A6oo802?=
 =?iso-8859-1?Q?YT8Q6E/rUJvagxQtEbeffV1rCg9+5bEwQYtemCOSo/3qicome8lW/+1KAa?=
 =?iso-8859-1?Q?s4AT5BSBy5sJmUTyWiZxc3NC7FxE8iL56Mq7iw9itU6xGa4IIR5VjnJuaw?=
 =?iso-8859-1?Q?dpD++jZYbJo/cF0eKiFjkmnrc56QOqdJ32pHCmYRu1N65HV+YAS6D5cXUZ?=
 =?iso-8859-1?Q?P/ecehgpP0snnqxC60XpjwosnpxqY5m4YBtHaoNwXE5F5d55+oqx2e/PAi?=
 =?iso-8859-1?Q?vjp5Q3l4lJDHq6HwjVaDMlkAnfJMATp0u1Q0pgmde9jbiTE6JzkdtCoFBD?=
 =?iso-8859-1?Q?YwrLTg8e1G+ibCdGesinpNo9jPwpORH6eIGNVIQSEDj/G98YnfYkix3e38?=
 =?iso-8859-1?Q?iiBQfF0YhvcnqOkAD9s2YjeGOv9NbZmO+f5VtFz5z/UVMyRt0YhJzDTbs9?=
 =?iso-8859-1?Q?68z3mWUupNQXGm4Xfc9JmSgtB3/0DXckDml63hZJkpAHzYRTXi2Mj6Lfsm?=
 =?iso-8859-1?Q?CaMzEm5nMQccsXat30gAu9iTpj9AwJOR13KS2f2Pf/FOnWIoVZPKCOYf2o?=
 =?iso-8859-1?Q?RR7mYNm3+S1FbHaUvja8v+QS3JbyTMji/CrWrJmtqzSvnrq8a/Ax031929?=
 =?iso-8859-1?Q?jiwNpIwvJaBuMNATr3vjE6cG0kmcZkdmXGt5fZ5HWZaRW3wao6hAN6JgXa?=
 =?iso-8859-1?Q?wSFGxM2OKVXvbVBrxzcrRRwOh+HKRzvbubrTF6QpZzZxxKH3U5uqTVW5cr?=
 =?iso-8859-1?Q?xMt9nM+KderNrbzGPAaIBntfKYXCSM43LzSVoKYs1g7EPC+FdzTVEBNa0j?=
 =?iso-8859-1?Q?xPMovwk9BUkJMFASy4DtT3G6XGhS0LfkXbobfmpl+E5KZHV0Mn6PrkO/UB?=
 =?iso-8859-1?Q?WQ4ytq/J4HDuiZu4PWiEzc7LOxp3DH+WBM4YJ53YTkBlrE4B+xvm7y94RL?=
 =?iso-8859-1?Q?gBwZKO61Bs3awtxhzcSumyIqUOn8yp4i+kV2AQEmuhp3CNbTDBhAiRrFU0?=
 =?iso-8859-1?Q?3mjnW3kytcXfiw8HZMGVADVDcYhvsIic09IcU8nmY8pZD562aL6ZGbuDa5?=
 =?iso-8859-1?Q?JY1rvazQGrOmnRuT5BVISMsqVjQOIuFXsI1jUQDFRe43tAUZs0xqhkIOWH?=
 =?iso-8859-1?Q?B+9pVNh5XIA5Fw5uuXEwiLwe22Pny2Ff1d5o+jEOFc2gP4vNXWD1y0BqpA?=
 =?iso-8859-1?Q?fX99vxa1cuc5Te0fCy8oS4eeRus2eN6YnI?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d2c1f3-df9d-4517-2c37-08db45a689d8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:02:58.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzrXy/eOxLYO54cQzWu1nxxebHug+75+hD0FlvhScSvUqAl4tkT+vYa7/tjJtOt06C0ZM/UCqHh3z9GxOmH4+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB7522
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Apr 25, 2023 at 05:29:39PM +0200, Thomas Weißschuh wrote:
> Hi Javier,
> 
> On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
> > Some touchscreens are shipped with a physical layer on top of them where
> > a number of buttons and a resized touchscreen surface might be available.
> > 
> > In order to generate proper key events by overlay buttons and adjust the
> > touch events to a clipped surface, these patches offer a documented,
> > device-tree-based solution by means of helper functions.
> > An implementation for a specific touchscreen driver is also included.
> > 
> > The functions in ts-virtobj provide a simple workflow to acquire
> > physical objects from the device tree, map them into the device driver
> > structures as virtual objects and generate events according to
> > the object descriptions.
> > 
> > This solution has been tested with a JT240MHQS-E3 display, which uses
> > the st1624 as a touchscreen and provides two overly buttons and a frame
> > that clips its effective surface.
> 
> There are quite a few of notebooks from Asus that feature a printed
> numpad on their touchpad [0]. The mapping from the touch events to the
> numpad events needs to happen in software.

That example seems a kind of fringe use-case in my opinion; I think the
gap filled by this RFC is the case where a touchscreen has a printed
overlay with a key that represents a fixed function.

One problem I do see here is something like libinput or multitouch taking
hold of the input device, and swallowing the key presses because it sees
the device as a touchscreen and is not interested in these keys.

Therefore, my first impression is that the virtual keypad may be better
served by registering its own input device.

Great work by the way, Javier!

> 
> Do you think your solution is general enough to also support this
> usecase?
> 
> The differences I see are
> * not device-tree based
> * touchpads instead of touchscreens
> 
> > [..]
> 
> [0] https://unix.stackexchange.com/q/494400

Kind regards,
Jeff LaBundy
