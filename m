Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C766BD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjAPMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAPMQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:16:41 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4920F270C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5j8gclPCZjLj76SifCqk2dbGIXISSjNzJUbcGJkQY4L92Ta3MrOjW1l60eGZOEw1ltKzUF8F31IAITTARkN3El5Sg0DPKKbYkAfZS4eMe4XyNQipebm2LCqz1wpR4lgoomCy9Zy0gF8ydmzx7/LPJYecv4f3t5OSh1ZXScKA7r6ZjmXsXs/P+L0n9Veyt9Gi68kTgLgjpWPrRr/vsSrOt+CF8k5xUfbBlcL1ajjdI+uy1y1yabTiy1+WfCJ1D9cNT6e/HisUZ97eivsBmq/2Y3E2gOF4hj0P3TAfAaqDKW2WvWejzAihyAiG7ztTnHhrLsJAva+VltThJIu3tMimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urv2pZg06egk+jre4WFwKZx4QJ46bIdPrHIOmUc5Izg=;
 b=WJ4lHGzXNY8Z8PoJ/yQACoFfXhh5DN6SdR51V3XjAvPvPE4e9Zl8GkLs9KejifEu5U3jgBCeJwLSc6LZ0mlhbjsrjp9Kv4HlbwjQKuN2FMMY9V5U2jh02yNGgqkdWxiwOcF8Aggvninib01A30LCQs2IP1Gid5g8yPOx4z51vx6bdZKJPHTQG4DSr16A48XGy4jAnpsCetyLHrgpXMI1pKHs3gn8RnjnjuM9Wd4UMCAuXuRmzFvlsHetAmkFe0NW59VUUam/UIfdCCHIdmP8jFER3fMyADbIS0MTLn0Vf2xIEz8EJoLOMDT4CQ6jC8GWB0OsY8YLXBtpj2eqzqWS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mit.edu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urv2pZg06egk+jre4WFwKZx4QJ46bIdPrHIOmUc5Izg=;
 b=14OQfdXyoYYZmo/uTWvHmupX5zVyyLYOKKA7K3jsrT/SotVlurjQtIy1IJQ6XG6yIuUBQbIAi6IdQU6zPcl3wUrgrWZJWEgpcxRdkxLkiWM6hxr2qEz2/uixsED00XzHTDeMpn4MR2fbw7RYOBRQsnIK1rAyl+ke3uNqDmq3BvY=
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 12:16:38 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::e3) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 12:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 16 Jan 2023 12:16:38 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 06:16:36 -0600
Message-ID: <a1f1ad90-5f66-c73f-06ce-4ce65d079d1b@amd.com>
Date:   Mon, 16 Jan 2023 13:16:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Kris Chaplin <kris.chaplin@amd.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com> <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com> <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com> <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: Reg the next LTS kernel (6.1?)
In-Reply-To: <Y8HPw2t+TbdXa83C@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: d95d5e8a-795a-41bf-781e-08daf7bb84a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TN5HHHfosVwes+/t2w5YJG/jyxJCkRLEXT18GuOk59Jb8/eqc9NdcONc4QNCxUKqDy8HFIXDYMrdItz7Wv4i5G5Kzy2+GDlxbc8eLpdNuR9lFW5Myz5ZM4KCLdNTw7wLJyl7ZpZVrcngwzmm0YZ04dgmg+I3XidNje9QRxY/Zezwpd1E/XGSgmzQXfDuWTueckOpYTm+h48pk5rsLkq+iPjy/79YpeDQzfgOCijyKUxDGhcb0oIIqvhbGoLJYzkS3t/ZEtHnbDIoeVTc2NBZHGKM1FUNqFiTCOUJNH5OvE3x0ns32d1A3p+y7WJ+MzVyyOtGg67rwEAtmCqNyLP/gR017u2aO2ad4Dqu2W5HpOywDaKaCaiFNH0aXOZVHbaNKI03l5PavZdBrGa0SAOdACj81dUhROkFZKQkQmLcVKhovU4vUlSXgOAeIGrpOIIpJA6n9XgyYLyNwfiOZ8WF9wjG0l3FNMC3rWQB5kMxRhlBKEGD74o/8IQEqW22Se2y51c9CkJbh0smKRQ9PVNadvbE9aqAlj2ChgtZg6ivcD5RNp8g7jZ22cljz+Y/QfAqw4Zu2C0MJIU/HP9r85auMTZDPjda6lYq7bTnIGQv/cK2eUP0FIhuRCdPWOw+S5j8mh9k0PgtoPL3pZ7KcDjAsfHpcYvLLk/5esrtv42hH6CCGQqMtxxIItYx+BiRwWrPSbOuYbaEnTRBL/EvdEYB9KMzHHrl52gNeO+c2LjnkXjw0WAXt53RYJ4tegEhg5XIM+gUypPBloH9T3Iv8Pec8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(31686004)(36756003)(356005)(86362001)(8676002)(8936002)(70206006)(44832011)(4326008)(70586007)(31696002)(2906002)(5660300002)(82740400003)(36860700001)(81166007)(83380400001)(478600001)(54906003)(6636002)(16576012)(316002)(110136005)(6666004)(40460700003)(40480700001)(82310400005)(41300700001)(426003)(2616005)(53546011)(47076005)(16526019)(336012)(186003)(26005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 12:16:38.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95d5e8a-795a-41bf-781e-08daf7bb84a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/23 22:40, Theodore Ts'o wrote:
> On Fri, Jan 13, 2023 at 05:22:56PM +0100, Greg KH wrote:
>>> I am just saying that developers/driver owners can simple do calculation to
>>> identify LTS version. When they know it they also know time when their
>>> deadline is for upstreaming work. It means if patch is accepted between
>>> 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.
>>
>> That is what I am afraid of and if it causes problems I will purposfully
>> pick the previous release.  This has happened in the past and is never
>> an excuse to get anything merged.  Code gets merged when it is ready,
>> not based on a LTS release.
> 
> This is probably the best reason not to preannounce when the LTS
> release will be ahead of time --- because it can be abused by
> developers who try to get not-ready-for-prime-time features into what
> they think will be the LTS kernel, with the result that the last
> release of the year could be utterly unsitable for that perpose.

None is saying that not-ready-for-prime-time feature is pushed.
In our case all code before upstream goes to soc vendor and it stays there for 
quite a long time when developers have time to upstream it.
I can imagine that this can happen when you use upstream first solution where 
the code is not fully tested on all configurations.

> 
> What I would try to tell people who are trying to get a feature into
> the enterprise distro kernel is to target a release in the *middle*a
> of the year, so that there is plenty of time to stablize it before the
> LTS kernel is cut.
 >> Alternatively, I might work with the team reasponsible for release
> engineering the "product" kernel that I might be targetting (for
> example, for my company's Cloud Optimized OS) and since they follow
> the "upstream first" principle, once the feature is upstream, they
> will backport it into the various LTS release which we support for our
> cloud customers.  And if it just so happens that Amazon Linux doesn't
> have the feature, but my company's cloud OS does ---- well, that's the
> way the cookie crumbles, and that's why the wise distro company will
> have kernel developers on staff, not just try to freeload off of the
> LTS maintainers.  :-)

We are a little bit different case. We are pretty much not making products. We 
are doing SOC enablement to show the latest features on the latest silicon.
But our customers/users are making products based on code we developed for them.
That's why I am telling to developers to upstream code whenever it is ready to 
be upstreamed but not everybody is following recommendations . And for new SOCs 
we should be couple of months ahead for any customer that's why it shouldn't 
really matter if that feature goes to one or another kernel.

> 
> 						- Ted
> 
> P.S.  And if you work for a hardware company, in general the LTS
> maintainers have been willing to handle backporting device drivers to
> older LTS kernels, since your customers might very well might want to
> stay on 5.15, 5.10, 5.4, etc.  Of course, if your feature requires
> massive surgery all over the kernel, that's even more of a reason not
> incentivize people to make massive, risky changes right before the LTS
> kernel is cut.

This is the first time when I hear about it. I think that LTSI kernel guys for 
supporting kernel for extended period they are doing it but never heard that it 
can be also done for regular LTS kernels.
Anyway we don't need it but it is good to be aware about it.

Thanks,
Michal
