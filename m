Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAF5F67C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJFNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJFNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:21:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56FA8CE2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlLzlNsDAtBiTEQeVW5/OGLVUfukE5iq8ezIwEhgxIoP2iHJK4/Ul1wBWEFB4zI0YpEJseAgd220usREILzivgp/XtJk5ro/mtawWQhRRZEnYgaToKzQtOvzSG5bT43Dk/NmmKZmGL5uXAjrE1v5259BuIlUcP3lMEzerdVvLrwPTTz7GC7k7C4v1gIs1d8w3H1LXypXdB6q+8zo4xH73/xVAos5NGCFKc2Y5tcrjiCuxtVr9+ldjMBx7MFz+4l/26k3rDFMVBhzSNFbhEfmTNYX0i7lgP+9/Wxz/PlydBNhRTNZSLuUCZ2+h4UTYSmhDniTEN2aUlX8jzxoms6Ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfb1lbIzF2Eo52x2UmsKR3Fz9ObCKR1zYUUAfmsunHY=;
 b=cnoZPQ4phC/n6lGYgh/w0LLywep8xR/b04hcHDHpcqbxDZcyyDndHtHYKQVqa3zu1ymYkbDzHhUk5RIcGPpaX4BTqf26vaDnKMZy8rgyqSvOB4wvkCrSI8dCsyzUReutpRoMv/uwjxQeAk9Vc/xiRemPb2B8qSseSt+palTJ4h/U8RhsjSqrZhD9U9K8kaaqP3S+lwQNqVkoE7NhI7IsDVR3lwQuS0XKSHEEyoYl5BGptBwqnt/Bnq//QOoavJli13zKsSAJpbFW98Ht2XfpS1EcFX2/L8n09z9QND3tWzvLtBlLPz2jX7wXfiX/pNF+I7LD4FTbK3AzxZDzVI7Ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfb1lbIzF2Eo52x2UmsKR3Fz9ObCKR1zYUUAfmsunHY=;
 b=HIdKmsyf0AH+N84hvHf6le7oEUNjBoSueU1CVwV37W5rULWfiOzJMjfQmozpV2i7HmoJFFLraXFuyvHNTPuMYuF6HEVF8f4OCZ4h+/JQNXxa9zFTQz+lxw4fYeNVVS5LigKuaLP7tkTl5v6GGaL1RKB1RAXjdHHhyEm+L8Abrdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=knights.ucf.edu;
Received: from BN7PR07MB4195.namprd07.prod.outlook.com (2603:10b6:406:b1::33)
 by BYAPR07MB5606.namprd07.prod.outlook.com (2603:10b6:a03:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 13:21:27 +0000
Received: from BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::9a4c:e558:6a54:fc2c]) by BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::9a4c:e558:6a54:fc2c%6]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 13:21:27 +0000
Date:   Thu, 6 Oct 2022 09:21:24 -0400
From:   Brent Pappas <pappasbrent@knights.ucf.edu>
To:     Nam Cao <namcaov@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: most: net: Replace macros HB and LB with static
 inline functions
Message-ID: <Yz7WVCzAviUYstX9@knights.ucf.edu>
References: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
 <20221005235728.GA118549@nam-dell>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005235728.GA118549@nam-dell>
