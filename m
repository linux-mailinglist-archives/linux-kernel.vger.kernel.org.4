Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81D636E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKWXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKWXcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:32:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB7B6594;
        Wed, 23 Nov 2022 15:32:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLKxm5Tnp26MgL2WRLrCjIWC2kFFkgCEkKEfvGF9BFkbOkW9yfKp/NupU8hnW02/O8YS0X37YuYX4USScaGgHbFo6v4prJAZWxRI17exA73sF3au5EHwpC9anAclgcv0zxLC8t8ctQoD4MyKsAQIQ8egkVkEhC4VwHj/4U4kEbmiZnsQGhI209vOuQnBbCaLkKNFtGo4leYNFQGEelleRBwk6Pd4R6sdnEMfFktjXnOdbRrUT53jquqmJ8wVHkPni3NxAAJhZMsRKYp2ugRgKpzxe7IYkHz5XerOrNg1W/mGcm9ZBWwvDaLvMgiisLLckgPCaDB1Mg3BlS2VSEaRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ULWPm05rpr4EqC7UPbE3uKjJHV/QfHeV8IeVr39cYo=;
 b=DuwqI35OnmU2kzpJdWRrNJlDtZh1VoKt+plozM7V0reuzGcjSfX5pxuIN51YKXd81U6fkihk7nq3/Jz9kukB+RCacCrJvZBRjRflL+eg8I8AkWEG0+1dTfsBKU18vWancT9y81sSbq6+hh5bETnsh3QT8LQBZPxlFqEaug1qedE+F4Op4oH6gcDCYAArrOuPntkurdb1frT+rOaNPzla89QIMch4DHgPhpta1lXzHlAivCyekjHY0l7rBEVCsR1ncHHj48vR8W7Ogge7tfMZoB0rtZ9u6BlWuNxMREnYpDNPmR9O6Am2pDvPZYbCPoAT6wT1FuBwDaNCLTkxOBnkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULWPm05rpr4EqC7UPbE3uKjJHV/QfHeV8IeVr39cYo=;
 b=zJdgyjywaSDyvR5tGwxpgiQ6lSOPxqGYmg0IJwWqZob7ZGm4zLFg76l7LhiPAXZ5nz5JiWSaNOu3pJO1d3ss8jgmT6nFe2udI8x5ID6SQ2bPY5xd/4BlZcLlIXvOEly1rkbO5iG/+cRzqAGnuG8FmoeIA1U8iaX7HqP0pLXzcLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH0PR10MB4873.namprd10.prod.outlook.com
 (2603:10b6:610:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 23:32:25 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 23:32:25 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] add support for Phytec PCM-049 and PCM-959
