Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5283E747362
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGDN6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGDN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:58:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A4FB;
        Tue,  4 Jul 2023 06:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adt76Ub//Ux06ZQofDOes/+YQX7kgJl+CMjAMou6IYVoOLoLYa0jfLTuEg8AH/0GvKjDVYG8KiTpqn4iWpAe9kFwaCqNLqNam7xvHXv3EEjQsq4YYhBFKKtZ3XAUHtC5oxAGHJ43LrcUaqzx05J9AuCy72VZwQ82vEQwX/P+M8EPnov4STCx0K2A1sKl5lP9vzvJoQ36nyGz0fLPLEviUJn4CSLdL+LBqTvOEqsu9OPjfMA0r51rwVsMMSQ3XEC8HioYH2lqKPMmLlz1DFx/Oyko8WX2hc2uOe5NMdb/TZKcOyauS/pqKVGU9OZpLBr7rV78vlLWvwQgQW+lSzR6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v635qKZrR17ClWa0pVpVyVYioV9OA7ijpEuPdwtWm8w=;
 b=JbpjEG7suxzBqmo54/nD4GFU1SjE4Nz3RavJH8wgMpEmUefQ48tlF9TV2NSYxzHd0Zq24SFjsq2q0TgcJf5QVDfe02lmhCeewf+p6kHV7tjp5Ol5urnB9Z4pHrY7fAxQEojbnz52nkblT5axFnwG2HILUoJltcrx2NcDeGXbB4E8t4sLrs7Y+lDnGoA9RyBlXxPrrlz5/tzs5sQ8aT8K7/zH3CZOicIBwAr347kGuN0QXb1SDR1vaXksFtAyAEvG0+AXg6JDki6gTWVw7yd19j/+U/WOtVEPeJls7SaIErFi4x0SlleziwAOWOijz669d0d7EDMQdhvWrMjpw9gm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB7523.prod.exchangelabs.com (2603:10b6:510:f6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 13:58:25 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:58:25 +0000
Message-ID: <d5fbf1cc-9b79-5fbb-a109-87679caffcc4@talpey.com>
Date:   Tue, 4 Jul 2023 09:58:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
To:     Namjae Jeon <linkinjeon@kernel.org>, Wang Ming <machel@vivo.com>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <20230704074057.1162-1-machel@vivo.com>
 <CAKYAXd85gpb2xzPEm8BJV6gsff3p-8b4Aj_rOaEvU=+n43SgBQ@mail.gmail.com>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAKYAXd85gpb2xzPEm8BJV6gsff3p-8b4Aj_rOaEvU=+n43SgBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb4adaf-69c3-4002-4519-08db7c96bc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTOv66ykPQ9VoSSJEHaBhoBeA/wveVRsy8aFkuU0nfhf+IrGJj5qI4SD2cNHQruw4lrBln/VVKU1HlUtTdh5mghf9NG8PZRSBTt0tD7Gp24T7WGt+iTUrJygcDoFTvWaHWgCqkgvk7kS50PuDaDh+ZstNDBF/7ncq0Fc0XsLWbP+9hut6gM+maYUHEdxtbEHvaO0CTa4/bbTdKxgFz4pQ4zifOOs4xXsJXc2bg8Li2XZzIuIYQorWGv2rWU4hl2bISZAeVfsMVSFGM52OnmTktDD5/vBzlHY6Ahx3hDaUs09Prk49OHYE09goTDLnpzunXnFuMHXqgdJD0RjnqER2eUobJFUa0smmT6znk2aXHH/z82ZgCp8FiqOImE2NWtCOa4ZPTSpbJQUNNEDKt5kTtMnfCf5+8fsXLYEpQH4zzkXDPT5O+zcINECe9e5+1X8QoG0MQRSihR1CTzQjp+/y0erchMZIknzQ7gQkFIi150BSdh55h9858tNQrwewW02w7n0+vT1evy0o4olR/bha0CCWj+VVY96aOn+uElUcRGIsgsMhCxZG3AbLnnBcmv0dsTwoQRV2s4uGizBisLg2kF3hGB59pUmisaZ08mheD1+JE6sVIkP2IgWlY/AAbkTvb+K/sjlVTR8xMLIQGojGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(396003)(376002)(136003)(366004)(451199021)(316002)(2616005)(4326008)(38100700002)(38350700002)(66476007)(41300700001)(66946007)(66556008)(54906003)(36756003)(2906002)(6512007)(86362001)(110136005)(53546011)(26005)(31696002)(186003)(478600001)(4744005)(8676002)(31686004)(8936002)(6506007)(83380400001)(52116002)(5660300002)(6666004)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXkyQXVCRjluTSt0WFU5K3VGL1dncHViN3UvaXh0aGZxM04yaS93d3dyUko1?=
 =?utf-8?B?K0pOUVo3b2UrMGpBKzFjQ3ZLWW1ZU1hYQjlnY3ZVUG9WOWhGdmp2cTNhcS9o?=
 =?utf-8?B?OEQxNHV2YXZZTktuQTJ1MUU3ZE0xN1dLVkhST1lGNjQxSHVkaGdsYkxVZjdr?=
 =?utf-8?B?NWsvSy9JSXJPa0I0ekxEbGlQSjFDSnJXZ2FJZVdyZ2VCeDhCRVR3SlBiQWFE?=
 =?utf-8?B?YTRoWnNZSjZ3SlZSSy9zakhCODBheUZXRmVmd3Izek45eGpQZGp2c0JSTENG?=
 =?utf-8?B?QzJqb2U0ZkE5WlJ0M0NYUHhJUEkxZXp5VTBtTHFkMVBxd0RwMXVnZ2NVUWVp?=
 =?utf-8?B?UG5UK2lkRjEyeVRSM2lzNjFqMEJXMEZJS2JrSUJsRmtNMDQyVVdJdkZMT2po?=
 =?utf-8?B?cllYSmIxM2ZCNHZORVVxaFN2SWoraHkwVll4NTNkMUFCTnVPdVh1Z1M4dDZ2?=
 =?utf-8?B?UGtFZElIMTZ0aXJ4a3ExUlpYYm9YRjZDTm5PVklrWmNSeFI3Ym9xbmMrRG5S?=
 =?utf-8?B?dnRMRlB3VG5DdTBPYXViQStBc21sRkZkNjBDVUwwWmtBOXJJLzA1RVBleVZt?=
 =?utf-8?B?dDYwZHNMTHlYc1RpVXFsYSt5aDVXU1hNUm9VQVptUGRIWk5rN0txS0RJUDlH?=
 =?utf-8?B?MVRLZkFQM1pCNHloWXNHQStYNFhzNDVkT3ZRNnRMR2dZTmhGVXlGOXNOSnVD?=
 =?utf-8?B?ZmlFaDJBZ04xeHc4M3FscTloOW56SkIxQ0hoSWt5TndYalJFNkU0ZzlsT1ZY?=
 =?utf-8?B?VVIyM2grS0NWbUVPaVNENElpSDIzcllKb2VEb2lURzJHQ3JuOVBsaGVwVmh3?=
 =?utf-8?B?Z2pRbW5HNHJHSm5rd1dFQUsrWnhhdUFSbStwRkwvMTFaK0RuV1hxc2U1RkxH?=
 =?utf-8?B?T2RRSmwzUFRNa0MzOWlLeEZlS2VOTEJUYnBLZm9WRThKYjRodS9OcGdwOTFU?=
 =?utf-8?B?Ym80RmhFZFlLM0toRm5pcG8rZ2V3bFRhczFkTGIvQUVhUkpoTXFNVzlqSmEw?=
 =?utf-8?B?SEtla3NhdDJhUGdjMUlvZ1A4aWNQOFljOTBGNWZrQlRSdVVLcXNaTnBjR2RF?=
 =?utf-8?B?RWZEcXY1VVEvOGM3UkhZeCtDZktvWFMrYW5nbXI0akFyUTBqcWQybmxnekdY?=
 =?utf-8?B?QWVMZGpHRGNXaFREMlVVMWR5cGx5TVZFYjlkRVBSU3FNOWJNSXNCTmhsdmtJ?=
 =?utf-8?B?RDZJWmxxYnR3ODMvWU54M3VmQVRrSHczZEFzRVNEOTJEQVEzdllHVTRCK0Qw?=
 =?utf-8?B?QkFERmRWTjVhaTEweXBYZnJTc2s2MHB0WE04K081d0hLZWgzdFlVdnlxWGZO?=
 =?utf-8?B?MlZrc1AwZFJhYmJ1dW9nak4yTEoyQ0Q4VEdyTjRCSjcrWGdmbHVWM3k3ZTZw?=
 =?utf-8?B?d3BQWG52bTkyQXozUUM1WTJlM3B3NFRvdGtvWGFndlVZcnQxZlFDRG5USU1W?=
 =?utf-8?B?R0orYlBhVmRyaGM3N3JsQ1lHbDhoOEIydVJZUDdhRlFGdDloU3ZyL1oxRU1o?=
 =?utf-8?B?VlJobE5vQmR1aWsxaXNpL092Z0lYSWovZEVDcXRyYjkxRExmVThEQTdORmJq?=
 =?utf-8?B?bnFTZUNFbnU1WTYrMlBTUTlWbE5aZzVNV1FRYmNnT0xVNmRVMTJNWFdZWncy?=
 =?utf-8?B?M2t3bitXQUJlRFdhV3ljRVFvcTRZakhaK2I2b3VGYmcwK2V5ZC9mdVZQK01G?=
 =?utf-8?B?Q0lZVldONm5QbHVoZjRJVDB6WlpQajVULzFmTXY5ZWhvMmVEb1VPNGIyWWVS?=
 =?utf-8?B?dk1BWTliSTg4aWdiUDlyVE02WnR6SVNCYmo1Sk9DQ2l6VUg0TUVVdHZ0aVdY?=
 =?utf-8?B?bXRhMURwcWU5U3NQUlA5YUY0NzgyaU1TTUhGd291OCtzTEIrMXB3VGtrTjdW?=
 =?utf-8?B?TTZ6dkJIWk1OdXFkS1g2V1J3ZUt0S0M3R3hOSXdSYWFnWkxLUGFSWi96bDBW?=
 =?utf-8?B?WWJUeHR3UGErYkxJK3BlcmRobDh3aDF6M3RjMHJPK1ExYkwyQlZJQmtVMDl0?=
 =?utf-8?B?dW8xN0J1MUFURWZMK0l6bU9lYVd2dTdqQnZqeGtBNEVPUGhxMWhiWnl6eE9j?=
 =?utf-8?B?bmtuZkkxTWV0YXdpNGxoYlg3d3UyME5WK3hvaG1hNkF0a0dVMlBUWVc4SnVh?=
 =?utf-8?Q?at2NdMPCbAafc41yA3drt/TSE?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb4adaf-69c3-4002-4519-08db7c96bc2a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:58:25.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41t9vG5J6BCvMiUaPlRlcxFIMIGSgB9RCexXIcy9RmCzcm+gjObAcODHPpm0ao/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7523
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2023 4:58 AM, Namjae Jeon wrote:
> 2023-07-04 16:40 GMT+09:00, Wang Ming <machel@vivo.com>:
>> The return value of the ksmbd_vfs_getcasexattr() is signed.
>> However, the return value is being assigned to an unsigned
>> variable and subsequently recasted, causing warnings. Use
>> a signed type.
>>
>> Signed-off-by: Wang Ming <machel@vivo.com>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> 
> Thanks for your patch!
> 

FYI, this is missing my previous Acked-by. The updated changelog
otherwise looks good.

Tom.
