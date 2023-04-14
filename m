Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F96E1B34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjDNEvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNEvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:51:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1413844B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmQ1A5u+yLzqma3Qog6lZ24qGqoI5R4WwH91YzN/pooWDZQkkzfeipXNTzM0n6s0tqMdn76JCz6NanHEr/xXuTqGFfCO4CMk76feK+Pf0HHyX3kgB4mfyqTu45gFQEjQvZRTvP63g+RDB2dKt1EXSrw4QF+Cb2HgX80orMjYiwLKgcYN1TxvOCQeGIf01AG6gm/ja8TIdVYTKg15P2F5myAvT16+5mXDRigN7oQwENs3CYPw3XS9BxMqBu20VmafaW1iBKIlq1gOnKtbi+f4EgwlHtW/Oa23UuhqPDH7A6SwzCuZ+7aaAw+aU8hp8vvTRIIkcqLpzxj2QFELO+QZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2x37CJb9F33wUYorwOHXGN0b+IlAyQLCRmKjZfoJtA=;
 b=SFkJ3sskFGFGppQReQPk1Sy63n3flNo6WUGkOsarFT40kPLhqBPieYX1fni6hmbnsoYiHm/hkrosQn86PgnWk7TiOHRJlNgZHZp/SySztt5BNjtox8t/dbqFnZqPO6H4IQ8E1WtZuAXIyH1spbNCUWeIyZfUVpu/I09lSnnv2Kkz7CUVITXBAu28aXNOBcEMFxSkFg0W+Ydh0jOtqs2coSnd7R4fSS4HylhcvnbW/ozsE7EMRckSonlVwAMjJmnTkyq+E4zxMLfOMgDUm+mNeqFF2NcMIky41cDEy8zGlL4KZknOhia3dYqpPY0mBCe5IjJWvNWfzYF0nhOJ7cBwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2x37CJb9F33wUYorwOHXGN0b+IlAyQLCRmKjZfoJtA=;
 b=ty30+DNx3vpfq6O6DVNZVuf7m4OoX4aHmcyTApS6sUvrL1neCDXFLL8x6C2qGUelbSvWj/zBxdA42iq27+P0gVM6CUXVA96FY9hnTqKxxy75B4O4PNBVTspVbDMNe7dUBww8VToWBE4jFFb+qlRFxWjD1SmuZpSb5e8KebirGiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.43; Fri, 14 Apr 2023 04:51:29 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 04:51:29 +0000
