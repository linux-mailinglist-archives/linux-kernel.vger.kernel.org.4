Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F856CD131
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjC2E0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2E0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:26:06 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52D19BA;
        Tue, 28 Mar 2023 21:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4rAJU+37EOnvW70pInvCYslY+Z204Zw+wkBU7fMZU2eUUWZSc5XvKCTbi1lH4M63dodJThmoQ2ADm0WzMK7TdsPRd2/csISFFqx0MtHNvIEi26abgLId4NPD1y1/BCllmDnizfY5ebofGwq33rup+2mDdpWUbiqrSG/Bvdk5JKedUYhCP7/17UhAJ4fNdllhiwnQ4ci9EMnO1jp/3B3SZP4uhDLoO9Jbyj5YQmSU4NrV2nz0RT4hfthghigKxoCc1I21i1NNT0Snsq8kV/92wAtp0W2+YGXEuv+kAPQQA0gy4sfc/3HZBlzvDlGrs67AoYGaNUNOUyiYn0wb56aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YwqySSqreJ8Zu8aTRjJjnVKN0dfM2L0s2RFHlAGqLU=;
 b=hjlvvZph6nmzVCM+3ruk6kwvzIqAFbARLdg3xLynp4q0OLEahcoBsvyVnTg4I05/MzEDSWL8c5SQnE3zqVQwMUHu8ScZ0BiHK8gkJlV7THZUQ2hSf66wkYwH8juhWTZseRQe5/JDx2Hi9ZKq/ARj48oHgiBkeR9Qx9v5fESWlBDyf2n7dRxwD4Rkok+SQgee9ftpUhWHfTXp8xXGpdWnYNgTnIxLp5wiDTYg9uzub3Z9v3J7u29GrUfpJ+6ADUY9pH2bH16a7kYxkEQbWfS4PoPRnwtBaOWymNDCFYbXl3ciWtfmy0qiQI1HE+AHXVSqp9C3ZWg/WASFW6JqizVOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YwqySSqreJ8Zu8aTRjJjnVKN0dfM2L0s2RFHlAGqLU=;
 b=lUPUgkO8d2noz8yzOogQA878BsEqgXCk24ZlazzPkmV7A+Qb2GbEv1KXRnD1Ok9men/XuvcjFEkCERfblJV5PZqxG4ygslnIM1bOdGNH8Sw1h0vUj/Vq+bWLWcVRW9k4YlSw8QU5zZWZpPFgQEm/WSy2ckNbg5TcpGtDitTk/vkFMRU4I4Gylib64sMxXEyD2BkTYLV3PhAeB0MvUWP1sbXWz4XIbs5/QFr0HWLQqBYB3lXEQatj9gfZu3US41l2oQ4NGfbJQSTZiUwWX98IpBpjAuRqkunWNV6DyFhwGPBd7J1JnXWMj/w453DGX2WrqV26MTZjWe7UojQrjcyO2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Wed, 29 Mar
 2023 04:26:02 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 04:26:01 +0000
