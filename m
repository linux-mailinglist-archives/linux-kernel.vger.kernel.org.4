Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBB63DB00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiK3QvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiK3QvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:51:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D402654C;
        Wed, 30 Nov 2022 08:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7za4zGDaiylwJJLyfC9REpQ2bBLuwsqhOXkN3REaNsd7nkr2sYBTBiUMq3/pS5B6vIz262lAbu8vy4CchL88hSPpduVJwvCch20HeuCRgRg3IvBQx7CV0JTAJyBfXUGJDpO7kcr64kuHv9+Sn5/FdJ5uw+8LotuNNNaQNgC4jeg661klVldKvoeeXGpUaQChavLpT+wj38X59SF+WuVBjYXT+d8mO4vDI7kA3tAdmmbj4tyroY+3ABz+Z6SQMku2bYyKfXSPovszNmFrJMHh8CbJEcplGw+DxN1uJC8qfrfcN0GzKNkqaEX1psoya6pCQ/y7i5Eb0HeJO/Ho3j9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8Bb+JwPGVIgPVgP4LR1DHxQF5TSuHrtV7ksPs4/Bzc=;
 b=DJ09G2e7cIx9C91uNoUboMIteA0yIjbAaa78CDArTVm6yF6Zq1hxGuqip7KSYKUOsoiq6UkgOx6lSdHJdGpSj1SS3abea0ezna6cMHdfq5X+PbejTqeIb5SQj+G7ReMXE7VJQ//iXSj11XvXo5kAsz6HN/YEZEcul0RyvmLnAZfkJ3EqBVE1v5/d089LtMroFUFv5eFE5dVftb7KA2iU7p9XZDohoKLSV6dPvIkKk9UTR/GgalWghILG5FSOgqWEykVo1lMhjRumizsPKuIa6T0uCaQxAesRTKBwwmfNpNa7LNHZGkCXLEln8rZVCt1vcuMurP2MZ4TCdMHTfRNOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8Bb+JwPGVIgPVgP4LR1DHxQF5TSuHrtV7ksPs4/Bzc=;
 b=WmVebWgYRhPphIriXgoHhbAHCkZkSXVmnxr5B2EpzVVRdtT3MpuYeNQZ+UyJUeDdiZ9x0q+FaXXqtIbK1cpuVzA3oSthcfbw200kLKsnsAHSK7QqrZ/pmirD9KZZvK6PLjTIvxW9FS+8vOeAcWMW8MR4ktdYlFQ1202qghzqimk=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 16:51:10 +0000
Received: from DS1PEPF0000E647.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::1c) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.6 via Frontend
 Transport; Wed, 30 Nov 2022 16:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E647.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 16:51:09 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 10:51:04 -0600
Message-ID: <47dd8b86-8edd-8356-412a-96b8bfb164b0@amd.com>
Date:   Wed, 30 Nov 2022 17:51:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: zynqmp: Rename overlay source files from .dts to
 .dtso
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>,
        <frank.rowand@sony.com>, <geert+renesas@glider.be>, <afd@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <a14e9ec0af23eb349372fdcdb534d83652b5a449.1669826117.git.michal.simek@amd.com>
 <CAMuHMdVcJc-5aqy1u6=DYrb4fPiLSJw26Gw2m6gegOqnTwCQQA@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAMuHMdVcJc-5aqy1u6=DYrb4fPiLSJw26Gw2m6gegOqnTwCQQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E647:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e5ccfe-9c7e-4d03-fa07-08dad2f314cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOfJikn0A93vgNQZH089FYtbHeB6HkXlgTIovVkIRP9kBDBjwJubshQJYLQnq1mituEeUY5jfMGI8Xb3th5MH5BLtP5EjyNrLr+jniqYbdIgISLub9GiCwiVKg3qNbs3crrpoJAPsVkwV4WUfU8DrVo9RUiSJtKEvJP1e0C2gQ9XImav/8w9gSB+pgtBc6pDMfm7MsKhaynjG3LQWjj0yljkNxpE+kLJOJBLay8910/GRdBdvUySiz7aDBVqq29Ch7UgZUyXUrxEOdjjchrVKvhNYepntj/A+oOTldpa1BPBTytCW7qhfBRWOp3hJVykhjVm73ecuAgphizRTko3aDi3lU18pRF++8nYovlooKarWrV1N0vTzcGAWJ8kjDP4gWFsJpN/MgIBqPv62xI3e5EaurkLIthWCekolSYElUOY8ekQSFeC+AyJ2n3HtxhDvERcQfMFMawAbRueC1ktXriZ9wHAm8ww6Sn/zXtrvJezdLFxmkaKPmRshwbMBO2xkl/EgCCiM2mLqxPAwGWMvQwFAAFAPdVc6f1G/x1J6mcZmUJi1COLYGz7s0JxHM3pbp+0OucWvK1zm+S7Vz6mbLFt06WuTG5hIJGwzGDJxZLcNl6OMv+KmlyRnHj87Tig46+OmGGLoOqKed5wvBWkWw2L+aDNLb7G+HLRZ+PDrjTHZIKNXOfssEsTZhtHhZeR7xprTapLu4aqsmPGC/K+6s513U8oYrV5BhiG691Kp5Jy1LWU6nZYZUPZ14dOiPr44yMeULgJ7AM+5hYFW21jluHMLu/BFj+HBxveu9Ri7oRasU7fLdvwmW1f9hntIFJG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(31696002)(966005)(86362001)(36860700001)(478600001)(53546011)(31686004)(82740400003)(6916009)(316002)(16576012)(54906003)(41300700001)(47076005)(2616005)(40460700003)(40480700001)(5660300002)(4744005)(426003)(7416002)(44832011)(8936002)(356005)(81166007)(186003)(2906002)(26005)(70206006)(16526019)(336012)(70586007)(4326008)(8676002)(36756003)(82310400005)(142923001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 16:51:09.3428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e5ccfe-9c7e-4d03-fa07-08dad2f314cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E647.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/22 17:41, Geert Uytterhoeven wrote:
> On Wed, Nov 30, 2022 at 5:35 PM Michal Simek <michal.simek@amd.com> wrote:
>> Based on commit e87cacadebaf ("of: overlay: rename overlay source files
>> from .dts to .dtso") and also Kbuild changes done by commit 363547d2191c
>> ("kbuild: Allow DTB overlays to built from .dtso named source files") and
>> commit 941214a512d8 ("kbuild: Allow DTB overlays to built into .dtbo.S
>> files") DT overlay source files should be renamed to .dtso.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Someone forgot to CC you on
> https://lore.kernel.org/all/20221024173434.32518-7-afd@ti.com

Thanks for letting me know. I picked that version and please ignore this one.

Thanks,
Michal
