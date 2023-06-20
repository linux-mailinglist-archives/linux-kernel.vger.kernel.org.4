Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323BB7376D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFTVy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:54:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A471981
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWftsWiJYU/LOYaXioTeNX+szlF3zNXhW48oyYytGPpAfHp3edNyx1uwanrQC2C1/ygo0VeWj3GjmAl3EDK+Za8E+olePkuAXxnMXDnrj8T0sMBApStmrSJ/gWIPyUOnkP3+0iFK/IZpdpO2DEtu08heyWlCkTQOTOselsBSo4P2t5V32bnu0DTQZW9QwFZSOCmdMTtU/u3aPJqXfWe7xEWAW4W6iuC1N5SNUUj6qzuEGRfJTRKKI5Q+hFpP9TMYF4vukp1iuH/1JjuvSdX/wUtN2H8RPiV/t91d+si2yFcYUMlPY0dAVOeTXq/MugGM+m6SAmP487pYWvs3RyVhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KPhA2YfOCMOP3YgOSs3DGOIq4fxkwyUdMjVl5Ik9N8=;
 b=nGhZ2cShKR2z5TiuHaVZtRUlWIvbjZwiNHkK6wgl22skvotYbPULSMM0KbYQ1fjKMwQn70wSGHxwKy1QmrM5aH/KSxCA46xn+lIRjpzd29rGLHrNXFdD/T96egoQMiU8JX/61YLP1TqtgeYYtu8dW+0eFx1KayCLIlnCgj24Igo0bAiJahSuz1+lPSwTpMHeG6SIW0tGtKjhuE0enGkz+w2SHELwZRxcL4rNCAOfbZQQ4cLZVGqOVrI1rimEfOWs4bQBm771otcdZK4V+HRRsKNJ3c+FwAIX5xITcO7I+u8G4vthEPs4v2VQG35XhqNEVHllDgLRkY5aDsSRy10dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KPhA2YfOCMOP3YgOSs3DGOIq4fxkwyUdMjVl5Ik9N8=;
 b=OPI/qz2FtWyAqt68bJ8yCFRIi5XRUJxC9NjWXM71xBZ0P1prITVrpTR4Z/J8hHiXPrw6s0+/0eKsYkko93pfJsItE/F8fo6DliWze5mxQlDr1DLhU9vKKyrBsxNliSsy1QcR7YjXVZ0DoHfGnMGPbr/PHZfxg3GNG6hAjDKS7KmgK37Rfz8sg/aGD5x92QzejzfxoZh7tSuA+tiz7cCO+AZhlJqWmMQTZgxLhEUyvyWDNWICA4bm9DpYA3EbxGJMKtrV1oqh2todShqOhKzrqgwSVqU6ME+cONIL46syJ8dh2mcIcMAnxMK2u/aek0+UQcw9p0v01XKT4ovXctMjNQ==
