Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9956715C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjARIAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjARHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC679367FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnBtc9JXG9yzCQfs/4wzSegzqOdCZO1OqoPGlJyVTSiLMf0SKIQqnoj83BLodDG1uZWFeRQz9O4b9xU5YzGZLq4GGROPSUSMaM8zZ5CxZGEO9P5aXsRJjL+CCp18a6IWufaGZzTEvXcVDEpyRii3qquaYv1EdUocU4TLgN3cXkMf6AHMbUvrfz/Q/GXzGObED+a0HcKdm1xOfuDxSC8wr+z8ruqt75E0ZuismUOLZPuJmL1cR+S21xJ2lQ/0Kc7loLPcAeeaGQog8TZzCKMs0jj6QooVSsFlE/ZHotOJMCLSXH/HgRnfgGir4azHEgZexSb5SWjKGqRhyz46NiSZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahK1ri/jWr6AM3Bmmvox2fgvWwIOI7yOTrfmCTL0zOg=;
 b=L0/AL+qEAMNRzFfh5ttXgK8uieV7DBNry+Vzj0QrUUN2iY2GfjDuEWTJjB+RfgmBJq9+W1lLKM30YIwvzwrnTcrl+UEdriCuya2R44woIigtAA4FdJbzdLg1Hc4RsGN6Z2QzAI0/h7ZhseAPKsN/1dngn9osFwrNj7dAmLxkPaRVratEj5oqHzkg6Tan7jFwdbFSaiASNb9KV7RKBGJkef4W8UbND63yXGjhyr11gPvsFixUETMZJULAb1f6EIDiAJJNeWsQl+nutL7gCv+3jsUb53kxRwGZ+HT6nbDueV5IX890Ckr2xjGQKrFzcsAP1BDlqn06XoVmJ2HOn58ScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahK1ri/jWr6AM3Bmmvox2fgvWwIOI7yOTrfmCTL0zOg=;
 b=GLG6PpBWu9Uc6b/Pfs00CAH1253JlP/phSsn46jVBgzNgSBMG/8TeA0m+uafko6qTL63Gsdu/ol3bgO18z4R8o+4VChQDQiNSsmoMumQ5aYe3ERvPwzp9NsQHOiACTuVzuHvpJa6d1iyhZb2+e35ENO79LVd80eVfRAQWpg5z6w=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:29:28 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::c3) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 07:29:27 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 01:29:22 -0600
Message-ID: <40bf8f6c-c2a1-88cd-163a-256d8d0bb029@amd.com>
Date:   Wed, 18 Jan 2023 08:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] firmware: zynqmp: fix declarations for gcc-13
To:     Arnd Bergmann <arnd@arndb.de>, Tanmay Shah <tanmays@amd.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <soc@kernel.org>, Tanmay Shah <tanmay.shah@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Ronak Jain <ronak.jain@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230117164133.1245749-1-arnd@kernel.org>
 <d6166b85-01df-405b-3112-d9bde16b6bd9@amd.com>
 <eec4d2fd-f305-452a-a47f-83203da494df@app.fastmail.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <eec4d2fd-f305-452a-a47f-83203da494df@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 713b57f9-1e0a-422d-91b9-08daf925bb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODEVc2Z7Mp/Jr9pP2mP5+E1pdqOBRYTRH4kvmMquKUoGRyb8V8EFP9+ljMGv+A5LmeH9gyEtFOE1nrzc43n2VlrzZDWy4qDhvG9gT4anND95+O5PZ8uEUx+TWsQJzNcuUdbJrbe3879+lrkWn+wgHzq6XsICK9DkJKbiNaVGoieVA2F0KNsn1UaQ9yk3eUzAoEmoyQXds+CF5mzwzdUs6MitMyF4RUs8MVTebE5lZ/UFlwHYBVLMKLr/xSEEWTXUbjGsT7eh/BZ/MSXlwnIR19q0SG2Aie4RRq1035lVgyjqjzZ8JMBlQC6BzXUo3JDRvhJk2b4L+RgPJ4b54p7nV0kAyY2oxLUNhSjhqBBst6fp4DDhH9yxj5jkyuJmuIwwiLA0Dhg6x/XtZqpyPTrXjFcR8xItS8dvq7m0h+0oNhNMigI11XVl/14WA7lM2pYoUWPIn/cijqNc1npqkayoWvxRFnE1U4fnYNB8130Rfv3v7riorle8eY5NsyyBfBw+dI3Ed6p89XQvNTYFDCd9XEZu8CECrnsRdl30ybW8ZjJVevtaHYzG4OOHbcRgcoR5CS2VBYkcEGpYgdPeNGp6uO6WIaQ1x18CjYIecXDZnlnVJp9iCbZZSIKTTw8DExu224N9eeUifNYschOqK1XB7O6HDqbHYJmymf1xCBPONPOAxHpcID2GecuFMFfEwtrOS0X4neCT/fLbLPyeotrDzLYMbANfOWhpHwVc1/FyhT4422ulISusSThNK5wmhNwZwXzFHlNbJxKkrjz56Wgk7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(31686004)(36756003)(86362001)(356005)(2906002)(8676002)(8936002)(70586007)(70206006)(44832011)(4326008)(4744005)(31696002)(36860700001)(82740400003)(81166007)(5660300002)(40460700003)(110136005)(54906003)(316002)(16576012)(6666004)(41300700001)(40480700001)(2616005)(478600001)(426003)(82310400005)(336012)(47076005)(16526019)(26005)(53546011)(186003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:29:27.7225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713b57f9-1e0a-422d-91b9-08daf925bb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/17/23 21:03, Arnd Bergmann wrote:
> 
> On Tue, Jan 17, 2023, at 20:53, Tanmay Shah wrote:
>> This looks good to me. Thanks for fixing this.
>>
>> Something must have gone wrong when I ran sparse check on this patch.
> 
> I don't think any of our previous tooling caught this, only gcc-13
> changed some of the behavior around enums.
> 
>> Just one question, does this patch need "fixes:" tag?
> 
> Probably a good idea:
> 
> Fixes: a5e56980cfb7 ("firmware: xilinx: Add RPU configuration APIs")
> 
> I can apply this directly to the soc fixes branch if you like
> and add that line.

I have other patches in my soc branch to send you too.
Around next week I will be sending PR for it.
I can include this one too but up2you.

Thanks,
Michal



