Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A66FB596
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjEHQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjEHQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:55:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F10849EB
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdT5t8xtIDJNZ7DAgq1SsNtOlcKotqZ5trvReJiZB7ZxPoDUWz25vd3QPlqBjH7dtKmmTEHn7MJuWzBnBx0IcYdJaFKm+b4xR+Rbn0sJrEesfeqa8AupA1Kj30nUjaBMBdEMC31n8Amu+PWYbnk2dcANqVq1xUFxh02P/QlHd6i1KECmby22YjEEfqlJHdYF/fgWTEKW77MMEqaQF3RLiad3seUhekdD+ujdKhbXB3rJoK4SQxwuhf40Nuj8ps0OdoCI+tq0TlbmNMxaBrYcrh2pItnXVsZZhycew1OSM55b/ueyZrPvm6cRTel1FT5vuDgF58i12ymIg7f2TRQ70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GECgX87DjxOoM4At5iyedjU267eAGaeTOkqPELhMxHs=;
 b=Bw4DzBmDlrIlmTexuABop2o+qjguKd4tYUIdJTDlfaz5S8UUmspV9nipb4em4AAVp0dIvdzBzi92/m8QbWBUAzd5S6CZFHCR4yWUr46udXCCx0qwwVrZ+Epg+q/GVZrcrKuDS2lFTC8pQtCZxnXabD9zE1rwDbREZ8hDSCxQ4+CKeRQILatv6NfcRb8d3ybIN+9FkPhNekFuAB7kqxQxTqnVQYsLnuL7r5OEzwp/9SzmCxTukhz0T+O4NuQAVKSaaCaSlUMtn2+oVycReFXvwtxrYp4xZBZJ7ptsfUPUtNYAOvTHLx8wcVDk1woAT1kMswrBOysx4oIQ/iUWlMb7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GECgX87DjxOoM4At5iyedjU267eAGaeTOkqPELhMxHs=;
 b=I/Jk5FsEN7W+JJ0DlCrHSzeKbVhzfncJo8AFGPLWfOsyY+eS+QsboTvoqPutG4Qo7dHCfbdvKAfeY+MIbPzJL5ZnIOWZAadxo8MoE8aQ9VQyJWWeYLtEy6Mb0FlxWvWrCIBS8Lz7V5koaJK+2b4w0AzFGXJdQ3nYVIABlz8YK5KNNHOBgYsomiVsg+yQSHauMAzRt8yXU+Y2Mx7PJt41WI0dC3mRPP7qgaGHUkiIZ/5Ae1SCtCn1jmmWibouSkljaVZFiJQliB1QFOgzW6DvFNwW7XLgZu3BwZN1z0HfmIPJlR41Pu9dqxHWFPR1qfel3vr5GGA4+zbXQ0CgbyppRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 16:55:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 16:55:49 +0000
