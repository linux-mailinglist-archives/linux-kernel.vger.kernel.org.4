Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B972DA06
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFMGlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFMGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:41:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A31AD;
        Mon, 12 Jun 2023 23:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/Hf8JvccwkJOfjLgjvOsmZqF/BBGojp6EZ1OzdQmbY7TK3jorjmgP4S5dAw/80WOgE582C5JdThlyXKPHyrpHgmo3S19GgI1/cyZwyWoIEJIbkmiO+Nvdfp5pNprYLz1N6NqNj/hUsVs26x3i2DklgWJNLED4sHSg1gH3mQdY05U5RO3jjMzJKwIyp9rapPlmo7Lhw7ZGe7PbYk50lc9rBPrlo3e1/dQwiSCrXfkyT8cwf6Pe5Nq1ZePCNWpUSqMyHhr6QzB85FeeuEf4ewyG02HuaObNi55Iu4/10zSBDpDiRPR5Nv/be/ODA6veClUEhpLLk5YYS79lY3MBdRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5raGfRpDw1wqrIyxhfIu4rWsziDJwc58/biM5eyh5zQ=;
 b=FGZB+Q5ReFoMWu+gRM/eWeAZo7Q0RZUWHdHGGc9G4bKd3T9VPUl8EwsGBIJI5IpLLN3O2hhaaXPnldOBSItw1G7qEi0g7Pmrz1x3n+dZ3dNoPx8LbJZm6yCZVie+ogFRbJzWZds3sH5nSdYkocnG43p3UDzY94dWpwX1GHeFh85ITINPriOJeBeVfSLJaKxT1m6h/Kw7bahRarBiV/JjFR63q3IZHsONr0Evb/pQqAqcvulQaL8ujVab8pJnREqbhxiQJJImwdAn9j8MOWH3WW4aVSDOboo8sg4tI9jYyuLe3yrblPwOx1emAPkcKNftt1wYquecRrLPUHRr3IFazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5raGfRpDw1wqrIyxhfIu4rWsziDJwc58/biM5eyh5zQ=;
 b=frWYy8KDHf6y4VUv7gN2SaI1eZgnVOY6Ouwiarwe5RSo3dAKB23AA00zc8T/nF251EYoXnYqAQeaFyb2Fjq9o63gtPazA3VOyhtCZeT9RZyFfJ/0W4r1gX2+SQ3MMAcDr7ttxhonvzo94DnBeSz1o5GDq+zMAKjScMsci6FAICFfTtRhyM7R7p5futTLoHguQVKD/FWmG3l8WSOB/iEdfopX+EvZFjvsRZWxnawKwCIzxKvovmASAl8IsT/Lt1B9Bulsr1VqoHvwV2IStMde8gsXxKstCjvuSUoq7F6huqnyK2CU+tUiI37nK6PM4FwaswFVKOYv967+Im7Q4HdK8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM9PR04MB8795.eurprd04.prod.outlook.com (2603:10a6:20b:40a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 06:41:37 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::7840:68b7:3d49:6bf7]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::7840:68b7:3d49:6bf7%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 06:41:37 +0000
Date:   Tue, 13 Jun 2023 14:41:27 +0800
From:   Chester Lin <clin@suse.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, s32@nxp.com,
        linux-gpio@vger.kernel.org, opensource.kernel@vivo.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Lu Hongfei <luhongfei@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] pinctrl: nxp: Fix resource leaks in
 for_each_child_of_node() loops
