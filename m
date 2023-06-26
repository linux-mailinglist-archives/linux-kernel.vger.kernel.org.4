Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F234473E419
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjFZQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjFZQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:03:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A410DE;
        Mon, 26 Jun 2023 09:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB5ZgsxBqhboJNhy68QHlABoSWsimJpB6ypIhCA+ZM7WMOxxwDeDTGIOkgGv7ERjnukzgvA7eqhOLemuQ7RkbUq+WbUDQaLZsVh1HLksRJUdvd2KbQkQwc88g4TK/jweN7YE5wA/rL8XzwqE/GANTVwp9KjOE50etf0DJDsw02kkMILCtWOfMK8gWfbiS3l3UehSAWoijWZ7f2w29JxSxN6PPieUagIl0q0hwXP/veNQfpW8jVhOulW7N6TewqRXjoB0elMaPOaEy+fDa198KJSUbw7PCbPwuavNkFzcn+iduNKtcUsb9/bQwtDi+1HqhQcwCMfHl5Mxm/qk/mByiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG0Mr0w+CAtA0tzCe0KaRPbhfMPJRETqs/WG/aAwDnI=;
 b=H9Qp2eDEgrmjkdPq7VBcYQbexCX/NLQHOT9graZxWpCrUeAsAtkd9pcSyjIuE5S5qTNXmaRFzxNhWVMwFw8hEPlAeVbIaL3/iycEDjmwMKnaHURzNgu8Cm3HOtHtV33u+4GlwvBEaLrEg667zgv22+HaHvUYIiVMu/JvrcqAG82LS645sc+Yn25E+VmGL3YLuxuxjOWPadqmC+1TNY8iTaCn7yeYV2Amu9D8UMhkiLc1RxYclXhZsjJgYYiG14dwP2C/7PsgLmiugI6D63tzf4zk41JQ8xG88D1F5tylb6IDNzIxoi4qsBu52j4fvMWrZikM1dlOhxv2fRvoZtXyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG0Mr0w+CAtA0tzCe0KaRPbhfMPJRETqs/WG/aAwDnI=;
 b=l1OaEFl2JeBeCkGkwCqlv/AdSvIHaVpbzuUQO+B2KFY/UTune/oLDr9EyrVRA17V6spDN+LT2kI8ERa5HuIIehNyBpN5GDYyGnnzQQrzXYiqoTCBr/pjP+FkWdzW0G6gvp0a2y5Yad6vhLcktgQMl2TMD0yjTcsDOiJ3p1jTQcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 16:03:05 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 16:03:05 +0000
