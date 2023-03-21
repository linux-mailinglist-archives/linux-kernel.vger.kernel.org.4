Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22386C298D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCUFD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCUFCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:02:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A1936473;
        Mon, 20 Mar 2023 22:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuNujZizJFpi4Ed2mN06es6UqO+2m+ZR+r7cViXkrRyFSiJgQoV9BUU8Qk/nZz3s9V/ytTUufEKiXOI+0yTvHzI18pseE17BvqTbRnOIseruxmlWWe0rgMP8qsTr1+Lce3O9tVYIwkTnhwBQhHPLK4kS9b0ck4mWIPb/tXepFmZPAZVCZ1FM0ARxJYO3xVJq5yBpeJdUI/x2Spiw+vOpSm5F2w+scIzwewplDOLoD5s0ulzFa3NU6tfuY71D8m0Jl6e9VUMNkCl7EdLOE1dgHdz+m7fmVIuVjx+DGGE7cCRdAYCVCbefZmmtqqgfyXrxdc03T6VV0rYQUcjNRTv0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0WcVAtnh6FN/Wl65r684DFwhHpzUCGGhsQMZWaHszg=;
 b=f1SvrQhyaA5rb0KHBcD75mNVV7hVCAnd9xHYi0KmrWrnG+y59a5bm5wtuLnBRJ9I7qywClrFmoTHw+PNAzgQQU1mleX7ZeD6hdwDN6wOBUtTunHbJC7Dy2SfbRE8haGiZGJ7xG9vktbCLVNmLpw8HJosZcZIRJoNThLZK2zMhXvbTUva6v/UuxgZpymvnnzUVA2ucZEP+hBGEj133diqfIhG7G1TIMFvS0MlWr/u3Re11Du2A2TeZOmQongcbdzu6hzO3yAxR7j9qFGHi/scGuNmSEqNko6HK8A+EAU+7oeAoRkAjvMb4IiY2Fd1hVREaUaSiZ4EFr4IFvML0Ug5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0WcVAtnh6FN/Wl65r684DFwhHpzUCGGhsQMZWaHszg=;
 b=M9LSxn7VNNALsZRSUKtrWtiq+BcuNBcRiCOJ2M7BMworHHB/hPrfeQDjulyuRj4oObBnQo27TZmQ3zh32kX+nZq7gN/N7iARlGYA25KovVaRMlockGJu4Q5tUfiacV+1rXatrEVg23oPagJRVH/9VCFH10bKnhQFxGgUSgEaHqsA57l6xOS25UMF/jSJTmR1P44ZAv4VUf7lAbMMMctvkHsgKUmIzBn89kYjp2tp3RdzCzkxkoY3CqhgUzz26bk/afR8JGErmR2jL22V7SeNK9FFuwFXcA9syDxNZEV+cD0HI66YlnY83gyWPgp20joA+LB/zkngZ/m6+7UhFrC3Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DUZPR04MB10013.eurprd04.prod.outlook.com (2603:10a6:10:4d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:01:33 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:01:32 +0000
Date:   Tue, 21 Mar 2023 13:01:15 +0800
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
Subject: Re: [PATCH v2 3/4] pinctrl: s32cc: refactor pin config parsing
Message-ID: <ZBk6G61RUbFPIV3G@linux-8mug>
References: <20230320163823.886-1-clin@suse.com>
 <20230320163823.886-4-clin@suse.com>
 <CAHp75Ve325yfz1P4=vYndUOhV-VkqNCWVEObm1RURbKHgcLKrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve325yfz1P4=vYndUOhV-VkqNCWVEObm1RURbKHgcLKrw@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DUZPR04MB10013:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b4a162-d957-4911-50bd-08db29c956bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gixqHaDNe7iGF+Nyoouaqlk1BP4MD0owyl9fzXSw2YHNx0AT2ZJMIz/uAZT38mBvoe4WFUrMM8upZY+Zl/xKmkqPjwwTLeijUcYG7Ks7XKj76eS7D54Iou44EnZGupIuJOrdH2Gee9j3T5zuaybtZELMlsWzc/AVh4JVuYGjOZbA3fR5hc8jCYVPWQdV+UJz1mVBFnU00KSjB1heM9GB6dkvcSCUhXYVW9QE4EAPeHYYiH/qSHM2nh9pL/tBVnRuKRSTl/zTDY4vwey/3rFjvjgM9jwV/wvjbV5j5xFotSDXCZShGrxWxNXVLTqnO4OyP9Jj7YlH5xwazZBTcubL1yaHpryHxFnoOr5dR1M8jBAZZCCbzXMuq1OB8lxpucKCyegPhyaQLpzWxIvTf/FSdJ933/g8BH7fkNWCEDAF7Sg5hkp993Q3qtovDSQ2rfgOVmENO9kYSzm2Sf5e72RmZP9vGOquS+nyjzYi1QEQRpIqxX2sMxfJ9xtU2FiIcCb6LBrNahxLyMGWDJqAn5askW5OfoDyqAJTAXZgkLgY9aRo+YIefI9ZZlTtkBaOaR7WQT9wJu68Vq9H2F9Xx1YX2imHE6S0vgQ2K6Y2Dw6mYsJ1WO4gNWKDFQcc5nLqDYliiF0SNlP6Ugigt2cHJYTbwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199018)(33716001)(107886003)(478600001)(83380400001)(316002)(6486002)(6512007)(54906003)(186003)(6666004)(53546011)(26005)(7416002)(6506007)(9686003)(8936002)(38100700002)(86362001)(2906002)(66946007)(5660300002)(6916009)(66556008)(66476007)(4326008)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1ZwbXVOUm8xc1IrNENGUjhWS2RnNTVuZUhVdldJbjB6WllTZGQ4a0JUNWsv?=
 =?utf-8?B?YzJnaXhWRkJlZWp5VThXMVdhMWtzQzlkNFd2N2FBSUptRmtSQmtLaU1lN3Mr?=
 =?utf-8?B?ek5XYXc1VElYQXRYdWZDa1c5VXpncjVFeEI2UGZraURUbUpBbEtMaUp1MHVh?=
 =?utf-8?B?eFFET2x0bDZUNFlFN2NjbFNjNjVTV21Ha2hsVzIxWFZnVEFSRjRvWVQ5MC9P?=
 =?utf-8?B?UTZKN0lRbWtabGxIeWplK1JDeUVZV2FCOG5jZEVhaDVIUUVTaTlvV3JYU2k0?=
 =?utf-8?B?aVFDRVEvYTJkdnozekdlNDFJaWZPN2s4YkxMU3FObitubURZM3lkQjU5NFpS?=
 =?utf-8?B?eU43WVRtR1c0N0twM0V5VFpCM2Z3dzF0TUMxNWo3MTZ4ZTBjbTd3VVZnRjR1?=
 =?utf-8?B?QjFJdWJhVGo2ZkEyY0lWb052a0I5U3hoeFd5VVVMVFMvY1JLRTg2ek1sclV1?=
 =?utf-8?B?S2FOR0ZTei9KbFRyWmhjNjFUdmlDN1RvT0dRTUYvK3JnL3QzQ3g5NzZvVjBk?=
 =?utf-8?B?aFNUMDJVYXU4bTFGdHdBZmRaZXRDZVFIM3p0UXhkWnY0Ui9kS01yVW80cTZN?=
 =?utf-8?B?YmxBYjU0clNiYmFjcVNJTTdyWWhweDFNS2JwTExCT3JGZlpSdXhvMW5OWHhM?=
 =?utf-8?B?eGNlem5xM1Q5dnlveG5ZL1FqQ241Wm45QnNwTkJtTG92SmVQZGd6b2xXQm9y?=
 =?utf-8?B?OXVyazBJRjRTeXZFdDU5NmVvd29MNUN5WU0yN3Q1d2hxQzZVdnJBeUtzeEpX?=
 =?utf-8?B?TjdJM3BROU1TSEtub3RtWkhQdTZkeVJyU1lTVVgzWDdFbEM0dnIrT0ViN3lG?=
 =?utf-8?B?c2ttUTdQcWZwbWRELzlhSWlUbC8zSkpOWk9yRHJQcGJaaEw2QnBpd0NISWZW?=
 =?utf-8?B?dXRsZ3lKeEdsbWpHbUU5K05SUEM0ZUxnaldDRzdXNkdNbGlxYzRuQTRFMS9R?=
 =?utf-8?B?YlQvZDR4b01jTFozVjM1UnBsUDh4SjU2NTNDZno1c1J6V0VwcWlzOS9meXNm?=
 =?utf-8?B?WlpnUkdLdmdIWWN6QjlEOXZZdTFZYndBMzd3RWFFeUhJS1hNRHgxMHVzWm1P?=
 =?utf-8?B?OXBpd1JwUGlCd2lZUVh0RDVQeXB4ZzdGYkpDUzFubVIzeEpuSGhkZHRYMVFt?=
 =?utf-8?B?ZDJNQTd5dWxIcHhRd1QyTDlHd2lxQm1JSGJiQitzUDU5TEowNWl1cGR3Mkh0?=
 =?utf-8?B?UGZDc1lHWlJyTWxYaGNmQnNpQU1ReHRQQ3RxdmVOeVZaMU9HdlVoUE1wNUp3?=
 =?utf-8?B?czJ0V3h6TVBnVm5GQmVseGZ5SnJiZHdQaStuVTFjeHlHZzVSL2hYRExWcENQ?=
 =?utf-8?B?a0JaRDB5UDUrUjhRajVrb0NWZ0NkR3J6Y0tiTmhWdU91dERDMWtFbjJQNmMr?=
 =?utf-8?B?S2UrbW8yTFJ4Mk9vcTE5YytveVU3SFZScGt3SHJqZnlWd0pXSmNuQVZvNHJq?=
 =?utf-8?B?cUU0MzQrZkxZejgxd3hPZTlvSFlwUU1tam5xOHFQSk15TERrVytmQm9VYjhx?=
 =?utf-8?B?RkVsMkNOZ3dRV2k2Q05qSDBlMmpmeHFydjIxNnBtMDBYYWNxRHJmbUdzSjcx?=
 =?utf-8?B?SHZuVWxEZ0tIdTR2bndqL0tyUmFNOWRyVjFoV3AvVUI1cHFnVlE1TE9uTEdS?=
 =?utf-8?B?czJmb0RNZW4zOEdtRm9vUFNJSWI5V3FRSUtUQkExZG1uNWZLeFVwK2U4aGhB?=
 =?utf-8?B?eitzVncxamFBcFI2TlB6eDlJNE9jK0hldDhIME1kL0kyMFM3S2RLZWFadVEv?=
 =?utf-8?B?bHZaSmJNVDJxMURnZ2RGQW9qT2UvaXpzd01IODJjZlYrTjIwdUx0WjZ3SkZJ?=
 =?utf-8?B?SmVaeWlEK0lINkNNNWJjSDU4d1EwTFVvdzViNFN1bjRvZGVXTThsWVFrY0JI?=
 =?utf-8?B?OU1sSFpuMEpxai8wQ3FDN3pkZG1DK3hoSVJGN2IweFUzazZqaW1PTzNLcHZr?=
 =?utf-8?B?V2M5dDhSLytUeHh6ZDdlL0k2aTdPazFYTXNIVTZmcHlXSUdJdWdXMUlFaXIr?=
 =?utf-8?B?Y3k1MVpFU1FHQXFWS29IUzlDdzdDWWVOblU3RC9xemNLWmY3ZDFmaGErcWt5?=
 =?utf-8?B?ZDZoZ3NtM21STnlqNmtiV0d1MzFaQUtDQm52YkE0N3l6YWI3NitidGo4WU1V?=
 =?utf-8?Q?iMzA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b4a162-d957-4911-50bd-08db29c956bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:01:32.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4cW9C3qIUe+I8U0QBM6Rh/1bAUvUFvNFhYVMb9pT1cMR+wZJQpRHM70pR8Q3jGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:06:53PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 20, 2023 at 6:39 PM Chester Lin <clin@suse.com> wrote:
