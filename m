Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEB6D739F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjDEFKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjDEFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:10:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506953A8E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2CslUIOo1vlZ8Te8kBbu69axXE1N19ZKEAjzcQ0BaO3e/BdR6ZrGuWRnTnMNXve9voN+stx2aGJ0qmC/iDR/h1h99YC7aNBtVnd9D7uqIHPamEZuPe6z8SsMzgh2FwVhBKCCg8P5AqN9FG8Aqw8Ydp3vNn4GxHkbfAn5yVihuylKQIRsZYKbBrqojy6fAGOsDgcUUUhUk8O88i0dJMCs3XJFvfw3RtjvHvgwS//papase+CRFgSHJG6MYYTWEvYBRebL2UCNgxjZGjFPVa21KXDdnbIV/u38QULLRKrQcmEc1q7BXMesQmoBSWn4S+EMgJ04YoKXPrV3AUl54mZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkWVfdiC4JEYoqaH80cEInfoEK1m+rZCDztEzxVu9bo=;
 b=RzsioHpu4XA7mNRJDs5Qut+qC26NVjv3O4Gz1cdGhKCqDANnFtKAyh2nHPOhD0yCjSvRNDIOW0zxYHMo9HRsRWqOQS6GVBS8XV6DsOlHhtzuMqJV1J0roQ1bCixaoNyVvmVWVt034Ml+ChSZHDsVvezq1FEgnyL0vDFRTe0uzxAjtzKmTysbjImhlt2d4OHeDR2VVriiJRbsQYaLicvXwNMpCcUzBeq2ocKW7jBh26ZsfoFz1BmswpmbMLbseZ/3LG2mXTV7VE1yNIH+r98nxBylHiPAtCy5zNIeRIkABeqlmZbR0DYP2/GfgdstSpV8X4OEpVkSSWGJlB1R1TKSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkWVfdiC4JEYoqaH80cEInfoEK1m+rZCDztEzxVu9bo=;
 b=MHMqtjYE7uu9YjNOziHGRqCyUAjwGR+uhDYymVUC7Wg9cbDo97fVVerhffRSqiERPd7ebO5+PruENVlmL257IwQ0aHunr6Nn0hiJnt3isR3cYEel5yBXXCaKpbx7SV1yR0WMgjbOIlqa2IhKmaKQbBwYTs8+22FeWn3SIr7Qs28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 05:10:29 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 05:10:28 +0000
