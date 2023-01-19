Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74094673757
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjASLsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjASLrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:47:55 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB74302AA;
        Thu, 19 Jan 2023 03:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ8oG1npGnq2MMf9hIUARfOeogm7P0065exisjKFGjdqgceshWPa+LPmWSu6HrN/ijQSB7XTDauDG9P+GYPlqUGDilV4E8IFzNj2pYuJKALkUEKmrQW5cZFCn/jEzWaE7tLk9qUjz5ZZsfi9pik9Dk5gW7irPS2yeStoFL286lKKy2rdAnO7Jgf40IwM/iQFrVPYH6NMzH2tBAYaZ8j0h1Z5hsUzhY10l770wIHZowir5uB35/de/1akdA5CxC12QogNPTNYl/9XxZb2DPg9aJ0PUcWVcuONQ9JbbDzlIC63KKgsqRoKTyuSQnIQEHH+D0Cna2YAVsj5icgnhCj4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5uZl/lFwV/rzY1++k9S9pVPq+JjDuFekJrdMExZvhY=;
 b=h5AqdcF/tcLSe0Wkv8acisY/3taImk0XcjPMm2c3FSYPuW5NAIcn7BUG0YPJK+CveZQFFGzSC/APBfQnsIfCV2hBEh5lv4r3qoxxBYwqhjyHLVU5mUGAcHwirS8F5742NMt8nPw7ewCHQoR67bYo7xSdy8IYUdl4HN9/buVMDO34dEC7Zt02i41NfI9A2rKm+w/WQL6m/Rc2Br8mD8M1KrVapIdwzCEch+Ku8UvP1GrbkIN5oV0OteZY5clHDJcEtNNNI8IaOAIgvUjdGdVIdMfr7aHHKet96SVHG8dCXb81dK6OUnizCy9iixTOglaErBBo1cwayKr+S6n1Nvt/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5uZl/lFwV/rzY1++k9S9pVPq+JjDuFekJrdMExZvhY=;
 b=XPWDwSXSwHJsjJPcBH6rdVTa3WBfU6rfjHqtgfligzmVP8FD3JuoJCOOEWwFPdVqp2NJViYQ7YZHnJ0mjUXgoQccWISHDUcifB64gxCbYq1+PKd5g1DZ+Q/mws8sJammqL+oWAAaGpvk18kZ0rOR+BZIWpmWuBppyUUMqMGUxHo=
Received: from DU2PR04CA0202.eurprd04.prod.outlook.com (2603:10a6:10:28d::27)
 by DU2PR10MB7743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 11:47:50 +0000
Received: from DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::a2) by DU2PR04CA0202.outlook.office365.com
 (2603:10a6:10:28d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 11:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.199 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.199; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.199) by
 DBAEUR03FT007.mail.protection.outlook.com (100.127.142.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 11:47:49 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.34; Thu, 19 Jan
 2023 12:47:48 +0100
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.34; Thu, 19 Jan 2023 12:47:48 +0100
Received: from localhost.localdomain (10.167.0.77) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2375.34; Thu, 19 Jan 2023
 12:47:45 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmitry.torokhov@gmail.com>, <Jonathan.Cameron@huawei.com>,
        <lis8215@gmail.com>, <Gireesh.Hiremath@in.bosch.com>,
        <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: Re: [PATCH] driver: input: matric-keypad: switch to gpiod API
Date:   Thu, 19 Jan 2023 11:47:36 +0000
Message-ID: <20230119114736.30257-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230113062538.1537-1-Gireesh.Hiremath@in.bosch.com>
References: <20230113062538.1537-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.0.77]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT007:EE_|DU2PR10MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f907e6-2b11-44ad-aa7c-08dafa12fd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1Yhy/8XUVGisa9AfgqSpZp4q4WPVlE1kmvymq1CZq4AIla24mBkkQ+vIPm6YsVvfe8BS4TShxu/oV189pq+HgMBF5omdw1Tu/EPePBLEsJO/4dHebtsr4m+F5sFaHrrY3MTygn6nB+k0TF+nZ+FqVTshSuHU577ElqiQHHIoUTxAR9XwFeowixTC58RNqP12IaVtwzDAN+2sMuYTJ7aGHFrSB6zxQk5XVdIWJxBcWWswF/aUtZgrnKm5hNIR58a5zba1tDoYfVrTT/14CT6vi96/jKR7IyIve8QwiejTb9bPHRUE4Lfhg6WhTbvWF9Pmd756IkDlqpPQH5jC5NXiPY50ZV+IOvPxuliSY9GGIfTmXdkrbwgI4RX8gSauUnqGt2mIRh3p9VkgTzMrhlo3NYbVCUnsYuHW0wxJjX/XlZAdMr778Zoacv7czwOyqoydCyjOPawvaG46Batj5nAGhYEDbj+BK4Esng3KDDTY9fKD8Tk46J4urYmB+b7PUjp4bRyxg3XySlQa/BF1bCBhqxsEvZlaLb/1hz/G8RsoU18bkgcM0Y8AYHJADmLKOxtyRJGehaszd/S9TcULWkIoGoADGNJmBdtmAjaw1KwG7+b1+KaqVH87hdQ5kI8zRt6LZheq0BgF0f/zkRKxC/0etZ6HRKVGAm/LL9J9UsLCTLyCbtEfXEdSw6IZCsI7A0L0xJ9JxvzswJ6974rzBDZTtJWCQ5APumzALxlACUePOg=
X-Forefront-Antispam-Report: CIP:139.15.153.199;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(316002)(336012)(36860700001)(54906003)(2906002)(356005)(2616005)(40480700001)(82960400001)(107886003)(82740400003)(6666004)(1076003)(2876002)(70206006)(81166007)(70586007)(26005)(4326008)(82310400005)(16526019)(6916009)(8676002)(478600001)(8936002)(47076005)(186003)(5660300002)(83380400001)(86362001)(41300700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:47:49.3693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f907e6-2b11-44ad-aa7c-08dafa12fd71
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.199];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7743
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Hi Andy Shevchenko,

