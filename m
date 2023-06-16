Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67517337DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjFPSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjFPSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:03:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912722728;
        Fri, 16 Jun 2023 11:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP2E3zGuRvMzAgOnn6xKAZfF7fSYMZpwHEQB0nHulkoV79MDkzZ8QwBzO0dr6x/7l1JwmtAugn1TgBhxWbhVMZylxDn/tB8rJdNMkitLyjtTsTMOyeCjFXADoWYxLNXGeundUeZwgROSqdaujaUAh/krjKjlYFNQcxdgmrbC8+Zof9TxTrEovSIdJAcIV7i8+HCzuom+mA5nwA3fbqYZTCRJGqEyXhhhMOsveW81X8JbG6U5bYYV8IIjpWN2x/bEcUEF74O0EOxavVy2vJrhcRugsuwRkPBlSb5j2mvWdBNzenPya+4xvGwAxOYYBYgNy8YRjosJ9vYoD24dfOMj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8I1sRaRJci23B81g6zBhoYgz8rBRku4MX23zeIlv8M=;
 b=NK3K0kF282R7dfILk+aCmTyrw/AUyEMniXxzfX6sbEe8GemIQKfWeVPieQ4yXR7kbXkZgif4/D9lCnFosm/PhK1EsnxVlYlRM74un6Gu2fuou7rum/MH4jMQsOk1RhQv1rdi9ngeHTlX/S+U5LaoRpLs+sWogMzuEaO5mwkhiVx69Ati8irv08lXEuKsIrF8gTOGhpZZxY+18ZQsnueC5VhFLLDuoc2jWHk10iFpzkE9eI68aX02NOnXNY7J9rJtOcRRuCFBlmRJkFYv4/x544qsNxX26BMfnVPiGwUaw3+FHF/MGNHamCXBjcE3Nm0p6NwXV0630x49GWf9O5c19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8I1sRaRJci23B81g6zBhoYgz8rBRku4MX23zeIlv8M=;
 b=S7dOs24HijRHJAbISRq6xch7ZyfgQX+g2hL348mh26v5/0Y5VdhzGOPcIlpPm50xbUifhlFmtgxVRPc1D/fgz7ZQdOpakmIVu43Q9KU0K7B8b5meU7vEC25o8TSYoDt96wG6Kf21Tw79iNx1oWSlqaq/nuDWxRGU22uqQhVasvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 18:03:30 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:03:30 +0000
Date:   Fri, 16 Jun 2023 23:33:18 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com, Mario.Limonciello@amd.com,
        Perry.Yuan@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] amd-pstate: Make amd-pstate epp driver name hyphenated
