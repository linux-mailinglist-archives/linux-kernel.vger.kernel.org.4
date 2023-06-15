Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D7732261
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFOWEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFOWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:04:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6A2D49
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866652; x=1718402652;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fkoOmdO3DBeEIZj0FQ4OnxK+pKtTAa5lJzg8eFLBLJI=;
  b=ODkgA4WwgAGLzjbQ+2OvqzNvyKO0oIWPPgvoro6Fd7S402+AJOt1PRWX
   j/lAYcBuXYq5pocMWdC4qVYPtdIcB20U5B6XJoirz/5gktP4CD4ALOGX7
   RPZulNPt7hFydtV/4dZO9RBQgCdf6/0bhDZBQJS5mnV9qKg6Aop7HDGZA
   AfLC3fdT2mjNf/8+tdax9MZV2H7ndNQOfcAj9iGw23+guyeWdlCms8aXA
   SqDGu4m5WuiceLeVf3SI7E7OM1rSK/kzbavRc2wUn0PkGt2cye1ZYYXCu
   lihvOW/NlJlceGVNt6kr/xIQJnO9lmhGHO4BiplpQ4Yknim0wmjyhDCAj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361570362"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361570362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802575640"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802575640"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 15:04:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:04:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:04:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:04:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIpmwKGh7Q2fvdHG9wDEDiQBR5dn4iRP3auCikp+kPEo2fxv2ASUBjpONylQy6QOpPDIO+63tLACSPUxWo3Srne/Iu2cLnskfncvlWprIJJNetG0smvWk6XMaSZmCk2tFxUw8DwSUzaGuRSJ7SR7QbCc+49b/y5mW9xp8HEFZST5wIGHqhjjdkh8w+YOX2y4s65IYNiSVBPmkB54ClHbwYIDeAvYZpEBamvIprZxxj4feSmqkna2ye8DnZGl9Qa75TwPLzjgpVghLgm2vqq+ybV8a/UEyw9fK1UxF+pMS+pg9CplCPMmTNHggxv7IwuZUUojnRDQCpl225YFO0RN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxVy3iVt/HpV/UO4ci/ovDKAXP8bJi8EjwKPKOVL0MU=;
 b=WUU62wNASwT6ZAPNK8a8gGwfyY/n2Am02IjqqaFNMTwop82BGczPgI0HaVOPBHIrfpAOg0FhbT978bWAKAvIm6LrI9NQmBU43ZR5CXMqzBizjswQPKtr4nzNcpYmciAcb7pdncXEaCQUUCqPzs2zQJ81XIGQ0Z594NYfhf1b2b/pfymEohwQinabd4fRfnPnIKEzNU7eK9tV38iQZLs3cEoTCxue+ZWydBLopDv4dTjsSnD6FGZr6ERI9lWkFZZ6bkQg0iYA5YDVWxylt6eYVjCZ8/Uy5I6rPnp1O0ykZjZTcJbaPKdrt2/oI8tJukyPSHmsoSfqthvh4CaSq4gCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 22:04:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:04:05 +0000
