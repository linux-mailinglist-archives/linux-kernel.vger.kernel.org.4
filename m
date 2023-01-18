Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524056715DD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjARIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjARIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:07:25 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8811D5A80C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:39:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqe0KubOuFYZW9aTrizjxI2VLK4ZF04dxWg90DA+S3J5DsRLflRvL3WeTUPChE53jyC4Pgt6BpJza331grEOmuPmmzJgWsi4FqPBpjxHr2i/qsS2VPAn2y1QMHdAwCBY7iFy1yn3jD9CuiJzhr6C4Bp3QN6BvfsCHDsma7g7oZJW+fNkVxnrcyzJDVnlyN4Ol+mVYZqAmyowGCRlxtyBy/kA5vO5mgHMVERTilIrecl4fTG6JsjlRffFCnr+fBCcM47yCWpNa/EKbV4gilZdWBtUA5LRZtX3bAX/7ZMo8lNx1xGE1hVnR0Lxbd5qsQ9m35HoC6ishYOWfxN+kcnPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVZjwWJWMFIH+4iiw3la4wg/joBIq0yh5WOPrrAFSoU=;
 b=gHx5Hq6rQ2ZrxkH3qq72OZvE2bBWEuFWTbSLQz5LwEmjjyQD+NTfHc383r5CRKRdYuKX8IAf87QJBEuMauF2l1sCpEloOHnlgRVyK4q2bxK0C72iSDM5Ey8EoKVdagpUwNxSERxgRQUJi1Wa4QFRnBFenDwWSPZuUk8IsrV1GvCUDoHM1lcSSmMbfarH8QnKU3MqMRyqK3nwaVBhkOA9807VzPylVjRL+V56jby6+dcRFt4CwRzyCbtJxmnYDuq7kbjxqt0OAkrTtwUKVZy3jWjuNHDww18G8NOXHs4SPYeynPkw2JHHhzockYU9+f4HPnHSGbzHiqOoZiXm5njhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVZjwWJWMFIH+4iiw3la4wg/joBIq0yh5WOPrrAFSoU=;
 b=sIFfUp/exN/FHoxt1a8ZCHftUoaIjt2zmClN6pz6G3wT6vfH8v1NRhdP7bOHgnqcg6AZiKk15eqLC5mInoscbOMB/GTysNJRLn8n2nO1bDMMExt2FwTAgJvc2AgFfe4VQgllkIVk503SubrJPEZTsmxNVF5knRBUY7ZvkTei/hE=
Received: from CY5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:930:10::8)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:38:58 +0000
Received: from CY4PEPF0000C96A.namprd02.prod.outlook.com
 (2603:10b6:930:10:cafe::a0) by CY5PR16CA0005.outlook.office365.com
 (2603:10b6:930:10::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96A.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 07:38:58 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 01:38:54 -0600
Message-ID: <c3ca6780-823f-9a34-3245-5f3ad9ad5eb2@amd.com>
Date:   Wed, 18 Jan 2023 08:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] firmware: zynqmp: fix declarations for gcc-13
Content-Language: en-US
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
 <40bf8f6c-c2a1-88cd-163a-256d8d0bb029@amd.com>
 <55cb1658-488e-4ed3-b5f9-5d97c0041dd9@app.fastmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <55cb1658-488e-4ed3-b5f9-5d97c0041dd9@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96A:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 545a2c51-1252-45e7-ce32-08daf9270f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwVTJMMLpEOqtjBF86uKAfIsLRwPVzdwWTb72tMkQg77odB72DjBXeDdcashxoArHkIJPKikjBoawwjYvr768Hmn98Y0PsGdYmr4+m+VotHjFfEpcrd4jmBxQQUjfIYoMXu430izRKIe/9AGyHETClCpS6LlTS9Kh9zdbzL9NM9DyQ2bRCAY8JqvBI7pEJ2MqM9dCuwXWOZWv4dTnFg5HY1yBa3spXn1A2VHmqUQHxVXPqE8qhjfw78ju5vNeSid8/67WiAPg+ieRysyE1ZgAlc9GVhPoh8AViqb7hBT/8nHmXrXxNicMcLvka4K3CFih5fyaPggJXCCsp9XC1xT8Ow44pMlEu5AQ/g4D8wTX34EBO43ex5xy33fUBioJ/banMPo9NYshgVhsP7Dziwrqn3STpbtEJUBtXDxK0qKMT/XNXnaOFc/aOiOiTgBNrfVhVSDfFA+5VN2+u6j9yNi8+zdxzIHYALIlB7N70UJZM2TX1r1WQtzU9DDUojQ8WIp+q6fJZp4ZU9wRHV/1TMMXJ+WUVyUo/z7gP39p3aYkfHYxuZ68kGZ2t9OA1grTgOPihDWxoPjDqxHJzvC81Gy8dhkHmuKf2timhNHteB73OvLJt7AbjPOTe4Vbc+lTvDzd2K6qUtqvaqV81FCQNQwWr4aIEtIN0L181dQdlV/o/xlx8DjOhe3xPzUOQB7T+IpJCAxaYgooEzLZ7Cill0VQhND6pILBH1jUGiA88mk2Yfgahmru0kTJzz3xkfOhHqWPU/57nVK8BvA463AgYVRvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(110136005)(2616005)(26005)(70206006)(4326008)(336012)(70586007)(186003)(16526019)(31686004)(47076005)(478600001)(8676002)(66899015)(8936002)(83380400001)(44832011)(6666004)(5660300002)(41300700001)(426003)(2906002)(36860700001)(53546011)(316002)(81166007)(82740400003)(356005)(31696002)(86362001)(40460700003)(36756003)(16576012)(40480700001)(82310400005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:38:58.0132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545a2c51-1252-45e7-ce32-08daf9270f3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 08:31, Arnd Bergmann wrote:
> On Wed, Jan 18, 2023, at 08:29, Michal Simek wrote:
>> On 1/17/23 21:03, Arnd Bergmann wrote:
>>>
>>> On Tue, Jan 17, 2023, at 20:53, Tanmay Shah wrote:
>>>> This looks good to me. Thanks for fixing this.
>>>>
>>>> Something must have gone wrong when I ran sparse check on this patch.
>>>
>>> I don't think any of our previous tooling caught this, only gcc-13
>>> changed some of the behavior around enums.
>>>
>>>> Just one question, does this patch need "fixes:" tag?
>>>
>>> Probably a good idea:
>>>
>>> Fixes: a5e56980cfb7 ("firmware: xilinx: Add RPU configuration APIs")
>>>
>>> I can apply this directly to the soc fixes branch if you like
>>> and add that line.
>>
>> I have other patches in my soc branch to send you too.
>> Around next week I will be sending PR for it.
>> I can include this one too but up2you.
> 
> Since this is required for building with the latest compiler
> I think we want this in 6.2 and backported to stable kernels
> quickly. I'm about to send a fixes pull request for 6.2, so I'll
> just include it here.

ok. Deal.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