Message-ID: <20a75a02-e4ae-9467-49ff-5c3791bcf9b1@amd.com>
Date:   Fri, 14 Apr 2023 10:21:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 04/11] virt: sev-guest: Add simplified helper to assign
 vmpck
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, dionnaglaze@google.com, seanjc@google.com,
        pbonzini@redhat.com, michael.roth@amd.com, ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-5-nikunj@amd.com>
 <CAMkAt6r4-8zwW8_JbTG6zK0DFG9PVX5Z50Xrq1C_fLBCdsrqdg@mail.gmail.com>
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CAMkAt6r4-8zwW8_JbTG6zK0DFG9PVX5Z50Xrq1C_fLBCdsrqdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 0887eaf0-f3b7-43b1-8675-08db3ca3e889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1YD+IgFTpbUhhWVlGXsELtFmRlPQ9n7qLNv07laq58MmzmnRBMCDXEb/XhQmB5DP15cAV/NvaZapL87i5e91eqapPBcGixLqGh1xRduf6FVBD9kWyJUkCcw+nCgAkP6Bvh1C9vzc8McimDRSAlkiTDQoiXyTcE3WFhAzalEoac7541UQAstl4DtCzFAgIqcUJPZgzRpqhWL6Cq8Pce0AQYSdW08Y2Zl8YLFLe+pW/vcFbsYfACPx1w9WBh3g0c7YCtHKzrtjpC4yD+FEBOeXS8oie2wqJpOuxgMBfxVI4HH/kV2QwvsO/a8+Dvl/DeZiir1f8tKUDemtU+YQR0xkn4aWH0R3CZi051SJKGOSknmiPAQNjjzyXf7Jvj7RbDNBoMJDw8hilmKF24LgrLC2ZVBbyeTEdwkgDvtUTo7vDnkx5SgktsPXZCyJrRj39W95/MNnGJK43WDejDfyVkW/cxJpfOf/awBGQS3ygc9BnHf8KNOQUzzaS7BpEo+YgAZUt3WKsR7XlMWlrQbPn5NnbZMqXQxSATyoWyZtSWS+l2aUalBmxRbXmEwuA2LlQKMHXIxTNQZYu9RFRwqrQ21VJ9WoIanEYgtAx7C+815iWcR18kreqw7SkkFrv0zkwhvvaUlYypJUsLk1hgnY/+Kx7IHepdGEN0t8ZiIxepysew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(316002)(31686004)(3450700001)(41300700001)(478600001)(4744005)(38100700002)(36756003)(66476007)(2616005)(8676002)(6916009)(4326008)(66556008)(66946007)(6486002)(31696002)(2906002)(8936002)(186003)(26005)(6512007)(6506007)(53546011)(5660300002)(6666004)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VsRTg4Y3g0alV5MGNiZFhIakNJd3JtaXRSWUJUY2g4WUxlYTdMY1ZRMnBv?=
 =?utf-8?B?R1orb2tPZk1XVm53RGJPQkFNNVVDQ2toakV4alpTRFlDWUsxemtWVzBubkcw?=
 =?utf-8?B?NDMxWTJ2QTNWMzFxSDdjalJhbmpLNkpFdlFDSWJud29aOHhTemp4MGhrenhN?=
 =?utf-8?B?NTk4NVQzbDBBKzhTb0Jjai9USUdMcmQybGZubDZJdkVFQ2JkWnp5aEExb1lX?=
 =?utf-8?B?K3N1c0QyRFRXVzJDME91c2hjL0Nxb0xjSHZtZlNZYmdjVmFMZmlIZ083UGRG?=
 =?utf-8?B?c1BxZlpiOGw1UCtLTFd0KzFoemtyODNOUFV4NHJjKzdjWjg4ei9BTStnWjBJ?=
 =?utf-8?B?ODgrZUNKREFQOGlhR29vc3A3V1VrN2U5QURPMjF4UjlPQ0gyb0duRGVXMnRO?=
 =?utf-8?B?akhqRGRKSDJveS9yTFlFRHJNTkphM0RwbkFZQXRzYXhzS2J2L1BnVFdXSGNh?=
 =?utf-8?B?NkVuby9OZGVEalRNejZaTHVsU0xVbHdzZmZSNnI3M09FRzdKOC8rYXhkMEkz?=
 =?utf-8?B?ZUlSUWpWQmowQVJMM204bkJ3VnIrUmQ3NG9zdzVROVhxVlZDejR5TlFaMWdD?=
 =?utf-8?B?R2ViSHZ2VzZhSTVpcTc1Wi9la0YwR3loYllydmx0dmRjMmtOYkZFdGN2WXBE?=
 =?utf-8?B?QzEvMEo1YWNEQ1pZUzM4bXpDdTJrYW4yN0tIZ21yNnNXMkZLSm0xUzlVTVZl?=
 =?utf-8?B?VVN6ZkNoeEI1MWNoTitLdkZ3OU8vTmxDOSsvdmJSTUtBWXVIYUhJdTVEalZs?=
 =?utf-8?B?QW5BRlZWejlFOCtFNyszaFhxZ0lpSjFjRHdMUS9jZDRJMHRnbjFibmhGMXZY?=
 =?utf-8?B?dWJzT1RNNHdZaTRWQ0RjT0JDSk1EMCt6bEc4NllxWm40U1dUYUxRMGsybk4y?=
 =?utf-8?B?Y1NwWTc0V2c4emtVVHlONHVMc0dsYnY4Umk1SVJCalRqajJtUmZrZUNRbk4y?=
 =?utf-8?B?c2FYTWZWZ2JDWXJUVmd6dGt6a0ZmVlhWYmo1Q1NNU21KRU9xMkFKeWhLWFVU?=
 =?utf-8?B?ZXYra0JhSXc1SVJyOEdQV0hPRy9mQ28zWXY1SDFwRUpTWW0rMWNNcldjOVJO?=
 =?utf-8?B?eW9kSWFsZWlFRXpCUzZTaXNTQjA5eUVxSVpHT0pabVBkQ0hGMXlKY3R5eGtF?=
 =?utf-8?B?NGU5U2dXcE1HTGxadmFZcXZrdTdqK2FiQTRwMENXRTIzSDhyaE8wV1VHdFNq?=
 =?utf-8?B?MmhHdldSb0U2akdzQTk5RXFkTmwwQTQvSDdEK3BuUmdQdTMxMm43ejdWZmZU?=
 =?utf-8?B?TVRGN3IxVTdrajU5T1NWN0FUR3N6a25RTllaUDdiYmo4R2ZWSWFPczlzL3Q0?=
 =?utf-8?B?dlNyQ3NTc1hoemtKTWhReUtndUV0WVRBR0g1dDhSZGxHb24rOXZQQ1VlM1gw?=
 =?utf-8?B?ZVNva3pGbjh3T1JpMDIrTGErRFNic1hhWUZGMTUrYnhpb09rdCtpYmtGLzZI?=
 =?utf-8?B?TDVNd1JBNWxzMHJjTWo3S29GZm1tVWxabnhiekpxaTlkTzRuRHlUZklFVkpR?=
 =?utf-8?B?ekpHY1ZFNG5CUFhwU05KZmhTWGY4dFRucXhUTzFNcW5LYTR5ZlNuMWdYWDky?=
 =?utf-8?B?YWpRTzhjSzJkTW9aL1dUMW5FSHFxS3Q0eG9rZFY2Q2JZbWVETkhYNzE2MXov?=
 =?utf-8?B?NU4rdXd0d1BULzZWaWlnaEdSVUFWU1dPREVaR2g0NUJWd25wblpram1tSTVr?=
 =?utf-8?B?aE41RldkRWVwZW9KRnlSRlRpb0YrcmZTQUtUTEU1dUJnV3ZBZUNsM2YrUWNK?=
 =?utf-8?B?eHA0MEplQ2NjemVQbko3UE5CU1A5V080YVhUek0reTAxVW5ja0VXWFc3SnR5?=
 =?utf-8?B?ZE16TlUvMDg4MG9QaHdVMFUwZTlWMDUvUWZWVHRmWDVZS1c0a2VtL3M1Uzhr?=
 =?utf-8?B?SXkxdjdacDVSUmIwRjE3N1Z1RURsWk9xU1NFdlZHelZCRldTa3kwYVpCbGdP?=
 =?utf-8?B?aVlaVGxMZjdyN2c3eFJjdVNaTk9UekluVWE2WWNIeHl3SUtCQ3JWb0VLTUlT?=
 =?utf-8?B?YVBJSXZKYTdzQjNzZ2dIc3UzSmo5a2FqZGJTZWpQaWc1NXNqUEFraXE5cDR0?=
 =?utf-8?B?VTQ2cGpxK05RY05Lck5idHZ1dC9yNEJsZ0VBUStqd1g4d2ExaitwaC9tbnNN?=
 =?utf-8?Q?Gxqhg887M4Yhooh1dlj5y/y6N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0887eaf0-f3b7-43b1-8675-08db3ca3e889
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 04:51:28.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvY56O61XkKzYypQwSFG1IgeVqxT+0zY9RWdLs+pvb18D4GHo7vRoUatNbFy+A5K875HhI6/1PB9bw93bGEiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 10:01 PM, Peter Gonda wrote:
>>
>> -static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
>> +bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>>  {
>> -       u8 *key = NULL;
>> +       if (WARN_ON(vmpck_id > 3))
>> +               return false;
> 
> Should vmpck_id be a uint to match the module parameter or should we
> check if vmpck_id < 0 ?

Thanks for pointing that out, I will make vmpck_id as a uint.

Regards
Nikunj


