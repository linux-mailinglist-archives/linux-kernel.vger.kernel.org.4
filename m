Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A196114C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ1OjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1Oiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:38:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFD4303D5;
        Fri, 28 Oct 2022 07:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj0PWzAi3JkOTGC6JALwt2JADpScbD+y0EM+ybAqp8EjTKqCF39KC6RiXbgXsMkJ5r9KcFgU85YBgiqjRRuTS/5fdPC3HU+rDRbiI5gW7rwN1ew360B0zOTxFKUbuGVVrvty7vOlPgd2KJbrR3nC9G6Y4eN91LC/8ZAconRw+IDu8D3TWLd7Xss4NhGRgxMPgd0sDb+6BLzGYWIkXem63kyNozCNl7iPHe/wB0Ec8ZBhBHFXuclPOVifZ7pThB/bBsX0/np8XgizWNo4wIQH5AwEXQ5cgobetphzyEIZoqpT1TQb8iD4ACiuXfjBN1KYWkZRiRZeQfa09KmxsdngXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTSPO2U0uUtZ8PUTdvXBa1jDiJ2uf8aBADfYiOm+v4Y=;
 b=YiwJa7hvFbbMI2IKbLSm4evaRcOntWI4TptlcTGxfwx+CRGkQDr0b8/ybOZ5JrveHbYF/XA4mufUTp3b1YmjJj0ihiDtAw+mYQ8EC32icz3ubkgWYCm8qNLDf8I3VvG0PhYRvXEZcEFi+GYFUWWACTLowfe5rZShAKo0bkOoCvRtW9El26fsFb6tzGAjCDQvqjrpJDkQ1c3IV3/wXS39KnJ/MTYhzEy8U4OlrTV02zUOOA95/+jAaQCTw22CbUp3jN9Hr9oZHVDjH0nNcm0WE1XqefFnTBJjU6OfM2mDyHKfbAsM7aCSRZWUo6azBMOTrPBJoy8n80k41/P+n0sLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTSPO2U0uUtZ8PUTdvXBa1jDiJ2uf8aBADfYiOm+v4Y=;
 b=tmOlH963vVxRNI18/S9G6pD7y7AHoHL9971M4YfDZaIGMdZ/TkjFmt66b/bf2I2+J2diVxmsAzpmPFRkSEcLphG+j6WbAZ43HrwxI3HK5RPTWo6EtJSWGgXHgut4YOIGcmV9UeLjJgkVhRu8ljCXrN7NlJu00+UTiOl1e1OPcDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Fri, 28 Oct 2022 14:38:47 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89%5]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:38:47 +0000
Message-ID: <eab3d6d9-9e80-d63c-70ed-733c8f9a13cf@amd.com>
Date:   Fri, 28 Oct 2022 09:38:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/5] cxl/pci: Discover and cache pointer to RCD dport's
 PCIe AER capability
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        rafael@kernel.org, lenb@kernel.org, Jonathan.Cameron@huawei.com,
        dave@stgolabs.net, rrichter@amd.com
