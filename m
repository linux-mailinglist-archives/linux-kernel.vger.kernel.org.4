Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD17689266
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBCIgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjBCIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:36:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B451C77;
        Fri,  3 Feb 2023 00:36:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkqvoHguzGbLOlkpKn9gaHPMCgC+J6OZdSM0+aJ0N6DTIfvgPGp55AjIq7+hfsd3e3eg2rdY8Ik5TXVRHTNW2ojVmP3QUxs4DASDkwkqyH+L0wZXhPGfndQFbiHodPOjge910PjBmZ5JPXetgmSTdtOpYK9ACOUMJN/Ou2fsXPHRVtgYuOm/aLduGo5tAXwfBIYkSgaqWgsDaW8fsKZcULGJK2AS21ykTWEPw4rlQ6EDLl3lcF8T+RS+SYikhGgu5W4KNw/gS0h4HlnzxGjnKFebH6yRv3nJYc655X33t4k2KcX+1sdfu4FiQ2PfU+cvjjCGdpCgwzoXIeNGB2uJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXL2SX3+JJ8v+4CQVzU9ecjkSWap7v/Mak7JXTVVC94=;
 b=GuE6dKO/08pEseF0aYpfurXJbZbGYbG/rIodlxt6d7lCAR2fOmMfMramzEiKeMB2yM8EuGXTGhFWiXa4m+dZKYCvy0leLpsjbpezVAPj6cG427nqiFx56TZNoD0muKLWsVkrwzKOVuWZMJHj0e+FzQIXhn8BbSFU0p/+EMszvr5BlFcnx9bV7lg4RF1taqJuCh59ENRizJ2N1PlMIh9TjzRcjOE05u/qCnXsiQe1QlgHWKaUsZgWDZ9W2sBLM94q0jRsO0wXk9YWC5AJSU133x+ZT+6y0bfHO23eSSdYmVmhLrlqviN3CEUSS/TqSI9ogISsfNroyowWQek47lUIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXL2SX3+JJ8v+4CQVzU9ecjkSWap7v/Mak7JXTVVC94=;
 b=Nrj4/JJW9buyqdV/8fddL+z7zVpUtf2GbVocBTRy/0ZlDcsa7BkibBtJSs14fTIoikefux7aEdJx4TWbw5Kaa5KdZBc/5NJGt2nveRJOD2GOgrhguDV/xytW/zaU4tlhea82dCFQrxL1OEa9GHeZArXMS95bUXAzBUMHTjrkh14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 08:36:16 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6043.033; Fri, 3 Feb 2023
 08:36:15 +0000
Date:   Fri, 3 Feb 2023 08:36:01 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Russell Haley <yumpusamongus@gmail.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v4 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Message-ID: <Y9zHcXYm1a8nYkYf@beas>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-6-wyes.karny@amd.com>
 <8b21feb3-624c-0c91-7dc7-708b5bb19a93@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b21feb3-624c-0c91-7dc7-708b5bb19a93@gmail.com>
