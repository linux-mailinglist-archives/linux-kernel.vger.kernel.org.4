Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827B46AE3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCGPDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCGPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:03:10 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DDF769FA;
        Tue,  7 Mar 2023 06:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnVoUVVC3rMUCKDVqTx2IxeUMWVQssu0vRUY9cIKhd3m/yD8zOImqvnUpFFm1CCjBGUH2vyAB5SXABy6UpgknIFjl07wJTGfxzl8HHWKrKxAJ8npOonwE3VZO/YSWYN9YJVQp9uipc9NAjDDyPlUEhyy0q+sehTeQsUq/HJI81VgnCeXiWmIEZWD/OLIk4jcv7TLUjHyVY+kPQnkUsHk4998PF5arFn9sX99YGrQo8kO7eYdyZaulwdU6FDj3Dm/fPDW7sjlgvZP3zPJY/GSloE4sN6a2NE7eook7uMaA0L1nGejeNhBUuRmE17Z4u4EcBJz435Gq1AJxrVIMZE4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDFp1DOIjaVlSVjO56oeVuziKJUq4Eyc9t3kiH7YCiY=;
 b=oWcOS8pODTJrIrUyfmknGZdRx/Z1ecD3MC3hKma7ZWevXhx+xjssZXy/f76K0O+0/ieyemSrSqQCEJVwSGgzB+bRcuSoU4ElpfqeFgoN5v8GVtHlwDQhHI/txLNjypXbDfjBK9Y0rp0EfpCvp2ZwlJ1mI8SQWmZRUjb976zeJiAmzGbFZ96kNikT+vlGXGrnOabnAKfZVjHYUE1OFvSU3PQugFg+lV5a34N++QHZLZqfYbyNiJeRqp6+H0/7h9LYlVcEwBD36F9DV6RpEC2fbUScFJdYZ8JvkRl3V6DxtQFpwllOCCmkCqZVy8mZJaTdEGkV9kLWF1uzbH6/GV6X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDFp1DOIjaVlSVjO56oeVuziKJUq4Eyc9t3kiH7YCiY=;
 b=Y0GNUUo563jLjYyEOstT1E0ybRzLPdazfpzKS/cI64hsDPtSABjjrHKwwkCqHd9YYLVLejRHplA0tUSgA9v+g2VlbfSOjvUC/TQVIA5hEFacHOKmQnJw7ybeXmPAUXFWp8m86n6U3Hp0+cZ1kLObv7YlY8FILTOBWCDgwuk3f9zNz9Igz+LgIUu73vdFxpmUu3lRMJQ8L+ofQXmxqRxeFhiEEy4h8ygi0RF78WMt0pYc2q3d+UcUfbic7kPkzBd3O2aWjuXquoCAoyZxIXggapEHE2QDp1XoxNXVEUXHtlUhZ3QtqRARxTWqOQxgIVQDmhtiK0PznLArzJwty0767w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 14:53:18 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 14:53:17 +0000
