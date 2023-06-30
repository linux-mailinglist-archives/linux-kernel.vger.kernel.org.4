Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46780743CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjF3N3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3N3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:29:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6506B170E;
        Fri, 30 Jun 2023 06:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dntjOS3vo6AtsS62A0cIYhlCVR3BkGvUXvsgzs3gmz6KpwzWy5cfR7Ke8FaQfE3PymNqFaeFmteBJjcM4tsoqec7Ln+q86wzRGBug3gTsrVC0k+JK02EA6phx90sXV51GbdXd79993BTN3wrAuWpmOzjn0gHb/+O0wuW9su/BhP5uW7pvKxQtrdw9VrULV7iLrnMq1FgJKds+/l5tentJV1eVpRM12CZ4YeWuFVGJSh5G5P2Q7eZy46Rz6Y7Ps4YBHZLuf2CKe7AC+LTDMDYh0H7UoaEAtqRWVYpaivcGfto4tz/lsxaboK7Nq8NtDFKs9GRtLtQyokCDAyaAbwjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAB7sIDgzQe7EhV78Alk29UXC8OSsbgPwvJ+50MCzYs=;
 b=jf4ZxJ4NGLbzC69EeNz96nrnz0pgtwu4TyUG6R4wJoIGl+5DTcUiRls6EGXoDunCmbZ3TnpGhqgGuevksrgAB3+lm4ycQsi06/awWAR3BXe5d7zNQQ83+SucCoI4ayZyY2yUrvpEUoaHi/zQcL3nCPAgq4Eq17TRwqOnCaS4Gw7KUzyVb4ojKo4a3jS4y1D7cC/KNOharZqfscYwGXIqq7bUlPKdcZNjOQLNNQAwNclgl23XCQGeBsvueQwFqhA9zMX03W9KqK2xHWRK3QRwfY4As75mss8kfcUceCzjqmPo+MDJ4dtZcPk9IloSRsipP8t10XIS7fFfnyhKy4FnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAB7sIDgzQe7EhV78Alk29UXC8OSsbgPwvJ+50MCzYs=;
 b=WsmbZ/hGzzJFVSUnb7oMfLbw+A58mVf5QiSW0DB/McNuASXZ7YZYERmKmSnEzTlDBrLCPsbi8jy8QOjZbZ3mCllRL/Zbc35RMLBuuGgPJ6nePcLuGfmU8KjhxUxPnIWKpRx5/gd7DqQPCev3BnXBpKA2pepFXtRgghItz9jsCrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3768.namprd13.prod.outlook.com (2603:10b6:610:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:29:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:29:31 +0000
Date:   Fri, 30 Jun 2023 15:29:25 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: tag_sja1105: fix MAC DA patching from
 meta frames
Message-ID: <ZJ7YtXGLZDuV+az1@corigine.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
 <20230629141453.1112919-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629141453.1112919-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3768:EE_
X-MS-Office365-Filtering-Correlation-Id: b1743f72-3ace-4b9d-d40b-08db796e097e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sP31QXd9ivrVpJTQ00wkEZhZBE+1UcYEtW2GIDXWseb79ORDtga/wcgSmalDBUx+Q7ZzY7mH1+RkpdiJ9HS1jm7lm49IlZxcG8WRuA/jhaS852wqPTMc+a33ze4W/CKWrRQa63mg4uJJJtTxG3iR3z9uXpY4pbr7O0idR9sKeI510qXkeMLwszwXaqrkkrMNkRo2iC0W8YLjfJSBj3vI8DI/duLfTjmkFPI7lvDi+9JiWL0+B9dWfwxOqUWtnPbx1WKZpbYGt7Vqh4zG0jdXVawE8URfwrYS2Zgml+hLDbBNS7K4vx/b++xCS9iy6cv86tWh2ugZNuXWSAsow1XJp1IUzRsLcarPZpkNgb3FYVWM4UGRFJVPF9RRc6YbF90bmvkfDI9/DKVBWAZOxDyaPESJx7E7Uv2wIG4v3hZK9oktbSxK6g9g5ZfA6+dE6TnSRIy6axf6QLpkzH9yL5/aEtuYgWYNwTPrG1MvlPyqKcQqiz9v4RXpa42j5u+EpojMXyrW0IUZ7ACtC8g0J088rwR0swd6hXVq+/xsE3rAK8WJUrXygF8zZ/sq3h2Xyv3BGeDuh6vr6POwFx+FXhnu/wgAOVrMyZ9zl6R9zIZfHIB3w4Q4OfnMH+Hwvo+DrE6ig+O/BvxBgjZext0kU8uiVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(136003)(376002)(366004)(396003)(451199021)(6486002)(6666004)(44832011)(8936002)(8676002)(478600001)(5660300002)(86362001)(41300700001)(316002)(6916009)(4326008)(54906003)(66556008)(66476007)(66946007)(2906002)(4744005)(186003)(6512007)(6506007)(2616005)(38100700002)(36756003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3SH0cBneBYAwcxsuaCuPtHVLfc4OLQiuCWsr/ygGe3LCrah5OKDgpX4Edy6?=
 =?us-ascii?Q?RcDscR4Itm2+B4iS4FdDLZySzHW3iY70Xmm1RRvvIFEXDEjLIm8hQuDrg6BX?=
 =?us-ascii?Q?NsyVYanYYcuLBw2R+Arx3upUMrKtIFmshgOn/7yNs/6lHCQF+/sF2ofF5wWK?=
 =?us-ascii?Q?e39plKcmAs7izN/rlHGkv9OrR3eojLWwnRMiGhQaiCy0NU7jA1O3uWB3jn5A?=
 =?us-ascii?Q?xLQVWRem4gUZq3e3B81K8+rW1EtiZIEzb22jYglK00yN7Mg/YEnjhpCmOnTA?=
 =?us-ascii?Q?qyN6Luxvho3zM+zl22GDakC9XxzD19l/l49PfDd6gQ/Xw1hyt1Uc9tHL/nMt?=
 =?us-ascii?Q?vc/5i3knmII8lHP7dCd0509YD79Dz6DLPNBsSL86VzUaVFpHOy6xXrUwd1cY?=
 =?us-ascii?Q?kzU6WdNsD8rVKCvs6GozzGmxk5H//PWL3eFFSyioSaxumlGgpjo5ITduzR9P?=
 =?us-ascii?Q?BzrxfAl/28RXIOr1bMbpUYVh4iX1ZI8ABAd9nEpzE0VvjQ+Y7SZN7f+EoYpq?=
 =?us-ascii?Q?a7bUdr5JhTaD6zW9mAw1ZOJg46misNOUeE/DuDInCPn1OH9D/28Z2bowAa9R?=
 =?us-ascii?Q?ZLqXBI+kusM4EFs5KOpsTnhnwqeD4ENQSbcWYxa+/seAynrBh2dJjIY3k3C3?=
 =?us-ascii?Q?Q0e5yV3QhhfyC5YTMRig12yyPZ0Lwz0mi6JR1u3dQ3oiedRyxnLf1BewQup9?=
 =?us-ascii?Q?+J4sXdE93wMvztheyWH4GY/pcf/r0ETjK30K+NwDG72G1Dz9yTqJ96lNgV4t?=
 =?us-ascii?Q?y16azea9It2Gea6z4teaN9YQMjAzXV+vMNfDNHcLRQ92E0n49GdyLDl42DJo?=
 =?us-ascii?Q?z7Q/ImKuV+zbM74Hs5TL8x1L7mWbwujetTO3/r2PiGFM3e69P8tnQsNIrrjo?=
 =?us-ascii?Q?82FxTKrg5QB208/PT/Ort9Vooa9zFqQO4p4NwfvpjeYrKODiDNihU4MmX5/i?=
 =?us-ascii?Q?9K0+AVajS/qAJUoFMVFjD43wCDZYRvQXm9XCMegusPVv/0XIdX607wBlpjRG?=
 =?us-ascii?Q?YP/yCTQW3p008P8UfN4/2M2B8DVMIFRBKzFmfRcROlweeCmm/BHMi7UObQYY?=
 =?us-ascii?Q?68p2ZYDfVLDRcrV3HQOa9FD1wx+KySEBNOJo3OBk0g6dhzlTnqwrBAvWW8qH?=
 =?us-ascii?Q?H2Pkp/88xTwtASZiUEgpO4SiKwD+5Tt1hpSv02faz4iJYR+l1WBzX714Gqpw?=
 =?us-ascii?Q?KsU5emSxjW72OqId7mQxJ+HTeGDQ9B15xkPrbVEAsMRGqnPnkHQHyk0dJc0r?=
 =?us-ascii?Q?PCDxnhof7wGoOVmW6QKs18dplf0vwckzwwSDIKMjYPX+Hcb8SCrSKJs7w1sj?=
 =?us-ascii?Q?+OATD8E79QpYwl92QwPq3aiySjIcAVUhAIO/KYwwMnHV0rKev2uT3h+VGUrq?=
 =?us-ascii?Q?asKoo2tZ6aNNQl8fyi0QsZnGpTsztCbo9hvY38sb95gC3hvHaRCn6KVMY7xY?=
 =?us-ascii?Q?aPs+kazzozRNLecWHVstWYsOHu7vvYV+7uMSBnl86ScKEnAD0xJ5EwSj2O6c?=
 =?us-ascii?Q?2x8dE8jj3L/VijjTZwpX8TBiD5cIPB5tP1QUoAVFNn7sieXmFOYWdrdKXF8Y?=
 =?us-ascii?Q?2sumNw9nbfvigjypj+JhiEV3q/alFihn9YYWm29QcaQv6jZr7HsnE5lWVbx1?=
 =?us-ascii?Q?iVfqp4LovSwR66gFp4S6grchx3q6QjZs0PRGI0/9QYfEfq5puDsfG5J7CItA?=
 =?us-ascii?Q?IM7Wcg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1743f72-3ace-4b9d-d40b-08db796e097e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:29:31.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrKtuHIw6ecb7x37DPoaOdzzctuEeDFhWIPmUNSVeI/15U8E8E7eXPePwPzFJxZyzfmfPga7bMGnvprUi5egb/61vxI9lsSjENNKkOlUYSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:14:52PM +0300, Vladimir Oltean wrote:
> The SJA1105 manual says that at offset 4 into the meta frame payload we
> have "MAC destination byte 2" and at offset 5 we have "MAC destination
> byte 1". These are counted from the LSB, so byte 1 is h_dest[ETH_HLEN-2]
> aka h_dest[4] and byte 2 is h_dest[ETH_HLEN-3] aka h_dest[3].
> 
> The sja1105_meta_unpack() function decodes these the other way around,
> so a frame with MAC DA 01:80:c2:11:22:33 is received by the network
> stack as having 01:80:c2:22:11:33.
> 
> Fixes: e53e18a6fe4d ("net: dsa: sja1105: Receive and decode meta frames")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

