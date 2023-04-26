Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D042A6EF78A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbjDZPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbjDZPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:09:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2C10C;
        Wed, 26 Apr 2023 08:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll8kP9pAwMfagCBp3LU5RuEixUEsy0yvZugw5DMqFUtvyzhq5XpSZ/zn1RD7NzzKb5vd7Sdh/L4u59hPmdSd1+Ssqr6rnPcEdYj21TfRihowmza+EC+knCoJj7Q7sJMC5yw7EfYIcfUOwGxY59LQQDYlJsuzAtXSElb00XTR3iEi5EwMXM3A0fSKmQ3yEsqlqo2vQlFBIVovvAV7K4Ico845DRFmOH7KTaaVQkbaScdzf8twoiKQ1WYgiOnR1A4kSFMxrS1mUzGv4UuGjI9HDboLb51vJ++78oe4sf/ezv8lMlPKeiFHFIh4E1AUxPjlbbOR+79Y3ka94GVIlvliTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niuotSlLhi6NjUXMLeWCMIQnfgwxfbO0+8cS7tEDORQ=;
 b=f3zoMmg0H4b0fCoV5k4oH1jzzUPEUfrrayut6uLzBCatHNak8phj/t9x5a4gamniFpq/UIJyGh7ZL7BD4812sW6fcT57H4G44wgJiXl7c99CyhWC6189mGqob2XzU5lUth7KrrpSIzbjwupIPw43PB7+vs5KPhyMG0kpY3TMZqQUn6hqXaNN6ElUL8KZOubR1Yk6KZWM23x0694PrmhJ4MRNl2rco4F2QMjevYQ2lHLw1CU8kvMiFzXVnjqQQ3/CZFQbcpxrVxEZMPOlXSWICl/7Vf7d3HLSgsiy4pqNtyCpWANH54Z4l2U1A6hDSVrHxX0V229KR8jH4gIfYB6Elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niuotSlLhi6NjUXMLeWCMIQnfgwxfbO0+8cS7tEDORQ=;
 b=mDBsPDkGSGmWVjx1id1H8rMsbipYmVgjFfsuLZ15ZN5FEeUpd9KbMJa8QczmdYCv8T/V9lS5jJYaU1IFvA8wRgi0Jyx7rvbq5N3r/5SEy0B9QN31kFVJkV4/CnACM5QCJOM7+Cv0ZZ6dpPCkyrMtRXYympsZRTeVBxJ8/xpw5Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 15:09:25 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 15:09:25 +0000
