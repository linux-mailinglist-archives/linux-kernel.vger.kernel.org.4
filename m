Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF205B30D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiIIHra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiIIHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:47:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2759ED9B1;
        Fri,  9 Sep 2022 00:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQLRMZq6o3YGyfFMFmGhsxVCpWjxzIZvspE3OYINyTdHca/v7UcSYvaHC4WdyAdV0hcUx6wWi81suE816HL0EP2/ux/7M0RBDkdqmd6OSkoFFc5vrhK9q1WU5NolXd3p+dizHZzJS2Yh0wtrJh8Y/kyPOzAY8eT/1Z8rlg0pLw822uVpdo3/uZdpUWlSpzeBE+GX6S8ukZLNPvB/xHjOWCpCzSJEXzR7lg2jCSFL+lJAjwCZypE6pOjFj3zi6sUB8Z5nSSxfqdV6jLLRx4ExXEKKeE7FbPYRiuzSIsONxDBdpdZH8Te/y9AQ46nBZ+PKjDrpwONKUBHEKw3o2NU44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgByRmyMLsy2hJh5MNUELBeSkcGHbv/JZvC7xyM0L5A=;
 b=kBHwpVUpiRoPlxurJGmmxSaQWiMbjwi6bMQRHWeKNYA7y+alG8XzEXR3rMwOcIkNXImzR1VjadqUuucx+rBUIUzg5/5i8HWmee/1CqkNuvi0r/WdRmXGu3vmGLsXQ/x5DBTawq+yvSZ5dNCZ6PLdPx5oK2IF263gdEDgNg7z5JVg8JakWsRe1cAfHMWQyASg5v9vGYB0uKwc4ZWGzFPYYh3uoTy5L4t22rPiZXSrYTIH4Go8DkeB+a6uqXsbM3poDJ98fldxDHBqh0AKRSbS9R5nZVGdtvVh0GQ8tSbhC7CHcY9C9/T+g+KGtgyex1QormrbPJyqS8gqVPfHRZKMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgByRmyMLsy2hJh5MNUELBeSkcGHbv/JZvC7xyM0L5A=;
 b=rLGbMwBgYNmhvckN24nGOoSp/stvJpOIp3taO1PdmehRtjKaAQCZLhxr8zkJfltyF+83ZBPbkIk4yncAP02PEf+r5hWWe4io0qcu2H4XAhTxDq7Ok2elsCZAEnksp/W1Jkj9gxIgSX5zce5CZzZIB15xZmoH/oAlgh3l8gvM2Pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by PH0PR13MB5448.namprd13.prod.outlook.com (2603:10b6:510:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Fri, 9 Sep
 2022 07:40:12 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Fri, 9 Sep 2022
 07:40:12 +0000
Date:   Fri, 9 Sep 2022 09:40:05 +0200
From:   "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
Subject: Re: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Message-ID: <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
References: <20220908164434.122106-1-niklas.soderlund@corigine.com>
 <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
X-ClientProxiedBy: GV3P280CA0071.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::6)
 To DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|PH0PR13MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6e96af-d50d-470a-06f6-08da9236871e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50pRqSqQvaU1oldzQtZSbC+3pLlmDIm9XxxyZFwLy1RE9GqidCkdu+fujBufLc39cB5Dq9MESvMZBpKhve9Dinu/edsfrtIFhHLmGCvzWDs3d54eu3Ce2M167HD2iI6P8zof/xsOwkVn1ym58jnKdfKFZnLxnjx8wpV4qu7XYwRNtO6Gdk7m8QUm7CTrMXVyEKUzxGP0ZMsa1IqJ+VLZIUiLVlx5DfzVnXtoagZNiQkG2vwB5eBb9Vymk7xGfETofaSs0M3ir8VuznpTtW9Fg1s+aO5walywOx4pKVwXA9rn61PleqUUQBc/fHaLCV664Z2k0svL7hd6DU1TpBQK+ghxVfbvGMK39pYssK5tTnR4b7PC+pBERHLKgpLw6ezYl2IHF2ZYWCjRzE/Dof9wF+08TietbHX7/jEZixg7DmWBi60WHFrSEo59a8g396RVMNdrntO8KRPvEfy5Y4w7T4C3sjpyjiIlQj6RoshBK5YVHU0c05v3fzcDtLqsKtDB3pVGM5RCP9CGq119UWAgH2ntqa9Owr1DqkZxVHBIlotb6RFnZ1800UEEFUnLdVNNX6bkbcJUsR6ftQKH5Pgx0xNzZTiDFUflcnCs/OABTZfNacs8n2INuYDNXgZ95kn3HU/s+xfCdh2ODAcbMnOCE6dA8oBqvsMml7DROkT/egKyMtQoMFK4BdDIH8hxqYdxfERR5NTQZbHAoOnPZttmm8ZFpGln7VLd+EPqtmAEf5eQeUei2hQfkdljPntX4WoHCn1ENxbKuqQ9B2V2Zi+4ycfDEiBD5sYAdnyPsTFVqMZIPdPkXNj9X2NSxwj5SHeonPmbM4rpBQxQlFTv+t0X7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(39840400004)(376002)(396003)(53546011)(8676002)(38350700002)(66946007)(6666004)(38100700002)(66476007)(4326008)(86362001)(66556008)(107886003)(316002)(8936002)(2906002)(5660300002)(54906003)(6486002)(6916009)(83380400001)(52116002)(9686003)(26005)(41300700001)(966005)(478600001)(6512007)(6506007)(66574015)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?y2q3kKflniuYDU4cjgJOjB6HCywRHFdr0msoa3TjE3ZkQwXanEXjQku/Ji?=
 =?iso-8859-1?Q?eLsFVHBHtnE60iUbJyPwiDO2oPL63P9ZSIadOLOcp6K+VvDz15Xfb0XxY4?=
 =?iso-8859-1?Q?Y51tiMaRvZIHLPreuDa8Hqidn5xei3X+QmZNq+mm7BKjB2JaQHWcEdIQQ8?=
 =?iso-8859-1?Q?Fmf8OCmDkcZYzdbWEgRxpTq1VgGCsopW2+o0bFjtRQe7Kzh+Ajo5wEI/S9?=
 =?iso-8859-1?Q?2yLix2dc3RT7Db16p51NBWDbXf4pkXgdWhX0VKVLFsc8AnOQef7Mb0qFGs?=
 =?iso-8859-1?Q?IsqNlcBZrZpYtwUqKagvoECJIj9MiGUwhZBBRPwHFFyI0CdbugJyhuRvtp?=
 =?iso-8859-1?Q?Y6fck0/sX6F1z8WQHVM5s84RHELY9oqo//scv1WLDD1gf5qtRoU2vdXMbh?=
 =?iso-8859-1?Q?RaOeLTzudoScsyurTfcwNQ5Jz2rK3F674LLllqqZbh4yg/PxMXU/2gVp6k?=
 =?iso-8859-1?Q?EEXxONgx2Muv5hdFCQn6/IClAmRnn+4U93+1VskxN5cl0hy1nEZD+l/a03?=
 =?iso-8859-1?Q?wQgAc3QILw9suecbappOo+eFlZXtJ38Ylb1dP4T9Y+jfn650eto8CRlrDs?=
 =?iso-8859-1?Q?NJB/xkE17/N7FLUK1zUq7Ew3W3v4R94DxTbEjhMc9f9HGT6MJ5itHJr51j?=
 =?iso-8859-1?Q?pmbJqrkhOkwUfLEUWOpMmEIXbnI9yp9DN/eZ8JwKU7zay+XxHnpy/O5uOQ?=
 =?iso-8859-1?Q?yrkRQndaxbdpWbnAovinjfcvdtTWacGcSmj1DJ9pOeld7gsUCyrgF1AuyY?=
 =?iso-8859-1?Q?EUG0dn3+9Ot4pIPUdH+fyjUIjABJJDvZAvzxxjaQ6a1vSHU+XIOJ7ScN2i?=
 =?iso-8859-1?Q?I25rUs9Q3DsWEeWhJzWmJRvc3UZlnSckcEKc19kHslVZCj6BR8pwSnod+Z?=
 =?iso-8859-1?Q?pCGjS29yaoi3owZZn23pBQEQeigbXRC+/hP8ryXjmYqsA0wKHcNZCx3k/f?=
 =?iso-8859-1?Q?KUTnMGiad4UQE/8uLm5yCJR6em6J1jldT7YDP0DO5Lq+VbuFu13kYeku44?=
 =?iso-8859-1?Q?wsRemk2VxxPbNA0iczF8FlmvsQZ7Npp5koQ/ZF/YWMOuc8MI3ZGlbtNVJh?=
 =?iso-8859-1?Q?Q0Pt7pjO2Vt1Aubt6TD8OILob/H3G9cVxlGlGsfhWvAsJchZgNWG50pJTF?=
 =?iso-8859-1?Q?G/AATl/NQeMOkr9rq4XmeHNFbGxDnTpoXjLXVXWsEvotP82PEG5/kEBhK6?=
 =?iso-8859-1?Q?Q5Au2ORmD1y/K4qPilAFkHMP3ptmoPQV+r709KXaC2czsYX4e2Tz1O1/O8?=
 =?iso-8859-1?Q?Hot0Fz9AcXwiGXN5PDCpMnzweHyW+HWozRbSXen7Z92Y6zPHO4cKGmj0An?=
 =?iso-8859-1?Q?HLIQpC8wYeVcDpGL7KuHW1KvkosDGE9vf+L1QZ8O9iDJG1tEPgTu+rYM4D?=
 =?iso-8859-1?Q?gKA3m8pM4NFHxeXoEtEMkUouA0BHYXWFIBmy5kMRG5xjZXII6IoejIlRmG?=
 =?iso-8859-1?Q?pZ72LbZqUq5SeXwbS+okQFbun5g8Mm+MJb1EUrP61OEey8c8SQ4X6k6iRv?=
 =?iso-8859-1?Q?Uw5Pz6lych+CdN6IKQf59Z4LPyB05Gj3gcxIe2nwkpREYfRIGt3k0uW9yk?=
 =?iso-8859-1?Q?qRLcrTUE5nY81f3fUSr6c+yE7N7eA/m4IMy/aZergTdmkVvMBJ/vKgsHB4?=
 =?iso-8859-1?Q?Ni9epTQktdllfnt5MOw20/twXuDkCBVnIfHOP/gPVRcM2sytXKbQR/pw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5448
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On 2022-09-08 17:49:14 +0000, Philippe Schenker wrote:
> Hi Niklas, 
> 
> Thanks for adding me to cc. I will also add Stephen, as he also sent
> some comments on my submission the exact same problem. I'm supportive of
> your code as it has the nice advantage of suggesting the right format of
> the tag if it might be wrong. However it seems lot of stuff is slightly
> duplicated and lots of lines could be left away simplifying it greatly.
> I don't want to hold anything up anyway so I'm fine with it, but will
> stillleave some comments of things I think should be improved.

