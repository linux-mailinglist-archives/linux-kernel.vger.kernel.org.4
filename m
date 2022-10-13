Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6215FD9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJMNE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJMNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:04:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01acsn20809.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::809])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C114015;
        Thu, 13 Oct 2022 06:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLZvkaR4wSDjltE1FJWzXBdApjpCt7qobooKZmApJ4Yzu0Xggcj1fjPUtxxw5XM/Xezayd7coq3vlbzQey/C54oWviir2SM1A+/GsLQp2hqvkRKN96U28mvG6Ko3au/guhjchYJst6lsTLk4S/39/qQrxApaAr0X8YXVGVxWwdjRmkWY1UFhZMekJWrhD8JLx4KQN4OGU1qXV7TZtqJnSWwdafJ8UOJx7Zfg5W/dC3uRjSXpSa+U+cSId1I8jAohNvvx+CapB8kShk/sReujXoxHnvtioHgjmxFG8NdwQOEjNaD3QO2tmHuR5tF5PIleNuwfzwk8NMEhB8O0FxJUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pDXcnSMEAQOB8yEghKCBTDz3amlJTBYEyhbGZbXXGk=;
 b=R3GGqt2dWnDZOn5sNxoKplENpm8b+jQZkbsyhGdJtM/Ba/F59RSpHpuTReY2yKer+xMCboGZ+IFI3mu23KEOOSjASzT5lHQXZ3rSVUHPCtUPyeinvxLzdTR0YNYRMuUNizYfeQOFKqN1abAAIUk14pELcf6KdMB6bRpoaWoviSXllSQDxeph1292QLV2y17uave9YTiFPPbJmSr1IW1GAZJwbQHp9SiHnSulk1Q6ZU5lMPM6jwSDDpc+fdGEQguNDbmUbdqcP0KRQCQwWyW/SjyU2CQ7+9TNz20PFS6N80w2M+ayEIexmuLRN0OAbUnmVDr6KkRWuP7eNtHAFtOaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pDXcnSMEAQOB8yEghKCBTDz3amlJTBYEyhbGZbXXGk=;
 b=kcLcuSf6MF4Id6Y2w2UEUBoYsBvIbB8TEt0/nDbBVb+caPeMVNp5p/VtJStaCeBMJTrkJ5JcVA4IVNgmbK0Ijy3oHRQ4/BaitwWeDdpQkPjif3RHo4+8lGhrHgxiJf8HMJWbkD7d6k4bBQGa/KCtob0Bw5yo/+MBG3IetcOplclJbfgsZjxTFkhLQl5hiBZeKz4EjULkHa1++1H5cea5dx9o4vrVqorCvdSBOKFyFiM/NH+dz7yPmneJJ7RPwIwzYrwVpqKIFLp6ooKmIGQyy994swyHzgFukaNUzH6rVUv+hM97XgIx2pwjHkWIGtM7CEnI0DIygxMI6DqdO9V1OA==
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a7::12)
 by TYCP286MB1827.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:100::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 13:04:48 +0000
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d]) by OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d%5]) with mapi id 15.20.5723.025; Thu, 13 Oct 2022
 13:04:48 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: put the reference of the io scheduler module after switching back
