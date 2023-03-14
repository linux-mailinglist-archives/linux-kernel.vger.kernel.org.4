Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71246B9EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCNSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCNSqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:46:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5DB7885;
        Tue, 14 Mar 2023 11:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAlzQ45qGiekb8Oa7ApnFgLizU3mcQTRrtFuGGejnHHoe1DuZh3DiK7FPccAfZGoefR6PK2flCbanIX+DcihJ3qSdlfAVy/RU9j1dTNqMIh194N5SagJTEGzj+ZugssL5VIMdPjUvXDGmjsERxvFsUDGpo3CpGxMA47+AIbbqT+eNyKD56SRIoR4vUuC7o1v/w4Pr/ca2QlZVWf022EtUblXjbdxDd94n1ELciP7uXjY52zrjH54LqC2TzRJ31XBbIaw4aArCgcXkN+yrW2czMVAY6beWmOSHT0NBhD5mVEjamaJdetsYN7FXvCRAWEn5FCKMacGPeYGquoDMCwSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW2LvmOwgGRjlm9KTIpjNpyM3QfjMq0kcCC60/zxLL0=;
 b=R/r5oyoG1eUaRh4i4W85j1jTJxXJDKibbk7MnT4kHsm3msbHDLohexmPhliX23rflIby72i9DeI6v5DnMzo6lvjw7Zam8jbOZHhaAsMsRZSnB2+CfBYvRyztDwjT5mCSON+9/mMNIQb+5qaVaFRLRrdCm3b7agcVa5tOccGEU1CI91uVNLl9EdNh5pziiFMecIwOZJ4X3D5SaVD8TYbBy4/lII2Es0giK0agMJYM4WC6nQaMhZl+KKSLZMOTi+/OyR2L/CAxSyAYEAbY2MizgF+X1RdHinWWlQd++zXlLSGYVrOLz2QaB9o+V323Ylxbgkz4tOjIOGIP3Z7FCbYONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW2LvmOwgGRjlm9KTIpjNpyM3QfjMq0kcCC60/zxLL0=;
 b=5gNlP3dePPXUjAnH62jaQ+Dzcez90RNSKoCYI8ptoNXQHZtlEtXIHI/bSFtBfPJVWcTFs9DphPve8Fl8AHgeHsQSPFsHIDiNZZ1pgOO1sr6FYW/tIPo5IlH0nKedBuyI3MI0Pu4aio6+U5wZ27Ir7nEi656r4/NEVUtrEJYAodM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 18:44:42 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%8]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 18:44:42 +0000
