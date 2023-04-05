Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134736D7505
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjDEHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjDEHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:11:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16826BA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9tMbxyFYvvFpikJFBwQSglMnKRru+6+qzBtBGoXyX1Jan5hIrmfpEic6UiJwEjwdcqN50hwlThqPLmAzfFTh1dFvzPntQ6ZnxRo/HDV3Ur0cjqGX7u1WDIbY30Yxp4kD6Z34WgYlVLJQuOrGkQnxbF8ysRDS7b2C9Q2xun55sqjGM5rzvoGR413J6B7EYZKhxF4b+7t3hGNGbZQHUydrsn1dBtZBPZ6wziSv/oe0mpgTp18TmiIqy66cUl8XIyFHwRiNQ8aA4NdS4AmXukrmWVnussYH+Ic8RyX90+/BbUfc3Nk2tckX6VZrnMdrvdra7uONZV9ctM//5++ja/ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py/bOUzCKnahuSxzYeiucqzsK53qXwZKUEq9pUdwfmI=;
 b=nZV9YOzSr0LF9pdz5GweKLX4xadhHE5NhYEpLKfOpvzMdusOT+7OlLEz+LUy5aozng5BUOJdixaohhJCfA9pp8UfOYCBV3AC1AxdXecGF9KFQ1RquTnAwJNcl1ElC4L5LJVDHUgv/J80nT+4pIiknFajCGSCiGPniPPDZHG+FpSPAnl2iVOPg6F1OETFcBgUNGOtRtES6RMMC6K8UeROk0eLXkyL8C9CnQK5aGwCQZbVER9TlUDs4E234jdO29RmvxxOoBXPmwW/N+ctbAMJgvi8yUz5kyV4sdVoAhowUD5KVwYreCrM/tEtCKi2ht/lC6v8ljd85W1pqBjZe2ixLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py/bOUzCKnahuSxzYeiucqzsK53qXwZKUEq9pUdwfmI=;
 b=INwWSnXUoElME4dIfpSVInGrX2B5YCA9msxSEN/cnfEktlnu67DlpDJkzS1DZ192uQ/C9JWmERIV2KzNjbVFdtQ6nGj/HPNCIMCF8gMo+E/0Yke9zsJj5M7mCw30Ybk6GGviHPikz9rvZJbIQUC4/V/fPjkzr9DtCimoIFFsGtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Wed, 5 Apr 2023 07:11:30 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 07:11:29 +0000
