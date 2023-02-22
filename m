Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D078269FD32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjBVUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjBVUtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:49:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418726CEC;
        Wed, 22 Feb 2023 12:49:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NppItkASnEcq/o6rpq+gw/bibE1XyCMbNaam28WMC3d0loQuydKZOmB2ybU7RsqUGa+gooyEaXywV6juRaVvagb4aYo65fTJeTzB2ZPvWkndsvg/z8FaixER/dU/YG+mPcfnZDhVehFAgguXiguUII3HdkJTre0jsXBLRCQdjfBBpAOQavkA7/lLii5fxOZRso224U1/KOxurW/IQoqrwc6GVu2JLacIHkKmYo/XP/DBiVCh1mBz3PPOzO2hR4PN2tMZSaLHqEjPrgY8iKOvFnsEOgdPJby1su80X60o3h0bcVffVnflUphEeGzsB7+FvULmnpohXL6bAn6/ylPSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0icGr8QcUJD0qoFpgqJfOmUTFNyskX4us95djKa5uo=;
 b=iKKMyMRXG5AzMCxZY4cutKozTgCgmA+Zn75PF378FiUQ5JXk8u1HZBgfgmYfghXJz5+3Hi8WvfReoIS4JB621T80jEaMoR6a02dshwc9vHFcjBN7PBD+aKqfiofBJbFi1qmceCuj7dQJGEZ2sgBXsn7HBp8aP8G80v0oet0UI6mPt4a00TJv+RCzG8vNeubSLbq+QRtmUl6Vi5UiahwWjVVAbgMXq0G80kSAWXyIlzmqEHl/ZQAQWC3eQOIx4m3kmBvXKdd49EZRNCl9ae6bMZiTStcFEzcCjTmYLz7w9XHVLfR+QigIqoGq7iDVg4eYuyp+7iUKGjnewV2s6v9t6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0icGr8QcUJD0qoFpgqJfOmUTFNyskX4us95djKa5uo=;
 b=TlSjHbe9hQvB7ek8X1RMQ6/P1jbJ/QCWUm91tDrPtDqWYkikVOEcI2txHFgxM/WVedyurURIffk7rEZ6ccgOnjaaA6kMmgb6ljksGUCb+lBRwp4d9kYrBJ6CAmps6T19tw/BIxCLe0ngVprLONBGtXY183Mn63N3qjESwJ5ABws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 20:49:37 +0000
Received: from CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::bc3c:ddda:b3b:9fcc]) by CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::bc3c:ddda:b3b:9fcc%5]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 20:49:37 +0000
Message-ID: <cda08910-52f1-b0d2-3e06-6c5b930f898a@amd.com>
Date:   Wed, 22 Feb 2023 14:49:34 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:110.0)
 Gecko/20100101 Thunderbird/110.0