Date:   Tue, 7 Mar 2023 22:53:09 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v5 0/3] Add pinctrl support for S32 SoC family
Message-ID: <ZAdP1Z+LcgOQWvtK@linux-8mug>
References: <20230220023320.3499-1-clin@suse.com>
 <CACRpkdYknZo3Q7_CeSkOL2XwwAmKERskx24o-toaVy=rs0Yf5Q@mail.gmail.com>
 <ZAZ3JZQ4Tuz5vyH1@surfacebook>
 <CACRpkdbksZ59ndrRAQpTGa01GTq4c_2EcOQ2mtz1PLjqU8_nug@mail.gmail.com>
 <CAHp75Vf3ve-NdMG6iti-KSs=tGGgGf9tNj=aK7Jofk9233WocQ@mail.gmail.com>
 <CACRpkdaCZSoem31GmDC97LPYcZqRjkyf=6VGtXdXK0iwrV74qA@mail.gmail.com>
 <ZAc3nKEiYbUEX2xv@linux-8mug>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAc3nKEiYbUEX2xv@linux-8mug>
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 748b6f9c-c666-47ce-efcb-08db1f1baf6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jSmnMJB/74zXU4fIX6r7kqOSviFCevGoFj55N9AEw42hvmhb8CKBNzaKmDsCohUM1LawGC14ba80RYEoDCn92VLu2fn4ospbfFW3N0nQdd/N/eN2EGnYdsctqA2MtQbkWJY5IVFf5twP0zuk4Ah9reFf000rsY4epbl/ygjD9uBylY5n+GjZ7rPxPI1pOdw6C5yvjZVqFwE8oypj7Ah9LI3NiwYh7lTXdsHuJHNUbEKUOzJ+UtiWdVR9gcwSaYcTpCZUQ1Lo/cNw9Izj3w7MP8VBFl+s7CoCwua/nYOuNTiKei6vRttBC/Pi6PG7HD/tpa+1StzUrTODJ1ETJunqKGm5nG9dbu88EcfkxGbX/Poen59FiR3uK5d93kItaHQVHPtzIo2aUUUcYlmHuVYdaz6vgnD5Tux7LxzvCtutdmtKhteKSq7yMQi2vDRXBPzzhZWOFPha3lOeaau54JhSG5WyKZGiCS/94YiJ8ylXC53ZRL0QQQp8SwtGbX2eLi5TqmaGMcPHOz1i63Ypbq5StV+3P0UfsejZ8v9Yu9P+nrYAOiUrWywnf5DiZdZu4LsORY+WIVBuw55wY/F3QXdrnmWwKNXSjZWrE/zQEGswZ4tCPCiXYJzO4SEVas9xW4HPz1/x2X1VF8Vr1i3vwHARVZ4NwRx6XKafugk+KWBApHgJiUsCrGg2mtOe6ZCcYqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199018)(86362001)(38100700002)(66476007)(2906002)(66946007)(5660300002)(7416002)(41300700001)(6916009)(4326008)(8676002)(66556008)(8936002)(33716001)(186003)(9686003)(83380400001)(6506007)(53546011)(6512007)(54906003)(478600001)(6666004)(107886003)(26005)(316002)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFubVduc1lJR1ZycU9XcFIrQ0lkMUt3MUlZVTdCVnU0aS9abm4vb0VhYWkz?=
 =?utf-8?B?ZXFhSjVHQUc1aENDTkZuS3ZEVHhHNmNSdUpyem1EWDRwSks0YWxjOGJIaUkz?=
 =?utf-8?B?TGpTdmp5bGJqZlVDOWpUZ2VYN1NSeUtvVHR0NXlORGE5SGhSU0U5c1FkYXBY?=
 =?utf-8?B?c0QxMjlTT1ZjQjgxUDlTWkRyQ2pSanl5TC8vN2w2ZmdzZzY1Q0VoSGkwcDA0?=
 =?utf-8?B?eGxmQ0pRR3hrV0E2SmFLV0Vwc1lHN0NFaHg1SFlNWnFUYnA1NXM4NVp3V2Mw?=
 =?utf-8?B?YmxkSzllamk0YXdkdlNFbDgxNEJ3SWlIUEhOejNKOExZc0dhc2h6QTBKWXJQ?=
 =?utf-8?B?UzkwV2NmdTVSNjNPMTN1dlpVOS9kVmN1WlNBa3JrOFA3ZHJDNEpLY1MxVTdl?=
 =?utf-8?B?VGg1a3hoQy9jVndSNjlMTStqUXJpVWoyZ2RFTldvUUxxbTlsYjg4UG12M0kz?=
 =?utf-8?B?QU5DTVArNDNydzhDYzU5bkZld2dScHdQT1d4YU1yOGh6SGU5bWVuS1pFejhm?=
 =?utf-8?B?aE1kUmRmVDhjRkczS2tiazZjTkwrdzdRU3BWWFY5ZXR2L1hqUkhybTRiLzhn?=
 =?utf-8?B?ZW9DNXQyR2xKZ0NER1ByOWNJRUJBNzlMenE4aUpFWDhDUm52dHQ2TE5NdW4x?=
 =?utf-8?B?ak9uNkd0d1NMUlQzTjAzODJOdE5Vam5HRWlDZHkwVFlSVVpuU3Q4c3FhRVZt?=
 =?utf-8?B?U29BRnM1b1Rhc0pIaTJBMk1KajU1OTZDNzI5U3hhNE5ZY3c2UkNCbThPeVkv?=
 =?utf-8?B?a2E2cVZ1WUpod2FzUnpTMVlBKzJMcm1ramdzcXY3WnVobTluYXdwRlRGZ1c0?=
 =?utf-8?B?eGZmT2V1VkRnTGRMVVBDNkJ6RnRtSmduTVhYRWxiYVBJM2Z6YlZ6d0Jxc3Bq?=
 =?utf-8?B?SENzR2llYlA3OFRXaVBSQjNDbHRDTDJOSUsvV01SQ3NId2pCSUJzYzJDUmJN?=
 =?utf-8?B?SHd0SDFBdWpnS2dZdTFJRVJta1luRm54L3M3N1E4MTBuZ2JMRG43Z3pNWXND?=
 =?utf-8?B?SlNqQjdFUWUwZStBTXVxV2ZvbjhUbkdTSEdGaEwwV2ZDd3pkem9zdiswMzdO?=
 =?utf-8?B?THh1bzFrQkh1STkwWVo4WW4rcXFoSVNTMEhLUlBtV1NKU0ppQU9VS0ZnSlJp?=
 =?utf-8?B?ZEFHdFA2RVdpMTdGQUg4d3hZbDdUQWoxSmExN3BpU2lTVmV0OStzMDhGSFY1?=
 =?utf-8?B?emtVbHpXU3lSbTIzYlBIeEU2bm9yNHNXQzhwdnFFYmtqbm9LdWlJTkpqS1VN?=
 =?utf-8?B?QUpmOEFGMVlMdlpvRThaeW10TnZWWmtBa3l1emxDNlVBTkhjcTh3SzNTZjJR?=
 =?utf-8?B?aGNRSWN5akJXd05abDVsUWhwZDkvbnFETXpnWktBVlY0QWttdlc5ZHVXR2Nx?=
 =?utf-8?B?T3EzcWVDdGxEUFVad3lKVkR1cklqdldZNlRMelVwUU42cVFGekZQRmlWZHIr?=
 =?utf-8?B?V2ZnSEkyYnBHb01zV2lyTWo5bWRSbmF1WVJXVGZmQ2dlaGk1N25SdVJWTHpX?=
 =?utf-8?B?VzVOcVNPRUZlbVQ0QnZiK2pNZEl1aEhqRWVWbFRqRzA4ekVoQmQzSHhvOWh6?=
 =?utf-8?B?V0N6MHpxV3dUZWhpNEJGY1NHRGxJM2NpemIrdlNuV0V5Z0lwOGhGbDQ0NFg2?=
 =?utf-8?B?d2ZlMm1SR1FBRHA2elFTOWNLaUpaVDdlUmNtYmRnbzVnS3d5dHlGd3RNZmc0?=
 =?utf-8?B?cHJwcHcvdW4vNklqbjB3Mmw5TnpFTjBPODRNdjZaakVJa3U4emJuUGo2QUZp?=
 =?utf-8?B?KzAyLzMyd1Q4K2kzU0t5M3F4MXZsOC9zazlzcFZucjRlMjVZYzgvNjVqMHM0?=
 =?utf-8?B?K1Y5bkY2M2c3aFpva1VvTm5hQmpzbC82M1ViWGxpWG5LbGRTdmwvZkxvZkxV?=
 =?utf-8?B?LzRuZHJvYzNsckIzU25ZYUU4dnRERWQvRlM2VjhZMzdUakJpTDJEYng0a0VU?=
 =?utf-8?B?QXpHN1hrTnZSeTBZc2hzbW5tKzNjaDcrc2R1ck9XWmhjQzc1WXV3cXRiUVdU?=
 =?utf-8?B?U1F3Mkc2bHAxb3lTVjlOb3JJWk8zR05lalJjUEZuZFo3cTIwNExoV1I2aGhm?=
 =?utf-8?B?L2k2bTM4bktxNW1lZU5vcDRPS0pQeEVtd1ZBMTlGVWNzOEswNUpqTEtTdWVZ?=
 =?utf-8?Q?8a78=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b6f9c-c666-47ce-efcb-08db1f1baf6c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 14:53:17.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdBdTgq72EcI2oDkKSOKonQciZI07I8UOWqj65rCfg0Mm7E3yV61S8U495lMAKNT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:09:59PM +0800, Chester Lin wrote:
> Hi Linus and Andy,
> 
> On Tue, Mar 07, 2023 at 01:49:00PM +0100, Linus Walleij wrote:
> > On Tue, Mar 7, 2023 at 10:56 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Mar 7, 2023 at 11:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > On Tue, Mar 7, 2023 at 12:28 AM <andy.shevchenko@gmail.com> wrote:
> > >
> > > ...
> > >
> > > > > Can you unpull this?
> > >
> > > > If need be.
> > > >
> > > > Are there serious issues with the patch set such that they cannot be fixed
> > > > by add-on patches?
> > >
> > > There are a few absent error checks, some error code shadowing, etc.
> > > I can't tell if these all are serious, but the amount of them is like a dozen.
> > >
> > > I reviewed the patch, so you can look into that yourself and decide.
> > 
> > I looked at it and some of the comments are pretty serious and need
> > addressing ASAP.
> > 
> 
> Thanks for reviewing the patch.
> 
> Please kindly leave review comments if it doesn't take too much time for you.
> I just want to ensure that I won't miss anything.
> 

Sorry that I just found that my mailbox didn't receive Andy's mail [comments on
v5 2/3]. I will try answering it and come up with a patch ASAP.

Thanks for your patience,
Chester

> > However it only affects this hardware so it's not like it's breaking the
> > world. I generally prefer in-tree development over too many big patch
> > iterations, it gets more focused.
> > 
> > I think if Chester can follow up with a patch or several addressing the
> > comments in the next week or two that's fine.
> > 
> 
> I will do my best to solve it.
> 
> Thanks,
> Chester
> 
> > However if we get closer to -rc6 and nothing has happened I would
> > not be so happy and then I might just revert the driver patch.
> > 
> > Yours,
> > Linus Walleij