I will correct it as
>Thank you for the patch, my comments below.
>
>> switch to new gpio descriptor based API
Switch to GPIO descriptor based API.
>
>Please, respect English grammar and punctuation.
>
>Also, you have a typo in the Subject besides the fact that the template for
>Input subsystem is different. So prefix has to be changed as well.
and template as
Input: matrix_keypad - switch to gpiod API
>
>...
>
>>  	bool level_on = !pdata->active_low;
>>  
>>  	if (on) {
>> -		gpio_direction_output(pdata->col_gpios[col], level_on);
>> +		gpiod_direction_output(pdata->col_gpios[col], level_on);
>>  	} else {
>> -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
>> +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
>>  	}
>
>I believe it's not so trivial. The GPIO descriptor already has encoded the
>level information and above one as below are not clear now.
>
>> -	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
>> +	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
>>  			!pdata->active_low : pdata->active_low;
>
if GPIO from I2C or SPI IO expander, which may sleep, 
so it is safer to use the gpiod_set_value_cansleep() and
gpiod_get_value_cansleep().
>...
>
>> -		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
>> +		err = gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);
>
>>  	while (--i >= 0)
>> -		gpio_free(pdata->row_gpios[i]);
>> +		gpiod_put(pdata->row_gpios[i]);
>
>This looks like an incorrect change.
>
>>  	while (--i >= 0)
>> -		gpio_free(pdata->col_gpios[i]);
>> +		gpiod_put(pdata->col_gpios[i]);
>
>So does this.
>
>Since you dropped gpio_request() you need to drop gpio_free() as well,
>and not replace it.
gpio_request() equalent api gpiod_request() is alredy called inside gpiod_get_index(...).
gpiod_put() is required to free GPIO.
>
>...
>
>>  	for (i = 0; i < nrow; i++) {
>> -		ret = of_get_named_gpio(np, "row-gpios", i);
>> -		if (ret < 0)
>
>> -			return ERR_PTR(ret);
>
>(1)
>
>> -		gpios[i] = ret;
>> +		desc = gpiod_get_index(dev, "row", i, GPIOD_IN);
>> +		if (IS_ERR(desc))
>
>> +			return ERR_PTR(-EINVAL);
>
>Why?! How will it handle deferred probe, for example?
shall I update it as 
				return ERR_CAST(desc);
>
>> +		gpios[i] = desc;
>>  	}
>
>...
>
>>  	for (i = 0; i < ncol; i++) {
>> -		ret = of_get_named_gpio(np, "col-gpios", i);
>> -		if (ret < 0)
>> -			return ERR_PTR(ret);
>> -		gpios[nrow + i] = ret;
>> +		desc = gpiod_get_index(dev, "col", i, GPIOD_IN);
>> +		if (IS_ERR(desc))
>> +			return ERR_PTR(-EINVAL);
>
>Ditto.
>
>> +		gpios[nrow + i] = desc;
>>  	}

Thanks,
Gireesh Hiremath
