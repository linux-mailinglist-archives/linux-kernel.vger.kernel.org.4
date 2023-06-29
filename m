Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A325C741EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjF2D3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:29:36 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:46048
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbjF2D32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTMN05Tfc9m3UfsOMf5J+J5cUEq1fKY/Z+RgKOqyrz5F/XnAWCgrhEXQapsgYaBC8jO5B1Bc7Kkpw4bLXtmZRvApPW5kh9WS6LV+YPcfWO0M/NvuG8kHqAm9U2SkF2MeeA/I3L0rwGQ4hK5CVBfKv8H02PFonyRdysRTH1YRV22SmbOWtWovmSOVhIDFQyejVE6yS239rn/y01FAlGR2ukM6MJ4pEiHeq750lTkB+5vrhQBtak2k+y22nKSreJspPfvpkvbKih7xucnKkRC+H1QV89XbecdYRjPtHsbL54nErCn6nteC2EOA4bvR8xx+/RNS3k6ONWYuX3m0fdWcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1gIl2KnGKIYnrZfU8hoo4kYNZxkWcn4lGVbsm+1T+w=;
 b=LJ/Uy9xVOuKrGhs5NkUHO2l1iWzagClYUQHiVVmdn15+glhCKdubbTmX+HMkGxlNwNMavrze0rmVuiG5ZZtECKC/sHfn1r3ZgMyMh1srYy9w+jlM1TqaV2lFzGJRmxYK56TmKAA4nE+7WmJ53j64OzvxQJ5tAw3vCwu9Q3KxmijWJ/Lc5brXBzP6VIOMv3GJ7ioMxBazjb0TrPzuPzBkd7gFG8zZfdBpUOhP0F3XNpzfwMyakik7SHucFe4xIZRfV/RIVFgLPsdo1wTBEsGi2ygwverqvcGy/ZltJL6eUk0qnQ1kgj3ECbLt0rFPEyrOqR/VUxUDAlq/gAc3LEMbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1gIl2KnGKIYnrZfU8hoo4kYNZxkWcn4lGVbsm+1T+w=;
 b=pDXoy68ynyr7C+17GACxUvLSjnmPJOOZyLSqjToU20Brj5uvexK1cMhJqxLJqqbGRzlhLl2pi/qe3HNl1lox8tB6NJysdnExQriAnvjAV604Y0fdcphrO6LTgXkpncglDchivsjfnA9K7pSeqgiArMvsXe3HWNdwql6ztFGJHzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6796.namprd08.prod.outlook.com
 (2603:10b6:806:110::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 03:29:24 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 03:29:24 +0000
Date:   Wed, 28 Jun 2023 22:29:18 -0500
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
Message-ID: <ZJz6jnt9hDjuU3du@nixie71>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
 <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
 <ZJmW/KOCJF25Z79t@nixie71>
 <543b2d74-eac4-3856-17c6-0654459a91b4@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543b2d74-eac4-3856-17c6-0654459a91b4@wolfvision.net>
X-ClientProxiedBy: SA0PR11CA0195.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::20) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: e26996e0-dae5-4c66-bb1c-08db785108ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2N0PnYrc2eXNm9bHErydtY0HGU1S/r1C3sGbT3JRkHqy76YtBYjW0/5MuYbY/WKrULbgzW97+hriNd3Jgbe0XoKFwvsSgZLhuYvRioOCTWJ8xJ7l26nxAL3of/ZpZoWAjEyGUy+Pr7Dt9Yp08C4jblhhsSjJ5Ge97X05OHdBy/OMNIW7snW1keU+7YAeZFOUJtuIK2ez1tuy0a+5Bl6AVr8nZxVcqX4kUEJlacL2Uy9GGlpgeE3SSzTh/bvuZVgR5lkD0PXjn1n8JbpjbWLdxnctC0avCCLuQIllQZT8NKiEgV4QQgl5mB4xd3nh6/e6VSLz4g0FwOxlvMvHyVnO0PDJI3yQrLC9+HhL9JZX4seOeT/GnQqJ6sTPwG/6XQfSG5h/51kV8YuTA5Qkscn8OMeshRCUpPVtwlasSCyuXi0Tp310a0pfh+Ad5sHBB2fRNNbhdFQF4WJpf+rdxmqY2kp2Y9IA+ve/+ZYLyqqB254aLjAEQYOXPIKG95NIEFRR6GbrRWrPpJVy0UfDrMT03f7TYj8ut/X4k8+ZVgPHdkiooOj9d5x/g3FSARAYG6XC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(366004)(396003)(376002)(346002)(136003)(84040400005)(451199021)(38100700002)(83380400001)(86362001)(478600001)(54906003)(9686003)(6666004)(6486002)(4326008)(41300700001)(66556008)(316002)(8936002)(66946007)(66476007)(8676002)(6512007)(33716001)(6506007)(186003)(6916009)(26005)(7416002)(5660300002)(2906002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+meQ6xdrJhKncI6YDs3akP2NWLVDRoa2QkIcyEOV8vhQRVIX8cjy43bwmgLc?=
 =?us-ascii?Q?0OBatbOQ+xgrxU/V+W3pEr16/fKRAofsBSxI5aa2WqO0ZB/Xe9gaaKxqdyFq?=
 =?us-ascii?Q?wd98eT0rcFG+Eo32DrzjDGW78td8NeX/8nOW2lk4jEc3pdBLCjTdzl0FdU7c?=
 =?us-ascii?Q?LZaq0Gs3xF5WSmgLlCIMbSmYZ/3lYjvbXoff8m968/c8phKF71rKalwr/Y5I?=
 =?us-ascii?Q?pROco9JUJFvGJpbLhYSfGay6E2vq5yPnBL0VZbhn6EpkuT6k54nPiwzo4ELC?=
 =?us-ascii?Q?oxu/F0fD4cgW+z8W1ZDhGSmPO/rc4xFgemm8DWoZi20omXytxJBRpQiMcDlu?=
 =?us-ascii?Q?3QTe7dHL2Zq+AVOUBIKogWYs+Em0+FykxGzFIrGjjzZLe+mROS6XOr+H4QlW?=
 =?us-ascii?Q?76SLrYpJB8nJZSLtwCmZFVbQ5TjQNOpOYkN+mp/jUD79VPtnw0x3bV1o0EbP?=
 =?us-ascii?Q?6wqdxI//E5DZB5TPnOEvct0XwHPgW+V6bciTTJUr57FzXNb5cqQ8a1e7G2OP?=
 =?us-ascii?Q?k/x8dalAEqWjRRz1iZbcOn+EMdtaYEZ0kyS7SiMATQW0DC/ZOACp0yM6b3aG?=
 =?us-ascii?Q?5SIBvrjcIiPtO3tR9PwVM6NqaJsHjcbRIus2o5bjgxjqUHDZFYcSAIDYO8eq?=
 =?us-ascii?Q?v0y03+nJ6Sz8HzkD0nj4HclMcsEv8eTMnkaT5C0M9ypzVIxEp8dmx4h3nWIS?=
 =?us-ascii?Q?hP4TkwnoQ7Ebgq+NbPfcbfQcAn35cstA1QadbOivbNwfiJtjfu1Zebkqow/L?=
 =?us-ascii?Q?MKisPDOTEPPqJ7IEeyKryWpntziOhUyQ9IwCBx5xGQ0r8vzJ5u+877iE7rGa?=
 =?us-ascii?Q?mezBab9bUmG+8NDtPj9VeYQkQm0A4erhLG9A/bHW7VpVYDLhPXbwEIelOdz/?=
 =?us-ascii?Q?OUgepg8A3GWuNZ1fgHHu7T2g+ais9EdPFsJeLkuIstoq2Zz++XaSdouKOdqT?=
 =?us-ascii?Q?FktxkKiDEKxpQsrc9uOrVJPRAFvGDuqwHWT055g/thvEHpoPOQT7mwICSel+?=
 =?us-ascii?Q?ZTDKFcFTx+4q7Iv0tXrwVss4HzJcLBT+E86Ik8338b7ZH5xQVtlB7lNJ3Qci?=
 =?us-ascii?Q?ib0J7hX32RGfOrlcAJUCFKF1YdGgPFb49zZUxAxdDRdtRCTWRQuCx6JWFgPE?=
 =?us-ascii?Q?5pBByQybv+ucvUDFFxdmLQ4Uab8OOfzjX99Nq4/rPPhUzbKIalHvfyWNnJCa?=
 =?us-ascii?Q?0VNrWa/zuCrIkMvMwqj+2YCJdpe2CfZwKfw6NOXqPz2y80U8bvNHn36HT4d5?=
 =?us-ascii?Q?dlWOZL9Nm9VkpMV65fJDzdgRcIbK46hwsBbCmdhTtgp8AHqwQzAn4MVifpPU?=
 =?us-ascii?Q?xxLqz0cLI4BXLMHGJuWmPX0Qah+AysXuWUUaPGzs4d0d7g0+of1TSPFPZEkJ?=
 =?us-ascii?Q?Rs8Nxoo/0hlTvBctDoRyJnaAgPtnSCD3WQfNqaE7SxxG6vkXWoTnF3cJcPh5?=
 =?us-ascii?Q?rUcntVpQR2c4z7I0cccCvJbVpkLyiWxTPrUmY0YjbgQaq1Z1Kas6hul9s9mg?=
 =?us-ascii?Q?LseUsrG3j4B/OZSCIZOo9SvnGOIK9GEqeGOdG9p2HtrZbrvRcV/uWrPyl7k8?=
 =?us-ascii?Q?Z7IJLI77lbjXGMuGETV0Blu6c6+ECJuq7E3cf92k?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26996e0-dae5-4c66-bb1c-08db785108ea
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 03:29:24.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0TVC7UCcmnb8idyQAfIJA5abHNcLu2sUcSMkDlIrB2WOAVOdqHUnDQ2ZC6fvkdPrBgWUrKKWlBz/9UTTZeHIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6796
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Jun 28, 2023 at 08:44:51AM +0200, Javier Carrasco wrote:

[...]

> >>>> +static const char *const ts_overlay_names[] = {
> >>>> +	[TOUCHSCREEN] = "overlay-touchscreen",
> >>>
> >>> I'm a little confused why we need new code for this particular function; it's
> >>> what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
> >>> can't we keep using those?
> >>>
> >> According to the bindings, touchscreen-min-x/y define the minimum
> >> reported values, but the overlay-touchscreen is actually setting a new
> >> origin. Therefore I might be misusing those properties. On the other
> >> hand touchscreen-size-x/y would make more sense, but I also considered
> >> the case where someone would like to describe the real size of the
> >> touchscreen outside of the overlay node as well as the clipped size
> >> inside the node. In that case using the same property twice would be
> >> confusing.
> >> So in the end I thought that the origin/size properties are more precise
> >> and applicable for all objects and not only the overlay touchscreen.
> >> These properties are needed for the buttons anyways and in the future
> >> more overlay would use the same properties.
> > 
> > Ah, I understand now. touchscreen-min-x/y define the lower limits of the axes
> > reported to input but they don't move the origin. I'm aligned with the reason
> > to introduce this function.
> > 
> > This does beg the question as to whether we need two separate types of children
> > and related parsing code. Can we not simply have one overlay definition, and
> > make the decision as to whether we are dealing with a border or virtual button
> > based on whether 'linux,code' is present?
> > 
> A single overlay definition would be possible, but in case more objects
> are added in the future, looking for single properties and then deciding
> what object it is might get messy pretty fast. You could end up needing
> a decision tree and the definition in the DT would get more complex.
> 
> Now the decision tree is straightforward (linux,code -> button), but
> that might not always be the case. In the current implementation there
> are well-defined objects and adding a new one will never affect the
> parsing of the rest.
> Therefore I would like to keep it more readable and easily extendable.

As a potential customer of this feature, I'm ultimately looking to describe
the hardware as succinctly as possible. Currently we have two overlay types,
a border and button(s). The former will never have linux,code defined, while
the latter will. From my naive perspective, it seems redundant to define the
overlay types differently when their properties imply the difference already.

Ultimately it seems we are simply dealing with generic "segments" scattered
throughout a larger touch surface. These segments start to look something
like the following:

struct touch_segment {
	unsigned int x_origin;
	unsigned int y_origin;
	unsigned int x_size;
	unsigned int y_size;
	unsigned int code;
};

You then have one exported function akin to touchscreen_parse_properties() that
simply walks the parent device looking for children named "touch-segment-0",
"touch-segment-1", etc. and parses the five properties, with the fifth (keycode)
being optional.

And then, you have one last exported function akin to touchscreen_report_pos()
that processes the touch coordinates. If the coordinates are in a given segment
and segment->code == KEY_RESERVED (i.e. linux,code was never given), then this
function simply passes the shifted coordinates to touchscreen_report_pos().

If however segment->code != KEY_RESERVED, it calls input_report_key() based on
whether the coordinates are within the segment. If this simplified solution
shrinks the code enough, it may even make sense to keep it in touchscreen.c
which this new feature is so tightly coupled to anyway.

I'm sure the devil is in the details however, and I understand the value in
future-proofing. Can you help me understand a potential future case where this
simplified view would break, and the existing definitions would be better?

Kind regards,
Jeff LaBundy
