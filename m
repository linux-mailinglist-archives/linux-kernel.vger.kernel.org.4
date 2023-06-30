Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D974416A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjF3RiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjF3RiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:38:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF61BC2;
        Fri, 30 Jun 2023 10:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqzd4k4fnrI+HvmBWuy62/nwYgYCSVmMnx+70mBo8BmMOmDM8L5XHwm2CfdwiYkwVgGf7prylXpHrcGE33srodCG+T20Y0oETTyCKq9VzpRSVwv0TYe4cy93j0T4i8PQ7O5Z8PQI0EMMSlR473s+BNLt+GdMNu6HibBJ4wfkqfj1isgM96e3OtATUf3FCoxNBHpNn9u0WMlNxEK2OVRuTDxAqpKyXojkjOhYcAEkg/rXJMexT6WtqMjC4dKHSno2J25HlBzr4wMcPSSyuv8GCu2Yw6gD72jF3qnc0I1vrheFYp/z0gUowEeuA86Z5CUZsQd38zVP3SgORT8kpjXmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCVrun2r+8tThnqI1qqLsC2gGrs1kTtCdkIDGS0mtV8=;
 b=NKcuG8HJop6T39j5E0Tl4Lvb6wO06Mj/R0ICFhBT7oXo9KBzYFqRdkLjy6QCoTo4i2tM71mUscsAPDq0jNqD3X1pbFsFYIl179pz8LxFhAADwZVt/uQVE7fSohcJ30I6NK6edWZq1xhZU/izzMiokYtzjzE+7uu8oKvx53CvJmtp3r5hmISEThxjy6EqTgKXKOpEsOj1lAALed7UWxDlYIldpXSJmK1gj3FIjAbzIricJEn3gIfnc8JTBIZl14bkQhs6SWK4h0OflLKUrP3plUzYPLQqkwpAE1rnv1q7Z6nJ1uy37CdMtOOc0tZeoAFKFUeZSV0ggTeUFxLHAkmaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCVrun2r+8tThnqI1qqLsC2gGrs1kTtCdkIDGS0mtV8=;
 b=uxbv+DTt1YriwYj88hXto9scty3mvs+0IUYeBUeulxgP58M1tdwDaCl8w9ItLBdbLyD64DprJR1biYaO4JcILR4hkVA0GRFeM5IHry33ZzDoG148iTuAhkqaCbf6kFx7ebHphWNundCgmPdO0XGdJ89X00KM9ScpDeAv+Uq2LGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3625.namprd13.prod.outlook.com (2603:10b6:5:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 17:38:10 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:38:10 +0000
Date:   Fri, 30 Jun 2023 19:38:04 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: sja1105: always enable the send_meta
 options
Message-ID: <ZJ8S/Deq94MAonfG@corigine.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
 <20230629141453.1112919-3-vladimir.oltean@nxp.com>
 <ZJ7aG/tzAxutRoeo@corigine.com>
 <20230630165300.jmy7duyrqj3gzjmp@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630165300.jmy7duyrqj3gzjmp@skbuf>
X-ClientProxiedBy: AS4P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afda9be-9d5c-4d60-0ce2-08db7990c59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lyx3EJehQB91l9BYqjkwJZzDX8Phhf1MzFuQjWaWMlHIXL5d7u6jYzD2unb8rJZUdaPmIYLlIfS15m3LKAuzfAFGFEkhOPKdY6LMNFn+OwHdr9sRxKc8r5MxTbsiKxDSk9Dgz6+RGlFcG7c35yg2g5o8yHfrOVODCkrZnFsER3Nh6CNCA+4RYRL7B3mUQvnCR5HSXcT+Wg+A+149pVAexZt5x9bmbxVoso6pmW3EeZTihN2PHj+u6PjrfR5VbzDrAYo6svUTptpIqTIKjKp979ssGxocp3xFctqpVcCNlVmOP622moS4EY0e/vv9IEmS528BYpDX5uSlD/7W14zI8aKj8iDPMx3Twnji2tkTLrevtRnfK5spcG7xseU5lrW3vK/LfzZXcYuLkO3a3f0AJp657roPEBjMS2loT+Dl0x6BhiWapA9aGQ0T+0UdTcYxA8w0Uhz9+qTVr6mIw22ljUmEzGnd3QCAzld8uc/xcdj9AA3T7SEbpuwmlmnp1d49wMI15jCaT7uII8NTE0OgaIpOSn2ieCEBZwbu33Ya2xmlU1lpJ2Eom24VcMqWu4HXbcxtum+x8lidasNxzSEH2AP27M7tydhxO9EPwgD/AM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39840400004)(376002)(136003)(451199021)(6486002)(478600001)(6666004)(6512007)(186003)(6506007)(83380400001)(36756003)(2616005)(38100700002)(86362001)(6916009)(4326008)(66946007)(66556008)(66476007)(2906002)(316002)(5660300002)(44832011)(8676002)(8936002)(41300700001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17Qlb/x8WIpbsIOR9WE/Q63LNJid5TT7q0PTPuHouTD0X1BquV+2A7VfkUyT?=
 =?us-ascii?Q?7kPxIWu3/VtJh9YE6tQIvE4G8F/I/h6O0zQ39fjdGK0tPyJDz4XBlpKDL/zN?=
 =?us-ascii?Q?qn+SZdLZ4cK9aLjJzuE9OT5L81IGOy2pO8IxdYsdQmuFNfzyYYJkdKZIZqmE?=
 =?us-ascii?Q?GSaKkH0a1gDOwWh0cKTSiJaZuPwHchbPhdEN97oy7zPJAk5PBuWhmPxpmb+6?=
 =?us-ascii?Q?ijmVHVnQ/rHpRHcHOBZIjwYhbv7DB7EXp6WiCjDFzzO9dAuPWxENpsdjuRFz?=
 =?us-ascii?Q?JDKfdr5d0a8/g/+XEfUsAEmNQe72Wui1aZxjeTxR74baDHhaPOlQAojggBfm?=
 =?us-ascii?Q?+Lx2BJepZFtsPjQo0YcVmALourKwxmM0JqmCdPt8m87jXsPzVYQy8+pT520U?=
 =?us-ascii?Q?q1+i/edNqz6nfzvhKcw0jExErafN4uOdPBcVNQ1ff7HIZak1cmTmxtyb90V8?=
 =?us-ascii?Q?SxWhDvGPwHl5mU08s0jcy2e7sYsyaEEM+5zVdYqu0EHhfdgi7Q2EMBEKyOFf?=
 =?us-ascii?Q?WS8BcWjz1pQLGBmWamhV2g4RYqJx/ynoTEtTBoE7xmGPEMxI3ku0g7NBlSvd?=
 =?us-ascii?Q?cySzc9whT0A+oU2KlZD2sp7FMBiKePWaBp7NSNLaoMOhgvWiRsGMqSJnUX6F?=
 =?us-ascii?Q?Kuk90f5W+JMM6UG2eZvhZdXnrnZZZ/8Q6MePpwkHjYIJ+iiFMadjd1i3JVuM?=
 =?us-ascii?Q?8ldu15aW0S99n9KS/7TcGX7osXVFGCYjFds9sDrvLSc9I2n4mDgMllsW6nxM?=
 =?us-ascii?Q?GcNwqoKePfWU75jBw1LS/dKpQe4lImq4NZRUs5VjGCK/EHfy5HZXiWJNUev7?=
 =?us-ascii?Q?oHvIJIHx86+I86tHfTL0JXxQJ9DHIrUMkF2PFZxWuwtgPTyw1H3fymHflIYU?=
 =?us-ascii?Q?XUmjSkL47VzBS3FJxRXBTTzo5GAuHU6PqO8GZvtief6RS58zDv9XyfLqZrwG?=
 =?us-ascii?Q?bvxxI+Vxw1nZy6o45w/KdsTQYOBia2TjUWs4Ju3z2M48Ezgo8WC319kEF7/3?=
 =?us-ascii?Q?YthZcQYsrIrbRnXsvGTXwUD5SkOb3+nRmu9rhucBLy14kOj8Wv/Pq8IrJL/i?=
 =?us-ascii?Q?2GnJmq94kAHetqto3rK8yFqGd8jslxXUnXvDDgzq2hnInVczDqRLC63PTp+G?=
 =?us-ascii?Q?wcO+l07ZZ16GkkG9xN0Y6IU468zX4JugFX9qVjL0lWpfK8Zg/VWRFhoCHSq4?=
 =?us-ascii?Q?prlA5GCqHXeIyPNM6xlFrDbcRTyhOJ0TsRm89lcHPZjw+NkxSbBnYooUFcYx?=
 =?us-ascii?Q?cV1RWm6Sogkcju+kW3ht4KeuoIu5ZI20JDQx3pNgnSyQihS4WfQWo0+PhI3e?=
 =?us-ascii?Q?dT/cGki6MaCKbhNYZ4/yp5nIvYyydoSc7UsMUMtEH67kCbQjNBrMsa74rgtd?=
 =?us-ascii?Q?wG7/44EmO4/I0AtDq2Jd/NTbNAQGJn7MJqlOIeOfssDDqk52KgtvnxYAA3mq?=
 =?us-ascii?Q?X7mj7767sHd2hYf112j0Q5Xwg/weZ9b0qkgWpsXlo8TUKbNdryqef5svr+yF?=
 =?us-ascii?Q?kmNCWMuNRnBkcG1ZVmIv4/dl1Efh5vCI7bIi0CRzTobjbrcWN2CwT4V7ZYo4?=
 =?us-ascii?Q?JoahZgOitVKKO3QWVFX3g6lpQd/YsfVocj08E6Xx0hno/GVQuvZeVpP8okFU?=
 =?us-ascii?Q?7Fk2Cjz7M7DvBo6pRy6mSa1EWRoKDLWamqiUcDFamLEZjNMF5B2Qo3oiS5Gq?=
 =?us-ascii?Q?pJUiGw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afda9be-9d5c-4d60-0ce2-08db7990c59b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:38:10.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp4ItxgOoJYkO/hMCtFDUbKpgsubvWStjiBJqCQHbq/RMH8ThFt+WbQezsrhj3PByFCMgZzE7bV/YmLK8OvEdaBXddjOEybjv3utpkBa0qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3625
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 07:53:00PM +0300, Vladimir Oltean wrote:
> Hi Simon,
> 
> On Fri, Jun 30, 2023 at 03:35:23PM +0200, Simon Horman wrote:
> > Hi Vladimir,
> > 
> > this patch isn't that big, so I'm ok with it.  But it also isn't that
> > small, so I'd just like to mention that a different approach might be a
> > small patch that enables meta frame generation unconditionally, as a fix.
> > And then, later, some cleanup, which seems to comprise most of this patch.
> > 
> > I do admit that I didn't try this. So it might not be sensible.  And as I
> > said, I am ok with this patch. But I did think it was worth mentioning.
> > 
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > 
> > ...
> 
> Thanks for the feedback.
> 
> You're saying that it's preferable to leave sja1105_rxtstamp_set_state()
> and sja1105_rxtstamp_get_state() where they are, accessible through
> tagger_data->rxtstamp_set_state() and tagger_data->rxtstamp_get_state(),
> but to only call tagger_data->rxtstamp_set_state() once, statically with
> "true", and to never call tagger_data->rxtstamp_get_state()?

I'm not the ultimate authority on what is and isn't acceptable.
But, yes, I was suggesting something like that.

> I probably could, but I'd have to delay the tagger_data->rxtstamp_set_state()
> call until sja1105_connect_tag_protocol(); it's not going to be available
> earlier. And this is going to be just filler code that I will then delete
> as soon as net-next reopens.

Right, so there is complexity. And dead code.
Or we could just cut to the chase, which is what you have done.

So it seems your approach is best.
