Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FA6F35E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEASiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEASit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:38:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6BD1700;
        Mon,  1 May 2023 11:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIcvo+KJHZaguE5iN02RyJTXkFgR8osWDdhCJooyITBimSq2P0g9AK9Xj2QWbSPCDCug+O4iwhuHT+5xTKCn3kjmjfZTztu0eBqxJL+yFJiB7Z+RXgaT2pODaAwu2Fv9Ij9XgxpCUq/FIbKVVlyv51OokU/adbme1WT8xpYKr58WXUSOjJEPImDO7YC5kZh+GkLhUuH8WLz5A3zcSzVgPBC99xo/jczoJT5lYOqTexDPDmG/vhf4BuaYzNpe00KmbM4qKwJRLqhgknwYSzbcNE+QRLdP2Ebe5HXfTBz9d72B3NLxqplR1q8EpXQMHr8XHMrpQ5VFwIG3cso+oxT0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bdbjV89M/HCGo8wEr32+MS1cMTm/e3r/gCnsyO/xnc=;
 b=KMQpKsRk6c8N4fISAT0U8zsOxO9o/4I73z9Wt3AI3I9aIT5Dt1/YAS4lFmwU3RiQklxaUHdnSK3TlbChxVLx7omuErCmb0OzP9ejoTcaW+SzD+asFLKDbStdOoaWLpiC3fX0bzmMRT8IMscIXYuGmcaqh6rKUmt5KbK7tQ83yDDHe/uouw3lyuUqkHvW5Sl/2IkBYR/QuWOMSaZlX2RupjjWXSYMaevWbbqvbh0jgPL3lWdew2w0Kf7wi0yyF2yCsOt7DqV5sdOsIr6hKq4jVTeYgJKLZr3Zua0GDtec9YIt4hxxJmxTf1VMwBny0ZrKOBF1TIVwy47E6IItVyjGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bdbjV89M/HCGo8wEr32+MS1cMTm/e3r/gCnsyO/xnc=;
 b=I+lWjnXpR+7Otyd602lYeDqs+KBS9UtfoY4SGXjqct6HYqS2tOohQNxn01ruZ9x+vtHjXPM1L0owhCqZ92oBpKtr9wCKxT7RFaUl117zIY/3x/1lO3uEFa/YfMNL1v+afYVhkCXOPvfxeD7/aGFrq2jWeGuFaYmg4wcQotpVqPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:38:44 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:38:44 +0000
