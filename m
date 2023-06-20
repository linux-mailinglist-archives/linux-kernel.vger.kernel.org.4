Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8177370F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjFTPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjFTPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:50:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA31729
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687276229; x=1718812229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eSVFD+4yBD0pLFM2u9/DDQZcxV7J5MSdm9GhEMLl2TY=;
  b=h13L3grCz82QX5aJcGYzOr3FuGESFpoyKPSIxFxrhRy+/dYiZby4tiFr
   fnQNmIKq0aWM+z2C+ayq4WsHjG2ai9tCqdhtA2aqCYqDMJNadJjzds+c+
   GLBLMHOF3dmngbGgzzJaX8ixj++WD9TTQA6qa43bq77jwOVWC5awadCrq
   OA/uvUFLkNcltG8Yd3JEMXaZchEIdDCiCELI39Mov8zuCcCnc4hha4RDK
   SfPMd2XAqr8CZfy+AZYGGcb3Ck4uS+7ht2Q6YRiTKK+HFYpfNr74yRxyF
   4OSSYqvpNMCdpJd70qdovxefJxQkcgjlE26+lmvXOg7H3PJYiQDeao1qS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="423561222"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="423561222"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 08:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="960827230"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="960827230"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2023 08:50:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 08:50:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 08:50:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 08:50:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 08:50:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCN3M3LvxKpGpn1XR7j8yMBjU2Q43Af3Lu62x1OeGOvgbu/XHxf+2BUkAJXWDOw4XM7ROLR+ukb+2Ryc1iNub7N+a0TvYkZQrNzQo6u17VqcYYSR21cBzxCc29H7zP6iQn8CoUyiJg3PdQsQmEqt5qnDaCCR7uPTIhlMEVUdbihxTN7Rc85xioHACvckt9FatHcWqjCf/tjyfoa00FsFOvKuTzRJkiIEG/4nv/8ngLdr9VJt3pUdEf0BIispS5KRaAJHFCf2AcRbx2yZoRujabe6sO+rknUdHEG/5eH8wUWypJmelRkjDh72XRsjaVIqQFMeth9nQk8EgEvAqDpaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaDnDofSHLk+L77MKFdSYjh+JvqeRnHuWpNKlblU4nY=;
 b=J7DN1jcg5+gyOLYoa2LOEKmOQClwJ9JRXp7l7HYHWK8bg2ikm8hdDpqWePaF5TBd5B59CiJN/IHO23qD8B4DkFgQ3SuHmWJPSOcd6heTcgKkCIpO4Vi1ITs0B5MRVndVAL+TD19Nl/nE1IRWAc/wWtV+7q5xgjUY5/LrZohJBVZXd7sI9nI83+0u0UA7wlY9lrQJXx7zf3/b6032Gywd6QxMK+2j7lgbMv76Z3EiHnqGk3e6LnpIOZFEjvLzNWut/3lYTAubY98Zw1vu3TGx4dKA0q7vjuC1vxQv8u7KnHFBhYe0Pby85YGrCizM1xxLucnyDOP5dT9+/XR1UR0/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:50:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:50:25 +0000
