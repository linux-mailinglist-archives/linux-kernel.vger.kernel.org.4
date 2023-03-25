Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55916C8A91
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 04:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCYDDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 23:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 23:03:17 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482401705;
        Fri, 24 Mar 2023 20:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiAbRIBDIdO4T8tqfjj++xukQ6FNvKPlQHEhK0aRhRbDk/slEwrf9ok/SgUN0KEd9aELnW5Nu06SKN8GKvo9wrf4DeAgNY1pd5qpGzmDwgMcGOwJeOyz+URFhiy/fPKck3E9Uq8b+BTjH+Xkge8/r4yLWUEut1VuyhesdyGFEPW7dqSCamqUqtxK9T+8r3bA91FFOLVZR/Uh88lpa78i/DGiRZlqy0X/TPuzgIU8trFiGZHcYVOdQnwwFgYGrej2Y9Ik5pXdEdAc+o7PzstIM2ciSZFViThwxIr+ZtAByUJvVxEoS57xF9nGZsfliEuJqxshX5U6JdX/PDpvuXHMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+ZBdcShmKBZfiioBS1rvjXN8kguCThFk3kFCrijFPo=;
 b=Ejh1ehPfTcUPyMhvGUQbqg3X8Ful8XcZ3MVBK4pzZq+pJf2X+pghSba/y0UP6Ev1Xv6oJn8nwQkcTneXhyNdbzWaohIB1mdf4MqGoEefE0gWAIEaUttKDCQR8F7OzmlVhJdnViWhb+DCGnKAmhoIpCctCbXBGQXZs0sYYJdu+2gS9S6XA3KEzp0zRpqbFA8bvCk2wizfPk/bnaV3C+vz3KPsH05XwmPLgDXDPRwLX1hyvhZp49ikGEGqsKnlZCjgICONaGtsXCYwyMZcpY0nLcZtC7GYsfVk7GhBDJJLImFEuWSM7hmckN105COReAnGKfantei74PIwjQqVPvKGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+ZBdcShmKBZfiioBS1rvjXN8kguCThFk3kFCrijFPo=;
 b=RYUFbKt+m8xkN42hI0NrdCMwceSkMLKJ8NdYJpruOsOzNvoWIUBx7/PnOlzLwJ+QHqm9kSyTbJ0ZrnEIv07b2k1K9/qXbVTDAOHiP1Sxj2tC5Ab1RCpifHO39j07M8T5vQUFeO5zSl7PVHLB9kQQKl6MyrcL1TptINjIMGAX8GdTjS8OzP1PH+ko9qOq6WnxqdJkx2ViwdjLVUWFXYluTYz6OJqvSR4j3FFbWoAH7hMy/GM97ED7VBB9OkYPpHAaQhT73V+i/ryAJ6iS1E/0ZKOYxDwvbJyeXEMuwNkvjD/WycnrWQl4aGx7yrhYbAgMO8xhHx+UjewdXvFHOvAmGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 03:03:12 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.038; Sat, 25 Mar 2023
 03:03:11 +0000
