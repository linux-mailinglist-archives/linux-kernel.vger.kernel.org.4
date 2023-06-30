Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4174413A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjF3Rau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3Raq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:30:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1C199B;
        Fri, 30 Jun 2023 10:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc13QP/cO84Xf3K36kers407GNcJskOFLCK1a/A4Fz8qObzHOpn3s5z/NDPNtivJSf5biFcxtvGq24p6Gx+RB9eIUGGP1cwiDv1WRMOQ5BsXKeCyxDygLHPnT8sx2wMNVIgqSmZHhaj60iQwjOPjfnL5plMvv/jVsNgqUUYg4pve4YmYgFlai8tuSmE7w/70nwmJcNeV/ejWsV7zsxURTsxjteE1+QadU7Zy8PCWESx8pW+m9KKZHdc81R/ZdAIhF4PMGWusOT01wnZAnRvjQBz55AOUIkznhbf0kScSmrgGwd2rQ5hyBOnbn9oJBrS2Z9TZZreuzzpDkZHO2GrqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAlshh40sjhiP/lkiGXRdr1eUSJK5dnQQxh4JAbALhk=;
 b=JSSunPN3XWZRaZi0VnwyefnP4YKFnezgUDIuwVEtlsrrX3/OJqHjyq6rSnF0DZSN3ES80UBfpF9G2jx1S0Z0qLsfo+leltOrHfIfWaqjRV3S7TeKUzClSzJtdE1+9IBYHl/VLARFxYwQBuCneB7+3kgKCBMDezbgLLikKTJq2dtxAON91C0QDLncNLJcuq9WOkTip9VMhFBZh1xVe/R5Yt9Okbqmwh+R9jiRi3yjGdFYzvCKO986tjDKRqiN9+wJgATuAPp7cXmuYqNDctzfAtdmjhV7lIxktfF3yTG1uVCjX1d1z2roi7WgtkJ4bGxK6rcFtL8gQwl1Wtc7HX3dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAlshh40sjhiP/lkiGXRdr1eUSJK5dnQQxh4JAbALhk=;
 b=EpZ9ibV92ylKwupuwJpCt5ddwB1NToQpDDUiMXUIEEVojG6p71msHKMROunfz8ECg/P/n0gincsNikkvr1JMvDFAoZZ+AJMyowpczrYuO7lYOqwGQc8gMNtHoxn/sAm5V4VYKsINXWlY4K6ty6nrCw+v5RKkmHYB2Vqm7NbGTvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH0PR08MB6504.namprd08.prod.outlook.com
 (2603:10b6:510:42::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 17:30:41 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:30:41 +0000
Date:   Fri, 30 Jun 2023 12:30:35 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay
 object handling
Message-ID: <ZJ8RO5lYgMUSWFha@nixie71>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
 <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
 <ZJmW/KOCJF25Z79t@nixie71>
 <543b2d74-eac4-3856-17c6-0654459a91b4@wolfvision.net>
 <ZJz6jnt9hDjuU3du@nixie71>
 <feb8931d-45e0-e701-d8a7-0f5e3c108a84@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feb8931d-45e0-e701-d8a7-0f5e3c108a84@wolfvision.net>
X-ClientProxiedBy: DM6PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::46) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH0PR08MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 046bb2ec-292c-49e2-0e93-08db798fba05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wp1QnYgfBpmiZ/38r7BbDxNmiWAG1yZwVeKjtptQvx1x0bYlcQ38/vhZwKDKMRlL1CmtMRZ6niyzKIspBdMl+xBdygRBiEaWJqLjQPEys0dQIMumKF5nSxf0GSHIu+1mrJIjOgfoo+6UOcBFFIbRrXxHQlMqpVD41hiJ6maEW3FV5Co1PysVPR5NjAQONvTuZCJWw/VHHFRRzI1s0/f5y7tBLSGsVRV1mU8O+oJfGyKpP4NJ3yCBSO+YoU29Sc8wALAPRClti14UgPdmfUlEUIWDn0tyESdVONsBKssE0ZhmGsrJMac52bc95jAgSoPJuxktEg7V1AhFBtwSd0NI563N8uQW4RwC49cPYYfnUGj9qOGtmob0cT3RiaEcpzyO+sjiMKpCS7jiLMj05xK3UwEgWXJ1TT161uhmQCL+y6xiO0jbpDlwMKqpnyZM6mCn9duXL7dHy2yxi/6wFk4JbPnGplD8q1tctrtHjzOLGpbaAzB9yj56+HlNSQsWllr1+/ODV0MLFBsr9O6r+JCabEoLp18D8xQnz70VSBmpbsLomw6XWwvCb3odrfHlClCU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(366004)(39830400003)(396003)(346002)(84040400005)(451199021)(5660300002)(8936002)(8676002)(7416002)(66946007)(66556008)(66476007)(6916009)(4326008)(2906002)(316002)(66899021)(30864003)(41300700001)(54906003)(478600001)(6666004)(6486002)(33716001)(6506007)(53546011)(83380400001)(6512007)(26005)(9686003)(186003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0l6kY4SGZRASMo/A0nALMJwre+b5VEx1xBn+7y+tb69IrdXWiYH6JPHYx553?=
 =?us-ascii?Q?7+QxCYLYHPSiNtXOLYBSYaK6/OjU6G5G8vlJckYKK6MSzB1zw6QhGTDaYC8I?=
 =?us-ascii?Q?EBnsWqb4GtQThBEf/YXSQsH6WNZWveyCoV1So75c01Hw2buF2AgpgkptliRI?=
 =?us-ascii?Q?eNwyv9ytrXtPmIOXngyuLyGKvblipkl+1kCYQwph8hPVK5xPrwHeDJOBZpEZ?=
 =?us-ascii?Q?HRGKtcHPcpa3tzKKLNp9xXNU5hO0knQGE/iEzNLe17Inb6iZtP+Kud3+HGmo?=
 =?us-ascii?Q?LGfn5XMIDOcoWF+bMs85OWsBDjdc+z5c7U2FjkIo3NWxXFceND/2OzWcnLBm?=
 =?us-ascii?Q?Vesg+qqs05c5Ddfq5CQELlfNeGruzT27geil7Y68zFxfgmxPkhzHJ1+D4P2N?=
 =?us-ascii?Q?7fuDc7teDPLzHIFQGD95HWQMgyY3dH8ZncbvHOqoF2TYA4zmX4Y82/BKQaqF?=
 =?us-ascii?Q?NdVTPW1vWaLsnwo68ZurjAuFx4Oyfb343fyaM5v+BO7A4pGEZ83YjgKzmR4R?=
 =?us-ascii?Q?2CHneXzpPPBHw3bDFZBFARUOx/jKdCbFeoh9OWNVei6DCClxwOB3SSAjC3Dv?=
 =?us-ascii?Q?bmNlJMiTpSuvSoimAlJa710zgBst7goVn7R+ri+7ajHvnvmQ6CY5Hd4xrDgy?=
 =?us-ascii?Q?cnZ2C5O6jdEnJq2k/RJHoItvJbt35TYZh07//9OQP7p5J96l8At61FuFT4uq?=
 =?us-ascii?Q?9kJ745VsLaeSFo/N9CWr681FBdpdS6NSV2KbU4SqLYxhhnw1FvQDJrkC0pF0?=
 =?us-ascii?Q?tSvzNSWXKOdqGEtwBmtaBTxFN8WtbMgoxhsYq1WeDxv4e8Kkz0ik3Z6y79MQ?=
 =?us-ascii?Q?oKLc/bCC2zVbdtUe+ZaeCU5r7cR6vvNswMD9lUGv6UhG8ITZ89WI9rAaNTh5?=
 =?us-ascii?Q?+tMvjwpH3/LVBa1p2hJozxF2iQ76oP3bTuWmXkMAaxD6SEaNVc24P3e6U3Tj?=
 =?us-ascii?Q?sB2YiBVT3exGX7TJNg4ytFow8op05Xl7a1uk49exmfmvyd2xuxaKXteALGYs?=
 =?us-ascii?Q?8yvdCR3WETJWWp3zciGGA7smZZqquUOXu5t2QvVnOWx0d3VvdHC+TwD+7JRP?=
 =?us-ascii?Q?0Za0pUp86xHpREkQn9LhOBKaZPiG/KXrSH9b0S1e4UGRsuuB3NMJT9RTF2v3?=
 =?us-ascii?Q?rD/pS2QU9LJKcTtdWuAtgzW3tTb5Gp+CjaHhSVWN4HwLM56khEvvIodIWxaC?=
 =?us-ascii?Q?JhrV0pWPum9nR+yYnaUOQhQeJBYzvzHlj861b35TOEQ3Ur5FOSyaukovY3mg?=
 =?us-ascii?Q?8GX9izgtuFHsPYtj1M5+ggSyABDSqpMkjvGUiTEW33rYN1EDSOZ/E920DWO+?=
 =?us-ascii?Q?Vjj00chZNR+V4Q4Ty3zeXw1AMxGePtLR0Zn9+vRY5Lw+ComZeySM5IHW16zo?=
 =?us-ascii?Q?UNF0ndOzmg5WvBKfJLyrZ5xOuGfyJcs79xzbjZHOPvKtish/W+f1lotoj0HK?=
 =?us-ascii?Q?4l4oBHJ4TJlhBUkUzZJV6jZ3o3NECRZKrxSUNrkse5tLsEMndYa58OiogESV?=
 =?us-ascii?Q?2tW+YcuhFs0THMHopTt8FVywajBEEnxONnky82Jiifb9Y7OhhdrpsX/gpBLT?=
 =?us-ascii?Q?megMABWIvE8tP7oaHyppHxwy0EPlnDwgdTm92OCo?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046bb2ec-292c-49e2-0e93-08db798fba05
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:30:41.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf2kGDJGLeTJg7r53ZI41heUFW8Cs0Hpjl02QJIPYkt3gkX0UnSLjubpvZz3ngUvBt7q9Ns5dZGDb4g/ybgjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB6504
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Thu, Jun 29, 2023 at 09:53:11AM +0200, Javier Carrasco wrote:
> Hi Jeff,
> 
> On 29.06.23 05:29, Jeff LaBundy wrote:
> > Hi Javier,
> > 
> > On Wed, Jun 28, 2023 at 08:44:51AM +0200, Javier Carrasco wrote:
> > 
> > [...]
> > 
> >>>>>> +static const char *const ts_overlay_names[] = {
> >>>>>> +	[TOUCHSCREEN] = "overlay-touchscreen",
> >>>>>
> >>>>> I'm a little confused why we need new code for this particular function; it's
> >>>>> what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
> >>>>> can't we keep using those?
> >>>>>
> >>>> According to the bindings, touchscreen-min-x/y define the minimum
> >>>> reported values, but the overlay-touchscreen is actually setting a new
> >>>> origin. Therefore I might be misusing those properties. On the other
> >>>> hand touchscreen-size-x/y would make more sense, but I also considered
> >>>> the case where someone would like to describe the real size of the
> >>>> touchscreen outside of the overlay node as well as the clipped size
> >>>> inside the node. In that case using the same property twice would be
> >>>> confusing.
> >>>> So in the end I thought that the origin/size properties are more precise
> >>>> and applicable for all objects and not only the overlay touchscreen.
> >>>> These properties are needed for the buttons anyways and in the future
> >>>> more overlay would use the same properties.
> >>>
> >>> Ah, I understand now. touchscreen-min-x/y define the lower limits of the axes
> >>> reported to input but they don't move the origin. I'm aligned with the reason
> >>> to introduce this function.
> >>>
> >>> This does beg the question as to whether we need two separate types of children
> >>> and related parsing code. Can we not simply have one overlay definition, and
> >>> make the decision as to whether we are dealing with a border or virtual button
> >>> based on whether 'linux,code' is present?
> >>>
> >> A single overlay definition would be possible, but in case more objects
> >> are added in the future, looking for single properties and then deciding
> >> what object it is might get messy pretty fast. You could end up needing
> >> a decision tree and the definition in the DT would get more complex.
> >>
> >> Now the decision tree is straightforward (linux,code -> button), but
> >> that might not always be the case. In the current implementation there
> >> are well-defined objects and adding a new one will never affect the
> >> parsing of the rest.
> >> Therefore I would like to keep it more readable and easily extendable.
> > 
> > As a potential customer of this feature, I'm ultimately looking to describe
> > the hardware as succinctly as possible. Currently we have two overlay types,
> > a border and button(s). The former will never have linux,code defined, while
> > the latter will. From my naive perspective, it seems redundant to define the
> > overlay types differently when their properties imply the difference already.
> > 
> > Ultimately it seems we are simply dealing with generic "segments" scattered
> > throughout a larger touch surface. These segments start to look something
> > like the following:
> > 
> > struct touch_segment {
> > 	unsigned int x_origin;
> > 	unsigned int y_origin;
> > 	unsigned int x_size;
> > 	unsigned int y_size;
> > 	unsigned int code;
> > };
> > 
> > You then have one exported function akin to touchscreen_parse_properties() that
> > simply walks the parent device looking for children named "touch-segment-0",
> > "touch-segment-1", etc. and parses the five properties, with the fifth (keycode)
> > being optional.
> > 
> > And then, you have one last exported function akin to touchscreen_report_pos()
> > that processes the touch coordinates. If the coordinates are in a given segment
> > and segment->code == KEY_RESERVED (i.e. linux,code was never given), then this
> > function simply passes the shifted coordinates to touchscreen_report_pos().
> > 
> > If however segment->code != KEY_RESERVED, it calls input_report_key() based on
> > whether the coordinates are within the segment. If this simplified solution
> > shrinks the code enough, it may even make sense to keep it in touchscreen.c
> > which this new feature is so tightly coupled to anyway.
> > 
> > I'm sure the devil is in the details however, and I understand the value in
> > future-proofing. Can you help me understand a potential future case where this
> > simplified view would break, and the existing definitions would be better?
> > 
> > Kind regards,
> > Jeff LaBundy
> 
> I agree that your approach would reduce the code and then moving this
> feature to touchscreen.c would be reasonable. So if in the end that is
> the desired solution, I will go for it. But there are some points where
> I think the bit of extra code would be worth it.
> 
> From a DT perspective, I can imagine some scenarios where a bunch of
> segments scattered around would be messy. An example would be a keypad
> with let's say N=9 buttons. It could be described easily with a buttons
> node and the keys inside. Understanding what the node describes would be
> straightforward as well, let alone N being much bigger.
> You could argue that the buttons node could have segments inside instead
> of buttons, but in the case where a cropped touchscreen is also
> described, you would end up with a segment outside the buttons node and
> the rest inside. That would reduce the parsing savings. Some labeling
> would help in that case, but that would be not as clear as the current
> implementation.

If we consider your nicely drawn hybrid example with two buttons and a border,
the parent would look something like the following:

touchscreen {
	compatible = "vendor,model";

	overlay-touchscreen {
		x-origin = ...;
		y-origin = ...;
		x-size = ...;
		y-size = ...;
	};

	overlay-buttons {
		button-0 {
			x-origin = ...;
			y-origin = ...;
			x-size = ...;
			y-size = ...;
			linux,code = <KEY_POWER>;
		};

		button-1 {
			x-origin = ...;
			y-origin = ...;
			x-size = ...;
			y-size = ...;
			linux,code = <KEY_INFO>;
		};
	};
};

Is that correct? My first impression was that it seems unnecessary to group
the button-0 and button-1 children under their own 'overlay-buttons' parent,
because there is nothing else inside 'overlay-buttons'. Stated another way,
it seems we are drawing an unnecessary imaginary line around the buttons. It
would be especially confusing for the case where the buttons are scattered
throughout the touch surface and have no logical or physical relationship.

My second impression is that 'overlay-touchscreen' and button-N are nearly
identical save for the 'linux,code' property that can be optional, which makes
it seem like these two should really just be the same node definition. If we
follow my suggestion, the example would collapse as follows:

touchscreen {
        compatible = "vendor,model";

	touch-segment-0 {
		/*
		 * this is the small subset of the entire surface that reports
		 * raw coordinates
		 */
		x-origin = ...;
		y-origin = ...;
		x-size = ...;
		y-size = ...;
	};

	touch-segment-1 {
		x-origin = ...;
		y-origin = ...;
		x-size = ...;
		y-size = ...;
		linux,code = <KEY_POWER>;
	};

	touch-segment-2 {
		x-origin = ...;
		y-origin = ...;
		x-size = ...;
		y-size = ...;
		linux,code = <KEY_INFO>;
	};
};

To me, this seems like a more authentic representation of a monolithic touch
surface. I can't imagine there is not some code savings and simplification to
be had if touch-segment-N can always assume it is a direct descendant of the
parent. In the present implementation, a common property such as 'x-size' may
be one or two generations below the parent depending on the context, which
the code has to keep track of.

> There is another point that I will just touch upon because I have no
> experience in the matter. I have seen that some keys use the
> 'linux,input-type' property to define themselves as keys, switches, etc.
> If that property or any other that I do not know is necessary for other
> implementations, the button object will cover them better than a generic
> segment where half of the properties would be meaningless in some
> scenarios. Buttons/keys are so ubiquitous that a dedicated object for
> them does not look that bad imho.

I think we would simply adopt the same rule I have proposed for 'linux,code',
that is, make these future properties optional and simply omit them in the
case of what is currently defined as 'overlay-touchscreen'. For something
like 'linux,input-type', you would simply declare it as dependening upon
'linux,code' in the binding.

That being said, 'linux,input-type' would not make sense here because we are
simply defining how to interpret momentary touch (touch coordinate or press/
release), so we would never have a switch here. However, nothing in either of
our proposals would prevent it from being used.

> But as I said, I do not want to make a strong statement here because I
> have seen that you maintain several bindings where this properties are
> present and I am not the right person to explain that to you... or
> actually anyone else out there :)

I personally feel my proposal is simpler, but I do not feel strongly about
it. There is nothing functionally incorrect about yours; it merely struck me
as placing some unnecessary burden on the DT author. From my perspective,
"less code is the best code" and we can always add complexity later as unique
use-cases arise.

Since we agree on the majority of the suggestions for v4, maybe a compromise
is to start on those for now, and keep my suggestion in mind as you work
through the non-controversial changes. If you still feel strongly about your
existing structure after that work is complete, then let us keep it.

> 
> Talking about the code itself, having a structure for buttons is handy
> because you can keep track of the button status (e.g. pressed) and in
> the end it is just a child of the base shape that is used for the
> overlay touchscreen. The same applies to any function that handles
> buttons: they just wrap around the shape functions and add the
> button-specific management. So if the parsing is taken aside, the code
> does not get much savings from that side and it is again much more
> readable and comprehensible.

Your module should not be storing button state; that is the job of the input
core. Instead, your module should only be reporting state; the input core
then decides if the state has changed and acts accordingly.

> 
> Thank you for your efforts to improve these patches and the constructive
> discussion.
> 
> Best regards,
> Javier Carrasco

Kind regards,
Jeff LaBundy
