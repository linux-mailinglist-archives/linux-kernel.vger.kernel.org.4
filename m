Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9C71415E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjE2AS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2ASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 20:18:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB44BB;
        Sun, 28 May 2023 17:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFoTwLLAd8sTuKVRdgdQleDKUAJE8xtOEDUk2D1B+/pfX4wwP9nMFTAygVVhdwrLkTLdoC+TMg3jKySKKKTVL3YDUxs8T70vakMidcIe7XBNPpz7OaESiWA/VLJCEbhcHv4sKBLsjr98mh2A855+UN/uMXo6cDVA8VlaYEmcRgRwBiQAaRzFYn4BkIVJE5Io3fZFU4sCjyjsLTZlyjJUKXFrZRWaHULp0CxiDXlRw0ByXJacUj02Qx6gofuIIQBhC/2d/kF24G/sHK9Z6th4xs79A10myKhZz+v5tXbYE4seveO44HpOsA4Ns1DwmCFqk1slh38pqYAPbCH3GxMUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS8tIi0MoGnqVMyraE9Dkh7ntJAuN+CdLCC3vAMXnbs=;
 b=LhqRM7j0qIHAeJSpUtq3sz2PkTlKpK1Q5CuqWlLMpthpsvH2oJFH2N9VKMjbbsumLL3c8++IWOo7HUu9ngi4QL0MCWlb9ta/7/tKdmpnhHZMs30E7A7oHlrbLO4wCKD0v7UAaMFbyy0N6DUJ5KTNEbQHFH1Jbe+GFxxExyi6PlhpKpgNwCq5JcoKpOQNDvrQ7JE6Igtx74t4fMlKPbsuaQ9jIpaM1mRtNoRcgIvLPQ292GrxeOO8T7kYTw9KrwozKExe5KeZWnAGDPCg/Os0YkgSs+BXlnW+tlV9j7H5xwTsuaZw4S2jzS2j/fRlqHaKkGW4mU/ubZAemgUpWINj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS8tIi0MoGnqVMyraE9Dkh7ntJAuN+CdLCC3vAMXnbs=;
 b=HmHSkqwotCBoLOxcst84dgoTKL5/uPtZww9Tzwg37TvEiS7VycE4jmntcIfTYYgCmQafu+Lq56pbASO2UlQBCgOjFfgz+pqEwT64+67gxAQ+ajJlc7yLSEe2++S+D2K/O+t6fBNYx8as/V9365sGtJ1guxquuHF1FEu/o7pk2Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TYWPR01MB9886.jpnprd01.prod.outlook.com (2603:1096:400:236::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 00:18:49 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 00:18:49 +0000
Message-ID: <87pm6km1lr.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
In-Reply-To: <20230526150702.2555143c@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-10-herve.codina@bootlin.com>
        <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
        <20230524141411.28765782@bootlin.com>
        <87v8ghgtyu.wl-kuninori.morimoto.gx@renesas.com>
        <20230526150702.2555143c@bootlin.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Mon, 29 May 2023 00:18:48 +0000
X-ClientProxiedBy: TY2PR0101CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::14) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|TYWPR01MB9886:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cf4919-af94-4b78-f17b-08db5fda4667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9rCFyUqa++WmviKLxFYfPzfwX62WhFluhdlLpihzriyvEqArZEHfe9pvMrcA2zRp6TnYDv9rLOt1I9MCwBoiJT3tKcm82+0ZpNd9NVymUBjc/EgeCKk5hRzSSKF6T2u2fJxE/LUKQrrUrKvTPWs+rDUzk1FsWO+UkjUVYe8t8sUTcImW7kLwfVHcfnIYIxhvK/7IkROp9uEC4f2S7VlclYJGj319IfH7I5T0XtZl/Wt8gDDC30rdY6Qk9sUtMYfSMWKiyaZ90CUpWP6JWBZLpM8yjSCjKYoszGQWvrNuJlG//21/cUmJd6yrMWdNYyNhy/92YR7XlIjIEwb1O2pz7jiZNSoWf7LeMBnGg95B1rjiCAPdRR9bIu/T23PeS9aUiNAn62WGE1AqSoXCJwbrWRkHP9bBGOMaP8ZV+NT0CerjcSdcouCYhUgltmGpsKa/rvhxixs8Q9XcWkliorsi2l/aqzQbxANTxVqjNreDhYRrhe5wkyJuSI6G5T6gw23Ux6NOTPolnOpzpG+kXcT/4F3a2dhx7pI3ub/Ref+xdn3O7w3K1Ot/Yx8LRiAERtfXbLo0lyx+H4azgC6bKrM5BE4CSVe90+VUZtTG/dmart8JamtWOcWAs/QKIGxjmM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(66946007)(7416002)(4326008)(6916009)(66556008)(66476007)(36756003)(5660300002)(86362001)(52116002)(38350700002)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(4744005)(6512007)(6506007)(316002)(26005)(478600001)(66899021)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AM/Uk+heMwfkovgNXLhZ6dQ/59LRRhb173Aaa9veDTAGFbMm08lPGhn10TPF?=
 =?us-ascii?Q?ST/rxjjJ7fdezYLP8/hPmekk09lwZCmJIDFxgKPVViUf9DeW6q6jhtKiAHfJ?=
 =?us-ascii?Q?b2C7pg9vFEXy7sX1M2+I7FcYjvtdhQGEHGF36z+hWNQIECpwSt0wztQrD2e1?=
 =?us-ascii?Q?BkYvv4vCT4FxQrHySSMyTkLnVhGzQNlijStQz8cVRVs73MsZKuL7btpXHRKn?=
 =?us-ascii?Q?1oe6i+lWtHK2j2Q9uP+L+qRyr/wsKM0cleqdvUG+F+pN0Dr4oxVy7IjHwYhk?=
 =?us-ascii?Q?tbgG53zBcZUAn/1uInzNyQedeEuwfa76IVqTKXQUmJRKijsOs1coKLJ/28o8?=
 =?us-ascii?Q?gWYgUBfj+2DDrD2iSGLrr5peqJ0E6c41xF35fhExVR+lyf7yI3nPOqRI2C+b?=
 =?us-ascii?Q?9poIPiA4iFJ3lGTWQ7BfJtlZwLubEWqnIE6NQgdiQgxbzVQhWzbMW3U8i9fX?=
 =?us-ascii?Q?PZDOAqni27XDYuI2JMV+OBZb1zBrdgi5G7yln88Ai1tasDtb9WZtuM7gX/TU?=
 =?us-ascii?Q?wrVBfHNSSOemCiINBMpPfYrI81j4ca/60xC4Na9P/4iWRhA2GDCV2/TIMkFi?=
 =?us-ascii?Q?07vbVbMciQwPfIuQZAI66t5CYzenaKANThcdaNyn7950C+bYF0niCfVEw+AA?=
 =?us-ascii?Q?6jfdYh/8XHkc4JzOFzpQsH1JBdTh/ehEQd67QhstG9qvHRjFlfySjo4ORMfe?=
 =?us-ascii?Q?o/YuDR5MaZIQB3r+k9MnASPg+2ROOzoCafUsaRbyT+FVHOumxgN8EflC0laF?=
 =?us-ascii?Q?6E0m7oUM8iImikPsO73xCl0wvx9tYE64XuWpMOfGRJDiLnW+3HhYNJt2IRY9?=
 =?us-ascii?Q?9CEROEm0lZszp+41JPeq6yfp7mKGYzbxaiAOkfgZc4ZoUuMLkXz5zMFKInGY?=
 =?us-ascii?Q?JJ0DaDYpKaHjFj7bqqxx5Urac1R2yhFVAwHFHxUK4lX++pJKgh/Qy6w48RQN?=
 =?us-ascii?Q?LLT0f3j+GSYCkcQuOBnfeJQ+AIeIO46/ZLFKjfkgjb24slY21ZotaBu6vQG2?=
 =?us-ascii?Q?wUDRc2sFgDpr2tBzj7jsQShtuVzDntnEIr7erAh7cDFUYdRlPrdeXZlvQFyg?=
 =?us-ascii?Q?XE4ZJTpKpVdM8JKUkxEQQ/nvDLEVyMfneLii8s10ECjZ6fFmIadwUrFTt4aO?=
 =?us-ascii?Q?4XCfZ2B5DZcje/fpAuSfG1rEa+K3y8ALZxp+oqOkc4HNZG00r4zuNbYHc3ci?=
 =?us-ascii?Q?DqPFU5LtBlJsDttHQs2tSiPs1Lk/hlgSGXHXRtexTRvgTXVr7hhO7NZXluz0?=
 =?us-ascii?Q?Sq0disf1iqNEl8G6mTIQY5kO07svc/RPH1Rsyrr1xY/jRBdJpZLtOFE5QT8U?=
 =?us-ascii?Q?56NrcGLumb+8sylIWA5KqPEVDo57kJtUXwhm8kBRGzcFpADOTZmlSjgdwSed?=
 =?us-ascii?Q?fq84F8biG9Aesvi/7TRbrHDAULoREmW0rfgz3SMtFhOcQgFxlFh3W0uFxv4F?=
 =?us-ascii?Q?BWktGQupIKml0DjLU5FxmbXUqr8uLBXr+PIV8HaWv7P53vCuRS5nFTO8Hh2u?=
 =?us-ascii?Q?34CjAqMVIgvRBYki6OrgIxROOG88zWzq6C2m2ZC6YWXVfRUeIRDHMGgAD3By?=
 =?us-ascii?Q?TIodRXA4VluD2aIxtXs2FG+lKxhMWukUsAUqHfqCTRWyny/x0yp2OQ33pi+L?=
 =?us-ascii?Q?RjycrT8/l8CNHZKGwdKlMOU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cf4919-af94-4b78-f17b-08db5fda4667
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 00:18:49.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afeZzVUBG9eix7xmRUqk25nwCSNhB7F6lBpgrV4dmoLYHHj+xNEMq+6udteF/B/K9TJDSBZLAYwAS+PDf6v3/G1fWs2eWWHKTNH9pc6fYkElN1AZZO/0LVk48A3mlOZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Herve

Thank you for the reply

> > 	static int __simple_for_each_link (...)
> > 	{
> > 		...
> > =>		add_devs = of_get_child_by_name(top, PREFIX "additional-devs");  
> > 		...
> > 	}
> > 
> > 	static int simple_populate_aux(...)
> > 	{
> > 		...
> > =>		node = of_get_child_by_name(dev->of_node, PREFIX "additional-devs");  
> > 		...
> > 	}
> > 
> 
> Well, of_get_child_by_name() is called twice to retrieve the additional-devs
> node but for very different reason.
> 
> In __simple_for_each_link() to filter out the node as it has nothing to do with a DAI.
> In simple_populate_aux() to take care of the devices declared in the node.

I thought it is better to handling "device" and "filtering" in the same place,
if it has "additional-devs" on the DT. Because we don't need to filtering
if don't need to care about device.

But this is very small detail, not a big deal to discuss about for
a long time.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
