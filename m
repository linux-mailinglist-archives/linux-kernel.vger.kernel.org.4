Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A465B9745
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIOJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIOJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:16:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD39A680;
        Thu, 15 Sep 2022 02:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWb01okOPl41DCwgVZfdIP8SfG5EXI8KT614PILE3PqyuKfExkFCnN58lI8eZzMtZb3PMnoQU6t6vx4QDp15RlKLyHff8bsv0YIZDBcGLlYhh3rMFtdUq4RwZwwXRTIUOSIGtYDzpoPeG40AuIStiqjIc9QlVk69k8ynKB06ByQDQOKLhX5w+Nt2I8UsdtcMe3/VXgmCt6PYvVn3fK3ZOgG9hObU1AbeMkDQVenJoMyFTJvz2kqAAJLrFVVFlMfMm8g861H1d27SDlmqXJUTKo6F32vh/2MkKqvkpQ9v9QcBagIvv9H/9RGVUDsmHGpuCk/LiHLsrB9onCo1dJ3Z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml/WfKzYalJdCJj6kueB5DtoTZERL/iXNUqskdFXkGs=;
 b=b3Vuv3xOi/RHguj4iPlyu47wikzZcn0mNdCegvh82uZaMvzA5M7Sj3Em/PWNe+TnpSILOpbqMCYb3XBCymL9JxjKtjCjWkZNrYSTzrjC0sZAzOvlq96u1cy95STz7RI718Gw7ayQuGPDPKKFMjEpo/7iR5EisrrCzwRuTb0KvQREhllTZxx+qywiXm9eLDxs11Bf0tpIeJoKmd9NfG9A90hvah++IGrE+9/ru7Np8JTNt0+609XoP2yswWdMpudscymE6ikbndFVve8Gof/SbzRZx9Ahgn/kadcMwMptkCMFVlIxDlrfb2lzgxDSCZMFJwZ3OMnsmgfPwGh4CYMIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml/WfKzYalJdCJj6kueB5DtoTZERL/iXNUqskdFXkGs=;
 b=SQrZpiOZ7/6DKp0L6RDnPx/WOXDnCCY2F1jCGnbWOXiLnUVySSmozH45+zmpPZH8M4p69Acs9S7dHmsDESQupsXydPxtq6ZXbfYfvE99mE8VmPL3H9/Lp4+yg/eO/WlCiZHMEQuGOVZ8OYjqbpviYGGKMnP4sdR3ON3RdAz+dRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by PH0PR13MB5681.namprd13.prod.outlook.com (2603:10b6:510:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.6; Thu, 15 Sep
 2022 09:15:06 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5632.012; Thu, 15 Sep 2022
 09:15:05 +0000
Date:   Thu, 15 Sep 2022 11:14:59 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH v7] checkpatch: warn for non-standard fixes tag style
Message-ID: <YyLtEza0VhSbflvH@oden.dyn.berto.se>
References: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
 <aa858ac592679fdf512debe17e0612c575450860.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa858ac592679fdf512debe17e0612c575450860.camel@perches.com>
