Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781E6C7930
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCXHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCXHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:46:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4CC227A7;
        Fri, 24 Mar 2023 00:46:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kowqkBDNBMNew3CzQ4RAWNqXR1nxxF4xHFBiA+Z6Shck4I3KYtFb0m6N1cU+jHMBru53XTpshshVyWlU/1y1lhat6se9YxJVsvLS7jHn0hQVWs4SciqE5Cgv6r5EkoyEtRqRwgmkMSCjoFasZz8M/qzLFx/16jvgAeZvhegyN7qarRYyi6GLOi6Rxk2TVPhOYQlPcsY8ZHxjSEV+AmmQUyg3MA00tJwBHYeAUyL3iwawFPmLdHhDToPmxTEFFFaNZ8wkNQDcabK6XpsTSMMn2Hfjv4TZYki4z9AHqOwpX7i39iVJbGqXFYbIKXQ6doJFMJ2F3WYQibcr3+az85p7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpVGKEOPANNe5RqP/xbW3bJwcGT7QM52nylc4xYUJ1M=;
 b=POx0yQ48kfY9WlptlvbN6NyPMv2ZOhVCj0Z9HORINaJBtfV/j3wLhQHtDxS8ZtKaiL7PmJLBN60ezYySNviwCRdzFdMKy5F8XGOzco4xBDiB+EjWSzRIhSVrEay1w5utRfmR5LuRp3mAqyGTHCTfLeBL5vy5ZDyLnpYU5CQw1hYejEcEUWMcjYt8XWgUk1WS34DDnKGRoiIAkrwLXXEMnNQHco3JN6exU6+9vJQTm5mGq2PGJYOyUele9rb1BlnL+zdvUXx6/KsqqLBEfkuKhBD4ZPp7N9hOVu0bIEBYcvZDkyxIpQTB0qajWncWclHy/N5Po0Qi2uonNgD+tMKzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpVGKEOPANNe5RqP/xbW3bJwcGT7QM52nylc4xYUJ1M=;
 b=G8S/7Q4zmONv0G+v8giJdt+P+zbtGeWtnkJbdd3MyNj8CtxLNxyuYxr2CsIQLTIJAObTlmcqJbsPlZ/sReb/IPBO8+fIOvEWPD+KpsWqgvAQYKxjOMURCuwXfLLoH2UwlwhIN30j5PNzKS1wEAovvs89rLUUBC1J+7qsEfAIKtzeeH9mRaYjCw2BNB1050TZ9v9FNPu3mckMxyJccPfLRO7e3bKreaEMry8GMrGrI+UzwKVWcUsFWpwWZsqfw4zhSDFDCcPOCdcX2DKjFBFPqB8kMpAejQfauqAgw94ZAUNymP28qRWl/HqTGBVq/ixPraRTJwryqwIV+hboD2S2dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:46:02 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:46:02 +0000
Date:   Fri, 24 Mar 2023 15:45:49 +0800
From:   Chester Lin <clin@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v3 6/6] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
Message-ID: <ZB1VLbvTudD2Ye5C@linux-8mug>
References: <20230323144833.28562-1-clin@suse.com>
 <20230323144833.28562-7-clin@suse.com>
 <CAHp75VfnVzrVLUpXdspw1H-e4qxVzia+hf_2uJ5xgSm6Q0C7ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfnVzrVLUpXdspw1H-e4qxVzia+hf_2uJ5xgSm6Q0C7ug@mail.gmail.com>