Date:   Sat, 25 Mar 2023 11:02:59 +0800
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
Subject: Re: [PATCH v4 5/5] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
Message-ID: <ZB5kY9iBqi68nafl@linux-8mug>
References: <20230324143626.16336-1-clin@suse.com>
 <20230324143626.16336-6-clin@suse.com>
 <CAHp75VdLd9UCNcMcCiQfR2OTepA+Z1fYQr6aWUuTP=wnNdCpVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdLd9UCNcMcCiQfR2OTepA+Z1fYQr6aWUuTP=wnNdCpVw@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: fa85e04f-9689-4a71-0403-08db2cdd7790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFwZAWEPdBoWtrCIpsEVrONkPW8I3AM7Xf/ewPtyxAZr4SOoFkASaWD0AIWW7fRKfGBN8KVjgxiCtoL+XAMlfk0PnrwkncMa3Padl6Roh/kpVL9oertnHDam6VZwgEkimvZyFNoxXlgDHXmzj2mxq5YQowHoR7HkDXPH3EQZWk0BmrSu8dwXoMMbLybzJ5ipau6cUZsY/KWQCe2n5Xkv17mK3GOQmqz5kQ+jqnVhCNFL3yj6EnUM++5DQOhmHkQKJD4GpO0uupMV4w1gZ0UnSoN9ImMQGhNic+9mt6ZL1UBuLawWQNshb5MQK3AJ8chBM9+7hIXQ11fGgHx31ivAB8nSlhHfZqlZ94V6WXKWdMF4qNWJ7xNuBbRPlpB33N7r/LUtlWg9S77GI1gDHaHJvRzf39487/XjynhdeG6FOweih4t8IbVhRH/30JZTniN/lSG0/x9Uj7DBcTrClK5GHPhYHwp0w5yaB7FO3BxXtXpRGTPM8Dqo1St8fshmjrrgECrDVtpNuoW/H85YQ62xjwkfETaVzKTDC5DCGMd4l/V7Fyalh7p7T+n9NPBoKUnzUn/y5hWdja2mjqPnRx+myKo4DglqEAdoTa1M1Mwq7ti07x8Nl1f0z8I2AWP5zgaFBvhICGyQsshM+IR6b0dhsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(53546011)(6506007)(6512007)(9686003)(186003)(6666004)(107886003)(316002)(54906003)(83380400001)(26005)(6486002)(5660300002)(478600001)(38100700002)(86362001)(7416002)(66476007)(66946007)(6916009)(8676002)(41300700001)(4326008)(2906002)(33716001)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlpPM0RaT1h1Rnc2SzJDWFQwQmcrZ29ISHVNdVA0NWx6dis3YUU4aE9Nc0w0?=
 =?utf-8?B?VVQyaVh2VGpZd1ZVcWVRR1F2WUFlQjl5aGJRSGJpV3AzQkluN2ZYYnk2blBS?=
 =?utf-8?B?elpyZTlyTDNYUXdZRFhncnZzOFFjbnp6dGR5SVc5NmtVcWZQUHJ2Z2g0dTFR?=
 =?utf-8?B?NURCbkxiU0lQZndOZ0IzMFowazQrSDMvLzdpQ3lKZitSZ1JpZ3N6YXFYNktC?=
 =?utf-8?B?SzRRcUNCOVFUY2ZJZDVwd1VyTGl1WWFUR1l1S3lGZG9NWHFhNG12czh5MFNB?=
 =?utf-8?B?clVXUDVCdHJramd0aEpEME5rZHJlQ0l6ak5LU1NRZFFJL0RCeU9VdllaeEU1?=
 =?utf-8?B?dE5iZFA3ZWgvY25ad2dKRlptTjZRTTJ2S2Nhc1JvQ1dmdGdsdElNQ2UybFpM?=
 =?utf-8?B?TC9ZcGtsa3cvOGExWHZvZXZ1OFg1d1IwOFlCT2RDQTRiYmFXbGFkZXlsRDUr?=
 =?utf-8?B?b0E0bkg4TUZDUFNWRkJNSXVxNjdVUlI0Yjl5YVAyZllOTzlUWmtOcVhFa1R6?=
 =?utf-8?B?c3dYTEJ4N0NuRU42RXphUjZZdVloYm5BY2NkVlB1a3R5eThQTnpIeHc4MmpS?=
 =?utf-8?B?UTZoa200SjdZdmx2N1pVNmRDbDdadzZTa01aZkRmNjZlQnY5Unh6TkNBdHVn?=
 =?utf-8?B?OWw5UVhNT050dnRmWGZ3Z1ZVdjZQbGFJbk1PWk9tVWx6L3RPdVZSOGxaRUVN?=
 =?utf-8?B?RUNzWllKTEkzZWdNQlU1WlhhSnlicFVBU1lRUE96U3MwWVAxQzhXT3J4TDlT?=
 =?utf-8?B?Sy9QWXNpL294RllhTkdDNTVDUTh6NDVyRDN1bnRYMzlaUnd2RTFDWGMxa3JO?=
 =?utf-8?B?M1dQRU9ZbVBmRzF3M212T0ZKbnhYNyt3SVNHZUxWY01UODhVWWlBV0psUEV0?=
 =?utf-8?B?RVU4eXhkdG1QcnBsbm9lNDRIL1dSRTQ3SkxnSWxSK0I4SDQ0aUQzL0lqUTF4?=
 =?utf-8?B?bkkxYUZCem9JNWJpUFlZWURUNUFxZGNmNWxrTWpRdWhrdTd6b1JZazYvQmNh?=
 =?utf-8?B?amlOWjdYU0lER3NNNjdFclRtdzdVUEt3RWRnbkt2eU01bXdOQnR5cThUb2dk?=
 =?utf-8?B?M1h1ZXlwMUN1cENIeUtQWERlTUdsZmx4dVlMcmwxbkhndTQxeWgvVFVxNXNu?=
 =?utf-8?B?dWlYRTViQUI2QXNiSEEyamxHZ3Y2M1ZhdkZ3b01HRjEvemx1NFB1NjlqUFJU?=
 =?utf-8?B?cDZTbWtqb3REczREOWF1UUxDRWoybmlBR1JOK2pSODZMc2xQV1QwVThJZTQ0?=
 =?utf-8?B?OVc1a1hPNjlnTmhHeXRNaG9qSjkvODk3NEV2NkRGdWpZT1BTYzFpajU5eVls?=
 =?utf-8?B?bHN5N0J4eVJFcHNNaStWSFVCdURFcVptVEgxK0E5Wk41c0YwczlHUWpFKzdn?=
 =?utf-8?B?NXNGbFBsa0YrbkUwWjZJQUp5WFRMUFFEa0RwMTNXNmpTVUdnWnQxYWlkTnFK?=
 =?utf-8?B?ZWlPcHpLaGlkaS9tL2FSYUFwUm1PRUdCRlpKRktHQTlCL2l3eXNrZ01keGdj?=
 =?utf-8?B?aTdQTXRMUm1IRDY2eExmVEwxaXo1dExXVmR3Vk4rK1gwK09CSC9DbTg2QjF2?=
 =?utf-8?B?NjRzYXBqdlNQbEV2RlEzYkx0R3ZlRnYzekl5dEVySkxaV2ZFU3FJVy9KNDVz?=
 =?utf-8?B?RjdrV0lIbDZEL0w1SGNUQkQ3RVdBenFPUkF2ZHdqK0F0djh1dnQwUEY3WGVx?=
 =?utf-8?B?T2trc3dIYUdDdVg5cW9hb09tdWkwc291VkpNYXRqZzRMcmlaSjBES00xYUts?=
 =?utf-8?B?K1hha2htYnkzMXRZbTZoNmk0ajFPNGJSalFWdzFCMlZ3QmdWL3o3dXIxRjkr?=
 =?utf-8?B?aml3dXBrYlUyY2J2bFk3UU9BQUtXSzBNOGpYVWZ4VGNSY3d0b3daa0lTakFa?=
 =?utf-8?B?em84S1ppUitYS2VEZUdDWlRqY0RpN1RsbVZpODBmS1hIUitwUHowK1BPcEhT?=
 =?utf-8?B?MlVrcXk0RVo1SkZtQlhlM1h6dW9ONk0rL1pUalU0ZC9za2JTcG5nQVVXblJW?=
 =?utf-8?B?UStrK05PWndXSTM5dUF3QU9OeE1TVkVNczArN0FKdTlqc0sxcTI5Ty9UQjIw?=
 =?utf-8?B?aHpWVVpIK3RIMGp2UzZrU2t1SldFWlZSVzBrSmZNejBPYm80cVVoVmJHVzFj?=
 =?utf-8?Q?sWB+P4vhCZoEqZpzXj8L/vNJT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa85e04f-9689-4a71-0403-08db2cdd7790
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 03:03:11.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAwRVrTXolNMWubaA6QfJ73xYxzoY9Y/pK68WQilvId7LXX/OKICAXCQK9oyyzyY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:57:01PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 24, 2023 at 4:38 PM Chester Lin <clin@suse.com> wrote:
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
> >
> > Besides, use of_device_get_match_data() instead of of_match_device() since
> > the driver only needs to retrieve the .data from of_device_id.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> (casting question is minor and can be addressed in v5, if can be done,
> or when applying)
> 

