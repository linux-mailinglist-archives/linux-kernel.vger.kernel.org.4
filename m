Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550BF6BDFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCQDpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQDpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:45:46 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2074.outbound.protection.outlook.com [40.107.13.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE200B3284;
        Thu, 16 Mar 2023 20:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOpnQ6xmfftsvXluDQg4wL7z3AyVDGBLBCtWhiFKLTsMB+DEpxBmGbkX/vEpaKTKlfdq6WGy5jmaH4yx6ls/1WWp4Q39x1fqqnH3qcNbdVmIMGukQLxIL3b07ZcWvuHpt+epL6RsvFAMzUxEyq0pAj/rUathrcLqNrliT73i7n5vlq5tH58suemqeG5YioJmAJLoe/qSXyNJfQxzJbaXknYH/r+FZqY4QSgy9q+X0nfeaXZvkO27vbK5kRTqmdMbxq2ddcNVDy8qrz+XOUfjMJGmEhWcE4ORTiL7HRFk4zXxH+Bt6HNRbbEh3qs0QUFx9RiX8JIgRb0BOmrCv/2Ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Czdlx/cNW7KtySQdKgBc7R6OYWDGTq4oUFrX8x16+yQ=;
 b=iYHOWfpzBvoOUaEU/NrIXS+UxtS5dtC2sF0sf2LVZPWLnUa6xFGv8YgEeC3ldj6HM5SkTW8C6/+dtfdFyBDPJLONSm2rq+wyf8J8P/Vn2KlK5UpBo/wplVEBOgKhPqCF+9TBsD7XS62EexVvGPh4BWXa+XUjp8RLVUKabM6uiBWeDCNNbJ2v5SV9ShEpTf6c/BAwDwkDVxO0/ULz5KhwEiO4vpCFvbi+Cdw5HijYRnvkTL2zmZWYziBFs/TcYDpsjnG8F/iO0rbxy01dp1LMUo9gWxSDFnUJU+iYk0rOH2HPwBEhY/AuTwwHqezr6amJu6vejKxEQGhCK0TVuIIr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Czdlx/cNW7KtySQdKgBc7R6OYWDGTq4oUFrX8x16+yQ=;
 b=hs8lHMb0fvWBfJdj2xBESg+NdwJgmQriRJr+cICZVdcSKw5wiHmmLSTQydgPQKwejev3lZvGtohjIt2yJcPCn/DV77aSKPEOAd/eAQxPLjXfVfn+x7xc24ffZG71uDv2+Y8uGKsk6BKEf3Pa+TVXAB8TFyZNsTpdmPfa2QosA2JBnF8575n/7wAPuJaS7R1DxMrxV1htnXUc+qh6XfU8pDf0ZItDt9hw+cKe2SGuX0j/4RH/4Nr32QoWSt3Z00xvP64INFGawcr8uYU44mQ4eW//wfTzFj/nQf1RJU1KVH3HJ+tYrTtna8kXMpIz+cEuL1oEJO/QH3Zp8snyn8EH2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM9PR04MB8098.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 03:45:34 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 03:45:34 +0000
Date:   Fri, 17 Mar 2023 11:45:21 +0800
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
Subject: Re: [PATCH 0/3] pinctrl: s32: driver improvements and generic struct
 use
Message-ID: <ZBPiUTFRFry/BAqR@linux-8mug>
References: <20230314134642.21535-1-clin@suse.com>
 <CAHp75Ve=U_rkgL6ohpy1r4RejXK-PqgrqfkPmCrhzK9O3necnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve=U_rkgL6ohpy1r4RejXK-PqgrqfkPmCrhzK9O3necnw@mail.gmail.com>
X-ClientProxiedBy: KU1PR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:802:18::32) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM9PR04MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 735aff65-9004-452d-53ad-08db269a1056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZzN/cPZLSwENIHUClrH89YYDkfpk3XLMkiKd6AR6C5m4eegxpyALFzN4ymOkuxLS8mxbdtZfhzw7GLpndjKuFX4qK6zKQHFfZ48AKN97HaWL6c5boKPI7Md50XKagxIXf/XfN4mMncgAcOeMpsIP4ibcjM124tP3zrhFhua2ZmhvVJHhuuoTuqMMgahR7WAEIaHvIZuVE/g6WD9/wmTNGQ1ycGZj8qGHh8f+zOyo6Eyyfv/i9uXZJpqcFnxeeSrOENhUJDKC0cszFWvEbZGOBKorUj7/eeeD0ZuTPgWF+4RrvTWxKTdypUyK9f/fyDmRnSv2Y04SjtuL4Bpl9LzyUW+XGuG+z4lTaMhwOmCyq3+9sb0qzT6gqG+wqq3XLe8Q3J2086sNDIG47yZtjwJnnNsyzU/0QEX4Q+QqynDVQfj7wuGEPVbBEpVlAcfxwOKInHGyHtHEYCzQS6YWCK7CkNhxo1UGWkT+bAXM4qsshGzF6C3dWZ33Qo1ruTvkcCt6QYTeG+5dQsxLKl69Red9l8r5L6sh/45j0uiWYEuRoTMBrtbh2DoO0LHf75eBg3Hvdewb5QK88R/NaSaG6jTa/WJiuKmcvAcG9rtnwmyVzSYn3ATkgyKNQPjMGKHSZg/rmoSQ1gWQyCyElGapKTtXt01y9Hg22ndTqWNCebjyWFKbZrskuSioI89comO5Wt4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(33716001)(54906003)(478600001)(107886003)(53546011)(6486002)(5660300002)(6506007)(6512007)(9686003)(186003)(26005)(6666004)(316002)(38100700002)(86362001)(41300700001)(2906002)(7416002)(4744005)(8936002)(6916009)(8676002)(66556008)(4326008)(66946007)(66476007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk90NzEvRkZnZjhUOERuZzlFS1dMaXo3Wjd3ajVqb2dKR0pKaEFiNUFJaVhZ?=
 =?utf-8?B?RzlVWU1BVHVSVjRiUGxRY0Mxcll2SitwTVdxWU83d1NmQnE3VmhNMjVNYUdp?=
 =?utf-8?B?TUxneDlCeWxXc3N6WWIzcC84cjExWkFsV1RLb0g2QzdiODBKZlJWN3BUY1lk?=
 =?utf-8?B?dEpKbElzQnVPZEttSmVjQS83V0FHZmNPcGlEVlVyZ1hYRzliMUxzOVhKQVJD?=
 =?utf-8?B?RXQrQ2NuVlVRZzV0RmNZWnJlVHA1NjNoV01HcE9nb1RxSUtTQVBVUEJqWTZ5?=
 =?utf-8?B?allKeEg4bVRMYnkveGVXc3NvTGk5UTNGREVhemlHMU5SRDd3TzdZbE1RbFV5?=
 =?utf-8?B?bTdlUnd1dWRxV1NGWVE2VHp6N1lZaXZLM0hydmxJa2VTL1JabE1GZ29LQXBW?=
 =?utf-8?B?djhzZ2lHN0tVNWRlUTdla2toeEd6eFhBTWxOQndrN2U2blRmSmtqYlBMVHhi?=
 =?utf-8?B?bEZBRTRZYUpManBPcGRLaUZvYmV1bmtMbXpjSm8yZFM2VG9FRXJURTFITndD?=
 =?utf-8?B?TkdSb2hrYVlHb2ZrQzZQTnBqNWd0dUE5ZmZXbm1oeUlzY3FFRnQ5RHhLMkdD?=
 =?utf-8?B?Zk8xQk1VeG42dVVRYldYNWhVODRPRnYwWmljbC8zeHMra1FycjIySXVrUUlY?=
 =?utf-8?B?VVlsRTNFVUdvb0hKQ28wY2g2blI0VVZKclMwTzlLMlRuOVlINmtsRnlqbzBk?=
 =?utf-8?B?d01QcXdiNmtVeS9lRUYxRFZ3R0paK0J1T3ZvRzFFOUZtbkQ3TTMrK0s1UzAz?=
 =?utf-8?B?Tjc5RFVYY3VYZkJ3dFdaMDZoYlBXcWRiSE02MFl1d1BMZkEwakxUVEtsMEdT?=
 =?utf-8?B?Yk1NMEM3dXRvdFYvd25BWkMxRWo4ZFVMVmQyZ2h6V2hlbUZOd3IyVkxUdmVt?=
 =?utf-8?B?Tkd6V3ZUVnFtSE1UTWdFTy9HLzM1T2F4d25yWmo3NysyQlRUbTBiWGR3a2xw?=
 =?utf-8?B?ZnN5eTBFR0kzZkJoSFJCckJVL1JvMEE0TU1TSUg5cU44RG1ORkI2SFpSYU1h?=
 =?utf-8?B?TXZUaVpMVjFwRzN1dUVmbE9xeGpJYWRVSjdrQnpnM0FJckh2MkgzMVR4MGhv?=
 =?utf-8?B?RGpSUDIyaW9BTkFBaVUzdFVNYSt0ZzAwcGVueEV1bHFJVEpiYXdKbHVxekxT?=
 =?utf-8?B?RkNERE9WMlh4azNDdHEwV1FXYjhieEkzYTBhbjVjVEpTOXhUVW56ODR5WVFP?=
 =?utf-8?B?anhkQnJFUzl1ckJrREZTUXRyOVNIWnRiVWQwUEJyalJjcDlEcmoxd0lqdW1w?=
 =?utf-8?B?ejBWQmFLNlkvdUFvN283VlFnWG4ybVA3QWpKNExDR0N3OGpoWUtKMXArVlRw?=
 =?utf-8?B?L1ZLR3ZKL3pVZVFnd2FoODZMQjFqWEZIcVY4UVJqdUxFY3FUcW1leW5QdlEz?=
 =?utf-8?B?bU9wSzJiVWR2eWpmWGFLMWpPbjZFYzBBaVRhUDNuZmlaT1ZVRjQray9IaGVJ?=
 =?utf-8?B?UVhLSnc5WUhvaFdjeHJ5NnB2WW9PT2VaemFPR3pNNFRMOVQ1NmV0OW9mR1Uy?=
 =?utf-8?B?MlhZNm1ucElyem0rbUkxd2NjUUI3eFZSdDA4TlYybUFUVmVwN041YldncTN2?=
 =?utf-8?B?eUxmR2pPcXBsSEZoOGNvNkJFVEdRdFBUbUNiTnJXMklGZVpUeWVaMTZKd296?=
 =?utf-8?B?Ump2akF6dG0rQ2N3UUFlUXdnQndkU0pvR1FJL1ZZRDd1Y1IwcnVucy9lZjN4?=
 =?utf-8?B?azBFWXdFUGUxcWFSRHZnczNnTGxQMTZNVUJxbTZkZkNvUlNBMktRNXhIVGhR?=
 =?utf-8?B?eHhveGJpUVlPaDBJYlRMakN1Z3prTnd6WDZ3UXFCUGdPV2lrKzNjTVMzNFdi?=
 =?utf-8?B?SVFhMituVXM1dWF3aEEwaTBMamRWWHN5ZjlSUDJrRVpOMVJWR1doOHZsVTdG?=
 =?utf-8?B?MlZ1c1kzZm1rYUZHalppWng5N0hKU2Q5UENrWW5VUUQzaHFHNzZzcG54WHFJ?=
 =?utf-8?B?c09zNG1VbzhhT05IWlJ5aWNyancraVQ1QXV2Wm5WQzc5TzBUcTluR09iS3F5?=
 =?utf-8?B?TlprWUU4YmhGenlPUE9Ea1BwNENXOVVLbEdxVGlPV3pxVUsvajZqMkkxaHZq?=
 =?utf-8?B?UjhOVXEyOVM0V1hxb2gveGhVa2o5L0JCVXE4N3NFTmFSdkhzWE9Uamx5eGVB?=
 =?utf-8?Q?Czi+RSNR+vbhlbB3aFh2+/enx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735aff65-9004-452d-53ad-08db269a1056
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:45:34.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXTZeTxNRT4AT48/ndLjF90epgVAIECfdqw5OwWZ/ttE4Ny1wKcbEP0zXuHD/MRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 14, 2023 at 07:21:55PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 14, 2023 at 3:46 PM Chester Lin <clin@suse.com> wrote:
> >
> > Hello,
> >
> > This patch series contains some improvements for s32 pinctrl drivers suggested
> > by upstream[1], such as
> >
> >   - Fix error shadowings and improve return value handlings.
> >   - Fix print format.
> >   - Remove unnecessary blanks.
> >   - Use proper macros and helpers to simplify codes.
> >   - Refactor config param parsing and remove config arguments that are never used.
> >   - Use generic struct pingroup and struct pinfunction to describe pin data.
> 
> Overall it looks not bad, thank you for doing this.
> Individual patches have been reviewed and commented accordingly.

Thank you for reviewing this patch. I will fix the rest in v2 soon.

Regards,
Chester

> 
> -- 
> With Best Regards,
> Andy Shevchenko