X-ClientProxiedBy: TYBP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::31) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: a05d1d4e-515f-473e-eafd-08db2c3bd0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRA2QRefVhOQCGfhjnMjvTYJZAQ5LqO0iOSGNnIe6Np7gWNv2LhLw1QwkBaQeANqjmc9/F5CMl0qQMfpya2oPI5AW7efof5I/fzm2WFt8yuiBljm2PMYsmoMyyfdZOxCkUL8qrAqti2dPoC61TH2o2sPIOSf8pKTX+01T/RgqLiToUyVtFNjLFJp+zehAItM9Mg1MUzIdhPNHBgciDnj9LQqWdgj7HGp2tAK696+QfztF94zKJ+alacrUcHbmPWCCa9UPef/5Uu0iTS5+4rchaHQnJna6DKCrmRatJWLsmteDfW38WFrFM6ZLbCyo5zQcfyaOUB7XbFCOAVet+lpX7/xPzUunvTyXBhzFilbqbQ1DRCWTFYRwu2f0Mx84Z4AIh4RIQ4AA2d+e7b8q52Iv4N/uNjJRTtO31RFPxV0BggGoteRUl9gfT4xh8ppLX+ovrC9pqCRm6zXmq3s+IjeSeNPsPH3LuyAEmdfHnvutrLRtamWIYmwddZp/HEmok+jIlLx/ytAAajF7Es93hM7FIFZez7Iq/STuBnJhUPyXdiTJOH3IYJ84rtGnxulJrcgSx1RMREeDWQxqrozIlsyY2TO6HIZQnyniWo+M7jsRV1WO9Tij4xcOCkZZfPmA223kcGA+88HInvGY+j+dsO+Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199018)(478600001)(4326008)(66476007)(8676002)(5660300002)(66556008)(6916009)(53546011)(316002)(66946007)(6666004)(41300700001)(7416002)(26005)(107886003)(8936002)(6512007)(6506007)(186003)(9686003)(83380400001)(6486002)(33716001)(54906003)(86362001)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJzQjdzbkxFdkdncFJFV1hXZFMxekVlMnNiSTJoVmQwRkg4VUI5a0tVcWll?=
 =?utf-8?B?c1VLL3JzZHVYQVRYZ1JEMHNMQmIxanA0RHFyMTNST0xvTkwzc0Q4WWhHbUxr?=
 =?utf-8?B?QUV6czVVVFBkOHk0YWFET0VoSVhWSXhNR3hZYXR5aHo0dDRHc01qSXZrZlRu?=
 =?utf-8?B?MmJiM05lTEtoMmNBNnFHZFhWU3lUeDNPa2pXZVpqUzdScGx1dERzVEt1eGhh?=
 =?utf-8?B?enhTWFRWS09xa2tZMlZ5cVNvYnE3NlpKU0E0TUxrNlBiZmdUd1RyRmg4em0r?=
 =?utf-8?B?NlpYL1JjZnduUittRTFZZlBoZndnT1Z0bFlUVnRnd0tRYUdDczJwbTRPZjJC?=
 =?utf-8?B?dnZzVGtlVXVBYzJmNGhvMDhCVVRpNDNWNlFFRFBaSzRkTzRLb0d1SFY5S1l3?=
 =?utf-8?B?VnlHUHc1UElVWWZnMlNEMS84NkloOVhjNmtkdTdNMVlFWWpjTmw5aTBFb1ZU?=
 =?utf-8?B?Z0NpVklNVUJCRHBZM3Q3WHFQN2MxNW04ZWZ1Z3krQmZocEFQYVZkMDBEaVYv?=
 =?utf-8?B?SzdjUndGMkxwcTRXNGVPTDNQQmtGM1VSMStxRGtlaFRWR056dFFYNTRmUkpv?=
 =?utf-8?B?LzFUOFpFdjdQTDFsMFBxRW1OZEtkc3lzeDltV1JremxrVnpUOXN0QTdVcGxv?=
 =?utf-8?B?dmV3TXpnM25HaU1XM2JLdU95UW1rR2hJbVVQVkJQdXlHeXFvMUJ0UmxkVUVN?=
 =?utf-8?B?WldKU1ZyZ2xwLzlaQTA3Rml2V05wL2pDUHdONHBPV1hIUDY4c1plVG8ycU1V?=
 =?utf-8?B?SG1KOVg2ZFFOTUhJNEF3WnVaNHlCVXQ2SDdmL2NVTFdFYlZQdkJ0RlQ4U3pR?=
 =?utf-8?B?MEd3REpvZ3h3dTBQeUlqMXM2NldJb3NQOG96VU5RQ2NmbFdMZ1oxWVplcFpF?=
 =?utf-8?B?L0EwTEEwL3EzUGNXZEZ0WDVncTF2L2NtR0pDS1lOWFZ5dTdWODBCSldzZi9z?=
 =?utf-8?B?L1lqellYNGtHN1Y4d3hCVG5HMHZQbXFtbUtWYlN6WGFyWGJSSHBFT0JLNmZT?=
 =?utf-8?B?OXd0SXRZT0NYV1N2ckRWWTBsdm1OSnlLOTJwNFNRQ0JUYVdDQkZOKzE3VTBr?=
 =?utf-8?B?Vi9IN2JpcGJoRmcyRTZEMUlqMXdTQWdqOGNqREJ3ckdMZ3VVdWU0dlFvd0E1?=
 =?utf-8?B?UHhYMDlkSzlmZFBDTG5FdHh2dDdwYko0aDdBSUhNVmVveDh2NHFRRHNzQmg1?=
 =?utf-8?B?ekhiK1ZBcGdsQ3dYWGpOYlFXQjRSMmxuQ3RjV1lMUHRyYXRyUnJVZzBUbENH?=
 =?utf-8?B?c1VTZ3NoSzVKdGVUeEhFV01MSE5zNE40YmxZRy9nV01sVkpDZGJpZzREd2No?=
 =?utf-8?B?eVZxV0pBYm9CcVRVOWduL0RMWW1XYUpCZm1yZ3RSOXJadXNvMlZEY3RqWTBV?=
 =?utf-8?B?UmxsRUhHMGxwbmVpN29aUkNOZjRHNGpSclhTcko3Z2xvc0lMQlR5NE1ocFRx?=
 =?utf-8?B?SmE5WFR0aXd3UU8vSnBiSThDL2tLQWlpOWdCaWJiRnpzRk5QdXlVYTRUYThG?=
 =?utf-8?B?Rm5kdHRCUlF0TXhQRU9mMkg3MTQ4eEFMVXVxbk96aDFVYTZjMUlVQmMwWE02?=
 =?utf-8?B?c1pLakdPWlJVcDhVamVDekRqTHprdEVjZUhxbjdPeTkwemZGOU5iemx5S1JE?=
 =?utf-8?B?dHdUY2thenZydVVFSEd6VDUwWTltQzZJcTRqNWpQOTlTa3Nlc3pCK2hTRmtV?=
 =?utf-8?B?RUFCU010NG5FMXBndGQ2WFJTdk42WERZcjJDbVBNeDhydFV5QnkyNkVlaitO?=
 =?utf-8?B?U0xUSFZqVGloMmhPNCtlWld3RnR1MVFLaTdPZUc5WCtLSURVN1V1T2ZnUWJM?=
 =?utf-8?B?R1AwejY3aHJrSmYzc0dMQjE3R1VxL293VXR6WmN3WjN5TmJ3YlIxYjJscHY2?=
 =?utf-8?B?ejVCcForaTdqbVJzR1BId3R2cGNGK3NZSm45ZWgrb1dBZ3JpYnhtc2F3R2tL?=
 =?utf-8?B?SDlhSWZUS3FZRlpTTlljcWFCcVFzTENpclBwQXM0YUphSFpsQ2xnK1ByWTU4?=
 =?utf-8?B?VTVPMmRBY2taeitPczhPclhpS2haRmQ4VUdXbzgxQU5BRCtWdHNld1NUS1kz?=
 =?utf-8?B?VmwxSmFJbGhLTm5PWmpLK2tISlB0ZWxzcy9nZjJXdm1OQ0J6Wlh1OFdGRjEx?=
 =?utf-8?Q?9o44=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d1d4e-515f-473e-eafd-08db2c3bd0ce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:46:02.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sq7XLJdO6IimL06LFzrmYlyCq4175CdZ+Sa+JNhUcxHSEJUGf0OBE2xMfkulXIaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for reviewing this patch!

On Thu, Mar 23, 2023 at 08:50:41PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 23, 2023 at 4:49 PM Chester Lin <clin@suse.com> wrote:
> >
> > The .data field in struct of_device_id is used as a const member so it's
> > inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
> > because some members in s32_pinctrl_soc_info need to be filled by
> > pinctrl-s32cc at runtime.
> >
> > For this reason, struct s32_pinctrl_soc_info must be allocated in
> > pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
> > to represent const .data in of_device_id. To combine these two structures,
> > a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.
> 
> So, the first patch has to be embedded in this one, correct?

Correct. Leave the first patch alone will cause a compiler warning.

> Don't forget to compile and test your contributions beforehand.

Will do.

Regards,
Chester

> 
> -- 
> With Best Regards,
> Andy Shevchenko