Message-ID: <ed32fce5-fcef-6647-7345-1eacda217e62@amd.com>
Date:   Mon, 26 Jun 2023 09:03:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 11/26] ionic: use array_size
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-12-Julia.Lawall@inria.fr>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230623211457.102544-12-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: d04f5495-9c74-4332-e06e-08db765ed3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmEcBv302Ijf38gLg/kDm1J1tH71fDLOtiItFV9p29Fuq/mZjMV1L+7R9WqPVJ5+nyeiX7/6bS+FU/PH3tG4PJKEIsw78/wGuCgxbnsH14EGKm9jM67C6H5VuWNaIGQ4+l4G9OQvGQ6EjvNVRFQCXwChYzA1Wj8dZVryHeI3G7sM5JrNQfXZh67NGT2MsCsGx8wUiKT6hsr1nJx0jpVu9SFRH1d+9TbUrTireqOV1sNkRU4UIbeqOZKGv7QUF3o9+5jTi+Y1Oz78OZA/GiMZFLf07HLKqzaS7FoSvp9LMcWipZLv5AiOSezO/SdHNxQPdeIfcUAEKh/D1V/w4WucECdijRZTBLWSghYyQ1nEaY6nE3zVQO/3YUwKGNT3rLbDOx131Z87OWsUWNPysL0WmPcq1GQhlowH1UPtEJN6IQ+uTElVed40w4IZJteKeJH/z0TpZNu3x2PF2eNnjFpy1NiV3E9fjfWTQgTJnVKsF8mcPj6JtKh0mPRajzPu+ZxO7O3iafLTHrcDrYKgWSOvY7qIop/vIxUsQP5IoWwdtODEqgsWGNXJVAbDdtnn60ocdycPXMYVE/1yMPs/FQx2bzeAV8rVx2l/3G/A5nR0Zhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(31686004)(66899021)(36756003)(5660300002)(7416002)(44832011)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(38100700002)(4326008)(31696002)(66946007)(6486002)(966005)(478600001)(26005)(6506007)(2906002)(53546011)(6512007)(186003)(6666004)(83380400001)(2616005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1k2bzV4Y0V2aU5JL1daWTJXVStjR0pGTWFKbWN2WWVnZmpsRk9GeUlWOEVn?=
 =?utf-8?B?MDRiWHBPdGdNYmUyUjhabnRmOVZNbCtCcndQVWMwSXZhNHFZdDhZQlI1UFJu?=
 =?utf-8?B?Z0xOaWtUTC9qc0JOSGIzN2crRmpseHA0SXE0L3BObEMwZ2w3TkdBNjdFQTVQ?=
 =?utf-8?B?cnpMSEdIcy8xWVg3RG5jTTR3dkNPbDNhQ2dkMDBycURFYWNNWDl6Z1MyZVE2?=
 =?utf-8?B?YVpoNWhzRzk5NXlDSEwrYVU2RTZuaDNpNGNRckxzU3Y3T3diNW9uVHFUZ2Rm?=
 =?utf-8?B?VXdOYjJWSUVxRzF2STB4U05JQk14WG1PbkVtN0w4UTlXdXZvMEpsTENhYXBN?=
 =?utf-8?B?QUY4L2JGdzBMcEV4NVc4dWduckFML0pJQnR1azRyc3FBOUpiUncxU3BTMlZu?=
 =?utf-8?B?Y2ltU1hOSGNFS2g4UUZlNVkvL0RMVWM5MFRFMlQ5M1A0YmgxbzhJQjRaZVRI?=
 =?utf-8?B?c2xZMlBXbGVqVlhlOVBLU1BKSjR3MjZtLzc4Sk8vWTl0R0J0eU5McHRrWHYy?=
 =?utf-8?B?QXB0aDAweVZJcVJIMUVtU0F0OVUxZmg2UjdHcWUvUTI3SWJOaEhhWDFrUmU0?=
 =?utf-8?B?WWtVVWNmUVQwRWZkSHhVd2dueE1nRGt3QUZtT0RFaFZaZEpITlRyYXUxSmtK?=
 =?utf-8?B?dDV0WVZGUGRmNFN5QVRqOU05UGh4VFV1a0p3NHB0U3NKQnpJaFZlSG5qMUw2?=
 =?utf-8?B?TzR1a1duQ3NkM3cxbmV5ejQ0Yys4cExZLzJpN0tVMHFENVZBclk5Vi9kV0Mr?=
 =?utf-8?B?Z1NvSEZwaFVPK2hhZXM1MUtJSHpsVFk0Ym5DZ1dHc1hiSEt0aHluRVFQTlFq?=
 =?utf-8?B?UHZNZ3pnQVhadWFkNDZiaXYrZ2tlbVZBUHhWT3lCVG5rOGV4SzZFeEJPZlhX?=
 =?utf-8?B?TXRtdjRrT0MyamtvaUhLOE9qREtGK3ZTRzRLVVY5ZHJpNHVyaTh4eEN6b1RF?=
 =?utf-8?B?dDh1SStZbHo0T2dDdlovc2FrWTdGTUNRQ3JJc04rRUtvUmNrcytWU1RRSzNR?=
 =?utf-8?B?czFVVldUZ2dlK1ZsRDA4OXgrU2JQUWRrRERNWXJ0bVFsZXpnU25GMVNMWFkr?=
 =?utf-8?B?Rm0vQ0xHMHNBQkhiSzdhRFdVcEJURjBpME1BM2dKMnFkMXNjRUw5WGI3bTZU?=
 =?utf-8?B?T2xOQTdzdkNyQ0l6SDkxYjNYejlSUzBCME80cEY4UDNKWFMrTVFUYW13ODk1?=
 =?utf-8?B?VXVZc0Q0bWZ3cWxuUndLbGlBY3YzdUNvYVl6UU9iMmt3d3JsWm41S1ZtVXNv?=
 =?utf-8?B?RmVGNHlUNGFpbDkrNG4zTTU1TWxDL3B3cEIrTDFoMEtqRHJCM0MvSW9Vc0FF?=
 =?utf-8?B?UnFObDBYQ2FoYXNTNEJYMnlEZDZEcThIYlRUMEMwcFpGOUlybVo1aVpwUndF?=
 =?utf-8?B?R3E3R2dUb3BUdXhRVWNCUFdYVnVEcUVXMG15WWpVaTVJbnhqSlZmdXMxeDBV?=
 =?utf-8?B?ZmFJNHhiQmRDVkl1NlZZV0I1b3BBejVBUXFva1B6ZEtrZUhsdjNjdlZkUHNP?=
 =?utf-8?B?eUxBcFpOYlA5ek1TQmNka3QxZUNTZWhSU0sxM3o1YTFlY1IyaHlBZlkxVHE2?=
 =?utf-8?B?MFVGMDNhWWpGSWNObWlwVmZDdzh0Y2NjS3puaWNzcUUzQkpRLzFmYk15N1p6?=
 =?utf-8?B?UGRIVEo5OENMV2pkMThJTXJpQy9LTm9zZnJ6ZUxOb0hUdW9Mamc1djdqazkv?=
 =?utf-8?B?MFc5N1lIQU5rWEd4Q1paMXZPb0VFQ2gwYkh4R0ZwdXpSSlJLL0pwM0FHYVQ5?=
 =?utf-8?B?STVvUjlrUGtSRU9RelRwVlhlTXlYVEZRRE9vOVl2SXI3Sy84QkhUc2lIU1A5?=
 =?utf-8?B?VGhIV1dEdmRWcThPL3oyQVBIWDlzeTVlRklGY1BRL1JXNFRkOGhFZmtBSnlN?=
 =?utf-8?B?ZjBIejdvU2NJMjJmZTV1TFQwQW1ka2NVbHl3SGl5UnZJVUo0RFU5RWlKMllm?=
 =?utf-8?B?LzRtQUpLYTVpclJjVHpvR0RRdmdEelRvNVlsa1lGd3VFS3EyS20wTFRtSGVB?=
 =?utf-8?B?OVhkdXh1SVVtRGgrQUcrV1dnb2M0NXArMDExYzVZOHNPT2xIRU5vL2JsaDF5?=
 =?utf-8?B?VUI5Q2RBVzREWE1QRldaRFBjZXZ2VWI1T2c5MWNneGI3dGhFbGgydWIvbWpM?=
 =?utf-8?Q?10ML5GREMF1cV+5FqNqrQcOB3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04f5495-9c74-4332-e06e-08db765ed3d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 16:03:05.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4i+pylj1ZohEPBQSDj57xaj2gBTY1VcnfZxrC3Zc/Df/vOOS7dCamfvX7ulEsq7Xus9jhO/9D01kjLy94T4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 2:14 PM, Julia Lawall wrote:
> 
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>      expression E1, E2;
>      constant C1, C2;
>      identifier alloc = {vmalloc,vzalloc};
> @@
> 
> (
>        alloc(C1 * C2,...)
> |
>        alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>        ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thanks,
Acked-by: Shannon Nelson <shannon.nelson@amd.com>

> 
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 957027e546b3..f2e2c6853536 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -560,7 +560,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>          new->q.dev = dev;
>          new->flags = flags;
> 
> -       new->q.info = vzalloc(num_descs * sizeof(*new->q.info));
> +       new->q.info = vzalloc(array_size(num_descs, sizeof(*new->q.info)));
>          if (!new->q.info) {
>                  netdev_err(lif->netdev, "Cannot allocate queue info\n");
>                  err = -ENOMEM;
> @@ -581,7 +581,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>          if (err)
>                  goto err_out;
> 
> -       new->cq.info = vzalloc(num_descs * sizeof(*new->cq.info));
> +       new->cq.info = vzalloc(array_size(num_descs, sizeof(*new->cq.info)));
>          if (!new->cq.info) {
>                  netdev_err(lif->netdev, "Cannot allocate completion queue info\n");
>                  err = -ENOMEM;
> 
> --
> You received this message because you are subscribed to the Google Groups "Pensando Drivers" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to drivers+unsubscribe@pensando.io.
> To view this discussion on the web visit https://groups.google.com/a/pensando.io/d/msgid/drivers/20230623211457.102544-12-Julia.Lawall%40inria.fr.
