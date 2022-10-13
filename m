Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F35FDC44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJMOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJMOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:18:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2034.outbound.protection.outlook.com [40.92.98.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922157CE02;
        Thu, 13 Oct 2022 07:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3C4crz4hY9TZ4G9lSp09rsypwAM3oetR6iOpRNrZX5sQXD4BBzFOxXwuaJ4ZnDGrZg3b1EVY8nMCWTcfvqMIDN0jBL4K+JHfVcqAeAK7uvDVVd1e91hLRW9BGQHs+zElmMyKEUMaxTb5iYufvDH7lvHQKQ5VQ1ooYqw6/IcIirEWm2EVvVoJBDdydBTg6WMTuIMg/CAMSRMTNlLuge/WbBYc2jW78HLcmTWI+Djvtg6JKNOMLBS/KjFi/FcXWkn+q3jfN1blSWoRf9sSOyERaloEmi/yh8kOBP17xAX9caJ5aI16eVHcwfgOWOjkRfhkEJhZJHcYoR/ZEfO6tmd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MarRly5I6gM8Tngb1tH7ohAwl15YnoSo60dYMQ1XCpE=;
 b=iWvy+7s2dimYFuwfRT6KDr9mKqqDTQ6g01l1UwwtMjQjIfcbR+amrXangCoRoS/pQvcdDrH+pK5Ebq8V4lAOL92x1pnwwjhr9Zd89tV13vO3sVO3USnbYTVniKiYKDYXk275Wo8mSW4Vcn3xcds1HiJrmXyYVaWRZWVpTew2dnk6iurddmy1An1EcH52WbHzJu6tIjJhNhkHklNGVfg2OdZ2Bwi/6mxXStTwyIqHDZGCwtql6yukzUeIrhZaFXa0jaz0chtAorc1E2MBK1mrf7fyK+6cXU0VjOnCDlWtfoBMWpAhQ3ydQztX3xStVDpwgHbffI2bKQr5K2UqYDFTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MarRly5I6gM8Tngb1tH7ohAwl15YnoSo60dYMQ1XCpE=;
 b=O55nn+VhFk86fjic64PDtvlKGepfWXDrnabbag3lsHYzBKxTSYKOO4d7caNPiX9wTtn12tStQ3NL951Vi6jnJuMRsPB4qv9jwHR96Y9H1q2HvuuSo7/4kZQ6+RmWZ6Xg08uWHHr8S1PE8qTgaUqkR7tStigsHBmSD6+3pmnqrQCYfdGeu9DCXpUtlzoPcRbu2DSdehJpu1blnyaRHauzCcJF1l0YC1pWg9lrtBiQQ3vg71xlTyRQodHdWp9uqlFFE4OKJWXaLgUukNg4D+xxKajE1Zr6KhgCzkpQoQ/H0uPnk1FiJ3noHxk3fCYRIGk3Cz9kF50RlzGrW8rw+wCnxw==
Received: from OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:82::12)
 by OS3P286MB1688.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:162::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 14:18:28 +0000
Received: from OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7fa1:f154:53ce:939a]) by OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7fa1:f154:53ce:939a%8]) with mapi id 15.20.5709.024; Thu, 13 Oct 2022
 14:18:28 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     yukuai1@huaweicloud.com