References: <20221027145213.GA828055@bhelgaas>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20221027145213.GA828055@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9d6e4e-a24e-42a1-dfbb-08dab8f21f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fRqKm9F5w6jhxDV2Gu9kPwcdr77PsFdpw5XUPv/8bxBRKeDCKy937qJbgyhzq/rGe7zyCdJYVbv9P4TOJuXGikC8htFnWT0auYZZJTNWJ0CqmDArMpzIjNzsimjhIl6s/ssnEjhoGlvDFj8E2NsKyBNRdGq9ta22LU8CcfEsi89BL1OyH83PpFB02a2O2s7LZK6Mx0hsKakVftGCORsd6iFCXJqmAcabruDX7ftkNqywWwGxZD1g0jkHRH8RF+joeG25O+YbRi22R+2tMY5P0lTqpPhAQVyT/Z0gLcnJq5WuwZkv8K7cTIjrlQIgfh2H3/jnYIvgPIvz87iS+0JVLXw1l2lTIEGdOKnZzkgwd+bRJwoSZt+7z4Vd3vyjuOqRfCVA7xsM1HMm8EDQ3O/9eSmsKTSYsNXThudB3+Nh5BDbjMbNMZvpxUnrWazDiBFARZkiODhMF7+F1i0MZCCiqUWYU9QxU9UUSwKAVnt7AW2L57u6tUKPrtXE+Bqu60qOn7DzvneGRQn1BWbhjn2/Wux9G2BZzaHCNq+ck0m+nbgC3fKNZYr281muOI9HV2/MHTt1bdDDsycAEAnBEFgqdNAhhPDhZjCNdM/luyLHD3OAxat8VLvtTjYDSvw+UAtsbwn80+2n+O6vUxJJuAAczMFVjNF6JTa0kitQRl6ze37oICQ4ieX/r/1Y0ATkXw3t9QX2PjYQN6u3loz1SH3AvHi5VlYdCZnT4S84CkDJ4W1/7gcAfZP7iXxLvKzw/PC6fyX6HWrPw67RLDqw6Fd94zZI01nf8u1vvNdSvzsQQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(36756003)(6916009)(66946007)(38100700002)(316002)(6506007)(4326008)(8676002)(66476007)(53546011)(66556008)(8936002)(5660300002)(41300700001)(86362001)(31696002)(6512007)(7416002)(2906002)(83380400001)(31686004)(186003)(478600001)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZoWFZ0S2xheFB0MHI0aW9NY0JEME04MVdnTzNlQkQzUS9ZaTZvUjRwd1RY?=
 =?utf-8?B?MGhNY3JGTGRkQWdCM3V0TlRTRSs3dkRkUTdsd09tTzh0WXR5cXczU011bGtT?=
 =?utf-8?B?Uk8yeUozTFgwd092ajhEN2pSZTlIU3RBalV5bDFma1Y5SVZNMjRmUkpJZy8y?=
 =?utf-8?B?QnZ4ckZwSElwRGxUVG0xUnpXcGp3YVQra2dSc1hUc0cwSkEyWFI3NnBncWp3?=
 =?utf-8?B?dFAvS2FHWDNMbVBBTnVzdXlKZXRWUjVsMnZZMVBSMWVDVWdnWjlOUXpJTVRK?=
 =?utf-8?B?bTE0TGxCaFlHU21mMzFwdDRFMHk1blRBRFlzQ2hWVFJnUFlLblVtbEF5Z0NL?=
 =?utf-8?B?WmlRclY1aERnS0V0YVMzaGkyYU5kRHJpcmtQb3QybXlwTVFDdE1USlJ4V2ZF?=
 =?utf-8?B?WnpLMkFPRE04MEJQYThRV25KdWtRYjBoVTFVdTlvaXFmQVhFQmplK1pXL053?=
 =?utf-8?B?VGgxVVdEL0JPaEJoZ1poTlFXMjRnOWJPS3VnWUpWZUhGcVpZanRhUVU1RU1w?=
 =?utf-8?B?eUphMk9WcXNBVW5TK2ZaQlZ4bzRmZXFDNS9iYjdBMXhzNUYzajZtQ0NEV1VI?=
 =?utf-8?B?QnNNTVIwNSt4OVZ0cGZaZkxVUURMeW5NLzhJbEc2b2hjWTVOQUpaTWk5bEZl?=
 =?utf-8?B?cWJzbDkyMGlKY0QyRndpZXorUTdwa2FNdmdUNTVnelUrazdZL0JuMEJZZVVO?=
 =?utf-8?B?bVFPR01BV3NEc2t2QmlUZFFYMytRMlFQSFpxT0NSOTliYnFtSUlOQ1FGZnZ3?=
 =?utf-8?B?b3kvN0dlcGlFbGptMElJZFNWOWZkSmE5QVpYSEJqTzFDdEdid3hKRE9xc05u?=
 =?utf-8?B?OVFTdjgwRHhyTmFXNFFGVnZqekxXUit2Y2ZVWFNsVE5TUGFVVnNUUmlNTXp2?=
 =?utf-8?B?MytVVnZGRzNOSXZBWEdkTGJyZTg5YXFvZFYzL203REJtdS9lMTlpK2lzTEkx?=
 =?utf-8?B?K2REa2lOTVlkd1Rvd2tJclp6V29wYkVUTmt3WnJIZ2REUk1EZFd1UUN1Y3RH?=
 =?utf-8?B?Mnh0V3VhZzd5M2RlcWhDQzc3cTVHMGVPTm5weHg5VGZRcTRBSzdsZ0FtazNk?=
 =?utf-8?B?M1o5Z2tHcUlaOGQzbTNXR3I5eFJBMHBEUU5pQXQ1TlROcWRPVUJCY0tpeVVO?=
 =?utf-8?B?RmtRd2ZrQTRzTHJXdjlJK0Y4SWhURWN5dTNlLzM5TldDb3NtWlc5T0VDekVD?=
 =?utf-8?B?eTlhTkt5YU5vVlF4NVZYeWZ0Y1o4eWEzWFNQSjFOWGZHaTZ5d0lIRU9nb1BQ?=
 =?utf-8?B?bDZ3RWR5Si9xMkVWK0kxbnNDM3plQVhzRWRRMnlYOU4vMVZ3UkY5bzhYMWo1?=
 =?utf-8?B?anNObmx1K3NOdFdXS05kWUl6cy9mSi9TcVUyM1d6dDhqd0M3NDQ3WTgwelAy?=
 =?utf-8?B?TFZTVitCcWp5MFM2N0hlSEQ0Q2xmdkZzRFBkeC9hRzQ2aU9FMnp2QmI1aTlq?=
 =?utf-8?B?NE4xZDBjWVFOeU1ta2xGRC83QzVtMnIwNW5vNzNncmVWMUliME9RWjNPQWJu?=
 =?utf-8?B?RnlvZGhtaUk3d0VDZmVzMDZvZzJISG41VjIzYkNhdG5uN1RTR29OUmxDQW1h?=
 =?utf-8?B?V1k2THNlSzJwdUVDamU0MnNDODNEd1hNaWZYME5wdmJvc2lUM2Q2QU9HKzNo?=
 =?utf-8?B?amRvQkM5amxEb0I5aFYwK2lVQnJwMzlPWktIb1JaWjJGNFlqanVQaVhjeUdE?=
 =?utf-8?B?blFOVVVtYWRzVlpSalprSnZCUzZqM1diMWtxcFBuQytsWjdNdzNLTlVsazFp?=
 =?utf-8?B?aEZsUXJhNXJtSVp2aFZNb0ZlbGxBazg5WTNxTVFyTnBkYmZoTkpaUmpHY2F1?=
 =?utf-8?B?dytNZUxKemcwTnJ3UUpaTExLYlh0bVR3QzI2NE1pMWNxR0d6YjI2V29YaHNJ?=
 =?utf-8?B?ckwwYnZGZGtaYlVkUm1iOE5Ud2ZJaXRkQkJkWUhublpTMW5mdFJrcGkvWkpT?=
 =?utf-8?B?L0JYenV5azd6TzFWQnE4cFM2a1ZEcmd4TjZNTWNXellxU1RrMFFSRHJrUUlY?=
 =?utf-8?B?K2taVUtoSi83SHZUUHdVVHJEQ2pCMzhST1JKT29icDg4RWNMVkx6WlI1cGlr?=
 =?utf-8?B?WEQ1QXEzUGlQdEl2V0RJd1p2dVBhU2hEZ292VmJnRGxaQWNhdG5qZjdyQmho?=
 =?utf-8?B?eEZzR0JZb05tU3RkdXYwcDltV2ZuZDY3Zm9rV1ovd3BMNHJOUGk1VTNCTWx4?=
 =?utf-8?Q?iA9XreqZ55WuOHQ4+ZPPYHd7ebd+Qu1UAodvxJIc/34k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9d6e4e-a24e-42a1-dfbb-08dab8f21f5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:38:47.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI0x0wnf/4jKRK8de3abPWatNCjAgcuTEa9vIoFdTBhLpnvykS7zs61f8TR0vy3XTqRWMN0IyOOIbvKtQCUC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On 10/27/22 09:52, Bjorn Helgaas wrote:
