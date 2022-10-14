Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43AF5FE69E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJNBjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJNBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:39:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA6619C046;
        Thu, 13 Oct 2022 18:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BygN0JWyPrCUNPWyk4NqWAU7RGcBdCvXSABx9RwMyILcoPbEhxkh8B8h49WujRkAMTnFFZrJ/cf/y+YPrOWFQ2x0907xPdfOSTBxZD/UWKliwBpAKg75t/P887thROxMULWo8PhnQ4BbFyQvT5d9YFdaYSNJqvsZ2Ju5BZIh1uGUWTUIjMvbiO8/7x2Fwu/z///0IM8Vd+feNZVYS9QsTOUreS8s1xhM5CW7SUAQFtf134u/upIb51ICuEBjwuHzaQ55Ru9YOMK9Rm4oKjSwut3o6muc61L27JZh4pB4jVCbNpVp02Y3ke55Koau1FE+/9EDzDqkCVeNJ1ZcP6A4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V94p5BU4T9w7IiTUR/XehkPpjd+XYqm9wYBWB/L4k6o=;
 b=dYvJlrBdv/DEQk1DdsNQjXRFKH8jWaOA2AU5XOIjrK9FEUzIeSvAHDR17NEzBe6vUdzO5VEEOq9n+58hELt0PLizY9Yf4CRaFSRUo3at1aU4e6pahRUPRf/mWi4DnnemjWJ9vt5C2+UVvP21KUkHWhxG4v+TTD7KsxVkuLfdGiUas1SaFfMS8RUsUHcSzDwMdX+NjWFshDkJmFNMI02MyEAd+GFlMtNLG4iHUQNgXjqs9YdlLeF4xeOOGtTrEJlkWdpH0JhmGdjbGiaOs9Oo2eLRnKzcwsMkVfnvGloGjT0G+0TVuGiY0eM7dVtBA05JZhpTuiXe9oZ93TiHupBiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V94p5BU4T9w7IiTUR/XehkPpjd+XYqm9wYBWB/L4k6o=;
 b=eeh+e9dRcWT6JASvttexS4xb09JvqXy8rOcfY21UAaFDNJzdsvVT4w10hobD9iNcU6q3JL4tC0HwbGCejST21apoPKb2qMVtbul4EEf1Ycw0MWa1E+kh8pYwBRnAWIHef5tsME8VC4GMFai/57Kx+6SSd6o+/M9tyOD5iShqN40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB8228.namprd08.prod.outlook.com
 (2603:10b6:510:169::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 01:39:28 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::afa7:70e3:c2c9:b680%7]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 01:39:27 +0000
Date:   Thu, 13 Oct 2022 20:39:20 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Job Noorman <job@noorman.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
Message-ID: <Y0i9yEiZn0kjYCU6@nixie71>
References: <20221012202341.295351-1-job@noorman.info>
 <20221012202341.295351-3-job@noorman.info>
 <Y0d5MNtieyJSaidq@nixie71>
 <CNKVTNMGW8B6.2H4V2JKJ6Q3CO@ancom>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CNKVTNMGW8B6.2H4V2JKJ6Q3CO@ancom>
