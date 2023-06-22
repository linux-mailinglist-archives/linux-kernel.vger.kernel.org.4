Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD339739831
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFVHf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFVHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:35:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2103.outbound.protection.outlook.com [40.107.95.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4711BE6;
        Thu, 22 Jun 2023 00:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJM3HfVNumbyxKuBmNE/6658NncX2GPCWIPgl+wHcv/nJB+wILsbDaZYrbEY3xW0jsLff6uaNVlsnRjZ+TwZdOpMtFrNjGeE1fLYbwq+wQRR0g3tHRJxCYVC2AyS6McS4422KUZjoyCebNsvZfceylmF1jZNfTQnRhdeIaklhF8zpeE6wP5dNGnksdrrS5udFktsWyWDo+sBhfuyVC/vnx8SxAhyVotiJ6z++6EyNkxL4hOs8wu3nL4CDlmrpnGaNfnbVK47VjWesj1EN314xgAMncNO/5YVCn7j9nK6CbXlMBVBvcIvoTOy7b4Eq0U2vBLi0PMe2FcXJw7o6R5jEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGxmthQRenM13iJpO1+UOrS8nJ0kNa4f4vCRLs39qKU=;
 b=HEWe110dO8iAyWgAgSYnIRDcoTI3QZWe0bW50kVjLnXSnZaiXkQgx90iGPTCtIr8T5ZLHUiZzAc44fuHl5Jbz9U/a07G4wQcu3VUm4AdKj6tt+iEP8YdXN1DrqpFaaWituB+AgLv04XmNdgGGHAnngq/zZvjwg28Cs54AK9on6LRqxRdofV2j19cF6sl4+IVepeoT1QsLOhES0jPTY5/w4l/QAoJdGC3ruRlVnLNPZ6eNhqzTwKBcrabYHHqR5ap6QV3ySpuhdcpor4xt2WpLHV9UO8BTT9YlbWa3oa9QHCVXwyiDoKMsrvOEPlMp67aPf8d3QR1CVWchqkZzw1K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGxmthQRenM13iJpO1+UOrS8nJ0kNa4f4vCRLs39qKU=;
 b=my+9Dx02IyCW7vA6EwSJVSIj0Xnyonk5fnSWq/ruLQKoZSNa4iodkN6fCw0CgRuj5dSZMhTJU3gpn6dCfF4mTiNYRdsVO7oJTqdbWmaxePLzLkrm4kNALbbuqWcTpngJGn3geMbOGpuyzlyu0HpNxM4siLaHTIvtcSNUdJ9izMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB3914.namprd13.prod.outlook.com (2603:10b6:303:58::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:35:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:35:20 +0000
Date:   Thu, 22 Jun 2023 09:35:13 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: dsa: vsc73xx: fix MTU configuration
Message-ID: <ZJP5sbx4prmdq7ci@corigine.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-6-paweldembicki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621191302.1405623-6-paweldembicki@gmail.com>
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB3914:EE_
X-MS-Office365-Filtering-Correlation-Id: e59e1290-9bdd-4cdf-ebb4-08db72f33b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3sCannrzhGSl9xLFHbANR8NJr90rDgfeU1w47EvvdRPng4H7E5bK/g3xJaZ9TMdXMTXMJBw6wVZLIG3YIFxMSGgM/UrYftGUvXxvfLHO9+vd8Q3cGH+FRxjWaFrsw8JqXjTJMPijvdrqLATTfXjXFUx9qQCNY6mYdTNZ0QKUThjTEnzxAK+G4zu2HTGGBok2pjBuZe3GcTKc4hNfzu2T3QMuHKuIuDUtmJ1A5lBfm/qdZXfTgaeAgmw7Oj40tRJioQj8KPYDeQFtFSCWlWmynizHAqVQiMARBlVrkq5ytzJJAYahV922QcCjW8XQamZ/OeYzBT+2t8QyRMq41Py+CQC0owfeAWfvStIeoBREakbS5VKPxbHs3wqpTDpbAEifMrQetcr7+od36Sjo2X7l3iae+3Kv4VlVx+c5xVT9cz+E2dPYUJVrBTtguW7xNdEl6/0xm9ClzxyNHT6lvBN7uT/WtWmtwAI0/dmig70i0dZgMCp+sVQy81F9G4siEWFWJhvD3tRxzjvVHWMqHtwOtCdD+ULMbKzLRbZMue8OQwX3VhV9FkOHWziVnJnPYAjHpsMTtBRYuZx5VyRv/VOjEcXAcAOu+HJ5WV4neW9qgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(451199021)(38100700002)(6486002)(6506007)(186003)(2616005)(7416002)(44832011)(5660300002)(2906002)(41300700001)(8676002)(4744005)(8936002)(4326008)(6666004)(36756003)(478600001)(66556008)(6512007)(66946007)(66476007)(6916009)(316002)(86362001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HK1guIgTfl9iIuoZolGxd7Cqxi30Axi7xkYNQXlVxwuCRaBzqljtyo4WLDx?=
 =?us-ascii?Q?c7EtkFy20/sx6BI8o6YEquQaAK+uR/Fb1EA3voACtZoO72KouPdnUr5JqN6F?=
 =?us-ascii?Q?51jw3tRVMdEa0ynaQ8wqGCEA8BiFSZfneP2AzuwgMMCJi254u5uyyJIEcBE6?=
 =?us-ascii?Q?eKnPM5o038euvNcpfWvFZcgUHR2bDjRgFDBoRT/lFRXLvr8mnxBkEPSf6kgx?=
 =?us-ascii?Q?C2O8fpvYc8CzrBjonVx+XJVgyWKYYx8Qq91yxTF1xtO0xgRAaVr03VhbeW+K?=
 =?us-ascii?Q?0iMTrOPAv3zuMqE/miWT649R3T1myn8GA/aaYw8BmGUppKZGpPODzi6D8KB6?=
 =?us-ascii?Q?o3RsrUqXb9+6XJ+2GU/lqP07hsaYB2v466rlvnKDOQW/6KAPRloL5RWkVMgC?=
 =?us-ascii?Q?krH8bjLjIg3+yGQjJRBRNll5PfqsG1ClAXYrOqOQAhSQX15tToHULnegqItc?=
 =?us-ascii?Q?x3tOH4A6HbVXnD/Sbc0548JgVBxMD3PxAecDgeQTEi+GhihjJXzvoc4LaUXs?=
 =?us-ascii?Q?PUzGth5G3/NCJBzBcBm+em4k993Clk+NlzQkg5Bt8wu7TlRWuAZvspFRDt3O?=
 =?us-ascii?Q?o4/rp7UXzfcKR7q4zeoIGhgOOtotyduqSPQ3yW+xtTV8vO10HK6T7xjegNq7?=
 =?us-ascii?Q?2Rw2uPESJccte2a5MQHcmMF5sUom7he95uHZUCdzWPn+6NBFdxvRAzXjfi6y?=
 =?us-ascii?Q?4KHM46TeAEf/Pr+AuqkeCdl1AovTjqWJVG0Uz8iOC+bDij7u4SBCEuzTjBhP?=
 =?us-ascii?Q?i6YQsZhmHDe7EE87rNAgoRw1Lu3HDl+x6LcBt0LiXe5QGHe3Iv7+jfHqnp+8?=
 =?us-ascii?Q?bwXHfvCyzXV+Te82pqw+mEsYqDFCloCVtAFpmWa4M0pZkVRKTTJ8GTQy1NOS?=
 =?us-ascii?Q?mCoX+nJ6tFoDmSr7BfX7t3SQnNgvVP5XHh2MHZ0ASkZxIq2s4oU9uxhZoeju?=
 =?us-ascii?Q?MXHA2n0YBjl/U/NcZWJdFFxjwDSvN6FhkoxgvHb788GLTgQY1F5fRjBSpMTO?=
 =?us-ascii?Q?ZBWmIasA1enLwxVz2mLtoCpemztrBxbRn26wgE9S9CkwhOeQBtXINvukZ6lv?=
 =?us-ascii?Q?PBa1c3enhzrMV92CAEcXsWzcULPOzE3+oVjAbW/5cbJ5wayireQ412aiHWMX?=
 =?us-ascii?Q?NX1QI4KnmnZ4vLaHjMMB647BIhTHEDE65EBpZa+5Jpk5vsV7xmx97RtHIiYT?=
 =?us-ascii?Q?0K+QgWEj0el+xzyvKBx6q6bM4mijr4FMIUPR9Jdv4lgqYPA5HGazhE0nz49+?=
 =?us-ascii?Q?hGsZU3NdnarKdzh7t49vMfGp6yehAblAjE61Nmm/WY4MWZySpVlrqlR9u36c?=
 =?us-ascii?Q?c18WOfKw9F9Dp5CO1Rl8Gzukv3NGsOI54m8beLB0fjBcFm8fg0l3IAin5tGd?=
 =?us-ascii?Q?AcerWj6+56AAE1r1HzkHGgSX8ZuHC6p0YravQqADVT08uh0McRRYfk8FijxR?=
 =?us-ascii?Q?mSFQHT2s71NH0W9ZQKs629LZd4Tjsi7J4JYClVwGwVIOlo7LXaYk2YChoyNU?=
 =?us-ascii?Q?A2r2bKT7LWINslGWXu+nrpiakUlOhPpndsaq3WYqS1+PinAdoP1hKv7dgbQm?=
 =?us-ascii?Q?pRw+bi6U+zATgizPW7Hf5+ZtSgTU1Jzb/Cu9ErDH9mEtlW4gWTF579o7bnjD?=
 =?us-ascii?Q?XHjwAdR1ab0bmHT0/B81JhoZVRPBye4ChdTUns1VPicScs7UPFXx//yMCADI?=
 =?us-ascii?Q?QKXcpw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59e1290-9bdd-4cdf-ebb4-08db72f33b3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:35:20.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89x1BoGxUn7XnXZuasz+j3A4TUnAQ8FGUHd24uWm7mJOfdwnmsr+h1Zpj1S+TVPDHrTx8NuzSF46CDq8A06Gc4ifMINYxJqp8E+/YQU2sc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3914
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:13:02PM +0200, Pawel Dembicki wrote:
> Switch in MAXLEN register store maximum size of data frame.
> MTU size is 18 bytes smaller than frame size.
> 
> Current settings causes problems with packet forwarding.
> This patch fix MTU settings to proper values.
> 
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Hi Pawel,

one minor nit on this one: there should not be a blank line between the Fixes
and Signed-off-by lines.
