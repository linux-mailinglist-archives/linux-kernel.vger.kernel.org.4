Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F9261F7A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiKGP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiKGP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:29:42 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0FD1E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:29:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwTqhltdFLCNjaXeTy9HV5bY5YYmUYgPCtmXB2fSlLbwN+9oTm0MDavPGbWFUkRuybBS7zcImgltq+Cp9kOP3RZI7fQQI9OpGd1XTWQEYwjYzTPTgMskWed+GUtCEZeR9G6ynsyJ1+RXxR8UVNdSyOa/g/PRmc63E8Mxd+hdE1EeHzcN63ckDyXcJmw7tsihjedMm0jrwaMPEr6XL8aFtO4L+ys7bvOMW9XCebSJQu9nzkA1uHdeqi1Gr28tzRAmwG0M3eItWCC9glVbtigob0W4FhKnfP29kW5GpgTYQtqZUXDrWhdDge1tN5GImtpiAc5DRiLJlF4uwMH15QqLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytNqvcxDarMIAEN063RTlEZ44MToQvp6XARbhUnrSTQ=;
 b=bZomZHEEBvT6LDVw9JO7fLDm/w0z6vVGt8tw8zibTpsTiDYSNFcMi0H7vWhxLwjr36pZx9q3Obx23EqDl5swhNDVMv07mFmrfSrmcOvHOLnfluIFhKfgsQQs59Vg23DRBXdh0BrwuqIDkxflBVJLgo+l74QNbM82RDXdVzQZTINfZeGV8G15/pu7fFJGYdSGlR+cohzCIUWIHtI+6wYDk64WiD+KBcKjVc4ac8t+DIm+C9xOLi/GWwCRRrhl9IhmJn1ged06FurGDdTkK9rSGduNxYKSzZ04jR+SbFi/HlCHPrKJey5Y5XESn0lBrpizfjnCrqQ1W5og1iyPAZyhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytNqvcxDarMIAEN063RTlEZ44MToQvp6XARbhUnrSTQ=;
 b=YYFr73wVlKIUJ8RJ4AW/UXAetsR6cQVjlNOimeCmCL12CMldipy1cF3hBAoTGcRBiwIKQrCULxHJdLn6z+ft7fHzmFy/n+Qd1oa3NEFKUuksTnPNZjwWKBNgUrqtZDVvW6JG9wt8IZvq30EmZ4RkKzKJxsWDLquVWF1jJevziAwZlKRuG6X7HZqru43eV1+1lbqM6TdKY5LaTzsAHYX46qSkjt2BIgQpcAF3hyutaKsHb49ehs3Z975rsWBYfWk+EQfREgZf3Z2NF9w50AuVrrqYX4K47+p4yVZdnM0CUAGTFsGpg/z3yix91KfeNCMO0HRy0z1fFp8oHAf0sbaVvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 15:29:34 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a4c7:f211:6464:4dbe]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a4c7:f211:6464:4dbe%7]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 15:29:34 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] migrate: convert unmap_and_move() to use folios
Date:   Mon, 07 Nov 2022 10:29:31 -0500
X-Mailer: MailMate (1.14r5922)
Message-ID: <E63CC007-672D-4647-ADF7-5A846C87D0B1@nvidia.com>
In-Reply-To: <20221104083020.155835-2-ying.huang@intel.com>
References: <20221104083020.155835-1-ying.huang@intel.com>
 <20221104083020.155835-2-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BEE87516-9FFC-403B-813C-1E15493DCFB5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0956b7c8-f0e5-433c-277c-08dac0d4df43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kvdes2VHyzBoJncLaOb9e9i5ST1X/Axoa2d0ukD5qJSm/Cfxxb3t1mMnnc7THOQQ9xjP5oVTjxFE5jrVUQBKPtsvLLUCDbRoC/L+PwZ0/u0xzub+8sVMrvXM1iBBJEwSu57/dl/6SmTqtJMkJwxKUiO/u7A/xdVQEYLAzWmNlcR3+tYG1BTURNjzQuV1wYS+e6UO3k9uYNZ/d+s9TxepR6PSKjLCtvcXGbQh7kKMgyREHgoA8Zf4/Yz4d6+vxMaDGiyNzBpkO7wa+wIzmNu/T60GHrYfc5rZLUgLQ9kcLZkitrB2aEc/GZ6GbqPFfG0gQCjELqixep5w8B8Ii788G3CIWbyPQEB9DAP9snZug+f5X3qclzC61A8h8L5lDsABZ0nyeJG7tWtC43Zh3sfvkgQpi36XQ38+Gb6i/rTBpYMpF45xRxeshO8toBzw28Kf3kCd5uP9Wb4IX37BUa1u1NPkMExW9pR+EQqn9OMPcrxbTRritCELP7skZ2XD/pgjHczrcabbHaDJw16yhKPigWnYDTx37XAob0VdHX+finGxftLYftfQSwM8Q5JTguSsQXRvJv8TVfJ35LinW8QN/anO9vgmyEhBfGxGnCKeKotaurMWn2cXl6A8s6h0BoiKoNndOWILLaZ88MaSAdH/Sv5ftiF4i4EhxPOiGtETwyl3FQQ8jF24KYBVxBV3rmbDu1WbRdUFQs7xsbl5whRZe4julIIQGREqqOZ8se+h4o4lwxds0e+FKouoOZQAhOpJXs9vAbStxtMknietufet/sskp1YKA9HOUYWcR7JPgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(41300700001)(36756003)(54906003)(2906002)(316002)(6666004)(5660300002)(4326008)(235185007)(6916009)(66556008)(38100700002)(66476007)(66946007)(8676002)(33656002)(86362001)(6512007)(478600001)(8936002)(6506007)(26005)(2616005)(83380400001)(186003)(6486002)(53546011)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PeckFwRkKzwuUWW0sggkuFsX4rA02g8ZpQNcn5KVTsw1x4+OAEll6QCyRc/h?=
 =?us-ascii?Q?8SqsMEWUU5Tma7SnKBDwdzBh6VMiV9AxOmJEZ/AGRuiWo9wQJS2AdbgLCiX9?=
 =?us-ascii?Q?Pa4cZsS+wSwKCqip0cwwBYQ3ABh3gfxHWkC97Qy+N5H05a1zKjp6JmtSUHjo?=
 =?us-ascii?Q?SfjhZ6iU2vNNpGyza2IDEvNdYgD1rrzwOqXopZsvUQxp7irgI7VaQA46j3Mg?=
 =?us-ascii?Q?VrltyOmR8QbXITy+xbONABpjjxrjmmtt8XzKmXcKx1gHh1AkRfSMBzQWNQh8?=
 =?us-ascii?Q?U5LhsKLyGfMlGp/6uwgVUnRVfALGIPS+3O8ITRwCN1JKOQMU0eRJ8X4QRlOC?=
 =?us-ascii?Q?0wP68MYEWX6/rSgMZaMOS9aWab1A/cv07zfYWHF2t+eXRqQzDdc1yJd2FNyu?=
 =?us-ascii?Q?swGg+cMeVc0dXzXfegmaDrJKNm8h8p9YPrd4lfrktJd64H+RwB2hYkUprGIs?=
 =?us-ascii?Q?FdTnVd4QHPXqVIysb8MAlOGQjBT97JZtQxPaKgauBdJbKSn1sDHXZp1am5hT?=
 =?us-ascii?Q?GzPwaiNQv3m/SADH0CLbAQLQxKfoiiNLQnOTAc6VvfbtZWvV4fdlswQqdEf5?=
 =?us-ascii?Q?Aj1Adr4+wck0awDxkqxqyKq7x/8afXeJ4s6/ogMmMPYT0fv7tl9Q70hMsVc4?=
 =?us-ascii?Q?9RznYxiUwOBuISYPYOYyMYYnOzZffz8egY1kXsgHMNjrEEqbym++D3cjaKPp?=
 =?us-ascii?Q?9sTgIsHE6qryfnbBgr78BZsItlp+AEkYXb5vxyH+l4pjjvXDkFxZ3DcJtlBv?=
 =?us-ascii?Q?IbrTO7gFwUdEV3+vIFXOkaFYb5GBSsc3eMQG/bqQM+VQZXlC53m69dSpLNCh?=
 =?us-ascii?Q?xwPDcrqXP9ByHfy6tAhY2KZUqhhipOfOYb++xu8lXD2v71WSmzVA8VSK0Yvb?=
 =?us-ascii?Q?He0XYDvHO8U39luc5m4FnHef+8pJ4ReuaQxQkX5zHVaWXhzaT7rRBPv0s0YY?=
 =?us-ascii?Q?BBKOTyU+ed3TWtoyKhMrWjguJdnPp7qmRqeAtKQWM7kDJc60gPSYTnyBmyjm?=
 =?us-ascii?Q?gWsW0P1NuZaniC/8sKzNhTkI2jcGV930E0cOzK54ylouDtwaJr9/mldL2tFz?=
 =?us-ascii?Q?1nezaX9I9qZMcYuZNU5m3kicotqbSnmeD15iGjtR6BzaqWhcoVfZM1yFNHhi?=
 =?us-ascii?Q?tbyi+cxiKlpT66W2RVv983gK2vSj2hJUp6YWh8yKk8qmdmUhUMl2061caUTl?=
 =?us-ascii?Q?/fsWN/mVYBCpiuEs+Z7CnX0pqR7yCSxY0ksD7Pr3sGj3kd87+KqMpXCjctTP?=
 =?us-ascii?Q?tIpBNtw3w7eZzWyT/92BI5dSC6IVkj7F5AogGw4OGHPdb9ChCza7M3oB0zCG?=
 =?us-ascii?Q?9gzN+3VZnVCq16tLm4PN3CbWlcCf36cNAXgZkIQt+zvmbZwGHphJhngPTNMw?=
 =?us-ascii?Q?mGMKdbctw8koel2OcgZ7TpCnesVgPu9f+Tl9WXWXJ8B0h2aKTusBKAKtsZVO?=
 =?us-ascii?Q?wS9cRx5V8liPe/lzRSDxIfybOiY5qnneQgjE4PtxiAjW0ZiymVVLf5nFo94G?=
 =?us-ascii?Q?9vFZsFTrOIHwQnam9aPUD5+Fx1WMhpKRr8QjjnRawVz1yk5vY3+/0Wn6hqlN?=
 =?us-ascii?Q?XMDwYmGdnBoypkKsiK4VGc4vAVqI8l1J8t/uVSgn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0956b7c8-f0e5-433c-277c-08dac0d4df43
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 15:29:33.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ngw2r+VZd3aCfQ0bB3L655wdS3VfXYJZN94tvcz4I8dOqFZpJqsm/oIYdiOZv2iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_BEE87516-9FFC-403B-813C-1E15493DCFB5_=
Content-Type: text/plain

