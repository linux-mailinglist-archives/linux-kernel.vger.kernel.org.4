Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE06E7E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjDSPUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjDSPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:20:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522349D2;
        Wed, 19 Apr 2023 08:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxZ9ybCwqAIFuZUE6hkm51YqIF8lhRSU8aICI2NJFfFqQdGfOd/dsOSqGXkWyLq9YaISWzvfI+242tJXAh8wFNtpZ8Bt+ZD+N+gOvgB5KO2hmIoes9oLA3f1Mv7ts7tPZctmA9ztBhF63S9iWx1PDZUUwjQcGcDRgZrpm8UF/YT0aVnnmO6Yniaig8IyQbM9LQORa/3K3ikMwNeIs59lyZx4rmebiNyp8wPw29LanFIDe/eZqxVbiESY2KanHZFdm4JvnbciHjiB6Z88bH1UqrVs9FqhDOtAAbTWmZ64yMJ+vBNvaU7r5XRPRur5bxNVJaxnelptwwh2LUyzHzDZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIIyPCFGCyq1xAaTYAeFtZuSQc4ahvT962Tvey5+jQ4=;
 b=kaA1TPRo+bjgoMOXxYGFoxnGm+e0Qh+HhPgdhahSIqWejoaoxWOhYTsVORGjNMAQD/taqN6p/PX5Eex14WPSXcnWeNiFU+mOc0ttJWWUBTl/gIP0CHe1cTalqSKEj1kgB3vrs1l31mctiVD0rKGMfN8+qgeQ9rnK7O+nlkzyNXo+A5uPF8MF3di5jwQnK2WmB9c9woMbrqRQnIHMcKHr8Ftr6OyZcaIU3TpSL0ePuxlQDEvCgKgDOtqBD2LuhXmAVexfYfZEPjm3yDzt3yxn9y/rO6IOOFA7BaV69jjpFfzTtoB6slbNtfaHWyC3B0SZVJbvLHcIlDdk8zc+53ma8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIIyPCFGCyq1xAaTYAeFtZuSQc4ahvT962Tvey5+jQ4=;
 b=LAex7n5suRKX5FQ4Ychjpe3yAmXoK/9AQcJFEywy7Nlfe+IjYP50+8UXpYgcQeMsjtLOvA1AF+yN7iloRrNf4LvA2ttW3xUmy0XghM+0DLqEEy9z1va5CwCbXfLLbFoTnFsTMla0umVnOJ1Sr7LqPNAbEOAYXu4S1bvHTdhPF98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO3PR08MB7958.namprd08.prod.outlook.com
 (2603:10b6:303:166::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 15:18:44 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 15:18:44 +0000
Date:   Wed, 19 Apr 2023 10:18:38 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Fei Shao <fshao@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: goodix: Add powered-in-suspend
 property
Message-ID: <ZEAGTiGyvynGA9P1@nixie71>
References: <20230418124953.3170028-1-fshao@chromium.org>
 <20230418124953.3170028-2-fshao@chromium.org>
 <ZD8z57MBvcfExJx8@nixie71>
 <CAC=S1ngBt9DmBobMkQXWhqE1UUxFv2U6iFd42nT=1N7r8+pFUg@mail.gmail.com>
 <CAD=FV=U_i26a8uJYmqYf6PUgmTUgmEB5L2DkVga0zDX_iDcGQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=U_i26a8uJYmqYf6PUgmTUgmEB5L2DkVga0zDX_iDcGQg@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO3PR08MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: a739dad0-d2d6-4fad-607b-08db40e95d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jp4YFX5W5TF2pnu2k690+I6QTM2ocNY14SYOVSzV9TpF+MmvruQml1cb9qnh0Trpz233lCzX4HUzB8i7OC35x9X6IuA3Lv9jRsxGmxnkU5BLYIICb40JMs5uvTvcsNT5UUzyA9ffo58sQCsRrJXjRYx9pW0aIeHJSg1KA+NR7wX6gfg8P16rsXF9f9fBGHHp9l+jo5QsvG3DRy4fk+BtPiY0gzaNFa8oOAoyrXLYqTE+yV7vqoqtla1j7CKU6XXt4nW4RX53vNkHC9BYoFpjN5yIiBhL/05iMUmuWiGtqsifN4eoDxjjTvUkTaRV8z2ptaBSuKBvQpXNdlt2NA0LD0nT0Jo9RifS9QM1feqYb64AHYxARwhllPeHsPnlaTPSWUk9B4Miq/3YipWeVecvWWsd7bBHkR1GMXyRIAVIp7FxRW4IpzrSAEMj8humtBIxGFHr96euh/J1fUZV91l2FFeRJTrA95FLnsIOwnwK8x0YCvS+Wf+9zDZgzGTRmJXrqUQWGcMXUSicemq/TnVq4WYJuG1Fr/hBY9usILH4KY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(39830400003)(396003)(376002)(451199021)(186003)(9686003)(6512007)(6506007)(26005)(53546011)(966005)(38100700002)(41300700001)(6666004)(6486002)(83380400001)(478600001)(66899021)(7416002)(15650500001)(4326008)(6916009)(66556008)(66476007)(66946007)(316002)(5660300002)(54906003)(33716001)(86362001)(2906002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0V5MXRMRW42ZHUvbXV2NGF3RnQ0MlBBZzBxM0hlb0NZWTFQaEd2dnVaUHB5?=
 =?utf-8?B?ZTJZckNyUVJzeTVvNkJOSjRXOWh1TmFFbStNWFRlRW9zMCtqNndVeXpmdHcz?=
 =?utf-8?B?Y29WOWFDeC9vL0Vtc2lhRWY3UndGc3NLU0FLaTdERCs4c0dXM0ZLQytSY3I1?=
 =?utf-8?B?RHErbStSbVVUSVI4bFJjRUZWR05nNWFhYi9icHlrTjNINXZQb2lzT1pLb2ox?=
 =?utf-8?B?TjFIdkdZWVRSTW5wNHhKaVNIYXlUbmxzR3hQTllyck0zT3pHRGlhVGpDeFVl?=
 =?utf-8?B?eVZDODAzWTdLWlBwQ2U1a1Y1VTVjN3BEU1gzR3dDMGdzT3NFL1B4NDhydEtW?=
 =?utf-8?B?OVh4Q3dMVzluRUFWYXpYN0p1ZU5saVJKdWxneHZ6V3hYMnI0aTFmb01UaXhN?=
 =?utf-8?B?aFFVaGZuOElUYzJuQjJ4OE05VTFaOWNNYTRwam9qUFg1Z3NKRzVEMFVFdVpy?=
 =?utf-8?B?RTdQclNFbEp0Y0QrMUhENXFrQjhlRXVUbWlqR0hZbjFwUngzOWJmM3hTakFo?=
 =?utf-8?B?RUE3NGxBRnhJNlFraGxmQWM3aDFRc1JnOWVjSXo4S3dqNnRGSlhpMDJYL29G?=
 =?utf-8?B?ZmJUY2Q2UXFkOEwzZnVXaHJEaDJOWkZ0S0F6UStjMitma0xNUW8rTmlyRXJN?=
 =?utf-8?B?OUVHWkd1REZTMGhTNzg4dUExZVkxNWNFeGxLaE1rZTFtR25qRW02YjBXMHBV?=
 =?utf-8?B?amJXWGRIZ0lFZ2lPOWE2OUx2OFBFbnJHRy91V2FDNW53YkNDdzN1Nys3aHE1?=
 =?utf-8?B?U0NpODlTYXlOQ0hyeXVza1JMSGo4ZjBBUVBsb2hyTFh0VG1WTkg0MkJGSCtj?=
 =?utf-8?B?aGpIVUJXNm1mQXQ2eUd1ZVFKQ0trWUdsbVB4UnpidWhiT1NhalZzQUUwcUJW?=
 =?utf-8?B?UEdKcEpKVUVMak5nclhxYzhSSmNGNmF5Z0dEM2o0NFdZMXB0SzBTY0Nmc0sw?=
 =?utf-8?B?WWdjbVg4bVd2YWNJTnlZaEoxVDV5ZmdrcWx1SDVLNmNidXVVMW0zTnZ6TlM2?=
 =?utf-8?B?NjFZVG9DaE51eU9OR0l6WlFMT2F1aWh2NENORDlnZFFCM0duR2IyMlpERWQ1?=
 =?utf-8?B?bVZxcG9MbXVKdm91K25tWFllSDFnTDFYUW9WK3AxT1FhRms3TUlkdi9zNDgw?=
 =?utf-8?B?V3VHZlVQdWVQOEtFRE1jTFNQOVBwcWY5Nks2ZmhSaVZTZjQ2eE5nVXgvOEQ1?=
 =?utf-8?B?bFdnVjV1a3A1ZWJsUzRiUGJwTmtCZDEyV2VleDd1aGNnanRqN1hjNGwwLzVC?=
 =?utf-8?B?a2s2bmxicHJZNkcvY3pJK0pMeTdQL01aMFhBV284empOMmNjRGtyZGFFREFU?=
 =?utf-8?B?QWY2eXlqWllVc0ZGSzUvMnFsbGtoYW5HSUs0Z0tidnpuK0VVT2txRFhuZjVB?=
 =?utf-8?B?TWZBZU44UzY2MWgxYk91eGdCN3hYQVBLTjAyNFRnWHhaTGhYbDRNYjB3MVNG?=
 =?utf-8?B?aFA0czZTdkw4cGlyMGUyKzRVWFhKbnZtSERBV3kwYTNHUUw5dVNNblU2cDA4?=
 =?utf-8?B?THU1eVArYm9LRTBKTG4xcVZaK3IvOUF5U2ZlTlRycEtxYzh6ZnlvMENLZHFq?=
 =?utf-8?B?UXVueWdHTW0wRXVsM0pLZG9ZYWQyNDJwbXhjYVVIdHhkS3ZYMjNUZXk1ZXNw?=
 =?utf-8?B?ZTVPd2JBelR0TmlVVFprMDVJSUFna3hiQVZQZlY5Q3dRWHBwUitrQlZua1d5?=
 =?utf-8?B?TlozN3JETzRXZTFwVkN4d0JoOC9XNnNaS0hxQ3lzWWlNNW13eFE3eTZmVEsx?=
 =?utf-8?B?dTVWNU5sQ3ZuTndFQjBWSlIzSEhMdnRYNkdVVWhveDUwSnZuL2JGLy94MTFZ?=
 =?utf-8?B?MWthTW9SV1JBVkZNVmpSYWtIT3k1WmxhNnl0bG5jWDByaHQxTUNDeVBsWkpW?=
 =?utf-8?B?aTlyWWE4UDVNKzgxNTZORzEwaGludGljcEhiQUFNeTh5djVyOEpXWmpVOVZR?=
 =?utf-8?B?VE9pWFVTZ0NPSlRzZWo5b0x3YjNtUXl2bUIxR1BIVVFGZWhWM0QwQXlaR3V3?=
 =?utf-8?B?MXR0ZDlBaHord3hyUmZ2Z1NMekV3NUlPbld6L0lQS3BDQlg0U2ZuOU1LSk80?=
 =?utf-8?B?dktwN2NFUzhJSDY3cXZCZUdDa2d5cDVMQ0ZBM29QaFRHaHMrSFlNQm52TXor?=
 =?utf-8?Q?FM9wOWEUUNmiBuo1+afuhTYES?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a739dad0-d2d6-4fad-607b-08db40e95d3a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 15:18:44.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M776EARZ1t6ix5d/ojHLbEEUHo9oIrjNeP3S97LTXbh91YlAN5dRot2lZXuv2uA+WILznfFh1JRvDEKvgD+QwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR08MB7958
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug and Fei,

Thank you for the informative discussion; I can empathize with the pain
these issues bring.

On Wed, Apr 19, 2023 at 07:38:13AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 19, 2023 at 3:44 AM Fei Shao <fshao@chromium.org> wrote:
> >
> > Hi Jeff,
> >
> > On Wed, Apr 19, 2023 at 8:21 AM Jeff LaBundy <jeff@labundy.com> wrote:
> > >
> > > Hi Fei,
> > >
> > > On Tue, Apr 18, 2023 at 08:49:51PM +0800, Fei Shao wrote:
> > > > We observed that on Chromebook device Steelix, if Goodix GT7375P
> > > > touchscreen is powered in suspend (because, for example, it connects to
> > > > an always-on regulator) and with the reset GPIO asserted, it will
> > > > introduce about 14mW power leakage.
> > > >
> > > > This property is used to indicate that the touchscreen is powered in
> > > > suspend. If it's set, the driver will stop asserting the reset GPIO in
> > > > power-down, and it will do it in power-up instead to ensure that the
> > > > state is always reset after resuming.
> > > >
> > > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > > > ---
> > >
> > > This is an interesting problem; were you able to root-cause why the silicon
> > > exhibits this behavior? Simply asserting reset should not cause it to draw
> > > additional power, let alone 14 mW. This almost sounds like a back-powering
> > > problem during suspend.
> > >
> > There was a fix for this behavior before so I didn't dig into it on
> > the silicon side.
> > I can ask internally and see if we can have Goodix to confirm this is
> > a known HW erratum.
> 
> Certainly it doesn't hurt to check, but it's not really that shocking
> to me that asserting reset could cause a power draw on some hardware.
> Reset puts hardware into a default state and that's not necessarily
> low power. I guess ideally hardware would act like it's "off" when
> reset is asserted and then then init to the default state on the edge
> as reset was deasserted, but I not all hardware is designed in an
> ideal way.

While that is true in theory, I have never, ever seen that to be the case
when there is not some other underlying problem.

What I have seen, however, is that asserting reset actually causes the GPIO
to sink current from some other supply and through the IC. I loosely suspect
that if you probe the IC's rails and digital I/O during the failure condition,
you may find one of them resting at some mid-rail voltage or diode drop. It
seems you have a similar suspicion.

In that case, it may mean that some other supply in the system should actually
be kept on, or that supplies are being brought down out of order. In which
case, the solution should actually be a patch to the affected platform(s) dts
and not the mainline driver.

> 
> 
> > > If this is truly expected behavior, is it sufficient to use the always_on
> > > constraint of the relevant regulator(s) to make this decision as opposed to
> > > introducing a new property?
> > >
> > That sounds good to me. IIUC, for the existing designs, the boards
> > that would set this property would also exclusively set
> > `regulator-always-on` in their supply, so that should suffice.
> > Let me revise the patch. Thanks!
> 
> Yeah, I thought about this too and talked about it in my original
> reply. It doesn't handle the shared-rail case, but then again neither
> does ${SUBJECT} patch. ...then I guess the only argument against it is
> my argument that the regulator could be marked "always-on" in the
> device tree but still turned off by an external entity (PMIC or EC) in
> S3. In theory this should be specified by
> "regulator-state-(standby|mem|disk)", but I could believe it being
> tricky to figure out (what if a parent regulator gets turned off
> automatically but the child isn't explicit?). Specifically, if a
> regulator is always-on but somehow gets shut off in suspend then we
> _do_ want to assert reset (active low) during suspend, otherwise we'll
> have a power leak through the reset GPIO... :-P

D'oh! Sorry I missed your original reply. My concern is that either solution
is a band-aid and does not address the root cause. I would rather see a patch
that addresses what seems to be a back-powering problem so that the driver may
freely assert reset. That is just my $.02; let me know if I have misunderstood
or there are other factors that prevent that path from being viable.

> 
> ...so I guess I'll continue to assert that I don't think peeking at
> the regulator's "always-on" property is the best way to go. If
> everyone else disagrees with me then I won't stand in the way, but IMO
> the extra property like Fei's patch adds is better.
> 
> [1] https://lore.kernel.org/r/CAD=FV=V8ZN3969RrPu2-zZYoEE=LDxpi8K_E8EziiDpGOSsq1w@mail.gmail.com

Kind regards,
Jeff LaBundy
