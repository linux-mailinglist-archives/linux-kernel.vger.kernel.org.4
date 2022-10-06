Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649C65F5E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJFBld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFBl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:41:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E47F082
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6rPhFhSlYv7TOc9HMU4YMA/Z5PaU+cynW7+YE1iNNOpX0M61zvH6PwPHc97qljrD8aM6p6PHfPPxjA86zHDom2hnQyGWvuaDCJj99jXSxX6jY4Rx3eG4RRFKP1kIrIsI9G/s7OStP3uyBLVOSxQQPi7ZG1KZnX2s4fdHKuYyBjPVdTGBS/dN6cAUbCetATvJgGqIszHH+/J9sUF68jsAC41xoTCrlVueh61Hua3AAkdYXciwWl9Tj0sUGskzf1RXMiYM7rzZZMbAmXPpQHdv6lPnk9eLLpXVt/8+lSA2kGU2Y5kKMysLX4H/1MgzVxkgiNcbQI1rSk2ztOkfBsKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G04Jd+lxv+wNynFxKcgb9JPGEerOT5FKsaJQHpxSeHA=;
 b=QlMc9nste/zKPo/E2PXKbMwK/NXNbkwItWslNoTkJ3i0tcHdY1IfZzFBKUdTZ+UI1uIgTj80KSK9onK6ofG+c1Lzwtgl5eS7GqJR45Sj98UeVNnIL7bud+pCG8Zs/QZqh8C4ahL5huGKGdwdlD3BC6v8JWxcdKZqtF3OqnWfcrlEFZ0RA2etRRKhXkctod8jdt49Ljei34Z7zG6txJ6pAy6GfxGDZSldNaL64AImNU5pG6eXNfBUeG1yZVuWyPXjOWJJt8k8OMBpvgOnUQQSqggEoZbNzxCVYi7jMJYZ0s8A/ovu+GzOuIEEJrYqC1s+MQxTcsddlfOMzFjdUnH1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G04Jd+lxv+wNynFxKcgb9JPGEerOT5FKsaJQHpxSeHA=;
 b=dOk24EYneOT/104rgf+vhYpYxVjr+D6x/yHJvEJMOadFUnFz0R6BPK4bXnsD+Zyn5A33VYIGX9dCnwvOJr6n/tEMPl+Q5cU/3FmymwM47W+0CRi/DgfRjN3h+pyR2KYldJumROMxcWr75P5LIMkToHtbVGzgrYvWDG5JigOoMaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=knights.ucf.edu;
Received: from BN7PR07MB4195.namprd07.prod.outlook.com (2603:10b6:406:b1::33)
 by BL0PR07MB8083.namprd07.prod.outlook.com (2603:10b6:208:1c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 01:41:27 +0000
Received: from BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::9a4c:e558:6a54:fc2c]) by BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::9a4c:e558:6a54:fc2c%6]) with mapi id 15.20.5676.033; Thu, 6 Oct 2022
 01:41:26 +0000
Date:   Wed, 5 Oct 2022 21:39:24 -0400
From:   Brent Pappas <pappasbrent@knights.ucf.edu>
To:     Nam Cao <namcaov@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: most: net: Replace macros HB and LB with static
 inline functions
Message-ID: <Yz4xzCDGxyva/yZN@knights.ucf.edu>
References: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
 <20221005235728.GA118549@nam-dell>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005235728.GA118549@nam-dell>
