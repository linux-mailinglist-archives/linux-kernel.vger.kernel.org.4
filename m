Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B266D73E416
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjFZQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFZQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:02:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8310F3;
        Mon, 26 Jun 2023 09:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elV8FMaCVmXObABSZg3C7Nng6ob9faniLaGs48SfdAnREXk5ypWC/qOCwoUuWRcZKAyHrFIPOg9c7LXXfJ1zWgEUqaTPb3/sAZbq+ERayaIuyTXe/R4FbedahdaI/HvwXEAIcPfTttJOBoR7CnoZobOrwgEbkATB1OBTbzvAtNQMHan1gCsjIlCU3tpjqB2ki6lAgu7zXNjM3Rc/AK++GiouFSMjAnTSnpvZGiNnShmSZGBUvBDXrIcRSbnEBr9BHHrTmMzFk2GaVfVOiAK8MdztpvrJr/kWrSafJse+gFyIQiK7BvSH6xJ3oFnxm91hm02eOyo+Qq9dmDfnJ9NepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyTGUo36PlSMm7EmWdPNAayfSkwPeFI5+TKN66D1v7Y=;
 b=PoKlm1yVLacreRwCQbaXU0WmiUiNARTbvNqBsPUZwJTVzZgtZZ7D8jL2cDo9e4U9Drksb0qx2DWXiQ3ic19VBWrs4w+fNkrzb0EE9Kq9Z1ho29ZpdV5nax0QpT96xCMLpP4SN/hX9p0Kg7Zj+xpejddptkGhb9CiiRdpbqnsTYi6r0LvPXOnJvgn6b2d7nm6fIGvmLTSToI7p8/8MNu9RqogOUjznlQABNv5wDMKI7eV4640+kPNjHX8MEAoveH1w7QHm9A5IIUBNMAzjGObpPv1Vu53cnQU+ULDWIpomn9fCuPxm4awP8Uz9c0hQcAZYpTwS9KBVkh4PRbqsYk1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyTGUo36PlSMm7EmWdPNAayfSkwPeFI5+TKN66D1v7Y=;
 b=DooTlrvFHIhVS9ITwQI10jK93sKYpPVYnwh80zxeHTESefuhJ7FiD83/+27A0hOrQO0qwDJuRBFtbKN99srmC0+ZZQz28Eyyg36Jzf0NyCI72fjDJi4YL1QdD8Ci1jbSNki8pncJl0qFr4nXLDkdyhbeCLbeTJiuv0//p/F42dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 16:02:34 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 16:02:34 +0000
