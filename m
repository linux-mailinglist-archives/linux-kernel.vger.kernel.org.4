Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC146A7CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCBIcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:32:10 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C6360B3;
        Thu,  2 Mar 2023 00:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZI1e8moCo7QaPrpbpVanQd/Fosb7tUFgfF8lnDmkHzvnUdp2irl6bZTXf1iA4qkkMgG0qCh3fQOuZTIrnhais5LpSbGMn07OqovXnoIl8c1DrfLiPPm23ktuLKiglzJCexVlrSHr9gNJY6Sd9VmFPZVwhvrmYHS/Y5O/o8IdbKbVQxy1LzvEmeN2HNG8/SZYth4CRJ/Fbm3u71ifiZ1zQXPrmmznxkMpf/qw3xH+v4G9NIx4dxWmLUHtczio1D+gCJC8YH5r33jw5vOHuQ9Hc1X2jTEQnwSFup10k/pLHd1kSyjHbA6ffwCiLDURqeFJxa4oDK6ArqhQfp89I24HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJV7xOeH82W2moJrsQ1zm1so8IzZ+ecspcSryhQ90dE=;
 b=UpJfLWGfAeyvSi4cbf0hm8eH54VV9QIzOduhYH4mDl7oassrOVOCPryLoVXPjI4K3WnOJZ9WBwQ55TgK3woX29ytrVAU4mHUxH8V0ikm4UZBdZYolb4u3hXZ4QuTepKGe0fHRY0blzIxVDiyfoqllufwANpRYAO6qo+Fq6A81QCovharJWvgKLx2H9cw0p5wmKv7Z+PUcjxiFvj0fHWvxdkud8UYkyRRK6PVKRtQJ5ebNuVhMNbSRf4HU/T40ZG7AxgGg/kXMWxAQ4cjyl9iVpXtJ8m+Woq/7LHXk8LERiCTjDRcz/Z93qKz1dzIyLbpF6H/BNRKpUDgd3pXsEOnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJV7xOeH82W2moJrsQ1zm1so8IzZ+ecspcSryhQ90dE=;
 b=D6SR9UI5H3VeTo/NtnK1k/6vs4hht9GFXkkb1kHRRTEGb0g/6RWA714yOLDdXv6G1h+F/M2zD2+0Iu+kd/Y3GIHAanqdXIikA+N2VPeMYAAqUJ0kvPru/OGPkAKJiVbvAbZ1HamU601TsWpiTbLJ/mLeWhWgPy3dM7i9UWpANnPUosaypxt9MquK3iaR8WoEOSRwJn/X+teHsr1UuzlHNYRxmALeRLID+z3dysnqUwBrK326HGtW2jRkPLkqf4/o8HP1/mJEHjmy0khhCZigUQf9oufvtaMy4PE+8q5dmdqQcG92ql3zrd4WcyNFjXsB3Orung8r9HfWOCha+ynYkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS4PR10MB5521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 08:32:06 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 08:32:06 +0000
