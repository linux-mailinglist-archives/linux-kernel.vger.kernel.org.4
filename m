Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2136C29A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCUFLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCUFLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:11:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A21C34C28;
        Mon, 20 Mar 2023 22:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AioHCcPA5F8I3D+l27QL92mwXL524hwIefYqxMJRHS2KIOknVzRngV3lk3pvEBfdxBLzvZqNA7kcBPM8YayC1pWRJpil2klNBQIvwTK1kt04Jl52GQKurRMP12PfsAqwfLygpC0nzSpzsd48XZufXEHLtcDvF5d6xsDcyGIM4DU3ROBrg+S7bQqkJlYuX4ALvlVDT/hhX4f+B8Fe8cg1e/zSEXBzO5qOviJvLEYXUC8Kz44rkUqBQhkNKmNzCaMpRv3oztW6E1/sB6txglqDFmjWwKmxor+0/gRzEpJsar0EV9qyZzToCEoPyhupQs98430YoEdt9Fxin0DOYtwr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysjQpHp2o1y4RgL3OZJueo+b1SptdMMHry6dea+91bU=;
 b=QB+FhZtN5gmelBijXs2us302teweIKQr/mb4b7Rl5a1BbX4BLxqBiJl6kudV2dtCZUHgGtWRvpSWTmwKzT1xOyPq0lO+LkebhcBCC4GOZNbQ9El92Ia00OJlC7/yfIFhq+9RKA1xkaQfZB5nRCdib8T7teLvidkv3KKq2p7e2LnWHeNy2Q92ewUoV3wHRBzP1GCy7r+YNjymKgjm4RjVRu8uZZEeaHGiXUAT38pHtdYlR4IY+QQFCzFB5VCvvJv8DVBRVFuCqrEBL2vH5EWF9YGiI01VSoAVdi0MhbFiZCVb3QSoQ1QDnDTzWXohs2EuRH65ZwDNIYIRBI0YP5Qo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysjQpHp2o1y4RgL3OZJueo+b1SptdMMHry6dea+91bU=;
 b=E5gzwBfSia8R8exjP/DOtJPLkeq06BysHNa9Ty31k/S8JyMku562tdjRdHsY5+5AQ6Oev2wNlmweNuvJGLKdf3ttdseunul2NSGDLFTD8wktxVCbqju4GPXIFlL7r6nnHRqCT2vh18ZmarX+dg9otd35g0nRCLEmaS89Onui+cE6V+b2SLqjCw5GIBmIZ2Oe5dZSICyso+MnygsweLL1lThSmwZBd9a7gNT/Iur/f231etPepjsCu21WK+zOPbRTaQhQhxh2tEEMKuiszr619NuTBJfkyFTUqlPqwGQXvEYRmEIpxCKBJyqD4CY/8PlSmNj+z5o7c8Wr9XzK6ttytg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:09:32 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:09:32 +0000
Date:   Tue, 21 Mar 2023 13:09:18 +0800
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
Subject: Re: [PATCH v2 4/4] pinctrl: s32cc: embed generic struct pingroup and
 pinfunction