> >
> > Move common codes into smaller inline functions and remove some argument
> > handlings that are not actually used by either S32 MSCR register or generic
> > config params.
> 
> ...
> 
> >         case PIN_CONFIG_OUTPUT_ENABLE:
> > -               if (arg)
> > -                       *config |= S32_MSCR_OBE;
> > -               else
> > -                       *config &= ~S32_MSCR_OBE;
> > +               *config |= S32_MSCR_OBE;
> >                 *mask |= S32_MSCR_OBE;
> >                 break;
> >         case PIN_CONFIG_INPUT_ENABLE:
> > -               if (arg)
> > -                       *config |= S32_MSCR_IBE;
> > -               else
> > -                       *config &= ~S32_MSCR_IBE;
> > +               *config |= S32_MSCR_IBE;
> >                 *mask |= S32_MSCR_IBE;
> >                 break;
> 
> Isn't it a regression here?
> Otherwise needs an explicit explanation in the commit message on
> what's going on here and why it's not a regression.

Oops, it's wrong implementation. The argument checks of OUTPUT_EN and INPUT_EN
shouldn't be dropped. Thanks for the reminder and I will fix it.

Regards,
Chester

> 
> ...
> 
> >         case PIN_CONFIG_BIAS_DISABLE:
> > -               *config &= ~(S32_MSCR_PUS | S32_MSCR_PUE);
> > -               *mask |= S32_MSCR_PUS | S32_MSCR_PUE;
> > +               s32_pin_set_pull(param, mask, config);
> >                 break;
> 
> This now can be unified with PU and PD cases above.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