Message-ID: <d3a85517-18c1-5793-133e-196bc2f546d5@intel.com>
Date:   Thu, 15 Jun 2023 15:04:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 03/24] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: d90f8ff2-91dc-4855-5343-08db6dec6f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfwGgoz9+W0YH3gsEJ8quuaua+ArywGlXm5tAzC/Lip1TEll8++DuDpO7puLDK+17+e/yl+5FMoJ28JHG+YaLfhd719ONwuR/CYFW/Cv4OquyuvRNdhdMcVlh/PQ2OV6KBXEw4CrYF3W5PNDW5gKKuaSvAFwmiIsbPBHD4bN26BSuzPuIv7f1I70FUSqm8IBPNTAp22fbw4JuoVFkRY/ZGmtWGWMD8zfsyfbVOkNbBFqk3LLr8Y7x8EUf3Ur+FM4M94Vr5CV6RX5KfGaCZtpAGrQiW/w+8iW7/Vi02xqnTdNWCYGw5vTE66ryt8/9wnC4gpjhHCIUPjo8ZIg2O3N+6aXiRzPYeEctfiRWXB/chr6TxnVyvcdkRuFl0YDmpyJslczSmfdddx1xCk15bl1/+wekyZO0pS+FxI3MBobi5BlJWBk1LsVLLbPjpaiXSzUN3PajDrMExtL0P4OghS6TWSLffR84SBttuFuGEdikAhAXjnEnRunLCioUT3R6+NTYuZvKZxwLxUoLt1nRn4mUsBR2zOe3/jmLC/kwJTUGG1dGBii+t0PvlA8yz0J5J6uQ1sx3b+KGXng6ixFfjUJX0W3+kt3XZJVVe9oEKVOme3P8bZtHsFc6HmGDClXldTOAIScSTcPPwvBL9fcWtD0yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(31686004)(66476007)(66556008)(66946007)(316002)(54906003)(478600001)(4326008)(36756003)(86362001)(2616005)(31696002)(6506007)(53546011)(186003)(6512007)(26005)(8936002)(41300700001)(44832011)(5660300002)(8676002)(2906002)(7416002)(6486002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVlYU84MVNrT243MGhZWG1UbzBPZERPOTh3SWt1SlJiMWdZbWtHd01aZzFK?=
 =?utf-8?B?K2lPakhoNlFIRy9sdExTa3BabzhKVENCMzlwdnphYnRhUjUvUzJJUS9nQUFZ?=
 =?utf-8?B?WlhuWWNVc0JCK2hFOFYvKzR6VHNScnFiZC9aMnFHMDJtK2o2ZXRoM3RGM0V6?=
 =?utf-8?B?dm43Z1hUaE1FS1dsTll5T2hhdXorK25uM3V3YnNEd09pYzcwS013V0VyVEhF?=
 =?utf-8?B?M3lTaDhqQnFnNjRlQXpnQjkwL3FNV09OVDRnSTdUYSs5RE44UlNyVmtxbjN2?=
 =?utf-8?B?YTNDZnVocUIrMkxkb3V1NGtPeVRaeXZXaWJFOWFtTEZzdi9HU2J1Y2lOckNi?=
 =?utf-8?B?d3FmeDRaWHdhbTR1WkpGVXZ3VlBJSCtwd2tLUnVOUXIwRXhTMUgwTFMvUExw?=
 =?utf-8?B?WUd6Um5aOVhCRUthKzdQSVgybnh3Yk1kUVd2cEVabXBZNkRGckt6dkdNTDNt?=
 =?utf-8?B?NzdobzJqZ1R3UG9LQ2lIbFlJU0dqNG16N2YxeFRmZTl4L1g1ZU1TSnkyem5r?=
 =?utf-8?B?bjVOT1pjc3BkVXJrRG9Nb25lUTF2bmplRjErbDhocDZPbEhtMUg0UlJWVWZY?=
 =?utf-8?B?UFZXcGd4VUNKUEdDTS9uQ01EMitoeXJVRmZiUVJxVFZwanc2bVErWmFNc1Uy?=
 =?utf-8?B?d3Q1NG5NNExOaUNKZWQzY0xUTlA4SkpyNDRUbHkwZ01USEZMMW9xRCt3UlF6?=
 =?utf-8?B?dEhETE1aTlN4QW5yd2pvSW9TV1A2YXovS05WNUlhUjRzeGhzQU1tRGs3aVg4?=
 =?utf-8?B?NEdPZk5kdGpsSGVKanA2WUdGaTVWd1RFbXpYeEJjTWFBQjJrY0pDOWRnN21D?=
 =?utf-8?B?dHI0aElQelF3cDU3T3psUnBiSG9BOE8wQ1BXWnlzejJESUVQOWdzcTZTVW5D?=
 =?utf-8?B?RVgvYnpxQlpISk05bDZ5YXBEQU1yTkZIZG9XT0I2WWcrMExhZEpack84MFVO?=
 =?utf-8?B?c2pXV1NKR1ZPRGg5a1hueDUxU2RueWoyckxCRjIwYmNCUDZHTHk5eW1keUNs?=
 =?utf-8?B?RnBaZzZuRGo3cGlqbnJTUFZLTzZwUHZSdi9UUC9FNC9CeU40dUpCTm9uZ0lu?=
 =?utf-8?B?V2pKSFNvQ1VlQ28yWlF3SGlVSVc1WndiMnk1WGxBTmpSeHNWY3E3OS9DNUls?=
 =?utf-8?B?WVlvb2phajRScm00cFhIWXVGTUVKNkNmb2I0dGw3Z2M5Um5ZWVB0QnJnR3dr?=
 =?utf-8?B?QXBES0hoZWErWXNDU3lydkY1dDVlS1pJZEZ0alZOeTlZTVFQbzVpSFg3ZWVK?=
 =?utf-8?B?ekRSdmRlUnlZdjBKVDN5MnZnKzNjeUI2aC8ydWFXNlFUR3hGVGJ5WllDUkph?=
 =?utf-8?B?eGh1eWE5K0tFd0p1ekFZaStSUktXcVhEVEZ2UXpZdFVYcTJNK05IaUdyUEZn?=
 =?utf-8?B?aXF2ODZ1NWZYQlVIbmtiODZZaE52Z0tQcGVKWnlKbkNDYW1mKzRRSkdMYUtP?=
 =?utf-8?B?OW5NMzl2VXV0a1RmdU5kWnN3SHQzRk90N25jTDZyTUpDY2JGd3VGZjRleW9r?=
 =?utf-8?B?VGdIMG5NVXM4dHhKLzlQZmZTV3c2aWRjZVF6REhFWXZMQ2lDeXdBZGQ5Vllh?=
 =?utf-8?B?YWE3WWF6aWdWUXdvc1VLdFdrenFCRUUxRmNFaXRIbHN1L1ZFOEJUR3dadlJ1?=
 =?utf-8?B?YnphU0R5UmZPeTgzYkIzNW9PdUdXV1lGQ2xTSlBNZ2N5UGVkaDliRTdYWHgv?=
 =?utf-8?B?OFd6RjRQdCt3RStWNlVrUjZPWEZiQlhDT2JVcHRwa2JaeWttRTR6WW9YYlpq?=
 =?utf-8?B?NVFaU1pmb2ZBbVlkVjFKV1NjZUlLMzBlTmtXcGF5Zk5vVllRYjFOT2Zld2l4?=
 =?utf-8?B?Mm1YN2VuZERyRSs0TDhadE95L2tVdWNuQm5Ua3ltRWd1TUxZNnd1WVZ0czk5?=
 =?utf-8?B?cmwveUxFYVFFV1RoSUhyR3hvSG9qdHhYM3RId3dPNUVnRnA1ck5UdXRCcmRI?=
 =?utf-8?B?dzhOMm45d1NQTHNJNEtCU2pZeWhPNGlEOWY2aXRoSEdSc1J0N24vWDA0S0w1?=
 =?utf-8?B?aG5xNGdpU0RRai9jV0pkZG9hcVpVbXZHa3JLZVltazVJa2JxMXNPL0NsTE9q?=
 =?utf-8?B?ZW9RY2d1b0RnSjk5cjZFWmprNEFFY2hzYWNuUGxnVXdPNVRHK0NjMm1NeXlN?=
 =?utf-8?B?bkVIY2k0U1J5WWtuV2l6S1hXdlYzdEVsTVJTWHl2VEFmV1U2ckFWVXZqL3Zo?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d90f8ff2-91dc-4855-5343-08db6dec6f60
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:04:05.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7qWqsed/mZuFzA6JrkvRnalwrzhNBPkupw8mR+SdFpnRAvqHEXtbKkhD0Ub5WM1jV+iXZhZxL5GnCWX0OH3oLEJgMTcCBPGQdUa+5V7duM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:
> When monitorrring is support, each monitor and control group is allocated

"When monitorrring is support" -> "When monitoring is supported"?

> an RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to
> allocate the CLOSID.
> 
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> To make a subsequent change that does this easier to read, move the RMID
> allocation and mondata dir creation to a helper.

(nitpick) Could you please swap the two parts of the sentence to make the
changelog easier to parse? "Move the RMID allocation and mondata dir
creation to a helper to make the subsequent change that does this
easier to read."

> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reinette
