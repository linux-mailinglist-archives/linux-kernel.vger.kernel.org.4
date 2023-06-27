Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037873FF47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjF0PHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjF0PHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:07:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2122.outbound.protection.outlook.com [40.107.100.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D145D10CC;
        Tue, 27 Jun 2023 08:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb9aNd1Aa35anCDc2oYN3JxSZ2sYyfMnAZv2t7BqrmINSal0SujELkANjBAmKzXo9zxplo5oNVyLrtnnpDND5Sldnh605eK2ztoTPchKJTrGqgWbdvW9APtlGD2ijzNt1tU3+h5zoVz7z+XpyF0WlG/MTNI1066vnwky3wVFnpimM/tQ6914v5lEHIlVeMqLFp2ZvwC52XQZ/nxRmTa9M8vjrcHuzbXlmsOIelB3eC9vOrfMPFaoffDblqZPodkx9scmeVXYg+AeWPcaRd/UsAvwFfucBb2lqUzK64PF3sKrrUZwtU+y6UtUmzl/vZ/2C695FHlIJzYhzM3Mcn67fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+1qe0X6xhIi99U3XjMQiz/cFaTpnYN/g+obkeBX890=;
 b=FNgvQZLZZMdQ8XccqyiB9Qwpw9Jeehu/qJu5Ep2HTDbfMEjGJZJpt04Y4bJ8sGbBNpsqcosSfe3UVgITFUHt6/EqpjsOw5brCVUhefNW3xge0gJ1Rs5QtUUJt9cfTTLKJVB/4skSvrx+4QzP2+2oPr7gE7f5wLG/WfprmY5yzflyZm1yjjbJzZVr4FAhW11WAl+W90Xnfq49L+M//BHfehdGZq/1c+Vy7oypoFrKxQyHXQx/Kc3JTs9N4newKLkSuAfBiK7Oq9/3hrqlPRizAXftVAZpRMiVqVffmA2HA+Hyn2OSh0XWU1uOa0seMG+q0J/jRXJbBx4eOaemQdiPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+1qe0X6xhIi99U3XjMQiz/cFaTpnYN/g+obkeBX890=;
 b=wHgefD++2QAk96whSu6KPBVroPixESR0/05dLi0tD4JO/Lj9Xp9FDDtk6DapdO/3EGtz9J7QI2yfxi756CT1nqM5cXTk+x6PeKhv/COdnrv1UquS1859VA6Y5ue96pGDPZwirUpSHMubmaNov6mmHBERNKrTrv7UdkeFw/97GdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV3PR13MB6500.namprd13.prod.outlook.com (2603:10b6:408:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 15:07:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 15:07:11 +0000
Date:   Tue, 27 Jun 2023 17:07:04 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 2/2] net: dsa: tag_sja1105: always prefer source
 port information from INCL_SRCPT
Message-ID: <ZJr7GFi02CuQaY4b@corigine.com>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
 <20230627094207.3385231-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627094207.3385231-3-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0PR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::46) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV3PR13MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff9a4e4-e867-486a-922b-08db77202eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpClhyCE1rNN4CmHScEcb2I+t0rNaQ8XlT5Nhqd3W0k3A6ARaRLD05dyPz5uGZQnkRaXTjXZB+ivJUtwi5a4LCChh5ATAibIxwdmRv7kLc6la4U2CbyF17bpgBm+9DH4yRRTaowEQclcPDuOXxnDn4kqgW/u6VOl2e3CTgbooL1mzT2090JzTVvXDZTWezzrsdVS3jJdDooWY/pFve42rJi6N1ftt1RE8MfHC0a/xYUhyVokpkMySNdyalz6UT6KsndgDG1M+PwVE6cz3sxH7imFxpFTZBuucGdlXxP4U1KIiaK3aTzhOSwV9I/PNtAk6/rLkXbAtJKPlMa3K5J8cnYVK1WrNolG5LYccx41McdJdEAFS1Etws5XJ95eMsWqwxJ5sLn0+qI96MmvUo380xWiyw1XLbNXIBNJ0vxooaOy8iH1o7Pmv/WsKKRqt00fJ6GnqVv9PKmTfjmv3v2Un5/E3jBwlcNMga0xVgoYTL8woU10aRAADyiyPCji2u1XfpSipRxLFrm50WCBuqOXKaSCnT74aI/ZThZAeBibWVhOTTJw2KIglj9G255sbd7Vo02U/PiHd7uv8uJAhdnpOXNDkRQZdYQgAUNQ4Z68UMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(366004)(136003)(376002)(396003)(451199021)(38100700002)(86362001)(6506007)(5660300002)(6512007)(66476007)(66556008)(66946007)(44832011)(2616005)(186003)(6916009)(478600001)(2906002)(8676002)(54906003)(4326008)(316002)(6666004)(8936002)(6486002)(41300700001)(83380400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MIs3795WGCRu4Mto4nHYksZQrxQyx3j6wfIjrKHBEaURrZfh9ANnQxif0Fp5?=
 =?us-ascii?Q?W2DLQR15HvNWkOn95e/uvpjrKCNFoNqDh/p5oy31NU7lOcP6ZEwe2N90w7T4?=
 =?us-ascii?Q?wCIVxFH4A8FHfZJ7skRtKfXChHpyTK6Iq55GeSMuu7MA0dWy7ugwvp0iEHVu?=
 =?us-ascii?Q?2uADP2VgMjqabtej9TranS/K6h30GEcVS2pLE/llMjjWayDsIfYAZCy8BUde?=
 =?us-ascii?Q?XnTY/I+YSjgMHAywkB75JcFfbWCSDCi07QU8eO+ObgdgWCXogWONg7JhE0TJ?=
 =?us-ascii?Q?xk4ET9NzCDpOOzldpVl2ga2N07JZmjo7X+3beowhMW/EAkN6Ne/nPAqRxsH8?=
 =?us-ascii?Q?qxH15Xp2ePyvvWGo0PIoGKMkvQouH7I45+wxhYqU/JfeeUU4UK04cT6H8px+?=
 =?us-ascii?Q?242SWbTqeecUmFFM7/AX8lGj5A/8jj4GpAhIPqGAUXQuqgy9WlZOdh8G0I1l?=
 =?us-ascii?Q?7PdU9RuoYrK2akB0hP9P52gbQsMZyzzNrUxZ8AU7cyXvG7b6v5bp/vD8wUcv?=
 =?us-ascii?Q?y6toNM5E+hTKSQO+9STdQ/UBgU0SIE3lAK3gFKKOAONV9LnnzBtpvnb6faXs?=
 =?us-ascii?Q?5QWYhrXVkfUpk83AkSOuthL6rXJXJ59WcigsQ3VDUZ0/YOEyjnztw3tq8OSb?=
 =?us-ascii?Q?dwWgbi/uSgEYcBi4uUXJddr/P92PbHtjou+1pdnZ+2FfecPwMn3B3fyvPwPc?=
 =?us-ascii?Q?nmRcH05SxhmgPVMVCemAp6YmDriGl+uDWEdrflbicAH4E+EKMll5B6hYjlfJ?=
 =?us-ascii?Q?weWIxgYlhQ015F/TM7vF6SZ6LDLDXBrxEmfiwu1izMwJqFoesNVcHd/pu1s/?=
 =?us-ascii?Q?b30R6rBD+Knszr6u+TTNaphXmYgqZmFtfuqoDUgJXIUpl0vl1VNbQOMgte2M?=
 =?us-ascii?Q?K+4rv+e3B7gWx7Uhn8feiS6mMjQoeEydI0sYTu9FyjpOQCfomu0B1LpbQALM?=
 =?us-ascii?Q?0rFI4QlPDiw37ca7U4iNa8BAxvWwalVD8DIwdKqvySO9xebEB46nWPonRgVc?=
 =?us-ascii?Q?QBsa5aBWhzId2wNVTelvGG7laS7NhLaAItCtiuVOG1TOcw7NF4pLZAE9X1+m?=
 =?us-ascii?Q?TNoIDT+ZsGpHFV9gDcRI1qRv7EGi+lOxo49OIJ8YFJj2HAfd15gIH+R0YOO3?=
 =?us-ascii?Q?JWx+IAb9Eqi6GU2zIR9abtchO2E5Zir7qzzkdeuV35IYzLgi6XkeponJL+hs?=
 =?us-ascii?Q?CZP6jPotpvt5B73KeNKlR62srE5xyWL1lHjmDUrMl374yQR7areobNoFRAqO?=
 =?us-ascii?Q?n46z/XoMKVn6GT0pRwyWA1zJqMgZKJrHv+Rxp8xQRAm/5wTOToKkFuHC/d0L?=
 =?us-ascii?Q?lKHroZVW61pwufTLfc0vqUkw6NwjRm1xfW9R7NN/lSzDbyadOZqZtssdB5hX?=
 =?us-ascii?Q?jsVk4KjRJu8kEl/sGsoMLOzpqXR/sQeLPYq+vWGLY0uPW/6lrnsx11tFhyXV?=
 =?us-ascii?Q?QO7EpVsQf6hZSnq6kYhCDrrYeS95Kk5gb1uo/V6CBtdkq2lISOrWSENK4HmY?=
 =?us-ascii?Q?rwL1tOzQ5ZWrGan10WmcphHnnDc7LT3+2uX970Iso21MQUvDUkXXBauGAg5/?=
 =?us-ascii?Q?lYBYyRUG/zlgtHDr1nv0wZhLV9DnT74GOgyJ1YnG/bXS+19ztDJDf44rRC54?=
 =?us-ascii?Q?wdsX4tvnj4EPR2e4q+ny+OS2B508xwToC4OXdFt8cQfylL3Z5TY+4wg07C63?=
 =?us-ascii?Q?p92XRw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff9a4e4-e867-486a-922b-08db77202eb7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 15:07:11.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANMwCOwchEfNvc4iUDqYh3ED6kV2AoPg1rspRBmKSc1Dc7KKGwI7dfJW1rIHdw7Z6zvp2eC+ES1qcgKwixDPzdwZ/6V/4kJ5f1LinMAjHJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6500
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:42:07PM +0300, Vladimir Oltean wrote:
> Currently the sja1105 tagging protocol prefers using the source port
> information from the VLAN header if that is available, falling back to
> the INCL_SRCPT option if it isn't. The VLAN header is available for all
> frames except for META frames initiated by the switch (containing RX
> timestamps), and thus, the "if (is_link_local)" branch is practically
> dead.
> 
> The tag_8021q source port identification has become more loose
> ("imprecise") and will report a plausible rather than exact bridge port,
> when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
> traffic always needs to know the precise source port. With incorrect
> source port reporting, for example PTP traffic over 2 bridged ports will
> all be seen on sockets opened on the first such port, which is incorrect.
> 
> Now that the tagging protocol has been changed to make link-local frames
> always contain source port information, we can reverse the order of the
> checks so that we always give precedence to that information (which is
> always precise) in lieu of the tag_8021q VID which is only precise for a
> standalone port.
> 
> Fixes: d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based on the VBID")
> Fixes: 91495f21fcec ("net: dsa: tag_8021q: replace the SVL bridging with VLAN-unaware IVL bridging")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: protect against malformed input packets ("vid" variable may be
> uninitialized)

Reviewed-by: Simon Horman <simon.horman@corigine.com>