Message-ID: <a577b165-1e18-e689-7580-cac3f37317f8@amd.com>
Date:   Tue, 14 Mar 2023 13:44:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: [PATCH v3] docs: Add relevant kernel publications to list of books
Content-Language: en-US
To:     corbet@lwn.net
Cc:     kaiwan.billimoria@gmail.com, rlove@rlove.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230222183445.3127324-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230222183445.3127324-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:610:e7::15) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfc4cb6-8e46-42f0-eb74-08db24bc2c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2HJtbbD9+ONbxLic41nEkpshl5nASrzsD4NC/X4X34uj9s+/ueowoN2cGPm9DnZBCpPl3allp0uhLTkLjU8P5dPI72S/2EOjRbHj4cIQo2idTX8AN6zbTxeYXSZF+8n2t2vixdErc06WtzOgXEkNzLh5O8DIUPQNQfFnEYdEw0I7coqyEqEf73jjuW/W/JAsxV0Cxf3Mtg52IWmvnDBRvAUiUym8+/lu/+6qWogVuUikpQ5/xm/t+ORRZuExhoqGOVCTT+YcoVqP2GjBmTCS4K1D1zjLrUDLJEOHIh9cvfhPaS8c/86g4wWII58G+4B6LNjQirRu+2m7BnhDwaMdSnPcYUc3XYdmyyvXxAHMt9LMEUpzxx36w4gyyxoMVgZgiAbis7IIB5GWcXq1ddLseXKGUcpO/AsioLp7p093lGzL6bgaGP5i1XMr9xPdDERxdLWgL8KR+9frIFuHj4ZuRv4EbKQYUSDrtH5hGMtbcfVk4wHZzECmOY0Jomt59ltVPQcjUE0pbZ1lH7dqxmHSY7yCSIk8fpLsp2U4fJNGjeOGla07gu96ewr38xAmgjZvqspzU/C7HRdIOPgLoU6B+wjAzTuYN6Xhr9U4qIqeWverUkv6EH3RKcOsezvcOyc6pp0Ln7n9Jh5MFinv6aL1QAUI2bKGMLsEwu0CDDJyj4woEmBQXD7tCq+5NjYwNhkMk2GlYpQumC9lxC+fTWCBZmjOC4kVeuIgYiF3Q91mwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(36756003)(316002)(6486002)(478600001)(41300700001)(5660300002)(6916009)(2906002)(4326008)(8676002)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(31696002)(38100700002)(2616005)(26005)(6512007)(6506007)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFEOFlZZ3ViZ3VTT01tT1gzUlBUMUV4d1FMYlViK2YxQ1dGUytIUFV4clZY?=
 =?utf-8?B?SmdxUzBDSVVlR2tWS28yeFNNS2NmVHN0d3VWR2gwYlB6dDIwb21rTlNhVjBD?=
 =?utf-8?B?dU5uQXJvUklnNDA4Nk84NGJEOFBIRzI2cXRyc0orbjEyMHd0NHZNSlg3UWg2?=
 =?utf-8?B?SWVOVlJIdEQ0SUlQTEFDQjlOdDMwVVZEMTBkaXRiS1V2WHZVZldCcmdFU25l?=
 =?utf-8?B?Vmo3Vyt1Y1FMWDFPYjhtUjZhMnUzUjg1dVd4cjNsYVVLS2hRSTQrc3NYeVhW?=
 =?utf-8?B?YUFIQzBNQ0tEOXRvclF4QVg2dEhDZkNmTEtwS3lLUnFJSnpMWW1Jb05nbG9L?=
 =?utf-8?B?NmEweG5QR0dRL2kxSllUTFNGVndOQld0MW9GU21weTdKZi9qRHJSaGxPSms5?=
 =?utf-8?B?cWFFTmFSVDB5OHNRTG9LL1ZrMExKN3RLTFY4U29hK0NjWXNNNXFZWHhBd0hj?=
 =?utf-8?B?RnZlQ0RBSTR4MkVzTUwrSHU4cVZ1OEpFZGVITjZzTjZBZDVwTnprQmlLRUR3?=
 =?utf-8?B?ZXZ1MDZGZWdqdDZ0cUc3Vi8yTTNKQ3cwMUJCQ3ZFZHBaV0g2TTRNdXI4TU9a?=
 =?utf-8?B?b2Rkd01HanBKb213UUhsVTBxY3dGWkhDekFEOWlOQmt2T0V3MHNXUFY1WSt4?=
 =?utf-8?B?YUhOVjJTYXpDZERyUzBHZzBiTzNrT3BXRVFNRVNqQ2dObXZrdmR6NjhaaTlk?=
 =?utf-8?B?Qi94OEJnRWZzYU5vcTc0YXhxTWJjZFRQT3JuQTBBK3lLV29JelhKbmNxMXRp?=
 =?utf-8?B?U1c2UlYwLzFaaHhFTjhwU3lLWEZXY2paNlQ3aFUyNUFjUVMveFRqSDlxVE9J?=
 =?utf-8?B?TVc3bzV3USt5Z0FRUGtjZi9VZlY4ZUtmRzVWVnhDZk90K3pBZ1F6Y1kzUG14?=
 =?utf-8?B?Z3MzdWdpaFhseEZqbVNzWHBxVDdtb0lKaC9KSWltRE5XS2M4cWIvMG9RZmlw?=
 =?utf-8?B?OXJYQy9vMzJaQW56S0VmVlVmU3BheUlGaDZncjJLODJvc1UwTG5QVlBtSFlI?=
 =?utf-8?B?ZlByZktGZHhhbHBIQjRtUVgyUEE2MU5ySm9vVkVnN2hNekpVNm9wZ3d0NFI5?=
 =?utf-8?B?clZPeDFYZnVzL0wxa2hGMlFKSWVTRG9vbkRQSFFYdGl4UjZraDMyYys2ZTlJ?=
 =?utf-8?B?dEFzZndTNG9tTjFsS1JwTUtmeGdLUllGUDR2bmR1eERtSnRLRmNSeU04dThX?=
 =?utf-8?B?VHZISVZsd2ZodlVnY1RJbmxVUVpKMWVjeWVLYTdFano0WU51NzlpQTRTZmhq?=
 =?utf-8?B?bDMxcEZIZGJLV3AyMkorV3dEM0k2TDJuTzdMNVJRZDVyQkpVZk9jQVYzZzYv?=
 =?utf-8?B?MVVyMzhOdFFBOUY0VUIvTDkyL2JXMS9iVHp2UlhFYkRTdDZnUEdFcTRTQXdj?=
 =?utf-8?B?TnFBRGViU2JBOHZuWEhLVmM3eHo5TmhFQ21YSWtxeVpMR3NjanRnOWNIVkNZ?=
 =?utf-8?B?KzV1NG0rVFVvT2R3dm9yQlREVTdSckpnWDY2dFNhNDBsQXRPZHU0UnVITkZ2?=
 =?utf-8?B?My9oK25rZVQ3ME1ISUJQdUZFREc4NVJOYkdVSlU0Tk1QSmZpTHlFNFNBU0ZU?=
 =?utf-8?B?Yjhkc1dWYjlDc3FweGlDQ0ZTQ2ZMbEtoM1dxUDhoT3RXTWFMN0hXaEZVeXRW?=
 =?utf-8?B?cXpjemVJZzEwL1k5SDBhQlhyRGdlanZhY0FXS2dWRDR0UDUvNXZpbUZ3c0JY?=
 =?utf-8?B?QWV3YWYydVd0SjA0cWU5bnA5d2hCc0JNSnZZVG1SUnNBVG92R01oQVY5SXBi?=
 =?utf-8?B?SmxMQnpwa2FtckRzZm54bmUvZ2JUVS9yMm5LU2t2VVpBQVg5UWJvY0xtL2N5?=
 =?utf-8?B?bDNTSDZGQ205K3ZZaWlmeFMwdytMejUyU2xqZnJhcmVYRTRvYXRWV3h6S3hs?=
 =?utf-8?B?VUgvMWMza3dFQ2lPR2laR2xaN1p6T21mSCs5MHRuaStmd3Y5ZlhpREtRYXYz?=
 =?utf-8?B?MkRtdk85TTFrZXhMUGk3WTF4bWpuMjg1a1lySG5TZ3k2bDB4N1I0Sld3RzdT?=
 =?utf-8?B?K01meGp3dC9Pb0I5T3Qwa09LQTJocEoyNXpaelpRQVZORnBDbDQvWDZEcjY4?=
 =?utf-8?B?MzRrTEtVak52NzJzNW1Ua0w0dTdjRUdOOFNHS3NSdTlKeWw5NGwwTG45QU0x?=
 =?utf-8?Q?o9RVxSpkaG7RsWUJIxZMDqiEG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfc4cb6-8e46-42f0-eb74-08db24bc2c62
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 18:44:42.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOjorHjQe9spSujpllcAw8H2kjMSPechiiggQqWS0Ucez5+8bJrKJTQwIvmV4VX4fbITLjw2LAylXX6Rz0kb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the list of kernel published books, include publication covering kernel
debugging from August, 2022 (ISBN 978-1801075039) and one from March, 2021
on the topic of char device drivers and kernel synchronization (ISBN
978-1801079518). Also add foundational book from Robert Love (ISBN
978-1449339531) and remove extra spaces.