X-ClientProxiedBy: BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::9) To BN7PR07MB4195.namprd07.prod.outlook.com
 (2603:10b6:406:b1::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR07MB4195:EE_|BL0PR07MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c4f828-ef95-4e74-ffff-08daa73be231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SedSu7CYdtnDUay6sXDBe4j3YyfftgvBVqTx7I8n50s78ihGGi7xT2xds/VYABYhRnElZf0B1dJDn7i68YFqLpkpLFZjxJJEvMe0tYBD0SK6k4myRwbM/NXJwpy+YAh2ZmvwAEeUPdPpz1gznnuvZcR3XeG7jdFQPPPLyqj1ctHXOhZDNfObH68z0BQX4I9UMBQYE3k+13Hxf+X+/FiWV+m3LPp0UKKzsEKb5VbUedSJm82GoN4Zoh2WGOpDUN7vpHorBn2YRMHcWPGqQDIkfWU+Dc9lD5jNg17ZSVbZf+DZoyYJN0g6lIJJ6XjPvDtpbZNvVE7GJPd0HNdsWkkLlwsJ1/DRVqIXx8PT1adafuKWph3U/BMizd2ujgqeI0Bk/kRtlqQo32T7H565G0epZlDxwiG2m/ix4Rfnr7919izYTG32XrtpJpGYmJAXh/ys1s86/OMewwd0n4nxgUZlKABx0CGKSiULzKtsERpXG75sx1UJIo5EoLgWLqUx7iQFOx++Tqes+2L6sgSfXjKepw3qc9PTzmfeO5Nps0i+2iLPqcy9KsKdryiMDU4Zyxp2NZ6b6+Kwu2cy4lMedb1h/XgqWNkaPheYtpFZL52vhW3mJa1z/R/rbAemIE7o1gYevwGAozsqAuBE7nevTuM9wKZmsOG5OlOI0jiDS+giaflWdgaf67LCvlm357QYfyJYHn5vIxL6zSM9YxIn26OTzxqSYV3DBH3ylLo+k4xUKN8i/lGcMOzsMJrnf2CkJbH4L0zLaSMv85Hre8H/ycycDx+2mtU1J7/iE/XPP+3juZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR07MB4195.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(786003)(316002)(66556008)(66476007)(5660300002)(8936002)(4326008)(45080400002)(8676002)(66946007)(41300700001)(54906003)(966005)(6486002)(478600001)(6916009)(75432002)(53546011)(86362001)(83380400001)(6506007)(2906002)(186003)(41320700001)(52116002)(38100700002)(38350700002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRMMWt4Y2dQU1B3S1hBaU9Ceis3Tk5yVHNDZ29Ec0QwRnFEM09RZzlqLzJF?=
 =?utf-8?B?YklFNHM3MSthRUlEQXJDOTdCaXJHL1ZzWFFDSVRVSDhudnUzVXhKRXlHaEk3?=
 =?utf-8?B?UmF3Nm5yd09Hb2N1LzlyN1ZYeS8zaGM5ZFoyQnJnTXFtOG9LQWVDMHVldzFx?=
 =?utf-8?B?dFV5Rm9hbk5mcGtBUU9RNCtVd0Y4M3lUMHdoa1QzVk4zeUFKd1Jhd3g2c3dZ?=
 =?utf-8?B?bnVRaEIwZUhXVDFrajRaSzBLejBGRWEwd0xsWUo3ck1yOThTKzRPQnpTMUN6?=
 =?utf-8?B?Yi9xTjk1RlZLNDV3VVl0UUZwN1ZpSk81Rm5sMnZZMTFYd3EwK0tjR1Joc2hR?=
 =?utf-8?B?L3lPbHl3dHhQUytoOFJ6dVpKaGtPeFhoUFk5L3lKcjlIWkpNVVd1ZDhPeGpI?=
 =?utf-8?B?ZVJvVjh4ZlI5NmNYbC83ZXh2dTdsTlNhOVBUbm5hc1QvY3Z1a3hVZ2s1Zzh0?=
 =?utf-8?B?d1d6a1A5SW1xdk5lNklmWlpDaWJodGd2ZCt3YzdybWhiM0R1SmhuQzZpY01G?=
 =?utf-8?B?bWhYMzg2bEpMWmJ4NDZDbTk4Tlp3QlNaeVZSN0RMaUt1QWNnczNxMEdOVEhH?=
 =?utf-8?B?NUdMSm82dk9HaWJNUTRncG5QYjM1RWdrcE16TEppL1pPNFQ0TFlrdnJnZkht?=
 =?utf-8?B?ejQxOGt3U0tVU1ZQYjBqSlZITEkzbzhjRURGbEJzNGtQN0dHY2pHM3RHUjRu?=
 =?utf-8?B?UjZTUHNKVXpOc3oxSkJlSmMxdGJpRncvcndNZllUUVNReUVNOXBKRHJPYXU4?=
 =?utf-8?B?YmFhd3lXazZwKzdoL3ZZeU9ZSlpyVG5YM2FPaXZIOUJLM0l0dktYMVdCOCtB?=
 =?utf-8?B?OCtwcyszNWRqbzN1ZGl3UWY2V2JyTGt2OWtyOC9rc0dJaXB6Y3l5T3dsYVhK?=
 =?utf-8?B?RFZDelZ2aTkwRHdSVzFjU25LQUtUdTJqZXNEd0JubVFmYmZSSUlSRDZVdGNh?=
 =?utf-8?B?a3ArOGVDSW8yUkl3ZmF5R2dxM0QxVHBqZzlpbjNsWHJPZ21CQXNkVVl0NjU4?=
 =?utf-8?B?T0IxaVhpWStOTE96bmpObUdMUmRQTlZjWVFock1aMVhHdFhKaUZvSFY2dWcv?=
 =?utf-8?B?Tkt3MVNDWlRzZXA2NTNUY0pBZmpHZWZycEFNU0tUaWxyRHNWQXhTOWd6M3lr?=
 =?utf-8?B?TUg1cHpNMExNRVA4UkJFcFBma211K2RiR05pbTZpZ0oyc2RvTU11ZHRhUGR0?=
 =?utf-8?B?QWs3MVYzeGRRT1JJWHczeGljV2RwMVpJWDR3MU5yQ1dpMlA1YmRNQldqSHYx?=
 =?utf-8?B?cmcvS095ejloSlBSVGlLNjV6WFF2cnRwODZEcVJ5bWZyMVVBYlNzTEZmaFE3?=
 =?utf-8?B?TGxSOGRFNFRIMnduaEtTK1FPdXJNZUVHeC83Y3dnWThjRkVGNnNFR01LU1NL?=
 =?utf-8?B?UmQ0OVBNODk3VUs5MXM1UXN4QlBkR2o2bll1eWcweFB3YTNJcGtiRGlaVDJU?=
 =?utf-8?B?ZU9IUS9CNWNadWlKeC9FNzd2Q1V1VXREQlVVR3NsVnFpbjNWZ3Y5dXY1bGZu?=
 =?utf-8?B?dVVjcHhSVlNhN3Y3UlpMNmY3SVNwL29veXovenk5TWp3aXZpL0twbHYvYzlG?=
 =?utf-8?B?UnMvMU5WMER3SDExTXVnYm40MVVaQjd4dzJoajNxQ2tCQ3gyN1BJTXFJSHJZ?=
 =?utf-8?B?Nlk4ZFlVVUlPOTJtOG1aV0pzT2NyMERPd0FsR2lFekd0d0VXNHBhVVdXclpD?=
 =?utf-8?B?VTJzdmNmbVhGRkptbElGWXp3Z2tieW1VaHJFYWkxTGw4MmI4S3lrOFBQNC9p?=
 =?utf-8?B?ZXRmQ1M5eHlrT3VSZmw2eDR0bUhwcjZIOVN0UmNOR0VWUG5UUU9GNVZDUGlH?=
 =?utf-8?B?WWZiTHFkK2ttM0xEOXQrcG5BTGorQUFGOUlRUUVFSzNYbUpORnZTbHM1T1Y4?=
 =?utf-8?B?di9mNk9KeXRlUEIyeko1REtQVVM1UkxtSXB6eXB0L0tDZ29DS2JOYTdVcjRN?=
 =?utf-8?B?UWFZY3NnbVErdit2MXRZRGFOZDV3dUI5OS9Mc2FHT1dqSzZuRzBXeUxJRURN?=
 =?utf-8?B?bUdnWUtHSi9kUTNYRjdqelBtalJiZDZRWFRBWUZNRXVoaDBQUXpNeHdQMG9Q?=
 =?utf-8?B?U1V4MjVrNzF2QjdwZXZ2YWdlVHBvSTN2YkZHTGRDR2ZVeHBzWjFyMHpzTHEw?=
 =?utf-8?B?UlBFYUJheEJnM1BzclpiZjI2OHBMekoyTVE3NU4zTVhLemNjRklIQ0huMWZ4?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c4f828-ef95-4e74-ffff-08daa73be231
X-MS-Exchange-CrossTenant-AuthSource: BN7PR07MB4195.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 01:41:26.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQ4qJxujwj2GuAFZWsa4VhZAhjdsxnaJyI7PW7AWHfEqM11rAaUnpy1tn+fIQkEHEm5SgP21EIH3hqH8htNircQSOczVskR1DdN1MBPMkWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 19:57, Nam Cao wrote:
> On Wed, Oct 05, 2022 at 04:10:44PM +0000, Brent Pappas wrote:
> > Replace function-like macros "HB" and "LB" with static inline functions
> > to comply with preferred Linux coding style standards.
> > 
> > Signed-off-by: Brent Pappas <pappasbrent@knights.ucf.edu>
> > ---
> > diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
> > index 1d1fe8bff7ee..8a8fbc274b73 100644
> > --- a/drivers/staging/most/net/net.c
> > +++ b/drivers/staging/most/net/net.c
> > @@ -36,8 +36,8 @@
> >  #define PMS_TELID_MASK         0x0F
> >  #define PMS_TELID_SHIFT                4
> >  
> > -#define HB(value)              ((u8)((u16)(value) >> 8))
> > -#define LB(value)              ((u8)(value))
> > +static inline u8 HB(unsigned int value)                { return ((u8)((u16)(value) >> 8)); }
> > +static inline u8 LB(unsigned int value)                { return ((u8)(value)); }
> >  
> >  #define EXTRACT_BIT_SET(bitset_name, value) \
> >         (((value) >> bitset_name##_SHIFT) & bitset_name##_MASK)
> 
> I cannot apply your patch. I think your email client modified some
> whitespace characters.
> 
> Check this for more information:
> https://nam02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv4.10%2Fprocess%2Femail-clients.html&amp;data=05%7C01%7Cpappasbrent%40knights.ucf.edu%7C3748a695ff1e438ecd0b08daa72d66bf%7C5b16e18278b3412c919668342689eeb7%7C0%7C0%7C638006110693613730%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=rq2pgVr1dqT2k9hC21LXueqMeIcVyk2Qjvjl1KtkhsU%3D&amp;reserved=0
> 
> Best regards,
> Nam

You are correct.
The tabs were converted to spaces.
I will read the link you have provided and fix the problem.

Thank you,
	
Brent
-- 