Message-ID: <0503fc9f-4f8d-cbce-dd2d-82a1915644b5@amd.com>
Date:   Wed, 5 Apr 2023 12:41:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 05/11] x86/sev: Move and reorganize sev guest request
 api
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-6-nikunj@amd.com>
 <409aca23-d2e5-b8e4-b6f1-a23e92c49b83@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <409aca23-d2e5-b8e4-b6f1-a23e92c49b83@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 29168656-a3d9-44a3-b654-08db35a4fa26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvkZlkKhthTJ9GjG+wrimjOfotcG8ieUaJpyEMv+krruaHd6FbqjF+zZp8xpL4yT5slNfa1Oxrd3tlhQQtTencWc41YRJBg6HBoSmKLhgmgDJOeipSVAUsvUqGyCX1wchksybxue/ApBj8BsAd0lxs3EyMMQqi60JBR0zJkzxORgmkSo3U7fhvM0FEz2gnZjC9ImBvlJqn2RhpEMcayymbqt6e9O2cgeeUZXm5Vr/VkRpMm8/zaK1OD9P2wyc98zGU+4UUG0fwpRLTdiXkYaoFzAVpzZejibcp1rifAEaM4sYwLoaMgH5vke110tKW0WkOun43ASH7PD8CE0s2Is3vEh+Ny3K0DWjPg4/AD0Ciq0raD6ZwLzDsrhOfLEu3X9096q+pz9ea086Y3SOaLpCNzKUArhOQM+7dlYuWAFLrt1MsOEgLu7AW1jSqsryBIycqavS56fM8cagbh0gj3yr2CclBUruKiNmdieo1qb45UlD4CcCmPX9VQcmd4IB56mw/MxXNpjPXUAmqux1YdFZStXbGzrRC2//NvIB3NqN/58QSVz8d2D0EZtPovbaPD9eZ8O51KurYQcmehgK9jgEzdIEScKTowWJKi/ome4SeB87jrz/oMFY3X2oImoCarOLbd7SzP8LyfON47jmmP0uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(6512007)(26005)(5660300002)(8936002)(53546011)(186003)(6506007)(8676002)(2616005)(83380400001)(478600001)(4326008)(41300700001)(66556008)(3450700001)(66476007)(66946007)(6486002)(2906002)(6666004)(36756003)(316002)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBmb09BODZjUFZldEZscWxWVis5TFBJenQ4Wi91eldWUk00Qk1Nd2RKdU9p?=
 =?utf-8?B?TXYxVjlLT3JYM3MwM1F2N2krWXNLOVh4b2FHdVpGdE5BVHJWUXhEeEJkMitn?=
 =?utf-8?B?c3UxTVdPaFZac0s4NDk4TUtPMDc2b3I5ZEZmL3ZXZDBmcHZYSXpqMlpLTlpX?=
 =?utf-8?B?N2FSampzRXplcHZmRTZ4a0VrV2RDbzk4dmJGVHJqN2wyYXp3b091M1ROOWpC?=
 =?utf-8?B?VWZTbnlMcjh3cEptSEQyTFc0Zjhja2dSV0x5b2EyazQ1V0RlT0p5TFUyRndv?=
 =?utf-8?B?RlJkTFlDaG52ME96N1FhYTVHbVVzVjFFYkxhWHNYNlNZcE12eENXWDZsK3hu?=
 =?utf-8?B?bmdHMHpQM29pZ3VXemx4cDhUNWxTb1dlK0duNmVjVGhxNmNqT25Db1lOUkUr?=
 =?utf-8?B?SE45WWp6VjdEbk5WajhLVFE2T3VaNmdJWWsrUmViQ3BNU3ZmSmtqeHhENHFB?=
 =?utf-8?B?cEJmQ1hHRFd6ZGFEQkhMYVB6d2g0RUhjZzNpUG1SQ1RacmJyY0Erak9uVDZk?=
 =?utf-8?B?eUJEcHh5c2JabFpVNGxMU3p1UFRWTTUvUThmVWtpdEtSenlxazMwS1F2ZmlW?=
 =?utf-8?B?R2taWW9NRVgwZ2wrMU5ZV21DcmJmQ0dmdTZnMmllV28vTUsrUWQwbFJ5eHNY?=
 =?utf-8?B?Nmt2WjE2eitNM0s0aTE3aVIzMUN3RjNhSVlBa2MrOUs0NDdnblpYS3VxMmNl?=
 =?utf-8?B?bzNwUGpwQXNGemE0cDd3M0MwQ2ZLWEhlSGhXZ0NTaVBWdEVYazNtOFQ5NHhr?=
 =?utf-8?B?MjdIRzNZYXdJMDltcnRlbnVteGVxTWxzaEhjaFRWdHVZOWxYRGlWUDY0UXRh?=
 =?utf-8?B?R1RHQVRBditrL3F0TDErTmtockF0WDNLbUtuNGxMcXQ5WnVjTWdjeFJGYnB0?=
 =?utf-8?B?TjQ0RTF6eUYrVWdYaTZ6VCtKeGE3RVdSS3FuSEpwRWhEWk5XOWI5blZrdk5h?=
 =?utf-8?B?TC85YVV4a2x5Z21kWXdscFF3MlRqbzcrZXpjM3BPQnVYTkNSck9HMXBPUC9x?=
 =?utf-8?B?dGhTRGlvTy9xcU1STklCdHFRNkRVU3NNZUNaSFpWbkJJNm1TSjM2dE83ZXMy?=
 =?utf-8?B?WjJQc3dvSlJ2ajFJY1VNWUpDNEFNUkRSSU9TU0RLRkpuTVNkSlRDbkFvYVlC?=
 =?utf-8?B?TnQvV1FvWG9kSDliM0VHOWxBcEFDSlFXSU9qaGhKOHluekUxWGZMeDgrUDN1?=
 =?utf-8?B?NklWME4yQVRyMVJ4Q0srSG5lS2pOaW02eHROZmlyelFhQUJscDVvN3d0anFU?=
 =?utf-8?B?cGVGd2crUkQ3dEp4Z0VQWkt2VmNCcWVLTkM3L25BUTVXZThtTHBOZUF3UnVL?=
 =?utf-8?B?TklZcnkvRzFCQ2xUaGZVWGVEQXBVV2dpTnBOa3NIVGdYSHBuOXEvMnJzb1Ir?=
 =?utf-8?B?cmpDNlhwajE5QnVwZ3hIdStkZCs0d09vRkF3Z1FYSUQ2cE9yNWg4cVRuMXlU?=
 =?utf-8?B?aXpKM3R2ODMzTWdGNFE3bEJKNmlZTXU4RXp1RGZCZ1hXbGIyMS9KaUZLZjNl?=
 =?utf-8?B?bkxQRk45RkxzWCtHbTJWamw4VUtiaG1iRVFNempYb1VMQmp6NG1UTHdxSlFO?=
 =?utf-8?B?WVRFcnVDM3FtdnBaMzdTb1M2R2dKV1B6Y0ZjbW55S2tYTHVETzdBOVFJa3Iz?=
 =?utf-8?B?SzdUZW5RQ1pOQlpZL0dPTHdNZVRtTHR2TkxYMHVWMHN2NkFVWVhwaXovWFZs?=
 =?utf-8?B?ZG9nNnA4aDhwNjJpbXZZZ09PNHBmdTZwMHpMeGU0TXFOT1RIWE1SdFkvZ24x?=
 =?utf-8?B?eG0vQ0dCRVpwWXhEYml3T2JBdERaMjFVdVF0ck5KcUkzSFV1dWpDZDBrRVRM?=
 =?utf-8?B?UmwwY0ZYV3MxMVlCdkcrZmdmTFc3YkEwb0xXdEgwcFExVW9WOE55ZCsyT09D?=
 =?utf-8?B?TlJGa0svRm5vcEhNWVZyRnhHeUIxK1F1L01BRXlhUEpweUx0OGdIZVFDQzNx?=
 =?utf-8?B?ditPU1REczhZTVppbzFEQXV0M2V4MXBpdGptQ1JoZDVCemt6dEFZQXpxdWtv?=
 =?utf-8?B?cWMxMlFDYk0vbitIaXhEckFHam1jVXdYVjI0VHhvK2wxMmJLbHBsb3NSWVpL?=
 =?utf-8?B?cVlwZm5LRFVjbEhuT29CQWN6RkZ0N3NDUTVMSEFzdHd1S0I4eGhvcFpkaU1H?=
 =?utf-8?Q?m8dTTqvo5hKyCMtIFcs5p56FM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29168656-a3d9-44a3-b654-08db35a4fa26
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 07:11:29.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isJl55FDIhY2a6WZmaGttFGc9fgwJfMMDirwUkcFBXwy12oNacH8nHRpk9/jdHPVPLM6WGovKG7iSQtlQsR6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 2:31 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> For enabling Secure TSC, SEV-SNP guests need to communicate with the
>> security coprocessor really early during boot. Lot of the required
> 
> s/security coprocessor really/AMD Secure Processor/
> 
> s/Lot/Many/
> 
>> functions are implemented in the sev-guest driver. Move the required
> 
> ... in the sev-guest driver and therefore not available at early boot.
> 
>> functions and provide API to the driver to assign VM communications
> 
> s/provide API/provide an API/
> 
> s/to assign.*//
> 
>> key and send guest request.