Message-ID: <c0a742c6-c1c1-63aa-eebf-e0fd265d5c0d@amd.com>
Date:   Mon, 1 May 2023 13:38:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/10] crypto: ccp: Add support for displaying PSP
 firmware versions
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Cc:     David S Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20230428185543.8381-1-mario.limonciello@amd.com>
 <20230428185543.8381-3-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230428185543.8381-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eb428b-6fb7-4eb9-f085-08db4a734b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J06yK9ljE0pRCKSjJo4GnI+RiwAXKR8wmz1fauHehAiz7Ga3/tAakSLt7ivYqSTGWmAlBs55JmvJ9xvIyT9vIPNvd55Guew+9CDe7bEEhmR9Pj1sKwS1DTAFTgv94cAKst99OVdsu4Lk2MpApERSGIU0yHsJqo+AI6fkHVHDiS+3yN7kE0DOVe9I8p8ntQzcNPsMSO6zEQXt5FvTk9jSB95OhfxHbhBCEB69mS7qNOzFcqHhlSA1FLZjuCP/6m0wJIQ0aZiqUnESAb9bDZr6AnVP8LD0ycuF7esGwYICxBKbEOzxXOyQPsK+64Fxu7B/1Kv7ggt2GlzX0otiXBrK1b1YXdiy7eUWLnADhOS4s+BIfwffP9RyTN3BdC9YRHhdWmuNK6Aun8bVrAz8Ailj0PzE38L8vnIoFnUeUewonoQZIE4ZaIz4zIsfn5ckYXVscRLzH83HgEfdiSnk5BghidAMasqjpX1E5sZ7RmiLBCP5l1hlv8uSKU4olIL3lzSLbkm08KGVPtYv+nUWsQMYPYXmVGi4nm8Mn+rH9V/9gYKJ99buL7wwk2cvIpZnAVws5stF5Z7iGohokERaYp+PZWLb53iVeWrriRNq4fs4v4jt2k7tV3t5hy6xYhzgOF7dPqumSk/icD1aRafeBdNq/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(110136005)(5660300002)(8936002)(8676002)(41300700001)(316002)(31696002)(36756003)(86362001)(2906002)(38100700002)(66556008)(31686004)(186003)(2616005)(478600001)(83380400001)(6666004)(6486002)(26005)(53546011)(6506007)(6512007)(6636002)(4326008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTdkN3JqNWhxVEh6eGxjQ2loK2ovY21CVTJFWUZyb3crUzRnaGVXbTM1cWNr?=
 =?utf-8?B?YzkzY0FHelRENjFCMW5tOEQzeDk4UWE0U2s2UmF6Zml5S2s0TlFKOURxUHZh?=
 =?utf-8?B?L2N6MUoxSW41b3RBc1FROXZtOEw4VVdoaWQ5VSs0RERRa0gwME1NSWE1UGxy?=
 =?utf-8?B?dlJjanZLV3pvanJybzZSN0NjVDFCSEdHc1FSeVIxNENLUkQvMDF4ZzlQR1Iz?=
 =?utf-8?B?ZGkrZTlEdENEc0pvVy9DeHlCMEdZdnVZblZiK21iR1o4ZURRdjJPU09kVExp?=
 =?utf-8?B?VHRRVzQwVnVUSmxuem1aUnhld3I3YTZYL25MQldKSnNlLzBudTRGb3lBTXJM?=
 =?utf-8?B?ZzM1dnk3Wkkvd1hkQ2Y4SjRJUUFvK3Y5ckxXbmVxR3A1eUdlVlNOQ3RnaS95?=
 =?utf-8?B?dStqcm9NMjUxTGVtWEE5OHZnNWRRVVVqU2FyZkJCZlY5T2Mzd1FHMnY5MDdB?=
 =?utf-8?B?Q3V6UElNcHZLN3lhWUsvb0MvUVJLTWY3bzIyUHl0UDUzTWcrSk1mY0tsdEZX?=
 =?utf-8?B?U2t3S0hHdHBjekxuNk9kS1pMRW83VkJQdDg4OWF1NXBKSHdmK01oWHBoQ1M5?=
 =?utf-8?B?eFozektqSkpqZGkvNWxhNS9hUHVxZzM5b2w4UmJUZHpDcCt5cEVrUVVlNURI?=
 =?utf-8?B?YkFEYk1nVlJCczBIdW5RZktOZ3RZMWFSZUkyalgyZVNJUDFEbHhWcVkrWTY4?=
 =?utf-8?B?U2F2Uzc3RElBb1NjMnl2czJlTkVDaG5hTFB2WXNOZnRVYmdQNWptT0tjZC9E?=
 =?utf-8?B?VTNTUXB5SDlud1dZU2Y2MlJXSGNMWGh3aktKdWlSNVpFbDFLYlJFRUxPMGhE?=
 =?utf-8?B?WXV4QkdRMWFxT3RESUlJd1pMSmkzZDlMK3l6dlQ3Q2d5TUJmaG9uK3RsMWQ0?=
 =?utf-8?B?My9KUVBhQk9lNkY2NmlxWUVHc1o2OWJuMTIvWG92WHdIMnJxTGxYZm4rNUYv?=
 =?utf-8?B?MDVHZm15eVB3RGU1cjRhZExlNjJnYU0zQndONjhlSytYNmpHUktSMFJubURN?=
 =?utf-8?B?V3ZQczRzMEM0WWNYZXBaYm5Edm1VdzFyclUwZTF1Z2pVWjlVMlZpUmxLY1ZL?=
 =?utf-8?B?M2IwTWRad2xVYVMrRzJkM1hVRTU4YXltZVRudWFIRTFOYWZ3Q053ZWU1bGU0?=
 =?utf-8?B?WHBiT0cxMjRtYmFFYlp6ajQwUFhVWDZiOHVEQXZicnNLUnc3V0J5eHVBRW0r?=
 =?utf-8?B?ZmN5eUwyQnIrYXY0YWs2OUZTcVFzaXZUQ0dWcDZ5QUtzd3BkQTZXanAwMmp4?=
 =?utf-8?B?eGIxY2E1cTI1cUFtUENLWEhnQzUzTjREY3dwVVYvdUZYMklNbG45ZUVuRklN?=
 =?utf-8?B?VlR6cXFnRkFuQ3oySEdTTUlSS1piOStxa28wTE9lSC90SWdWQXdXSFowbmU0?=
 =?utf-8?B?UEZjdXFQcitJVnBrWVgvc2FmRnlKcW9Nb3dqQkZYV0ZrSk55eWoveWd1LzBy?=
 =?utf-8?B?a2E4TG9hTEVRSEJSdW1PM0puaDFYNzVvOW82MTNRODVDRGFwQTBoUG50NWdG?=
 =?utf-8?B?UWVlZ1VQYTQzWmhZSGdtd0p0RWlTc0FWTUcrWmdXQ1VzRzhFSWtpbWZkZW5w?=
 =?utf-8?B?T29sSlBEeXZRVll1VTRiUm1rZ3FyODdYVUszVEZueFcvdnNubmdERFg3TDJw?=
 =?utf-8?B?QzBKYUhkcGFMeHMrbW1wc2dTZFM1bTNHSTYwUFRLeWxUV1dwVHRLdVMzTGZk?=
 =?utf-8?B?MEVrV3FnVERkcks0aHNUK0hqZXdFUHQ4UXZGVVNFd2NocjJNY0luV256MGtz?=
 =?utf-8?B?djBBcndtclpQTFBMcU4vWGtWQjRKcFpaaWEwMFZJMmlvRk4vb1RxM1o1RHc4?=
 =?utf-8?B?MENLNGNMSHZMc2dKemdyZktsR0RMRXdpOENEZWo3YW9nWFA5anFVMHdhWStH?=
 =?utf-8?B?bGRnOGFhSjVKRHhxa1dJK3FlTzRjSFdvZEZsVXpNaTlqUHNHaGdDd1AwRGhG?=
 =?utf-8?B?WWtvQVBhOUlITkZ0N0JtZytZYUhPVlRBam9tYXJ1VlZzdGNoMEJiUVgzUGxS?=
 =?utf-8?B?eXNIT3ZWR3VCT081OWlPU1drVjJtczZKSkpPL2xoanpnQmJKTTFPNWxIOGZI?=
 =?utf-8?B?Y3NoS0plOE56TXpLckdFRFM2S2hpNWQ0NTRoWXZaOHlDYjNITEdRT1pUbFJE?=
 =?utf-8?Q?Tqb4pbBbEY+xonLyPAQehe3kO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eb428b-6fb7-4eb9-f085-08db4a734b0b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:38:44.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkF23i/Gi1rJaE8UN1nzpU8fu58Ev52AtogDG/U7CF4GUiYCCtwylHMG7H6wfgyJau/l1FEFl4C5SC8NPLYW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 13:55, Mario Limonciello wrote:
> As it's not always obvious what PSP bootloader or TEE version are
> present in OEM systems, add the ability to get this information from
> sysfs for supported platforms.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v1->v2:
>   * Move GENMASK declarations to top of the file
>   * Add comment to support why checking for 0xffffffff
> ---
>   Documentation/ABI/testing/sysfs-driver-ccp | 18 ++++++
>   drivers/crypto/ccp/sp-dev.h                |  2 +
>   drivers/crypto/ccp/sp-pci.c                | 64 ++++++++++++++++++++++
>   3 files changed, 84 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ccp b/Documentation/ABI/testing/sysfs-driver-ccp
> index 7aded9b75553..ee6b787eee7a 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ccp
> +++ b/Documentation/ABI/testing/sysfs-driver-ccp
> @@ -85,3 +85,21 @@ Description:
>   		Possible values:
>   		0: Not enforced
>   		1: Enforced
> +
> +What:		/sys/bus/pci/devices/<BDF>/bootloader_version
> +Date:		June 2023
> +KernelVersion:	6.4
> +Contact:	mario.limonciello@amd.com
> +Description:
> +		The /sys/bus/pci/devices/<BDF>/bootloader_version
> +		file reports the firmware version of the AMD AGESA
> +		bootloader.
> +
> +What:		/sys/bus/pci/devices/<BDF>/tee_version
> +Date:		June 2023
> +KernelVersion:	6.4
> +Contact:	mario.limonciello@amd.com
> +Description:
> +		The /sys/bus/pci/devices/<BDF>/tee_version
> +		file reports the firmware version of the AMD Trusted
> +		Execution Environment (TEE).
> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
> index 1253a0217985..76c32ee6bd65 100644
> --- a/drivers/crypto/ccp/sp-dev.h
> +++ b/drivers/crypto/ccp/sp-dev.h
> @@ -51,6 +51,7 @@ struct tee_vdata {
>   	const unsigned int cmdbuff_addr_hi_reg;
>   	const unsigned int ring_wptr_reg;
>   	const unsigned int ring_rptr_reg;
> +	const unsigned int info_reg;
>   };
>   
>   struct platform_access_vdata {
> @@ -69,6 +70,7 @@ struct psp_vdata {
>   	const unsigned int feature_reg;
>   	const unsigned int inten_reg;
>   	const unsigned int intsts_reg;
> +	const unsigned int bootloader_info_reg;
>   };
>   
>   /* Structure to hold SP device data */
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index 85e3dc8853e2..7ef7c09b4a2f 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -8,6 +8,7 @@
>    * Author: Gary R Hook <gary.hook@amd.com>
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/device.h>
> @@ -24,6 +25,12 @@
>   #include "ccp-dev.h"
>   #include "psp-dev.h"
>   
> +/* used for version string AA.BB.CC.DD */
> +#define AA				GENMASK(31, 24)
> +#define BB				GENMASK(23, 16)
> +#define CC				GENMASK(15, 8)
> +#define DD				GENMASK(7, 0)
> +
>   #define MSIX_VECTORS			2
>   
>   struct sp_pci {
> @@ -88,8 +95,65 @@ static struct attribute_group psp_security_attr_group = {
>   	.is_visible = psp_security_is_visible,
>   };
>   
> +#define version_attribute_show(name, _offset)					\
> +static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	struct sp_device *sp = dev_get_drvdata(d);				\
> +	struct psp_device *psp = sp->psp_data;					\
> +	unsigned int val = ioread32(psp->io_regs + _offset);			\
> +	return sysfs_emit(buf, "%02lx.%02lx.%02lx.%02lx\n",			\
> +			  FIELD_GET(AA, val),			\
> +			  FIELD_GET(BB, val),			\
> +			  FIELD_GET(CC, val),			\
> +			  FIELD_GET(DD, val));			\
> +}
> +
> +version_attribute_show(bootloader_version, psp->vdata->bootloader_info_reg)
> +static DEVICE_ATTR_RO(bootloader_version);
> +version_attribute_show(tee_version, psp->vdata->tee->info_reg)
> +static DEVICE_ATTR_RO(tee_version);
> +
> +static struct attribute *psp_firmware_attrs[] = {
> +	&dev_attr_bootloader_version.attr,
> +	&dev_attr_tee_version.attr,
> +	NULL,
> +};
> +
> +static umode_t psp_firmware_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sp_device *sp = dev_get_drvdata(dev);
> +	struct psp_device *psp = sp->psp_data;
> +	unsigned int val = 0xffffffff;
> +
> +	if (!psp)
> +		return 0;
> +
> +	if (attr == &dev_attr_bootloader_version.attr &&
> +	    psp->vdata->bootloader_info_reg)
> +		val = ioread32(psp->io_regs + psp->vdata->bootloader_info_reg);
> +
> +	if (attr == &dev_attr_tee_version.attr &&
> +	    psp->capability & PSP_CAPABILITY_TEE &&
> +	    psp->vdata->tee->info_reg)
> +		val = ioread32(psp->io_regs + psp->vdata->tee->info_reg);
> +
> +	/* If platform disallows accessing this register it will be all f's */
> +	if (val != 0xffffffff)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group psp_firmware_attr_group = {
> +	.attrs = psp_firmware_attrs,
> +	.is_visible = psp_firmware_is_visible,
> +};
> +
>   static const struct attribute_group *psp_groups[] = {
>   	&psp_security_attr_group,
> +	&psp_firmware_attr_group,
>   	NULL,
>   };
>   