Message-ID: <ZIyj5uE/mbEF1Uq5@BLR-5CG13462PL.amd.com>
References: <20230616174723.148532-1-wyes.karny@amd.com>
 <CAJZ5v0j+sdo+_3W1xkgSUTshGhTSzjgZpYK=gApUc9f4+dr5Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j+sdo+_3W1xkgSUTshGhTSzjgZpYK=gApUc9f4+dr5Jg@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: e55585de-83ef-4e3b-990d-08db6e93fd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Og/4P5H4Xpv1NrcLxMy0yDZx8T4P2/xL9CPxUSphB6VnQRs+J1z0c1S2Y+hjYseCvmxOyU37RytXskrOOJsUpPs0qaOHZyu2VF11PTXVIyeCN7Ykd9O5ZtdWqXidDsSLgRlB8CbQ7kCpNReqsmUALNeB7YjROIGs6KTd/JPPMdC9DgNgPHBVbXRyX4VXZi5uNlzk7Hc6woE3++MYODe/CjfhcDV9/bUlGpKnalAghMdV3qZZg08BGLYuyrzh18QPMu7kqYozgFhsXqwW+Z6y9MLbymC6BNj/pHBlOgkEaYBgPkPQGsVk+SuVYJAWddpKaHt+3ksBHcNOW2JPfHvaD/v9kWXT3mLH4Idr63GmHlQMOZm8HCaTV1BxzQRWFLuyLUaT0FV1Ph7y+1z+9ZGj4i5xIvAuWBYp5DdmBeGwIA/SKjBkubKyS/hNM4UOw4ogGf0zLoDoGdgji9FU/lEO423ZNRk502LjUc84S4/zpbflVrCuuB5ikdM4ChMFbFx6isFBRVYcN9WCPfCATBLnWvjFJ3bHFcetX8x2pdkk2Sa4b5DCc4wZaf8Fp9suN10V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(41300700001)(86362001)(6916009)(66476007)(6486002)(66556008)(66946007)(8676002)(6666004)(8936002)(316002)(4326008)(26005)(478600001)(44832011)(6512007)(5660300002)(83380400001)(53546011)(6506007)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpQakVIZ3orWUo3eDVLZG95WVdPem9zL084OXBWTHFKYm5LMzJtR2VwNEtC?=
 =?utf-8?B?UlY1WFpMc21MVGdFejFSSXFYUTh6a0xZYTArMVJKd090OUE2TmNMa0M3cjNQ?=
 =?utf-8?B?TE8vQll3NzBYOG5NZS9TbFgrOEx5UDFvOTBPNVdPY2h4TUg3K3FvUHBBZGcr?=
 =?utf-8?B?RWtpTmVlNUlFSFhUa201SGo0M1BwY0FlNzVocXNBdnI5eUNRYm5UdWFFUUhz?=
 =?utf-8?B?MTVSVWVGZjZJdGJzTjZBdDlOZHlWUEdmeGVhWWJMOXFMMlo4TjQ2cUpXc3lU?=
 =?utf-8?B?b0w5Nm1GMzlpaXVxQnloNmRzaDk0dUVUYllJZFp1cll0cWtrTDZ0eUpCRjRn?=
 =?utf-8?B?WHJFTmhzbHQ5T0drZnhVL3BqcjdsZndqK2xoUHpxQysxU1l3YzRwdG04UFQ4?=
 =?utf-8?B?VTZTMjZ5cDBIbWYzQlpXb3U2MWtRbnB2MllNRlB0NERNd3JNZjBsdGs1VDdp?=
 =?utf-8?B?TXZjdXJmYnhmNlBXRjhKK0tuS3VFUzZlVE42S1R2T3Y4NlpiOHdXZXVoMzhE?=
 =?utf-8?B?TlJ5Y1RieDhObVhNT3lEVVppQ2d6aHhOQ2pQZWZPdnNvUW83RWZ0NDh3Yzln?=
 =?utf-8?B?TUhaTS9SWHJvTjVDYTFOaUluRE9XUnAwK1BuYTNBYWo2UC80STRUSitjSjEr?=
 =?utf-8?B?aFRTdVg3TGpnYktIdlFJTzFvRUIzTnBqUUxBQWsyRXhFRTFFbWcrR0ZCL2tq?=
 =?utf-8?B?Q3hCTnNIOVU3azR2QWowWnZxN2lpZUFVbzdHcnZHa2QwdkVBSUpORTVUR084?=
 =?utf-8?B?ako3RmhsZ01OVHQ0S09lZ2xqT3R6alV3NHViWVFsTkZMUXlBVGUraC83OUZz?=
 =?utf-8?B?d3hxVWE0bUx2bHdOQ1lqYnFmWStSZGhDQVlmL1JIVktJZVM3U21FcEVmUURq?=
 =?utf-8?B?WWc0dlhuc2tCblR1KzNRUDhRd1dZR1BUUFZncVVtd3RxWGFXaXJzVFkyUU5O?=
 =?utf-8?B?ekRPZTBjSjhac2FWYWVFUjVaSUJSanQ5Y1lpaVNOb1JRMHd5c1RtODQ2ekVr?=
 =?utf-8?B?cDhsOUEvN1JpZnh5WS8vanltRFptZzZaUlBteDV3SjlTWGpUL3AwenZaVjUr?=
 =?utf-8?B?d0xEQ2ZrMEJCMnFETkxqSnRnSzd4eEZDeTdtUjFZWU1HSUplQ0F4SlJqRml6?=
 =?utf-8?B?QXJ6eXlDQW9Gd3o3RENmWmR4NEZmV2M5YngrcjdIYkw2WjYvblM0bWMxaEts?=
 =?utf-8?B?d2FsMEx3UWNOeFRqZ3JVWkRXc0dURkNmZW5Ld3ZPUnB5WE1OQ2lqYk9LeWRX?=
 =?utf-8?B?ak5uUVJBTnlEdktvdk50Y2dBNU1LNG5MQWhiWEZyU1p4RVpHRG42L0Q5NkFX?=
 =?utf-8?B?bGRjdEZHM1NCUllCanFVQTBYVGpzbWxRcTZEeWdhV0drUkM5c3hRSlZuVmRE?=
 =?utf-8?B?QmZJeFVtL1JySHFLT0dNMUttbkVkNmpJdkJPYWpJZm9ZQkpuMnN3QS8wc1dp?=
 =?utf-8?B?WlV2a29xaGVVckE4MG9lMy9DNHhmQmlDTWlWdUVPSDh3RWUySEpHUy9idjBK?=
 =?utf-8?B?OWxUWHFjcERDSUVhdmhzWCtSWTlrMCtOWGw2ZkF6d1hialJoZER5UkM2QU5K?=
 =?utf-8?B?alFSK2cwSU9UcGU1elZuMy9tWnNsbjZNQVJqV0pMOWU2c3lpdlRZZ3d0OVA5?=
 =?utf-8?B?Y3BCL2szNTdiWnlXSzNBUkZYek1rRmlwTjRRT1I4NjBTYm1TRm1ZdjY3aUxk?=
 =?utf-8?B?ZloyMGRnNXFxTjluV0dvaHRROGJGQ0tBOGt1QVVobUxMazRpMjFkZnMrdDZm?=
 =?utf-8?B?TDBoMEJOVzQrTHRqZU1zb3p1V3ZmalhtL0FuSmh3Z1RpOFNQbjdGVEUwUVpX?=
 =?utf-8?B?K2pvMUwvTkE1SzNMMnRTNy8rTHF3bkNmSlhZZlRpRWpib3pQMTUzSndyVGlR?=
 =?utf-8?B?YzJtYlRjYndPQndNUi8xNGVQZElhQWVQNnUvb3NNRDBpSzhucVBJcGtHSm5O?=
 =?utf-8?B?VkdWa3lKLy8yUzl3WFAvZytRZEJWVW92OFBra2l1Uit6Y1FVUjVGQTFxOERz?=
 =?utf-8?B?TnlXZDg5L01ZL0FQSWVuYnZzNnVIQTQzTlZRLzl3QWIvMlV6bkhjb1F4OGEz?=
 =?utf-8?B?czRDRlBUZUVROUJxKy9tZ2RreTJEWmpFbW8xdnFpaWQzOTVKVTBqY2MyTXJa?=
 =?utf-8?Q?1SsVC8c57eztNbmAkUslvuHLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55585de-83ef-4e3b-990d-08db6e93fd43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:03:30.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGiTugGqPttf+TRxvVSid1CWS128fUCoF7xPxoLVNmolFcQEsij7xz6YNU53qgTgD7sg35ML983tErD8hHYBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jun 19:54, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 7:47 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> > mode driver consistent with that rename "amd_pstate_epp" to
> > "amd-pstate-epp".
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index ddd346a239e0..a5764946434c 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1356,7 +1356,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
> >         .online         = amd_pstate_epp_cpu_online,
> >         .suspend        = amd_pstate_epp_suspend,
> >         .resume         = amd_pstate_epp_resume,
> > -       .name           = "amd_pstate_epp",
> > +       .name           = "amd-pstate-epp",
> >         .attr           = amd_pstate_epp_attr,
> >  };
> >
> > --
> 
> I've already applied the one you sent previously.

Oh, thanks for accepting the previous patch!

Regards,
Wyes