Message-ID: <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com>
Date:   Wed, 26 Apr 2023 10:08:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0122.namprd11.prod.outlook.com
 (2603:10b6:806:131::7) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ccf861-e2b7-4ec7-9546-08db466838f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCIFlnpqYvr7WYhUpRF3HmtL2LgG7Wlq64B9gbtIVjVvBB073kRPze6PRdbtksoS9VCr0F8dUMuMyRanuDiCynDTj6HrV72EI3Nm25LHVDtiy+cxtWBh1cOZ+LDQvy4eyT9RfB6Tpe2rMBQT+YwGV6Z7flD+N8qbaGvyktKlXeFqS2Sec4K1/MitVaQL8WO6PYWR4gVDp9XzZPuiI0A/D3f05dbmVy1mg+k3d/YkiZn2xPwFWfRIXzg1j6qB1Oz2a9nZzQVZTHyYSiH5MtuOP42L9js1YLBli2ZZNjzkJ0IpDhqW69NlWsia90sbe+Qvw+byCxtABqRK/sitsxPpnBZoUD3qpNJQlA+36CKrxQ4hqmbn58SlcYA7aaQfzbl0aKEoG71n6zZBaDoGf7awyu9p/omoaRz+8x2fvDwK0HEO9glbBPiDhfejrZ7u9LnDOtzMO+P3qKZlvbV7u4YtTaZp4KHNDOfT0sYnvzDgsibSNJTNzdpPsxw1oBwlIyZ/GJlnWJBDUfSI0jtHcX4Bo9z4KkK3gDZoMsIDwlGGULkAT8bs8RVwF19cZ+FZadDBVhGsasRlYWt72mny2eJDQoD2wTSXC381tjKxNmXwXvVH7sgUwFYx5cqvoDzv+U3j7CKP9K/gCPmHYwk1qEfpErl8nM5r3GWIXviFVX0YB4QpBdteqWXd873mtH0/3nu1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(110136005)(54906003)(36756003)(31696002)(66899021)(86362001)(478600001)(38100700002)(8936002)(8676002)(7406005)(7416002)(44832011)(2906002)(15650500001)(4326008)(66476007)(66556008)(66946007)(316002)(5660300002)(186003)(6512007)(41300700001)(53546011)(6506007)(966005)(31686004)(83380400001)(2616005)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBTVm01MFJ5am9qeWJITUJPSHJQbDI4WlA3WG1FMmtjTTVQODNJYm9vcUFV?=
 =?utf-8?B?djFBc25kaHp4dEdpL0h3VzN6YjBBQ1RsTkRXdlZFZ0ZwRDZlendzQzNFOTZ2?=
 =?utf-8?B?ZFhsd3VpRGRjcEZvMTUwWjZrY2JaSWQrVUMvZ1NhdTRBcVVGMDlHS2dLdngv?=
 =?utf-8?B?Q0tING9aVFlEQldBTnJyVWJROFh5WEdzRVNIS2VjSHNBWmRZQm1aSkRPSldv?=
 =?utf-8?B?OGtDSWhZaCtUK1NqYWVmUGtIckcvTzY2VHlJWXNpQnNGeUFWNGxsTXN3QVc0?=
 =?utf-8?B?WWx5amJwcFA2TVI4a3FQeVQ5ZUxDaDAvbXpTK1JWcFVZOFB1a1hFZ0tObVh6?=
 =?utf-8?B?WlhMT0FnMkhtdHA0Y2tUS1llZG1lN1BjeTFwUWRrcUc0S20ySzdKeDhkOGln?=
 =?utf-8?B?UUs2MS9ub1JMRkQ4eVdWU1hLUVFRVkhualJkYVdFTjhyRGdJVStCVVBBQ01E?=
 =?utf-8?B?VnBoT0MxQkVRamhKM2VLTU90Y0h1SFBoMVVQcGVCWEg2bzJlUjAwNHZTVndQ?=
 =?utf-8?B?dnFrTHZFMmo2Z0srdlBkNTlHR0xUdkhmVUxVbDViRzg4b2ZGNTJhbVFMZXdZ?=
 =?utf-8?B?M3creGlETU1JdkEzbVIzSk5PdXdQMWFWcjBLWTN0M2krNFVYTVhyU2hBS3Vm?=
 =?utf-8?B?U3U5MXVXSmkxaUxvbHFUazd1ZkFxc0ZyeTlwY3ZSNDRRYTlZQ1R4UnJIS2Zk?=
 =?utf-8?B?WW10cTlJN3ZtUjByeGlIc3RtZW5zM0o2ZW5kcHREb3VLaU1IZ05ZOGZRU0p6?=
 =?utf-8?B?a00zczYxWnZnODVKVmxvcmt6c2VQUWtvRTRNOGNWam1zanBSQ0s3dW5Lck5X?=
 =?utf-8?B?aFozZXdSbmJyNC9sKzlscTBZcjk0UTVwMTlicG0zQ3JNSW56cnVnd3NoODJI?=
 =?utf-8?B?dmY3eXMydnpIU09JajlKU2ZjaG8xSlVvSGtBbHJVMU90SkRkb2dyYzMzZTJH?=
 =?utf-8?B?VElmR2NnZnJtYk9DcDA1QkdodFhiWG92VWZnUEhrNWxHUnFTUm10REplOFhR?=
 =?utf-8?B?RlRWN2FmUzdLYnFtemdXR2cxOC9aRGJadENsVUM0UG5JRitPZ1VWVXFUMDBV?=
 =?utf-8?B?Z0k0UTR4eUllWEZHRklreTA1b1lWakN6OEJCQXRyRGFRemNBQ3B1RGdsUnE1?=
 =?utf-8?B?QkhqN1FLT3IvUzhTTUZjTEVjYjA2c0tMQm5pL3c2MElUVEJFRzU1SnkraFUr?=
 =?utf-8?B?RzloMitDSzNXMUpIcng5aTg3TjFPa056SEVCVmZTdGZPaHhTWWc4WGVqZzJ4?=
 =?utf-8?B?RWt1eldCMUpkbDl2eVZzYlordExUVFVZVXQ4WGdXcHZBcU5LRUlHZ1JmUW8w?=
 =?utf-8?B?VTdsSytJQjNQQlNOVDlrYktBcUxvenEwd2dudGJ1NFZRM3UzWnkzeitnRDJu?=
 =?utf-8?B?ZkdvQ21sbXdybjJRTWlRR0xsbU9rVVIzZnNqOHIvTFJNcDdOSnFoQUdDUFRk?=
 =?utf-8?B?WFV1NXVXS1ppaHZreW43UW1ZWVgyMGw5V1VDUlJtWWtqbmlENCtSNnN6K3ZF?=
 =?utf-8?B?Wnd6Y2hZajlCOXVuS3M4VkRzTXY0QStRZE9rRWdtNDlpbU8rbHpBc1RMeEdH?=
 =?utf-8?B?NDFaNlozamdBakp3cU4rem1SK0h2WGlIYmx3cTF0b08rRk1ndGJpYTRLd1Ux?=
 =?utf-8?B?eVo2eUh6eUpsdnA0Yjg2K0N1czNEZ3BOMUJFUm1lRzVaa3F5SjM5b1I3ekNr?=
 =?utf-8?B?TWhTeEc3ZTNtcExUVGtBaTEwK3BJVWZOUnliZHVoY2l6ekNMUjhhTWhGL0lX?=
 =?utf-8?B?MEt3TjhJbEF1c3R1VGpaN1RqS0pRQ2Z2SnNIeG5JTms3NkhlOUVQVTNUdU9O?=
 =?utf-8?B?V09nZndLWEorc2V2aTBmZHdXQ2hEeGQ5a051elRiemtHb3EvODNRdnFQNjg5?=
 =?utf-8?B?bXA2U1p2VUhaY0E3RnFxcEM4MkF5SlgrTndRYW1ITmFJM2hiNEN4YU9HS2Fr?=
 =?utf-8?B?NnJ3U2NyS2ZYQ2R0c3kzWjRQVHY0SFRudHZGZ24zZDdnaW9Kdy9lSjJpV2Vq?=
 =?utf-8?B?V2lLTDA3czJxSDlUOERxTTZCa21qWHBTQkJWRVRXUmRJRHU5NXJLRFZjMzc3?=
 =?utf-8?B?bGt5QUt6TTNzTVRPTjVhaEhZcU9KTVRxbEtBMWNpeHhLRjUzbDdsNWhyV3Ax?=
 =?utf-8?B?bklBWFNrVGpHUDQwOU92NjNhc25CUjhmK0VPcEQzRzlRcmVCRS9oQW40djlz?=
 =?utf-8?Q?fQKEy+zi/h3kwmgkLKHYUMdpbSXpqWv751ssoycmKeB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccf861-e2b7-4ec7-9546-08db466838f4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 15:09:25.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij6kRG44ydAbiZFZgaGjOAzAp5gXhM0ZlDjZcEG+tKF3juFcW23Vc6Bcl6bslot8cKJkcWHc972JipeXjgPnCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sean,