Message-ID: <51c2e42e-b1ff-bd1f-fdf0-e886e76bc7f0@amd.com>
Date:   Wed, 5 Apr 2023 10:40:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 01/11] virt: sev-guest: Use AES GCM crypto library
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-2-nikunj@amd.com>
 <aad853e5-2c82-c26d-da3f-f201ba1125a6@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <aad853e5-2c82-c26d-da3f-f201ba1125a6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ce006f-15b1-4c0f-7324-08db3594122e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44RgMw/bIdOBriVF6+qpSIt3zQbAJYBWgu7Xe5oDw0oWothSbEFsZ83AYFfyk7QLLVmrTYdsiDaS4KWRe8i3cwpvxyA1FYHY4Qc3A2yCRGUhbNkCir7Hy2vRIubYbsSRhbZr2sWQQ0HSSba3S9GQA2EzUMcTg1uLz1qlySruetUbUPM1xyG4cRLvW+MTfFc7kdDnaa5LtLGoUVo3zCZPxTFwDmWBDwIGksgTSQVaHam9dj/b+RpXnoY02suF/SC7ZY+GE59Thj4dkGOvjAv7ILCTrnqqhuVJtyRBMrPUo/VzSQ0xCEVIi/AATGXqI+pYXHDkI9D8a2jOfN8pIGM7jt3mBOnBvdbibMpDm7TC812VhELIXE+wrJBPNsxs/BVya1l3YI2JLdL0ypDnbzTzdelic+H6OKtm0D/6ASCeHyH2ZAsqyblv+m5E/bVQ0DlaCKZ1f70tv4ZDIPmbv1tW1fjC3ydWzd/Tn1CnBWGhr76CLhw2S+WuEkx6UIQqjvouK3gdq40lAoPv7fAIaffhlo0vWDCP9MDdeiWIDFG3rbBpRbo2MfXKoB7GqcS/OZCkj2sdWsHdD0Em3R27GJtsNHbkPHLCq54oPBQhg0Vvn5k9rIvdaGa53/Savtiu+kwzIuDZTy0ZZ6l+NypFU9MxIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(31686004)(3450700001)(2906002)(4744005)(38100700002)(5660300002)(66556008)(66476007)(8936002)(66946007)(41300700001)(4326008)(8676002)(316002)(36756003)(2616005)(83380400001)(31696002)(55236004)(6512007)(26005)(6506007)(6666004)(186003)(478600001)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEVweXNNamVNTXNsSEsyc2U3SDZXeUMyTFRqNlpiRXlBK1crVm95VDJ0MW5y?=
 =?utf-8?B?ejlWamRJWDkxUW5pUWNjaHBjK2tINkhxV2dOTXFkL0t2S1JseFowOEF6d0tp?=
 =?utf-8?B?eGN3TlBLYmg4TlpKdWkzREppUUdOdDdNUkRKMjZESEppMnA2WVJmdHJFN1NB?=
 =?utf-8?B?OVkwS3JsYU1xYnB2ZzhJV1AyRjdnRWcvTGV6WUFNTldCSkVRNXNRNDk3dGxW?=
 =?utf-8?B?Wk05MUYxUElVSUl0TGpFNW41a2FXdjNxYVQzcnlMOXQzdFBPeVRXNGo2TjJx?=
 =?utf-8?B?dERhWjhzbkFvNG9pZ1c2d0FpOVlyUENDZUIxc3V2VS9rZURhRnlOY2xudEJX?=
 =?utf-8?B?STB0ZVZVY0pNZC8vaEI5cFFIek1EQWdKZkUzcytUNUJhVDZuS1RDVC9MZWMv?=
 =?utf-8?B?aDJRaWp1ZlRCRkdMMmV3RTNLL2UrcEFOck9ISnZsZVRsR1pNdXBQaExGVWdy?=
 =?utf-8?B?TlROZWsxKys1NDh6eXdMVjhKU3hKdWhuaEFialIreE96djNXNzF0elp4K2pl?=
 =?utf-8?B?TXRVSjM4aDNyRlNOenpYd051bFBKcTZ5QkQyMmNPVHJjUVZIZzJ1R3BIbnhj?=
 =?utf-8?B?SEdMZGxGNzNoYVFmVWRLeFF5WTI2cnR2QWNVWjRLMUtkc09zMUdBaUJkSDQ2?=
 =?utf-8?B?Z3pDTWk5YnQweUVyK2tkT3NhN3FzUzAveU5lbE9Ya1c1SVhVa1RJNWFPMGdr?=
 =?utf-8?B?SFZJUXZ2MG9aVFpldnhCMlFPS1M0Y3h3QTVwV0RnRXpHN05DdGN6TFU5c1Ju?=
 =?utf-8?B?TzAzNmJXcEppalN2UVRqWHZoQXpseHV1UGg3MEhISE1zQndYNzBYMGVFcU90?=
 =?utf-8?B?bjdrUTN6SWh2cWVLM25XSUhkTWpNRUdsRjR5QWdNN01XY0FXZlI5K0M1cXNS?=
 =?utf-8?B?OFhNSWJNTDNsQ2FXb3FpN3ptUUxiZHZWd2xiN3VjQ3NLVWtHbTFNcm9JTEVI?=
 =?utf-8?B?NlY4MStnVlZZaVZYSWNSTHJ0NlRGRG45Y3lZUUZWWkF6WnIydDAzY0FzcXF2?=
 =?utf-8?B?UjFwdDNtTmphclBwMHg0dDNzKzltSWl3NDhWbk8wSy9WaGQ2R2t0cm1KQVhp?=
 =?utf-8?B?YnA3aWRJNHVRMkdrVGxnRDRTeGFWdElER2w5c09OWFpEbzMvMlNHdHlDQ3FC?=
 =?utf-8?B?VTE2eEQrRmFxZVBMYlNlN0pQRHdJVGd1MGpNT25lc2dQa2w0c2t5S3ZxTXRn?=
 =?utf-8?B?Y2ZqVkwydjBJSC9YSVljVHJ2SG4zaGFjcDhYbVExazByd2Y5Y1lDUUJmdk52?=
 =?utf-8?B?R1hVVnZYdC8wZ1FRZDJtejhZQnhpNXVYSVQveEJKL2ZUQnpzUFNUMDBxZlA1?=
 =?utf-8?B?cWtKcnhoMTNlQ055RUI0SjJObGxla08yTm5kUUptV3VpQXdnQThTYndlSkZN?=
 =?utf-8?B?SVhERkJKVzZ1b2MrcDJLNTdDMTRFTG1mWlM2NUluTkJ6a0g2WWFrcnpySnFy?=
 =?utf-8?B?N3g3cEhacU5sN3NXR0xCQmRRcWlSTmxVbDgvS0lLakdmS01HclBla1VrRUZI?=
 =?utf-8?B?SVowdlJDMjNhYWhiVWh3ZzVsczZ4RjBTU3cyMElXZ1hKZUw5SkRIYURYTUI0?=
 =?utf-8?B?Vk81K2w2NlJ4ejc0TllyWldPa3IxNmRLZ2tsWUtWSGIzcUxuaUJVdWtjd3JE?=
 =?utf-8?B?U3orNXkrNE1zZ05tL25TcDFwY25ZSnRDaEYrK3ZhOExuNU5Ma3d6cWpXbW5w?=
 =?utf-8?B?anRoaXU4anBvSzNFYTE1T21SMnd2Sjg5bkRYNUdVSzJEdmdZQTUwUXpXalpl?=
 =?utf-8?B?WXk1YkxUbnQ1SmJWR1ZyWldsSVNBUkJWcFNlWjFCUjZIV2lZS0NMNktoUDQw?=
 =?utf-8?B?S2plL0NKYjdSVE53QlZBeHczSWJtTHVlNjRQTkJRNWhJV251emd1MlczV3VN?=
 =?utf-8?B?WU44VXY3R0dpZVVHNDcwdDhGSTZFOW5zWW5GZTBzV21SUytzYk5VRmx2dkc4?=
 =?utf-8?B?K3YzcUp1NFRtZzdEQmFwaGpDNldUS0dGcmQ2bGVFWVFCOUUwaldWdG9XNE5D?=
 =?utf-8?B?RzNCQ2trME5GZHJIWDZscGh1eUxYR2o4QjFCclQxaEtBeWNEbkp1QjlieGQy?=
 =?utf-8?B?QVpicFl4amVGZnhzczFjTDRLWlJZSHdENFo0emhuUFRBWVMrS2NCejRjbFZP?=
 =?utf-8?Q?D6emDmg0xsyI/zw+kHp6dESf6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ce006f-15b1-4c0f-7324-08db3594122e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:10:28.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvv5G+JKhy0aKP8rARyWDOJcOVXt67l66/IbT8PnuyE+fLa36pPmarSWP80DNXpXcZjJyqCZXdOna3nvpBeE0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 12:39 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> SEV-SNP guests with SecureTSC enabled need to send a TSC_INFO SNP
>> Guest message to the AMD security processor before the smpboot phase
>> starts. Details from the TSC_INFO response have to be programmed in
>> the VMSA before the secondary CPUs are brought up.
>>
>> Start using the AES GCM library implementation as the crypto API is not
>> available yet this early.
> 
> This isn't quite true, yet. You should add that the encryption code will 
> be moved out of sev-guest to support Secure TSC, but to make the diffs> easier to review, convert the Crypto API usage over to AES GCM library > usage before moving it.

Yes, will change it accordingly.

Regards
Nikunj