On 4 Nov 2022, at 4:30, Huang Ying wrote:

> Quite straightforward, the page functions are converted to
> corresponding folio functions.  Same for comments.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_BEE87516-9FFC-403B-813C-1E15493DCFB5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmNpJFsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUaH4P/A4x9XefwTjF2/6MkisMSGvveHAqkKKgnE4c
07e5l7NbtDcrFfSgzTgHrEqfbNkf9uaVt+Cv9jlUA3zPtEfVDcWMirCqZdyEELN9
CisI6WhBhPscj3zQRfVlqL5NQVm1vq40iAJlUOsD453U7jfKEm4QFOqZK/6SLPLn
6TEHw4ecuWSLxwdvooyrYsqXEpcEfmi+IPvazf3HINoQfzeYB8GU+pw7CIorrpQ6
bQNjX1+i1M5qVy9ena9zgsR0sSX+HVoZ8w8PlxiUeJO6A4b6gv5DK0IfiQB/hGuC
PX6dLldOQT2iALJmDGNQ5pLwTdGPMdsVYkbWgIs+yQiT/rNCXKhHGlPA9mLoKBJU
aK6/+bOx7yysoO1nVcQuLzK/LsHZ48AuGCc9ThrQnOGKfgloqQg0sCj52bQMKYWO
85d5H6ns3x+74KMNweP57RY/CJBrpHgRUSdy2qX4HSv0y+dhnug+N5cg+t0MF5i+
shgvZGqzGrqNv1B5+fVOF/1tl4TQg2XsquYZbmtChlsYVfE/uVPEbfC6QY2MdCJb
bVN6mp0wowKZ3ENnotvAp94bAdzysqj9LOngvXZ8RgY4RMSyxIcRDjbMIVaUcnyB
nNVBY4kWUl6CBgtAZP1s/ILibD+px1xI7gIyXt6K5QJjs8jks6CfybCIrXSeGXJI
QaR3F8ry
=wC8j
-----END PGP SIGNATURE-----

--=_MailMate_BEE87516-9FFC-403B-813C-1E15493DCFB5_=--