Date:   Wed, 29 Mar 2023 12:25:54 +0800
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v5 5/5] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
Message-ID: <ZCO90vGIx+Z+J9gz@linux-8mug>
References: <20230327062754.3326-1-clin@suse.com>
 <20230327062754.3326-6-clin@suse.com>
 <CAHp75Vf_k2ZDoyHUVbD_e4droAwxVqu7HCwNrPd=X_su-c8LjQ@mail.gmail.com>
 <CACRpkda097RwHCZu+_WAJRP=MGo7g4j++WJ57P=H7xKa9j439g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda097RwHCZu+_WAJRP=MGo7g4j++WJ57P=H7xKa9j439g@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: a4427c0c-3d74-4671-d257-08db300db411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm4dsRvTFgV/QX4LpmenblESJ/RW9z0VYIbG44hq4SXErhUkQ8kEZeBcJ/4NC+9P9uB62Kbw4FYMSqBr1jW7ACFruS2lgxzZMyEEHb4k9bw9N+scIIcD4Nu9Udq89S/kSs26n1btPKe6o9ymDAgkDnzH/3nSUvpIL42uC6Gls/c8aByBDD7zrsshEVHd42xJMtcERlq1Og5Ts/MVhJVsE48ki8an+AUiFcH+SUR5jVdmROFrdsKRP8vHX2Y5Vp+uXmaXnh1VSOg3ry7cTjQCJ04SRdnWff+gB/5XweurJwd/FZ+OfM7PDFIryt4vDGvzbr3wpUF55Osfk9mZloJlvVZ254UQA9ZLOm9f7OFjw83MFT320LcNbXA2Cjz9cLP4tkli5268unqw7BeMHyHUDMqqORQVDip4RGpA93R/WO0rfnV5LDfcEcIydVwAANtPJilNeapoMHUkg2FC0yj7mhRukx3OKtUhebu5HKnBSWexbiufkh6NY8XuFRuiVFBGyQFHsspu4Xoo2qKRPAnbyr8z4pZwtos9s1kRSKdCCIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39850400004)(396003)(136003)(366004)(346002)(451199021)(33716001)(86362001)(2906002)(478600001)(966005)(26005)(107886003)(6666004)(6506007)(6486002)(9686003)(83380400001)(6512007)(66946007)(8676002)(6916009)(4326008)(66556008)(316002)(54906003)(66476007)(53546011)(186003)(5660300002)(8936002)(7416002)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2dtbjdLZUl1VE1qRUJQZ1hSdFR0S2d2S0Z6bmU4VFNEbTY2NWdmdlVNcDZ5?=
 =?utf-8?B?RkhHYTFqMi9aeTg4ZWkvUUE4aUVWeVN2UEFJMWJtcGJKWGZNd2NlRkRMUFZS?=
 =?utf-8?B?MHVjdkNNK1llcCtHbytIU0NJUnZGNjJoZ2lNclEzNVZIN0FobUhOeFAvZTZO?=
 =?utf-8?B?TTFsRG1WUktNSFMzaS9UcHJ0WURrV3pveE1pUENwK0hnb3ozeHQ0dUZIMk9y?=
 =?utf-8?B?NS9yZTlJN1pMdCtETCtoRVFIM0VYWitUNnNHQzdwNTJkcWYzOWRZSmNUenJX?=
 =?utf-8?B?QXNoWko3QzRqRzNmVTFqK3FlOGRyTW9STnJubi9YeEFIcFdEWVNqaklxeWs1?=
 =?utf-8?B?WW1ub3FNWlAyZHEzWVNPNWg3ZDkvQ2F4VHVNdEVZR0R2S0lZMjR4MlhiWkpq?=
 =?utf-8?B?ZlJVamhqeVN1NXVZRXpPeWdCNVYydldDb2hmQlR0UVVkZVY3WUZWRTFaVFhJ?=
 =?utf-8?B?SGtpS1N6UTR3Y1FmYkpoSXdFbFFnaCtRWDB3VkY5RDNCWDJteG90VHlPMHlo?=
 =?utf-8?B?dldYTVNGQlhyS1lwSysrYTVLRnRuYXlLcE1RL0tDOWRjRWRyOHZ1MUFsK1hX?=
 =?utf-8?B?M1VaL05naklqSWdzMklOZFFaNWZuRmoyRVE1NXNoWVBOcFQzK3lLL2MvcjVD?=
 =?utf-8?B?MUN2eG1ETmR2OXlJU3BxZFVTS2hQbzJJakhjYlh1OXhsR3E5MUxpN3h4MC9G?=
 =?utf-8?B?czF6M3p5dUNLR3p1R2RjcXROTWJ0Zk1rdGJPdGVZM1VaY1hnQ2dTV2NVbHM3?=
 =?utf-8?B?TW5ZRWRZc0tKSU1vcUpMNVVsU3dHQUl2S2JWYVBWMEZzMTdZOU9PRXlpajlz?=
 =?utf-8?B?ZG9VVUZIZUJYNUUzSXIzck9zUms4blhpTUxTUUxPS2UrczI2UU1BZXFseVVy?=
 =?utf-8?B?MFFlMzFpSzluazJ2WlZYd04vWlg1UmpqZU1GL2ZIOUhDSklRMmpPbU5wNDZF?=
 =?utf-8?B?clZ6QVZnaWcvTlQxcjJwZWF2S0NGcUlkdmQ1RnhlcFVvbnBlcXJuazRiUHF4?=
 =?utf-8?B?c0krRmgrY2txMzAxdlMrRzF3YW81WWFLSGVRS2dOd1BYTVNueWpCSGc5U2tk?=
 =?utf-8?B?OGg1Z0liTUJrNzBySG9iQWorejBzS1JSNVZ3a05LYTJldk45bXZjeUc0ajFh?=
 =?utf-8?B?ZXU3MTBJY3I4V2VYSWRMYkh2YUZ6WkUrNngzRVR2VHE4S1daTnlMazlBak95?=
 =?utf-8?B?WGtmajZqZ1RDM1FTek81bkc2bGZRWENiblZlZmtrOXB0elhncUdnUGZpQitR?=
 =?utf-8?B?aVhaeTZOREw3YjZ2OG1iek1vWW5nRmhmWkN6WWc4ZHV6QUhIYW5DaGR0WVNM?=
 =?utf-8?B?dnB6UjlOS3Jsb2tyYmxyN09VOHhuTytJUEx3bnFCd090ZUtpUWs2YUF5eXNN?=
 =?utf-8?B?aWRlTnJTWGZpaWVianFwSEh2Vnl6ODQ1SDE2TnJGUk9YMXhCWHZWZUpxYlk2?=
 =?utf-8?B?ODMwdmprN3J1RW9sYnlaTGk3Z2NvTDRKM0hQMHIxNUlXV2xBbGQyQithUlg4?=
 =?utf-8?B?Z3lPSGFwOFB3TVB2OEN4UGZsSUNuamdGVElGMWhsTXZjSGZPb0YwY0RQdGZ4?=
 =?utf-8?B?RWZHQURlMDhzVGt2Ni8rVkVETkt5R09MdkdHNVBtNnVTTzhiMnllazQwZHdO?=
 =?utf-8?B?T3NMMUNpM3dwMHdmU1hJTC9TNkR2TFNWdGNxV0RuRUV5TlAzUXFGV2N4WlpO?=
 =?utf-8?B?a0tXZXcxdHBVOHNiSXpFOEV0c3c4aUxaZ0pyZnA1T2txM0ZLVUliUzIyVFRW?=
 =?utf-8?B?V01BdXBwbUc2MHRZU2ppaEtPVWRYUGRxYnR3bCtoU0RLRWFlN1FTc1V0Wngw?=
 =?utf-8?B?cDJ4bHhGanhSY1dWQVdvYUFZRDdOeFJ1OUJHM2I0ay9JcHB3YlBRQ2JINWdG?=
 =?utf-8?B?SEFuZUFYRFRjZnFHY2c0dkU2K0hYbXd5VXhnNjlUZUROOTBoMzFIQlN6Vm55?=
 =?utf-8?B?UEpYc3hHZVlqUER4aFI1NlJ2UUNrS3F1RHZqZC9QSU1wbHB2VmR5aDdoZUYw?=
 =?utf-8?B?eFZ4T1h5bnlHUThCelJ5eTlkOVNuenRzTWFqc1lYVjhDKzF4MGFhRXhpR1NK?=
 =?utf-8?B?ZTFXWlpyQmlIdW1lMGtSd09DMTE3by9mOStZd0dMY2haQXJaZjZETzdveDdW?=
 =?utf-8?Q?aFlk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4427c0c-3d74-4671-d257-08db300db411
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 04:26:01.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mplx9UfRSIP/tlK69+oHBI9Zjp0FTA0gT83QsPYXviymuqsWhiMm4S+RtlvooVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Andy,