Cc:     axboe@kernel.dk, chenjinlong2016@outlook.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] blk-mq: put the reference of the io scheduler module after switching back
Date:   Thu, 13 Oct 2022 22:18:12 +0800
Message-ID: <OSYP286MB0344A71BA994B77B9E2E46EDBE259@OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f1c07b2a-ffdd-0912-139d-d51b34b77bcd@huaweicloud.com>
References: <f1c07b2a-ffdd-0912-139d-d51b34b77bcd@huaweicloud.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cD3xDAVV6yPZmS6jKRtHukA5gMv+zXMr]
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:82::12)
X-Microsoft-Original-Message-ID: <20221013141812.25353-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSYP286MB0344:EE_|OS3P286MB1688:EE_
X-MS-Office365-Filtering-Correlation-Id: acade48e-4c96-4352-be39-08daad25cc21
X-MS-Exchange-SLBlob-MailProps: C/ir7cSdGltGXZ5hP6IVfgoZ9qi9retvdSL+iY+H6YskAd2sUnFzx97aO7kvztkhgQAgeULti5QQuEHqbTeu2WG6OtKL/u1HlsENATfUiiZ4exXdcTZhNPVuQ3+O2HXqcESPYvwOhZt03JpG4bcVnxgaC5LPwQJwOT7kZnU9Aw3tPnHTVnF56CHZ4SHYl6b0Vq/8VjDaoGMGTq7/6HZar+zxOq/o43B2C3jqyBU0KF+onsr/hJiG8bogDWI+bxImLEkf+Z3bAaHhpA42wlgNEpQ7wlXYmMackOjdInmKKMI/qHjuR2Bf25UkOxl1ufrzAUnPcy4+iTYEnj/SsNk4BtlPJdRFGJEbyGV0v+AO3veWcdkot4ML5Upu5ORQIFY/B+KOMo2O6CddAfj/cVBlNMGM2EEBuBBftt6Nre87SF9mxBY50eC8aOcek8c+oaZIQ2EFhGfgahPe+ZO1m3yklq1B52+AI6sSfWtmjh43eaWK4A/qfdcmvBi8mwA2OFRUu44ffPDoetzCrvTvtG9Um2/Y406KsZl2iFbSeu2v4pMUq3AFt9yfivGKRdR6XMSmDsBhx6t7WRfQSNTEPw+sS4RnWA9yMwcyBT0ortd34eB9BWzaqzo6RK0NGx3hZ4RM7s5YBPh2zB2yl2bOnKfde4iBYbNSh6opKpA5de53qTqs5rvpXqmWhlp8DJXBl5fBldp82ebI/u6kVcSra0ELMBFiBpY40WvSs9W7hYVSqtXGjmx8guHPp26i8XwHaqmu
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0BwFi7Kag/cGBiV+2uPz10XwyM2fRaGVsO0C0l6kzBV8W9yuyC8EBiiS6YZOcaF5wkIIAQR/KFRWKVeP0lKkV/Wr08iDPGW5/DO0ASUfYL5n4WDu6JNckF4CTjC+bRCXXTi7TrU55rnAzTcqO9j8cdv2E36YvPg0FOYPzTOQbETsCsoGtqDhOOK+Ssz+WizegtoP9+q9PJEBbrxYOZVlXJABYs8/oMw1euQordALk8gKK50IaZO3ZSPwOouv3ASINnyuBISoF78X0YoZkGZ9ok2df9ZFxy0iFFmcQp1HqJdstN0e+vjkMgHRatnybHXt3gG6qjUECZFJerW1L0tkapKQszUkd7Bft1PTRoqZWBdU6j/wM+klpFCC9USBx3vEch2mI7pQ3yK16Sj87iaE6HwWdUKVSTAMHGqiS2hV2qypv6aZ7G2IuARfgPJfn5dsLGCK1EPnnoU4fVYF44avurcldSCsVRxhnDhY0rzt8wL12201X53V4bNHGXt2R7R65qKCMaW9lTDrd91a8nSqTzaUA2Rl3XQwXv7Q1gjvfpa4WqXHXJENZy1YdaYB6sOr7GgbdWTS7GhnRZIRrDamoj5KDCuRRGJnpOzNCTU4F23LuePiyO4Z6DfnRIohhtNpSzHrqgcTKhIb56EB0Lt0liZ5WAEjKA1IKO8yqX5TzVnhqcq6+QxZ6SXlOm+z59cHyHYan0nDYn1ReYBTzLseez+s3UMn8r4B3dQVA9tD7E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/sSb4+jKo49eNkRhzpe/f5K/sdVxzcRHyGCsdJk37NYb+JhuvePKu5AZXJy?=
 =?us-ascii?Q?CbyiWD8uCtwlC1RJauvtDLXzZLvqv+JUyiJ9+N21A0UPfM6IrOIEK8oEci0t?=
 =?us-ascii?Q?G4eog0Mq/VwY6zplyvl4y8WL/QJyTRHcXN5Z54BV2iEgDVgfZsfA0gqfXwd3?=
 =?us-ascii?Q?80edsqiWJq0sdLyJZ0/Olcs2S3kdZjFaGpWYyD4B2pvT77eEzk59CIr6zh55?=
 =?us-ascii?Q?AA3c31faezPBCJjo44ykcbK1EmuVQmSL+09E69qI3A+4dVnjNo+m0F5MT/pr?=
 =?us-ascii?Q?kzQf18JH/px5+hC73eAPpYZCp14qfqmMs6NPL4pGxrOGKukd7cjZr+F5luTK?=
 =?us-ascii?Q?5lKZhO07mKy+pFQ4yw9G4iLtEfMreUbM596DkZYb8AZI7JzSFnA3cR5f1NlY?=
 =?us-ascii?Q?uvXjaX74CTmpLmaq+957CYOMVd60nRcHDOhwr1HIIp+/Ea6SwmWUW2AymLuQ?=
 =?us-ascii?Q?RwDhKfL9E3czb0YDD5JgVPVj9R95dtKMfA8sPJdtNsKDTNAI+xpXR/v++55K?=
 =?us-ascii?Q?aN4xCqtofVKnU/qo5j+h/quSswE3yybPBRL6xJ7lFE790XwFKEYuXz2iILC9?=
 =?us-ascii?Q?0BqQktWbPrqzPBkom5cNt6nSWlefWJWSkBuOPDqz3wBnA33iUb3sEMYdrwiy?=
 =?us-ascii?Q?7U47H8b9ERhQLYCAQ7m8pUhOkqLIElzXXgdFy/eLQdlE7vHJqntg1JX4ZK0i?=
 =?us-ascii?Q?WCprHlP9iGT2XY/Niu6RTRN+AheXnZbijprrjnEMqYDaI6cWsuakhqsY9Cwm?=
 =?us-ascii?Q?zjXZfkPPW+MBodD4TcUnbFLKrNJEIXD1g7WEQzFRz2fWofHgKFjUgGXzKQfk?=
 =?us-ascii?Q?gSejTVPvMhCaJfPAZulJH5ZFSVeH4nwAl4BV9rcyUw+eRsAU5yPIYy5euq6s?=
 =?us-ascii?Q?Sw+lF8dGDlO2if4uKt50y0P/K6agHL/yVgYSiM1bjvsOcw4+Q0ioZXhOpNno?=
 =?us-ascii?Q?+iRCQJa8TFLto56rmJxlsRyT6D2MP7blp+qkxvVqhm1k2pxcUWgufE3wYUHU?=
 =?us-ascii?Q?w9wt828p1WLyTKcsQKQjeoej9zMvcsUfeM9THUPNU54Q2P3t9P3VJfU/0yZU?=
 =?us-ascii?Q?H2JK5FdW1MCrZC6Eu9o0uQcuhrPMNcF+TgZaAgv1qa2DuuLd8Fz4C+kgL4Ok?=
 =?us-ascii?Q?dFHk7tRQi4QNdaCcsOD2Zu+HZ8c6S9rtdacMTMNF3OLPzRiLN5yONuAD4Dyv?=
 =?us-ascii?Q?pM0KsEMZ9kRjYv9qs7auR7HsNwXbLBpZ+7ImhjUfyqeNfBIS3fJKC8ZQVAdh?=
 =?us-ascii?Q?5yBhKYUwhe4A/j07ZWsFDS7Z9FrXGMzbifdNox4mgq1caBuda1R31ojV/XIS?=
 =?us-ascii?Q?WL8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acade48e-4c96-4352-be39-08daad25cc21
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 14:18:28.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1688
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> But I don't see elevator_switch() release the referenct of the module
> it is switching from. It's still not balance to me.
> 

The reference count is released here:

elevator_switch_mq()
  --> elevator_exit()
    --> __elevator_exit()
      --> kobject_put()
        --> kobject_release()
          --> elevator_release()
            --> elevator_put()

What a deep call stack. :)

Sincerely,
Jinlong Chen