X-ClientProxiedBy: DS7PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:8:57::19) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7bbc89-10b1-440f-b00b-08daad84edac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTO9ZaCcu52mv5aMb5J7vxfLyMFAko+FeYJr9O/LvvFG8PoFfLFlPih5WyKFiPAzTmxBLqCTAE9Zg+CNa1lhsicycH8B84S3BsBJryql/DeooqtZxuxcq62GZP0xVEzIonKrVNwBV/x+zm8m/xp4SejHyL5WwFkkzIfs+vq1laaQBf0LiNPjMp0BwWEQnCkb3pqg8syh7Er1rjQC8DYpDGu6pgHJupD7ADERLFOM7cTxMJFLFtTNoih2h018Z3Fmr0se2nP2ouTL1pCSG930aJKQ6oN7I2eSFlHTjGAnH9rTOwTOxLibLgQpyQas7I2RcvXnl/C6kc06snXH8QAT+pG8i7HCsclEkZDmDuwMKFOZP33mGcf1F39wip4/CkiL6TVFHaW6QCf/OjofZr7J3XvbWI33sOjV0v4ZWUgOCWxMGdelJn2+ovFPEUUiGgsE0V1aolfrLHaD7atVH0ehcSRS7Zl8Gs556MNDLXseD7OFneGEcuGxYN5moAxcgqJDUaMdUhWQq72SidGnMy8nIu/IVTpamcRDx6aZWTkXPayC33vztOxeHV18QL1Ebjab+CgR9eb9rSmrO/twABWm7+QpQNc/Auhybb+wzOqfNz/XykXjklO2Cql5TjQH+UJw1KALc8iqCSovq+j0Mq+ednoXXv5gSinuryVfgz/5UTgJCMrMLP1XpMS0LNIE2HgBEE13itsJ7fQ/DqbF6q903w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39830400003)(396003)(366004)(346002)(376002)(451199015)(8676002)(6666004)(316002)(41300700001)(6506007)(6512007)(186003)(26005)(9686003)(86362001)(6916009)(478600001)(2906002)(38100700002)(5660300002)(6486002)(54906003)(8936002)(66946007)(66556008)(66476007)(4326008)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFsU40p/g+nLBuRwfWetvj9vCogB1On/A0xu4J0T7vMT6Un1UcLJxeHEHyWL?=
 =?us-ascii?Q?n9xp5Puyh6TOjCOk8Rvf0dYqxhhG+zZV2Y+mlRfUHCymgCUfg486kmY955ax?=
 =?us-ascii?Q?uFLX95mxNb+8AeMOeXHKDQwY9UvcPvPS83QLZXPrEkSWtvgxCBzh3ARHeEjL?=
 =?us-ascii?Q?z0n36DOKqGcpYGQ9cTMMVc2OG0oVm7vCOICLLpKa+CsunoCPa1b880xiYFiv?=
 =?us-ascii?Q?JDB046pOtfbG5U5suP/ey0Px12aBdVrzlNh/nQJ6V10Bs2Zuc9adZ0tcSQrd?=
 =?us-ascii?Q?mWf8G5RcRWKffMk6/+fuATrPAFFYzy9X9xJrlv1253FWck9IS1IZz0HKpXuF?=
 =?us-ascii?Q?y4T73wnmIB68J3jpuuNes0W9tfzU2yM+9mvn7J+NhViz61jbqoTJT6T6PmfL?=
 =?us-ascii?Q?HguqBTL57eN3VUhtTlRnhXcmLtfMznGFt0io1meDqYvzK0nG3mAHhcte01tL?=
 =?us-ascii?Q?6YXvTPqCCj0cq+d5W0qRTGMk1QQ5YMyRSGbKHiadJtvMHF0vFHZFMdzRRuIy?=
 =?us-ascii?Q?14CShSPR++3DKxAcM0Ah2HI6VcgN4ZYDPSLfKe2Lzblp8CmizzNxWCQtpi0/?=
 =?us-ascii?Q?YOZnBpmX2En6XnN4wiy6pch4DFQOLjgl6qB8M+o5uAOZkd8RAVzVH+Lbdpn5?=
 =?us-ascii?Q?8fnK+5o1hlHn6az7vJ9Obm0YTc3q+YDEFd0zmvvxN51Z5XFSWD0ebMqZ9XbG?=
 =?us-ascii?Q?EwmHqKskvwU1vcZvD3YaIbqAWYTLqEaAuELgXSaeHFSf3W5+0THwtT+1xMJj?=
 =?us-ascii?Q?WoSWY2WAUti4UsxzJA105cyxW14nijsV5ToakQnT2XThIy6vhqPAO1PAb4m9?=
 =?us-ascii?Q?ts2Yc5QJK3zJncZR2RSxqYzHoR0g2d7veMaN2KxK09ug1kPNYQrlAGNasqhZ?=
 =?us-ascii?Q?1qjp1uJmirrwIZ+AMW89Fo0H05hHD41dhDDujHshNyvtQVwMuY6XS9lPJNYq?=
 =?us-ascii?Q?sgcZLwiZ2zm6QHgQF3zqQdLLlFFs+Z++DePqmntnpDtjtRYbQvEz9q6futNU?=
 =?us-ascii?Q?Ebogi/n30RQZnMSXUuBrwa5cGkmfCbX8d+PygHOnHN6wH9quqlJe7m1RHDle?=
 =?us-ascii?Q?jODTUyep3oVHN1CDOpiahVi5RFFnfFVKXKjaQR5sVskO6OxyicX1euNAkZaB?=
 =?us-ascii?Q?RUA/U7NAwh0OHxoRHQ4KCTbgCfmfgPcCPTHafAlC/TH68TcAWWWMEGj5gcNW?=
 =?us-ascii?Q?r6HMpykSlO83SC8bmvAFj5mQNBE/B63LqUvRI2qX/R+o/MTyADcR/bKqHSP8?=
 =?us-ascii?Q?OlBTkguWELfQ0UqgD1XsaDyg0Bxz3cSEsqxOu0YWWh19CLp54DPiTuzgRkqm?=
 =?us-ascii?Q?3T38tUKlroxI2qJEKWcIN97uS6BcUCs9pz4ynuQzZLnCwh00SdMGWQ27dUoZ?=
 =?us-ascii?Q?m76T+F2RsqJVell+QXLHRbg5dyahB4o9jsMLjiDAdQD/1BL35BqT//ZCU7Ts?=
 =?us-ascii?Q?xj3MUkhrF7ujlImsZ6UgDpMP3DrHpkrpfvvGhJNEKxWFeEAPJVIKpel+2Dgk?=
 =?us-ascii?Q?7cw7ZrFBSvRgdYGs52ENCOFOFJv2mjAgq9wPFtCgSXY+HECL4OlvVY8ZEeOU?=
 =?us-ascii?Q?TDOMSxRrFqqIpUR/7XfTQp4m6FbK2+4RBlj58JDj?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7bbc89-10b1-440f-b00b-08daad84edac
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 01:39:27.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvQ8rXU8fKtWdma++nVeAtyDOab84tz102R38EzJ5CN5AlDDEu2a0N8RxdLAi6jLp7MoA9bPFfE98wCy7aDggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8228
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Job,

