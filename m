Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A524D700659
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbjELLJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbjELLJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:09:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145BB11DA5;
        Fri, 12 May 2023 04:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8oYIeV12176gZKXribQqR8gd8mSr+zhZiTzhrIWhhfax8ZtuRCvEuUU3YsV32ch0L+x1Fu9PJPTXyz5Cx1gFIjt4Aj0tV6oNN23lfM8FYBFm5bgnFxwWjPmQzNmklmG/ADI4EDZDbNOqDLX67MlJAMCt6oJORxmzQVVQO6OV6tjSh23y4rdQ/lEAu4t8XpSIV1JGTLrJKs/Dixlnz8Y6/LffWwwmp5ls2RIJgoEHHYJil9DQe+c4CFgTkLC4E+pnCXMTPSSwjilgzhTSv7GcjJZ0V5qsJOsHXDj5z75xxjmzjubYJXveJa3RoVf5HyLKaIuc+xOQJcS+ottQpTDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHXvIUoKbbnG1j2qI2vq8+jrJ+beagtBnFtmlto/LRg=;
 b=ChwTvdwdocVdAYSw3Fu3BZC7c0YG7685TNhKlk5F5FZzK4MDKF7kcepq9m6g8NmbeOZYITdi/3MbB9QKYhqcRmX8gJtgv54z1etJdl/hd7WAv9hhzbOk6akwZsBP4Vu8vD+otRY5cotvateyiT1BQ3PS0opIYnSlIcEKMJDldyY492sps+UAoTyxJDcbTw+4SbR9MheKqP91NYU/mMr59+adLgBeaNAtoyFaL+Lx+wvUVZVgW0+QMD9yp57Cn9proGa7hSoNHU+yus86cla+AznvCA6mT1tNmldctXsz7YKISOLMnan4/SCyU/n//wr+gj+idjBHZBGG3XR9V7f/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHXvIUoKbbnG1j2qI2vq8+jrJ+beagtBnFtmlto/LRg=;
 b=Z3eNwCaBgdmKclQpcVnLWCIW1Av7vNDmnCliIOiN9jIZ8UgR8Aa2wCBNUQKydVT0EWTJ+JnTLEpHCENtuWVTZCHXjhfCwIZ18n4lFZQzCuB3G0Ha+gG3ARLTy4YEvMPyvqlTqQLXU+Hx0hQVaSw21SBwgU9qgFFdBisnGoV0mqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 11:09:08 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 11:09:08 +0000