Date:   Mon, 8 May 2023 13:55:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <ZFkpk8y8mUZuZjkV@nvidia.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder>
 <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder>
 <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a291cd4-2c62-49c6-1b18-08db4fe51369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbfhYYqawatpKAGdqdRCTo4tlnnLWBeUJRbBkkXK0Y5uMBrsZ+/DhS9f5KSI8YsihEzpTHPv77oqS94lJNVjY/bptLoTwhYb4c6Bo3pVoZ6DD5rwCGCgETjIa2vSgbrRv1UxUkX8wG1M5mz/fSf7ObO4bagtcKxyB1Ikn3ya2cn+5EEMp2Xi4vriJchTyWJP05hFuWoR2YRKZxPKfTRdJ3I8Io6ghFMUiBE2UuuQCRmfNIRAkIRBmN2ECj2p+DESuRpONP7DChMejedu91lzPTwkB+wvehVhjd3nRnXu8AcQdVhK40DHN+NgR9lASJhnqQp6WLvAEJ1h7kQF+hHyHhOxqhDsSbYCiD8q38V8/m3bsc0JC/tCAJ/3UHiUPzSD4EUnoScUJOJ8Qqt5+iVf7jQ2Sv6fRch7gBrHBwihtVrm17iOLxlBOlGP51HWRCNAoHLIGuGhrMxpLjbYBQr6eM0Mg0mm0btXfkrfbuJ/tf90c/PgDu0fhgKCWaZPFQrM0DKSi8e9/oGEsNJQOYSGOYziWTNZ7RBIA3XMA3vAaHDx7PYR3j/rPGl6oH9C4TXS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(66899021)(36756003)(38100700002)(4744005)(7416002)(2906002)(8676002)(8936002)(316002)(86362001)(5660300002)(6916009)(66946007)(66476007)(41300700001)(4326008)(66556008)(186003)(26005)(6506007)(53546011)(6512007)(6486002)(478600001)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFJcHREZ3dEc1UxYTZwci9JUUhHUVBMZG4xUmNpYllXTnl3SzBidS9yY3NL?=
 =?utf-8?B?YmVKenJUY0UrTjQ4ekNXemxFQU5sdDRzRkc0QmtQVkhSY0VlWm80VldXVXhG?=
 =?utf-8?B?SFc3OGs0MUZtTXplYStXb1RGcytpWjB0Nm9IaGpYdFJNSU5RK1V3d0NqWFU4?=
 =?utf-8?B?NXFwU0J0TUpaWEswQlRtcXhHK0xQY3ljcUJJcnFEOEVaOVVJZktXMmxuUity?=
 =?utf-8?B?ZHBtRnJGRFZxMTBscHZHUkI5OUVua3lxem9aZzdmYmJMQVBSanNibE5OSlZZ?=
 =?utf-8?B?VWxUcXpXL2pGdVZqQWV6Rk5KZk5JQnVwUlN0WVpiWG9FK3RWUy9xMDhkTm5m?=
 =?utf-8?B?L1luc2Z6N1Y3MEFpTEIyV1N3S25vWmY1Z1pUakcyclo5WE1ITTZCRGFCZ0hD?=
 =?utf-8?B?cjZoWHRFQXRvc3I0YWNCeDROYnRrbHEvc2IvVVlrWnZISUN2Zi9jckhxem1q?=
 =?utf-8?B?VFI1dURqU3RjUUVpbGtmOW01VVRCcEdXZDVpT0ZLNGZPcWo1bEVTMHZqZDZG?=
 =?utf-8?B?VWlSZUxhMHpqMUdpcW9Nby9Ba25NRHhKT3laanZRY1FOeVEvZ3JHSE5KVXBE?=
 =?utf-8?B?VldyRnd3VmxRQzFkSlQxQ1hPNHVjbjlyL1FpVDd2TU91cytQQWgrT3hTdTFU?=
 =?utf-8?B?SWVTNkZ5L2Y5WUdRRU1jSCt0SWhDRTBQS2pmaHJRTFcxQ3dSSDc4VlQzM05G?=
 =?utf-8?B?WFZtOVBTN0VRS3IzWGRNRy8xN21JNFpmWkNVSGsxWHBjblphWTRRYXR0Vmpn?=
 =?utf-8?B?K3Y2TDBOWHJtenBaOTVEL201Q3pER1BPZTZjSm5tRmRMejRrWjZrNllJTGYr?=
 =?utf-8?B?SUFIZHN5azlpQmhET01xcUtUM2NseW5WQ2NjR3NjUDk2WTE5clR0Y1NCUWFJ?=
 =?utf-8?B?NWFmczdER1VhTEpvbXZPWXRlT05VWVpkSGs5eTdBdU5udGhhWGJLZDBsVnNW?=
 =?utf-8?B?Tk5KZGIyUWJaWDBhMmk1ZHJsVGQ0Rm1TWnJVM29ZTUFwRXZYU29GNERFTG0w?=
 =?utf-8?B?cTZaM0pJeXRyd3B5bE5RSTBmVmpTMXp1UFp5QlpreURhQ044U2c2REtUUkNq?=
 =?utf-8?B?N0ZGVGlXdE5QQWlrR05qU0hVV0orZHNMT1dabmZnOCt2RFloZy82Rk9ST1pv?=
 =?utf-8?B?ZkNsU0ppNkw2bFZxWDR4ZTcwaDdDclU1bGsxejJrRURKRml6WTVDRHVnWmpv?=
 =?utf-8?B?d3k5TGs2OU1PU0NZanN5TTMrRWk1NVRjcFVFd2JsTkUza1dmUlVRMlVlM1hr?=
 =?utf-8?B?NDBNT0lVVEloaFJkUVluYjUwNVlDZE40ZVZRb3VtbXcvRnVBcy9pVUp0RVVz?=
 =?utf-8?B?TWhNR3BqVVAxNTVmSFhYekNsdk9FRmlsZ2xzb1grb2REcDlrdmxQbkdaOVpW?=
 =?utf-8?B?cnJPZldVd0FIWHdKQjBKMHdvYnNRa0h6em9wREhyanpzL1Jad0NpY0czRlFZ?=
 =?utf-8?B?eEJVZkM3akNJbVV6VTdrOEZ5NGw0OWk0bVhNUnlEMkN0T0pVakZZZE5DdXhL?=
 =?utf-8?B?cHV6b1drbFRjODExeVBvN0RFdXdrbEFiMnZTZERuUXBubHFHRlMyU2ptNUpu?=
 =?utf-8?B?NzVSYXhiVzMwY3B4Yk9ra3JRTkZ6S3JUeGJDSFY0b2NWcXEwemlXTTZKRnI2?=
 =?utf-8?B?UjlwY2djVURvdXh3MUFyUm5nbXlHNmkzNjRmVFNXTm8zRXhnclFuU3VQbWhv?=
 =?utf-8?B?Yk9xY2VvbFdCT2VpOGhKQmpiUjhPSHFQNEhZRHZpbCtMRVFwUkRndXdrMlRD?=
 =?utf-8?B?RTZ0SnFoYUxzM1pjeFdscHRmK2FrMVFLb1pBYUFIZUxGTDhsNjFxczQ0VEVO?=
 =?utf-8?B?TWYwdDRKZE5YOC93VnBMU1VBd3VqSzJMME4rU29LS1cyM2hmamdibWdHWkgr?=
 =?utf-8?B?cU03aHl5UkhrTWtXZlBOQmJRSW9MRkVJRlVXdFFuNng2QXlTeVpLcnJRNmdh?=
 =?utf-8?B?YXlvaldSaW9zVWUyRW1mQjZTSkZiS0wxL0NRU1ArWjdCV0JJOGFsc0YvTXVm?=
 =?utf-8?B?ZUF2TWFwNEtURWdSc1dZcnAvcjNIa1FqTjBYUHRNSHlnUEh2U2JrTndhcGZS?=
 =?utf-8?B?YW1qbEtCaGJtRXdqMzVqK01rQnE2Q01WalIvMURFWExqaUhBSTJ5TWlJTHZt?=
 =?utf-8?Q?Fujk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a291cd4-2c62-49c6-1b18-08db4fe51369
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 16:55:49.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekBiZBUV2NtraLca6MtXMc7eMGuEEvgVFnrgbTvqJHJXSk1Gu4Ke0MA9Sa1mchJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:42:18AM -0700, Linus Torvalds wrote:
> On Mon, May 8, 2023 at 9:35 AM Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >
> > Conversely, we could also have some part of PASID that is not about SVA.
> 
> If that's the case, then we should *definitely* have that IOMMU_PASID
> kind of config option.
> 
> Then IOMMU_SVA - that needs PASID - can "select" it, but any other use
> - that doesn't bother about SVA but might want PASID for its own
> nefarious purposes - can also select it.

Yes, this has been unwinding slowly, but this mm part is about SVA,
and specifically ENQCMD, and not about PASID, other than SVA and
ENCQCMD are both using PASID.

CONFIG_IOMMU_MM_PASID perhaps? Says what it does without a clue about
why it does it. x86 arch code could select it ideally?

Jason
