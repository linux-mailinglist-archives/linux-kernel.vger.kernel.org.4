Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108DD69812E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBOQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBOQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:46:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E41F5E1;
        Wed, 15 Feb 2023 08:46:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqooHCVhUCLYEg+f+u8mKcDceniis0P1NOEEqcRiFUMwnMlv9bELcfNms5NdxyrSrOerVgf4psekwyGSqnuaxjr14zomNPBN8kjS+Wx5el4TSSvyDezRdtgvu+PhzjCnGwY3w6oK2PbelXOXfmfhHkE216cidbEpNhBzHs0C6N1gzsoeENJnC7VN7rJQ7sTdw3xbJkl0GxGZx9f/LTBPPIZDJcno3R8V6R/DEe+gOhQc8jYr99PITNLtLtUSq+OIBa8TrSnsUP+XaBorpY0IZBrqgy/T1/V89vLrQWL1UKi2XiP3p34dsjUCbpaXJ+ya3+KfcbHC+dcu4B6xVpfJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjfpWbDFn4+GxP3g5296w2yANxVMNwhuNQ2VupsFR4s=;
 b=fVWtlsIa3cKliiKPmQJS0WD6C3sAHERjgFw3e5K/WUXtF+DscXH0tqzBMf18pOl/NI38v+uwJS832A79n6cNBuywY9BMhMNb7SoccamjZ2gH26DLciLvvZCMWYvlhzxgpqXXZZbmTwC7wyFytT4Nn4PSLNUJKtBNhGDSWD7yoooxigHCtn/ijcVqBOM2RXYSgV9GbbwDMEqBrNtUxLSY4a507yNngwejv1dyay65bTCIi2UmSCUj0H6fW7BnLjnAkQmEzc0fGKd4e1u7b7TNrU12ucoyNivLVxkh0EtzPsN7OSixa55gUmF2SfnXvo9wWKeDjlJwlWotTnWK7+XuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjfpWbDFn4+GxP3g5296w2yANxVMNwhuNQ2VupsFR4s=;
 b=gIxHbxa3HVc9aAlP3Q9QodWSKVrBSY18YPKw7ZJKg1rS0LgQ4zT1l2ZrU2Zu8DMFuDcIbT5eI1tu0mGyUq1ZYv4kxQx9rPGPxUAY/Rdepe7yKzkc0VhIPr3Y2u35AbxaOVY1dKmuqkIxA82unfQNCRlKImyzKMcVVJxxA+MyE/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SA2PR10MB4746.namprd10.prod.outlook.com
 (2603:10b6:806:11c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 16:46:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 16:46:43 +0000
Date:   Wed, 15 Feb 2023 08:46:35 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <Y+0Ma9En4JLbR41t@COLIN-DESKTOP1.localdomain>
References: <20230209025525.148872-1-colin.foster@in-advantage.com>
 <20230209025525.148872-2-colin.foster@in-advantage.com>
 <20230209173534.GA539622-robh@kernel.org>
 <Y+yGYycS7rrBRBPN@atomide.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+yGYycS7rrBRBPN@atomide.com>
X-ClientProxiedBy: BYAPR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::48) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|SA2PR10MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e636f0-f857-45ab-1a51-08db0f7437ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpGcQgcKsBYQJqaLzCzIRJ/z4UghWpfGvsVzkf1z/ZbJAUKM/wc7Bly/qAYqrgJOpRYRdikcDzzuf/z6SoDORQX1MwJYG1IVp5aoc2Agk/NKgNh3Tx9j3Y1sHNqOp6aChzgjIEkEv/WMJJfOfjmv3CpKjjzjT1CNKYM9qUZlR9XV6ZAL8jmrzIe2xuu2lvDyKqHSpz2fctFD7xsOH9z9uYrWCjUfPWTOyldfT1q4+033RfSlN+hJk2OTsQf5HcdbnkI9EfR0Oyw2BKJMb6O4GtI1dAlL6KFHwJQhvhfJXMTcFmveK2ZG2v0rxGqDxLtvU72tEsXOvxzoJ3kUadhW6759TwKGcoBj3VdF0sFP3+sJWC+jlW5WVoJbb0OxJ6j6bERGoPwrt7wOPLfjoTE5ITuXky8kLB+M5FcuNJr4aTVjRFYT5Ly1+5qLQcdedCTxuwVD958FwW899CrFYzJW14UwWEf6/aqewSIIp4yUxTrUp+JJNfVlop+mrw9DYFo08WHJ/KU7b+gvku250Zd7as27tlLjxR1oX26xw1bb3MJbukuSBsUVSxqdS4df/4YqHKL2AYGB+AZCtI8xo+XzleQMsAazSqfxGhZo6VV2qCE/mwTigAea8nN+NwDkPEipCgduVA3ccZUfREO6H0HuNZZkJq7jLyZNGcqRpIHT3P6vSJfvVBWqdySHR6nUkIts
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(376002)(396003)(366004)(346002)(136003)(451199018)(8936002)(7416002)(41300700001)(44832011)(5660300002)(2906002)(6486002)(6916009)(66556008)(8676002)(66946007)(4326008)(66476007)(316002)(54906003)(478600001)(38100700002)(6506007)(26005)(9686003)(186003)(6512007)(6666004)(86362001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvfDP3gSDkC26/stam3UNuLFgZtJgeBOWKN0UkyaAuQ9fa3YYLmbeepqU571?=
 =?us-ascii?Q?vkOhGxcV3ZJE4ffLufuZyaTYFfYc26UN7DOlxvl5r/fAriaaQE9ewDclztvd?=
 =?us-ascii?Q?XIEErSg6m4gRGcJtbYEJiQNNWwtZB8jdxFNJomXefBKz1NmMJ9MTZTqBXy3a?=
 =?us-ascii?Q?F/URKdD2apwsrtJGo1IWJozqtX2BrGnsMxpFMaoyeoOMiXsejCeNvsaWAJ/r?=
 =?us-ascii?Q?n4X1uhd+csC5n6Q9AoAlAkAdbaTSSqafj1ussFteIAzhY0PNfK2aU9s1epCI?=
 =?us-ascii?Q?sAArl9dbYnwqqUq/aQtC6iiaLZVnTGyRQj9a33fmb13K8sX4h99ZvoSAYcwX?=
 =?us-ascii?Q?rc3fY/h3T0hCffpmSfMHL7dlX2pvchygp9sNGiUVlUQLSTW/Cd4LD612/SMs?=
 =?us-ascii?Q?v93THO+hwudPK6PwhRcbZAG0kfrBi2UlC7vjvGtxQq62y2MpVKVrQTxTehOh?=
 =?us-ascii?Q?1vVjK/n9I+LoedFVEQ89YwKJwibugap2wBcGPF06OgsmrJPEIwZKYHr8RT7Q?=
 =?us-ascii?Q?ne4XnBZNrqWqbYD6F5/xxuWw6fB3Vah/uKidgtAWiN7CVfcY2+rLcHqPbSXV?=
 =?us-ascii?Q?QQhdsFXRvUJorM9uYLeh6cBXa6+EGy1lBHirQdFCSZE49pZfgMj7HqqrWPya?=
 =?us-ascii?Q?hE0I/Xgfz+x8y2Qnh/rbIc5Kn1PCdeJQRgyKNEa0qQeK+5Xgc0xkItbasS2g?=
 =?us-ascii?Q?mCOtNNupE/wsvLjZlA3RaCsCnYZniNvIRaFrrz2co1lFmlJh1HfJNo6A0R8x?=
 =?us-ascii?Q?iwtTivLUJIp6Mx4FPub65ALOLlD6WCiPQHpqqm2+eq54wlXwKkv84PyuuGAW?=
 =?us-ascii?Q?mD/2C587Bg/VDI14npRSkhjEb/5UxiCEhEn7G2AUzOYrlhThtVlNgxxGDa0j?=
 =?us-ascii?Q?ISgJIJduA1hrnyB2cLQNCAro4pMrTmMvwWNqHsOTOhI+DnDpW9XAedQwNwfN?=
 =?us-ascii?Q?BsQaSE2X0ISnLzWkhd7JGUublBKFLtaHq6i4qcwFT0AAzJUqT4i6gaFzzRbv?=
 =?us-ascii?Q?SDNj9mwJnpyRtX0C8GNt+a+VIrWjsbdWMXC47cMduo4de/S77ydodDM3tkUE?=
 =?us-ascii?Q?TyZhCXgynX5rr9VY/VsbAwJHPtzuKjMLqmGW3WIyU/4DFSvPUfviELyBKE9p?=
 =?us-ascii?Q?RfBVXcACzABXjPMPF6J/Dq0lr3bCxzpPScg3PrNJanLKulECvvk01vRJQWi6?=
 =?us-ascii?Q?BQM1Pibg797rJIa3gQi5r4d6dvLZRM9XSZdDvjfiMBBpNDe/dNA+uP5SqPiO?=
 =?us-ascii?Q?y+YnITXV5dJUCtqQ7cYYq7AWcMsIVvqGx5RYi4Sbkz5KhtXSCKuy4ekeP7rk?=
 =?us-ascii?Q?ltL69uW/0vDlj2b6SpsMVIpo7d67uYRYAsdeqHYI3KVCp3hnD240HJULy7MU?=
 =?us-ascii?Q?zZWGipH3OjB8Y2DfmIEkAyxZnETfzjQksLKd64GU2rP3MKLc07P4pILi3hmz?=
 =?us-ascii?Q?Ws8UGpgFQzoeQ0HoqLW+Kx40a4yk3Qy5yc35jUwdP4qQ7pl28K2c2JwTgCR1?=
 =?us-ascii?Q?boNIRffNmH1ssJ9JhKnAeUv54OnNhk5si/m/uuxw0WQxlCFbpAuuTqj9jOfO?=
 =?us-ascii?Q?/QokK3nqd1SVX6xzJI2Lw5/MfCJYiUd4cPSBw5o08EJ8d0jIg6tOqcUSXDdf?=
 =?us-ascii?Q?qzrxGH9zFUZ5BG2ZGLq3Ze8=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e636f0-f857-45ab-1a51-08db0f7437ad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 16:46:43.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyJDfFkWQhW9iLDvJAe8cqNW7hX5QNqYamKfXz+KN2XIOiyC7vSJtkLgYsXZYAlM8lqs1nBxQz743ZA82eX3P8gxyZj4OQh7FIjHt2kEFM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4746
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Feb 15, 2023 at 09:14:43AM +0200, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [230209 19:35]:
> > On Wed, Feb 08, 2023 at 06:55:24PM -0800, Colin Foster wrote:
> > > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > @@ -131,6 +131,9 @@ Boards (incomplete list of examples):
> > >  - OMAP4 PandaBoard : Low cost community board
> > >    compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
> > >  
> > > +- OMAP4 PCM-959 : Commercial dev kit with PCM-049 SOM
> > > +  compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4430", "ti,omap4";
> 
> Do you have both "ti,omap4460" and "ti,omap4430" SoCs variants for
> these boards? If not just drop the SoC variant not in use. If you do have,
> please mention it in the commit message.

I don't, no. It might not be an issue anymore, but I remember there was
some reason I thought it had to be there. That was back when I was
struggling to get anything booting, so it might have been a false
positive.

I'll remove it, or at the very least explain why it needs to be there in
the next version.

> 
> > OMAP maintainers, if no one is going to convert all of omap.txt over to 
> > schema, can we at least start an empty schema and add to it instead of 
> > here...
> 
> That sounds like a good plan to me as it allows moving one device at a
> time.
> 
> Colin, care to add the initial yaml binding file with your board?

I'll give it a go. To be clear, this would be
Documentation/devicetree/bindings/arm/omap.yaml and it would
include my device? I'm taking
Documentation/devicetree/bindings/arm/sunxi.yaml as inspiration (for no
reason other than it was the first one that I came across that seemed to
solve this same issue)

> 
> Regards,
> 
> Tony