Date:   Thu, 13 Oct 2022 21:03:44 +0800
Message-ID: <OS0P286MB033887ED7C81DD1F782000DBBE259@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <OS0P286MB0338E8D41770BFDE7B3A4EBBBE229@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
References: <OS0P286MB0338E8D41770BFDE7B3A4EBBBE229@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yYXQFuPacvfD1E0wjvtc0fyzU37Ldycm]
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:a7::12)
X-Microsoft-Original-Message-ID: <20221013130344.12352-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0338:EE_|TYCP286MB1827:EE_
X-MS-Office365-Filtering-Correlation-Id: ddda0adc-d662-48c1-13e2-08daad1b81d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7LlICBcybR+mSlm0+nSPNoKph6B9QZY7tiuCSYuqmDl0dSMEHWmiU6pVSYlEWZ9zlze9XwPfu7iTf1qs+kQzm1VM55a6NRmZqC8VJC51uZpqP8mK8NN8oCZENvgWmiIKd3WdmPuDR8fHo1WdHCWGOjYD3OvTskLCjw9aTuOXQzodbJP2y1Ip8DkMGALvzY9L4b84kuBSL3ygyluaeU69w70eh/jBauRdl3XtHIDL67Zf3Td6PFkvt2OzsB+evpek5DvfGCuC327rgyIZm7V91FhH7peS7YsvHaJJESFUP8tCKiKgoKxvQEn6IIVMKAdkVcbl1o4jevvJylGv4DkbCLG8zVf57qqd9Ew1Rlbu630jQXl8AEaDZF4c+wSuOh2200c7lkpU1hXGTxE0/IHxqwffty0xhVA0G/ztkTz0Z6nywjTWvv0f9z+A8uz+pEaMwWqZpaIwqkwnWRrCOZ1VdQzOmJpVXAP0UTZk0sOJxRqiq9imTGCnf2aGzeoCcE9AGrWhEIAsD+L3DJWJ1gUL3yx27l+VvkDSXt2W0ESsSv2hXe01ww/xFGYvio3XEorTGgVXOlIJfoBjxyopAPProWIL3xTOpBTLcNZwCSzGscfZ8zZ34daPmS1CEh+4QvircJ4+LadryLvWTv7NWEzCNxdVbDk0sVtavhsyvMIP+E09A2h62n7Qg9BovKAoEkw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+nhLfWfODHJSlDUCFWLYW9H2iBy7GdKTYYtIk8T1LTtn/nTFWYDS5Tac8dgP?=
 =?us-ascii?Q?8ADLS36/zZH7P+ihxKWjE/v+mz1ZgOQKhVmUzZ+NPdrsmhN6mBaKIwX6Mp0v?=
 =?us-ascii?Q?wRNML0GpJ+jlbhITsGrl4MjZfyV78N6n35NiuSfMSjfAsvjSH2+X+OfKEC2E?=
 =?us-ascii?Q?jZiYtOUqxsGy2UEh9CbktoqliGmDGyFNF+frnz1TXa+Pc372sU3fOQdN0Lz3?=
 =?us-ascii?Q?ad2WRV3i7j3S241z1fVIdnamHa1ASrvadtMschcyOIaJhsrbpRgspSjf5n1t?=
 =?us-ascii?Q?du0zDQeSNy52tF4FRxTXorT+35/JrGY/NaSlYvyaAOc3xYhDe1ooZO66miN8?=
 =?us-ascii?Q?rT6ypmSfj+F8rt0RB/WysrwSmbcNK2IRi2wtWacYaAcXWaWaREnzoa5SrMnZ?=
 =?us-ascii?Q?KCrOmZPjZp797l5+E2UpfC1H+yWaYUA4gViSKnqHu4pNMLOo8D1MqAI7wX3m?=
 =?us-ascii?Q?EbEP6e/gnTFhE7P8xcAy67lo3ynOt6KMwEph2vKI39LjSnjOjE+ujzuS1eGa?=
 =?us-ascii?Q?md1cXX6XeQlV5dUcfXVm3oPYUcp/l7FyQq/yDDxk6djLDwF6CAIQbAkL33bh?=
 =?us-ascii?Q?Fq4P9LLWJFUata2Co6CXbxlSDpgU9E8sHaGweNiI/VIUbCOOA6zm2u1QVcfS?=
 =?us-ascii?Q?vIKKht+FghVK3+/Z3su7D98wMMNY4R5UKd0v4ep1JjuiFW6zLNaKFXxtAozt?=
 =?us-ascii?Q?cFIv93kCp/NlA2nrh/qLpxOYMC/FSw3pysbwpYZ/oRgaU5NxK8oIJ4728/rh?=
 =?us-ascii?Q?MKhS5VoIfvayUJ3fzz2Vtmqes655j5KaDJU3m6gjVFUx6FiO3/Zqak9zQoff?=
 =?us-ascii?Q?U/oHdQNLKQ0E8MmvMoPCgLy1PC/rUmBPmJpOQV2XDwCAsCNM9cF725Dy0pqB?=
 =?us-ascii?Q?aO3Q1kTT1goGxq3FyWOBEf/AZ5IgMpFs0R710PN2EdJDaks7fvzySVYzcflC?=
 =?us-ascii?Q?ljBt8lNBVyZQrPCo/llKRyS5A8yx7CotorvQJ9uv0Q30K6HsFyUuxLxzNU78?=
 =?us-ascii?Q?uA3jXUkFC99FivAoONVRcm2tHc7PXfxem3uIvbn8KW19o7DYW+irIrhRAAIH?=
 =?us-ascii?Q?nI+CDJo2q2T3Un0cXirMiPFgIUi7eQh+1/ZBUjZhQY7lxexdqM68p1JyKhkn?=
 =?us-ascii?Q?nJC3U6MtB3FW8M7zckCzlAZ9UHXOtBOEYCpl1FCOHky9QCX+ehExpc0W7vH+?=
 =?us-ascii?Q?aCAFc4kHyLrec0UHgtK6fOH9J2X9l3mpTm77ZsV+6qKRbJn/fPFBkffz+/r+?=
 =?us-ascii?Q?Y+3BqAomTn7Hbr5EwiMKx3+1qpnskzd07iRH9F/X0LRG/dp1moAkMs/SnUD1?=
 =?us-ascii?Q?KcY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda0adc-d662-48c1-13e2-08daad1b81d6
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:04:48.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the disturbance.

This patch is just wrong. elevator_switch_mq does not increase the reference
 count of the io scheduler module to which we are switching. Hence, we do not
 need to put the reference back manually.

Sincerely
Jinlong Chen