On Mon, Mar 27, 2023 at 11:39:18PM +0200, Linus Walleij wrote:
> On Mon, Mar 27, 2023 at 1:59 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 27, 2023 at 9:28 AM Chester Lin <clin@suse.com> wrote:
> > >
> > > The .data field in struct of_device_id is used as a const member so it's
> > > inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
> > > because some members in s32_pinctrl_soc_info need to be filled by
> > > pinctrl-s32cc at runtime.
> > >
> > > For this reason, struct s32_pinctrl_soc_info must be allocated in
> > > pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
> > > to represent const .data in of_device_id. To combine these two structures,
> > > a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.
> > >
> > > Besides, use of_device_get_match_data() instead of of_match_device() since
> > > the driver only needs to retrieve the .data from of_device_id.
> >
> > ...
> >
> > > -static struct s32_pinctrl_soc_info s32_pinctrl_info = {
> > > +static struct s32_pinctrl_soc_data s32_pinctrl_data = {
> >
> > I'm wondering why it's not const.
> >
> > But don't resend too quickly, let's wait for Linus to comment on this
> > and other stuff. It might be that he can amend this when applying.
> 
> I don't dare to add const here given the compiler warnings it
> can easily spawn.
> 
> Chester can you investigate if these can be static const?
> 
> You would only need to resend this patch 5/5 because I applied
> all the others to lower your patch stack.
> 
> Thanks for fixing!
> Yours,
> Linus Walleij

Thanks for reviewing this patch and Andy's suggestion looks good to me. The
s32_pinctrl_data should be const as well since the 'data' pointer in
of_device_id is declared as const.

Anyway, I have resent a revised 5/5 under the same mail thread:
https://lore.kernel.org/all/20230329041630.8011-1-clin@suse.com/T/#u

It can be compiled by the following two gcc versions without a warning on
drivers/pinctrl/nxp

- aarch64-native:
  - gcc version 7.5.0 (SUSE Linux)  <aarch64-native>

- cross-compilation on x86-64
  - gcc version 13.0.1 20230127 (experimental) [revision ca8fb0096713a8477614ef874f16ba5bf16c48bc] (SUSE Linux)

Thanks!

Regards,
Chester