X-ClientProxiedBy: PN2PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::35) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: cc91fbed-0dac-4fa6-2449-08db05c1b660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jVQcyssvm8UxKIYqa9nnHUMHPWOXltgaFKz23FRhc4AWa/bnlYPrQOtMcwEyxDZbnWOTGyVxqQPRw7uzuEfhzkupNqB8tZIcXtrkyROslUITu61ynPQqQu4MMkdVHugq9N0hgZKZgitJFwB1XLNLd/S2Dq4VJhT2/Ji956v2IayOcX12OzTkDz6IGajVEds4F8WwhVUdT724LObLGjAEUHnBwccZkq8QGc0Cb8VYF350JcoU2sohI36BMv0w3a6ye/4NsZEGmBX5pxbXw78mio8RIaOfC+QI3Z2/v52oB947YHJAoIloO1BOEd5Wa2Nxx7EMsQxSuQIMI3Wllr9WOINJk4PUj5K29oYBtMpakgS32oSQMPtZTe4cZmTlaYRBY/bK8xK61BZ4ZaI++f41rID870yECBlblZit9jJJBokQM97dzTak0O9AqK0+tceDQrh8S2JFg6ehsHHnK4iulQTXAH4XRH8naqTkx9VaroXd9D50euS6Szg680k7YiEWcEGFJ9OvuYTzfCCWczH3XJM1w4Pt3JbNpP351ZP7SwNye2Iz7z+egITeFAbu7DJDrXdPKEP5IQ90ndihnYoeLIAKUISNnUQDwZc+SCepCFhZzsRa70QbnnAI8szRwlB0e5+jHg6fL6w5I6B+Nq10A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(38100700002)(41300700001)(6666004)(33716001)(6486002)(8676002)(86362001)(316002)(54906003)(53546011)(6506007)(5660300002)(83380400001)(66946007)(66476007)(6916009)(7416002)(66556008)(4744005)(478600001)(4326008)(8936002)(44832011)(9686003)(6512007)(26005)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRFEXqemZjqTc+bfs5lvMw9i1S1DM/si2Lx1B2crw8DkD/pTr+/oZMEnH8bQ?=
 =?us-ascii?Q?eqAHjNSmn0GqOdbJL2fp4xVzOLmA37M4SqpkTqaomM5ppf2Zt9M0Fehqr+9P?=
 =?us-ascii?Q?/ka8AVG/2enzGF5oMw3myb9TdoLtIskiaZq9P+hs255s3PmfDqnF3tCrc9zr?=
 =?us-ascii?Q?bJ7pq49P04nLLXjBzB5T2WL/KbSyR0C7JHfr31UWWTVmYtoJvMU3KgZv43Wt?=
 =?us-ascii?Q?BHseqg4dlZ2h+va9b7iuNk7K3TGPd87mbqnRjAO1SvyGrHAO/zZc+s+vvNH5?=
 =?us-ascii?Q?6LJQcJ147m0e+z6Iukok/D262wxB8qm6IIK9aEmO8AeXJ7cGsyjRbTAtrEN8?=
 =?us-ascii?Q?zG4KSDpBNAp5Tw+8gnFIfaqPouSQMbGWZaPmNHDvWnMVX9Uo/lDVFpykSoL8?=
 =?us-ascii?Q?3lriiIOjL/FJZbUOwI6cUSq9coSGFaAIPG2nCHtmtaKjLE/98rcNEHheZRDV?=
 =?us-ascii?Q?AlzlHcrjGGLka5zFpUdF8yixwoqaPyCOmXdd2f4NN78ZT+3s+3Nvnnk8YUmm?=
 =?us-ascii?Q?AjZ7FoSv3I7xDseZYOE4Chz+qK9ngCpUo2DZigvAc7VvmjKROZCtMh0D2BZa?=
 =?us-ascii?Q?9UU+NeDu0QsYbyFH2hVz+T/oYounfKm95uVI9w/mx5NMyR71ZClyTNX5GuHm?=
 =?us-ascii?Q?HOkw9jI7UAGJP1csWf0toKeIoJZXyaSvBsiTqIX1g94Dh4gyZDV/Y68T5Sc4?=
 =?us-ascii?Q?SLXN/WIasc5ydiE5qAsWPoLTtmgtXnUxVoWWLfSOqCrIQZqmAjxNJMMhc5yq?=
 =?us-ascii?Q?AgtMqfUU72gXczJpjeVSYH3lgXxKbtGsHUukUI9ddh+8Dhmbh6xhkju3oGND?=
 =?us-ascii?Q?TNsTL61iEnb6DdbTXxi8lNCcJgqAr8KRqKv8fsjerLoJXHVZYbdkv9zkF2Hw?=
 =?us-ascii?Q?JgoJ7xjT9sO/TFxiU3vlGWt1Ed6XuzNhCBNHgHwL+n8dNhos1wHU4xM0H9xB?=
 =?us-ascii?Q?EfibjrrGKvx/iPweJyP+7mrmDtWzlFglTWTj/vUagzjPmsUkiafBrIZN2FMT?=
 =?us-ascii?Q?RTd18QbpQqS9R22ulrrZO2XkMwRoZZgr3RcOSQmhepET1eaBkqUzAn+nGdxg?=
 =?us-ascii?Q?IS/9hg0l0MgVcN4qfZra9StZZ/oO7so9qTtAvzMoeTcrtmEaCtsGQCwxIDoy?=
 =?us-ascii?Q?76RJ+wCmlLVNvH/M51VmTkzAGGpJfgSq884yl7vSuEDYdW9XJfjcvSLwLAyj?=
 =?us-ascii?Q?r3TsQ+OF6H35pMymG9ue2uo5AT5jS27iyxubvPnYYgThZe0CwROBHsn9e3Pk?=
 =?us-ascii?Q?sJwNUfL1jOUsE+0Zl2uJWfaqQJe6gK5t8gilT1+mCb8C9gznTLbwvTHL6S6q?=
 =?us-ascii?Q?2xZaOaaL+JQnHR9IBa6quo1zq340OBrDUedB+o2+LVX7WWcu8v4Xa0ydMufE?=
 =?us-ascii?Q?MkDZWGvYst572jUAooXMEMFUaT82Cp4xeiqUpgmvrRhsdjSrZ5Y9mvQM1/vO?=
 =?us-ascii?Q?axlQyNSuyalA/QpFw6KWrIiWuafKcjLoQJb53j6uCtWAJs3ie9GoY0O7XKhH?=
 =?us-ascii?Q?W1uhPYUp/tRTcU4GD9fjb7McJ+yzGiqLSmkrPlffbUfJ4v+l+m+a1nSjBPHZ?=
 =?us-ascii?Q?JBFQnhR9ky4eePRfZBpGZZBY7+me63XWvjQrs5u7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91fbed-0dac-4fa6-2449-08db05c1b660
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 08:36:15.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ltuP0Z+edKzd6Wy4gHkmt+/MW5XNG9HdYeGD8O+Xpj7PdTpqzLjn83Phm71Lakrvlmhp6lpxlvIqd7Y7s+NRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On 02 Feb 01:41, Russell Haley wrote:
> 
> 
> On 1/30/23 23:21, Wyes Karny wrote:
> 
> > Only if the state requested matches
> > with the current state then -EBUSY value is returned.
> 
> This differs from the behavior of intel_pstate, where writing the
> current state to the status file always succeeds.
> 
> Why not do the same thing here?

Make sense. Will change this to return 0.
Thanks for reviewing.

Thanks,
Wyes