Date:   Thu, 2 Mar 2023 09:31:59 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
Message-ID: <20230302093159.564057ba@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y/+LhLH9Vm3WClU5@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-4-henning.schild@siemens.com>
        <Y/+LhLH9Vm3WClU5@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:610:56::33) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS4PR10MB5521:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cb80b0-5209-4441-964f-08db1af89b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZN1DA6mJPIt2Hwkroc97QQ2ZWRxwd3TE4yT9IUskaZTnhI/Wjr3YWwRmKPn9WvGzmp5p2lyL+AYGHS0d+Gqadejy9TKWkp9LtLl1DS9fe8e+BK0xVTNh5doGSfZjK7AZU2iPU51rsZgnfgnaJm12IhYvvOmB35wgKILgpsdZVHivbTitku7gdbBcNkg5DY0iE+jdlHw9Jz49jfepSvLoGV333qe74SLQP36NGs5QS98YL65FCnyC/NANKswd9emcpDQPr7eyHhigehqoHgKG3MS03ONHfPGcOGEeX+FYJN5nj+1S+w0d2F46lbQsapWHWdzj0XWi8ylzYhmjw6qQaVDu6Rp6yVMN6iWRCunrLlFrW6eeBk6tVd7HRczcqfmh3PQixwKG2B5ObCMEpLlUAmlHzU5K9+HCCYnWiRbyH3F/AUlpxysLTz6Hvp30fP4KX+g2h95kYeD2WEJDHENe8ekI/gFUeorHWq4szQaMhRfxxPsCEPl+7fWUkd+lgHvTLHRy4+4qmGP6spe55N09JoD8g++06BYujed/jxDGoRkivjagcso8Y+ZQNUy/siwp2+gnKDy85ivE/6Wb1UL4XfNQfP2Fvfh5AdPWHZnX+wXIp50zllAWpj4Gt6MaLDHVZh4d3nXLz4ExNjnxrvn1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(54906003)(478600001)(6506007)(6666004)(6486002)(9686003)(6512007)(5660300002)(41300700001)(26005)(186003)(1076003)(66556008)(6916009)(2906002)(86362001)(8676002)(4326008)(8936002)(44832011)(66946007)(66476007)(38100700002)(316002)(82960400001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iUc73N5Pzh9D05tEZ2KZrIteHWtyjF1xbE4hI0QZxMClTz1GgHAd8K3xw2xD?=
 =?us-ascii?Q?ffbNhKHx3q9qoqESBbYLQT6Jy72QBIWSqHdbDI2bb4WPeQrJuz4/4VGERikc?=
 =?us-ascii?Q?woT+z+QyVf2tSKOH8idQ69JfZ+iLmBH1PEQh+5qT5BfVjAtnRBM+/CApB8en?=
 =?us-ascii?Q?pzBdU5d58XsnZHyY2fq+pDoC4iEecPxcFsuMrStkWlI7zC+YQQuLYAeeeEBI?=
 =?us-ascii?Q?uj94eO05wkD6qGijp7unoTIqUgAIDL0nc+jxEZYrOwNwQJxJfIwNFmTSk6xq?=
 =?us-ascii?Q?g/JYUHUtKghUM2jwRJDaTBti3usHSwI97qNxzBSWTdcwzIQAPpMfPvivURxs?=
 =?us-ascii?Q?zf/ioIDrBSclGZkC6D6d323vwOGfqaJbM82ETePXV+ql7WjfIZehM989OaDp?=
 =?us-ascii?Q?MfnOQgS9kwMq4zQbugXjOEctzzfDenE3ZvzjTw4K/p2ky+Ab1NcSAgv39kfb?=
 =?us-ascii?Q?bGLL9X45m7ROOyhjgyAfdHUkFZibMT8yx1u22CuA108/sWS39YsYsPE9Gx9I?=
 =?us-ascii?Q?4Cytk/O/ZPgMaRa9JlfNdMGN0+MCvMvzA8QIqt5oeNUY37U/OwYO8wOeV2H2?=
 =?us-ascii?Q?xjxh8mMy7zxH67tpso8xo/po+lfmYxNsZ1F+8ODGeOQMDeVMvUD4vhnwln5e?=
 =?us-ascii?Q?rlgsSa8nPz10AljRu00QVsq+y3hXb+GHLO4/d3ywVMFXGCzxxWCsWSWL01SR?=
 =?us-ascii?Q?n02rGhs656R/0Gp+G6gMYvoBSGmqMvBw/ZJWK5rkL4ityY3DbeoA+S8Hyf33?=
 =?us-ascii?Q?xkjDBHXxwSWKYIQ4vQRZLo8n9hTS9I7fsMWBEJrrSgitdwoJ2drn8ltUrmUM?=
 =?us-ascii?Q?3JBmGi68MbZW9wr8CkgZrj8u49SI07xOZxPj7c788RHYJ197jbpfPf4Nrki3?=
 =?us-ascii?Q?2KOQil255l3lKczDFyRo+1DvY/mmNV332N0FKKx2YNIcG/L1iwULklIwHuL3?=
 =?us-ascii?Q?miBln8uRVsHPEW9x2rnBdp7EM5Tpw8q0w1yde5B2BcNsaQXWsFYfKqwgNuBo?=
 =?us-ascii?Q?Zntgq+QpDseFwI6lEzZNp/S5JW7qZDqF1GnKxPByXvjDHatYqnC10BrqB81e?=
 =?us-ascii?Q?TaP/xVeYNZC5Tewy3dhbzomhIKATdpCWN6xdOfmpzsA8+8mdm9B0QqW4pTcP?=
 =?us-ascii?Q?iRQrgQZ54jBBpkfSDdV72o+aJ6+34q4uTKc2qXWxFFPv1TIql7mRv+oiWBKC?=
 =?us-ascii?Q?B1W5rRWpVqHr/0FNHbOBLDaGHYAMlG0fYA7rJ9rhLNJI3xaj+cx8VyXcrexb?=
 =?us-ascii?Q?B5PkNm9PFD5SkqrqSP0Pi1hUF+zDrtMrYS5zxV+h5SVzK00/EE+tf2forBzE?=
 =?us-ascii?Q?uq7ACq6VO3xCbNT1v3DrMjTvw3g7CjI6uSsC8MEvHopgKVZFDJlw0GJPMfid?=
 =?us-ascii?Q?IDY++e5DPFT5h44ZdveXauEFVz7YVbvGydv3s4r+q9TilRNS9Gsh+Qd/1++3?=
 =?us-ascii?Q?ssNgr7U8PGadeRQaXd2l45gvFC07SRiClHX9bLv8HqLOB7TbnfRgVqhXYKcI?=
 =?us-ascii?Q?z3BMbnoMbcsOboYMWP5AbSiYVZPRxAzceb90ZzlmMMG7Enkm78x6UzGJNrQI?=
 =?us-ascii?Q?wqAg2Q2/RsktU8nHxj70xekB9XsScL08f/Xd5Wjej3iEjfUxlikzEyZjLG3b?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb80b0-5209-4441-964f-08db1af89b70
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:32:06.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7yQbPCcDwOb7q8HhOUQ3+5GbHDnInFB7w0ga+9uGOHELVgI9vGBvV5YZUNxj26bJtcJCsjU0aGq+xEyd31Fdxhcqbcs9OjRcOLS9Dp0TVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5521
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 1 Mar 2023 19:29:40 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Mar 01, 2023 at 06:02:15PM +0100, Henning Schild wrote:
> > To describe the dependency chain better and allow for potential
> > fine-grained config tuning, introduce Kconfig switch for the
> > individual GPIO based drivers.  
> 
> ...
> 
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+=
> > simatic-ipc-leds.o
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o  
> 
> Have you tried the configuration where all three are Y?
> 

I tried all m and will also try all Y. Why do you ask?

Henning
