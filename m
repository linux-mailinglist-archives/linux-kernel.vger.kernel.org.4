Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720761088B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiJ1DHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiJ1DHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:07:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390EAE845;
        Thu, 27 Oct 2022 20:07:45 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMnBoI023106;
        Thu, 27 Oct 2022 20:07:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=05qkL3iaWPB16Ks+QE3MqFd9s3Sj749SWFbKCEevBxo=;
 b=Z7qrbTeaRlRFT9Ju1P/JHAho4mQLAQ+YNgNgRM8kQyqpH93JYyqTaYOFMChoKKKI9rL6
 gLyGR/Zu0/uKkEYZs6Pt8DbUGI2gBZL2DwQWUSYrsD3o3aAL71Q1bSu9FmY+gqwcMGHZ
 /m9HOJiBGzthPvzfRO1ehPtRz1W1F0lk+A7m1HprPMELMFk4xPm37j+13q89G3U4CYiW
 HgN4bE625Bbza2Oo4PuC8kRJM+OJh/xUtY2VLAScXwKmLd7+sWn8rTB/a9C3Ztc5n/Om
 uCwpCcatom1bJtwTDToVl5J6Sx+sfmE8+EfImQUfmpka4sLtdY4S2usUadyMK8Op9Ha/ 2Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kg23yjjjb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 20:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1D19k57Oe+9IIknxhjR/vLm5JNgboDnvX2ao0Aa27P3wYlLS1KbJaYKq5XWG8yDtqwol+42ju6G2rxHKzlo3qOv4FpmkXUlFLvF/JnidZ94LpZ+ktzsdmAuIPQi+bFQ9w06nz7T++8nX328zsT3JGM3cJJu66WECKx2fwaZB/MdJ4lW7Pw4rm5tnv3rGl46/6hFSFoT4sjEw7E4wrk1cEcDcyoPyiRreC4ZU3VxEAh78f40Y8WG1F0m5BZBA5n05u13ei8UVInj/W5hJRrktMNXxbzqM9j+txB2yAmK/o+4dS6FsZ24fMbdR3K5dIK8X9Qas1mCTqJoBGTYL6Tx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05qkL3iaWPB16Ks+QE3MqFd9s3Sj749SWFbKCEevBxo=;
 b=CgTetSSq8uDUmVJ/IcDadzxzBMpS0dLdQReAsthbVAt1b+P6DIH+OArgbGZ7wOuOJv+U/2pgsAXZuPBneFWYQWvYVMucAQ1IKtPveLtltaHbWfqewma63FJFUnMTJvqgM84To85uWF1Z5P4k0f+n0gwOBiSCzdJD+HeVpuZymxKmjmGirS28kb66U+3cszp//KHJ+PCx4/RRecwq1qCNyac4ByXXWVjTtjuespTWnjHK4lQ4TxMODFr0KUpUlatug55ea5apqtg0Pu/XI61gol+tR3LDxxLdTyPiRFazVG3cIaXJ2ySw5bMoncd1QHCqIQPlERqVaBjfy75m60sVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by DM6PR15MB2553.namprd15.prod.outlook.com (2603:10b6:5:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 03:07:41 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f484:212f:e766:d1f5]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f484:212f:e766:d1f5%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 03:07:41 +0000