Message-ID: <ZIgPl0UShltd0VEe@linux-8mug>
References: <20230606070201.14249-1-luhongfei@vivo.com>
 <fca44dcf-e632-fed6-aee9-03a5b0c6b1d9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fca44dcf-e632-fed6-aee9-03a5b0c6b1d9@web.de>
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM9PR04MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: e64e1d45-c407-4cb7-944c-08db6bd93c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJV05FErXVoHPBki8Ut5WL2VVfcQHG2cBnHnPyKwFvZC8TEL1zpVQsyYRQHnm5ROcxBf4rbNj+GA246Sk41E/9D6XWShfg8CUzMROxU4EIJKtUMjHYkaF90+T8hLYDlyczDjljNP9xQYjDbfZhIKyPRJ2v9IxjCghQ+u3Jg021RoD0bjwNT8kYHfsrB2ZFVBDuuPkz0dswzidzGwJqYku++seoKYKUEq0X/0iT+xsCvQPqtYts/h2Kv3Li+L47cHCbMO/8FQrs+lhCaPYDVx5P+OrIDMkM3za0nyUuyZijmhhAcvoxh9pLWCuTmzx+T1OKiH4JVOcQNclnuOeSW/auN2yb7iVVHI8XljCmLGCtzMUgJxSRZ5KBuzDE2paHKE8sDo22pEJqd/Uns01hYZBh3goBjXNZd7CFcuHDIfbadSHhuj5/feWhrAUi8Jfly0QQnj6Mapo2oIdzE+lfd9g8IKKaBJgIKc/jqkeKHqhlT5zsLDR5RmIdAmEQbJfllK5pxYyNPFRAjBJa3x97a8acnF1n1BfRE8S2YwTXYCaJ7D/KyaLg4Qr+6E7/f+RsS1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(6486002)(316002)(41300700001)(9686003)(26005)(6506007)(186003)(2906002)(4744005)(33716001)(86362001)(6512007)(38100700002)(8676002)(5660300002)(8936002)(66476007)(66946007)(66556008)(478600001)(54906003)(6666004)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JlVTlsT0NkN1N4b2ZpNDFqZGMzQzhhVXIyNTdwWTE5QkZpcGoxY293YTVx?=
 =?utf-8?B?VVNEalk1YmRBNWZqYlNPVFcrbitTYnlwNjBnemdiYVFmb045d0hBc1pEaTVp?=
 =?utf-8?B?OUM1ZDZlWE9ZNUVNRmdXK1pPbWZaOXhDWUNFVHI1bFU2TEdTd0VweWMrSjQ5?=
 =?utf-8?B?SXMvNkVVbTdtUmxicEVQaEhMWStGekl5NERsZjZhR1pHVi9XRkljcXQyaGlF?=
 =?utf-8?B?NC9DWlZRcndqaHZJMzkyRURsYU0vQXJBUnd1Y1dTZnlaRExuZmpuMTh2U0px?=
 =?utf-8?B?VHZ5Q25lT25ZS3Q3T0c3dFRncXE5NnJmaE1rM1Zvd01QcitsdTJaaGh4aUlr?=
 =?utf-8?B?bkU2OWw4VnhjZHdmdVNiZkkzTmxFN0FrSW45eUliZFpVZHZWNG1XRkdjdFlW?=
 =?utf-8?B?dFpJZVVwOVl3U0pFeGEwczZ2b211TXdzWlpUbzZ6YW9WKytOeDdXUEpYeWtq?=
 =?utf-8?B?K0p1eDdBYWhBNTBsUkVKbGFIeForN013L1doTzZBWGh3ei9QOUtoMVZyQURB?=
 =?utf-8?B?QXgwTTB0RkxMZ0dVMWhUcFFMdFVCVU9GR3dkcVZLb3lZY2FvR3Uwd2NuS01i?=
 =?utf-8?B?NWxZMDAxalZBVVhqM2cwSXBUVnhDcVZhVzZIQXMvUzJ5WnpKZE5LOHhFbmJo?=
 =?utf-8?B?TDIxTmljYkxBTGJFdFdsbU5DTmxLL3dJWWR3Q1o0ZEhoVUFMSmN2WjhEUFNZ?=
 =?utf-8?B?OFdkWlZLdER0bW9EYWQ0eUxXOFJjejdNNXFJYzd5eXkwM2EwWGJyMnh0cm94?=
 =?utf-8?B?UjJDYjA0Q3pabWNPRjZmL0ZQajRzUk1sR0U0S3RSUDI0cGdFdjNDT21abUZL?=
 =?utf-8?B?amp5VWpNeW5tNnh3RHVocSt2QzQyUDdLRUZtRE9CUm9kZENxUGFlZ2QrZERz?=
 =?utf-8?B?dFdaZ3cwOHRSUS9wZHM2NnpqZTk2RU80QmU3Qytsd2M4bE52K1FSVXVhYUZT?=
 =?utf-8?B?WGsrcWRyRFBtT0tsZlhDd3FxZ3I2VXo0OVZ5Zk1CcmREdTNIbzVXczEvNlll?=
 =?utf-8?B?NHU3NzZ3enhQQUVWaERuOE1GQ1czZjZvd1FoKzI3UUZPZFMrem1VODczYk5O?=
 =?utf-8?B?ZTBlUXNWTDltZjlvcGQyNXdUQzU1K3c2NVZUSENJVnJEdXRGSkJKd0Vjczdw?=
 =?utf-8?B?OTRYWW1KSThHK291bHRxVU1vTE1uTVFNM1BnSStYYXV0K3NpRjNhUGJWNzZO?=
 =?utf-8?B?b3Rubm1wM1RXb1RRb2tKbFB5WE5BYmp5aDVlT2dhcldMaW56enFOVmZJUUhG?=
 =?utf-8?B?ekdVOFoveVdlcm5XdEcxVCtHdmRZNXRjQ0pFdERvSTJNSlAzWmtRTm0vU0Nq?=
 =?utf-8?B?SlZsRzZwRUwzTU96eWNVeGRyUHZXcllCV0FkV0h2UlFGcENjdStDWTcwYS9x?=
 =?utf-8?B?TUxNRm1rMzAvMDZTRmp1bGxLWnhkZGxhNW1DQk9Xa3NPVFBqSlR2dHV3YSsz?=
 =?utf-8?B?V3VqZ0NYdjJpdGdYRldlNWxwdjF1ams0ZmxQcFJJdmR4NUNhUjg5ejBuMkcz?=
 =?utf-8?B?am9BZllLbkdIeHRHTDdYdzRQNEpZWlpwZWgxMDkyR3pIYk01bzNXMEZMQW11?=
 =?utf-8?B?VHViZXhEclFGSTBJZFdIQTI4SmI3N2JOWEdid01pYVpyMEJHRVZGK29WVzNk?=
 =?utf-8?B?cUF3aVJhWEg4L0Y4U3FZOEVNbEtHQ2wvUlIwaExPdGI2SnVWdEFTUGFzV0FT?=
 =?utf-8?B?V0RwMldMUmwraEc4TWw3WkN5c0VEWmpKMkFWNXRHVmFNOTF2ODl1QjZtM2t6?=
 =?utf-8?B?YXN6TjVMNU1XeEVCb0tPUmhjQ29DREtiYUhYVEJkcU53Vlg0Y3oveHAxcUVN?=
 =?utf-8?B?cGxrRVpoMEx5Y005RHJXcURTYnUrUCsxa3dpVytNL3dEcENISHdZSUJhVW1I?=
 =?utf-8?B?MVM0REc1ZDRzRWt1YjZ6c3FDNnczTVczc3ZpTDNQMGQrL3ZJeFgrUE9DSmZy?=
 =?utf-8?B?azhIOGZpMGhzQ2t0SVpaaG9pMm1XN1pYMWQ0NVlOaktFQW56NDI1VTRHYTdX?=
 =?utf-8?B?UWVtY1RBUE5XZFZ1UmNpbzlsNTZCV1Z3Zi82NjBDWE5pbDJZSlBMZUM4RFFz?=
 =?utf-8?B?MHNGQk1vK1Q0ODhRZjdpRjRUWVc0ZldmK2pVSE9UR0UybWluTllKSWdvbktm?=
 =?utf-8?Q?C6qs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64e1d45-c407-4cb7-944c-08db6bd93c34
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 06:41:36.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0+C0sUCNWHikEp+P1RXO0w/Yl2z4899tbkCmBwSAjry53qev28WAmKWHOM1L6Qi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8795
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:01:00PM +0200, Markus Elfring wrote:
> > Ensure child node references are decremented properly in the error path.
> …
> > +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > @@ -279,8 +279,10 @@ static int s32_dt_node_to_map(struct pinctrl_dev *pctldev,
> >  		ret = s32_dt_group_node_to_map(pctldev, np, map,
> >  					       &reserved_maps, num_maps,
> >  					       np_config->name);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(np);
> >  			break;
> > +		}
> >  	}
> >
> >  	if (ret)
> 
> May the same error predicate be applied at two places here?
> 

I think these two error predicates can be combined together in another patch.

Regards,
Chester

> Regards,
> Markus
