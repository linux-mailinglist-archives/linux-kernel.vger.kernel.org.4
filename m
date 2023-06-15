Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8E731F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbjFOR4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFORz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:55:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6702724;
        Thu, 15 Jun 2023 10:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnxxogTGKaHP3NYMwjff8EpQwVq8GGV67zOPWuLu192Bd5A6mlXOMunq4to08SVSi+E86il+Kg650xPFZ5cgQ9OEp+6pgsbnlFZ51EVr9AHFbLYPxcN8VJT3OrT+Gqz43xw9qO0ohuzaBjR5IrkAuxkWt6jPSuq/vwES4Oz5z6K2whGH1rJY+1OtpQFN0Dd82s3cfURjmlXfQTFbwLe248QJyUNNC20ZusPCC2Mo+pbJe1vuwpoEtIlULJSvRbNZhL9zT84eC/bCNPbJnp4B3LIBqsUZ1t7AN++0G+ciog2PhBs28oMy6LhiR02Ggd5Hxh6D9rYZ8/FEGq5f7lreSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nff0mhhsuSOd/We8IC8pa3/KYvm3Z00XQJXkXpAiL/w=;
 b=nmeYmbhlH0wZyyJaCUt58u4eA90w5+knL6hPjZPjbxrS/e+py3KByAMSKHylwVeL6zFV7PTtquEzEPRfbldm48+ukbhvNqj5wZbpyK6KNG0/81Rrj2hNSMWDDSsYMHZaJhsYpdEwu4hIJ0p2pFRtjSYNktTpEofG4YokKF9lkNuorD96UZRzLlYCSpSbZLSZ5ix5xFdGECbFGxGeV5wXehwzk4stA+bbuKDbN1APDKlQBwyp0pbZ0CMNeW7yMuPsi8ER1Xj/Io9i8RfPYDZJ4wDgcKOdegEDgNoduOBqRuyvGBN0GCULjM9OXj4Ce51IpOCeMYjidp240h3gT4r54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nff0mhhsuSOd/We8IC8pa3/KYvm3Z00XQJXkXpAiL/w=;
 b=m0NhHz/fBrM/9LcfooZtoA5jojV22g/Gi9AJnkGGyRenla3srIVmyFoU1VD1m0W3aewA2cFIhsiigHo7oaAtrZRjKrQpiP0WtePpjLIEn+S3fM8a3BgrVreDkT9MD+UkyQqa2vV8/9lhuCzMdS50HC5PBG/5myQYEZO7sXd0W7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 17:55:50 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 17:55:50 +0000
Date:   Thu, 15 Jun 2023 23:25:38 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ray.huang@amd.com, viresh.kumar@linaro.org, trenn@suse.com,
        shuah@kernel.org, gautham.shenoy@amd.com,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name
 hyphenated
