Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC66ACE4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCFTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCFTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:41:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4707B410AB;
        Mon,  6 Mar 2023 11:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSTHxKv919jVAzHd8uzIxytrEF1TyI0GAbAGtT+97DdYSkteL6Daq6TpkAHiSetB+37eZeuJxEGzGT6CeUsD3Kkpms6iqdSJlWc1gveZ1h8WtRJjVjIYXKrT7ucgmca078xFSc6fAwtvdCoQjaMR9jWRtut+dFs1up6ilgZc5LMLiOECIRtGZOPZ8kYjCwSmbClg2XJ3Ur8fzNABnGKtS3FLcSS3C6VSsgLRunh8i7vd7FqV7Q/qlgoRkmn+AEcZg26n7af64uVt1fLzOasdP+xp85EbKBAAb1sJVxG8Ou/jwdlpNmrkMtw605FyvP0PNbSlIBrrBRuleeIg+wgj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaYxfwHrZzy+lOTlSglIYjCGSrSapVtqWK0s7EBESh8=;
 b=FfG/JIGl0KxF0MJfYnZQWzejWVamgDBZcm8rVkjsj/MkNBTesC9/0JG2YnCahGM9ySXgqqmwKgUz0AH9Zwdb7zfLoqphgfKPAR4zqP+ULOMx/LsW26G7A2zDf5ooYMqcMiyXrpdVmVTEBlsYckUc41/ZA+O12nIlo4ajsPIiprF+Xw0vsiWIwHBCjYKaGrfj3xuv7+lU0PG9ZjBpgTrfrgUQNWVfWZ05ncpUImdLhWfL6++18m6Ial3LubnB01Mpcmrugn1EEdQDRgIl+fmOCyGtLQbvfBvsJgSpMVFx7f0RRiz0srqBtknHikXwKr/bjThlK6WGr9vDEs8TAygLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaYxfwHrZzy+lOTlSglIYjCGSrSapVtqWK0s7EBESh8=;
 b=f6d1MAN00JHRQnEYaeMbJHf6FGlVN2+hpEGuBcZ7XjJxfs3rXljHAvrnJ/epV2HX2yHe9+TZPLQ1JqraOEBpdOIIKBq4kHpWzdVNgFLhbJykuvcFkcFwxDRSonN3L6/hiXu9uW5UTpwa8unUFI3qPZyIbBVQUtvzDnw1qAtByKOLvXGdQuO5JKXB1asDgejOqOVuFuvvdL6TdgM5XvQftwMZjl3mMW0lbWuQdXFJMNxqBhjwLXEP6pEim81J2ydxCe2T3+/1HY0lHlYg/LP5VxSoplGiq8AAO9qwfw8exwfJR3CUYhCklC3erS5QfiFe0/3eoYccQOAWk+S/Ry5Ibw==
Received: from DS7PR05CA0062.namprd05.prod.outlook.com (2603:10b6:8:57::8) by
 MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 19:41:52 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::ce) by DS7PR05CA0062.outlook.office365.com
 (2603:10b6:8:57::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.15 via Frontend
 Transport; Mon, 6 Mar 2023 19:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Mon, 6 Mar 2023 19:41:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 11:41:43 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 11:41:39 -0800
Message-ID: <ed82fe57-fade-7dc7-50e4-acce014a5d2a@nvidia.com>
Date:   Tue, 7 Mar 2023 01:11:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v1 04/10] memory: tegra: add support for software mc
 clients in Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-5-sumitg@nvidia.com>
 <ec955be9-affb-e84c-0b27-c27235608a81@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ec955be9-affb-e84c-0b27-c27235608a81@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: b04f57b0-297a-4b49-231d-08db1e7ad597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auLdylmuchcpOqE9nt/F0S2EfTdtWQnc8ScZ///kXuNoCKXtXfAbuAKK6iJ7aW3CsFuOG5AgFCehksqzpfBKaZub9kx+I5x0ffNxzQtiFDTKzIyX0iAv+L7na5YXF4WhhGIF47nUMApHI379tW9o4DUT+OSVg/0GSlUl5ZUa/9fIJK3cCwUhhUMToE4x1ntAxuQhH2lOnfr5d5V/Sdy6bM9tHjYBHc0qXD6sbNDh+1F7PqKnDyCq+WT+j56Mh6V8VBrx7DFG1oOFZwILbf1VTXl9PK30WWHtxwrUcXiMAN4f/9FD12aejF/TsFfYXcdCoOYikOaLHsA91PFoEo/PTbxqvvjNbzEwkVGhLmpooMBe/Gwphlg/1mfH7XpA/SH4VujAzVTLutv+KvAVFBbI2omaZIYXKzPo/DqQ+yBi6Xyr9TC+xG4dwOqHwEMdRVOJV0B+W7q4xoHMf0f68GH9GlpSsE2x4VKOgPXWv26LweUJidsjNTG2fDC66ib3aHUm4My77WLjwk3oTxHPS9cmZcP5Z2HFGjYrtv6K6kLg7tzdXaXhWwvUGdX7IyDlEJl00WbhhWqLAs+9V6YKH0oDjiLC2IbGvSB/Qgh7CLGWf4VYli/laHtCF4fO4unJy3BB6bOxqoYGaWth4E1mfigUlok+jYP+ZSRDD+161GLSvwkUNdrhqQyOujoavpc7Lcnkn3L+2NBxA+ygWZuPnBgSBV3zXhVfg2kEPasajO26wKydde7TlIIH2QeTKmQdQuUlug2tWASb+h0kY0PigYkSGerWWQUNuzteowtWq79DSTQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(26005)(966005)(82310400005)(53546011)(107886003)(36756003)(36860700001)(426003)(47076005)(40460700003)(356005)(921005)(31696002)(86362001)(7636003)(40480700001)(83380400001)(82740400003)(16526019)(2616005)(186003)(336012)(70206006)(41300700001)(4326008)(8676002)(70586007)(2906002)(31686004)(8936002)(5660300002)(478600001)(316002)(16576012)(54906003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 19:41:51.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04f57b0-297a-4b49-231d-08db1e7ad597
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 17:06, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20/12/2022 17:02, Sumit Gupta wrote:
>> Adding support for dummy memory controller clients for use by
>> software.
> 
> Use imperative mode (applies to other commits as well)
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
Thank you for suggesting.
I referred this and changed in v2.

>> ---
>>   drivers/memory/tegra/mc.c       | 65 +++++++++++++++++++++++----------
>>   drivers/memory/tegra/tegra234.c | 21 +++++++++++
>>   include/soc/tegra/mc.h          |  3 ++
>>   include/soc/tegra/tegra-icc.h   |  7 ++++
>>   4 files changed, 76 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index ff887fb03bce..4ddf9808fe6b 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -755,6 +755,39 @@ const char *const tegra_mc_error_names[8] = {
>>        [6] = "SMMU translation error",
>>   };
>>
>> +static int tegra_mc_add_icc_node(struct tegra_mc *mc, unsigned int id, const char *name,
>> +                              unsigned int bpmp_id, unsigned int type)
>> +{
>> +     struct tegra_icc_node *tnode;
>> +     struct icc_node *node;
>> +     int err;
>> +
>> +     tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
>> +     if (!tnode)
>> +             return -ENOMEM;
>> +
>> +     /* create MC client node */
>> +     node = icc_node_create(id);
>> +     if (IS_ERR(node))
>> +             return -EINVAL;
> 
> Why do you return other error? It does not look like you moved the code
> correctly, but with changes. I also do not see how this is related to
> commit msg...
> 
Corrected in v2.

Thanks,
Sumit

>> +
>> +     node->name = name;
>> +     icc_node_add(node, &mc->provider);
>> +
>> +     /* link Memory Client to Memory Controller */
>> +     err = icc_link_create(node, TEGRA_ICC_MC);
>> +     if (err)
>> +             return err;
>> +
>> +     node->data = tnode;
>> +     tnode->node = node;
>> +     tnode->bpmp_id = bpmp_id;
>> +     tnode->type = type;
>> +     tnode->mc = mc;
>> +
>> +     return 0;
>> +}
>> +
>>   /*
>>    * Memory Controller (MC) has few Memory Clients that are issuing memory
>>    * bandwidth allocation requests to the MC interconnect provider. The MC
>> @@ -780,7 +813,6 @@ const char *const tegra_mc_error_names[8] = {
>>    */
>>   static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>   {
>> -     struct tegra_icc_node *tnode;
>>        struct icc_node *node;
>>        unsigned int i;
>>        int err;
>> @@ -820,30 +852,23 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>                goto remove_nodes;
>>
>>        for (i = 0; i < mc->soc->num_clients; i++) {
>> -             tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
>> -             if (!tnode)
>> -                     return -ENOMEM;
>> -
>> -             /* create MC client node */
>> -             node = icc_node_create(mc->soc->clients[i].id);
>> -             if (IS_ERR(node)) {
>> -                     err = PTR_ERR(node);
>> +             err = tegra_mc_add_icc_node(mc, mc->soc->clients[i].id,
>> +                                         mc->soc->clients[i].name,
>> +                                         mc->soc->clients[i].bpmp_id,
>> +                                         mc->soc->clients[i].type);
>> +             if (err)
>>                        goto remove_nodes;
>> -             }
>>
>> -             node->name = mc->soc->clients[i].name;
>> -             icc_node_add(node, &mc->provider);
>> +     }
>> +
> 
> Best regards,
> Krzysztof
> 
