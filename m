Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE55685C40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBAAhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBAAhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:37:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892741B77;
        Tue, 31 Jan 2023 16:37:37 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3110IIaF005090;
        Tue, 31 Jan 2023 16:37:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=TMGyE7IY8DNy6kP8j4JY6DGIRzXbMuYfboiu7ycj11g=;
 b=DWIK/BCcp/qvLfGC0ywTxrn6vV42hCAFxMytxsyhqtPswUJLO3rjKr3gIFL9h3mqJL5K
 S/aI5/lD+t0BlWiw8GSXZIY4Vna/gWVzl4/qoMVrUMGYXmnbda+xr5vGLge0njVEg1Bj
 Uoc+KOhRlEhV8p8rYrkX3c5OBErgcEsmqjm8K7m78JMD0xUt9XYn6UpFR62iApJ+N/s9
 1wbE8058gdiq+M/5D2B5JCreTj5/VELHQZqMtQ02tN2aIMRySfad4fOreVRHKc2PTTK1
 A7F7eI0pYqShnTK9y+OtdDPH5E8L13erEIchVupupMq/k3OOCkD/v/L2qx+i93grIRPc oQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nf6a1br0n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:37:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8PSaQenywPcpbgHaqSk1PMQ0arcqaYI01rZ9gHRkUmEBuqvjXoUehUpjylkU3/BKtHHZolznvTQAOX38WbqHmIRAmTF8ca4/JI6lyrni26nKuhcxHkf24kE8Zj89Ua1hd58EaUEgbmtZzj0YXndaB/hWW8bLi6zYe4k9hsVntF1T4V6sHEOKZkWMTOx34TTFfIw9zElzeirgRy90/AAuNPZMF9C7pHa9iqoOiyPNEugjutbNQntrDPQjlPLdJBvIDOUovd1PbAWtJaq1UzS8xPj6sC8Etd5aIICTfsbdr9bY1Gk+N79yyd9g9YAiYeI3XJdajouuCGE0sqh5luaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMGyE7IY8DNy6kP8j4JY6DGIRzXbMuYfboiu7ycj11g=;
 b=P4mAOdkNzkTJqLqaRVK/YUZdl6XojeclIN/QL7WxdkXF2HU0VSaOysI27rz7w54ux68kuvcDW+kQIIJZXNjVMxpwPFwfTKlJyugkzO/iCpOMOoz1IQKG95NfRacr0/kRfVIgzr6M/kGEUjl3nyAlz+TFpZkelVc2IaeEVXVUbpFwqCNc9NPzR7U2d9Cw0tQPEI5DeOZ7kYXQyYraL6zDs/xc+fU+146iBlZ/OaV3BUndXFyAZ1LeQUVU3zJdRSVK0BdrZarhwrxIjEGxcr9z7i1aj7/T90++jT7j5Iw/7MeEkDxPBNWkXxiSDvuqZGdRIvisB/Ui9DqrKT45PLR9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB4043.namprd15.prod.outlook.com (2603:10b6:303:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 00:37:33 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 00:37:33 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Thread-Topic: [PATCH v4] module: replace module_layout with module_memory
Thread-Index: AQHZNNeuHVNEhGQ600u3kQvatUZkaq64YMyAgADgNYA=
Date:   Wed, 1 Feb 2023 00:37:33 +0000
Message-ID: <DE7832AA-27B1-4C06-A82C-5FA4EF7CF7E6@fb.com>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9j4LYijtFZzkKHa@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9j4LYijtFZzkKHa@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW3PR15MB4043:EE_
x-ms-office365-filtering-correlation-id: 3f9e2464-b741-4717-f5c5-08db03ec8218
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0K/LCzuDCWTciGUsHy0kstbxkm4PySSIpC54CN6aU/W3bj13zW/2NSY1HlDhiQQ5LTqIVJcFyA38lTGp+L9xNFTXFG6Bcknj/NXQgydyHj3VpatoKLu+oOjvuYFCJpj0UguXpaWH+jMbuaT+zGsq5vQR636T8wLZAQ5n4jnrl8EW5k3z8j5ofZuHqIKqptvxSrKtsll407B1XMIhLiLPuVOpPsfI9wLm97aGxu4m7OGv2YKibwoFwTCrjkB0wntY5RtygZCwMUwJeyBvsNV64GY66BkwkyA3TxWCF3a+0PiIbcGbaxj273o134/xmL1VqC9Onx2QuzetVjydSPG5oAH5cLJshwaVYPKFNskWEstomF/+7aLhgPBms6CSPJyDqACBjpPGW/14tD7Cq5i42/S1D9VslvT6nllm2DkBMZBqa7ZcSlRNCY6lJ2AmTa5/IyRyHx63uJmgw1WE5SCb01CWznRtq3t9T+JHWhU1OF/WbaTfeLiYEbxxCE1gwHqtWLWQbYNEIpIk/TeUah2Rj0iYSxj9nAgCAml0fFP9979RTM0PGEOVY+gMuA0w5gz/Xk/oOBuNsfATly5dtvmJfto+LNYuQPzQisbzRiPOU8XUFPolPFsSawvq/38nUBDqkLvCA3E1s6gsFEIsHASzEATeqpEy8rZKJEzS0F8QRkBbcUB4EouXb/c9A5EkI/wbCMEy3HcyJ5MZoclQQxnww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(64756008)(8676002)(66556008)(66476007)(6916009)(76116006)(66446008)(66946007)(91956017)(316002)(54906003)(6506007)(6486002)(53546011)(9686003)(71200400001)(186003)(6512007)(478600001)(33656002)(36756003)(122000001)(38100700002)(86362001)(38070700005)(2906002)(4326008)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HLKjhmoEwfePjSEppGMoss0d4dfOEDZa1/BsiJPl63QFBQ2L5J73YP+Ttz3v?=
 =?us-ascii?Q?I9gJqc7rqJCv4NlGID1c7qpagXG0johBTNMCcXzMmUOdZSWIIYTxqIwnrt5g?=
 =?us-ascii?Q?jJ1IgdgcLG3Hzo6Mvm2MBTYeDSv66GBwe86ZH8O0crOqgDC1A6fLfuVurJen?=
 =?us-ascii?Q?R/EKTfBvtyd/ZwUlhyWO5STfKc4slL70OCwmXo9plMWyDirfP3QZUyp44k7u?=
 =?us-ascii?Q?D5+0cR5i/S/kXbRdbythZukf8E7iyJyt0fet77GMNOPtkD0bLsx4Rxfjlkuz?=
 =?us-ascii?Q?HkxKW8M7NHr4UxpkQnD6JJfuhLHhgUnes9pVCO/0lMvc0dKSHxmA69sw2hJI?=
 =?us-ascii?Q?Yn5pnz85YbCqxzT7GpkaaD3dhpXIeZaUhrO21MAG36xTIPKVbwn+zX9fNJC+?=
 =?us-ascii?Q?to1sx2N5CN+KfJ9QGQlJOPe3qK/Pkkdm+cKVRJLytjdYOEpt6T8x07qotq4W?=
 =?us-ascii?Q?9cKbEDaffk5r+vP/JC+7TOtwZwDPfRURxuTrrOOW3SLa9vTLmYNT0zt5AeyU?=
 =?us-ascii?Q?f+sQsVmfdxsrzotlyr3fDDK4/R1sLMvLEkxYpbHRA9uvb1tNxSwzDebs3p1a?=
 =?us-ascii?Q?h0MPfbo5HhzaBXxgSq5dxTNu5wP+o/Onvi0sRnYUFvNpdTujiwf8DfYTLkes?=
 =?us-ascii?Q?x77izAtPUd9jhP7Xu7F8S2+994T3kct0s1e3KLbotm4wNZ4CLsYxXYUxxG5f?=
 =?us-ascii?Q?eSuLA1b+KW+DF1kmxbcfjgYJ1E4QNcpNMvyALxYxxHLTLoTs7B56K1hwsfPv?=
 =?us-ascii?Q?lJ0L/cI+06PYZCDQCEAPhwfEI2te2nP/O2KLgsW1UprHeigeyI0N8cLUxiHP?=
 =?us-ascii?Q?dbK+9kPDVQtO5vChSWRUWhwXDyWn9wWw2sIpsHZrObhL75HWNOECy1vEeMT5?=
 =?us-ascii?Q?t+i3MkFPHCIwh1BEMKZDXBrKRlYeTi3lQGNv/PWawB5J5kyjmtsDi06V6kTL?=
 =?us-ascii?Q?sNAo0TNXhosmPHYBMvvwsJUXyp4hqcqBTbA2oMxKQRCGnCwvr9+JmJnHUPbi?=
 =?us-ascii?Q?mDIfnEOCCXLO8IHwt7PZC16nivEgvNsgU9NwE5zLT5s4fZlxhmNZR3Lv6LOr?=
 =?us-ascii?Q?5LXADazI/rzxcKR1VVNzVtrCP5CsFKkI7iVFsMqtOVi2r++aCSRfpPKYTP30?=
 =?us-ascii?Q?HsrRl2Lj/T0nQ065GEbbnhZqFlaEecVjbz3ChgbFRKWVpbgrzaa1/DYU8wLC?=
 =?us-ascii?Q?jmV/pVhf8lq/tuQom0/EmwNMGqCZ3ed7YYnLzZYgLkj+SrVLsH70CC0GGPWx?=
 =?us-ascii?Q?s61I+47lUCYDownfB/ZmJF5YSvWCoy/V8JAIKWJ2cwD/TTum6mlGK0pTk/jb?=
 =?us-ascii?Q?nT2sRHV1o6DSbgpySVr2L/eEf+bBEryV57G01g7Kc/iIvqTs/h+p46Ol2tUI?=
 =?us-ascii?Q?WWppEIr7XK++5Xxrt3G8jpeLJbXPgTnPwFLklLYIn1mqji2cDB74nxTUngfq?=
 =?us-ascii?Q?+9ZELLoBxZOnlFCYej6oMYVVs3clqw1d8IZPTehxsdzN0CC6ITG5sGcSkEDj?=
 =?us-ascii?Q?9h4vJuTNnjfh6fz1D/76UOUwIfY7jSmlgX7BhkD+rx3cZLvbtRhKnP5Gbeb8?=
 =?us-ascii?Q?XQxhc9nPpdnm8+2aGeVh3vN/QLohsypV824rviGOhAZkJUBE6SGkGv7WJe8j?=
 =?us-ascii?Q?mLg9clLFsEz/R/Y96qz2uhntiL4qtfrjjcYKGfZlK72G?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3AA0D76578837458BED1D4B2F86BF99@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9e2464-b741-4717-f5c5-08db03ec8218
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 00:37:33.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pGvj1F0wW3ycA2pQ6CUyCZYzJ95djDk84bwYLN1E0FDuGHwKW7zBQFqgt9QLRac7+OCxhJRzpamITlNE+kaJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4043
X-Proofpoint-GUID: AA_5uyTyY8GP3eJAQVoZweYtUIbm_19v
X-Proofpoint-ORIG-GUID: AA_5uyTyY8GP3eJAQVoZweYtUIbm_19v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all for these feedbacks. I will fix the code and send v5. 

> On Jan 31, 2023, at 3:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Jan 30, 2023 at 10:21:09AM -0800, Song Liu wrote:
>> +#define for_each_mod_mem_type(type) \
>> + for ((type) = MOD_TEXT; \
>> +     (type) < MOD_MEM_NUM_TYPES; (type)++)
>> 
>> +#define for_core_mod_mem_type(type) \
>> + for ((type) = MOD_TEXT; \
>> +     (type) < MOD_INIT_TEXT; (type)++)
>> +
>> +#define for_init_mod_mem_type(type) \
>> + for ((type) = MOD_INIT_TEXT; \
>> +     (type) < MOD_MEM_NUM_TYPES; (type)++)
> 
> #define __for_each_mod_mem_types(type, _from, _to) \
> for (enum mod_mem_type type = _from; type <= _to; type++;)
> 
> also to be used in the previously suggested within_module_mem_types()
> function.
> 
> also note the C99 variable in for-loop decl thing

Aha, I didn't realize we started using C99 for-loop decl. 

Thanks,
Song

> 
> #define for_code_mod_mem_type(type) \
> __for_each_mod_mem_types(type, MOD_TEXT, MOD_RO_AFTER_INIT)
> 
> #define for_code_mod_mem_type(type) \
> __for_each_mod_mem_types(type, MOD_INIT_TEXT, MOD_INIT_RODATA)
> 
> 
> 

