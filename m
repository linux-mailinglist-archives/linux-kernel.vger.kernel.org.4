Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB7712F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbjEZV6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbjEZV5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:57:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09FEE4D;
        Fri, 26 May 2023 14:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKfzmdl+P4joPKNvAkg5lirKbidiXPHxlZKuXg+nG+ovxWYM0Z5pOZ5DRAbq/3JcCni+PzsbPi0rI9/svTAJUpmlTW7PBFX8BPOczNr3ikIau9iBqWhdei+/OBpKoctBv9h7fvsqhR0knUZ2cA+jCdmy0t2CH4E6qWzLIQ4SmuXKSh9pX7SqnQzE1jqAzbqJaUdFP8XHj2cd5KPhynjJbPUWz6O6DK4cDj+uqJR0IEsYdPPl9JJtSzMZj3bOyFxNbB4q2JPAXnFlKnJVA5NX0zmbt4OT9Ia55me9+k6dxRA2dwfVy7ZK6IGVDK8R/ZZY8mXEbLQ8Bi3oBHw5IX/DRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iElHjRng+7q+OIRI8IEFX99mjTqQLti7XlIrWLW9cwY=;
 b=ZC12aqyu0k0lTAfUEKSSYgIJOEGBsfWiwOliH3ZX+BwDEKioybTbiLoP3/ngotLV4HR9SfFZ+gNt0sJerRlu2HWXN3+bzcbX5UOrTDnXEbiSjaV3wPolST4wNnb5ydJYs8Pf+88KupZEjsJh38WjVAzbTxvSIkktWme0w/lHme/c9eeIxciiuqYWsrJ05HwiaUj9qT6suEbBH0T/kUt7n64FRbnJwC3AqW4ykHWI+bd/bNKhaM8cqBjkB3q+bjxgvMaOVXSaHBeG1CovwB3GOv+IEcBX653CNkYhlXwzBIQiDPKbZCED8IM/N6vhgoo13S8YV9CWIEAavl65LGMR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iElHjRng+7q+OIRI8IEFX99mjTqQLti7XlIrWLW9cwY=;
 b=gx2hhCApk2v+e+X7EcP3n241vfJW8EtiFEeEhu8IlDUtXpiEfkzI93xm5fUTWotqfbHRmiAKjC6K8RJ81wkpR4uiKeYU6FQ+FYYGY+CQ4ivaACB2K9CZ4lHf7WjvT7tKH6w6fsjBbXM4MSXzwprZNlM2CSVGB3ElGM+OKgctyFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6700.namprd08.prod.outlook.com
 (2603:10b6:806:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 21:55:25 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::c696:d0df:10ac:8071]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::c696:d0df:10ac:8071%3]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 21:55:25 +0000
Date:   Fri, 26 May 2023 16:55:18 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fred Treven <Fred.Treven@cirrus.com>
Cc:     Ben Bright <Ben.Bright@cirrus.com>,
        James Ogletree <James.Ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>