From:   "Jonathan Zhang (Infra)" <jonzhang@meta.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Thread-Topic: [PATCH 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Thread-Index: AQHY2pI/27foXU1qhE2+ZZlknLVcfa4ZgNaAgAZkhACAAAReAIABRD4AgAIRxgA=
Date:   Fri, 28 Oct 2022 03:07:41 +0000
Message-ID: <D9381C12-A585-4089-873B-3707C17823D3@fb.com>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
 <63531a9dd51b9_4da32946c@dwillia2-xfh.jf.intel.com.notmuch>
 <151c093f-1e92-1c8e-957b-8781e488626a@amd.com>
 <63587b16dbb3_14192944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <69a14ac2-510e-fd8f-0854-60805a150663@amd.com>
In-Reply-To: <69a14ac2-510e-fd8f-0854-60805a150663@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|DM6PR15MB2553:EE_
x-ms-office365-filtering-correlation-id: d181e877-f643-4e91-ba27-08dab89193a4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSu4TZcchA1mkzjAYQdIILSacNx5jzUycXojBsSip1+/bDkyGRrC11Aejtj3hj8OjNRHOpuzC/CNeblpnJQelDxKQnnlp1LmD1SBKgPk4Uxx8RHhloQfg6inkfZKntsCaN0lTielhsHDZARM2MkpmKosuSLtmmhv08JW8P/oYYK7skvV0i7nV6iT1CAAOjxOOQ/5LJJtm7X4h31KP/pbv5yE2eJT+8BRuuA1p+EaSUq3PfELMYiHeOTJlPZCwLNYmMDJc9Vd1cZIBK0Q5uUEbTn6957q96PLai0DhqIrBj4OSQ7p+TF7YAPc2gHahqF3U6roOJbzUTCjZKrJUwffLkMVoO4YTnEdQmTfjXtRlhhCiOsOnQvTUplvxymARyAjQj5idxcvd2Ophexgth4/lUywYB14GIxZ6+zuMCxYmniZPTZWxIP0YH9yLIrZ3ZfV6XdZmTa0K0LDABLQrorovyfk3zojYg7xkuXeLW9OVHVp0CRq8YDW+HPbEaxryzb4RAc/EsDDt77gBq/zZz7y4LYMwvRh063OaSwpkeRCR85ASAcqSPZaMKOiijwSH4vT5sHmv4HdBv9C2WV/ZDqNz8oGBBGhtMaXcQNpllMzfPOQs1qQcMM4FkUVxs5TSM2hjPf5Ey1Xy96RB899hnWmtkwmYo25fe5upqB2ozZxaIpMzO9t5S05Gg4gXkALgCrPwrHQ4TyAlOsJxpJxNSRHQGHgo7JShvURAUFsSkZ2PgLcyyINAf9gqfG8JNlq+7djMIMGe3h8pv/8TuX+8AY2Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(5660300002)(76116006)(83380400001)(2906002)(38070700005)(186003)(38100700002)(122000001)(54906003)(7416002)(478600001)(86362001)(8936002)(71200400001)(6506007)(66556008)(41300700001)(66946007)(91956017)(66446008)(8676002)(6916009)(53546011)(9686003)(64756008)(4326008)(316002)(6512007)(36756003)(33656002)(66476007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x5wxEvQw7/xUFEu3lGuvpAbOPChQBdbrY6b7qeTyZGYnZmh80YZvk4Wwsnbk?=
 =?us-ascii?Q?dHCnbI4LQQKHI699CljGvv/KUZ6ODb7Hhw3QWJf2F+O5XiflcDvltIMtrBib?=
 =?us-ascii?Q?KSBNSbGYs58FuMl+yQVfkAikqP1GBBipa5CfzoHUuidRKDGKLn/9wj4vtFXd?=
 =?us-ascii?Q?ypTeY8pE1kQddgR/0a5HUUUhZcMj1vXhBqltc1RjVbyLcrGPpWPvjysHrFMp?=
 =?us-ascii?Q?6lx04ZVnWCK95RJBEcDM20zKwf3bh/RqmvXUXZP3hsVGdktWJAp/kdQaV3jU?=
 =?us-ascii?Q?j6ySS+Bs3p6oh8IXucwZV0ubYnRShU1qW/bLBbV0ttr9mXQlWiQ/Dsq8v4oB?=
 =?us-ascii?Q?XFo/dS9bg8FLSRDR0Gd7nNwRSu6HCpjYdpl5w6GqC4LjCGrHcqLkqonFCFyn?=
 =?us-ascii?Q?+LCfDdl7zt8YKkejDLNp50JKeS0pLgNcYDH23SELMJXH7kvQj3MerfGnin+m?=
 =?us-ascii?Q?lwcdvYfbnSr2Mo1QB+Cf/bhjH8EZpgI1Azp4clYtYFFYhcs27bfTcozugqS+?=
 =?us-ascii?Q?uJ03DKTQgQpMuuBQDFXxeoJxhxIDZamzCCbATn8HzVFcCbCAthItoQvuN9v+?=
 =?us-ascii?Q?oq6+fjXkZMdmOg3cg0uh6vYivAzJJ/UJ1JhqygZMKvMlZi1WzKUijNdmY+V+?=
 =?us-ascii?Q?xpzUv3nCco2r9zrpZ/N/c+aWrh4LjWn5S8P8FpFWlP3Zvo3+crwX6DlTcYJ4?=
 =?us-ascii?Q?tf2nVm2ukmxiYXQRNA8NmFHDz10IQkU8hfcb0q12Q3btte8P5AovXa79cCH3?=
 =?us-ascii?Q?2coXg+t4zggnrDg+idaCStbR1PLxk/iNv8dB5owCG9WiirYq1mMhK0HnMrCo?=
 =?us-ascii?Q?pF74zLBCQFP86CfMdDqJCLFsUcVf3sgBXgHIEhE6s46vCUZ7BzcjDYSH/KiR?=
 =?us-ascii?Q?42ai4Nxmb5aQNZk1bP8vuT8O5O1Z0AvLMlaAP7hqIhf+HAgAWFGLYYgH+xZV?=
 =?us-ascii?Q?pv4pxv1C+iR2NZHgsuSZ60FxTVbXIoMq5FhReqoft/hr4DI+z9p1nX1ay2yu?=
 =?us-ascii?Q?ldZiDUFzziBo26fNkk6fFZMlmC/eY0L8VxCHIc32rKFGT55mpON3FvEpNCZY?=
 =?us-ascii?Q?R0YfnewF1cAeaFLbP78b2N19gTyonHLGwNRQEb+2e3hjKV/IKbd5aAX19RTx?=
 =?us-ascii?Q?GpNLu8yapeZmLoi6PUZrBB5s8fsWw/jtXQ3Z/8mrNduFymh2LtF09waDzZc5?=
 =?us-ascii?Q?X6lCpoLiQOwh8L5nZPFFkuGzPg7LidhNcIhyIMcsbNo+6NPESjAoQR1jwtjQ?=
 =?us-ascii?Q?Ij58+YUSVwJhUyja5alNoXu+roCQmNLCRHNmvQ1EqwEIhaO6StFUdRfNW/uB?=
 =?us-ascii?Q?qBcxehT8+AVyMSTvS90T97c1U73mRRCGa3JqkkewhUL3892MCrOtSCHu0gQM?=
 =?us-ascii?Q?+EHysAPDlJkKon8/8qsqrPbSR/6jxPoW/ddjxxD2iQaGrSE/lJ9iYq+XmHXX?=
 =?us-ascii?Q?jqBkhQsxQs8jlB1eU01KwO/DvJKdqiiUHlzwifDNV5ZCtlTEom6r6Fnd+rYZ?=
 =?us-ascii?Q?fxgGp72mYmgMkGzGthuENCNes9WrjEWdbPiwmfIfxNnz6f0KBQGkh8cJE0Md?=
 =?us-ascii?Q?eLRmsstA3i6gtFROhjmBjzAOk1Vmu8WiSz3Pec8021EoMns8WC2TnSeFHjYs?=
 =?us-ascii?Q?ixfRBLmS5x2fNbsm0v3INPo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA7BBDF738DC084498A3F6A7CB66E069@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d181e877-f643-4e91-ba27-08dab89193a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 03:07:41.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyXGqlC49jzT5H2rPqiMYLWOYadfJWz+Yw0bDEyrxpyiORHXNfXLMKfJf9PFefy4WlG+VdTMEy8lrC2x0lNAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2553
X-Proofpoint-GUID: PQPFcz1zDgSkalnBTi8ef8mWeeINXwZS
X-Proofpoint-ORIG-GUID: PQPFcz1zDgSkalnBTi8ef8mWeeINXwZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 26, 2022, at 12:31 PM, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
> On 10/25/2022 5:11 PM, Dan Williams wrote:
>> Smita Koralahalli wrote:
>>> Hi Dan,
>>> 
>>> On 10/21/2022 3:18 PM, Dan Williams wrote:
>>>> Hi Smita,
>>>> 
>>>> Smita Koralahalli wrote:
>>>>> This series adds decoding for the CXL Protocol Errors Common Platform
>>>>> Error Record.
>>>> Be sure to copy Ard Biesheuvel <ardb@kernel.org>, added, on
>>>> drivers/firmware/efi/ patches.
>>>> 
>>>> Along those lines, drivers/cxl/ developers have an idea of what is
>>>> contained in the new CXL protocol error records and why Linux might want
>>>> to decode them, others from outside drivers/cxl/ might not. It always
>>>> helps to have a small summary of the benefit to end users of the
>>>> motivation to apply a patch set.
>>> Sure, will include in my v2.
>>> 
>>>>> Smita Koralahalli (2):
>>>>>    efi/cper, cxl: Decode CXL Protocol Error Section
>>>>>    efi/cper, cxl: Decode CXL Error Log
>>>>> 
>>>>>   drivers/firmware/efi/Makefile   |   2 +-
>>>>>   drivers/firmware/efi/cper.c     |   9 +++
>>>>>   drivers/firmware/efi/cper_cxl.c | 108 ++++++++++++++++++++++++++++++++
>>>>>   drivers/firmware/efi/cper_cxl.h |  58 +++++++++++++++++
>>>>>   include/linux/cxl_err.h         |  21 +++++++
>>>>>   5 files changed, 197 insertions(+), 1 deletion(-)
>>>> I notice no updates for the trace events in ghes_do_proc(), is that next
>>>> in your queue? That's ok to be a follow-on after v2.
>>> Sorry, if I haven't understood this right. Are you implying about the
>>> "handling"
>>> of cxl memory errors in ghes_do_proc() or is it just copying of CPER
>>> entries to
>>> tracepoints?
>> Right now ghes_do_proc() will let the CXL CPER records fall through to
>> log_non_standard_event(). Are you planning to add trace event decode
>> there for CPER_SEC_CXL_PROT_ERR records?
> 
> Thanks! Yeah its a good idea to add. I did not think about this before.
> I will send this as a separate patchset after v2.
> 
> I think with this cxl cper trace event support and Ira's patchset which traces
> specific event record types via Get Event Record, we can start the userspace
> handling probably in rasdaemon?
Yes, I think this makes sense. rasdaemon could aggregate data and provide user
with full picture:
* Memory errors from both processor attached memory and CXL memory.
* CXL protocol errors.
* CXL device errors.
Such errors may be handled either firmware first or OS first.

> 
>> 
>> I am not sure if the CXL CPER to trace record conversion belongs there,
>> or somewhere closer to trace_aer_event() invocations since the CXL
>> protocol errors are effectively an extenstion of PCI AER events.
> 
> Right, I will keep it simple in v1 and get the comments about the placement..
> 
> Thanks,
> Smita
> 
> 
> 