Co-developed-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

---
Changes since v2:
  - Fix SoB chain.

Changes since v1:

  - Fix name of author Kaiwan N Billimoria.
  - Include other book, from 2021, also authored by Kaiwan.
  - Include Kaiwan's SoB.

---
  Documentation/process/kernel-docs.rst | 36 +++++++++++++++++++++++----
  1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst 
b/Documentation/process/kernel-docs.rst
index 1c6e2ab92f4e..46f927aae6eb 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -75,13 +75,39 @@ On-line docs
  Published books
  ---------------

+    * Title: **Linux Kernel Debugging: Leverage proven tools and advanced 
techniques to effectively debug Linux kernels and kernel modules**
+
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: August, 2022
+      :Pages: 638
+      :ISBN: 978-1801075039
+      :Notes: Debugging book
+
      * Title: **Linux Kernel Programming: A Comprehensive Guide to Kernel 
Internals, Writing Kernel Modules, and Kernel Synchronization**

-          :Author: Kaiwan N. Billimoria
-          :Publisher: Packt Publishing Ltd
-          :Date: 2021
-          :Pages: 754
-          :ISBN: 978-1789953435
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: March, 2021
+      :Pages: 754
+      :ISBN: 978-1789953435
+
+    * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and 
Kernel Synchronization: Create user-kernel interfaces, work with peripheral 
I/O, and handle hardware interrupts**
+
+      :Author: Kaiwan N Billimoria
+      :Publisher: Packt Publishing Ltd
+      :Date: March, 2021
+      :Pages: 452
+      :ISBN: 978-1801079518
+
+    * Title: **Linux System Programming: Talking Directly to the Kernel 
and C Library**
+
+      :Author: Robert Love
+      :Publisher: O'Reilly Media
+      :Date: June, 2013
+      :Pages: 456
+      :ISBN: 978-1449339531
+      :Notes: Foundational book

      * Title: **Linux Kernel Development, 3rd Edition**

-- 
2.34.1