Subject: Re: [PATCH RFC 5/5] mfd: cs40l26: Add CODEC driver component
Message-ID: <ZHEqxraGB2hZgh1b@nixie71>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
 <ZHEL30a/YEia7kjr@nixie71>
 <F6FA6CFA-BFC5-47DA-83D1-6330E66195F5@cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F6FA6CFA-BFC5-47DA-83D1-6330E66195F5@cirrus.com>
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7b1354-e936-4b2d-7f96-08db5e33e8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+WdGvJMQaghR3zZzNIvBD0WcTQjhBDnw5/9d6o21wjVS3NBtp/ohlzrwFnS5C0jHjdE3cqUHPGNB4zXawGAwQLU1hZV6tEOx65n0uP1JXZvIRQg0S92rjGokZuBKClsym8ssvHalpcOuc3ReyWo9b1lkyoFoTzmI/IVcPQgmoqa6D2fCVseIPAmn6mDJrtvtCF3PlKgA4n/I5DbOMKJiVTXFoX4HHE1WtNEjEDTgUO9sX7fA+L6k4i3HWLwvZ0YZjFBre734nbnSC3eSzk+Ed3aCEzyG0JnnjyMdmCzuKLYutNjs6LnfVr5GRr/TxmXlTAa9KdtPzHcHpJXRNmfsuFhbILQF3N4HIktmH2BI97C6z/WW5WL4KYVa/xjKsYv6ZdQTSmf66z7Oe9Kws1CWl6OgaH4S5o0WlHoRlmSDjSMK/Xi7Q7q6zNoT2xUGacZmfjW++wO7Nazy9hyNeosMmN9YQB0wyUpqJ7xdBvg6cRZRxy1fymSnl+O21hz0i1WZlyKdr5uGofLTgZMAo6sYJLgK5J0DtKJ3xNxFjofwff1FhFTgWUxGv/4kuqcNxxH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(376002)(396003)(366004)(39830400003)(451199021)(54906003)(478600001)(8676002)(66946007)(8936002)(66476007)(5660300002)(7416002)(2906002)(33716001)(86362001)(6916009)(316002)(4326008)(66556008)(38100700002)(41300700001)(6506007)(53546011)(26005)(6512007)(186003)(9686003)(83380400001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9RaGs3bHV0MWE3RGxMY3F5Ym4yM2graEZNOGgrTE5GMEphUWRiRW8rREx5?=
 =?utf-8?B?T3g4MGxYWllzbkRtc0V3M2N5a3lkUWNTN3owbi9GNzNTeUEwNVJkT20rTGdR?=
 =?utf-8?B?RVhuVzg4Z3RYZzc5bVhzSHRXaUgzSUd6Z1pXTXRHYkVLZEZhVkVwbnhVVUhs?=
 =?utf-8?B?czEwWDdoWFhQaDJmcWpJZGhNWXU1UUp0REJ5MmhGRjdCSXg4RDZ1bkNHVGE0?=
 =?utf-8?B?cnJsNkNGeHN1SEtOaTJBeXIzK1JDYWZEcnl0by83L0ZrTGpGd1JlL0RXY1J6?=
 =?utf-8?B?bytTOGhWdmNPKzlYSy93N2JEaEtSb1RRanZyTzRXQ09pVkpwTHJpVnVvLzVI?=
 =?utf-8?B?VUI5bkQ4WjJyWWVlaU5YNFIrbmxsUmcvdEJMemJsaUM5dEpuRnVLQjUrMDNw?=
 =?utf-8?B?SnRLUjYzd2VHcVU5b2hXaXJxc01CeDd6R3pnYUI0RXN6T2tSY3k4ZkdDZDZQ?=
 =?utf-8?B?UkUrZ0UycCs4YlNQMGxiSGZXQ1JFTDRjd0tscWRjQUN1SU9HSGlER25lbWE4?=
 =?utf-8?B?UFRvRGRkVzdtKzdKRHBQV2VZcjQ2M0ZMOUQreisyUFNnUGhwTlFpK1B6Um8w?=
 =?utf-8?B?UGYwT0s4bDN3aVNqbDBFeUZ2THcwUFEvNERHbVYzT29aYWFVeHdPVXoxWmRH?=
 =?utf-8?B?bEZwWlpHZTBuWjVnWU56V1hYK0pqcjV6dXE2bVFxRTJRdlJkWDY1bjN1Z1hD?=
 =?utf-8?B?M1FNbTlINTNPU2NDMUZ6WWxlMWlKNERPak1PWE9CM2JDYXUxeGhJU0JQaDJz?=
 =?utf-8?B?NHdNSWh4bzQ2aHBvWGZlaWt0U2VyQ01OT2xTbmpFcHBXeXpEUkZsOVhGa2Iz?=
 =?utf-8?B?SmZGYk9OT3VaN0Y4WEJTM2pCMWZjOGVYUWZaaE1wYk43WnY1UnExbUJSL3Vt?=
 =?utf-8?B?UVduT3FlM1JENC9sbFFFZDVQYWRGWWswQ1Q4Q3NKVjFDVitKazk1TGhGdUR3?=
 =?utf-8?B?YVdNaVMvNnpqUTIxOFc3OFcvSy9DZ1Z3dERrNHo4MEVKTTlwMFdTNXdKM05I?=
 =?utf-8?B?KzdMaXNlemU2eGtmTmo0c2FaaW9pcEdTT21waElsZTBuRkVyd3l0Y1VJenZ4?=
 =?utf-8?B?Vzh4ZTk1MisvdWJYSEdZQXJHYzNjcHFUZEJRUkJSTVFFQTdneWtlYTdIUnI1?=
 =?utf-8?B?TjRuczFBWmMyanZvUVVQMzlCdVZhUnNuWmdRRTl6R2czMmRjU1RCdUZlVjhw?=
 =?utf-8?B?aERFN2lpQ0hxWGg1Rjh1QzU1Ti9TWkVOK1R2Q1g0MUJqWkx4VlVWUVVsZ3lK?=
 =?utf-8?B?MDFwbTZTbC8wNmNwclliSXh0ODBIU1pEQlVWZVV6V1BWL05MRDBNUFN6eENj?=
 =?utf-8?B?UnJpRjI0RWxmYW5mZEcxTWJzODlTSU1OTld4SUFBTWdKL3pUR25vcUR5Y1dW?=
 =?utf-8?B?SStoS0JqQ3kyZ3FKZWhNNUl3d1JIdXhmcml6enJ6YWJnbEZrTmpySkYxbkp0?=
 =?utf-8?B?eVNDUHRWUXVua0l5dXhZdzJBRysrTW41bWJPb0ZJMVZvTFFUWXRHKzd0RVZh?=
 =?utf-8?B?d0NhMnIyOGF4c2Y3V25hTDREWEE2TmU2VFpUNHdVZEFHUmFISm5KazVwazBZ?=
 =?utf-8?B?VDZtL2RsdUNqb2ZNUGJ5cDlOSUlLTDBMVldYM0trOExaVmt1bzEwYk00TFZV?=
 =?utf-8?B?Z0EwUENkKzNyeitvczJzQ1k5eGVZOFBYSTRUZzF5TXNVSHpCdEhvT1RvNktQ?=
 =?utf-8?B?M2dha3NoVGk2ZmMvd1IzVUExKzdOZGZWb2paRkNxNlNvbDNsQVZpZkdrczdh?=
 =?utf-8?B?U21EcmlVNDY3QndrWEtnR1lscGZLTEs2T0RYcFd0L1NGRVdadFU2bXZuMEoy?=
 =?utf-8?B?dXVZNVZDWlp3d2JtMjJpbFVycjFLREdnNnRYQXBGTXo4VXFXNmt1UUFiYTdJ?=
 =?utf-8?B?NUlvcDR2d2VOWi9neVRrT21Ddi9VdVdxRVhxeS8xZlpPZXhDZ3grSWFrdEkv?=
 =?utf-8?B?b3l4eWZDZmRldkkwNEJBb3Z0SDhJcmFheXF2NnRLM0ZrdnRFREdRVUhpY3ZK?=
 =?utf-8?B?UWFxZTU0bkNCbnlLaXVwZWdLZGM0NS9lNlY4cnFwamhNZWN2aENmMFcxVFRO?=
 =?utf-8?B?bktZTzgxcWI5QlMzSU84ellKK0J0blZPY0ZXM2ZGT1VZUGtlNFczSmhidy9M?=
 =?utf-8?Q?C1tUFb2ZO2v5O1dY9p1p7P2JQ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7b1354-e936-4b2d-7f96-08db5e33e8ec
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 21:55:25.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YATfJIJSH+9EF+6GuzDh+gQ4vxXt5h6g7s/M5sY1YwA47e5OFUmYY1gYlGjgzRycQWVuXsdqbJcs5CJ8ifo5eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6700
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,

On Fri, May 26, 2023 at 09:23:53PM +0000, Fred Treven wrote:
> 
> Hi Jeff,
> 
> > On May 26, 2023, at 2:43 PM, Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > Hi Fred,
> > 
> > On Thu, May 25, 2023 at 07:04:31PM -0500, Fred Treven wrote:
> >> Use MFD interface to load the CODEC driver along
> >> with the Input FF driver.
> >> 
> >> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> >> ---
> > 
> > Did you mean to include a thin codec driver as part of this series to
> > support the audio-to-haptics use-case? I don't see one.
> 
> That is the end-goal, but I wanted to submit a request for comment with just this patch to see if it was at all acceptable to add another device this way. I see now that it is not.
> 
> > 
> > As Lee correctly points out, this isn't an MFD despite the title of the
> > commit message, and is sort of an abuse of the API.
> 
> Understood. Do you think it’s best to migrate the appropriate code to the MFD subsystem before submitting this initial patchset (which will include the codec driver) or would it be acceptable to make that change after this has gone in? My hope was to avoid having code being reviewed more than once if a significant portion is moved to MFD.
> 
> > What you seem to actually want is a true MFD driver responsible for
> > initializing common resources such as regmap, an IRQ chip, etc. That
> > driver then adds input and codec drivers as children.
> > 
> > At the moment, you're more or less treating the input driver as the
> > MFD with one child, but that is not the correct pattern.
> 
> Yeah that makes sense. Please advise on what the best way to continue would be: a. Drop this patch and migrate to MFD after the Input driver has been accepted or b. Move necessary code to MFD and add both Input and codec drivers from there along with the codec driver.

If your goal is to support audio-to-haptics in mainline and to do so using an
ASoC driver, then I recommend option B. You should start with a scalable and
maintainable solution that reflects your long-term goals.

Option A is sunk cost. I also expect that you will identify additional changes
required to the input driver, particularly with respect to interrupt handling,
beyond moving initialization-related code to the MFD. It's a major re-write in
my opinion.

It would be interesting to see if an existing Cirrus ASoC driver can be gently
reworked to act as the child codec, vs. having to write an entirely new one for
L26. I'm sure the devil is in the details though.

> 
> Thank you,
> Fred
> 
> 

Kind regards,
Jeff LaBundy