I agree the LoC could be reduced, I try to mimic the style from the 
"Check for git id commit length and improperly formed commit 
descriptions" check. As there is some overlap maybe one day someone 
cleverer then me can figure out how to share code between them.

> > +# Check Fixes: styles is correct
> > +               if (!$in_header_lines && $line =~ /^fixes:?/i) {
> 
> I would check all lines that start with fixes, even if there is
> whitespace in front (and then failing later on...)
> 
> if (!$in_header_lines && $line =~ /^\s*fixes:?/i) {

Good point, will do so in v5.

> If we check also the fixes: lines that begin with whitespace this 
> would be a good space to check that we do not want any whitespace in 
> front of Fixes: tag.
> 
> /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {

Ditto.

> > +                               $id_length = 0 if ($orig_commit =~
> > /^[0-9a-f]{12}$/i);
> 
> I suggest we borrow the patter that is also used in "Check for git id
> commit length and improperly formed commit descriptions". This has the
> reason as checking strictly for 12 chars is at the moment right but as
> linux grows 13 chars will eventually come.
> 
> $id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12,40}$/i);

This one bothers me a bit. I did do that before I sent out v1 but 
changed my mind. The reason being that the documentation asks explicitly 
for 12 chars [1]. I have no preference on keeping it strictly 12 or 
allowing anything in the 12 to 40 range, but i do think the check should 
reflect whats in the documentation. If we change this maybe we also need 
to update the documentation?

One argument to keep it strict is that when Linux the need 13 or more 
characters the documentation will need to be updated and it is natural 
that the script to check that the style documented is followed is 
updated at the same time.

1.  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

-- 
Kind Regards,
Niklas Söderlund