Sure will change.

>> @@ -96,6 +97,27 @@ struct snp_req_data {
>>     struct sev_guest_platform_data {
>>       u64 secrets_gpa;
>> +
>> +    void *certs_data;
>> +    struct aesgcm_ctx *ctx;
>> +    struct snp_guest_msg *req, *resp;
>> +    struct snp_secrets_page_layout *layout;
>> +    struct snp_req_data input;
>> +    u8 *vmpck0;
> 
> Isn't this unneeded? You have the vmpck and vmpck_id in the snp_guest_dev struct which will be set based on the module parameter, so vmpck0 and associated checks shouldn't be needed.

Yes, this can be removed.

>> +    platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
>> +    if (!platform_data)
>> +        return -ENOMEM;
>> +
>> +    if (snp_setup_psp_messaging(platform_data))
> 
> This shouldn't be done here (or yet) since you only moving the routines. The sev-guest driver should call this regardless of the vmpck_id value.

I am moving the routines and also making sure that sev-guest driver works with this change. So sev-guest driver will not need to call snp_setup_psp_messaging().

>> +    }
>> +
>> +    /* Skip VMPCK0 initialization as the key is already initialized during early boot */
>> +    if (vmpck_id && aesgcm_expandkey(pdata->ctx, snp_dev->vmpck, VMPCK_KEY_LEN, AUTHTAG_LEN)) {
> 
> See previous comment. The sev-guest driver should be setting up everything private to it no matter the vmpck to be used.

I will try this out, as for secure tsc the vmpck will be used once and the sequence number would have incremented. And VMPCK0 will be initialized twice.

Regards
Nikunj