Message-ID: <f470afd1-2c13-b208-7e8c-7a8564f87b89@intel.com>
Date:   Tue, 20 Jun 2023 08:50:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] x86/resctrl: make pseudo_lock_class a static const
 structure
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230620144431.583290-4-gregkh@linuxfoundation.org>
 <20230620144431.583290-6-gregkh@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230620144431.583290-6-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 650353c7-3286-4383-eadb-08db71a6101c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdsQJr4x38wU1TWFk2VSlUcrsTnrY9c30GxgNmroof29uti3gcoHmRn94VDLqMpQCE9WRe1G6oAfBxmUbDlmh/iNPW85eY6G+Scex73btFIUDXXhRb1Wnu39tOh53q1CdlBlMrmVPQG5AbIMNjAHl5fr3559jgxx6BCrCOL9WjGiBo/UgOo5xplf4FQZJy05SHJ2TgB5Td2yLtsRiAYXWqhhP0Hw2eG321VXZZK5JOSZCk2wpOX4uGUU7kqpidNG1FiPa81cEFHrJNmYtpJCjnJhA1ZKQuTpZcfDdYhYpyiVL6pJP5e9SCiPQgerwvBda9lnN3Y/ssl0BEvsMJGyxBsJC/TyDAriBR7+JFzp+n9JBRy6bIWkDqufXqhbs8+YqUFnA/6Y6/lzCy9DkiwbW2sEXK+Vk6gxDXrVQDJQAe9yzpAyrnxHkRf5Bw2nuk7w3GgRjZJ0xmFlCCq+mHPBnHozwuzWcIRxbQe58ZcVk5fN8m73LkxJ2Z7XeO1Us+Oqc3EfwnLC+u2GCekoEzPuStTZNqK2oJmlpbwRJ2HRcinAFWeFHvB+JizWUYMhiwnWGijDL6sCu7sAYU/mBDGZN4I+X/ls3YGD9hA46cbvnE+DNvNLIbQVs0X0DAQIr3p85lf5R/PmIVEq/eAcRCH0zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(4744005)(2906002)(2616005)(83380400001)(8676002)(478600001)(6486002)(6666004)(54906003)(5660300002)(6506007)(6512007)(53546011)(8936002)(44832011)(316002)(66946007)(66556008)(66476007)(4326008)(26005)(186003)(41300700001)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpsSWgrNDZhaEZkVHU1RXZCbXpsekR2eHN1bnNBbXJzSTI3MzByVTRJUlBK?=
 =?utf-8?B?ZENRdThoQTQ0L0tpS0JVZzY3YWhmVStLa2tRQnkyZ25aUWFPc1ZTYVcwV3R1?=
 =?utf-8?B?bGt6Z3p5cmdMUFZOYzdPTFd3L0hXdm5ramdzd3dLU0tsMUVlbHNqSGlpVk42?=
 =?utf-8?B?QmJwcURSek93amVYK09oVjVhQnQzZm9BWUZuTHE2bGVzRGlqNDliY0hGSU1P?=
 =?utf-8?B?RkprUmw3MFZDYTJTWmU4RjVuRnVHdU5LQzR5NDNWMVZkQis3bGUwQ0w1dG83?=
 =?utf-8?B?OStwbXV1MnRBRGd0T1RFcmJlbU1hN2Nad0grelVDbXo1Y0w0YjlWcmFGZ1Nh?=
 =?utf-8?B?MytJb1lweFJaZGNwZnh6N2lXZTBhbi9YeVZlUFhTVFVpT2dyUlhsQzFQUFBW?=
 =?utf-8?B?WWV5SW5CSE45ck5qTlJqTG10RmtNdk9IK203SUFrSHB6ZW03aFdKL2grUHd3?=
 =?utf-8?B?UVlOeHFzQUF3Q21aTEVzbjVtUTBSVXpwdHp2RmRyTUtkd3pPNWhLeEdCdWcx?=
 =?utf-8?B?SExnNjVnZTVnWlNFL0l2bDYrenk2a2liV1NBSWxPUnB4QlgyL2VrcHlJbXky?=
 =?utf-8?B?bXFacjZJOHJ6ZWsyampUK1BqR2Z1TWxIbitDYWd6WjJjM20xaTVXOWV6RXFZ?=
 =?utf-8?B?dVJWdUZqSjhBajROd0VtcHBUczc4SUlwa2RvMU1IQ0VlTndMOEsrd0QyZVk3?=
 =?utf-8?B?ak5SZm1CU3lxQ04vTmR5b1U1NGkrTE5UQUpkZGtUSVhLbzQ2NENsQThua3A1?=
 =?utf-8?B?QU5NdEVNVUFJK2w0ZmJrOHJmWnNFMDNYNUdCdU1ESXdHdTNMZVBKeXVreVY5?=
 =?utf-8?B?aStWaGtIcmI2WHRRSVFLcWp0UVJUUFNVL2FqVmNFdm14U1pZbzhIcmZ0ZVFs?=
 =?utf-8?B?bDVHU3FHMFREbC9NMlZPcm1QbVB0TkUxdTJHWmtVbUszdmx6SFBkUlJNNnVi?=
 =?utf-8?B?ZCtpaGZwY1pqRTJXMlZlTzV4cHBWZCt0YWxkWHJ0R0oySVQvaTFRdVdkVXBV?=
 =?utf-8?B?d2Y3dURpS0Jtb2gxWm5PSm4vbExDLzRpVW42ZVBNbE1YbUVudXlabFBOUXRQ?=
 =?utf-8?B?djNUbVdhS1JJeDBjKzZtdHdtSlgyc0FieC9oTUd3Q3FYQWZMNXhJa3lmaUQ3?=
 =?utf-8?B?MFpCWlJzUStYd0hCQVNpWU12Q2pDS2luZHl3Q3RjQnpVaWxtTHA3MVlxNjdJ?=
 =?utf-8?B?cE50VEd1MDJyL2FreG5iTXprUXZwN3R1OW4vT0VGdWJQYUU5VnVqVzVNTTZC?=
 =?utf-8?B?aUQvOWFjMzBGSFlLTjdCSUhoVFFMcUV2RXRVUFlkTnRBUzE3WTBubGdLQmNy?=
 =?utf-8?B?cktLdDhUMUtWTW1Ea2FORFVzQVJweHNHcUxBQ0tFVEpvdE1WNlhTUlE2bllW?=
 =?utf-8?B?R1JVVFlmc2k4VjRFUjJjY0FZTUJuaHRZM0RaYmtIVVUzT1RDQzk4bkFDbTRS?=
 =?utf-8?B?TmdWVXAvcjZlSHhjZDB6eUJDTHUvRUdUYnczR2hvcUh6VjZ2QUljRnBVSFNL?=
 =?utf-8?B?S1BIUzMzZkg3N0t4R2dTVDRLWmFpdVpPOEV1Qk9UUkNBazVNK2xFQ25rQVJ1?=
 =?utf-8?B?VE9TQTdaQklXTXlvUnBGek9VK1N1bDlrTGVRd3hIMFdqbmRjZm1RY0QyL3M4?=
 =?utf-8?B?MEtoYnpoako3TlN1UnFEN0JtUTlzY1BuVkhpekc1TkRpR1U4ZHQ3NXRKK3ky?=
 =?utf-8?B?SHFHMm4za05wUTNHa2oxZVRTRVkvMWNLcGpoWjhCTTZNbU9RTmtodmdHNVFR?=
 =?utf-8?B?Y043eDM5YUdrb0tORUZNQUlidGxxWkc4SW03UnJ1Y1ozQ0FvVUZOTUxwRFRB?=
 =?utf-8?B?UTFSSWxUYjlxV2hZSEp1M2JXSDBGNEhiNTU5a3dnU2NBQngwR1JVMjJxc2Y3?=
 =?utf-8?B?YUNxdFoyYk04Y1ZSdHNIR29tYjR5MnhTMGNTOGJteDdBQmgxLzdvVEJmdDZK?=
 =?utf-8?B?YzVyZXVHLzNZaEZWZlk5Qnlrd1ptZzYxUkdvaFlVWURMckRhaWpzUW9vWmEv?=
 =?utf-8?B?QXlZY2xLTzBWeElkRFhBM1ZaOXBvY0NXbExpMThyRGR3bjgwTUVYVE1JL0ZU?=
 =?utf-8?B?YnV0Ykk3djk1RFNYZThrZ281eGgweThSWGxZQW0zV01pWStMemQzR09NM0Zj?=
 =?utf-8?B?RVIzOGxFME9QN0VmQU8yZXgzTkl6dm56c3hYVmRlWHIrL2dCWVJXUnJ5cTVV?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 650353c7-3286-4383-eadb-08db71a6101c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:50:25.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYTjfvk+23kVR66yrTxA7nCzdJBJDjio8smaR69CtVbAvgAw0TsSCHRinT45kYcqaiDAYLxqSQuiGt36y6MDjVCABbgNvzBNYsjzvLkC/ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/2023 7:44 AM, Greg Kroah-Hartman wrote:
> From: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Now that the driver core allows for struct class to be in read-only
> memory, move the pseudo_lock_class structure to be declared at build
> time placing it into read-only memory, instead of having to be
> dynamically allocated at boot time.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you very much.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
