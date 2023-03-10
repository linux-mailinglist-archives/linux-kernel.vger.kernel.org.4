Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6D6B4E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCJRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjCJRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:23:24 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4617D119428;
        Fri, 10 Mar 2023 09:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvDYM3nTEGtBLS+8MguOBTEBreNfoEzzEwC7B+loXz1FmAe4FjEdsL8SgI8XLcQeyb+E2G3Rh094V4dFj1AWmCOn1uGNtBzrY88qZRY9AXN4IgVovBe1qksiuBmVOlaZ/0QEFu9+pqZmAurllDvvPP67VZO9UMOidpPGwJMKL57rk8WrSOfl8TG840tZni9pyKU9s8gtkvZtSHX6Ug96cBH0YTsT0xLs6iGX2MHrwFnONtQfoRLNnm7LBDWv9WcoVlGNsHA52qlyIWPj1EaNjRUfOC1sbrK9zFchYpTPfbnQ9GGvgfSiKQZGZTiTQdiaY5zlc33AXQ3hT31S6COuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU6YVPu5WAHNz0l2ScFuYu4jvBsuPzFuUf1j2fI7IJU=;
 b=gnckeBSsZquhkXE8odvRqghP2+ak2mO89TORDMl/mtrgMwbkpiUhC2qRpNyNpPzGjalS0f7IukB/BN1RP3l8kSAyHbKDSro8jtPPtGprEkoGqOKqvO/lvTeUpk960L0y61/f56Z/UQKKF70z7+FgGy3rnTygjKay+laAJXopT/toyt/Ve/nrD3wP1ufH/qUAP1VFUeEgdnfSQf6nYaktxc1ruOvoqtR5xGtBw1W56GtVya5DW4IvO0vQ4IedJMUQA7ZPSNs/wdZdBYkJL25KQllwZgZQcdd11Rkyn+b70Dq1HSwcANr0Yv5o4m3EKo8gvPHeOj3j2vVvNfVX4/ukRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU6YVPu5WAHNz0l2ScFuYu4jvBsuPzFuUf1j2fI7IJU=;
 b=h32b92nGz/cglmbEydZAOx8pwb9VpbMLdP8Y5jz+5EG7L6R4b8a4+R8k7uLuZ7JP9zhXTqLqaUB2SkmxHC0DHBnclEsiE6nqTP+YJfLRgJX7/hxnyvcjdd9vTZLUz71IsuBQ6hNvhBbgnXsllk2GnhNMx9u3upmWSyeNsT2En4ONVm+gSk8N4T3qPsE/S9c1NjKidE3mLmi8P6TdDOyxsShAqOKtPebxtKl9v0GYJYcH/zdxeLLMJpFBr5wQVDTYq1oILRq95WN0zNMAe0s3ctQvZfo2TQDHOlwPCuL3geIDbVsD/ADzikIWRAzuzIjqDlqOiD8ktn5FaMgKzp8i9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:22:20 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:22:20 +0000
Message-ID: <791bbd24-3146-a5ce-db7d-ff0b95a08e6b@nvidia.com>
Date:   Fri, 10 Mar 2023 09:22:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] hte: Use of_property_present() for testing DT property
 presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev
References: <20230310144706.1542365-1-robh@kernel.org>
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20230310144706.1542365-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: d226e1c5-c188-4e6d-12f3-08db218c00f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umKMC4hWD4lbkGl2wXKEQVbteT2ZAgx54tQ3inLRM7B7GQY3kzvq6Hk171v3Z4HcSSnm0xPaNlx+aFoBKAX2eoiUKMebVkJcEfy9BBXj7eaHJhGDvnJA0lLQEpQ4rzzOdNjo9s7TJO7eKi8F3II6XPEGhwqRZJ0jRyQHXXrpz7qKfgXWMSLboLjT1P0QQyLzH0RuaOHNK/U+k3BWAQ/HOWsb/hPHvjzh0BIECpcN0ceam9WFRhYfM173wJQMimjoT9RykbY0aKjkX5QtaduyXsngyz6pZIysjJfchGTkOATffp1VjUGC73T7A67/+bH+QjlrxHK5TMCBKW92Q0F6qDxMw2+SSdoufpPdmnf3nX8zCyB6nbCA909iHnTKbAfzOR8uIV6PAEw/VJYjjmyes3qfyE8ZjWdub9es98+7oiiPetChtunzlEK8iNUDxgbu164w4bzvkDqXjEkfEoRP1p1uIxyX+wKu/6OamOT0WXR7tBfn1bj8+Q0dW1YPzAL2nKWwgkfIh+fMQaOrOqJZvjp5SHkgM+eJ3IHwlIP2fRSJjKbs7o+hDrtnOKTq2bdOskJCgYt+STAKcJ2YrmA54s3EJ7Gc5NYvyy8oN41IRQB8L06nsF6SwZFmXqAvU9sjPGra08ayHwGaHsQmbGZLG5Q1EoS3jWlNt4WPEtncNK8YC3WdM9XcD6u3s6cmV1e/OEOssPqsPAZF9Qtzz9/ZctS3xEB/ljWBINNz3adDCK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(31696002)(36756003)(86362001)(478600001)(53546011)(66556008)(8676002)(66946007)(66476007)(186003)(316002)(31686004)(6666004)(6512007)(6506007)(26005)(6486002)(2906002)(6916009)(38100700002)(4744005)(2616005)(83380400001)(8936002)(4326008)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTYvU2RRUmlPS2tiLzVyS2hESmpVVDdGdnRHN1UxdHdYU1BMZEx0MDFERHkz?=
 =?utf-8?B?SkVKZnk3OTVlY1VqNDIrV0lsOEs1THBHZHY3d2ZSSWJpMGV2ZGNGZjVFZzND?=
 =?utf-8?B?bUJ6Vzk2YzF3WkVRRVVtNDZhdmNGWHE1V3MvVEE0ZXBwcnNOR2tZc2UxY0pt?=
 =?utf-8?B?b1JZci9xRkJRWVBoVnVDOXY4RXF0Sm45cjB4MHV6eGNBaGJKMk55WU1URWlC?=
 =?utf-8?B?Mjc2eWduakNwMnZqYXZWdkpzbWRQcDJSMkxqN0I2WUkrZUt2TWxya0tLTWpu?=
 =?utf-8?B?NEJ0NzB1ZEo5M0hNNFFzdTh5VWVpdnAzR2o3eUh4Ymlxc0swRXpaL2hrdnRM?=
 =?utf-8?B?eWs3QUpBU2tMR2FxZU4ydzVhdlhUN3ZLRnhuNi94WUdseVN3bzdlaXJUTmQ0?=
 =?utf-8?B?MzlEUnVxb3VHMzdkY3YwSUJQTXBCVG5OMTlqTFo1a3RBSlNZMkg2b0NNVk1X?=
 =?utf-8?B?dndmZ0EzYnkvR0NEU0FRODVwNERUdjRrT2FKa0tqaW8yaVdMK3o0bHUzOUNR?=
 =?utf-8?B?RFRwTkdlUWpDK1BoNVVRYkRjRXZzYnFpVUlPRzU2aHg0c2V0eDdlVmplMDF4?=
 =?utf-8?B?UkZFWGxsUHo2akV1MkVWUlBySzNUMTAwaTFtZ3pOTUJpOW5USzk3SFdNem40?=
 =?utf-8?B?c25hR0QzbmhheW9vNTBLaXE5bHp2ZkJuOGhjWTI3dnFGbTlGS3N2ams5SHhC?=
 =?utf-8?B?TnVGRXp2V3p3anRSVnNzS1Y2YUl5Wlp6RVgra1hqLzVDL0lXaS9PaG1vTElF?=
 =?utf-8?B?TDlXNUFWZC9hNnlGcE1aUXVqRU9MNkJkY3FseGJvVHdONUc3QnplSVpjMzZT?=
 =?utf-8?B?ZXVUZGE3K0dKcVJDU2RxTWVGRGJkUmpnVTNuQ1FZVDRHT0hDR0dmWXFCbk1N?=
 =?utf-8?B?NDR5czJLZWZ6M3FPeFVzRkpNSHlOUjFFU29QZldjWmdjRUZOWkVjbFZQZ2di?=
 =?utf-8?B?Mkxxa25kRVpVa0hIWU1IOWc2b2tmbklObFZPb0FXV2FjSno5QU9uV0hBd0ZU?=
 =?utf-8?B?bVBRUDdidU1lM3hmL3VCck1NZi9SdVRldzJoUzFNSTViNzdldTZ2ZGRjcE9U?=
 =?utf-8?B?YWIrNWFqUkJLanVOdlBhRGhJUkdmWWZ3ME5zYjVIdHNlZlZXbE0rLzl5NU95?=
 =?utf-8?B?L1piRXVWZ1Z0TG9MR1ArRzZsUFRUSTZMK1NCbG5TU1Q3UGEwalZ4TGk2VWFm?=
 =?utf-8?B?eXNzdHduUSs3a0pOMmowZ3poRzlsVGJDQXQ1R2J4Nm5TY0VpeStKWHE3UDl2?=
 =?utf-8?B?dUZYb3ltdVlNdVMrYnJqZW9Vdi9tMC84aTZHeTlxbEtiQlNDa2k3L2pwcjVU?=
 =?utf-8?B?dDN1aFNMcXVPL0RrMXU5blJqL0l3YTVoNnUyVjkySlJPTUc5Q2kxMS93VEZ2?=
 =?utf-8?B?dldQWE9hS3J5emVJc0wwSEFQKzF3bGkvNmV6RWNjcmJTMHlzV1Q2RDAwSzNT?=
 =?utf-8?B?MFpJZzRtQkx6Z1FFWW1KT20yMFJsVGlJQnlWZXZraHI5RTE4dnNSSXdQeEhN?=
 =?utf-8?B?VHVYTlE2SytVMS9lMEVqVHFodERIVE1lM2VWMEd2UWYxZzVJYy85QkF5TDV6?=
 =?utf-8?B?emZCZlc2RzBHZGZkNEJDdkxHY01ZcitpN3l6OXoyM1lpTHM4QXhkejNKTlZK?=
 =?utf-8?B?aTNRNktqckd5RUFCMXJvaU9BdVY0L21nallvL0hrTGNOY28wY1BXc1N1NmhP?=
 =?utf-8?B?TTNFdEtmYUlxbDYreTVUbnhGK0hHZndkWm1GcTNTcmZoRVJreE9uczZiaW9U?=
 =?utf-8?B?azZiVmx5MmVIYWRjOU1sbGcxVFVWdExodFRDbUREbERYYmRRTHFJWUtrSlNz?=
 =?utf-8?B?TE9zVUVpUkZSbGF3VUV3amFzN3BBdmZ1UFFiWEM0QitUV05KUmNwRzQ4VTEv?=
 =?utf-8?B?UExwamF4TUZxZEQzQ0U1Uk02WFBnL0Y2T0RBWGFBL2xSK3phYmJPbVhKdmxv?=
 =?utf-8?B?TERlSnNWOVpvbXRHd0M1bDI3ZmovVkRvYi9wMkh4OGRqT0dIUVp2dklQWVov?=
 =?utf-8?B?Y3lYK2w2ek51aGNJdXFyZkl5RFBmWUoyUU83dHZVNnROZ0FyODB6c3FLQ2VI?=
 =?utf-8?B?VXpCVHYzeG5nQVQvMVlNZXlxWTRPekV2MVp5OVVqZVhpTU01Rmc1ZjVlS1kr?=
 =?utf-8?Q?xEvWExOro32JzIr5hV5KU2IFt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d226e1c5-c188-4e6d-12f3-08db218c00f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:22:20.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+Pfcr77X1E60lTi+G//PHsgbAgtF+g4PAh13NHkAC4nieBBHhV4MLFhatvOo235lwmwN8mdj080JCqoWCBDkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 6:47 AM, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/hte/hte.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Dipen Patel <dipenp@nvidia.com>