Message-ID: <cd1d3939-d5a5-2d30-ffbb-cedab71a4536@amd.com>
Date:   Mon, 26 Jun 2023 09:02:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 09/26] pds_core: use array_size
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Brett Creeley <brett.creeley@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-10-Julia.Lawall@inria.fr>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230623211457.102544-10-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2648a2-15b2-4899-3c6f-08db765ec132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBM0fE68Nxa8pJ9y4PXOMj1doARkD8pXgehHVCDoJmo9ps3kxO9usPFz3Bif2gsqK423CXbz4yFeH63313+QlNszSN2WCIg8ItxQB7lOqQrlwiupn6CeGbkXJ+syUDNYPEpz8JTC/12/fD/9P1IHCJTSjPd65B0+EDwkOoZds3P/TmBwaWsoR+FsX8FQ9TjdEsJBe3ZMjl4bcbaMg/XxfkJHIhjjaW7MPnLLezMGDFiTUuST85ZoZhDv1Fz0FUvfmPrXPw8EM7TOFL/6NuJt6nJn67p7fTyNauIS0JVvHatS5/iKMJuUo/HfHeU1SiGm/xmF7hDcDfjyuAF6CjpnwLb3672k6U36P6lBdX6AsU/BKOU3SBZjpHNl9SpPrIINqIcS+fDzpRiylPgnPfH/04OnOXx738SQsxmwEozNBKzRHuCsHb28nkaRFQ6xGR2TpHRmcqEXjVSGZ5NAXyCJ/u9xFseCCS4b4NO5Ac7/6gfkNk+9PNIEnLUWf0hu7MsUdEBarDJXvl2Paqg4KOjtRbeNPt51xULaUKxYc1Sr3iN5LXY8+yrFLnm0HXJqZ9Wfvxvdl6hEB+OBI7ZeG5GeFLNeKorcOYL7IkWYewHmAFuM0t0d+gpYc3BFcHbiQDj3zP8GRgPkPfS0vDZ+wk1zGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(31686004)(36756003)(5660300002)(44832011)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(38100700002)(4326008)(31696002)(66946007)(6486002)(478600001)(26005)(6506007)(2906002)(53546011)(6512007)(186003)(6666004)(83380400001)(2616005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1IRFlzK3JDWTMwU1ppZFZNRCtsalEralpHdHlmV3dTWUxiQ2VMSnpoN1hZ?=
 =?utf-8?B?Rm1tQXA0SXN4V1BXa3RpUzhWWkpNUlZGNy9FU05EY09uL0RlY2xhcjR6YW5h?=
 =?utf-8?B?VHdRdm1jU0ozNEgvTEJhVVpZSTY0ejd1ZmszbHVqN2hzcjBGR0xLalRCSWln?=
 =?utf-8?B?UHkrdFRQcnl3U01hbjcyckl0akZwTmdRcWJxUkVQdXY2UkxBek93VGM3cVNW?=
 =?utf-8?B?K3JFOXk5WXB4REVQUmQ2bkx1RWoxVEhmSm00SFVySjRGVjdza2ZLV2REUEFG?=
 =?utf-8?B?NkhTVktZTitDUmR0NXlLcllZVlVpdFAreXIxdHpwZUh6MUxnUFRYdW5CVW1P?=
 =?utf-8?B?Q0JJUU9NRW40SVNPR3QyNzBPQnNJOVlMOWllMHNJVThoYWRiT25tZnBqeHF4?=
 =?utf-8?B?K1M5aHB5NXR1VDIrQVNJUjhjVzdtc24rRFBZekNRVW9ZbER1RndDODRVSURR?=
 =?utf-8?B?MzdyU2tDa2tldVZsZmkzenYzRmZLZjVFZzNIelQ5d25wd0lvL2hRdWdSbFpG?=
 =?utf-8?B?am9sdTRPd3VZMHJXTUVWdVB2Sk5JTXd2cS9xQ04xWFhCU3lrbEFyT2JVVCsr?=
 =?utf-8?B?SjdVbGlLQ2FUOXRtejg5WUgyR0lsUlRtK1hTcDNDSm1WaXp5bGxaUDdVOXo3?=
 =?utf-8?B?c0pkMzI2RDYvdmJxRHdydmNqanJDMExNdmttRWxUTTRCZFcvSzU0TGJLeTNE?=
 =?utf-8?B?WitlL1dHMHp6R3pkS0ZGQjlkbnk4Wm5uZlgyeXhXTEcvL0FobXY4byttLzNu?=
 =?utf-8?B?MnBKSllHVDBYcnk4N0UvbVlQbzNsUEpqQlNaaDhwUm51dm16K04zVUFVazRZ?=
 =?utf-8?B?aTJvNjB2ajhDVkpKTDI0Z2RJRUNvYmRKTVMzNTZIS041bC9Oc0VoVWV4U0lI?=
 =?utf-8?B?YzJua1hrNlZXSHpVK1dHT3crU2J5T0hpN3RCR1d2aHhDRUdrYVd6VHpaSE85?=
 =?utf-8?B?bUk3L0NzNEpTSFU4NlVFbEg5NEF5dXlDRXd0aStDRG9PVkRVRXhCUk4zTDFh?=
 =?utf-8?B?N2VTS2NmOHlZc0dxSldVbjZzUytWQWVQWHUzakZRY1Z6U0pEc0oyRDFwYVM3?=
 =?utf-8?B?VmUydkNRWmkxKzhYTmcvVHZXcDBMN2FwK3dXVTJxYm0xWVc1dWkrVEVxbjhI?=
 =?utf-8?B?SXBQV1NzOHBQN3dCNDBOSFlDV0RNTXBSWkZGT1BvNkxkT2JFRmp4cjVlWnZW?=
 =?utf-8?B?ZjA3TkErVFVQT2ZxSzVGekNIRVVyeFBYeW5mR1ZkMTI4QlRvR3RWT1paZEVu?=
 =?utf-8?B?c2VWcU0vVEp2ai9ML1NpbEdDYlVjL1Q3T2k3cER6UDlHNjBrcXVmLzdlekd6?=
 =?utf-8?B?RW4vc3JtOEw5Ym40TUo4cGUrMkxvcFdnQXp3WS9PVTEyMUl3TWRKZHo4YUdm?=
 =?utf-8?B?OGZ5WFdiYTVjSHY1cGRhQWNVK01Eb0F4QStPd1NSMVdmL202REtVazBNbmNk?=
 =?utf-8?B?bVkyZlhua0REVjQ0RUVBZWNidGhxTC92Sm5rQ1RlVFZ5c25IeTlOWUY0U0x3?=
 =?utf-8?B?VkdreEs2dTRucVEvZm5oV0JCeG03dncxdEVBZk1IaHhBeHdIV2xVSkZaME5Q?=
 =?utf-8?B?blFpRmUvdkpnVWZndGhXMUFVdGJPdkN1VWhERi9aOXNub090ZUJYUUdpNHU4?=
 =?utf-8?B?VUc2ekRKanN6Z1NUSmFQbk51VzBLVk1EaW12ekQ2T0FFQlVKc3BHcVFkSlNN?=
 =?utf-8?B?NnExYVBaY2xLRTJra0pNR3FPaTg4Z21oMHdCYkVmUEJsSzBHMm5ZQmxjbVg0?=
 =?utf-8?B?VXRRQ3Azc3l6ajJ3MXVSWHRHbE92d0NQdFlQcHhWYTlacXRRVTBBMmU4UXhh?=
 =?utf-8?B?VW9aMDJQV25XOHg5MWtENjJDOHMwMlBEMXc3NHVubDBLME0rd0lDUDVDVU9V?=
 =?utf-8?B?SitpSEJnUXBGQzJEelJKY0M3U1pWREFPYkhmS01FQWlLNzVFbXJQbWV1S29o?=
 =?utf-8?B?RVpqSjV2Wm8zakozaEx1YXpYWUdXMm9TenJPL1pxeENuZy9vNjdkcnBubzUr?=
 =?utf-8?B?dnlYSlRXWTE5VDRUUFA2bHVMWkZuaFgrbEl1NTZqOFAzZkFuSUtNZWJ4Z3Ro?=
 =?utf-8?B?RkdrcE5FUDRycUxjU1MybEQrQmNLSXQ3SHZGN3hKaG5Fc2oxNk4rWVNxcTZY?=
 =?utf-8?Q?8SMEF69zkfRgd5FR3zYT/adgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2648a2-15b2-4899-3c6f-08db765ec132
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 16:02:34.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8h6QnUtu3QhRubCQXyKVa5PWhxWCJNfEgPTnREHycUD76rqkIJDwCmaSA6TLN7LePtv6O90BwwldxzJgrNC5w==
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
>   drivers/net/ethernet/amd/pds_core/core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 483a070d96fa..d87f45a1ee2f 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -196,7 +196,7 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
>          dma_addr_t q_base_pa;
>          int err;
> 
> -       qcq->q.info = vzalloc(num_descs * sizeof(*qcq->q.info));
> +       qcq->q.info = vzalloc(array_size(num_descs, sizeof(*qcq->q.info)));
>          if (!qcq->q.info) {
>                  err = -ENOMEM;
>                  goto err_out;
> @@ -219,7 +219,7 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
>          if (err)
>                  goto err_out_free_q_info;
> 
> -       qcq->cq.info = vzalloc(num_descs * sizeof(*qcq->cq.info));
> +       qcq->cq.info = vzalloc(array_size(num_descs, sizeof(*qcq->cq.info)));
>          if (!qcq->cq.info) {
>                  err = -ENOMEM;
>                  goto err_out_free_irq;
> 
