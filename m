Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9195068CB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBGA2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBGA2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:28:08 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D81F913
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfIpFNJsog8O09S/mxHHNt2hw13f+Ie03Be9ppoyHUd3eIybae9YyRnt2lsaeqw/hxWCvNkTF45LQaBz+xmpCaOD4rSghmOozQySr6hfLeYtgrd2vjkKd1yhE8e+SrAwa7dVu4F0bsn5q07RGOjrOLRahGTuQMtt6EcQ4rscqW+bFnlmHXGY5PTxdA7jfJnGhvdFK+k0EqJ9ncyMuySmhf7hwng9LOyfcWYqZWT9gMIFPyyKFyKwhlpR2X4deUqTHO9g0Ssa1z1N1EWpuquxCJx4jf+JMM1ImQJW3XlVXv5ZbZ+iGuHwag3Svu75dhHe73yMhqvZC+fkKYKKnt6LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUPVKCKm5UJ+rbpH4NBwnPRiw1zhOWwbAR/KfLzHeuE=;
 b=X7CGvMjmRzUDHyyUsMDih3XgZllfUBPc7pyyOnh7zv/Rp8aWWBja03W21ATIuSld9y2Bocum9qCFH4GSlMOcG4QiJ8Y4TAHp1pICXtWOvEDu6wacHmBY5EtkVHjF5RySdLYoMtsZgEoBVAJor7h8dM3SgdKLf6Rt3GBb6MQ/zdAzyFM2ardUg8MIrVOGIquc1gbXBEthcyj1rNPiZEYu1/3mp81n2l6llhJ9EYCgznYzrvwJS8aMsqOef4JXdI+nhSdSveu+JWlVuPy/GylI+HZcgSgxpk6RwFdGRU6nko2iH8ibANJmmyNXF/3zAO4Si06orofewbknXZjaekoilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUPVKCKm5UJ+rbpH4NBwnPRiw1zhOWwbAR/KfLzHeuE=;
 b=vq3LRUuZNPY0ysUhe6FWtKw5xBeEEdB+Y9eJ9TRuQ6q85s/lPGPDwJ7fg7fs2RZIUz/kAzYtWpUVHa2bA46VhPl4Y+4ipwnVyKEGvzsRnpV88f2eqgB4LwVqiKjNH+TA41jA0GYaPZqnQxB9KmcEbClGvN6NFql5TCx+0OYhS2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 00:28:03 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%5]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 00:28:03 +0000