Thanks for reviewing this patch!

I will prepare v5 next Monday for solving this question.

Regards,
Chester

> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> > Changes in v4:
> > - Retrieve the matched device data by calling of_device_get_match_data()
> >   and remove unnecessary type casting. (Merged from the previous v3 series
> >   [PATCH v3 1/6])
> >
> >  drivers/pinctrl/nxp/pinctrl-s32.h   | 14 +++++++++-----
> >  drivers/pinctrl/nxp/pinctrl-s32cc.c | 30 +++++++++++++++++------------
> >  drivers/pinctrl/nxp/pinctrl-s32g2.c | 13 +++++--------
> >  3 files changed, 32 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
> > index 2f7aecd462e4..add3c77ddfed 100644
> > --- a/drivers/pinctrl/nxp/pinctrl-s32.h
> > +++ b/drivers/pinctrl/nxp/pinctrl-s32.h
> > @@ -34,24 +34,28 @@ struct s32_pin_range {
> >         unsigned int end;
> >  };
> >
> > -struct s32_pinctrl_soc_info {
> > -       struct device *dev;
> > +struct s32_pinctrl_soc_data {
> >         const struct pinctrl_pin_desc *pins;
> >         unsigned int npins;
> > +       const struct s32_pin_range *mem_pin_ranges;
> > +       unsigned int mem_regions;
> > +};
> > +
> > +struct s32_pinctrl_soc_info {
> > +       struct device *dev;
> > +       const struct s32_pinctrl_soc_data *soc_data;
> >         struct s32_pin_group *groups;
> >         unsigned int ngroups;
> >         struct pinfunction *functions;
> >         unsigned int nfunctions;
> >         unsigned int grp_index;
> > -       const struct s32_pin_range *mem_pin_ranges;
> > -       unsigned int mem_regions;
> >  };
> >
> >  #define S32_PINCTRL_PIN(pin)   PINCTRL_PIN(pin, #pin)
> >  #define S32_PIN_RANGE(_start, _end) { .start = _start, .end = _end }
> >
> >  int s32_pinctrl_probe(struct platform_device *pdev,
> > -                       struct s32_pinctrl_soc_info *info);
> > +                     const struct s32_pinctrl_soc_data *soc_data);
> >  int s32_pinctrl_resume(struct device *dev);
> >  int s32_pinctrl_suspend(struct device *dev);
> >  #endif /* __DRIVERS_PINCTRL_S32_H */
> > diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > index 8373468719b6..41e024160f36 100644
> > --- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> > @@ -106,7 +106,7 @@ s32_get_region(struct pinctrl_dev *pctldev, unsigned int pin)
> >  {
> >         struct s32_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> >         const struct s32_pin_range *pin_range;
> > -       unsigned int mem_regions = ipctl->info->mem_regions;
> > +       unsigned int mem_regions = ipctl->info->soc_data->mem_regions;
> >         unsigned int i;
> >
> >         for (i = 0; i < mem_regions; i++) {
> > @@ -688,8 +688,8 @@ int s32_pinctrl_suspend(struct device *dev)
> >         int ret;
> >         unsigned int config;
> >
> > -       for (i = 0; i < info->npins; i++) {
> > -               pin = &info->pins[i];
> > +       for (i = 0; i < info->soc_data->npins; i++) {
> > +               pin = &info->soc_data->pins[i];
> >
> >                 if (!s32_pinctrl_should_save(ipctl, pin->number))
> >                         continue;
> > @@ -713,8 +713,8 @@ int s32_pinctrl_resume(struct device *dev)
> >         struct s32_pinctrl_context *saved_context = &ipctl->saved_context;
> >         int ret, i;
> >
> > -       for (i = 0; i < info->npins; i++) {
> > -               pin = &info->pins[i];
> > +       for (i = 0; i < info->soc_data->npins; i++) {
> > +               pin = &info->soc_data->pins[i];
> >
> >                 if (!s32_pinctrl_should_save(ipctl, pin->number))
> >                         continue;
> > @@ -831,7 +831,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
> >         struct resource *res;
> >         struct regmap *map;
> >         void __iomem *base;
> > -       int mem_regions = info->mem_regions;
> > +       unsigned int mem_regions = info->soc_data->mem_regions;
> >         int ret;
> >         u32 nfuncs = 0;
> >         u32 i = 0;
> > @@ -869,7 +869,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
> >                 }
> >
> >                 ipctl->regions[i].map = map;
> > -               ipctl->regions[i].pin_range = &info->mem_pin_ranges[i];
> > +               ipctl->regions[i].pin_range = &info->soc_data->mem_pin_ranges[i];
> >         }
> >
> >         nfuncs = of_get_child_count(np);
> > @@ -904,20 +904,26 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
> >  }
> >
> >  int s32_pinctrl_probe(struct platform_device *pdev,
> > -                     struct s32_pinctrl_soc_info *info)
> > +                     const struct s32_pinctrl_soc_data *soc_data)
> >  {
> >         struct s32_pinctrl *ipctl;
> >         int ret;
> >         struct pinctrl_desc *s32_pinctrl_desc;
> > +       struct s32_pinctrl_soc_info *info;
> >  #ifdef CONFIG_PM_SLEEP
> >         struct s32_pinctrl_context *saved_context;
> >  #endif
> >
> > -       if (!info || !info->pins || !info->npins) {
> > +       if (!soc_data || !soc_data->pins || !soc_data->npins) {
> >                 dev_err(&pdev->dev, "wrong pinctrl info\n");
> >                 return -EINVAL;
> >         }
> >
> > +       info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > +       if (!info)
> > +               return -ENOMEM;
> > +
> > +       info->soc_data = soc_data;
> >         info->dev = &pdev->dev;
> >
> >         /* Create state holders etc for this driver */
> > @@ -938,8 +944,8 @@ int s32_pinctrl_probe(struct platform_device *pdev,
> >                 return -ENOMEM;
> >
> >         s32_pinctrl_desc->name = dev_name(&pdev->dev);
> > -       s32_pinctrl_desc->pins = info->pins;
> > -       s32_pinctrl_desc->npins = info->npins;
> > +       s32_pinctrl_desc->pins = info->soc_data->pins;
> > +       s32_pinctrl_desc->npins = info->soc_data->npins;
> >         s32_pinctrl_desc->pctlops = &s32_pctrl_ops;
> >         s32_pinctrl_desc->pmxops = &s32_pmx_ops;
> >         s32_pinctrl_desc->confops = &s32_pinconf_ops;
> > @@ -960,7 +966,7 @@ int s32_pinctrl_probe(struct platform_device *pdev,
> >  #ifdef CONFIG_PM_SLEEP
> >         saved_context = &ipctl->saved_context;
> >         saved_context->pads =
> > -               devm_kcalloc(&pdev->dev, info->npins,
> > +               devm_kcalloc(&pdev->dev, info->soc_data->npins,
> >                              sizeof(*saved_context->pads),
> >                              GFP_KERNEL);
> >         if (!saved_context->pads)
> > diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> > index d9f3ff6794ea..e0944c071c8c 100644
> > --- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
> > +++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
> > @@ -721,7 +721,7 @@ static const struct s32_pin_range s32_pin_ranges_siul2[] = {
> >         S32_PIN_RANGE(942, 1007),
> >  };
> >
> > -static struct s32_pinctrl_soc_info s32_pinctrl_info = {
> > +static struct s32_pinctrl_soc_data s32_pinctrl_data = {
> >         .pins = s32_pinctrl_pads_siul2,
> >         .npins = ARRAY_SIZE(s32_pinctrl_pads_siul2),
> >         .mem_pin_ranges = s32_pin_ranges_siul2,
> > @@ -732,7 +732,7 @@ static const struct of_device_id s32_pinctrl_of_match[] = {
> >         {
> >
> >                 .compatible = "nxp,s32g2-siul2-pinctrl",
> > -               .data = (void *) &s32_pinctrl_info,
> > +               .data = (void *) &s32_pinctrl_data,
> >         },
> >         { /* sentinel */ }
> >  };
> > @@ -740,14 +740,11 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
> >
> >  static int s32g_pinctrl_probe(struct platform_device *pdev)
> >  {
> > -       const struct of_device_id *of_id =
> > -               of_match_device(s32_pinctrl_of_match, &pdev->dev);
> > +       const struct s32_pinctrl_soc_data *soc_data;
> >
> > -       if (!of_id)
> > -               return -ENODEV;
> > +       soc_data = of_device_get_match_data(&pdev->dev);
> >
> > -       return s32_pinctrl_probe
> > -                       (pdev, (struct s32_pinctrl_soc_info *) of_id->data);
> > +       return s32_pinctrl_probe(pdev, soc_data);
> >  }
> >
> >  static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
> > --
> > 2.37.3
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
