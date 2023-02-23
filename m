Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F36A051F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjBWJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjBWJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:41:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6823843925;
        Thu, 23 Feb 2023 01:41:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWd792yO4gZHbOgop0TNi63aKqK00R63t+H0bCNesa4YvBgJWLRmxsFoLdi/jpOQDyv5pO0mFOT17mOW9aFINgdW/tM6qDA5Ft0amNEx+iWRrR6XukrBUyqpxTyE7srPDyTPWwZNn7fQZXnldtuhSxVbZEPkWBv7K5TP9zrK9WCpsiSbQ0hHV4FIwEbtFXwMSosqWbtCtmzKnA8kUkexVK1MKwje+XhBTggU4QzxF+15IQJsNgDjyvKU6P+VaTz20s2pzMHg7IDzwkpWJuDfPkaD6syOzdlZDqvXuyIS2uhfq5ksl5roPX/bJgbCIy9zLtSsR2Ll4YvWbV9TV2vhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQKMSKq4P/fnXqH34nzY5+YLuj055J6J1InyvVqMZ3Y=;
 b=gmKiDxEQTgQHrBKKK/9Z1cF6rZ89yl38+AalnJPqXWL6F6spxBZKzt4OHa4MNmewovbWX1AGj2WACjVHr63TiL4MIs5eFyqWraTlLzXMnjV+7ag09zsNsk0fe+qR9hTMkWAES3CwcBaAPr/yGEn1VSRaHoqS46TbPZuz1nk7w13MqAbGDg7Jdv8soIegskN2olzVgKbylWOaJjLy0VLUaFkqANaHQnoPlI1n0DYq6JJXvzlMEnChfCThx841qhRkplIeuQV8jAEar4hQLvJTKvZ7QhuG84z4CGPtXaZn+gQBrEPd8iWURxelB+DFocjJyEic4MR2mZLT+47Eqrb4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQKMSKq4P/fnXqH34nzY5+YLuj055J6J1InyvVqMZ3Y=;
 b=mkrOpcU+RB2+oa9oWBUhA5wKAOXUMGnSnsIitk1/IZLcgFhzhEIHSExrZ7wO03rgwZC0Oho/rFEw8ZlGOacnr6XjJYl/SG0r6hHJbbbgkIPFHNWnIUeQYH75y+pbl8IdcJ4JKn6uv7O5gT+Uonp9CczfhYVVX7BkCRUwaoKqerY=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Thu, 23 Feb 2023 09:41:28 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::50) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 09:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Thu, 23 Feb 2023 09:41:28 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 03:40:36 -0600
