Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7547F744AF4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGATi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGATiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 15:38:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E36199B;
        Sat,  1 Jul 2023 12:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGuWdRzbWSHFEd5uCLWQJPh4/eKnCXxCL/J6fCvMqLNEj0Mq//iKql6llm2YpRGG2rU5KttTw24BxrGLdz/l6bdiri1/GYO+43pqARAI2nj9zdeH3fPSKL/z9H0TYARqhaAzCNZS5E+gYc1VePTnuYVnvCnltyA2ubH+r2yEmAs7mNDdy9wCBoJ4NlK2u6YksdBmjOixkRy8/6uPiDbWTNFe5HYhpxrBye+3j+S1Mk4jWp4JoivKDKcipTVktUzT4FQnRPOiXE9xzWeORBVxS2S3D54M6al2wgw/vZyMbWVK9WoKc0oGGR/RDdXQ6ZiIrnREeJ8p+9+Q3ePo0B/mhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWLPc02dvV0Q9UAmyL5XaibXG5cOE5p6aoUfyv1eigM=;
 b=UaSwYhOtDORNpBTc74IeCjmA/1vzxneZuZW3to2bL8dvQ6P6hLA6667t7y17Y77Q52eQpffm8i+nu+8B1oLQOJp2H6eXE0XZJzBABwCq5+nX+EZ8m6w8YgDBMMajQ0yydMdXj9F6xRWy0VLU9y5X4yxEyX5i0Zu2H9xMnQC86XUA8breBdaFp3Q9RK76FdcM5QwJjK0Ti24lWLU27edWEv/E1ziYZl3PD/eMIS+jb02BGehwTSim343950N0tf0zkTjartCtrU9AhVokKH4BM+hiQNqjyGUSmei716teX80eFBpM3KN7q7a43go4z7vTeqE7KLBvzyRD60xgbniCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWLPc02dvV0Q9UAmyL5XaibXG5cOE5p6aoUfyv1eigM=;
 b=CEyNEDIMeaYTIATf61+xwB4e+aUftSR5+ex712wctdxfK0BIYL47dxQOd79m3NgnaZAGgWoJFLrm1YYeOGPuG2XpYS3NnbenEd1slHZnBcpXbmpRpA6+Ne6P+H9unNDC143m2IRSFsQHFAoirjHVJRDDJOrvIHK8M5OIB9zIiLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB6122.namprd13.prod.outlook.com (2603:10b6:a03:4eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 19:38:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 19:38:20 +0000
Date:   Sat, 1 Jul 2023 21:38:06 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_sja1105: fix source port decoding in
 vlan_filtering=0 bridge mode
Message-ID: <ZKCAngK+ngGrrG3q@corigine.com>
References: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AS4P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: a875202f-5301-41bb-e65a-08db7a6ab99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjGLQYrlkO9xyAmJ6kYu5eDA9Mx8KouePv/15J4eb1AE7w4FFDtyGTpCAiVc7kfP06lU34UQqKySP87q3kOZsQk3XfjGSD+63OTWE3DGVfu37Vc/iVuqPaCXBiFLfkRJ4UlN8+K8yIVsbaG+t79vqNr+k3QpvWx0+ryqKrsxAMIYLAalDh0OVorc7jrWwBAsvasd6LZxcA/r01sAqD0DT8lZD13AYICpDoO85SEkRaU0AkgRhi6lVrh1SO7XCrpGvnppXH404xrKc4LsjeCnWQdr2yV9fyuX+4u4kinIybdGE/5aGzlzQX/xU+S90leGTxDkfa01JQ3WluxXiiP9rqL5P3F6OQkRHYjeyTBkJJk7Y9H0fMeNH5J2deVhWqX9cvbRslj8wt2Ct0o4BLTx67hQldasGPMZu/4m45ovVLSLpQBthAaEvCTpfULtQWAwSUqgwfuH2fKsViikRRuGUCtXm3/YX6zAvKlozCkALNo1Ipm3fAaaAX7G4Q7sLudcgh77e4kWe19WJRxAMbPqDt1sxFfq43NfEceQajfL5S7sF4vr78QarzvexdicLxwl25fWwKMoJq3j+cQHOD/F6sVWMcQAAdehS7dyy0jtHozfnELv4BMgLPoIEPFcdNeFTRX9H8ksL5yg7sba2ATYYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39830400003)(366004)(451199021)(41300700001)(38100700002)(6486002)(6666004)(2616005)(83380400001)(6506007)(26005)(186003)(6512007)(54906003)(86362001)(478600001)(316002)(2906002)(36756003)(66476007)(6916009)(4326008)(66556008)(66946007)(8676002)(8936002)(44832011)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MB3W1hlrcJVZyTuId1sWbK46dgSU6CPy1i1mNqCy57AobItQzLJeBOUiwPPU?=
 =?us-ascii?Q?WQOk42iAo41uw7jerpGDKQLZrg+CN8mR/PjlMonEZjooFmfvMtG1DMBD9sVD?=
 =?us-ascii?Q?ctWKClWXJ7lQfodqa8Bpe7msxqYfG9FV6CBKasZsxHYdfvVAaQVCE/qqI/gK?=
 =?us-ascii?Q?7DqFiXVbhIu6Mbcoc42TlmJKNxi0swMZ0TATe5BVtkVtxLEhwHVuoo2WVEwc?=
 =?us-ascii?Q?ymS012XaTIwMYLp/qwx2qKxgUQDMRDMLTRTPMvnWc4zKbJAzWr82hIgME6nt?=
 =?us-ascii?Q?YMqlpxxkP0GCRBqaHKflRDsgOWkFHbazc3wVis9ls/t9afMYYAntiR/0eVXi?=
 =?us-ascii?Q?YambRBfH8TS8r0S/InJ0b/6GEJ6xx//gtHqyzg+6Qw0Az+vUWd/+J/wq/Mut?=
 =?us-ascii?Q?aXkgdqb8v0Ol695dYhNiLGP21JE8KiT2IdKYaFftNnjcXkZOCrKakpjhWzep?=
 =?us-ascii?Q?21fjPRUCo58wtGrgRDcg5TD9NkX++Ry+1LxZ51pJgP77NzX/Ecb3KnjbpG4e?=
 =?us-ascii?Q?Htofsd/mqjgMo0/MRLbEpcEFKOuSQDxWWx4esE05PcrwFdeZcdeDqYccE1yH?=
 =?us-ascii?Q?kEEUVDgxFXnYjjhXERWc9f+Yer+9BVFe3JTP4V+1xf4wPCK2WO2VRd3NHLwU?=
 =?us-ascii?Q?0kyu4uR8eY+/9byjjs5VdDcBgWM+p6AJZMrOy5sHDA1LujawQzQws9cYGCfH?=
 =?us-ascii?Q?9W25n+SY2k2HrH1mLJgpyq+pDA2//yrPlswSjYnfjFEFKy6hIO3w3UOD0fDB?=
 =?us-ascii?Q?4IgylcZPzSEwdDCJVMxykRrORux5DJDuvrbCcDQlh/2wfa4+CwDvL0bc52mm?=
 =?us-ascii?Q?gHnn7IwMGeU6OnafYeVU/VeMUjgGyE5gx9S1Dvbp4GyhBlEfk2zjx0WcNusw?=
 =?us-ascii?Q?kLoz7y2D0CJg0tH7NHzFuHe8EyRWKIolQNHn4IQoEidT5Nm+eNNlciAgCcQu?=
 =?us-ascii?Q?DNUFOsIZk+Pmp/KYdew02C8toqxJaHqjArzcgvIlgkBt3n3iFrzQnfLjUkGs?=
 =?us-ascii?Q?96kteqp5xiZ27FLfR69yRQ9a5vy+8VEV58Xwdbf1qc1+EVQ+5lTXH6tGbaOI?=
 =?us-ascii?Q?lbb6CnuZEHi94SRvrUwpHkIpynJxiFYgljV4VghHxpSv60Z53E9PzHPD4Zcp?=
 =?us-ascii?Q?iJSIP03lp2NCJWYrMb35t4N/0eKjZcK930saUjDPl2r2G8M9nRvv9MAdobEz?=
 =?us-ascii?Q?E608nIVfitsl93rTKY1t0uWrNZSOQunY6CxMdEmCWVZrLUqVHb0l/taPTx57?=
 =?us-ascii?Q?Rxm7HKbjv3wqsd0bFMvwZxoTY+zd8PLfOc6LLhbGWQEncoS6eBenIVx4qstE?=
 =?us-ascii?Q?Hx2UfzcrWta+Yj3OJEPGekTCGVasUxRdj+YWpg+v2x7JvCaVQf9DOoNovi88?=
 =?us-ascii?Q?NADVqjqbbMB97lb6ynRLPHGbEqVY4eTq0jkl444JBTUaDRXRUmm+u9LH9BKA?=
 =?us-ascii?Q?x0/NKuf1pqacLNfdIOwfr8xzxk0P2b37H3dhaWet22wJsLh0JPMJeZVqeUma?=
 =?us-ascii?Q?lF120A1OBXnI5/r4jTJZxF2tYX0yS/3LOs5zD4Y/jfPpL6AOUYuSFIlOEjVx?=
 =?us-ascii?Q?yT4YoYbFv/+CweWF92EirAJJPNxgd4k7pzEiO+GupxFuqwd6MQK/v9uXcrqj?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a875202f-5301-41bb-e65a-08db7a6ab99b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 19:38:20.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfQp+bljRIhrBBmRNcTiCcMXMVfV47NRuSYjVfNfU7BtUuIcCtihJjh/9OAtCBnCaX1986EBZWzv/Rj5nFlroomW+MdkwGrec6Icw5kFzqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6122
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 01:20:10AM +0300, Vladimir Oltean wrote:
> There was a regression introduced by the blamed commit, where pinging to
> a VLAN-unaware bridge would fail with the repeated message "Couldn't
> decode source port" coming from the tagging protocol driver.
> 
> When receiving packets with a bridge_vid as determined by
> dsa_tag_8021q_bridge_join(), dsa_8021q_rcv() will decode:
> - source_port = 0 (which isn't really valid, more like "don't know")
> - switch_id = 0 (which isn't really valid, more like "don't know")
> - vbid = value in range 1-7
> 
> Since the blamed patch has reversed the order of the checks, we are now
> going to believe that source_port != -1 and switch_id != -1, so they're
> valid, but they aren't.
> 
> The minimal solution to the problem is to only populate source_port and
> switch_id with what dsa_8021q_rcv() came up with, if the vbid is zero,
> i.e. the source port information is trustworthy.
> 
> Fixes: c1ae02d87689 ("net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