Message-ID: <58711e80-8720-0a92-2e9e-5ae0a23368c3@amd.com>
Date:   Fri, 12 May 2023 13:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] driver: soc: xilinx: use _safe loop iterator to avoid a
 use after free
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <761e0e4a-4caf-4a71-8f47-1c6ad908a848@kili.mountain>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <761e0e4a-4caf-4a71-8f47-1c6ad908a848@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: b45faa6d-302e-4292-1e5a-08db52d94eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJ94e7NnLzKqF+7d5KxaFXdUuGL4J+NOqY3btp/o/DfiOnPsDKddhUd+L9VHtpLnh43XKfn6lWFzTM/HDGKQGfN6z5XEclD/eGwnM51Iw8QdwexCaG9ESsPPeRpO4lQ85iBBUqhsKbSU92vc6OuNOPSN6v1cs5pK3iUi1cgau8p+MQ8HrHMkiX6fs7c2w0xiRyD01uYI2JIu5H8TzD9qg9EboC3HhX1yGEQvl2FRtYNF26LO0QalyeYQlsDqmCkQWqHKa41KxA1b0oCoO/0TG7Qcj3fW3pqvY896I2BwnIlt2BS1unKaw4253hOImb7zV0KAYG0IEnyWmgF1zpGFsIYhVcZL7W1ZRX/cMsepNm4nvo94wQG0zq5G2h4TMfPj4lQ+zDTjc2wt/puiI3/2YGIZwdftuGRMZgRl07K1Avo7sm8Tv4NqI/Id7s2EJjSrz1BSTINZk11chXWGCdHxh7uK6xDQR86V7Uf+cTYS4srIWvUlfENIewmjZiAu4oHe1C5vfP7jBwLNzkbkcF0K2+7E2U1R8bqB08qYfQMN6xzAzY/MqBpuDHqT9SDQ3SA0LsrRni5u0+DsMzYzLBjp9QQSnds938249yaUS4x2qkbxda8FAZJL6cY1Xa/Tcd/8vBgEeDCf0ft43KVJCRMVqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(38100700002)(36756003)(31696002)(86362001)(5660300002)(44832011)(8936002)(8676002)(2616005)(186003)(53546011)(6506007)(26005)(6512007)(2906002)(66946007)(66476007)(66556008)(478600001)(110136005)(54906003)(31686004)(6666004)(4326008)(41300700001)(316002)(6486002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUc4cU9JcnlOQlZIQXZlVG90aCtpTGZXU25HdVE4NHR0YWNLazVDN0VFL09q?=
 =?utf-8?B?cDNBZVo3UkxPRWxkZ1FDRW1zNkZjMEFsSHZvOSt4SUxsTENZNWpyYUJORUc2?=
 =?utf-8?B?TlhHb0JoZGlnVGNrZWIvZUJlVFFiaE54MFcvZTM3RTdUWm9TZmhOZll5MGNh?=
 =?utf-8?B?Y2FXVCtpMm9TczZ2MTZwYWlmMGxVN2laRmcvT1l2V2h4TXBua3pDNmlDSTZW?=
 =?utf-8?B?VC9ZdnZsSFBGeVpmUm5XZ3FINEExYkdVb2czRXl2Zm1nblQ5Y3hqZE5SMFFU?=
 =?utf-8?B?bGJXUTFxbCtzMEt5SDZyMU1OZ1gyRzNUb1R0WDJHVVY5TTRnNXRBVEJUNW9t?=
 =?utf-8?B?RFNqc2VHeDY5WmZYWmQwNlF2ZGdCWm9BT3lvaVNCUWhHZGdvTlplOHBURVpW?=
 =?utf-8?B?c0hxRUp3MmpsR1dEaW1sM2FCQ28wY2dkbytSVjBMMXJjTlV4TU8yWTFrM3Yx?=
 =?utf-8?B?WUV6cU9wNlhqQVdqb1FMOXhtcjR5N005bGcvbHkzeVVydnQyVklIQUoyQmxz?=
 =?utf-8?B?WllWbElGYUQ3TXd1c2RGQzgyWjlCZjFsejcvM3VKcTlpU1NveDVDSjQzVzFx?=
 =?utf-8?B?NGhncmJ6TG0rVlZKZ1pFVjRPdzNPMlhHQWlUYlE2NmNaWk5kWDRrMndnM3VB?=
 =?utf-8?B?dHF3T2F6aUNMMUFPTUpuWDRhbDZQMHg1WUVuSzNWTkxacWNuenYxKzdROFVt?=
 =?utf-8?B?TVlLclpOdHcvOUZrMEtScitPRU5MVzA5cjJLcmJMREYxOFB2UFh4cWxMdkZC?=
 =?utf-8?B?ZE1ia2Jsa0pvL28vR2RWWG1mRU9yblZKZGJXak5DUXZ6R2wvdnlydzltaUJx?=
 =?utf-8?B?K2NGdUVYUHliUkI0WE1sekh1RWhKWGhmcytZSzMyeWg3ZllwRmg3bjEwRDFD?=
 =?utf-8?B?aHNYSEc2SWdzdXBoRUt6WUVJTkx0VGo1Z3dBOTk0R0N0dWJCV2E3RnNXSUVt?=
 =?utf-8?B?OFRDTHlxQzFNbWNsTUtKTHhXQ0FwSXhxdjNXMWROTExySmJaQjEwY1NFZkpt?=
 =?utf-8?B?RXNES2pLWXM1Q0Z4clNQTFN5cFNnaytHd01mb1JGcElLRW16ZVdtQVc2Ympy?=
 =?utf-8?B?S1RoSGIyWkJFcTFXVTJCckVRS29CdWJUNk9EcWNZYUZVUk5tZXpXQ1FZdlkz?=
 =?utf-8?B?aXdNR3VITDYzSTdyRnlDM3BhbjBkbmN3UlJ5OHZCakJEeEE3ZloxK08xZndS?=
 =?utf-8?B?TVNkNGx4enZnZmpKQndHbmY0UkRHTzRJVm95TTFCR1hFcmc5OE91ZVNGMUk4?=
 =?utf-8?B?T3F1S0lKMFN3RFI3MmdFUjVaNjI0dVNCZzAwaXZGOEo5RUU5b3lzMURkU0kw?=
 =?utf-8?B?cUtodU5yZ3ZyT0M0WjZ5enhUS0Z2VVZIdlQyVnhKeklXeTF4ZUVtWjVXZGps?=
 =?utf-8?B?L21oK1lpWDN4NlA4RW9tMm1uVnZPcVQvd0tkV051S2pqWEJ6c2xyZ2kwMUtl?=
 =?utf-8?B?bHNEcS81OU5nSk1BajBERWtrM2tCSzB2TG93MmUrNXowUkdoZEdoVGM0bnY3?=
 =?utf-8?B?UDJscEhNR3dZNUhjWnJYYVM2QytHSTJseUFPT2ZoeWJzcXY2UFB1RXlPNldr?=
 =?utf-8?B?RWN4UUxoT0hjcmZ3N29nKzlDbUN3bjVZRGVhZlNKSS84QVZEMzREeEJOQmJO?=
 =?utf-8?B?OUxpdnpxZmhPZUdUUHI3eHNqOGd2Z3ZqdGRHaW1TTUNaZVhER09wcG80MmQw?=
 =?utf-8?B?dklFMG5majZ4WWV1WmF2QU9jTHR5UUc2UXlUcDRncGdVbmwvMnNTVDdPb0M4?=
 =?utf-8?B?eGM4cEREQWVXNzBhUlA2OUszT1hwOEJUanM5WHdPbGlNVWZuVStaMzM0MElw?=
 =?utf-8?B?b1l4cTJLODVadms1ZHZqekpXUVFxdnRXYjFldHpOaHpDR0NGNzhTZ3lCY2M0?=
 =?utf-8?B?YlZQckE2Z2dTWllnTjZmSDRsM1J0SnhHaHpTRkUvcHhMU1dHRUtVSXF6dnEy?=
 =?utf-8?B?L3dmaFM5S3JlTitFV2dRYTA4dmR5clV2ZlRZOFIyUEpjM2l4V0wxcW9paXJH?=
 =?utf-8?B?bHpRbWRrTGxBUWRlVGJPeXE0NGVBaEFhNWdJZC92bEhZazVrWFhUNlhPYWZn?=
 =?utf-8?B?YjlNbEdWZzA3R3ljNFZJYW9uU1U5M3V4cWFWaHZMVEpoR1dkc25OcGxzQzd3?=
 =?utf-8?Q?Xv64nDPKC3p6cb8hOldPgHnS+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45faa6d-302e-4292-1e5a-08db52d94eac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:09:08.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uECQBJCGHRXqzlKcncEMannr1jLZ1iDhX2Au3Hhjws+/lRcAM0lS3Xe1D232S3f2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/23 12:44, Dan Carpenter wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> The hash_for_each_possible() loop dereferences "eve_data" to get the
> next item on the list.  However the loop frees eve_data so it leads to
> a use after free.  Use hash_for_each_possible_safe() instead.
> 
> Fixes: c7fdb2404f66 ("drivers: soc: xilinx: add xilinx event management driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Found by static analysis and not tested.
> 
>   drivers/soc/xilinx/xlnx_event_manager.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index c76381899ef4..f9d9b82b562d 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -192,11 +192,12 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
>          struct registered_event_data *eve_data;
>          struct agent_cb *cb_pos;
>          struct agent_cb *cb_next;
> +       struct hlist_node *tmp;
> 
>          is_need_to_unregister = false;
> 
>          /* Check for existing entry in hash table for given cb_type */
> -       hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
> +       hash_for_each_possible_safe(reg_driver_map, eve_data, tmp, hentry, PM_INIT_SUSPEND_CB) {
>                  if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {
>                          /* Delete the list of callback */
>                          list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
> @@ -228,11 +229,12 @@ static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
>          u64 key = ((u64)node_id << 32U) | (u64)event;
>          struct agent_cb *cb_pos;
>          struct agent_cb *cb_next;
> +       struct hlist_node *tmp;
> 
>          is_need_to_unregister = false;
> 
>          /* Check for existing entry in hash table for given key id */
> -       hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
> +       hash_for_each_possible_safe(reg_driver_map, eve_data, tmp, hentry, key) {
>                  if (eve_data->key == key) {
>                          /* Delete the list of callback */
>                          list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
> --
> 2.39.2
> 

Applied.
M
