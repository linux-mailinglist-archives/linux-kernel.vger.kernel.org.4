Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C472DBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbjFMIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbjFMIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:02:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413131FF2;
        Tue, 13 Jun 2023 01:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvgncqonQty9SlmwoKqyvkztZ+7MlX6/C6j6naTPjMeJ3o3oBhWloeIIPRryhU9Foe1A92JYjf3O8xKP+C0s2Cliwi7c2smW1/Os9MU4P7kx7AgiLKitVuJNCUQBCPwnn7xx7Nmbp/8kg71RTYoJTFkSsAFmFwlOoPUd0/chK58rlBrRHgyN/SBxhaE8vDjhgM3EcZAGhnmY9kaF8xn4lNba24GC6NCqGp/fc4Ttv52hhoJwKz3mJtRmAPeGBt7FKc7ygoRhJNVLoQK9b9XxGVvzWJl1Riru23oqwgVtnUHwaX0VjnbiublXRYZxTNvUg6EP7qbQp2C/SI5QI+jWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
 b=BDJ2bCwkLtHTFDagUojtEDURjYkrqwmghpxXQfGCcqFhTaC4Juge0IGYmtSygPQYtOyAIQW9GRRUf/ol8pGDcIhlgUps8cacVw9nIL5raoOEa59tUBhNCGMRE+ps9SCj57MJYUVvg7PmpdooW7lLUvd8RMj7BgxsAjITvckgT4QJXlvC7JDIqNSG0M72utbGCoRAYFhEIbUhTRe4iwqdgsElbqSqyHArm4bslTc6fGW28/ecmEbELrL5cpBfckIwRK9xnIFTrHB3GucslYiUh1heCZ1vQEeaGWagx4MovA1g3+fIIDmUoMxQQb83Og7baxSLlE23fvQzbPAZXvhrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
 b=TrV+Fy5ipErdoMF9oGf+oR2gQUfTXmRa1qguuGAfR8xK1jrGFuSY5vA77wKNcWp/eLtVTPaoPslp3SmEKTslGGxxwrSChAXoMTlFCRvblD01RO4t1FfEPp35eIVZumdn18Zx8glDhBC7+kaOfdegdgqoXzWGIJl5ZKclIAxQIDLEt/JodV0XVjuClqRye9KEWzDvwcn45rIaAla3NmRdNgQgqMaKPVDD9NhnbrSbjhgY2D8SUE6YFj6me0B/ErkazWyhnD404jjKqPyvn1rmgMlUzIiLGDGJe2jaNwGeGeui6K7JYiLaPpeXMUgqTbCnzd0mos9XaUn8Uv1pJT9xog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6667.apcprd06.prod.outlook.com (2603:1096:101:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 08:01:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 08:01:58 +0000
Message-ID: <b42482fd-debd-1939-f129-4867017f0ce2@vivo.com>
Date:   Tue, 13 Jun 2023 16:01:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6] f2fs: support FAULT_LOCK type fault injection
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kernel test robot <lkp@intel.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230420062207.26879-1-frank.li@vivo.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230420062207.26879-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6ad287-42e0-4ea4-6c67-08db6be4763a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX3BVmR1u0JdKn7W6IQx2kz/sOHhUdDiCodi/Wzf4C1GUCLaeOY1Jex07nHC1XIxfdf0R40xa+y73JFC9b/3hbuRNC6YXyClzbZfDcMvjpDFwedRgJdN+/RThyAX5wbxlyIR4kQYKtg1xoX3Dz3U3C0OeEwhS/xAZOb5ANCSXq0YOtRMxxFv5iooS4/nFJO1EaCMGvG/8m5nprR7ObjZuPaPlcDrqFYGi+TtUVU/HmL8uIxnmGGO8gPekSVp2VQw+ewbQHf+gJVARhEZUJw4fngJHGzaZSRRJkLoRwJ29jfojQrfy3skdb64Wvn5pqn1+yf052MjCGBbzOeHNr6QQTKMImhWrgSEKApMwbvUdBhhX9GO0c3S5RaVNlSeipP+VdLfHduXBxR9+ro6oLklkJDHxwApgxhP8wmNAQEm5sY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(31686004)(26005)(6512007)(41300700001)(186003)(6506007)(6486002)(558084003)(36756003)(2616005)(66946007)(4326008)(66476007)(66556008)(6666004)(110136005)(8676002)(8936002)(478600001)(38100700002)(52116002)(2906002)(31696002)(86362001)(316002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hDWmRKaWtpRWlvMWdOZm5JMkwrWG9FVUpEZ3hCN3R5VlpYTUdWKzhNcDdY?=
 =?utf-8?B?WkpiMHN1Sms2MmFDVmtZZE1Vd3l0QUZ6a2hENGkxUFczYW80OVcyTnh0a3Va?=
 =?utf-8?B?eUFnTlV0THlHMGNMRWZldUlUQmxZQWNmQTBSYzJvV0hLSzBTTjZTeEMwV0ln?=
 =?utf-8?B?dEZ0dG5HN1hCNjE3c1l0b0lrdmwvT1BMQ3l2bWN4Nmg0Y0RFbitkdVE4KzlI?=
 =?utf-8?B?ZjJwWEM1ZU8zY09Bd0pOQ1gxc3Bkc1FBSjQxdEVtNTl0RUNlN1p2Lzd5TmpH?=
 =?utf-8?B?UlMwcm5jdlFWZjRMLzVqeGpiOHNObFY3ZlZNampFR1ZyVCsvSUgyS2c0K09B?=
 =?utf-8?B?dzZRRUo5bkVlRVRtSGxkVitndUZ1eXdyTnZzY2hUaDBlT20rRW9GZit4MUtZ?=
 =?utf-8?B?YWRGeGFPdUYxNkpWQVcwRVA5TS9xYzJHZ3lCSUhaQXNYU3R6Zi92ZkxaMGx3?=
 =?utf-8?B?WU0rdUxvRDNWZVozckFnZlFJSXZCejUrZklnYWdjV3l0ejRvTkZjVW9pY2RN?=
 =?utf-8?B?eU1iakVaZm5aRVB3RkVNUUNUQmRMY0lEeEVBMlJvYWFqMmU1a1FoY1dORFpQ?=
 =?utf-8?B?eW9IT3BlNHRvWUdOb3BGRWtpRmpybUVFendXTDNJR0dWQlQ4aW0wVmRHajY3?=
 =?utf-8?B?T2NYT25QSTd6dFdJVUREYzNDakJqT2oyRjkxQ0FiVnNMQmpCSS9GQ2pnVC92?=
 =?utf-8?B?VlpKVVhIajNycGJNVCsvZExEMGY5NDFlSkF2SmdxalJmYjh2RTMrSzdVSUxX?=
 =?utf-8?B?RVZmc2ZROHh5ZFMwYWFCeFJzMkhHcEhxTXFsblZ3am1JY2pmUGRmZEVhbm9m?=
 =?utf-8?B?WGFtd3F5dTBXVTUrcmhpZzJJYmpJbkIzczVBN0U0dHc5ZGMxcmFmalNRYkxV?=
 =?utf-8?B?aGd6cXRsMG41Q2ZpUUhYdis0dDgvaG1HOVR0Ky8zWDVxSkt5VC9Yd1huR3dI?=
 =?utf-8?B?ZTRBOW96UjVNeEJHVVFybzVweUd6UWpUVGozbW93QlhKSnB2dVN2QzYxMmY0?=
 =?utf-8?B?Ny91enUrenU0SzRpbHR3RnhsRGhCWHFveVRQZThOQ0xNR2NXQkw2WlF0ZjlH?=
 =?utf-8?B?STk2NHoxTnZIamVuTXZ4Y2s5dXpmL0VRRmxyMHlGNEVKY2I3cnFwR1VTa0tl?=
 =?utf-8?B?Sno4QXVnTDZlTTZON0d4QU9jaUpJYVBPUENuYzI5RUk5VXRYalM2S0VVNXhW?=
 =?utf-8?B?WS9OeGtqRDMvY3JnWER1Z1k4aFhQVENCMkoxaFVkSmJ6QjZrclc4TlBUMVl0?=
 =?utf-8?B?QnhaR3E3NlFXMURHYjErZktFQUNFd0NjK2FOWTM4NitmNU42SHZLRG16b0Vx?=
 =?utf-8?B?K1BoSXB3d05qYkxpTWFPNFVvUG9wSmJxOGZvekhFZHBMWWErdEh2NVlkRnBR?=
 =?utf-8?B?b0VnM1JiRktTdlJIVnZpQTNtWmJoZ25iNFVCZ25KV1dwN0t5SmJXTkEvc3E4?=
 =?utf-8?B?NEEzVnRhRDJUVGI3dEl6ZG4wdnB5d2pOZjh4SW5HUkxGNEJWOERSUmpBUE4y?=
 =?utf-8?B?THd5dGhIVWhEbmd5dTNmL2xvVGZQcWZEc0d6bE0rbmZIRlBCWGFhcGdCV0dp?=
 =?utf-8?B?SlRPSzliZlZkNDdSQVBZZUpWWmxITThva08xMkdKVHplYzJsQWhKeVB4MjVm?=
 =?utf-8?B?aEJ5aG1CSVNmQmc0cFE2MDU3L21nSVByNTBtN1FXc2VXM25IeUc3Y3ZlUjJo?=
 =?utf-8?B?U2dTSVFXTXdZWXpzbU9rbHNDWjJiSlI4M3Y5MFlhWHFSMVNoQUJQKytFcXdy?=
 =?utf-8?B?T241ZGx1MmVHbHVGUkUyVUNhQVBiMC96VVk2SlM2Wno0QUFtSEFFVVVDNWk2?=
 =?utf-8?B?aHoyOFpIWDBFeDNvM1p2U0FIYTIrc2RYbTBuYlhKY3c3NTVXMzRYcC84Vkxl?=
 =?utf-8?B?YzFCejd3ZEhFZFNaUWs4SjJ3YjI4Q0Q1eGNMTGZmVFhld2NFUUwzR1p3RVhY?=
 =?utf-8?B?SWVFaXFidWhvd2UyL2pIMWlQc1BVc2h0UHFIWllGNWN1ZU1ZVm14UTd0dzQy?=
 =?utf-8?B?WXdhRFJHandMeTJzVFZqKzBoT29sOGRvVzdMaHZEMWhhRG55aXFRZlk5Uk5X?=
 =?utf-8?B?eWl0R3dCUjRWT0RiaThCajVVU01rcS9NWStQSnE0SEcxNFJGUnE2bEw4Mitw?=
 =?utf-8?Q?5wnhvxCxUv6rIjIibv+FLAwYp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6ad287-42e0-4ea4-6c67-08db6be4763a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:01:58.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHCyy6Yin05z0o/2VpLd4f/HH4WummlZXZOi75hBf7lCuad21DukqxLSsj0jbLlBa4QZAO6KjnlNq/WI1Y5mlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6667
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SCC_BODY_SINGLE_WORD,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......