Received: from DM6PR13CA0030.namprd13.prod.outlook.com (2603:10b6:5:bc::43) by
 SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 20 Jun 2023 21:54:49 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::1d) by DM6PR13CA0030.outlook.office365.com
 (2603:10b6:5:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 21:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.38 via Frontend Transport; Tue, 20 Jun 2023 21:54:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 14:54:32 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 20 Jun
 2023 14:54:32 -0700
Message-ID: <80e01fa9-28c0-37e8-57f8-5bb4ce9a9db7@nvidia.com>
Date:   Tue, 20 Jun 2023 14:54:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/memory_hotplug.c: don't fail hot unplug quite so
 eagerly
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
 <ed83df65-f785-7077-ddd0-4e53d6fa6056@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ed83df65-f785-7077-ddd0-4e53d6fa6056@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 083c0afe-4c01-4f04-230a-08db71d8f802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qtg4PpgqU+7GbG7uqZvaCslRN6UT7Ed3arWvd3OLr5mN6tSDuvpBZ9V2gE4H/PoepVAQuDvZ9/xl7Pi1ikhrrUftqm4WZcrPnuHrne+Ca9hpqeAyQzx+WP5c7dkPgmxRSNU/c+liOy91+2Yr8HeO4j8GDlT0BmvgTa6aL+Bu/xbmUSN7asGotj/2TNcKc+1KtgmoNaNwV/ltkOs7I2KHJHY+QNg2s06G2wBrcqetY5gTxjUD9mqoz/OuBYpd08BsMuRT/Y5e+QDOyH7bBS8dof+kFQDYux60sQGX6155u1FYxQtsMJ7O+GU/pC6Xz2dYxCepkP8NEqeDC/Aa+hwokSZBtdWGjfU/HX2YkpDlpe5JE/9rKDjPCl4OnaUZ5jvNk+Aov92wlNkGvsLRgGh/mjZ60/rXnxKjPlZCn1oAFX0rcDcDtLvJyRfDMLYccGPql2U8BP4OfThkV0yDwSIYMuWJ8/MAg6Qk1AVvy6cz+x6QN24mA1ilql3OkPcoUL3nMPc72C/MSEv2A0eDg1zqh2G8vpqZRLezvKgosOj/ziUs7811Hoqm1++AWvd4RUYK658iCZEG3h6TSvsNjcxdcc/mtcetvErAa98eduHRXPKCNd8KhRbqo1bd0KFPTCE4hWjpWwFoNcqvTcjSHBY6pmp0/C1tHTWnQpd0M+yPLDMm3p1zHSQx1eotLBDaAl3tdAF4+GT06kiEvEC2iK7hh8+idr3xiRyVdXOIPClO1khpdi4JS9dgAPrFNy8GmMnalk1ho/WUwaZqvOl59Edkkv6hdgyIswBOj+OkXfbDpKdBAoNx75zux8RAHpsQ70VT
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(31686004)(82310400005)(36860700001)(36756003)(40460700003)(70206006)(356005)(5660300002)(8936002)(8676002)(41300700001)(4326008)(86362001)(40480700001)(31696002)(316002)(82740400003)(70586007)(7636003)(426003)(966005)(47076005)(186003)(26005)(53546011)(16526019)(2906002)(2616005)(478600001)(336012)(54906003)(83380400001)(110136005)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 21:54:48.9259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083c0afe-4c01-4f04-230a-08db71d8f802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 00:12, David Hildenbrand wrote:
> On 20.06.23 03:17, John Hubbard wrote:
>> mm/memory_hotplug.c: don't fail hot unplug quite so eagerly
>>
>> Some device drivers add memory to the system via memory hotplug. When
>> the driver is unloaded, that memory is hot-unplugged.
> 
> Which interfaces are they using to add/remove memory?

It's coming in from the kernel driver, like this:

offline_and_remove_memory()
     walk_memory_blocks()
         try_offline_memory_block()
             device_offline()
                 memory_subsys_offline()
                     offline_pages()

...and the above is getting invoked as part of killing a user space
process that was helping (for performance reasons) holding the device
nodes open. That triggers a final close of the file descriptors and
leads to tearing down the driver. The teardown succeeds even though
the memory was not offlined, and now everything is, to use a technical
term, "stuck". :)

More below...

> 
>>
>> However, memory hot unplug can fail. And these days, it fails a little
>> too easily, with respect to the above case. Specifically, if a signal is
>> pending on the process, hot unplug fails. This leads directly to: the
>> user must reboot the machine in order to unload the driver, and
>> therefore the device is unusable until the machine is rebooted.
> 
> Why can't they retry in user space when offlining fails with -EINTR, or re-trigger driver unloading?

If someone uses "kill -9" to kill that process, then we get here,
because user space cannot trap that signal.


...
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1879,12 +1879,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>       do {
>>           pfn = start_pfn;
>>           do {
>> -            if (signal_pending(current)) {
>> -                ret = -EINTR;
>> -                reason = "signal backoff";
>> -                goto failed_removal_isolated;
>> -            }
>> -
>>               cond_resched();
>>               ret = scan_movable_pages(pfn, end_pfn, &pfn);
> 
> No, we can't remove that. It's documented behavior that exists precisely for that reason:
> 
> https://docs.kernel.org/admin-guide/mm/memory-hotplug.html#id21
> 
> "
> When offlining is triggered from user space, the offlining context can be terminated by sending a fatal signal. A timeout based offlining can easily be implemented via:
> 
> % timeout $TIMEOUT offline_block | failure_handling
> "
> 
> Otherwise, there is no way to stop an userspace-triggered offline operation that loops forever in the kernel.

OK yes, I see.

> 
> I guess switching to fatal_signal_pending() might help to some degree, it should keep the timeout trick working.
> 
> But it wouldn't help in your case because where root kills arbitrary processes. I'm not sure if that is something we should be paying attention to.
> 

Right. I think it would be more accurate perhaps, but it wouldn't help
this particular complaint.

Perhaps it is reasonable to claim that, "well, kill -9 *means* that you
end up here!" :) And the above patch clearly is not the way to go, but...

...what about discerning between "user initiated offline_pages" and
"offline pages as part of a driver shutdown/unload"?

thanks,
-- 
John Hubbard
NVIDIA