On 4/26/23 8:32 AM, Reshetova, Elena wrote:
>  Hi Sean, 
> 
> Thank you for your review! Please see my comments inline. 
> 
>> On Mon, Mar 27, 2023, Carlos Bilbao wrote:
>>> +Kernel developers working on confidential computing for the cloud operate
>>> +under a set of assumptions regarding the Linux kernel threat model that
>>> +differ from the traditional view. In order to effectively engage with the
>>> +linux-coco mailing list and contribute to its initiatives, one must have a
>>> +thorough familiarity with these concepts. This document provides a concise,
>>> +architecture-agnostic introduction to help developers gain a foundational
>>
>> Heh, vendor agnostic maybe, but certainly not architecture agnostic.
> 
> I guess it depends where you draw a distinction between vendor and architecture. 
> What was meant here is that we try to write down the overall threat model
> and high-level design that existing technologies use today. 
> But I don’t mind change to vendor agnostic, if it seems more correct. 
> 
>>
>>> +understanding of the subject.
>>> +
>>> +Overview and terminology
>>> +========================
>>> +
>>> +Confidential Cloud Computing (CoCo) refers to a set of HW and SW
>>
>> As per Documentation/security/secrets/coco.rst and every discussion I've
>> observed,
>> CoCo is Confidential Computing.  "Cloud" is not part of the definition.  That's
>> true even if this discussion is restricted to CoCo VMs, e.g. see pKVM.
> 
> Yes, I personally not sure we have a single good term to describe this particular
> angle of confidential computing. Generally Confidential Computing can mean
> any CoCo technology, including things that do not relate to virtualization (like SGX).
> This document doesn’t attempt to cover all CoCo, but only a subset of them that
> relates to virtualization. Academia researches have been using term "Confidential Cloud
> Computing" (quick search on google scholar gives relevant papers), so this was
> a reason to adapt this term. If you have a better proposal, please tell.    
> 
>>
>>> +virtualization technologies that allow Cloud Service Providers (CSPs) to
>>
>> Again, CoCo isn't just for cloud use cases.
> 
> See above. 
> 
>>
>>> +provide stronger security guarantees to their clients (usually referred to
>>> +as tenants) by excluding all the CSP's infrastructure and SW out of the
>>> +tenant's Trusted Computing Base (TCB).
>>
>> This is inaccurate, the provider may still have software and/or hardware in the
>> TCB.
> 
> Well, this is the end goal where we want to be, the practical deployment can
> differ of course. We can rephrase that it "allows to exclude all the CSP's
> infrastructure and SW out of tenant's TCB." 
> 
>>
>> And for the cloud use case, I very, very strongly object to implying that the goal
>> of CoCo is to exclude the CSP from the TCB.  Getting out of the TCB is the goal for
>> _some_ CSPs, but it is not a fundamental tenant of CoCo.  This viewpoint is
>> heavily
>> tainted by Intel's and AMD's current offerings, which effectively disallow third
>> party code for reasons that have nothing to do with security.
>>
>> https://lore.kernel.org/all/Y+aP8rHr6H3LIf%2Fc@google.com
> 
> I am not fully sure what you imply with this. Minimal TCB is always a good goal
> from security point of view (less hw/sw equals less bugs). From a tenant point
> of view of course it is question of risk evaluation: do they think that CSP stack
> has a higher chance to have a bug that can be exploited or SW provided by
> HW vendors? You seem to imply that some tenants might consider CSP stack to
> be more robust? If so, why would they use CoCo? In this case they are better off
> with just normal legacy VMs, no? 
> 
> 
>>
>>> +While the concrete implementation details differ between technologies, all
>>> +of these mechanisms provide increased confidentiality and integrity of CoCo
>>> +guest memory and execution state (vCPU registers), more tightly controlled
>>> +guest interrupt injection,
>>
>> This is highly dependent on how "interrupt" is defined, and how "controlled" is
>> defined.
> 
> As you know there are some limitations on what type of interrupt vectors can be
> injected into a TD guest. Vectors 0-30 are not injectable. This is what is meant by 
> "more tightly controlled". 
>  
>>
>>> as well as some additional mechanisms to control guest-host page mapping.
>>
>> This is flat out wrong for SNP for any reasonable definition of "page mapping".
>> SNP has _zero_ "control" over page tables, which is most people think of when
>> they
>> see "page mapping".
> 
> Leaving for AMD guys to comment. 

