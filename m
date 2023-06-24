Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A173C5D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjFXBdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFXBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:32:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2074.outbound.protection.outlook.com [40.92.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A7213A;
        Fri, 23 Jun 2023 18:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Keiz1DeIdmfqLgq9VJX9wSB7CQd0GHi943+X2Y5rzbgL5Uojgl+YxmAI/fpvueWlNHbUEoGKRw1mwunKtnp/RRTF9x8zCOw5VRjzc+GmaUvptbXZWTF+YaLrgSyq+ZWPacqNNt42fb/8+yI6Ccw8xUpiHS+nI16K0bI5Xa75U6B4+mMyjeDx+HXy1XSI71JG+XcP8dH+ZJ+K07kQLASEVKHhTIeGpn4Sn6BxFrJqUzQLb9MecXKBbfB7aUsZZplWWIHyh3Wx+VbtGTTbPk9uLYR7nsDp1aChD4D8yX1TMhPZvrmST0UsirzZkrr3WrtzFHv035bSfCeGOCORNVV7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epj5RkMTe1qH451XeDGCIcNXYLWU2TjaWr8Ff7Q9Cn0=;
 b=etdMCMjsU+7AzHtils77jG2Zj4dwMq7/HA7WconPvaNomfST3L6iyODj3SJByRV7Fo69Q2vHSOKEFuQPGZOK52Nhws0Ux5x16OmiMRMMKN/7xegCLMuilEWxYK2G936pO1Sd7lp99QV5sSwn3Hl/BBk8VisMdvb8z7AwyUpOPraWXOv2KqKoWT9TRe79MeRZskh5uCKwgcoQufPgOG0TWxbFUOMGAJuAYFs2CXrNdjqOGCMg67XxLwXmL3B8xs+vS8JcPqUdnoNhXa83WO5G0plfmVuBnBp8CJmEB248TrlAmiUlij70+xbWvSzho07WiNN92I/CDHIHhVJhMxCs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epj5RkMTe1qH451XeDGCIcNXYLWU2TjaWr8Ff7Q9Cn0=;
 b=jz+5Wgc2UrE5uDXGiLFyYJ/MaCR31NEPUn5qn/FLivx76ibcFwTiqpQoQFvO7PNpfcA3AzadSRce9kYldL33xFxIfhJG7ukKxIn0htcZ28+iT/g+QoZ8y+tlnm/jfa8S+QbPVPn6iOOgjDmxUEu4zIUz0O2PORpzshmPuSO9/ioOBmrrLC+Xg9oHivOBPED7QId44VrcqP5/ly5yfyaU3Wd5Xc1QSQuVVXC6P+7M63nLlDK2YmCOvssxJx49M51Shx0WAK00cctdpaGDuz6R5e8SZVpjS0Smrp7rhMZFWWbvO2EFCBemsAAwqHpdhjM4zv95Wzp7YJ5GeZry7WbC+g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BL3PR20MB4921.namprd20.prod.outlook.com (2603:10b6:208:3b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sat, 24 Jun
 2023 01:32:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::1818:77d9:407b:dcd6]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::1818:77d9:407b:dcd6%3]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 01:32:53 +0000
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
Date:   Sat, 24 Jun 2023 09:32:47 +0800
Message-ID: <IA1PR20MB49536C0DA47122E9E3CB7CBBBB20A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAM9d7cjtisDVPijfU=iEGxc0YF=RnAt+r18Jg+8Av-+RAO=jeg@mail.gmail.com>
References: <CAM9d7cjtisDVPijfU=iEGxc0YF=RnAt+r18Jg+8Av-+RAO=jeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [7u+aWMwo2m9INaTxe+Eho1G0RkY10PFGTMFvocVS5TpesSz0DVl6sJq3H/9uzvKB]
X-ClientProxiedBy: TYCPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:1::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230624013248.637913-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BL3PR20MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: ad13cc2a-1e40-4faa-5ab9-08db7452edde
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nDUp8bIAwOWCqxT2NJSXd59YvOqHkdZDz7oZGh5TQfLlKLXKvcdMKEnuCmNZT935VLDxAli34rrEx6P2ku1YLyULx/hLbCkhjYnHlT6KWNYJRPuyFv9mJPg3dO0tJOHUaMyRC3FPOm6XoFJIns6Lv9opn/dMd7pqT+91iwRv6bAsKJoU1L8flBWtcforBXjdf2j10Gs6cheu7xr3U2h7pzj+wyirmOhEyGasS1g+6Up2jTKvnCeffcXBbQNcdNdt/iDdWRJ1rAdpyuGHEyFFv0IsbZGgJd8aa8m/04rrQlIdeKdOchIRJ3a4iqWEEIbQtYijUhO1qUAUWMSBZsdgoNrZKKBLrhsbpd/RPiDm0nHnkp0tXmhUGATQuQwSetvPQ19o+glHa1LNsnGX4ojcug5MUIhLTUvgj91peOVv1b5NGsl9lpZgos9F45WHOZCe9ZrAl/na+BvaRKkSsbqWZNclm+OKLoT4QBmnOZbKJ7UawO3rrOdqOxf9yDS9q3itjKjL9U3218Zs3pyzYDcOmrRXZO3DphTX1TZ94guWMoTVkuEimkhjHhjKAU/fZ/CyagKPI2NS+BLKnnygb67tH0PNGmGWvrJiEvwEzRE+AyoD46be4eOEIj9IvnxQF1R7rmUu39zUM51F8bCyyRds/bMBAnXeX40w1bU/XuvDVwx/u/1tg7Gc8pj1IJ5VJDRNurnzTqsMlMc1CLqU19QYUW52VcE3ROyqV2HA8qNE61q1pb4uiDOIjrRw3vDENybtHHtD1UaKcErqdVUi5NxY2L
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wycFMgHQNObQ/p46Ti2bShRarHjKxFJLxVaqVNGHtoRL2nuv4CXdSGQqJDPE0asLFxZHgZulBVnXAsRIHfAzU+ibt8wgXJPT+dHCj4OJFbV/ZX2Da9ulpUO3eIdJc8/tW+5nb/BdxQrE0QetPpaFfLw+kcv/VoGAWjNHKMTsq1krW5CdJ1BU6Rg9DXe5IMr3NVuLNibqnnvkfZqbn4uY/ZZWKTFZ/Z2xlu2R8dKuZpZex+E8T+UQAn1CkIqEjzEa+SWFIi5zK8+Qpk4GjVukO+jtqJkqG/kOAkjtKbjdnyNZRwh/qLVUmf3cfdEZayNfAnxfae0+JFIMYP8FZME9pWYYfOiJlRj3LjTJXhCVc1VLDyJwRK5ZqZYteowKa+3yligmGn2CpH3p85vm0DauPtrF4aaujc7PCPnM1kkkraC/TpaPhrG494FNlmjYz/2ey7vs7n2Qy8nB36c6WmPci2tj7WqNgulT2W5Nral6UwyCiMmRoLFJOKNqPSPGJrJ8ORW0Xgajkx6L4Ss4ga28eRLOABwsOdS3uG2+7J3l+vD4LXcFW3fuyhwXEsB0z2NuAXErR7Hz+y1LOmtPTQAOxvIx7x5rfrM6K545EPZauQtqJ4CQkTo06IQcQw0U887f
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldHbDZmbnN0cm51a1E1NTJpanovQzZMTjdLbDltN21XZUNkaHMwTG1xaXEv?=
 =?utf-8?B?NFRaTU1GSTFHZXk3SjI4WjUxY0d3S1YvTmJJN1VqM3I1dk9SUXpuejNGYysr?=
 =?utf-8?B?ZWM3ck8wQnhZcHBDejRLOFdtcmdiaUFiSTNva3IvVDFQR2tCQTdTNHN0SDlr?=
 =?utf-8?B?bmJQanhJS2o3aUhMcTZnY1FUcGxYUzFkUUhhbzl2S0krYXpkbnpEekZtdFRM?=
 =?utf-8?B?RVhYZFRuM3R0UG9aM0FYSlkzY1ZWZnNadGxJWCt4c3lZcUxOWG5xWHYydGlp?=
 =?utf-8?B?L3FIQ0hCTzVpb29PU2JLTjhFYmdSM0hpa3VqOTJuVEFHK2VWempiUnRTZXV6?=
 =?utf-8?B?YWpoald5a2NUY2ljVy9yU2ZPREc3UUlycjlQYmFqR3BBRkZlb0RWbmJtMVhv?=
 =?utf-8?B?Z3VUMGZ0ZWl5N1Yvd2tpYmFubTZWODVtYm1NY1lsVm5vcVhGMUtxNWQ5cTV6?=
 =?utf-8?B?a0l2WmZNZDVpNGlUeWtscjM5T1FWeG9CVjRLK0VBbEcvckxSSUpyNWZZOGh4?=
 =?utf-8?B?aG5ySVJ1aWZTN1BHY3V3OUNFd084ZGYvaElrQTJvWDVvY1pncWdJNzg1NVhK?=
 =?utf-8?B?NC9SOWw4Ni9RWStLdE5aVmo4cHFVaFBqcXJaVFVsK2F2MlZNc0VON3RwbitG?=
 =?utf-8?B?MWFBQUZUS2RYdmxBNHZMN0N4U0IyeTgwZ3IwbzJiMjg5RXBSVk1WR1hGSm5E?=
 =?utf-8?B?UUVDMkVzOUNKVXVndTBEbEs4N1hrQStiaU55Q1p0RE1HbHZhZnlFeUhsOGZH?=
 =?utf-8?B?YVZOYWJVV0dTNTY1QnBsZ2w2aG9ud3p4YzBQeVBQbWxUOVF3Mk5UV3htTGlk?=
 =?utf-8?B?N0ZveGFrc1NNVnFXVG5UVGxscFBranAvQVdlSk0vMFFMU1JQNUFhc3Q2VU5D?=
 =?utf-8?B?TjNpMjVlbTB3Q2tHYXlGdXBxekdnTW52SndYQUFmVkEzS1RTeEdLUFVESTdj?=
 =?utf-8?B?TC9xaldTTEY0WW5IclA5dEJFSVA4Y2hmZzc4cGdyTjhpZ3FWWmp1YnBkUWNV?=
 =?utf-8?B?L3JGclBGcUNKZjUxOGc0WUxFU3hTaDljOVpoWDF5QjVobm5aVUdKSjhGc2di?=
 =?utf-8?B?bThTRjJoQUpJMzQ4aVl3NGNEUjdSRzE2bUM5OEFqMlFJdHo3YjZMZlNIbk8y?=
 =?utf-8?B?cStZSFI3K2VkbWFwRFBKQTNENUtTbWpic2hTbTI3TlUvM1FvWXZsektxYWVu?=
 =?utf-8?B?VjRJWjRReHJIQlFEVEpCVFJSSVhiWkhBWmhUUDhXWmdwd1hndytTWG1uUnBD?=
 =?utf-8?B?RG1oUHEwQ05nMlRCd1BRTi9FbkVxTUtzZC9IYXVyZDRzSG9YZlBCSXEyMXlJ?=
 =?utf-8?B?UzY2TXZuaTAvemJKYUhuM0xlRXFkODl4SS9GREZwdThUUUorb3pQYkExZHJv?=
 =?utf-8?B?bmp1dVd1dmZiclo4VEd4SXhGcnl1YWpHKytMMDJIT05kLzdUdVBpWXE2R0c3?=
 =?utf-8?B?NlBFTytEOFFDYklPaHJTdEthaE5paGJpYTlKMnh3Q2lMdDk4QlJLR0RYYlRk?=
 =?utf-8?B?VWZRakR0eEtCY1RISHdraWRON2sxOEkzL2x6ZW9CcHREcWJucDFsckJhTUFJ?=
 =?utf-8?B?T2RJZFQzbXpKR1loZC9kWlZDRTFhZ2NTbUhaWjVNZi9nM0dwU21USGJyN0Za?=
 =?utf-8?B?YVJIUGJqOWt1MkRMbkVVOGlzdFNlZTNjQ2ZVYmEwOUJxemNTM1pqTWRUYzA4?=
 =?utf-8?B?cWxvSWtnS0IwTTJiTHdWUDF2SWcyL0JBSkRXcEhQMnl5dCtXa0NDWVdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad13cc2a-1e40-4faa-5ab9-08db7452edde
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 01:32:53.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB4921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Namhyung