> On Fri, Oct 21, 2022 at 01:56:12PM -0500, Terry Bowman wrote:
>> CXL downport PCIe AER information needs to be logged during error handling.
>> The RCD downport/upport does not have a BDF and is not PCI enumerable. As a
>> result the CXL PCIe driver is not aware of the AER in 'PCI Express'
>> capability located in the RCRB downport/upport. Logic must be introduced to
>> use the downport/upport AER information.
> 
> I assume "downport" is the same as "dport" in "cxl_dport" and means
> "Downstream Port".  Might be nice to reduce the number of variations
> if feasible.
> 

Yes, I'll update the terminology throughout to use cxl_port, cxl_dport,
and cxl_uport.

>> +static resource_size_t cxl_get_dport_cap(struct cxl_memdev *cxlmd, int cap_id)
>> +{
>> +	resource_size_t offset, rcrb;
>> +	void *rcrb_mapped;
>> +	u32 cap_hdr;
>> +
>> +	rcrb = cxl_get_rcrb(cxlmd);
>> +	if (!rcrb)
>> +		return 0;
>> +
>> +	rcrb_mapped = ioremap(rcrb, SZ_4K);
>> +	if (!rcrb_mapped)
>> +		return 0;
>> +
>> +	offset = readl(rcrb_mapped + PCI_CAPABILITY_LIST);
>> +	cap_hdr = readl(rcrb_mapped + offset);
>> +
>> +	while (PCI_CAP_ID(cap_hdr)) {
>> +		if (PCI_CAP_ID(cap_hdr) == cap_id)
>> +			break;
>> +
>> +		offset = PCI_CAP_NEXT(cap_hdr);
>> +		if (offset == 0)
>> +			break;
>> +
>> +		cap_hdr = readl(rcrb_mapped + offset);
>> +	}
>> +	iounmap((void *)rcrb_mapped);
>> +
>> +	if (PCI_CAP_ID(cap_hdr) != cap_id)
>> +		return 0;
>> +
>> +	pr_debug("Found capability %X @ %llX (%X)\n",
>> +		 cap_id, rcrb + offset, cap_hdr);
> 
> Would be nice to use dev_dbg() if possible here.
> 
> Is "%X" (upper-case hex) the convention in CXL?  Most places in Linux
> seem to use "%x".  Also consider "%#x" (or "%#X") so it's obvious
> these are hex.
> 

Ok, I will make the change.

>> +void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
>> +{
>> +	resource_size_t cap_base;
>> +
>> +	/* CXL2.0 is enumerable and will use AER attached to `struct pci_dev` */
>> +	if (!is_rcd(cxlmd))
>> +		return;
>> +
>> +	/*
>> +	 * Read base address of the PCI express cap. Cache the cap's
>> +	 * PCI_EXP_DEVCTL and PCI_EXP_DEVSTA for AER control and status.
>> +	 */
>> +	cap_base = cxl_get_dport_cap(cxlmd, PCI_CAP_ID_EXP);
>> +	cxl_setup_dport_aer(cxlmd, cap_base);
> 
> I don't see anything about PCI_EXP_DEVCTL and PCI_EXP_DEVSTA in
> cxl_get_dport_cap() or cxl_setup_dport_aer().  And I don't see any
> caching, except for setting map->base in cxl_setup_dport_aer().
> 
> Caching those registers, especially PCI_EXP_DEVSTA, doesn't seem like
> it would make much sense anyway since bits there are set by hardware
> when things happen.

This comment needs to be moved to later patch enabling AER.
