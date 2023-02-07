Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1C68E350
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBGWP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBGWPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:15:52 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5620793F6;
        Tue,  7 Feb 2023 14:15:46 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 317LhBVJ027078;
        Tue, 7 Feb 2023 14:15:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=ko6hKNI8ukYLprSb3pJzb0jDIxLS9ogI1SyMjFj+2eA=;
 b=U1jBRxvu78xQRM/gARZf5tdplCI1lryZMg997N6+QcCP4gWS5linjEZgR05XftUrjqGd
 Me5UiT575CIkM8ufdbKzz9KLuhfMvqerWUxEcTIGcqs93DeR7Zcg/1eDxSRoKREhtcnK
 5auvgAUCLz/jv9GnO8hbWQOcnIusgrEn0O2rzrEO6tr2gZb5fKdqQjjOeBydx0rZsd3c
 z0ODsu6FimDS6CfSnDpBQ+FUYh0kjIfblHJnNea+iduO5bi4wQ3fP2kPitxkypvQInvW
 6iIHkxuXdlgggFf8DPMkohIC7dryFkWTxs1Y2oYzTskSnYW+lrYoAkkU02DIuqUti5vQ Aw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nk2whckd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:15:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIqIzjpzynIL+80l6WsXkVdWzr06r5GJtFqhV4f/9FLYI6aLvJCWcKhS5gCU4bw2QSw2FTI4YPiU7xkj5Dykxnui4AYfEzNL4oSMdNhAwFM3Mm6B7tCIBm9M7N7c5lfuMuQL1IMA3X1oPuKweDEcZHdzdNdwPWvR/BVRLKvMZJl/5j+KdwqC8ca+bR+XaAY50ZaggiKSJLCrqan0Itojs+ta4lp/ikFEqiLA+phRCFf289zvPKQJFBke9BUhz20gl77mEccxp7t+bUEfybjq7wNIgl/CXWQmpKSnhg8sJgzVuId5HfimSo4x5d+Kgzg61rb5BNOFCEdyC+tGujDkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko6hKNI8ukYLprSb3pJzb0jDIxLS9ogI1SyMjFj+2eA=;
 b=UWMHIoMnAbu5YMbbqf4qx9To6WBo117yj7+OCo4ZOA1UGyB/INZIMTbF45OPo4btFJvzpDHsz8uaizhs7IEeTvXiEUKkxn+h/umkwTDWOcD2FfEVKu/gUGeidvkEbZfSKS2awyoK+lbryAcrytYBm17IMfDhHA2TPlYIuO8VjleSlZB3pKfqMrg4301L7+kGxf9cwwLF7qqw4rFDFDhYnVTSgX2veGiLAJziqSVryi+H7gJJpTRyLMeoPG5ow5Uis4FDZC36MaXTKPqVb21etX0qNuTz44PCh4ydPcatgEy0u09n0mSJK8aOiA4lu/gMNsWMLvTbVE2vXTdTQFC7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4521.namprd15.prod.outlook.com (2603:10b6:303:106::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 22:15:42 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%5]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 22:15:41 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v9] module: replace module_layout with module_memory
Thread-Topic: [PATCH v9] module: replace module_layout with module_memory
Thread-Index: AQHZOBjM9Um86gAGJEyMnpzD+3mYlq7CeI0AgAAcZICAALSGAIAAybcA
Date:   Tue, 7 Feb 2023 22:15:41 +0000
Message-ID: <7E141837-4629-445E-BB58-EC49475E36A9@fb.com>
References: <20230203214500.745276-1-song@kernel.org> <87cz6mxyb7.ffs@tglx>
 <09C6F0A2-5AE5-4D8D-87DE-BFEC2C642A49@fb.com> <87edr1wzoz.ffs@tglx>