X-ClientProxiedBy: GV3P280CA0059.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::12) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|PH0PR13MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ab6c77-3477-4915-3035-08da96fac75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxyrgOyhfL1OsfFKD1SsQr6fdjhwma3Yueb5PRD4f7WYxjntcIGY9PSAahTM2DnVQyQrVKYAB4bjChpSVmoE0M68gNW3sB7ZsPJrzxRUQBAZk22jK2uyT1hi9bGcZn6kntRmOloIvdMbYZI1Xg2FCst/BuPW+P2DvwcRaZpqMtTzUNmplddPZvGqGZQ9hK1i7JPyniSHx82b/pzFLRosmFECwU2JqSSiFjkWNvnZ+75zE6jbitOTEczKH783/xVjxiwvwuasQgGH3KlbjcVK7BbpM6MV8C2Hj7sp5oUa/u+vDQdMa6mV4hKOxaD0pg0azfY5zKUbMOBJWZ+jX1/rmVXEWkXF2Kb8XLg/gVSDJm2PiqwFHiWfHYbXnkt7wn6rZ0aAC6SMsmS5sOAaiX4+pGNjnzULOu/ks3R+2xE6/+RWk7W3C5d1i3jhh8kHnrObqj36VXz/UzFfXFzPFLSzgCI73znN1wTk6E9Q4bwi9O57tb7BvV5wbQyAa+Dqm52Hhmjvl9IwSVNESlFCzOAGRx+Lqx6YmTswHJ1YAS2hr/2Mm1+c+TLaN4fcZyLwE+LZY2+XPm7suZTwDXhhiSNTNAHjvQqgOPiGPIXviFIGLHCVNANhYv9QDiKu85Sn6D5uJWumJ8utqUiT1uwHG+sHn58cLIQGJ2yRoO7ffyky7IsFI7p5iBFMAkIAJmtbic0IQsRWwfMcEy5vNBVLgsGaRCyjbfRkv4UhgjxtYN2+3Dk/p4/XIBffhmG43W3iwxbz5A1LNlEGIZyeq6PmV06H2weHcIJET5TH9UnRUNWmSdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(451199015)(6512007)(86362001)(38100700002)(38350700002)(5660300002)(52116002)(66574015)(6506007)(53546011)(9686003)(2906002)(186003)(478600001)(966005)(107886003)(6666004)(41300700001)(83380400001)(6486002)(4326008)(66946007)(316002)(26005)(8676002)(66556008)(8936002)(66476007)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hHd4Fr2GdYGM8EeCOe79n9F3XV5BEl9VB6f4JAt7iNmY8/UHgKQYQQHGX0?=
 =?iso-8859-1?Q?sZ/Ue4tkcZg7RiqTD9AvvwHyPC5j9HMmcLDgnf1ij3wgoYY5uXULr6UYxl?=
 =?iso-8859-1?Q?0V8rCkqqWEVSPOAV2b17m6ZE/vgzVfI4ewiwvSoW7ohcFMNnq/wpz8ycX/?=
 =?iso-8859-1?Q?lc2DKiIfgGY52RO4BYumxmESbDdRMIUm/FIsPMxchSIQvkNiJhD4bWnr5O?=
 =?iso-8859-1?Q?cC7NIx/DFUXv/cMgmmT27jzWYCLklHchuMPbbAraV3uq17PphOmq4mAimv?=
 =?iso-8859-1?Q?2+Hw2VOJncn6w1DnKECmWEKrSfPayyDfJCp4et9K2To1SiVIhIl6Kr6InX?=
 =?iso-8859-1?Q?9pLEJ4JIPAzJuayC2tV3ueAFBkbW2k/v1weVI7iqAc+oEIUQt0CCRYJDTH?=
 =?iso-8859-1?Q?9pIxFB1+WGNh69VcO0FV5DqxIIR+OTbOlVHoXTjBbdeeWGoE5PYxWg6Tda?=
 =?iso-8859-1?Q?3O9SEqHwOIDYw7jVzyt20xqN3IVfX0yU4V0zci939nriqvo06QlryB8fTQ?=
 =?iso-8859-1?Q?5t1vQWkGxZzWds/ueVGT8/odCTxtIhKru5wtXneX17Ye/yB2zgUfPazqAa?=
 =?iso-8859-1?Q?K1pPZAYIFOgXV/uOAT6tdMZuzXyir9SNPhh11iGKzpsAD3MfOE2w2LiEJy?=
 =?iso-8859-1?Q?v8dRaq6W0491ohRi0rFC33ir3ZXtW16tcwB6Nm+QmAMcAulbsaqNxgzWPE?=
 =?iso-8859-1?Q?ydPLgLE0cBI23pIEh9CnVnTAgQZ3kq9QPWMDkbtuKm6ypZ2GPNdwZ8pWzi?=
 =?iso-8859-1?Q?SphM6qPIeWj2kHAhgKrr7Mg9R7lIZU0ThQcUlqtxzXbewKHz0WYOqaH1QU?=
 =?iso-8859-1?Q?QxgHhvOvVMp0ILiuR+KrKI69sYkvvlXbcN3609WsFicsjIdrD0DFh3oujW?=
 =?iso-8859-1?Q?+ifLJG/L2XXUj8yz5jJuZ3x8biDMi8ew0nwy148ngyCR/66bphXEHY7hx3?=
 =?iso-8859-1?Q?Eux47SNpMYYShTCAbm0GLZl2KVO7qv5th3yx9dL5Ok2IqETYQjvFjzPX1F?=
 =?iso-8859-1?Q?bjmy18oM8Bndr3+qxvJphQhe4yGtJ+ZOz/Ynyk7d9NOAM9TF2f1Cy+ArqZ?=
 =?iso-8859-1?Q?ndx+FV6tm+4aE+Yn6OWq0vKzeKl3my4Nm2BK8SjlFe7BPTb529oU7BbvaI?=
 =?iso-8859-1?Q?1DipNq6EWGG/2nUrNf1UU/ORKKIwPQYWlVDPWEyJ7CiQqmqDJeF+oVuwid?=
 =?iso-8859-1?Q?ZtmFqIbDJPrPbpya/jZkuhmRbxUMAqr6fU3AwrSnlnyNzqyDbSzrJAixTQ?=
 =?iso-8859-1?Q?Yf4+ewYs2F6FkeUlxfU4W7ynSAXkbkkRjkCeTN/qVAjvfTN/wshKukTNSO?=
 =?iso-8859-1?Q?s4OwQEs5TKIPVrNwzfs+BAGxad2wNGk1CDwXtXoClT8q1ly6M0mxDgEYh3?=
 =?iso-8859-1?Q?wr+jdKqkpx0eTGULJJGHraxVVCCY3IpG69vXI3DuXhER2+PPLtJSFihxX9?=
 =?iso-8859-1?Q?a4tutAVAMLNz+EevI5LnCnGfDTPkCalN5hXpD8IymVLYoLmZkvcz34wQmu?=
 =?iso-8859-1?Q?6/NrUXLwPwXaBPtLlGiZTfRe1jHGF2Z/lMacVImwHTSV8/6DUrz8RMPyHO?=
 =?iso-8859-1?Q?CC1QV79z8EOEmCqrcB8OoPapDDP3ieatkXT7XFOglHS8fK91RnJqqt3E3g?=
 =?iso-8859-1?Q?w5S3JWEmH4qoLr1TvTjG/YL4cZhS2DrxZ079/fV+SNvNWvGO39w/jBiQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5681
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2022-09-14 09:09:25 -0700, Joe Perches wrote:
> On Wed, 2022-09-14 at 12:02 +0200, Niklas Söderlund wrote:
> > Add a warning for fixes tags that does not follow community conventions.
> []
> > * Changes since v6
> > - Update first check to make sure that there is a likely SHA1 of some
> >   minimum length after the fixes line.
> 
> https://lore.kernel.org/lkml/2febb7893346b6234983453de7c037536e479bfc.camel@perches.com/
> 
> The goal here should be to identify a line that looks like a commit
> reference.
> 
> So find lines that starts with 'fixes' and have a SHA1 commit id as
> broadly as reasonable.
> 
> Did you run the grep pattern and look at the results?
> 
> One grep pattern to verify the non canonical fixes format that
> are mistakenly used is:
> 
> $ git log --since=5-years-ago --no-merges --grep='^\s*fixes' -i --format=email -P | \
>   grep -P -i '^\s*fixes' | \
>   grep -P -v '^Fixes: [0-9a-f]{12,12}\s*\(".*")'
> 
> []
> 
> There are many different styles.
> Parenthesea are sometimes not used.

I understand this, and I did have a look at it.

> 
> > +			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> 
> How about some pattern like
> 
> 	/fixes\s*:?\s*(?:commit:?\s*)?[0-9a-f]{5,}/i
> 
> or maybe even more broadly:
> 
> 	/fixes\b.*\b[0-9a-f]{5,}\b/i

Maybe I misunderstand your comment, but this is what I do in this patch?

    if (!$in_header_lines &&
        $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {

        ...

        if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
            ...
        }
    }

This will catch and warn about such tags but not attempt to break out 
it's components in order to suggest a potentially more correct fix. Is 
it this second filter you would like me to change?

-- 
Kind Regards,
Niklas Söderlund