In SNP, the guest controls the association of a guest physical address to a
host physical address, so that the host can't switch that through the nested
page tables [1]. We will be more specific to avoid interpretations.

> 
>>
>>> More details on the x86-specific solutions can be
>>> +found in
>>> +:doc:`Intel Trust Domain Extensions (TDX) </x86/tdx>` and
>>> +:doc:`AMD Memory Encryption </x86/amd-memory-encryption>`.
>>
>> So by the above definition, vanilla SEV and SEV-ES can't be considered CoCo.  SEV
>> doesn't provide anything besides increased confidentiality of guest memory, and
>> SEV-ES doesn't provide integrity or validation of physical page assignment.
>>
> 
> Same
>

Personally, I think it's reasonable to mention SEV/SEV-ES in the context of
confidential computing and acknowledge their relevance in this area.

But there is no mention to SEV or SEV-ES in this draft. And the document we
reference there covers AMD-SNP, which provides integrity.

  
>>> +The basic CoCo layout includes the host, guest, the interfaces that
>>> +communicate guest and host, a platform capable of supporting CoCo,
>>
>> CoCo VMs...
> 
> Will fix. 
> 
>>
>>> and an intermediary between the guest virtual machine (VM) and the
>>> underlying platform that acts as security manager::
>>
>> Having an intermediary is very much an implementation detail.
> 
> True, but it is kind of big component, so completely omitting it doesn’t sound 
> right to me either. 
> 
>>
>>> +Confidential Computing threat model and security objectives
>>> +===========================================================
>>> +
>>> +Confidential Cloud Computing adds a new type of attacker to the above list:
>>> +an untrusted and potentially malicious host.
>>
>> I object to splattering "malicious host" everywhere.  Many people are going to
>> read this and interpret "host" as "the CSP", and then make assumptions like
>> "CoCo assumes the CSP is malicious!".  AIUI, the vast majority of use cases aren't
>> concerned so much about "the CSP" being malicious, but rather they're
>> concerned
>> about new attack vectors that come with running code/VMs on a stack that is
>> managed by a third party, on hardware that doesn't reside in a secured facility,
>> etc.
> 
> I see your point. I propose to add paragraph in the beginning that explains that
> CSPs do not intend to be malicious (at least we hope they dont), but since they
> have a big codebase to manage, bugs in that codebase are normal and CoCo
> helps to protect tenants against this situations. Also change "malicious host" to
> "unintentionally misbehaving host" or smth like this.  
> 
>>
>>> +While the traditional hypervisor has unlimited access to guest data and
>>> +can leverage this access to attack the guest, the CoCo systems mitigate
>>> +such attacks by adding security features like guest data confidentiality
>>> +and integrity protection. This threat model assumes that those features
>>> +are available and intact.
>>
>> Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
>> considered CoCo.