In-Reply-To: <87edr1wzoz.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4521:EE_
x-ms-office365-filtering-correlation-id: a412e031-55b1-4f75-fc4c-08db0958d99e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kRN6H36w+agq8M2ll9419ZHLqV8PoAJhEr7YAHzDwY1niVeF0MO2CsPmMCOCPjwfQzOiSUyOt7/1uLCY5Iwj7hxVGhsGnbePzL2KO589siXmxZyFa2buE3DPf/HErk38XIekjDqgthSN02PFJ+xq3rjtYpVfB3YJ3xBJ6xIfznHZ+ub6XAhNaokgBizHZNJW0Hvx/U7WkZayk7NFjDQZHEPBBQak85RcIonHveO6MSRWIWt3OeXNhGuOb3OKw8h3FAVx82o+4oHW7XI/4Zq+Fc6c4OckBeGAG8cTo7fYvmr+J8vTDNxjX6lvDAIXu92fk5xbtXAfoAJvH81tsDtdi2/Qi95C735iYhDPz/x33micHsGFyzKfp7uy+K8XPTwrHIFQzYBggTtCJNmnZxjHJnNYZlDwvk2JAlR4EnWi/3D3QET/XnXiUMiFlNrxgw6GXm7PU8aWa99ib1/HWm9RSBElX3BbWlB5msrPigYQctmrj5aPmv6WgVHdlLoh0Z6xEpbdT/OdRn9wiETQKSVqFm/z1D9hKQ1E84EGMwHaCkwfpRAjEHRy8UwaJV/VFV1oAbUsfRi1ggWwpEH8x3eSMAHLbR7D3TXkYda1B9PphBS6Mc5q4aVPuhsP/paBRnqEio//no7G+pdNRVjT0GjPiX6G57mAjlVayUuMcx8hwATZXXzclqyqkU42cAby6aAp3c6e3Ej4D8D8evGex6PiXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(71200400001)(83380400001)(33656002)(2906002)(36756003)(38100700002)(38070700005)(122000001)(54906003)(76116006)(66446008)(478600001)(66556008)(64756008)(66946007)(91956017)(6512007)(66476007)(6916009)(9686003)(53546011)(186003)(6486002)(6506007)(316002)(41300700001)(4744005)(8936002)(8676002)(4326008)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MXVf02icJoEtlXZWNEotneSCbmq8t86V0WrNheh81R5nkqipLmmXJUj7mSSV?=
 =?us-ascii?Q?1yXFmGopJS/THpzzF5uSq8e32vlBj+LNQ6hC+n+ECxpQSkAotjRyV+PDxIWF?=
 =?us-ascii?Q?u35vFxdaobW6T54620BRTQWQg/KHGwO12HmydPD7eULj+Qc711qCVrGmaec0?=
 =?us-ascii?Q?1GEsYB0ax9Japxxz4xWIGYcf69XE0zdei8MgEv4v34cdfTdGkdxges/N/55Y?=
 =?us-ascii?Q?kBfJq2ugkc5IuVNw96oe8SfqD1FGkUcf+QDFx+CENaWXaJiOyWm8S4Lb7hNL?=
 =?us-ascii?Q?P02AZaN0kAmWZfuEJw+M3Obgpdf4smJmWYUds/zAvLckKIXdXyVmgxTT1DMd?=
 =?us-ascii?Q?92Ymt5lHaeEoFRIh3DwDbfwEzydzLiV+uhd303Z5VI8DkNN5C0+jZKZD0gse?=
 =?us-ascii?Q?Cb16RUYMDih1uKwtcaYGe5oLdSlJrdqaSMbeIs1a7INS5+ab4wCDTcpMAWso?=
 =?us-ascii?Q?b+9yoyY7Ij2dxtU7X5jFF77jKZIiHRYhAZtUs/jORrvhNtSqIvNCnWaYR0MI?=
 =?us-ascii?Q?zdEmUBE6t6XgbqaoT6zRNlC1Pa331Qwn3d1ZQb88FYTC2eL//1OgaOb0ZvVj?=
 =?us-ascii?Q?cRzmWnDG4AJRiRXh1L63FdOmePPhRSDLJJRX8yMzOncEy9o8d5YUtYI7vDfA?=
 =?us-ascii?Q?MR2FTrJQufUTdB2x0Va2Q2B6m0CfZO/JRbF4ohSvb1/nb5SrHzOxxnlNHusr?=
 =?us-ascii?Q?7TM21dC6K1V+uWAlwXddYbotIrVNSpCj6tCdsiLyswOGuPzb9pnafFgGBPog?=
 =?us-ascii?Q?juRyiKAFYQyISAYBnyUVbrPKpASu9g43Eddcfr5CXDpmVgkHJKcEr0jBLw0Y?=
 =?us-ascii?Q?sw247bkVOSRkT5HmRNJAjjgGSMFqgrwLNubE7yNM9E7X6rMleLm0DwJlfY/C?=
 =?us-ascii?Q?1zrhbp7pX5N1vDxPUF4/3WvHifoVcQ8TwvmaH6f8FmhZN59Rg1tQuaXfNLPX?=
 =?us-ascii?Q?5aRpAWDMIvrNMrWhnzdVscLi1b0U8GOQssznjM+gFzvcF2fRFmaEwQb6QEYg?=
 =?us-ascii?Q?8XL8ZV7gmD45dtPgOhEZlAM6g34lInbQ5GS+RfCee6lVk42ovxORWV54p3RC?=
 =?us-ascii?Q?d6c0uiaszAfQORrTXRSQPWDbeaJ6JxXH4zorysiTkHV9CQlOaRtvsCZ/7b5E?=
 =?us-ascii?Q?JOGZWN+5e4HiPWHA8CWzTegSlgwbnfxMUL/uNfzASYV5nmgEuoG8tzoFMQ5q?=
 =?us-ascii?Q?RJiIqZCKQRs1fSyRCSINZPeqlYxUI+dL5ANAiBE4qNqBsB0MwS6N/rqZxxE5?=
 =?us-ascii?Q?4L9c+Zbs3aJlPCGdXdIwlYimmSa5eK1Q/m9ydpUINtxRx0evJOHcHyPBZHq8?=
 =?us-ascii?Q?Lgjckig60s3nSdANPnRLMI5nNj6kllqT2AEfa2tfA3v2dgCfJ11jacXaP0ml?=
 =?us-ascii?Q?M/kuy/nx0TQpBnuEnIh1jIIrW3W9i12VXStJBrQkokIAMReb8cinu1Z8jVfG?=
 =?us-ascii?Q?OrjA3XAZvKSo/2AxMAmsVKoobAVK48EnNdjr+hfPZXuFrkbV38eZjXmvOiL2?=
 =?us-ascii?Q?tnHAXyQbISmgMmYIjB++CNOcQCNakm6SoiOAawOOpD7Av9Of/63cxhPM37B0?=
 =?us-ascii?Q?eWu3adyh6gzPgWIGAME4szqRu0pIys5nevVuM8EmxsTexkYP0ceD5OeoE3Tn?=
 =?us-ascii?Q?nu9FbUy8MC/6RhmQmh5VUWAeH0EbM6CqiwxBxP51YQtE?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E123780B6C2DC346A06B285BA9295EDA@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a412e031-55b1-4f75-fc4c-08db0958d99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 22:15:41.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTIRpyJNRk8wVMCiLGWMgztLvoAXKmLDIBO5RcQvHLjgKke8ejviSAt5qTN/1OcLkzGZqje3+jubwoqk4drLcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4521
X-Proofpoint-GUID: -11g1cNvrmvjAkZ2Mdtr7ZNx-1wRAoaR
X-Proofpoint-ORIG-GUID: -11g1cNvrmvjAkZ2Mdtr7ZNx-1wRAoaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_13,2023-02-06_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2023, at 2:13 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Mon, Feb 06 2023 at 23:27, Song Liu wrote:
>>> On Feb 6, 2023, at 1:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>> +static void free_mod_mem(struct module *mod)
>>>> +{
>>>> + /* free the memory in the right order to avoid use-after-free */
>>> 
>>> How do we end up with a UAF when the ordering is different?
>> 
>> IIUC, we need remove MOD_DATA at last, which hosts "mod".
> 
> Oh. Please add a comment to that effect.
> 

Oops, I sent v10 too fast. 

Thanks,
Song