On Thu, Oct 13, 2022 at 02:57:55PM +0000, Job Noorman wrote:
> Hi Jeff,
> 
> Thanks for the extensive review!
> 
> I've addressed most of your comments. I will reply below to the ones I
> have not yet addressed, or have questions about. You can consider the
> comments I don't reply to as addressed in the next version.
> 
> On Thu Oct 13, 2022 at 4:34 AM CEST, Jeff LaBundy wrote:
> > That being said, use of dev_err_probe() is generally frowned upon in
> > the input subsystem and I tend to agree. The argument against it is
> > that resources that may not be ready in time should be responsible for
> > the housekeeping done in dev_err_probe() rather than every possible
> > consumer doing so through every possible error path.
> >
> > I only mention this because you will likely be asked to change even
> > the "valid" calls to dev_err_probe().
> 
> I have removed all uses of dev_err_probe(). I followed the approach I
> saw in other drivers of only calling dev_err() when the error is not
> -EPROBE_DEFER, and calling it unconditionally when this is not a
> possible error. However, while I _think_ I managed to figure out for
> which functions this can never be returned (based mostly on the Goodix
> driver), I wouldn't mind if somebody could double-check this :)
> 
> > > +static bool himax_event_point_is_valid(const struct himax_event_point *point)
> > > +{
> > > +	return himax_event_point_get_x(point) != 0xffff &&
> > > +	       himax_event_point_get_y(point) != 0xffff;
> > > +}
> >
> > How about U16_MAX?
> 
> This feels strange to me because conceptually, I don't want to know if
> these values are equal to the maximum u16 value, I want to know if they
> are invalid coordinates. It's incidental that invalid values correspond
> to U16_MAX.
> 
> I created a #define HIMAX_INVALID_COORD for this. Would you agree with
> this approach?

