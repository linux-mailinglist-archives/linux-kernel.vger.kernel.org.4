Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14156A459D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjB0PJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0PJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:09:52 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE06FF26;
        Mon, 27 Feb 2023 07:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOOv8MzUKqFuLfsCcSeliaku2NeUianyBaV46aieMcmB5jvLPOL21hfMoNfqRstvgeOa0/GjhG3Svfq5DTHggLuGo8HPytCFleUI2k/YlhOuCN6sKr8OFw6ZgvcBV5ElZmegHamIyTr8hpuJ/aF+Pa5HfTwXzTnbFGwiu/i1s6vYaqfVb0q1Bx5Eo2i0uNPyEqL4Wr4dw5EHsjg+rI5l97HjvcP4PmkQigjFnL9fMKYqQ6DQvdckZDOwekPVxA4Eb4LhmYkvg6qGjUrJU2ku/JI/5APoewIjXzSSV8zntEvxDcfO6bBoVqTGYV2NrIle51iaaP2UG2uelABdCFbUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcZwIkRFzz3zrWnYJPCOjgI2v9ml73pkkinxDcADKfw=;
 b=ihcAyelV5nnD+ptmst0AVpsO/dogYl6YGnJQ+MtTFoVPOmQKc2tnq1qhuP1xCJtBnwkTdYaR+2MSLwvCSpVdowHuUyv81OqOJId0nz0p5wf41wjV1Lkxr6EpMN8agVgyyJYw1wlF7EvXAPdgzZVRJ04OXgNsxOv2ljjP9tmNkPZHNoxmHN2CI+Rhb/sNtKowe5npUSfFGBV3LKaXdQbRU6NquGbs+ae8EMiK9D+5OMr/VkWX7PhQOfLMVPp34FouKgR1NUlT+c+5K49W/wmqMTdleBa7Hlk2bEkC8yV1wrQphrNec5An14ZSDLo+zf5Cha8rL8SeRP8JCJ5rcam/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcZwIkRFzz3zrWnYJPCOjgI2v9ml73pkkinxDcADKfw=;
 b=GWRJFtCMBRf1Tpye96xsmMo6EOl6EMpno6RZvhCooYtMgBJQnkJ3avxh7W5Bh2tdbhPdpHtdbY69HKMEbXyJtZZFxjsAYHmBlYIk9ERsRAxYvKyIMgXj+aVlIkJIkFnVWRF+rXW1sG1kceUPcqiNsI1f7MJz6J12tDsCjo1OfeI=
Received: from BN9PR03CA0132.namprd03.prod.outlook.com (2603:10b6:408:fe::17)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 15:09:49 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::7b) by BN9PR03CA0132.outlook.office365.com
 (2603:10b6:408:fe::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 15:09:48 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:09:45 -0600
Message-ID: <6e037df0-8f59-9277-3f40-c22278e02430@amd.com>
Date:   Mon, 27 Feb 2023 16:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate"
 clock
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Swati Agarwal <swati.agarwal@amd.com>
CC:     <adrian.hunter@intel.com>, <michal.simek@xilinx.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
References: <20230223141402.23979-1-swati.agarwal@amd.com>
 <CAPDyKFoGmHpdt5UckyDTWQSK7OmZ789g9Owz7sPP4VJ6ezJbsQ@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAPDyKFoGmHpdt5UckyDTWQSK7OmZ789g9Owz7sPP4VJ6ezJbsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a597f54-a76a-4423-2ff3-08db18d4ab0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7egWRI40t05TYeXb1jsbzX7mStDwHAAxM9liqDvSUwXAD2EqXrCYj5HgaJ8U85xfJZh4zpPqkYmllr9hkVYxeXA8Cl4qlt/SZfriBmUKHpu7Vk1Dcc5kql0yNwG9B6v6RFFVspZu6fJ5vpu2+rVH2xuDckvg59HwwsVgCqfrzDD8GC34DPqirIUvzTYVGQAiasIIpipHx19eOinRoYi14Vt1bSjir/hacVUNjKjATO4T9aby04l0ydKem+VPzOLz6+DgBnfccEqhg+71ZfuKU7Gi+vnNBHWy52c5nnUWEXhgLNhZ/FGEDOgt+K+67jsWTwpxr7z5f6NJf0riIA2/9Nj4QD+NMEjWQFltvIgCnnXTSGwK9eCuLpOJIQEzz/XkboDGwuJizJShgoGgGbALmY5amWfA0Xj4l0Ef27q73OWTSyIOOuwltd/v6ZB07PwTMfCQniUIS3yp8XDZJLn13vegh0MiX/iDy8lSgu3J0wkU11o1h9GeYKJeQ92e+l5RigoIntz4eeWv2Ao7CLKZjo5Pqg6mKFUOFFztA/5COg6Yxokswo6Dhje0+LTEeS/wY6SEbXxnvF2GvNo8x8uXZSdVFDqE7TJaFiJixixhUkATdsU4fjVUrr2abU+bqkt+c8sfgL8DLexCg0N35XQwa0Yu2G7nNytOu0i6HMwbA6KERHEwAoQjHQ1WYqDLf5uC8hUwFk5+Fqcr6F57V/J0GGchu9hAI1ygbiW1UEN/xxcWLSN24f/Z5aMXka6kSkAZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(31686004)(83380400001)(8676002)(86362001)(6666004)(40460700003)(36756003)(36860700001)(478600001)(5660300002)(81166007)(82740400003)(8936002)(426003)(47076005)(40480700001)(31696002)(356005)(82310400005)(336012)(2616005)(53546011)(26005)(186003)(966005)(70586007)(4326008)(70206006)(2906002)(4744005)(44832011)(316002)(41300700001)(16526019)(54906003)(110136005)(6636002)(16576012)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:09:48.4489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a597f54-a76a-4423-2ff3-08db18d4ab0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 15:56, Ulf Hansson wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On Thu, 23 Feb 2023 at 15:14, Swati Agarwal <swati.agarwal@amd.com> wrote:
>>
>> Add support to read the optional "gate" clock property and request the
>> clock which will be used to ungate the DLL clock.
>>
>> For Xilinx platforms which has DLL module, dll clock must be
>> ungated/enabled when SD controller operates at higher frequencies like 50
>> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
>> clock from the driver.
> 
> I guess we need to update the DT bindings too?

DT binding has it already. It is just not used.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml?h=v6.2#n110

Thanks,
Michal