Message-ID: <ZItQmjQHe/I9CXJh@BLR-5CG13462PL.amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-2-wyes.karny@amd.com>
 <CAJZ5v0gfqGj9X=3bdf6X4HqQDxg+gCJN10DXLruYD5p3kZ59Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gfqGj9X=3bdf6X4HqQDxg+gCJN10DXLruYD5p3kZ59Uw@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5cce56-e76d-47b3-e1c6-08db6dc9c11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaCzmsX9OMMgT63NaNzOq2NY9YDag/ba7/3viOvjeX4ioEQQXW6j+FpP8ZMx/36tXw5dS7P4jhbeqXWF/DSvCyjknImdJyGK2Eqs0XzzN8XQbmD+OCr87sy31g8HRp/T82/ZTVZqpFhgv9YNo/6T3zgXUr5qrMxz6bTBtTVhWr5Q8+H+vxod/jxsn4Rmx+bXDGpVwjBPrshizU2LIcvagQxJnQdSM2uXCYw05pJWvIe49Yzr3hS8Y9HN0dK0cu8uhpei5SwwkhoiXrD64YTkfv27CQ9Y0yzJ3Cb3w2RkacId09zJKaH7fQYBZ0soa/lKxp4D4xExQAMkcZ691iqa27BZ/PaCuQ/muaRArMx2e2LC8oPsWAiWnAHDrqayQISI1H7LWbwv5NCsKi1B7Su6kcMC5dRsWG+93BQR6yTtf16HdFFxwS6OQv03LTrCdmZyt/66SJY67a3+EP4ddGhIlkRIreA7IpWy7xJdt+jAeQJR6rNBkj+wtNZBVK9eIVFihJ1WoCglydYJEi2Yopol/GYpk2LjFHJIwsisxzxyvyWT4XM8Tp2YgykeLpY11M0U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(66556008)(66476007)(6666004)(66946007)(316002)(6916009)(478600001)(4326008)(86362001)(6512007)(6506007)(53546011)(186003)(26005)(83380400001)(8676002)(5660300002)(44832011)(8936002)(6486002)(2906002)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1phRXJuT1JZOElKZnllNHV0YnZVdi80YkN2c2FBeENVZlZDcUNYTzdtQWk4?=
 =?utf-8?B?bUZLSWp2dGVjSmJZaCs2Q3BiR1hIQ2c2SXlvcGpFNnJJaXZZM25kOFFTWWtS?=
 =?utf-8?B?WEU2Z3hMYlQ5UzFhcVVEamZyMlBjUkNCa1hQRi9rY0gvLzMvZFZ1Rk5GeDhp?=
 =?utf-8?B?OVJSOXRNL1NqOXlVQW1EalEzQ3RienE2Y3lTZHpGUXByWEh4cTdHR1hOMDR2?=
 =?utf-8?B?UFlhZnZQRVNWckVsZW1DN3RHVEs4bGpGYVNxR1ptKzlWVzZBU0lZQ2N5c3Ix?=
 =?utf-8?B?N0JNOFJsSlNya0wvMjVWUTEzbGQ0TVRDbXlWa1owcXh2Qy9IbnFQQzE4dHd6?=
 =?utf-8?B?RG5vRlczaHhaZVJ6R3JWYkJNdVgxSW43ZVJRY0hHVCthUW1sZ0dxc0tPQldo?=
 =?utf-8?B?eVgwTmJDekZLRnZsaldGSmdFc2E2YlV6NWVyR2dNRnZoRmtTYUdhc1VudEZY?=
 =?utf-8?B?OUkydmpjVjQ3b1hJVGdNZ25uZ3FKMkU2bkVkMlhldGtiL1pHRVdnRjZRZUxx?=
 =?utf-8?B?TExXSXM5QTNyOEdrdWNUa3AvOWRMOGxHdjYyMWFxeng0aUtDRFZpeU9RbFA0?=
 =?utf-8?B?d0haY1VkWC9jc1ZPU0RxQ0htY0ZXdU5IWG5pdFo2MlV5NHlQUnFSQ0lZUHRQ?=
 =?utf-8?B?TGRUV0oycDZoa3dkelZiQ1p5ZHdWQksxQVpwT0hyaWhLcUZLQ0NwdzhKV3pZ?=
 =?utf-8?B?NklXa29TcFJRMVM5SlQvT3llbmkxVzVMek1GTkVOdllsY1BkRGt0WnRodHBv?=
 =?utf-8?B?VmsxZ2RaZ0VtbFh5TytUblgxTlE1dXZlUVFjRU9qR2FDZkQzdjN2N0U5cUFN?=
 =?utf-8?B?K0ZZU0VCUjBQZG5KMTRRcitKdDlOVFo5cEtRNmt6WXBGb0k5MmV4aERhN0t3?=
 =?utf-8?B?RG8xcnlWU2ZjeGlTQW1ETHhkcFNVNXUxQzNjenJOQzVLK3ZvYng0d3BpQ01S?=
 =?utf-8?B?NmpKUjJpcE1nZXBMVUlBYk5TOGtIVUp6MXUvRkl4TXFlSzdZdjkxcGQ0RlZY?=
 =?utf-8?B?ZHhhcDRJSjBFL1dBWXFtVUpITkFOVVQvQ05FT0lQZ2xtaTU5a2U1dVdMcFNO?=
 =?utf-8?B?WmZCc0E2dStwMVhYd2Fhd3dxYjk4a3pYZmpwQ1BQLzlvQkpXcUxiSks5MHRr?=
 =?utf-8?B?ZHVFK0F6OVAwbC9lU1FMME5BdEl2M0xCNW1McXppR29SSkhiQkFhWFZTT3p4?=
 =?utf-8?B?dStNTGRLbzRtUW1kN21CRmhxeUFRbWVxUHVpZ0RZQlY5Z2JGSmc5Z2VGcU9r?=
 =?utf-8?B?aHNTaHg1NS8vd3dmVElqbGNvYU9TSXZ6YXd4UjJWOFk1NlpBdU9BMy9paGh2?=
 =?utf-8?B?OGtKQUdDNjlTS0tLaldFNGZnYnJFYnVvNG9IcVplbWN0UHYvZXppS1NuU3FO?=
 =?utf-8?B?VGVKa05qNXJwSmw3OUJUT0Z1MkYvYzIxWHo1Y0xTancyWFVFc25qUmxQanpY?=
 =?utf-8?B?anhvVkZYUUtFb3VCM3crSi83SEJKakNNRVorUWNiS0xzYnNPN2F4UXVWejAx?=
 =?utf-8?B?ZzNvL3gyRzR6ZmJEdS90bm04cHdVZ3pROXhxakc3SVRJM3lybHBWZFc0WmF3?=
 =?utf-8?B?cXNmZ1grVmRENWx4UVdRM2lvUlZsSGZMc3Y4ZmJOWnNpSlJuTnRlQ05pZEIw?=
 =?utf-8?B?UmJtMW5uY0lxb3JDcE1BSFpkenplSGtxaVpvaWNwMlAvTEFhSzl1N014aFBX?=
 =?utf-8?B?cWRiYlZ4OWQyZWtOdHF0eFVJV2E3ZngrbEtjdXR3ZkJrMVJHUXlvZEt4cm5q?=
 =?utf-8?B?bHVrSkxBNjZmQ3A5STdpajVEZ1puOE5uUnBHcUNZNHAxeDVrNmpweXl0eTky?=
 =?utf-8?B?ZnRabmRXenVXL0Vza3YyZWFRYzROVnd3dGNNeGhUdGc3SjB1U0Fsd2ZtaUhS?=
 =?utf-8?B?aVo1d0FxeVBPSHc0R2JXeXZ1aXd3TWxKQXJJZ0h2MWYyWGhFU1A4WDQ3VUV2?=
 =?utf-8?B?ZWJkWGI1SHJ1bGZOMFBMQjRkb3NKcm1NMW9rbXJ6U3ZlR1l3Z1E5NzNTb0Z3?=
 =?utf-8?B?dTluNy96T2dwTVB4eE5abnlVOThQbmYxWCtVakw5MXN3RkdqeCtjWmdYMzdj?=
 =?utf-8?B?R1ZqeS9WR281ODV5Mk1aMHZEYmhiOHFMMjAwM24vcDVEQUt5MDYxK2d5NW5l?=
 =?utf-8?Q?eTVP1nHUX7kCBJxfqF0nH4erk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5cce56-e76d-47b3-e1c6-08db6dc9c11d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:55:50.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT5Z5VOAdQrBCdl3joOnILl+Zjh4sXnkyrpZ+kO1m2+elz0LcvHTcggzvS2A+JJiuaiRay3jrFe7cGMUljfjng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 15 Jun 19:31, Rafael J. Wysocki wrote:
> On Mon, Jun 12, 2023 at 1:37 PM Wyes Karny <wyes.karny@amd.com> wrote:
> >
> > amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> > mode driver consistent with that rename "amd_pstate_epp" to
> > "amd-pstate-epp".
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> 
> How much does the rest of the series depend on this patch?

The rest of the series is independent of this patch.

> 
> I can apply it right away and push it out to a forward-only branch if
> that helps.

Sure, that helps!

Thanks & Regards,
Wyes


> 
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
> > 2.34.1
> >