Since there is a fault in T-HEAD documentation, I am not sure whether
the perf events are correct. As a result, I suggest temporarily suppressing
this patch until I extract the correct events from its vendor perf driver.
I will prepare a new V4 patch once it is finished.

As for c9xx wildcard, the T-HEAD provides a `MCPUID` vendor CSR to allow
its CKLINK to get the detail CPU info. The format of this CSR are:

------------------------------------------------
|31   28|27  26|25    22|21   18|17    8|7    0|
| index | WLRL | family | class | model | WLRL |
------------------------------------------------

And for C9xx series (only index 0000 is vaild for us, as `MCPUID` also
provides other index).

| 0000 | xx | 0100 | class | xxxxxxxxxx | xxxxxxxx |

The class codes are:

C910: 0011
c906: 0100

The CSR is a M-mode only CSR, so now I'm exploring a clean way to
integrate this CSR into the kernel. Any advice?

Thanks,
Inochi

> Hello,
>
> On Thu, May 18, 2023 at 2:50 AM Inochi Amaoto <inochiama@outlook.com> wrote:
> >
> >> licheerv # perf record
> >> [  432.015618] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> >> [perf:117]
> >> [  460.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 52s!
> >> [perf:117]
> >> [  488.015616] watchdog: BUG: soft lockup - CPU#0 stuck for 78s!
> >> [perf:117]
> >> [  516.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 104s!
> >> [perf:117]
> >>
> >> But that's not related to your patch anyway.
> >
> > Same issue on c920, but it did not always occur.
> > Like a sbi issue for T-HEAD cpus.
> >
> >> I am strongly against using "c9xx" wildcard, i would prefer declaring
> >> them separate (especially taking in mind that c920 is c910 with vector
> >> - AFAIK), but that's up to Arnaldo to decide.
> >
> > AFAIK, there is no reliable way to distinguish c906 and c910 cores. And
> > the events of c910 and c920 are the same (according to the draft document
> > of the c920).
> >
> > Anyway, I agree to let Arnaldo decide.
> >
> >> Tested-by: Nikita Shubin <n.shubin@yadro.com>
>
> I'm collecting patches on behalf of Arnaldo this time.
> It seems this patch was not picked up for a long time.
>
> I think we can make changes for the c9xx wildcard later
> if needed.  I'll process it in the current form.
>
> Thanks,
> Namhyung
>
