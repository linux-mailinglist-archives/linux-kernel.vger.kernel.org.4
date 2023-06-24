Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293B73C729
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFXGm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFXGmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:42:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2048.outbound.protection.outlook.com [40.92.41.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E8A26B5;
        Fri, 23 Jun 2023 23:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuZ+xUkmLHAKVCuIP/GprTzdK3+3YUDK9JkWb++KfJdAtk+BkGj2Qqbc952aiqC9WXiHoWeGd8j9K0K3ajw9rxLxFDPyU6oVEk17A+6p51Dr5QR+ky0srJ+lulmd3aysokEX5lEo1AoXjr0E4tJwhYXWUlTqtGrRyq/G9vt+8SyVeQ+JJwlpAxBuiv/ASnmaFnJPOr1wbN87TSYF0vXQtUoVnJFyZ4RrdLkNpllb/jTbjhUywIJ/k9ZxHOzYasp8uj643f/FRXKQ4F0pEpI5u48hDUlew73D3M1QVLwsapVhJ4Zwxfuhu34XmIL9B/S+BdYCCLuG5kDKonFJfnQjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwkIOUe4U+b8RAuw4CPLEUxN0fAQxg0fkSh822G2rJM=;
 b=P8bSiIDF7PrQAFM+kBgHa6iDE2TX+Tb56jGxZWpv9iM1rYoo5cp2zC4JV9ZUK3Sk3xW06FVEacYhBiNVRkYurHzqopzRkzbVMqZP1lYlZveaRoFv/kzIFvMk520RMtgHYWM8B+KaIJ71VzGi3vkDKJ36q8DPxFAAkkkf3DF97gHcy7u+aBykUhaEzGMEo9t/qf7k0LHnEhieN8fuEHQ56ID1iVNXVEwyLAZ4QtzzcqUbRkrX5X8EnzI05ai4+OhJZASiLrkzca6SzsyXZxQ2w5QLSS+wLTrPOWSUSM3bfspAAmezFEm7Aza0mO16jck6LSEOpthCMibeha8ylFbbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwkIOUe4U+b8RAuw4CPLEUxN0fAQxg0fkSh822G2rJM=;
 b=NF9/gUlo2oJ0hJLKDd8IPvtfKNVZvXsvK2ME3Wrez7rjA8OLsfoiYXHF/lZ2+gkq/bhYrXHiFuDJ3cDTT6qSS5BOn/5XqMbGrmdXmOMz3IJnfSC6Vhb4UaFifxMpi3n6rXl6kRf9hgDIWwURlNgOWQEy1rP9E3SQQ0xkdQKh9mmJn6OMaFp38rVmSIPSmu/SpEQtzvSareFquDMpqv+fvgP0GZQIRua1VXOh43UKXDSTxwSp5nFB36XKhE9DfjYG3wV2cyMNvATJXiY6kyGRDmMNOyW3Fb/lbGqLLUMA0JHHsNDqbVIaX4xf9ZYeQFTDt6x1yOKh1XXYrf0RXZYmsA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5687.namprd20.prod.outlook.com (2603:10b6:8:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 06:42:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::1818:77d9:407b:dcd6]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::1818:77d9:407b:dcd6%3]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 06:42:51 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Sat, 24 Jun 2023 14:42:27 +0800