Message-ID: <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
Date:   Mon, 6 Feb 2023 18:27:48 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Linux guest kernel threat model for Confidential Computing
Content-Language: en-US
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::7) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: b2611edf-d270-4ce3-73e8-08db08a22c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8fS1TgV4G7jwVapJOL26DUkRgbTsg5e/feKr8Vy/g3mK7AgGzMLnA94E+WnKG9ftBKYNvrJ+P0uh/Y508U6a1a9H+yjQegDaoIAqT//I+KGT6/T+yPKKpK58I7etBNcLIQAy3lj5kbiay1DJYGGgmQ3jHmPCgD8GBeAbaTgZ1NnV8XsgMNDmprBgUScbRIpo7mmIu1svaR2hop4Aw/4IL1CHmHLhWS3xxrwFYv4WndaFtiRCTviIAdXZVB7rW/7nXev5s8//DPCKkkng9RRJSYLrLo4EuBkFTGboCr5xZwCxS9C8Ny2Aa0wbLFu0B/UMoCPKmzGdQDrzNjU1JsTUHqbWfHpCo0VQqkR8eWIFg5KPH5yKT36BuM4KFsWPJdfdIyIb6RBysvzypwH9JIzbyQbcezFMPCUvt/xFrONye85/UjAPnCq8kpAHpY1nXHyuLBAMFEbfmhs9iuk+gW+6B8gMu0PM2jO+xnwwDVPKFYVEXRVJD/1jAOUFHhou/ThPuxqfCfxYzaMAm3XA5ppynPlchhmiYVhkPZzISFoOrKUBdD0PvEHi+YH8hGuBbDh1YnnfNJk65G5dNavxTRtZ4KuN1je9vDw6r66OYLPxbn+HA2EhYFFtsnwGxB2NyMwjIQ9F71sGnIpEgDz1qHSvIzAUy/Yn2JdacGq0N9uku+gebEObfaa5rA90uJo182EsqzQGdjGsxzvdXBbiBkgRO/wetE8IhWBEalKHvf6kTHMCUQxSKbd8gkAjNjaj1CFfb+5QxYolxBQ9x4iMLv3Z7GeIdyNjDYz0Xkw7ypZ+O0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199018)(36756003)(38100700002)(966005)(186003)(4326008)(66556008)(66946007)(8676002)(66476007)(316002)(110136005)(54906003)(6512007)(6666004)(53546011)(6486002)(6506007)(44832011)(5660300002)(86362001)(7416002)(83380400001)(2616005)(41300700001)(8936002)(478600001)(31696002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnF3dityNWJVNUJOaEFnZ2VkNDdPeG9VVGVEZG9VK1JVKzNEbThiK2ZYZXFW?=
 =?utf-8?B?ODNaM3RRekhVbGgwQjJMeWszUzZWdkNKNnpuQmpDZTF3WUNQS1Radm5WZFM4?=
 =?utf-8?B?R0N1NmdQdXRhejZkUnBvQVV4RTNvdWhhVGpjblV3TWJFVjBtWk9lNnlGVGZT?=
 =?utf-8?B?cG9neDR5ZVRuTldzUUpGb1B4V2VZWkVuMjQ3V2syNlZNOHc5ZnRSYlVxOHFl?=
 =?utf-8?B?ZFpDdHBTeXRoN05BeVVtdnIrUklWZW9wK29nVUVuZ2FKNUQ1YUZIckhCY25q?=
 =?utf-8?B?Wm91dS9wRWY1T3dNa0VkUUZIb0pIVFB4Z2RYOVlwZUNzS0dxNjNUMWJwbkxQ?=
 =?utf-8?B?aExZQmFNMGhhSjZsTVhXUjdrT3hpZkVZT09LNDRkVXUxVVhKWGtFeTVQR2dv?=
 =?utf-8?B?U2k1Zy9DZ1lrdUd4RW0xaVpzZllwN3g4VVppR1BLcUVmYkM5WC9vR09saHl4?=
 =?utf-8?B?WHkxbjg3QnhtTlpQSFJzRlBxNTRsa1M5a2pDZGlzSHRub1p1bWtlNktoWVhp?=
 =?utf-8?B?bXZoMkZGYkxOaHhOSk1lejdIQ2dyTnJ5TGpsTnY4TnpOTmFIbWVHV2d5WlJZ?=
 =?utf-8?B?K1dRWEs2RnJseHlxOHYrZVhaU0t5Zi9jNllhdTBvRWtSSGN2Vm9VUDJqR1F5?=
 =?utf-8?B?cW1tTzJScXUrKzB2ZFQ5c0twdmV6aytHVVduLzk2VGpxRHdGT1FheDk0MmNB?=
 =?utf-8?B?WitnVWIvTlhndnJKZWVCQzFSNXc5Um5EYmRNU0hjcUg3elp2cmVreFVVemdE?=
 =?utf-8?B?TGo4SmtVV1JRQzV3U1RjdFRyRllSZ25kcDFlT1RUaWs2YVVISExWZ1ZyVExs?=
 =?utf-8?B?bExEN09oTEthbUZTS2Y4Sy96NStjaGpCUWJEb2ZCSS9VZVU4T2VmcDlPRlBD?=
 =?utf-8?B?b2I4SXJ1L0FRTDVhWjNGaEJCZUc1R0syWFM2bC9BMkxRMTdsaXNlNDRyMnQz?=
 =?utf-8?B?dkFZQzR2dDREN3RhNGJvTHczaFM1TFFQVVl2dFdaakRyczNuRkZ1V0lLeFht?=
 =?utf-8?B?TERUNVF6eTRON29TQW8vQTZJS0l3OWtlbUNMdnlKTXpvaUVyTTNNVnFMZHpp?=
 =?utf-8?B?R1U1U0h1ZmtWQ2NqeHhNNVZkYjBhODByRnRsRmtCcDVVaU5aWFVjN1pmTnpV?=
 =?utf-8?B?U085bkZMNFBRVWFOanpxdXVoRjRFOWg4SFo3djRQNmtweWorKzlmWEdzVlgw?=
 =?utf-8?B?Ti9sS0U2S0lkZWhyd0oyNnRvZGNjcVBUZVlQM2hHUnJqY3k5a0lYWGt6dGhy?=
 =?utf-8?B?WXE4VnlWWnhZQm9aWG00Mnh6Q1hYajRqTlV3bVQ5N1lSMXo5N2Y1Y1hGRDJQ?=
 =?utf-8?B?QU5wUEhuOU9UMHJpbFI0WHdod1lnMEp6Z2MvN0VWNm45WXBMOWFXQWlLWTNr?=
 =?utf-8?B?ZHRWK0VmQUxyemhicGlocXVkanZCS2tFc1FGK0kzUnBjYUMrMFpqL05zVGRK?=
 =?utf-8?B?MVFXc3ZKUUNWUXFMZzNWVGZPNmdFRzBqWFgxSXBCZUhmdUQwaEhrdjdpUjVo?=
 =?utf-8?B?NzZMQ2F5QlZ2eGYrRk9DamNSNW43MW9IKzkwWTJVd0tvK0xvMXR5UG5hc3Uw?=
 =?utf-8?B?VnVRcGovVmpTWU0vVmxxTGtSbzJLZkF6azJkVlpCaWZKb3hHOXM3RmEzcW5S?=
 =?utf-8?B?OVdqbmU4L2Q0TjdkOWcyWVk4bDdQQk1YOXNidnJIbVpUaWlyNzVhVnBnVGtR?=
 =?utf-8?B?N2UwcjZIN3p5L2dLY2hJS29qQU5vcXVmWmx3NlV2M0pTMy9DMGRnVzkrYWxi?=
 =?utf-8?B?UjZPYVVGcG5CeTQzSEFTSEtva1hVVjZQSDYwM2d6eTk3ZnNBSnFWaEs5WDVS?=
 =?utf-8?B?enVoa0ZVWkNRTjcyQy9DZ3hnQmhPRW5IbW1TaHNld1NLNnNQempxZkpoNGpJ?=
 =?utf-8?B?SzM4a0ZOOS9ONk4ydkd1UHZpUm4wN3NGaW5lTFlSVXQ1SEV1TnNXMHZ1NjQ0?=
 =?utf-8?B?Q2FRaTFOdXVuU2tWVCtjNzVMcHpQZ05vWFJ6aURjWU1lSlFzN2xvLytkdXdQ?=
 =?utf-8?B?dDFwcCtkU2pmQTVxaVdIdGc0M24zNExNYUt4OU5IZGQxdzU0emF3VG13eTRm?=
 =?utf-8?B?N1M3V3QwZEFYbExnYmgvRFNnM1RIVnlEdnhiVTRCMTR4S3NrRW1zWUE0Vk5F?=
 =?utf-8?B?ZWs4M2gxa0FPUCtOVE9yTmFCS2pWNkdrcVBDblhWSjNoMCtTa1F3aXV5dDdE?=
 =?utf-8?Q?L/xAaXvi5zqI8z4n6jI0dFgMBOws83GzHcJp1Qar2lUI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2611edf-d270-4ce3-73e8-08db08a22c6a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 00:28:02.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VcrjTUOIl9bIl4lfFHff6Lf6F5YGqPbgmydWdAfmCCALbaLXPKquqk7colRDy/0fR9Zwll31j7vZm8Ys+urRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 6:28 AM, Reshetova, Elena wrote:
> Hi Greg, 
> 
> You mentioned couple of times (last time in this recent thread:
> https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> discussing the updated threat model for kernel, so this email is a start in this direction. 
> 
> (Note: I tried to include relevant people from different companies, as well as linux-coco
> mailing list, but I hope everyone can help by including additional people as needed).
> 
> As we have shared before in various lkml threads/conference presentations
> ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> This is a big change in the threat model and requires both careful assessment of the 
> new (hypervisor <-> guest kernel) attack surface, as well as careful design of mitigations
> and security validation techniques. This is the activity that we have started back at Intel
> and the current status can be found in
> 
> 1) Threat model and potential mitigations: 
> https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html> 
> 2) One of the described in the above doc mitigations is "hardening of the enabled
> code". What we mean by this, as well as techniques that are being used are
> described in this document: > https://intel.github.io/ccc-linux-guest-hardening-docs/tdx-guest-hardening.html

Regarding driver hardening, does anyone have a better filtering idea?

The current solution assumes the kernel command line is trusted and cannot
avoid the __init() functions that waste memory. I don't know if the
__exit() routines of the filtered devices are called, but it doesn't sound
much better to allocate memory and free it right after.

> 
> 3) All the tools are open-source and everyone can start using them right away even
> without any special HW (readme has description of what is needed).
> Tools and documentation is here:
> https://github.com/intel/ccc-linux-guest-hardening
> 
> 4) all not yet upstreamed linux patches (that we are slowly submitting) can be found 
> here: https://github.com/intel/tdx/commits/guest-next
> 
> So, my main question before we start to argue about the threat model, mitigations, etc,
> is what is the good way to get this reviewed to make sure everyone is aligned?
> There are a lot of angles and details, so what is the most efficient method? 
> Should I split the threat model from https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html
> into logical pieces and start submitting it to mailing list for discussion one by one? 
> Any other methods? 
> 
> The original plan we had in mind is to start discussing the relevant pieces when submitting the code,
> i.e. when submitting the device filter patches, we will include problem statement, threat model link, 
> data, alternatives considered, etc. 
> 
> Best Regards,
> Elena.
> 
> [1] https://lore.kernel.org/all/20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> [2] https://lpc.events/event/16/contributions/1328/
> [3] https://events.linuxfoundation.org/archive/2022/linux-security-summit-north-america/program/schedule/

Thanks,
Carlos
