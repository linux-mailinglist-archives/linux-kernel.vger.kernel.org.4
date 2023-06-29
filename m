Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6CF742E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjF2UGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:06:03 -0400
Received: from mail-mw2nam10on2127.outbound.protection.outlook.com ([40.107.94.127]:64769
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232432AbjF2UFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMwdGchk+R08pDZ6qdfmH/8Gnh+EvHJ2ZSrGrpDMIvGXN/j48CWABhCCLbHwpksBCDK+BEfPPvRw2i4metVyy+0psjoVJyAbmsZRqmQ75qC+LWNfuSjmhC2rM64yhe/AKfII74tLE9acr5VnrEILfRXmK2c3eK1mVSPBKOG+pXFSO5vCdzpI6blxN/3aLcm1pqQsEAPtmvgvhSUzHBjSqpa2asl4UkKEkJVlz64HqBgzLd4g2JGnn8TWMfRldqOYTfQa+HeXXrrjFynn20RASGw/DYTwExIIR/CAyBXPP+1yh/BbTruTmFu56Hh7DHgAnX1SADCuK5NNX6VzsZCu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKT5oapl6jiuKbRC+9aBRTxArFEsW6KOdcrgA4sXHSo=;
 b=Ph3h7OwDd7ZE+hSqo+T3ZGb1Yr/ASX8++fp2dp+UDjMDf7qowf/Kylo9EUG/P6+IOcRF6n8YxCgJChdQB1qEXycaJLTervI+EOj0DawIhLFcjmPPQ6NgjC6icVu9mUNUf/qMu+GSJ363XJBbTFRw6pQgJjrKawCLpfbdwRP6Ws4m+NLuIfUPcalg3M/LKA/BOurqNXTLSEYZ/E0auk38DxqqVm0slXKeIf9PeS+EaV4jLouvCS/Afnhb0ZnMHyBBIyLIC7NsAV45+g87ueBVQPNqlsT9Pfsc8xTcNvciTq6xOR2QJw8vRfTR/1M4/45wwUbvWCLJLAfApmOt77rGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKT5oapl6jiuKbRC+9aBRTxArFEsW6KOdcrgA4sXHSo=;
 b=eUaldwwWFD+zuhU2C69ClXnwIAvQMFwvjHaLUOTAClqrejUcwt3UqE6olA5QcyEAP6ArvOCDFTz47bVxZWe3/cVtNAtfjcZhrydvf3VUdHP+WkniGW/HO9uwDMHjoawu4VKTFl5MC9ZLDxNSxPjA/K0VLeqI2vJpQir6ZucY7/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5709.namprd13.prod.outlook.com (2603:10b6:806:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 29 Jun
 2023 20:05:53 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 20:05:52 +0000
Date:   Thu, 29 Jun 2023 22:05:47 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v3] wifi: ray_cs: Replace the ternary conditional
 operator with min()
Message-ID: <ZJ3kG7CSWSGw1Ql2@corigine.com>
References: <20230627043151.19576-1-youkangren@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627043151.19576-1-youkangren@vivo.com>
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1fb1d6-260a-48cb-a302-08db78dc3dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UELD2PsLZAA5BtmvUwOEqd0E4ehYGr7LY2eXU1K1FzP3q5LGaj3/hTnBSoiTCr6RiA0EXKUOSIyL5Hs64irFbMvXlnz9UsZzj7nW9n1E3Hucl5vnulv1XYWQLhzqAmqaIsFZtOQA3+sifIk5fNAAj4xCfeGG0M1wqZzKji3NFPuxZr+SrlSNYwQeOC+tEkrD7ux07TFVjOZ5eSr645PMT0WPTTRUdjjt7TroqEiyzrLwTO2E3KHjMg2Eh141gChY9KfFnkGim6FjZC0rPt/vJn1d7irJZy9BdwrAKZ3yqnmRPBJny5jfJFgEVcXCIFi/RuH9S2PzIN9T/HEPu1p/usMA44w3yzShRxRZZXAi6xszvIUaJkR/qerSjLv6ZLcPBPuPjZROvkyJeb50kLpQeipbaJ6JzYVjlcSE+pz6Mdo9Ueg1iSj2AuNowtZQKdgFIjOz25cQ/o40RzJirc8wiG6tXWqXrAn3BSKgEI5yzhEvWyBWmELJn7VV2HwlV4jOyx5q4TA6NN3AQukmM1/iBzGEfjAh8k7X/DnnvjHlb0UZ3Dbf28CAHwQIiQ+8ce2PYMJ6b+BPh6PIrQHXnZwCUsgUZ9Wq8viCPXg+pM6Mju8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(366004)(376002)(396003)(136003)(451199021)(6512007)(44832011)(6506007)(66476007)(8676002)(8936002)(5660300002)(186003)(86362001)(4326008)(2906002)(4744005)(36756003)(83380400001)(41300700001)(6666004)(316002)(66946007)(478600001)(54906003)(2616005)(38100700002)(6916009)(66556008)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90MoqDgUhpj3w2dChPR4BXNQxd/iusA/cSU7KHWD7P3Lj8v1QxNc01BJ7I1B?=
 =?us-ascii?Q?PGtgPd2NpVroiSUM8EBh5UUUxkBoJyehaw68IptryAA8WjFhhvaGXxS3Pv60?=
 =?us-ascii?Q?ja/eQqQFZrKNlIEUwp5/D+cYRtX7Kkqe52QoBNPpBQ3QGohZaUvJIOVjdftn?=
 =?us-ascii?Q?PXkxnqzrpGKgs/fK6IxksFtlwGk4EAA0TgPM77WBRDYoC9iFj4FUm/DuKsju?=
 =?us-ascii?Q?FzSKfU+nMN0qT3fdlfkHCf2S8/eJf4Ys9OHXODQDyMfELew3WUjLoDA18kb5?=
 =?us-ascii?Q?YRAkovRFaXrdT4NlGqTdu+TYiHRwJODf/NNvy5NUq5yLkcj+9GUvbGzwuh0e?=
 =?us-ascii?Q?oAUW4d7RLBcZj8tT6AVI9svfAo0MeJKlDdkabPh8AsACspefxGRfjO3xD0S9?=
 =?us-ascii?Q?+G52F3+xxAUDeTUkQ/Tot7keAi9yMlYppx+2p7r3JODWI++Jz4OXf6zndH9z?=
 =?us-ascii?Q?FxQghLSM6VzL+x5oz3Y+kHs5p6jDyAUY7okx1hlH5ELPFjlxUxvQ6CdZaBWw?=
 =?us-ascii?Q?S3H6IWTA2EeUnuHzSe++K0d1gB5l3qnfLXJbndQqrsxaWE6Dz66QvW/MSSxU?=
 =?us-ascii?Q?gm2jJZ1eXyC4KGa/OrHbdfukxs7UkGNdfgeCnclV6cMw0jPQiHh3jLoZzdmR?=
 =?us-ascii?Q?zvHVzHbZKYaaxq6ui+OLgq6WpUY7s5a8WmH6FJC+ZIjMoNQwKdXOAvS0tZdB?=
 =?us-ascii?Q?ZP1wm+68axMIve1qQaOc6Lgqx2CgkthurPD2n7EFVKDyl0vhUmEZhPPRRTUB?=
 =?us-ascii?Q?jfX+15Nu1gihZMYoS3Aws41aDDgcx3JjcYV0H4tuIQe7+bGv/74yYfwx9Mee?=
 =?us-ascii?Q?hPmI6wkz231B2Ugn0vAMlVGueeghi0Nab9dtOxXlE8hX1hAoD3IJvAms2run?=
 =?us-ascii?Q?GAv1Fv+MDOYDlZcRDrD0lQQurTZSJgTJSnZB7mEpbzZv77fUnYPnStssBUDA?=
 =?us-ascii?Q?2KDHwwQEzT4XWZ9sBWvwkYL7OhlVKttle7zZwKN3P183+qY1BK+1fW1gYHAu?=
 =?us-ascii?Q?AArDXzcRidclX5O/NaV1vsTeCesGygWU7KW9CsToT7OsVOq9vIEUgUUjkCgU?=
 =?us-ascii?Q?6g/0Q0hjjlOrL/2Zb8GJkzBqeLEhgCCggoeLL0Q5UVBuzOU+EEqQ6DXmUYAk?=
 =?us-ascii?Q?YcmOsfqPbd7T6lK9OqqCdip+j1WqyHllME8eoPawWF/S4wBbjPXO8DXE5GGq?=
 =?us-ascii?Q?KVGaKJvPPUI6Z9jfe1MulJ3KY+0KwrCAMzJr0ZmlUfgKZQQRkRoDZP2rkr8q?=
 =?us-ascii?Q?0/b7+dABD0Xxm9jkf+wUhpYaA71DJn7vwBzWppqglcQjH10E0FDF4MvDus7U?=
 =?us-ascii?Q?KWyX4DL5mzY/ZNe+oQzw6H/OwYhu+YdQa+1YD5CGFSqGqYb8Gxkew2yupIf5?=
 =?us-ascii?Q?YhCfISfiFGDjiYA4QHECqnQuZjkJNVJDbGR3WMTUxN9L0K732PW87ojT5snw?=
 =?us-ascii?Q?qGP8WlWxJiAhy2lXdqRQrLL7pu0E4TZVk8Dqcfc/SXbSUIYiHw0VmnkNp5u+?=
 =?us-ascii?Q?zUmR4NOHYSQNHnadxDOnzsLxcOdujuKigQTRzIBXPJwqQ7yWZ9W5q6uXvlrK?=
 =?us-ascii?Q?ArWxImSSdrfd4WdzyaZLikHIyV9VTwfEX5a+UEZoKZuXSyK4hLvpT47cLwEf?=
 =?us-ascii?Q?wuKcdsAXeNAO1GyB/rwvCx42fhzpJ/F5RJgfEtAx8ykaJhTeCMygqli7U7BY?=
 =?us-ascii?Q?V58ZSA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1fb1d6-260a-48cb-a302-08db78dc3dcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 20:05:52.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki2xG9gxuGSMA1A4q6k9M6ppUztA0EKO4YUENCHAxknHMdF2z+xKYUEpcDVOFeIWyvLgsno8ruqxN51/rESFh7DB1btNquo9RpWIkqZ9Yu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5709
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:31:48PM +0800, You Kangren wrote:
> Replace the ternary conditional operator with min_t() to simplify the code
> 
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/net/wireless/legacy/ray_cs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
> index 8ace797ce951..25edbc655738 100644
> --- a/drivers/net/wireless/legacy/ray_cs.c
> +++ b/drivers/net/wireless/legacy/ray_cs.c
> @@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
>  			rx_data(dev, prcs, pkt_addr, rx_len);
>  
>  		copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
> -				  rx_len < sizeof(struct beacon_rx) ?
> -				  rx_len : sizeof(struct beacon_rx));
> +				  min_t(size_t, rx_len, sizeof(struct beacon_rx));

Hi You Kangen,

unfortunately this patch doesn't seem to compile.