Message-ID: <IA1PR20MB4953E87F213C869DAF43E69BBB20A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAM9d7cis-rb0fozK+T6R8MCEcT0ZF=RRNpv1qAWsLkMfsG6KxA@mail.gmail.com>
References: <CAM9d7cis-rb0fozK+T6R8MCEcT0ZF=RRNpv1qAWsLkMfsG6KxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [85rBhpa4gDFPZ7usTjzM6ejtu9IXg4W7JleeOSuQ1ecHEkHB58PCdOD9O2mRKdaW]
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230624064228.774138-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 31eeb946-dad7-4789-35bb-08db747e3b4d
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nDUp8bIAwOWCqxT2NJSXd52YSPdpO4fY+QMor2YIhn4aaG6uniUAOhcCLYODqEjLSMWzqJ3DbtQt+M0CI+UcScpfDxmGmKo7pqCW+3aV6cPERn8MUyDvIu4IV0CuAzT2QjrL6IPGaFwDGcF4scCJAbx6G8k/s4fLZSjiBbytE8WMiG1jmEKwwbMx90VPIh2iV2bSsISzzv9GFacu6Aj1ODn9UMDlctIYmVn0nMLeP8xjmGwB0AJMvoz6Dx5otTCW6lXAuMeIrogqJLn4q0vcp4Ln8h33oV0wTCNu677qFPdXbeLXhZolwXCleILSKKjiynDcUMzjrZYsWvEwII++SmDMJveK5ZmwhvhmOEyBixEliHndlvIHgtrNGuw7yhaJvoS8hjYWvDFIEXRm6fKSxjuz9LKPuUZx5EpRln7i1Rcqt6wemESGF5pJ0cvXzUuwzdn6cAr4k4mswW/pmroT1h7v2GL4x6SUDYDAyD9kJ7npYAszWOWRzv6O0BOmjgxNC8hyAiebUhlj/WyWgAMk4lHxxh1KLLvrG7G05vLuNL5pqWgzUBAsV55JwqhZqK+eVd8vfN1l/OfaBebqzEfjR9FpXSRWpooH+NUOMIK/55Mn1E2QHrjll5g42VJTlx+WBy2g2rnpXCUBW00lFe9FJ6rt4VfF6dUiOB1e1dnrA8Ig4HoEkhobsc2VWzXYxm8jnJR5CX2YTmTlAxvADtc/w5AorzrmTPxYAAffiGX8ZcNGN44vqCN3izXCjWxDzPfCZuCAHH+6yyJvur0BNdSEl1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GN7e2dHfi7MkOZ0immjqr3Y83Wv/+kA0dMUWx3ngayJ5/NaYg85B5FTuPQUoSr1YFfQDITpeCHZh6KHSXPaWT8nC+oug2utwhRjQyLBJscSmpOr/t5PD1FlclILesCMc7KBq8yOZt9wv6zHeXkHX2OIffJZ45TYer7YwbZk7t5jZLgd0l43dFw7bdzsJR+U0Jk0DbTUUyF1Q5t3QXG1u+iNSYIRJaCHjT8f3CvdATfkogkqmN7wMzPTNKoMvIwjeBLHR3UYPpJlmBstt0JklSZ19m8SPT4eHJuovYPEDncVrrBfoOXqacIDhdjmhkYLBlC2/YffzknV79hIP2J4xu23JhrGZjvFXnOl+g+3lOAHLu8tmPIMlfEafYagjSmnH5BTcdIizdSxA1RYC8ghT5c+GEeTnZ7rY0lorl4PGC27zwadZtiB+D6fmMr9QHCHsXICbsR1ncazYxTK8lOYwz+5L5PArAEEWXNQAVhke/SJN8yywFdgsLJXdJy5pWTLGXIQaBdacZCY7xCR+XXcicoRPs4knHFE7rZjVDivZkaueSX5CUP3ApMdkf7Zp1pLNsKyB50maQ47i2kRaQjV1adfygws3LAj9JRMrcOXE+PFjxJxY847RT5XwYjssAr+A
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklNMFBzUUlYK3JnQXNzRzV1Zml1cFpxYmhMTFdHMXlTMVZIWWl3RnZqR2VO?=
 =?utf-8?B?cHR5YmFnRzNxZHpxSVlHR05sVE9OSjdBUVozZ0FlV1RJQVNyUTBCbUNjOFV2?=
 =?utf-8?B?bFlSM2ZvdzJnU0VML202V1pQRndkY1pOUTc2TnJXT01NTk9PNUE4KzE1bTRH?=
 =?utf-8?B?aE90QVB4aTZ3b0NmL05RODFqRVA5dXFoVC9sWFVpaFZkRzlINjlDMzBMaWxZ?=
 =?utf-8?B?VnlPdUFMVmRXSG1CZFl0S0NKa0V4L3M5a1prclNiM3lzckw2RElxUyt1WlFx?=
 =?utf-8?B?Z1ZKVEVNV0FjZWRYU2FWNVZUMG56aEhhMlRsYW80NG9MUDdLLzlKNjBkQUZ3?=
 =?utf-8?B?L3Npa29vUi9WZlpsaUdOeDZya2lOVlZaYk0vcFdqYTNMVDR6NXhIdVdLOUFH?=
 =?utf-8?B?NjB5UDRiYWx4NFBqN2NjWDN5UGZiU3NBMElLOXEyM1FDL1RlbWZuamY3ZGQ3?=
 =?utf-8?B?VWtXWlg1RHl2cGpvZFBDRWw2enNVTnJlNkdVWTdrOFNTM0hjZURZTUYvMXBK?=
 =?utf-8?B?TllCODNwdm1OTkxoVDJ4dkZjd0pzcWlwSTg0WGtjVml2di9Nd01yRVpyTDRT?=
 =?utf-8?B?anAzY1duNkhsQ1poVStrWkFRaFBrK0VrZnl3WVdwaE95UThtS0FQN0laRDNG?=
 =?utf-8?B?ZFZMRGdxR3QxN01raHVVbFVPbE43Qy8yWkozdGx6YXRaSVdId0lMcEU3QmJp?=
 =?utf-8?B?Yk8zQ0VXcklzU01naXVLMk9JRTBmOUVnN00vcWNJNlZMY0psYkdGNGNISm03?=
 =?utf-8?B?bzZOVHhTWjg2REdubkZjZWVtdFNMV2VrN2dTanAydGIxU2U4NnczTHZxZU1k?=
 =?utf-8?B?V1h5OXRaWGR1Uk9zemp1TDcrQlh3cnNCeWVVMGw0b1RLOVpubXFhNnZGRWYw?=
 =?utf-8?B?cjd4YitJZjlGbXlJMHBpRkVnVG9ZQmRMcUlkRG10NnlqRUdNWW5YODg0Z2J0?=
 =?utf-8?B?SXFNcGsvTUl0d2NZZU9wcnBDVWE3MGFjdVJLQVEyL1R0aFpTamhtN0hrQ0Nm?=
 =?utf-8?B?TVY2SFQ1WEdEQVVRd0dMRlgvYUZSVXRJS1BJNTF4TUhTeWhuNVR4WFMrcThL?=
 =?utf-8?B?RlhhczJ2TURHNFVRNWN0dnBvY0tvaWROVnpzNndVK1BieHpPYkFWdVdXQy9K?=
 =?utf-8?B?QU9OVnFrb3pRTnROaUFKNzkwOWhWMy9YbEZybWc0MnRTaXNpWnVoVXJsZ1Yw?=
 =?utf-8?B?b1hObzJ0aFhpTjk3VkJDcHRCR0pFL1NGdjJrL2RaQ1dJUXNoeU1mNm0wS3BO?=
 =?utf-8?B?NjJVaWd4MlMrZ2cxTXBDaHUzN0lGVGE3dFRDYWdxVnBiN3V0bjBLMmFkRkty?=
 =?utf-8?B?d3ZZWUxCWlUvdFRwU3pNdmd4WXlGQk90dkcrdlpWWW9aVzdyT3VTSzJnUUdP?=
 =?utf-8?B?ajZmaHRsMTdFN1c2aEdIdVlUQWZZajFMT3NCaUpqV3ViamlQYkxKUnF2UGpJ?=
 =?utf-8?B?eDVFSEc4SEdBKzhZdkVzUHVpUG5YeDdKbW1HR0VEMU94clV2aVl1aVZKTzAv?=
 =?utf-8?B?bFk1QVdFcGpGSHVnbitTWkhjK1BXUUZlaG5GYUU3T3MxaE5MeEU2NDFXVmI1?=
 =?utf-8?B?aS9GTFZxY1pYKzlQVDM1ZldpODJoTE9FSmdidmcyRnhBZG5ONkdxMUFsTnNv?=
 =?utf-8?B?MmFvNCt1aWRZd1grUjU2ZVVPNWl4VzljQ0E3TVFSNFVMRVl0Q3hRcTExdEFp?=
 =?utf-8?B?M2ZMd0VZbi9XTkwxemExOVFlUlJLUVlaWFA3QWNlSzlqYmhXQktub0pBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eeb946-dad7-4789-35bb-08db747e3b4d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 06:42:51.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> On Fri, Jun 23, 2023 at 6:33 PM Inochi Amaoto <inochiama@outlook.com> wrote:
> >
> > Hi, Namhyung
> >
> > Since there is a fault in T-HEAD documentation, I am not sure whether
> > the perf events are correct. As a result, I suggest temporarily suppressing
> > this patch until I extract the correct events from its vendor perf driver.
> > I will prepare a new V4 patch once it is finished.
>
> Sure, thanks for letting me know.
>
> >
> > As for c9xx wildcard, the T-HEAD provides a `MCPUID` vendor CSR to allow
> > its CKLINK to get the detail CPU info. The format of this CSR are:
> >
> > ------------------------------------------------
> > |31   28|27  26|25    22|21   18|17    8|7    0|
> > | index | WLRL | family | class | model | WLRL |
> > ------------------------------------------------
> >
> > And for C9xx series (only index 0000 is vaild for us, as `MCPUID` also
> > provides other index).
> >
> > | 0000 | xx | 0100 | class | xxxxxxxxxx | xxxxxxxx |
> >
> > The class codes are:
> >
> > C910: 0011
> > c906: 0100
> >
> > The CSR is a M-mode only CSR, so now I'm exploring a clean way to
> > integrate this CSR into the kernel. Any advice?
>
> I don't know about the details.  Is this CSR available from user space?
> If not, you could add it somewhere in the sysfs.
>
> Thanks,
> Namhyung
>
>

