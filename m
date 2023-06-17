Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686477343E3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjFQVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQVQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 17:16:01 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2085.outbound.protection.outlook.com [40.107.135.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB2F3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 14:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giGwP48HkSTR12gbWCidMtp1pZW+0Ql+CuvZflPm/8UFPPasXPJtyKeP76Ma4UoQTIdBPKwTUgPqL5YA05W3AzhRW76IpYSH3K9wnPL0fzwGGaHzc6CVNCge7FnJtJ6PQxXKdoksLmLgfx55YZisDlFGXFDbcN7xA2qt/PoIcay/d5LS5vMHhN3/rWKdnVG5LIFm7nOtvVQlaDxGEVvv8GyBCmyo4wdHMIuVHxurWnyOBLU6aWG+2jlX/mVM2+R2vRil5dPus5KfkY+A3/qiX4FImY3Z11Uxe0aEdtU0nLaPECYnhzPpwc2WhMDM9hIxMKI1BgC0APGNTT3VH6UJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZwuO7wH/mkCs8tdIB2E8z3yZB64i2c3NVkeM3QSqBY=;
 b=esFmypj51YKVD/ETUX/cvEnAyqjiVzxoHCLnhQzvzeIzJGYc8miX3yBIGvaydQyFM26cR0DHA2JAymCBmOUgV4B/4nk1JNhF2TTPhhLK663Zfm+0XpjTGXofx2XS0sZ+1CGVac9YdLMlw3qqPLi/a8yiHLvL6rrAWCks5OwPQRAPgrOCAVxxQLv0mbrndH8dT5IU/hlpeMh1ZomHTwjNwZ/C3mtwXeAk3MJqqlF3rQqNXtP1Efw/eTFVaZrCbxq/Qjobqt05VHpDfJcA03Rigv+TLdK1yZVV8HV8TRVH8eFYpCcJWGPS10lrYvrIGEhDrap1Fx38I5EBRLwzE7xymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZwuO7wH/mkCs8tdIB2E8z3yZB64i2c3NVkeM3QSqBY=;
 b=PU5btvdts4FlZ2u51sDpF69uE42xbVZXl1wEVlV87j/7+tyOP8A+F/IAjZcvvsuz7FVHd5IUj/uf64ThEtD4L+8Ri1lFWzerqHxzhqQpr932jfBjieZ89iIP39qdPnWaTklMk43H+O0+/XJOVViLQqpYgDUYtzN5gzC19zJe5KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:69::5) by
 FR3P281MB1802.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.35; Sat, 17 Jun 2023 21:15:56 +0000
Received: from BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e23b:be0c:420f:11b3]) by BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e23b:be0c:420f:11b3%4]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 21:15:56 +0000
Date:   Sat, 17 Jun 2023 23:15:54 +0200
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/gfp-translate: Fix script after refactoring gfp.h
Message-ID: <20230617211554.gfxgyrxexy7yjv7p@NB142.eckelmann.group>
References: <20230311211329.21385-1-t.scherer@eckelmann.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311211329.21385-1-t.scherer@eckelmann.de>
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:69::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2529:EE_|FR3P281MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afcdd6d-9662-4c8e-12b7-08db6f780a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSI5n10aDnD12Uf1WY8Fr2jNwEuMBtgrm0o3VmA9kITWNNrZ2CFMeXtq9/VoEVXJWtgL+01VnxXnHJAmdxt9RaPr8aC9AM0Bd5K0NSYk/39ztkQJSuoHsWAxWhcyU06OmIgKNX8QL9X61ThXIoj2Yb6vesjbljGE8eDJl4ExWIPK+BDwEjTEgVd98cTTX8gFQ9c2aopf+I2KNTtHJAbtuBhFEqOcNgm53zAqxoOCBCG/OjdfWURBQM3s5yK9v4Z2GlXvffqmY/x2RrlM7nyoS9IjeniZB/Sc4rCZtEo0XRyUGqzLvoejAhAxOWZu5S1ddWq8MW3e6VUA+ms3jsDBtTYZmPB0K5RZF5EF9n4281QT4FhBwUk+U7h9ynVhJgaIQpXWFe0cXJzOX+slpZiRLiI1GXRf5pzhjCEetqwWdZy5RJno7lr1jQwvBF6oNaPDUZaAb9+Wh7d3NQmSIcF0ZSCm7u6YSMsdDUeoLqniZdzTFj7lAN57NQmO3hzSFCGri5YcCwKqGNvDwZtZGTa39+Bo6tBL91izWuXuI9vpmdX2rybgKfguGD9RSu56j3/sO7eEnehYlZeybHVeympdvghJPA87MuZN24p+85m2gfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(451199021)(86362001)(38100700002)(6486002)(478600001)(6506007)(110136005)(8936002)(8676002)(5660300002)(4326008)(66476007)(66556008)(66946007)(316002)(41300700001)(2906002)(83380400001)(26005)(6512007)(1076003)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UOIr6TssJEvF6qR7KNFF/0u6pZmpZcmxdH/YXQDJzc60nD32XBn5wrb+DsZZ?=
 =?us-ascii?Q?2NxRs5A11GzVdfTrPOx3JNG2F4DNElfNYhAl1YDgovTNC9CGmVP6cjgj7xqT?=
 =?us-ascii?Q?YYd3Xo0OdVMDcX3opO8dFcIxc+NzG3xFT6Rwx0Ms1+dS3Udas1smoj22xRNF?=
 =?us-ascii?Q?CneVs/Q21jVmXIpcLoWM6KmppvQsOWFxuYUjZAU/jVhV1+piavrrFG+8VlrT?=
 =?us-ascii?Q?N4TZVyPryaXoX/dVJHKKrngrnW8eUGO8rQTTdg3p04fn3lDTb2izffLLmHcT?=
 =?us-ascii?Q?2MO57TLU/Ei5jUym8pfRvGpS8WOhIQrzeN+wtwUKiC4m0fLvsYvzLheHR/p2?=
 =?us-ascii?Q?bCzi0q4r8HCf50DXflv5ezYyV9GPp4Wt1KIji6HZTQSqG7VeNrGuVplmR0wr?=
 =?us-ascii?Q?fuD9Sd4RLL4wVMmMrP/P0Mai5agLYqJQk1eL64nSvP5gSjdjnknwN0qJ0ngV?=
 =?us-ascii?Q?c7+wey9faSFm/stlglzrRXx56ga9OXhp7TMqeW94I1v9P6c2Lf2s95wUmaAr?=
 =?us-ascii?Q?QNXZNG4nROSyqIakJUYxdHI/C7RFLui3q5JBUM8OJhGElWpWcDA79M2G599Z?=
 =?us-ascii?Q?AHz7kO1ZA2H8kG3AV2que0RaIWTLIv1Dh5V3GlankfULWmHaXx9ZA6xUSLWT?=
 =?us-ascii?Q?ytdgQo3ymuTlFIFBsGlGaljlP6GtuptUdEVmbgCGP7HdXYk1WjuaQAaG+Pry?=
 =?us-ascii?Q?koNt4BsCmfhlbmV+rTstx161lIDm7t2haygFQkcNznnk6yegAMw6oomYq6Wc?=
 =?us-ascii?Q?m5svfBFLzy9Jd1Zm63syt9j0gd0zoTUZDqKLR0usE6z9GaAIFMud4HHeGjV+?=
 =?us-ascii?Q?/R0rw69yoFHgXa83PGOxQ7BtsvPwvZdjde4FQb5HzjZPnJgpEiEPdSg5i/26?=
 =?us-ascii?Q?sr92es0SFKdRd0DMXRntgVCt3Fc/jyOFKuhYIp0TmmYENKTSmHiH+L5iK543?=
 =?us-ascii?Q?V7yzpXWcRZeRffDsU9mlKL80/Rd1aflj2+sWKGDxpgjy7cpulZDWH2vhTSEj?=
 =?us-ascii?Q?kH/WyNMWlFHNzitvDkpiZrwQCtmON5u9uacJnVaengKy9ekSbSdcm33u3Kr/?=
 =?us-ascii?Q?YiiBlSy7aCBo+BRi1vobK5O/cErQWWdJsEzgV2cLAC+hfM5HIn12FC755nU/?=
 =?us-ascii?Q?ZgoP60Fs3bm/QB/IGhmwF1GSYaLEewLn45em19hBGbmsVb8u/7yMLvFMZ85v?=
 =?us-ascii?Q?g1eWNjYVwuzgOmC5cyGhfy5mU2cHYANdP7Wg9IR9Q2jWlrCZ7h8GY8xSQn2o?=
 =?us-ascii?Q?uE08f8/nGGqw9anJX3+UW3y3mifIrBUin/TX4GObg5tIbvYeXzyk3br2znl5?=
 =?us-ascii?Q?6a7sQ3mIy7RqngmUQORJWzwiaiMW/0/2H6ULmNk+0gz7X6cZdGOcXkOBDOy3?=
 =?us-ascii?Q?+Uye2hKQPTWi1MiazeJA1tchuqsNTjDqVIZhueHxDN/ktasDwIlL1qCr89rf?=
 =?us-ascii?Q?WJ9CaOF8fct/EL8edjg4POcMAK6SsEPbc8j1NfgHvt7We55f9LrYYL/KtMKn?=
 =?us-ascii?Q?2o0Ab9sN/dg0ScbgxX6XtDlRG+Ty6f8ec+k7EpF0LG2k8VbquMkTLBVNgV6j?=
 =?us-ascii?Q?vhc+t6HymG11FgpTmijrFyHcxmJNFMzrj0H+xrKvV7le8IbugxARj1Tje0gv?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afcdd6d-9662-4c8e-12b7-08db6f780a2d
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 21:15:56.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn6xKZLnLl6pXpn32D5dBKUfqVy1nfDw2mG4lMo9kMmpv1f0cMF32yUVNSx1tSMCPZCXtqZSdE8rVWO37gtsog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

On Sat, Mar 11, 2023 at 10:13:28PM +0100, Thorsten Scherer wrote:
> Splitting gfp_types.h out of gfp.h broke the script.  Fix it.
> 
> Fixes: cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
> Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> ---
>  scripts/gfp-translate | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/gfp-translate b/scripts/gfp-translate
> index b2ce416d944b..6c9aed17cf56 100755
> --- a/scripts/gfp-translate
> +++ b/scripts/gfp-translate
> @@ -63,11 +63,11 @@ fi
>  
>  # Extract GFP flags from the kernel source
>  TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
> -grep -q ___GFP $SOURCE/include/linux/gfp.h
> +grep -q ___GFP $SOURCE/include/linux/gfp_types.h
>  if [ $? -eq 0 ]; then
> -	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
> +	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
>  else
> -	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
> +	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
>  fi
>  
>  # Parse the flags
> -- 
> 2.38.0
> 

Best regards
tsc