X-ClientProxiedBy: BN8PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:408:94::40) To BN7PR07MB4195.namprd07.prod.outlook.com
 (2603:10b6:406:b1::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR07MB4195:EE_|BYAPR07MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: af991d3f-3f3b-4ef8-bf29-08daa79dac28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xd4KM6JilH+HnamxKGd/+5FM8FXZjaXMJgThvywuMphCZoi6wam5t1MDfXRxMSXFlP4dO0CnisCjasAolHBKUvyF0ehZ5InBwV0dLc47/JK5ZvEFXCthGiAamwlbXJx+epwcgee3d+1EcPBMCMWvy8nMD2GDAUsrDpjvLn5jxzWyo59DoIGUYbRj1tSij2mSHAtk0d/HcF8c6AkUhc1t53rWte80giIiOTaHafPXt2onJyQYcA+SrQ95m1PLCTfZiE3yKg5cnl+moDztinRcfenoapMJW1sFMB8b74LCNSE73XZ8VZddf0GWv8ggHj3cZGJkZwIWcdFp8N62MRTsWN8IbUxfSWIV4HWEausu7zcddfzX/IvD+bTUFVsUwpG5HQW0/3aWcrlisNv/eF6/NtcXsvdT63uAx32jar6OdXYEZ553MEGOTXj9cjGTcV/WcSkCmSA+n7GapWhy3SJ5xUNVaV7qnsZ7H7kmjt2R38I30FEEgQhnC9vDx0iDGNWMmsg7T/i28ijBqvuA0ItFUvXvF0fMkNcfe3rNg53yeQm9TR3X8LdGmWPw/a82s9EfgxrzhKYUJ4zfzHSSEFFq6N3mgitiPZdm27gw+zyfjkIixyk8cBhVYBiCmtIzXF8PI/f5wx1lNB/rY+2cGtJH72HxhGKrp7uDpdn3Jo0Ilm97EsSdD0N/1jgpQBlEztv+euNkjZ5I0TlNZnHwUGDMrGzZ+WuMnKnxNj0eHs5wWdg30TdERMVkIIFU0ULb5ObT//hEbXsnUJ92IIz8NJY+VMzTt7oKdce3ghOLRMI2XTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR07MB4195.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(38350700002)(54906003)(75432002)(478600001)(966005)(6486002)(45080400002)(6506007)(6512007)(6666004)(86362001)(52116002)(38100700002)(26005)(2906002)(8936002)(316002)(786003)(66946007)(6916009)(8676002)(2616005)(186003)(5660300002)(41320700001)(4326008)(66476007)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXIweDN3eW00ZjA4Ry9tRk4rMFQ5UnFwdEhZMVdkWVM1MHZJNWtLUlQzMkZj?=
 =?utf-8?B?S3ZrK1EvKy9QbUhvSHJCODhYa1ZWUE9JSmhNVnN1ZjYyd2poS0J4TDJnSHZs?=
 =?utf-8?B?WGtOVnJPZ0pQNVlRSkZVaWVkUFNCUDVobnA5NFc4WTJ1U3FwYnpRSTB0djBN?=
 =?utf-8?B?Z0RteDZ0SmgwWWloZktLMzZ2aE4xN0pJeHFFb2xGMmtSdnQrZjFwVTBVZ2lT?=
 =?utf-8?B?VUhmazIyRy9nV2RVZG5obDVwa3hWWFRTMWw4UXMweHJuQkdNTUNCU1E2VDNs?=
 =?utf-8?B?V1RSaGN2eHJqVkN1N1d5MUNQTU5Da24rRjZ2QUp6VTg1TTlUVGo0TkxSaDhv?=
 =?utf-8?B?MVNuRlU2MDlXVWZTMWE5VHB2UTJEc0VLdU1KUXp2WnVEdXB0aXZORGtORjBV?=
 =?utf-8?B?eEZQdGY3bWNjeFQyZTJSQm95ZUpjK3VTTmxFYUpSUFY4am50L2dOaEhxY0FF?=
 =?utf-8?B?N005dXlqbnpHcDIwbWhHQ0dGMHhkRGgvaUhXdkxUZ2lhQW5XdUZ0bEtwbjNB?=
 =?utf-8?B?c2lCdHQ3SG54RWI3TUFQY2kxTmo5VVN3YzFMK0Z1ODQ1N3l4cnhnL2xxc2xY?=
 =?utf-8?B?TUk2N1dtR0NOcWZObDZ2UDQxTzhua05yL0V4bTdsbE15ZFF5QjcyRmVrSG5S?=
 =?utf-8?B?SWxSWVVkUXprc3VVSDhjT3lQaWRxd1ZjR0kwTGFKZE9acUlDdi9TUmwvRDQ1?=
 =?utf-8?B?TEdFQ0IzbUp3ZWlpZEtMTkd6WE02Zi9vUjFLSCtyMWJmUVltdXFTKzEwbjZW?=
 =?utf-8?B?TlhUMENoem02bW9sNTZ2VGFLa1lPV25rV0xzMm1RV1V3N0JTQi9lSXBEY241?=
 =?utf-8?B?TGFaQzlNU1pIenhWc0tjTEM1NndJcmFMV0VzczVBdU1BKzVYaWNjNk12ekpG?=
 =?utf-8?B?U081b1ZhVzVvMWkybXJPQ3d4TURoazNXVHRtaHVDRlBZd2t4Q05xN0xjWFcz?=
 =?utf-8?B?Q2swZCtSZ2Z5WHBGejluVFFIMm5Cb2JUNGkrVm52R3NQV0lFL09ESVI3c0Va?=
 =?utf-8?B?VzRZVGpveHpGVWlVb1hsOWZGMXRxakhHMEVDMmtONC9XMnVnOFFCUTYyR0hv?=
 =?utf-8?B?c1Y4amtIYnp2anI1SFh4bk1ESG5iZzd6RnFDcHE4TDQ1enhWMURIVC9wbWZR?=
 =?utf-8?B?OTM2Uk9FRVNNVm9hVHhKVlNJSm44NXRpMUt1amkwTUxFYVBHYm94ejkrR1Zj?=
 =?utf-8?B?dklYVkkrUzBOT3FhaFFEYkk0RmdhZ21PZkFDV1hIbjFvK0FJQlM4UkRjSno2?=
 =?utf-8?B?c1FJNUQrL0cvUGw5RDQwQWdJd2VvaUMrTmUzSTdFQ2lZaW5zRHJQdkNTQUNu?=
 =?utf-8?B?Q1MvSHVsVER6b1lqSmFMWUZLb2M3ZUJzdjhMUENsTVk4ZmVjR1g0aVBSRy9M?=
 =?utf-8?B?V2R6UzdMQkZtcUM5VTc2UzIyL3I3T1BhcThCSFcwd0hzL2JUMk1BRkRoWUoy?=
 =?utf-8?B?KzZvRXRMQ25zVWpYWk9GZFVSU0kvbnM4M3VQWVNKSkFDTmtEUzZiSWFUL3Fw?=
 =?utf-8?B?MEtuVXZnQlNEVnBGR3pRcmdPRVc2QzU0VzBuMHUwRUpCUWZ0NE9QNEd2aDFw?=
 =?utf-8?B?eVRyYzI4WktscWwxMWJmTUdKbU9xNit3Q2hMU0FMWElHUkI1Rnk3cUtzendQ?=
 =?utf-8?B?NFllTS8vTXlyWVVvQUF5K3ViUkFIay9QOXdEbjI5Z2ZNenJWc3VCclFYSkhm?=
 =?utf-8?B?dysxTnBqVUYzd240aUdVTDNYUDMzZTJ3dU0rV2QzVE5qZ2diMjhCZTZkb0hT?=
 =?utf-8?B?TjhuWGhPVjdrNDNOeUpzdUhDZ0VSVVhKWCtkMXhSSDRpaWpEZHVzbnNlSDFt?=
 =?utf-8?B?bG1yWHBzd3o1REtTRWJuRDM2SGVsSlJ6VDFVOEN0MlNyMXFreFFwemYyZWlt?=
 =?utf-8?B?OEM3QTNqQmJZNzRJYUVpemc0dmtFM0RkeGU1ajBDU0RIMkxyeWU5NU9iVkQy?=
 =?utf-8?B?ZnVLdngxL0c4d3FSRkwrNlRaa2cvU3hwczdJRXBYSGI0eHFrNFZtSUpmL1pN?=
 =?utf-8?B?Y1NCbER5dUQ1VUZjK0VkeG4rMDZ6UFhhNUtUYlIxTGNCc3Z2aDFGVnV3eTBx?=
 =?utf-8?B?SUpxTlU3VWZ5ZDhibm9OQWdmMklNS3lVVU9yRzNrMXk0WmVGN2Y2bkR1RUx5?=
 =?utf-8?B?T1RHYitnNUJSVXU5SFFRc1FpRnJiWktmQUp1bnJpaHVpcjZtL2tSVEpaSndr?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: af991d3f-3f3b-4ef8-bf29-08daa79dac28
X-MS-Exchange-CrossTenant-AuthSource: BN7PR07MB4195.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 13:21:26.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7ePqmwzCEP32gc46N2aGlcaegqZS6UmFleuToKsTl1t1qEiwfvAI0v6gIROqjqo/VHg9Eofs2dZz+R1gd/2Lexn5jksOhUltcY0wjs5Zg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5606
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/05/2022 19:57, Nam Cao wrote:
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

I have followed your advice Nam and am now using an email cient that
leaves whitespace intact.

Should I reply to this post with the corrected diff, or would it
be better to submit a new patch with it?

Thank you again for taking the time to review.

Brent