That sounds fine too.

> 
> > > +static irqreturn_t himax_irq_handler(int irq, void *dev_id)
> > > +{
> > > +	struct himax_ts_data *ts = dev_id;
> > > +
> > > +	himax_handle_input(ts);
> >
> > Is it accurate to assume that the act of reading the event status
> > register(s) is what acknowledges the interrupt and de-asserts the
> > interrupt pin?
> 
> I assume so but without datasheets this is impossible to know for sure
> unfortunately. However, since this is the only interaction with the
> device during an IRQ, I cannot imagine what else could cause the
> de-assert.
> 
> > If so, I think it is safer to define himax_handle_input() with an
> > integer return type, then return IRQ_NONE upon failure. If the I2C
> > adapter goes south such that reads are never initiated and the pin
> > is stuck low causing an interrupt storm, the handler would get cut
> > off quickly.
> 
> Done! Two questions:
> - Do you think it's necessary to return IRQ_NONE on a checksum failure?

I personally do not think so. In this case the problem is not that the
interrupt went unhandled, but rather the driver handled the interrupt
but decided not to trust the data and post an input event.

> - If I understand correctly, this means that once an error occurs, the
>   driver becomes unusable. Would it make sense to try to reset the
>   device after an error?

That's up to you; it's not terribly uncommon to wrap low-level register
access in some kind of retry loop if there is reason to believe the
device may be unresponsive for some reason. One could issue a hardware
reset after some number of failed attempts.

Personally I think that is a bit overkill for an initial submission if
the device operates perfectly fine on your platform.

> 
> > Just for my own understanding, _when_ does the pin get de-asserted?
> > Is it early in the I2C read, or after the stop condition? In case
> > of the latter, consider a delay to prevent the interrupt from being
> > immediately triggered once more after the handler has returned, but
> > the pin hasn't quite returned to a logic-high level.
> 
> I don't know the answer to this question unfortunately. The downstream
> driver doesn't seem to have any delay after reading the registers
> though.
> 
> > > +	error = himax_setup_gpio(ts);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	himax_reset(ts);
> >
> > It looks like we're expecting an I2C read to occur directly after reset
> > is de-asserted. Understanding that no datasheet is available to specify
> > how much time the device takes to exit reset, does the downstream driver
> > at least include some delay?
> 
> The downstream driver has a 20ms delay between asserting and
> de-asserting, but not _after_ de-asserting. I have copied this behavior.
> 
> Here's the funny thing: the I2C read you're talking about (to read the
> product id) happens _before_ the reset in the downstream driver and that
> also seems to work...

Interesting; I'm guessing that's because the reset GPIO may be pulled up
such that the device has been out of reset for quite some time before the
vendor driver reads the product ID.

> 
> So I'm not sure what to do here. It does feel safer to add an additional
> delay so shall we just do that?

Since reset is asserted for a whole 20 ms, it seems relatively harmless
to insert something like usleep_range(1000, 1100) after reset is released.
It adds some margin and doesn't noticeably increase the probe time.

At the very least, it would be very obvious where in the code one would
increase the delay if required in the future. Consider adding a comment
that the delay is a guess to prevent future developers from believing it
came from a datasheet.

> 
> Kind regards,
> Job
> 

Kind regards,
Jeff LaBundy