Subject: Re: [PATCH v3 3/3] remoteproc: xilinx: add mailbox channels for rpmsg
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     michal.simek@amd.com, andersson@kernel.org,
        jaswinder.singh@linaro.org, ben.levinsky@amd.com,
        shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-4-tanmay.shah@amd.com> <20230222190623.GC909075@p14s>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20230222190623.GC909075@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To CH2PR12MB3688.namprd12.prod.outlook.com
 (2603:10b6:610:28::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3688:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 194e56c0-2b84-4342-4d8b-08db15164fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzlG49ex02VGxuf6myuwvNuPTPYyvC2CoadsERHBSENpxy7QYmERuvhnh4Uw1YYLpCwjjrjaHrIvR3MIEFVaC5FLX0mQ7exGM667OoDCgxNgExWlJsk7ObgrMO3dfYQHHdf+gpgEziA3HrXOThw+/85TBQupam+r5nKfE/93cUzTgZLE7SlsMOoBt3fiaRWkui0fQ7OY5hyjRiXOz8osYmcQr2g9Su9BhXfDrLxSzVrHp935+ja+3nNuuOxPXTGrINDPdsEGxO3bQRkRmTwQHmQQ5Knyb86sx5bFvDB0zKU2lQiGNqPzlr8shHXzkshurLW13loJ1hq4m2QYhnCwO6S3gLKcLjg4Qkpc7GKQM2JWSKc9nU336c4X99PYI/IPP0IqxtipolOqRwTIZqlhl1m7lQbsBGXLEkubM4xuYdnSKCdjxTp+R/YObFAIz5lnlNxqPTMUGuOkhKJ5G1p81KDUzq+FlSXEayHryWXMitJ4zdKW00uPwUWgcMI6l9heEEyYs+/3ifCRVxVL1TXz6lHCI9drkZY4nQ8DxRTeE5aMSiwJKoSs8WKZE/AELGt9HIFd0PEGDQYcSMk0epgeeFvkmtl+oFRnW+TUWjH0E9eNhSzqOsaur4FYaS2LySK/JrZ6NBSP5llx/MkhpXixVEDXDE8F++7mi431qkibiIPmpO46M72OCe1wLxwShkmCQPe961moNFlkFcs1jIatrcy3hrbRck4QxekDSKbGAxkjyIMJVeLdkqQ6HgbcOFqT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199018)(31696002)(31686004)(38100700002)(83380400001)(2616005)(6636002)(316002)(8936002)(8676002)(4326008)(5660300002)(110136005)(66556008)(15650500001)(478600001)(36756003)(6486002)(41300700001)(66476007)(66946007)(2906002)(6512007)(53546011)(6666004)(6506007)(186003)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZwemEyQnF6bk1PNUNHdldIT1QzYUpYMVlBTjQ5YXFmWXl1bjNWRXB3U3BO?=
 =?utf-8?B?MHhaVmRkSko1d1Z4bnFjRmlldnVSTWFVeXorN2hmVVEvTEhmRTB1UUtTdnRN?=
 =?utf-8?B?cGdwc0dJN1J5L3JWYTNrWFlLWUh3SHcza1pZdXlINmUybC8xdWdsTk45Yzds?=
 =?utf-8?B?OXV1Z3Bub0JiWlRVditHdnAzWFBvNDQvMWxreVk3RVRMeHQ4RkM5VllzbENp?=
 =?utf-8?B?Vi90YzRGcUM2YlpEUngvdEFOcUhRclZSQXAvSmtjUnY2dTFuNTltc3J1WnRr?=
 =?utf-8?B?eStvdzZjK1RIcnhVSFo0OVZpRk5CSHdkWlMweE9FbnZEVEV6R0pPT0pTMnR2?=
 =?utf-8?B?UjJvMmRVUmdWeEk0VjlPd0R4Ty9WZFBRK1pPOW56NFQwZkJvMHZUOEZvRlJu?=
 =?utf-8?B?ZzJvRVN5ZEZsLzRJNVZYVm5EbGNsNWV6YjhXVlhpMmgrclRPVGVPQTR5RStZ?=
 =?utf-8?B?ZWpPb1NYZ3EwTmNIOUZKY2V1VUtRRUJHY0tmRWd6eFhianMyWWtTZStFZUpu?=
 =?utf-8?B?emFYbDk0ampOZ3UzWWk1eWx0ckRRck5ZdlhTV0VSYVpqWVBtT2FQWDBOQzYz?=
 =?utf-8?B?dzFoTmJGeTZ3ZVdPdjF6WTNBc0VWK1lqc2hVT3FXZ2tCVlh6Z3BDK0JkeWRz?=
 =?utf-8?B?TEQ3VXJVeFVzNGswZ0VGNkZTZThkM1ZaM2wzbGZwSXN0RUFJWTU5aHY1YVNk?=
 =?utf-8?B?emcvRlViM09nSDJFVHFqV29aWXljYm9UZU0xQzZWb1JpUWQySENtbUROcC9z?=
 =?utf-8?B?blp2TG1Wam9Qa2o4MVg1VktMWENIN1BNQmRZbkIrb3l0dEl5RWNKUjVROFRn?=
 =?utf-8?B?ZmV5bUJlZkdEdElnUVdndWlnaS9aaDQ2dG05UDF5Z3JxczBDOXc1R24zTm5I?=
 =?utf-8?B?S1RUTlQ4ZG5IOHFHNFYyaGtjSmhELzJodk1jcGw2VHVmSlo4MXpRQzN4UzMy?=
 =?utf-8?B?bDczczlNTFo4d1R0Y2h6dloybEwxM003TWpPaHNGYTZCNGpUMy93VklzY2FU?=
 =?utf-8?B?WnBWMUxQa2xFZ1Nhbzc3YzVOU2RNZnN2QmJ4bS9QNFVZdW0zTGF6aDI4ZEZL?=
 =?utf-8?B?d1ZscTVScHhEY0hRd0dqUFNGdHhOUmRneTRDajBvU1JhMzhNRVpHei9EN3hz?=
 =?utf-8?B?UTZ0RWJEMzlYZHMrekkzMGFhMU5LcjZ5NGQ3ek1LYWo2anNoUVBqWUo2ZVB5?=
 =?utf-8?B?a1NWSS9hN0U1V1JTbXpGOVlveWJSRmgycTBLd1J1anRVajFWNDBIVURWQlF6?=
 =?utf-8?B?d0ZvZm1uUDVxVHhNYWVHaEJMZVg4ejRZdVZlMk1XemJralNZWkg3ZDNZVUZN?=
 =?utf-8?B?ZTBTR1pybjNmTVovcE16QlVKeVAxVkJIUjdIWjR6TW9UT1RxWWk4QVU4R0w3?=
 =?utf-8?B?a0w2SytvaG1ybkhhdEVJS1c1RFVMczB6T3B6VFUvaStia1h0OHVQUE02dW5L?=
 =?utf-8?B?bXg3VlRWK0ZXODZ1SVFvbXplSXltbWtxaDM4NVRLbW50MkJ4NFZoQlE5NUFu?=
 =?utf-8?B?b2VlTlRUenhLTkljVlQvanN4Y0paRDFxTEhLT0ZWc1RLY1hvTkdDT0N5K2tJ?=
 =?utf-8?B?ZVJkVjhQQzUrdVRPUWhuMXFDNUVhNjZ3d1gvMEZ4NHhKRG1tRk9Zb2VQZGJx?=
 =?utf-8?B?NzdnWmlHSHIzcGRUN1d0dWF0OEdVTlZnZG14RmUyWWk5ZGQ0NjdNUFhHMWZl?=
 =?utf-8?B?NWxzM0VkUCtIUDlKWVh5YWtlejZGMXVjVlpzU3lIRjIrSlAzNTVvWG1KQmVE?=
 =?utf-8?B?QUZ5eWJTY2pRSjdDajZoZWgxajFodS9GcEYxZTAzcGxYclpMcjVRQTRaZ2o0?=
 =?utf-8?B?c3BsOFdHS1RidUhzVGtCc0toSGVKay85RW5xdU9TWWtEMUxVekhQV2Njdkc5?=
 =?utf-8?B?RThraDk1UlpTN1o4Um84MDBoZFVCU0lrU0tydkZVZW00N2VtRzRVOGJmWkE0?=
 =?utf-8?B?eXkrTFVxMkFXbTRSWGxrOXZGbWRVQjJuU1gwYTBoTDBHR0RidnpUVnh1N0hG?=
 =?utf-8?B?Qzg5NjhVZDdGdXlEWWFUOU5WSHlKR0xZZ2hQZnBtYmJ2czk1Z0pJY1VuT2xu?=
 =?utf-8?B?NXhFbEhoR29xVTFtUlF5Rk8xWVRFMm9iY0FvNkJ6S25mVzluN1U3blFVelo2?=
 =?utf-8?B?c0JSZC90bnR3K1E2ekV1MGJXYk9sZklWMGNQS2g0NkZ5SFJ2dnE5cnl5eVdx?=
 =?utf-8?Q?Yr3UMsNLUXa33Fjp+dEGniKaXxglnwSxnadYQvpAfV69?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194e56c0-2b84-4342-4d8b-08db15164fc1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 20:49:37.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1l/P8qYX9NIQdc5GZmGE52AI1mL/fyhxKeZavI3ugE/JzRZQYQc9V7kmL5/AOMW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/23 11:06 AM, Mathieu Poirier wrote:
> On Mon, Feb 13, 2023 at 01:18:26PM -0800, Tanmay Shah wrote:
>> [ ... ]
>> +
>>   /*
>>    * zynqmp_r5_set_mode()
>>    *
>> @@ -617,7 +819,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>>   	return 0;
>>   }
>>   
>> -static const struct rproc_ops zynqmp_r5_rproc_ops = {
>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
>>   	.prepare	= zynqmp_r5_rproc_prepare,
>>   	.unprepare	= zynqmp_r5_rproc_unprepare,
>>   	.start		= zynqmp_r5_rproc_start,
>> @@ -642,6 +844,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>   {
>>   	struct zynqmp_r5_core *r5_core;
>>   	struct rproc *r5_rproc;
>> +	struct mbox_info *ipi;
>>   	int ret;
>>   
>>   	/* Set up DMA mask */
>> @@ -649,12 +852,23 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>   	if (ret)
>>   		return ERR_PTR(ret);
>>   
>> +	/*
>> +	 * If mailbox nodes are disabled using "status" property then setting up
>> +	 * mailbox channels will be failed. In that case we don't really need
>> +	 * kick() operation. Include .kick() only if mbox channels are acquired
>> +	 * successfully.
>> +	 */
>> +	ipi = zynqmp_r5_setup_mbox(cdev);
>> +	if (ipi)
>> +		zynqmp_r5_rproc_ops.kick = zynqmp_r5_rproc_kick;
>> +
>>   	/* Allocate remoteproc instance */
>>   	r5_rproc = rproc_alloc(cdev, dev_name(cdev),
>>   			       &zynqmp_r5_rproc_ops,
>>   			       NULL, sizeof(struct zynqmp_r5_core));
>>   	if (!r5_rproc) {
>>   		dev_err(cdev, "failed to allocate memory for rproc instance\n");
>> +		zynqmp_r5_free_mbox(ipi);
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>   
>> @@ -665,6 +879,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>   	if (!r5_core->np) {
>>   		dev_err(cdev, "can't get device node for r5 core\n");
>>   		ret = -EINVAL;
>> +		zynqmp_r5_free_mbox(ipi);
>>   		goto free_rproc;
>>   	}
>>   
>> @@ -672,10 +887,17 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>   	ret = rproc_add(r5_rproc);
>>   	if (ret) {
>>   		dev_err(cdev, "failed to add r5 remoteproc\n");
>> +		zynqmp_r5_free_mbox(ipi);
>>   		goto free_rproc;
>>   	}
>>   
>> +	if (ipi) {
>> +		r5_core->ipi = ipi;
>> +		ipi->r5_core = r5_core;
>> +	}
>> +
>>   	r5_core->rproc = r5_rproc;
>> +
>>   	return r5_core;
>>   
>>   free_rproc:
>> @@ -918,6 +1140,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>   	while (i >= 0) {
>>   		put_device(child_devs[i]);
>>   		if (r5_cores[i]) {
>> +			zynqmp_r5_free_mbox(r5_cores[i]->ipi);
> The mailboxes are initialized in zynqmp_r5_add_rproc_core() but free'd here in
> case of trouble, which introduces coupling between the two functions.  I suggest
> moving zynqmp_r5_setup_mbox() in zynqmp_r5_cluster_init() and initialize both
> mailboxes in it.
>
> I am done reviewing this set.


Ack. Yes that makes sense.

Thanks,

Tanmay


>
> Thanks,
> Mathieu
>
> Thanks,
> Mathieu
>
>>   			of_reserved_mem_device_release(r5_cores[i]->dev);
>>   			rproc_del(r5_cores[i]->rproc);
>>   			rproc_free(r5_cores[i]->rproc);
>> @@ -942,6 +1165,7 @@ static void zynqmp_r5_cluster_exit(void *data)
>>   
>>   	for (i = 0; i < cluster->core_count; i++) {
>>   		r5_core = cluster->r5_cores[i];
>> +		zynqmp_r5_free_mbox(r5_core->ipi);
>>   		of_reserved_mem_device_release(r5_core->dev);
>>   		put_device(r5_core->dev);
>>   		rproc_del(r5_core->rproc);
>> -- 
>> 2.25.1
>>