Date:   Wed, 23 Nov 2022 15:32:07 -0800
Message-Id: <20221123233209.1854806-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa3404d-018f-4f31-9ae6-08dacdaafa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4fGqHMT4KcuVqWIhbjJeF4YqPIOBN8xwerfCeiH3J8KEcMX9EpvjQ88/seQaMwQ8PZff1r0oVMX1j/2j6sV2gvC7JISn0vLn1uj4a4fT1gjJBXDTbKyQLr8ruxECESd6MnDzAFRPd9NWJGmYy55AbdxaRPTOJ6IgxljT6UfVyzI0SRXpMvTjEqUnQy4Gr/F2RJvdA8RgzjL7d1pnGlGSzb3r3rUadUv8HuYN1pWsSsX+97xuVAKukITqX23OtfPXKcdtyAK3aCYoCN6hCtL/nJL8RJhicgu4jzpc2DdDAMcnXk6cYe4vD3VxOEwCn5lW0oXIe8hzmlM1rF8A7PCmqVS3+sgvu+2KhFS7lzj1FQ9tweG6XBZeshLgpqlr+t1KVJ2ZEeG6ZuDlVuEVYMlleBfFhGlBFJcvdguCZ378VN6p0HOR9NK5vrUMSAMf0df0W1ipasr2j+g5e+0TL6GBwvVSafH1lkUxPwQw5ZQ6CYrNfT3ZwQFrOQTthdwCYAf+jV/5f0MZzuqzJJlTEik21JX5uSSIz/Tsbxh4lR2aTjgLiax9y1jWZMoBJbhvBNE435ALr+UxHp7ae9KByhscnP4EHIpA6I4VN0BYVSHC18HIgKhfBSAqKtdpB9FMuf4DGFPTSjp31O8Q7+NdKJmiQIvh5oKlKmigkmSa7brAA1C6FWfYUZDp7zlANJSRKBeitCZYByUIRpF7+q5MLJlU6q7ifC+pWp6ChUxdqeZSnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39840400004)(376002)(346002)(136003)(451199015)(6666004)(41300700001)(478600001)(66899015)(6486002)(966005)(66476007)(8676002)(316002)(1076003)(8936002)(26005)(66556008)(66946007)(4326008)(7416002)(186003)(5660300002)(36756003)(54906003)(44832011)(52116002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8US9MBVXra6+FThBrC/dAmkR0pz3jtGaaql0cbA4UVMwFpo7EAGg4eeMmWQ?=
 =?us-ascii?Q?iKgwgrCNp8peJLvRynBh0mb5msOi/7U9BWtM9V5X9vXdJMeULvTQz4ceZokm?=
 =?us-ascii?Q?l8Hjk0dC9vgD3SRUH68YANmfloUAYXa2N3KbTxQbmOSM60BjVqwY1cDcK+R+?=
 =?us-ascii?Q?v36xer8ex/5iMwlPGJCbxswuU5VRNI2H4DkSDVR+DG3uEw3zacMGSeY3BYsZ?=
 =?us-ascii?Q?oyoriN58QvyTWlk45Ux36kIfaMgQ0eczH+oNpGckpThMYd1V7vHU1v7FltO2?=
 =?us-ascii?Q?q1AXO+EqRJZ4NQwP1ZH/E4KFn0Oic1Jr2KTcWmt94yChqfdv3/tkp1UWXZU2?=
 =?us-ascii?Q?blTXEwab5HZQsus9KUBSb94b1KyYY80mkYSfSozJXUpJaUFbnhtIibEzd1A+?=
 =?us-ascii?Q?9lArN9QyyV8zylKLLdIc6Nppnv1CVSvECoj7XHv+NsLzHzmXc5M/vgQPCsgL?=
 =?us-ascii?Q?YRNBd+9OicytKV+EZJ4sPS5KiOcydzlchZYXXIiJbRAY5t1LROdnGwycQ9Rt?=
 =?us-ascii?Q?qij1gZ7y8uzTRyMaEeLfKgkeMvEinww9zvrxL+4xPZmE3EXsYWtlAv+Az42X?=
 =?us-ascii?Q?+BKILJm2Gd6KBFHTovhJHcMajygqsRWsXkMqKW0iiaEiaZLqIVmj3f7N9M1A?=
 =?us-ascii?Q?8hJX30gSz0sJ3EaVXLWxj9nCB4ABnAlfl1l9FiG3+jpc1ja2dk4/spf1lRPA?=
 =?us-ascii?Q?sZE7rOFMA19lJ9fmzRJ0RLpGnolIyFK+sUpeZqWlqMw9CSVH5HkCq53bsoOZ?=
 =?us-ascii?Q?QIqPHBC+iLdpw1xAHoYiw2j+RXm41P4/+HCVJZ9YpW5IKk5jeSA2xrRIYdFx?=
 =?us-ascii?Q?ApRzuVy6BvGBjeY4Ay0oM01Pp6oVM03Bn9WLoM4iCfL5SoHFq49VGIjdT07u?=
 =?us-ascii?Q?gFKAnnDuE/UbNLVmgi+byUW80RB8iOhtJtzROfQzD0iPm9wJMWh+NXe9gfGS?=
 =?us-ascii?Q?+oTlOHDcvxRtGhBp1dJYQ7S2vvD4OLq1yA+Z/qbJ/uLfW++EB8UIZBRxFdzz?=
 =?us-ascii?Q?HnPyNoYhyy1vp0Y91uOk4NYvOo37hXgBId7lGULeg4+AZLohFPVfdBckbm5h?=
 =?us-ascii?Q?5XtMoTnpdsDB0sTBLp2OMikP+NiAWpSwnMLIx6hyYodaD539VdnbKKOtNZno?=
 =?us-ascii?Q?45NiymyVQO9i8lAzUMFSxsLB9Mp4EcYV3RDcgH0HtkvgHO67RnKeXIo7YG7F?=
 =?us-ascii?Q?1xPlqwzfxZNjIMaJ1L0ai9Ms9v+EJpmqVDH9FOeTDeHPSuTMzvngQJNa/SEd?=
 =?us-ascii?Q?NWAliCH9C4vs7QVI4S8p/IVMtZ3Gn65m45E1arZC9i5OMuf5uiZx1ApUTVbW?=
 =?us-ascii?Q?tqxd5EfjJeBIoc79F8Z+vBWpAjCKMg2MpSfvUe0prS+w0Hxju6GfpPMQox7S?=
 =?us-ascii?Q?4f/NSAK8wFM1LBgw6SYt8J/vRMYg3f3yJlgJIC5zcFhUFtYqfaXxNzOjNRgf?=
 =?us-ascii?Q?euvtCa3UkZji6pe4n3SdFR0u1GF2yWu32RrwFFHklx2UdfaiJKYOagHhvAvc?=
 =?us-ascii?Q?1EXkaPs+xQTFbKsBPO3yLa2RnqiXBjOEGOZWFA+GIXY2thQnABsvwVOvGzzk?=
 =?us-ascii?Q?IPEIwHN2/PSU5IY8beIcc0qjoR1r//PxB79RM85QTsKYWLIMyB+Vew2wryfm?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa3404d-018f-4f31-9ae6-08dacdaafa5e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 23:32:25.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULZjce5TEvP0Mrv//kwzjf64KAOcPcxYQUYdpoLbtV8IUl19blz12BwfQF+CLtFvfpjVVPp94cV8Ap2ZQO2FcXX42+uAQfT22/RXXse2kbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As should be clear for the title and patch title, this is adding initial
support for the OMAP 4460 SOM and dev kit for Phytec's PCM959 evaluation
kit.

The PCM049 is a legacy SOM offered by Phytec:
https://www.phytec.com/legacy-soms/
There was a vendor BSP offered by Phytec, but that never entered the
Device Tree era. This patch is meant to change that.

My development bootloader has moved to U-Boot, but I have verified
Barebox works in the past. When booting from SD card, either bootloader
should work. When booting from Barebox, the NAND OOB layout is
incompatible between the bootloader and the kernel.

I haven't had any OOB / ECC errors in the NAND at all, which was my
main concern. Due to that, I'm submitting this as a patch instead of
an RFC. Hardware ECC correction seems to be fully functional.



v1->v2
    * Almost everything moved into the SOM (PCM-049) .dtsi. Only the
      LED chip is dev-board specific.
    * Fix pinmux associations (*pmx_core was applying *pmx_wkup
      entries... I'm surprised that didn't cause more issues)
    * Documentation added

    * Updates from review:
    *   Board compatible strings added
    *   Hyphen / underscore changes
    *   Remove unnecessary status="okay" entries
    *   Generic names used (regulator, led-1, etc.)


Colin Foster (2):
  dt-bindings: arm: omap: add phytec pcm-049 som and pcm-959 dev board
  arm: dts: omap4: pcm959: add initial support for phytec pcm959

 .../devicetree/bindings/arm/omap/omap.txt     |   3 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi   | 412 ++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts    |  48 ++
 4 files changed, 464 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts

-- 
2.25.1