Message-ID: <ZBk7/h4nquwZShv1@linux-8mug>
References: <20230320163823.886-1-clin@suse.com>
 <20230320163823.886-5-clin@suse.com>
 <CAHp75VfFTjPFMQ91yHC4O1enTJqtww7ur8ppwa1rqT_7WNzDTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfFTjPFMQ91yHC4O1enTJqtww7ur8ppwa1rqT_7WNzDTQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a480f-d405-4a68-2dbe-08db29ca7476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fURAf4bolx0nEkfhGwspvqAi+EUjZh3yR633yd4evI6NAIX7kgLtOmtdhp1HLXTMZMfrhLq3q29eCYAIUk6Gdvz87FIFwPf63KPgcJDTYs/8tn88wua3QyDIk5B/jn3jfWBV7ZH3ugqXYWGAuQzEHHxwBJXPyrJFlUzL5bfBfE25srvKRUXbOqhCcdbUtJxAROxv19ivapJBHsKt5+hSga557BSl59e3c+QqZyToKCTe1cT8wyMcsJN4mfkN8m2UH7VJyfvTlvEUUatX0+eDsGYP3HM2CcAahTA/bXcT/wFgzwZjQHhvv7m4ba22t2iYit8edGQmkeSQBvCtHejiHUKj8sJwwondpLWqLT1I/c41neJhl8sZOaie0eqQ5UktwvimB5G3wv15Pr+C6MsxqNWaLVQLarX4ZkBF8n5X+oEl+VBu4cv0DYSX4OtmtlqXL2pyU7PnfsqkUvTeaSkwFiSm3XIhSctnCPk3klgHsLDKaZTwTv6LM4ixcYRrhGZ0ZpQzMD4s9I7MwNPly5951BDv0xvQanJWdTClRdB6Arwqw7TfjDGahJcAzBPtWGyp1safeEqNkOdl9PPIoXPDujzfzfJ9nwR+wgFzK2eVID4JPdBNpuaD/0ahhTB2G+CoZ7vsAIMQQsQ+niPbK/45Gr9fcBYhAxV5BuU3Z4d0T74R2wS2GuPbHljorFbnu497
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199018)(7416002)(5660300002)(41300700001)(86362001)(8936002)(33716001)(38100700002)(2906002)(6666004)(4326008)(6486002)(107886003)(83380400001)(478600001)(53546011)(186003)(26005)(6506007)(9686003)(6512007)(8676002)(54906003)(316002)(66946007)(6916009)(66476007)(66556008)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9ua05Ud2JyQ01KNjdEVDk0bkdDTk1TZnMwRWxIV1pjMVR4M2pWUnptSVQ5?=
 =?utf-8?B?OStTUTdjbnE4YmhFMllCQWF1K0dENXFWa2NVN3F1eTMwMEdVTitKM3IxWjNE?=
 =?utf-8?B?ZVQ3V1FFUW50VDRiYWMwaGhXVE51VFRaWHRKMjlGWUZCMWU0dlJPOWZXQkdQ?=
 =?utf-8?B?RUQwaXVSTUc2YjEyVVBES3pZS0o2dmJMT2xvWTJTME5zeGtiZXFyak5Rd295?=
 =?utf-8?B?Slo4NisrSE5UbUJhT21WQ016Rk5DTEFjbDE4VGVxaHpKaTBOOVE5bU1PUE1t?=
 =?utf-8?B?Ykg5YTVhMmxkSG56R3hGbG1URUNXY0xwYnRZRCtXK0dPQzJlTDVSa0RwcUw1?=
 =?utf-8?B?bXhkVDF3bGRsS0JPSEhKWmREUjNUVVN0VE1OYTJ6TTN0Zms4Rk9xYVBIbU1C?=
 =?utf-8?B?bGdTdGU1aHdicFMyc2JrdFR2cVJNVHlSeGdwK2NHcFV5YlBIRTNKbHh0Wkxu?=
 =?utf-8?B?QXovRkt6dXlpcTFFWTk4SUJjLzQ0ZVlzSGwxb3RsbHlZQlJ4T3BjVVRHcTIx?=
 =?utf-8?B?dlBseERYR21LQzlwVjhObCtUVXR5bVA1UGhOUjRndW1UZmdWN1dwT0N4QmU0?=
 =?utf-8?B?ZlgwM3R5a3dRMVBsOFpOT1Z6L1VrczFrRGZvZUZEczRrRFd0V0JKenpxWHhO?=
 =?utf-8?B?NC9TM2hZa0dFQ2JMdXkvWUpwWWRxMktyVnk1MXlCdUxDS2lXdlZpZSttUGF3?=
 =?utf-8?B?eGZkK01zS1B5TXZGMlBBU0ZOdGNObEtYaFJKMlBDQjdKV0xSbXpwUUN6bDRt?=
 =?utf-8?B?aHJZZEZRZW9JLzF0UmNrKzhLMXAzb1dzSFM1QnpSbGxWQXZISzhweFFaYkZZ?=
 =?utf-8?B?MWZwUER4eFMxNVo3dlp3TVl0dlZUMTJYSUVOUzBjNzdNZzR3c2I5SjRMaFpR?=
 =?utf-8?B?ZS8zUWlweTNuemxIYmptOWFiYVZSQStjUjBjdlVFVW1MenNGUmY3cjRoMTB5?=
 =?utf-8?B?anA0bDlIWkRBUUpFVEd6M2ZNT0t3aG00ank0emFJQmVOdGtCN0hlY2JvVHlk?=
 =?utf-8?B?MFQ4aFlBZU9Ia3dGUmw5cjBDMjBqWVgyTC8vS2xHZE1IUnRxdElYakVvb3l4?=
 =?utf-8?B?ODFMbEFnamxPY1hFcXFVTnUrenRtVG5KQlBJZncxSkhsdzdsamkzNU5nVlJK?=
 =?utf-8?B?YzNOTTZUQ3FsK0ZTS0RNeGdzN3pYS3pEQnpEUW1heXcrSGoyZUlDdXN1YWE0?=
 =?utf-8?B?L2xBaWN3VzdHSXk1Y3JnSTAzcDNZa0NPVGxjMlRJK09FWDFuR0xab2V2ZWs3?=
 =?utf-8?B?T25lYWRVOTFRTjdBTTE3ZTNRbXFtNlFGYlRJUGdFYVdWVTduSUlvNmdrNTN5?=
 =?utf-8?B?VGpBRTlqT09XcnlFaXlheWowaEtqSFhsNEdYeUp0NWgrZ3k1ZWgwVnFDYUtm?=
 =?utf-8?B?Z1dRejhFdzAvNFN0ejhlSjVoQnIzWWhaLzE4WWNKZjU2M2Z0QUgwZUtHQTBs?=
 =?utf-8?B?eE80VHc5RmNsNSt2YjRYRUE2Vk5lY0F1Zjl6RVl1cDJCdzFSbGdKcmdjVjdP?=
 =?utf-8?B?U2FLeCs4QmcyMU5vZmRRejFEbXN1VzlHSnVsWG8wWEF4Ky9nMkZxajZaT0RC?=
 =?utf-8?B?ZTdLdTcrTS9yUUptMFZGN1Z1LzlVQjRENHFaanlBekhvOFBRTWI4MWc2dExO?=
 =?utf-8?B?dXMxWm8yci9HV2tkSW9TSE9IZ3l5VHdiY2VFaFB5VWJmcURkS2NzQWZtQ0dw?=
 =?utf-8?B?eUFZTCttQ1JCRkQvMFdtZ2F3ZEtDcG1ia2Y5MFFkMkxMcDJrWUNqWnk5UXJq?=
 =?utf-8?B?M015ZW1UWVNkcXd6enlFN0pQdWh2SVNSUmhCUFBnQWllL2RkTzNEbUd4WUZx?=
 =?utf-8?B?TVdzNkN1aHJoUnFmOU94TEF5UmJETktUL3BjbVdBTmVNcGtUejNXMGQ4OTdP?=
 =?utf-8?B?aGhCZ0pkblcxNklUNTUvclNqWk9EbVcxR0JHTDNLZ3UxNXl4bk5hY2JtNENa?=
 =?utf-8?B?VFd5Q3NLb0JjMUhXLyt2QVdVNG0wMEsvbENCajVvOFhqTVp2ZlQ3WE9SQjJT?=
 =?utf-8?B?VDg5dGRtZ2FNSDJEeVBOcVVuYW1EZFdyNTVVNTZmQ2wwMG42WmR6bGR4UzJ1?=
 =?utf-8?B?V1B1Qkx2VTZWUXE0UEJzcC9mbmhJL0ZLL0t4TFNCZnVkMnMyS1RwbG13WGMv?=
 =?utf-8?Q?Nv7s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a480f-d405-4a68-2dbe-08db29ca7476
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:09:32.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVyZ7yjPpeuydqUt3z4t+RJD0T+CJH+NMTT9kN0Z3KVOBeaHG6GwG9XUwKej5DuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:10:40PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 20, 2023 at 6:39 PM Chester Lin <clin@suse.com> wrote:
> >
> > Use generic data structure to describe pin control functions and groups in
> > S32 SoC family and drop duplicated struct members.
> 
> Not sure about the need of the casting, see below, otherwise LGTM.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> > Changes in v2:
> > - Simply use generic 'struct pinfunction' rather than having extra 'struct
> >   s32_pmx_func'.
> >
> >  drivers/pinctrl/nxp/pinctrl-s32.h   | 26 ++--------
> >  drivers/pinctrl/nxp/pinctrl-s32cc.c | 76 +++++++++++++++--------------
> >  2 files changed, 45 insertions(+), 57 deletions(-)
> >
> > diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
> > index 545bf16b988d..2f7aecd462e4 100644
> > --- a/drivers/pinctrl/nxp/pinctrl-s32.h
> > +++ b/drivers/pinctrl/nxp/pinctrl-s32.h
> > @@ -15,31 +15,15 @@ struct platform_device;
> >
> >  /**
> >   * struct s32_pin_group - describes an S32 pin group
> > - * @name: the name of this specific pin group
> > - * @npins: the number of pins in this group array, i.e. the number of
> > - *         elements in pin_ids and pin_sss so we can iterate over that array
> > - * @pin_ids: an array of pin IDs in this group
> > - * @pin_sss: an array of source signal select configs paired with pin_ids
> > + * @data: generic data describes group name, number of pins, and a pin array in
> > +       this group.
> > + * @pin_sss: an array of source signal select configs paired with pin array.
> >   */
> >  struct s32_pin_group {
> > -       const char *name;
> > -       unsigned int npins;
> > -       unsigned int *pin_ids;
> > +       struct pingroup data;
> >         unsigned int *pin_sss;
> >  };
> >
> > -/**
> > - * struct s32_pmx_func - describes S32 pinmux functions
> > - * @name: the name of this specific function
> > - * @groups: corresponding pin groups
> > - * @num_groups: the number of groups
> > - */
> > -struct s32_pmx_func {
> > -       const char *name;
> > -       const char **groups;
> > -       unsigned int num_groups;
> > -};
> > -
> >  /**
> >   * struct s32_pin_range - pin ID range for each memory region.
> >   * @start: start pin ID
> > @@ -56,7 +40,7 @@ struct s32_pinctrl_soc_info {
> >         unsigned int npins;
> >         struct s32_pin_group *groups;
> >         unsigned int ngroups;
> > -       struct s32_pmx_func *functions;
> > +       struct pinfunction *functions;
> >         unsigned int nfunctions;
> >         unsigned int grp_index;
> >         const struct s32_pin_range *mem_pin_ranges;
> > diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > index cb8a0844c0fa..4ed0cc905232 100644
> > --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > @@ -188,7 +188,7 @@ static const char *s32_get_group_name(struct pinctrl_dev *pctldev,
> >         struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> >         const struct s32_pinctrl_soc_info *info = ipctl->info;
> >
> > -       return info->groups[selector].name;
> > +       return info->groups[selector].data.name;
> >  }
> >
> >  static int s32_get_group_pins(struct pinctrl_dev *pctldev,
> > @@ -198,8 +198,8 @@ static int s32_get_group_pins(struct pinctrl_dev *pctldev,
> >         struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> >         const struct s32_pinctrl_soc_info *info = ipctl->info;
> >
> > -       *pins = info->groups[selector].pin_ids;
> > -       *npins = info->groups[selector].npins;
> > +       *pins = info->groups[selector].data.pins;
> > +       *npins = info->groups[selector].data.npins;
> >
> >         return 0;
> >  }
> > @@ -314,23 +314,23 @@ static int s32_pmx_set(struct pinctrl_dev *pctldev, unsigned int selector,
> >         grp = &info->groups[group];
> >
> >         dev_dbg(ipctl->dev, "set mux for function %s group %s\n",
> > -               info->functions[selector].name, grp->name);
> > +               info->functions[selector].name, grp->data.name);
> >
> >         /* Check beforehand so we don't have a partial config. */
> > -       for (i = 0; i < grp->npins; i++) {
> > -               if (s32_check_pin(pctldev, grp->pin_ids[i]) != 0) {
> > +       for (i = 0; i < grp->data.npins; i++) {
> > +               if (s32_check_pin(pctldev, grp->data.pins[i]) != 0) {
> >                         dev_err(info->dev, "invalid pin: %u in group: %u\n",
> > -                               grp->pin_ids[i], group);
> > +                               grp->data.pins[i], group);
> >                         return -EINVAL;
> >                 }
> >         }
> >
> > -       for (i = 0, ret = 0; i < grp->npins && !ret; i++) {
> > -               ret = s32_regmap_update(pctldev, grp->pin_ids[i],
> > +       for (i = 0, ret = 0; i < grp->data.npins && !ret; i++) {
> > +               ret = s32_regmap_update(pctldev, grp->data.pins[i],
> >                                         S32_MSCR_SSS_MASK, grp->pin_sss[i]);
> >                 if (ret) {
> >                         dev_err(info->dev, "Failed to set pin %u\n",
> > -                               grp->pin_ids[i]);
> > +                               grp->data.pins[i]);
> >                         return ret;
> >                 }
> >         }
> > @@ -364,7 +364,7 @@ static int s32_pmx_get_groups(struct pinctrl_dev *pctldev,
> >         const struct s32_pinctrl_soc_info *info = ipctl->info;
> >
> >         *groups = info->functions[selector].groups;
> > -       *num_groups = info->functions[selector].num_groups;
> > +       *num_groups = info->functions[selector].ngroups;
> >
> >         return 0;
> >  }
> > @@ -602,8 +602,8 @@ static int s32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned int selecto
> >         int i, ret;
> >
> >         grp = &info->groups[selector];
> > -       for (i = 0; i < grp->npins; i++) {
> > -               ret = s32_pinconf_mscr_update(pctldev, grp->pin_ids[i],
> > +       for (i = 0; i < grp->data.npins; i++) {
> > +               ret = s32_pinconf_mscr_update(pctldev, grp->data.pins[i],
> >                                               configs, num_configs);
> >                 if (ret)
> >                         return ret;
> > @@ -637,9 +637,9 @@ static void s32_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
> >
> >         seq_puts(s, "\n");
> >         grp = &info->groups[selector];
> > -       for (i = 0; i < grp->npins; i++) {
> > -               name = pin_get_name(pctldev, grp->pin_ids[i]);
> > -               ret = s32_regmap_read(pctldev, grp->pin_ids[i], &config);
> > +       for (i = 0; i < grp->data.npins; i++) {
> > +               name = pin_get_name(pctldev, grp->data.pins[i]);
> > +               ret = s32_regmap_read(pctldev, grp->data.pins[i], &config);
> >                 if (ret)
> >                         return;
> >                 seq_printf(s, "%s: 0x%x\n", name, config);
> > @@ -732,6 +732,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
> >         const __be32 *p;
> >         struct device *dev;
> >         struct property *prop;
> > +       unsigned int *pins, *sss;
> >         int i, npins;
> >         u32 pinmux;
> >
> > @@ -740,38 +741,38 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
> >         dev_dbg(dev, "group: %pOFn\n", np);
> >
> >         /* Initialise group */
> > -       grp->name = np->name;
> > +       grp->data.name = np->name;
> >
> >         npins = of_property_count_elems_of_size(np, "pinmux", sizeof(u32));
> >         if (npins < 0) {
> >                 dev_err(dev, "Failed to read 'pinmux' property in node %s.\n",
> > -                       grp->name);
> > +                       grp->data.name);
> >                 return -EINVAL;
> >         }
> >         if (!npins) {
> > -               dev_err(dev, "The group %s has no pins.\n", grp->name);
> > +               dev_err(dev, "The group %s has no pins.\n", grp->data.name);
> >                 return -EINVAL;
> >         }
> >
> > -       grp->npins = npins;
> > +       grp->data.npins = npins;
> >
> > -       grp->pin_ids = devm_kcalloc(info->dev, grp->npins,
> > -                                   sizeof(unsigned int), GFP_KERNEL);
> > -       grp->pin_sss = devm_kcalloc(info->dev, grp->npins,
> > -                                   sizeof(unsigned int), GFP_KERNEL);
> > -       if (!grp->pin_ids || !grp->pin_sss)
> > +       pins = devm_kcalloc(info->dev, npins, sizeof(*pins), GFP_KERNEL);
> > +       sss = devm_kcalloc(info->dev, npins, sizeof(*sss), GFP_KERNEL);
> > +       if (!pins || !sss)
> >                 return -ENOMEM;
> >
> >         i = 0;
> >         of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
> > -               grp->pin_ids[i] = get_pin_no(pinmux);
> > -               grp->pin_sss[i] = get_pin_func(pinmux);
> > +               pins[i] = get_pin_no(pinmux);
> > +               sss[i] = get_pin_func(pinmux);
> >
> > -               dev_dbg(info->dev, "pin-id: 0x%x, sss: 0x%x",
> > -                       grp->pin_ids[i], grp->pin_sss[i]);
> > +               dev_dbg(info->dev, "pin: 0x%x, sss: 0x%x", pins[i], sss[i]);
> >                 i++;
> >         }
> >
> > +       grp->data.pins = pins;
> > +       grp->pin_sss = sss;
> > +
> >         return 0;
> >  }
> >
> > @@ -780,8 +781,9 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
> >                                         u32 index)
> >  {
> >         struct device_node *child;
> > -       struct s32_pmx_func *func;
> > +       struct pinfunction *func;
> >         struct s32_pin_group *grp;
> > +       char **groups;
> >         u32 i = 0;
> >         int ret = 0;
> >
> > @@ -791,18 +793,18 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
> >
> >         /* Initialise function */
> >         func->name = np->name;
> > -       func->num_groups = of_get_child_count(np);
> > -       if (func->num_groups == 0) {
> > +       func->ngroups = of_get_child_count(np);
> > +       if (func->ngroups == 0) {
> >                 dev_err(info->dev, "no groups defined in %pOF\n", np);
> >                 return -EINVAL;
> >         }
> > -       func->groups = devm_kcalloc(info->dev, func->num_groups,
> > -                                   sizeof(*func->groups), GFP_KERNEL);
> > -       if (!func->groups)
> > +       groups = devm_kcalloc(info->dev, func->ngroups,
> > +                             sizeof(*func->groups), GFP_KERNEL);
> > +       if (!groups)
> >                 return -ENOMEM;
> >
> >         for_each_child_of_node(np, child) {
> > -               func->groups[i] = child->name;
> > +               groups[i] = (char *)child->name;
> >                 grp = &info->groups[info->grp_index++];
> >                 ret = s32_pinctrl_parse_groups(child, grp, info);
> >                 if (ret)
> > @@ -810,6 +812,8 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
> >                 i++;
> >         }
> >
> > +       func->groups = (const char **)groups;
> 
> Hmm... Why is casting needed?

It's used for fulfilling the type checking done by kbuild otherwise an error will occur:

drivers/pinctrl/nxp/pinctrl-s32cc.c:815:22: error: assignment to 'const char * const*' from incompatible pointer type 'char **' [-Werror=incompatible-pointer-types]

In 'struct pinfunction', the member 'groups' is declared as (const char * const *).

Regards,
Chester

> 
> >         return 0;
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