Message-ID: <b11cd9f2-3759-1df2-ea00-50c574668c28@amd.com>
Date:   Thu, 23 Feb 2023 10:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
CC:     <andersson@kernel.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-2-tanmay.shah@amd.com> <20230222173448.GA909075@p14s>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
In-Reply-To: <20230222173448.GA909075@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 18272a3e-dc2e-4ef9-cf99-08db1582237b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnwtANdzsnEyipmeLQHOgjdTi/JzTMzAoJ+SwYbvGMbD/dM/6/K+rO2Nk1kvZ3UnTrh0sYAaIMexyC2x40dM9oFvHgz8HKe9TXKgSBTTgzGsQktw6j+d0NT1c2ZFEKZlSdRKYDFmCAqZijnbXTWcWvBGezMlepR0Gvb2xxoMdxoVB3p+hRjX8C8BJjmRD0Mxe3cMeg2DRLxP0biyXSgzAYFvvTZc6okF3sHMoPNC3O5yYpF/wasJKhE4d2s5+TZ6kwoEQIGtg7QbUpZ/i7VTRAaKFV0MyPLv+0VyYdA5blOxGonAqXRybOgKprfi6yUTyHsDs87l75flbHl33LcW7K9bmYEsP7t2HCCVSKQMaGkN9r4SqJSOSzwgIz1kL2p/32bj7qxitPyHurqatDZdr1DfGSbKY1sEy0r0O6SaIfn77o491ApddhBGSMWGTIAP0pynmJ8exJ6vPxNlOFZwVVSuMEpvb8w/9uIfTkKGvs+gpZj/LXrp/IALOa/xu6tSyQrX0HI81PxJ6mSkxWVv8gsr5MyutrwrTqg1Kqg8Kj6vuLg7ayf+nwOziR0AZJviUdqmpiTREOcTtN9TaEv2sgOLJWSeQFK9RIMQaibfce2AS4QuzYi3ujP9uGWT9amRwPA2p80DogwttEE1d0HrKfQV9lBc+gTOckmAsZw/GoNLElQ/V3cl5QV1+Yu8nQ+QNJwMLVpQkQMPLnNlqTfW5zl8cFaQEdbBaRgfpawik1x8DgswpK8nBOH39B9TZZte
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(2616005)(41300700001)(36860700001)(83380400001)(31696002)(5660300002)(478600001)(44832011)(82310400005)(16526019)(26005)(186003)(8936002)(86362001)(6636002)(110136005)(54906003)(8676002)(16576012)(4326008)(356005)(53546011)(426003)(40480700001)(47076005)(70206006)(70586007)(40460700003)(316002)(81166007)(336012)(966005)(36756003)(82740400003)(15650500001)(31686004)(2906002)(6666004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 09:41:28.6430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18272a3e-dc2e-4ef9-cf99-08db1582237b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/23 18:34, Mathieu Poirier wrote:
> On Mon, Feb 13, 2023 at 01:18:24PM -0800, Tanmay Shah wrote:
>> As of now only one child node is handled by zynqmp-ipi
>> mailbox driver. Upon introducing remoteproc r5 core mailbox
>> nodes, found few enhancements in Xilinx zynqmp mailbox driver
>> as following:
>>
>> - fix mailbox child node counts
>>    If child mailbox node status is disabled it causes
>>    crash in interrupt handler. Fix this by assigning
>>    only available child node during driver probe.
>>
>> - fix typo in IPI documentation %s/12/32/
>>    Xilinx IPI message buffers allows 32-byte data transfer.
>>    Fix documentation that says 12 bytes
>>
>> - fix bug in zynqmp-ipi isr handling
>>    Multiple IPI channels are mapped to same interrupt handler.
>>    Current isr implementation handles only one channel per isr.
>>    Fix this behavior by checking isr status bit of all child
>>    mailbox nodes.
>>
>> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>
>> Changelog:
>>    - This is first version of this change, however posting as part of the series
>>      that has version v3.
>>
>> v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
>>
>>   drivers/mailbox/zynqmp-ipi-mailbox.c       | 8 ++++----
>>   include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> index 12e004ff1a14..b1498f6f06e1 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>>   	struct zynqmp_ipi_message *msg;
>>   	u64 arg0, arg3;
>>   	struct arm_smccc_res res;
>> -	int ret, i;
>> +	int ret, i, status = IRQ_NONE;
>>   
>>   	(void)irq;
>>   	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
>> @@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>>   				memcpy_fromio(msg->data, mchan->req_buf,
>>   					      msg->len);
>>   				mbox_chan_received_data(chan, (void *)msg);
>> -				return IRQ_HANDLED;
>> +				status = IRQ_HANDLED;
>>   			}
>>   		}
>>   	}
>> -	return IRQ_NONE;
>> +	return status;
>>   }
>>   
>>   /**
>> @@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>>   	struct zynqmp_ipi_mbox *mbox;
>>   	int num_mboxes, ret = -EINVAL;
>>   
>> -	num_mboxes = of_get_child_count(np);
>> +	num_mboxes = of_get_available_child_count(np);
>>   	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
>>   			     GFP_KERNEL);
>>   	if (!pdata)
>> diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
>> index 35ce84c8ca02..31d8046d945e 100644
>> --- a/include/linux/mailbox/zynqmp-ipi-message.h
>> +++ b/include/linux/mailbox/zynqmp-ipi-message.h
>> @@ -9,7 +9,7 @@
>>    * @data: message payload
>>    *
>>    * This is the structure for data used in mbox_send_message
>> - * the maximum length of data buffer is fixed to 12 bytes.
>> + * the maximum length of data buffer is fixed to 32 bytes.
>>    * Client is supposed to be aware of this.
> 
> I agree that this should be split in 3 patches but the fixes are so small that
> it is hardly required.  I'll leave it up to Michal to decide.

Generic guidance is saying that you should split that patches. I personally 
prefer to have one patch per change. It is useful for bisecting and faster for 
reviewing.
I would expect that this patch should go via mailbox tree and the rest via 
remoteproc tree. That's why maintainer should say what it is preferred way.

In connection mailbox. I recently had some time to look at this driver and I 
didn't really get why there are registers listed. Because all that addresses can 
be calculated based on soc compatible string and by xlnx,ipi-id for both sides.

Thanks,
Michal