This CSR is not directly available from user space, I will try sysfs. Thanks.

> >> Hello,
> >>
> >> On Thu, May 18, 2023 at 2:50 AM Inochi Amaoto <inochiama@outlook.com> wrote:
> >>>
> >>>> licheerv # perf record
> >>>> [  432.015618] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> >>>> [perf:117]
> >>>> [  460.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 52s!
> >>>> [perf:117]
> >>>> [  488.015616] watchdog: BUG: soft lockup - CPU#0 stuck for 78s!
> >>>> [perf:117]
> >>>> [  516.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 104s!
> >>>> [perf:117]
> >>>>
> >>>> But that's not related to your patch anyway.
> >>>
> >>> Same issue on c920, but it did not always occur.
> >>> Like a sbi issue for T-HEAD cpus.
> >>>
> >>>> I am strongly against using "c9xx" wildcard, i would prefer declaring
> >>>> them separate (especially taking in mind that c920 is c910 with vector
> >>>> - AFAIK), but that's up to Arnaldo to decide.
> >>>
> >>> AFAIK, there is no reliable way to distinguish c906 and c910 cores. And
> >>> the events of c910 and c920 are the same (according to the draft document
> >>> of the c920).
> >>>
> >>> Anyway, I agree to let Arnaldo decide.
> >>>
> >>>> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> >>
> >> I'm collecting patches on behalf of Arnaldo this time.
> >> It seems this patch was not picked up for a long time.
> >>
> >> I think we can make changes for the c9xx wildcard later
> >> if needed.  I'll process it in the current form.
> >>
> >> Thanks,
> >> Namhyung
> >>
>