Again, nobody mentioned SEV/SEV-ES here.

>>
>>> +The **Linux kernel CoCo security objectives** can be summarized as follows:
>>> +
>>> +1. Preserve the confidentiality and integrity of CoCo guest private memory.
>>
>> So, registers are fair game?
> 
> No, you are right, needs to be augmented here. What we meant here is that
> the end goal of the attacker is the tenant secrets and they can also be in registers. 
> 
>>
>>> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
>>> +
>>> +The above security objectives result in two primary **Linux kernel CoCo
>>> +assets**:
>>> +
>>> +1. Guest kernel execution context.
>>> +2. Guest kernel private memory.
>>
>> ...
>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7f86d02cb427..4a16727bf7f9 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5307,6 +5307,12 @@ S:	Orphan
>>>  W:	http://accessrunner.sourceforge.net/
>>>  F:	drivers/usb/atm/cxacru.c
>>>
>>> +CONFIDENTIAL COMPUTING THREAT MODEL
>>
>> This is not generic CoCo documentation, it's specific to CoCo VMs.  E.g. SGX is
>> most definitely considered a CoCo feature, and it has no dependencies
>> whatsoever
>> on virtualization.
> 
> Yes, so how we call it? CoCo VM is a term for a running entity. 
> That's why the academic term Confidential Cloud Computing was used in the
> beginning, but you didn’t like it either. 
> 
>>
>>> +M:	Elena Reshetova <elena.reshetova@intel.com>
>>> +M:	Carlos Bilbao <carlos.bilbao@amd.com>
>>
>> I would love to see an M: or R: entry for someone that is actually _using_ CoCo.
> 
> Would be more than welcomed!
> 
>>
>> IMO, this document is way too Intel/AMD centric.
> 
> Anyone is free to comment/participate on writing this and help us to adjust to
> even further to the rest of vendors, because for us it is hard to know details and
> applicability for other hw vendors. 
> Adding Rivos guys now explicitly to CC list. > 

I'm sure we can find a common ground for this document.

> 
> Best Regards,
> Elena.

Thanks,
Carlos

[1] https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf
