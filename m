Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF416476D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLHT4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHT4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:56:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93DF56552
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxXOvvh0hnPSDxfvZbKlUOb8/LKLGUvsXa5lC9D/hEpVy7/LbVFxgtGhkdj7QSyUbVvzlgBTpia7quDPfgGJCQGhioGgf0UreL9+MWQ9tahUIuqHSmbuUye2PkushKa2F1h6/tsCMagJUw62Wqoiu3UnIeGbQswE3P7D+hKRyPiSsROIPxIbbv1VY6FJcpN6vERnKXhMop5wWgTO2cAAlWJ39sZTmmVR0I0QFH5E/YGy3Yq3r45j0XFIEkjw/q7LALM2a+UMxyKej8ZRULtrnQfPGS719XWYwxlq+XMhR2qDaH+Buh+NCNSvoB7pag/I6BvKw8t6FUInLUC7YGO2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp5hgHIJC8giRmg/l0NKkt7PRpEA1NLwz70nc5pG7lU=;
 b=ZHujCRb+mJQeBWMkHay21LcwBydlY/668Lu+A0XUF1EJHXGyAPixFvrja5W1/LYAZL8RQCPwuO5XO231R2hREMJ/GjRmeEXEDGVy/nMSsLUPRzBZQEkPtA/22NtPQoKQM4sioDZzKcPWvphbv+UBKxUu+TdwBpxD68BH0EUHvf0QIpQBEbPI0O7ney5XYtWxdYkeFfm4V8Q2GLBGDE7PVIhChKwOqzARlghXbIdLSV1Jxmjtbzba7BdlHtdI9T/uaK8FLNzY+jVTdyS39yPb9c1tDSsDqfE+Br5dO8ngwulpocmpzxgiumythcV4vfs25KucnGZhNyF/4V4fiMP8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp5hgHIJC8giRmg/l0NKkt7PRpEA1NLwz70nc5pG7lU=;
 b=t+XcGkcKIYyrRp0ebuK6giZ6NYrAjlP41ka6kvXQoFuqn1Ya31m3amf7hsCEpVcGtbxx68XKqTsI7ZAJYrnPucMPvTM/SAWvnqxGRqerqFx8K/ZgGwYgTLDCD32JSn5UAxLJ0ww8oL4fSJcHfE+FVXejX8A5MvR8Un7s033l12UUZZWXtoqL56QbbqrVlYSBpk3GPDSrEVBPV3LGSwSOOJ2cJdDfN+2BLeFctXArb61lkIlOpu56m2DzenS7APDv5gnXQYcvx/4oR9iY7F/shakXQbsFT+13cPURSL+mIp7CfeHMkySNFm+z4hmkoTAOWbU3zS77xBJbdNG91N/Yxg==
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 19:56:08 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::9f) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 19:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 19:56:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 11:56:02 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 11:56:02 -0800
Message-ID: <a679502e-0945-c834-9c0a-66cb7b194069@nvidia.com>
Date:   Thu, 8 Dec 2022 11:56:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <tsahu@linux.ibm.com>,
        <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5I78soNmAFv7pi8@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a6a2f1-fb85-4f09-a0eb-08dad9563f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKceljLFBhxxZezD5M6kHAI0N4TXkaVBtHUXR2dNU509XYZaCyUFgWawhmaxFrgw4/xDIhiJoci52OYq86WLhI3C4ZtcfnFHtjLV2mTP0u1ojxck1uA+vcEnfgudd0kO+9F32pb6DVKF2fpVeuiMtKCeXzoKqJ6VqDc5EDwFshIta+DMvip9Si7KjrEGWo/30M2lp6p1a348vYoqjeq0N4grOU9VcAok8e8mwURPXzAcrcp3uudKzR4xcqlXqNIi4NQ2OnfNhSteiOow6yYo4e1dYzJXU0KrkzaK/vhEXQMPVtlexenv/kWI5fPZXu2xtPvFvrkrxwnZuShrA9YPsDLSicM6Zzok3Z5eGuiqGiBZ/PzNMSTAQ9hCHEW6lmJzh7uNzKNugG+WBoPILT64lTCE1mT2jVxl0FYxMYKH7/XNEeEHbUdXh6A4tLdoBMe9Iw9Yc0bpfPeTWQ/EB0RcSvZKgOVZbV5rdOCFKO53gbz5r60g4ckkzr3hl133bzi3n0gluk63kveANK8eno3ZAwl+w42J0egPErR8D6kvmQ6ws1nr8iKfX+QAIye9eguMH68ra7DmH9Bl2roHtu1buWnhRSz9Aeshqkq/igoGmrINAv979hHUh4Vq4xgP/XUNp1ayici/3k/veTEPnme1ggbaUP2ar2exv6s0lp/DkU5sih/FPL5+NqVSkW3ThIm3qtv1zZThgeb4qoj/IVEqRJVC04TrwgkuOnW7XOSj7rQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(31696002)(31686004)(36756003)(86362001)(316002)(7636003)(356005)(70206006)(70586007)(83380400001)(8676002)(4326008)(8936002)(2906002)(41300700001)(478600001)(2616005)(110136005)(16576012)(54906003)(36860700001)(40460700003)(82740400003)(16526019)(26005)(53546011)(40480700001)(82310400005)(5660300002)(47076005)(336012)(426003)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 19:56:07.4160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a6a2f1-fb85-4f09-a0eb-08dad9563f25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 11:33, Matthew Wilcox wrote:
> None of the above!
> 
> Whatever we're calling this function *it does not belong* in mm.h.
> Anything outside the MM calling it is going to be a disaster -- can you
> imagine what will happen if a filesystem or device driver is handed a
> folio and decides "Oh, I'll just change the size of this folio"?  It is
> an attractive nuisance and should be confined to mm/internal.h *at best*.
> 
> Equally, we *must not have* separate folio_set_order() and
> folio_set_nr_pages().  These are the same thing!  They must be kept
> in sync!  If we are to have a folio_set_order() instead of open-coding
> it, then it should also update nr_pages.
> 
> So, given that this is now an internal-to-mm, if not internal-to-hugetlb
> function, I see no reason that it should not handle the case of 0.
> I haven't studied what hugetlb_dissolve does, or why it can't use the
> standard split_folio(), but I'm sure there's a good reason.

Sure, perhaps I overreacted to the "abuse of this function" comment, and
the whole thing could be fixed up with a clean name, hiding it from
the public mm.h API, and...removing comments about abuse! haha :)


thanks,
-- 
John Hubbard
NVIDIA
