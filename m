Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E046758E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjATPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjATPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:39:26 -0500
X-Greylist: delayed 1584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 07:39:08 PST
Received: from mx0a-002e3702.pphosted.com (mx0a-002e3702.pphosted.com [148.163.133.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC3819B7;
        Fri, 20 Jan 2023 07:39:07 -0800 (PST)
Received: from pps.filterd (m0171835.ppops.net [127.0.0.1])
        by mx0a-002e3702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KF8dEW017613;
        Fri, 20 Jan 2023 15:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=ppsBULK0520;
 bh=bRw4jrt5vf/W6v2g3RL2LyLL2DU0XToZcPJtlw6+wYY=;
 b=oyURH4MS3SQWu29kr0LL87WuZmCOTFlgCIMjstGGp55HQVF96dBPBiK4p9/B7bqHQddQ
 r8mKQ1c8qYbhX740ysjz9Bw7WZvD9RYUmBRWDQO1CjdAF19W/DFnokAKGtekGrYm0661
 6KhXLT83DVCxXdSOPf0TMZIe8RW/6Ql6yci71fQ1uSkfkLj60IVsJ8G39owkmMsqOWRn
 1bIIXwdL55LHzxyIi5PliZLixpuqd9HFvdFV5DOk/YtK4/IJHG7WpHFGqx67onNGspJ8
 A3/hujGN29nDkh+cg1Cu6NfFkrzX/wohZcK/SShfVcUgqDpY7ig8Cu5jMK3mnTMIu1+2 YA== 
Received: from p1lg14884.dc01.its.hpecorp.net (p1lg14884.it.hpe.com [16.230.97.209])
        by mx0a-002e3702.pphosted.com (PPS) with ESMTPS id 3n3j66aabg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 15:12:25 +0000
Received: from p1lg14879.it.hpe.com (p1lg14879.dc01.its.hpecorp.net [16.230.19.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by p1lg14884.dc01.its.hpecorp.net (Postfix) with ESMTPS id BFED180D8C3;
        Fri, 20 Jan 2023 15:12:23 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 8F49A62FA1;
        Fri, 20 Jan 2023 15:08:42 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 20 Jan 2023 03:08:29 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 20 Jan 2023 03:08:29 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 20 Jan 2023 15:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhYBbxbgQsBHZPfvGDVWOF92CM7gkTN9lJbsTfX6tQA+11OVFwVPIKe/IZhd/zw6V0kRxT+vPjm95fX8+S+DSQ2mBzhdkLYnaXcuMKV5rgZTqcBQAbrDjydQQKq2vrKIV9Q64jDewXWcy7RpEcLoGYgmhGHw8C1A+tLj4v2Ul9M1bQEpflcDoT6YfEBrM7EC95vIX1q54LFFXitxEzOP1AK0KxsA/u/U3PRr6luPm+RQogcMBkGskEjvKyP34xes53AhMccHnBbyExWkE0tDk5RAp7+bWiBcGOPxx1eZ/atJJjqJIU+CPqWHXVuioI6bvBEwAAoPypMFbF7toov3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRw4jrt5vf/W6v2g3RL2LyLL2DU0XToZcPJtlw6+wYY=;
 b=KDCPjaUMHVTU9wHAZBmusYlJIoWZ9YsCN8hr6i4KXsmOBOqqvGL4+qbaH/ApsmPhAJn5B0Xm3yUeh9hg4ODKoTgZwAiDCzTjUXoNMImqbXhboMfsYDlPBTn4Gnnk2ElRdLam6kv6fJHQL1HbPLRwPP9KvMY6SDSfrB+CZfRzFxtzq3ooLdRNLgLIitiu0NrgvxvtKo5jE8zy4J2g4V54fTzH40fqenX14RFboc2FtbIOQdftcW+PBQhlj8vsTyC6u0rkivW5cALUuIO9ne9wKfr7UoOyhSmvwrkA/91yPhK2mKaDD9k5enrrJ1FeqpbB+IBejHUIbWr6KHHeyYwrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1428.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 15:07:08 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%7]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 15:07:08 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Babis Chalios <bchalios@amazon.es>
CC:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jason Wang <jasowang@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "amit@kernel.org" <amit@kernel.org>,
        "graf@amazon.de" <graf@amazon.de>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "xmarcalx@amazon.co.uk" <xmarcalx@amazon.co.uk>
Subject: RE: [PATCH 1/2] virtio-rng: implement entropy leak feature
Thread-Topic: [PATCH 1/2] virtio-rng: implement entropy leak feature
Thread-Index: AQHZLDYqz+OzQX/4LkKse2Y5pZYAp66nPh+AgAAqY0A=
Date:   Fri, 20 Jan 2023 15:07:08 +0000
Message-ID: <MW5PR84MB18426587FD27BB152D621BABABC59@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230119184349.74072-1-bchalios@amazon.es>
 <20230119184349.74072-2-bchalios@amazon.es>
 <20230120072909-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230120072909-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1428:EE_
x-ms-office365-filtering-correlation-id: 5aec68a5-4c47-4b6c-c8a1-08dafaf7ffc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyC5vrzKM+kBHp4PY3vilmGIxQcsj0tPtJjunEk7OmRtVonh70//n1K1dBi6thkKzHoPXYdynJz9pLm0c7ZOTLEAdiGIB+cnLq54CJAtROMBgFUUalTJUsptBJIyRR4gbC921N/m47p8dJy9dv9eNISQQ5DaYR/avAG39DyePPOWiw1CMpRatZvoGTnOl/7LMEzoRgmHo0Wd/suAps9ccCioFs+rhAk/J2EQOyGTT5D84HM5XhTgL+SasZEcanowy6He2ROvIIvtANy6t64Vfocs+X2wLsxv2XZr732Fe/ywnohyFU0MR3YQiaP6xp9dL2EdNiDsaVO9XGjuJuCmfBKT5WWINRJSz0plbO0ZNNE5TqK7N41og4syDdrEe/OFcngkljYlq88+/uc9s6whiITU9ECNsvgejANs8Ddm88VfhDuPfVxlW9i5K87Mrzkg/TEvxcTPZ5MVI3qyLAXJ/2Fcn7cEJnTPsUPDmjhDT7ZVmlP2M3v9jRq1+SbseWEYO3ZyGWKSV8P7cwvWn+mnTDGyRTSyGSTxSVc52r9yS2QGTh2hAKYgZ0L0gV4b6+QfaavdMcQxtP2ljmUNuPJ9YpW8N6CXZxFDmKGzSf34u7uXujss2Ixoez16lrRtoPEk+qjAjiiFbU5wFr4FbZeR0hlSXaHtzqlMf9tIsOTYXoY+o+jgBCNw4ZsicHeOXSUWYJtkll2GrmRQf/MephV8NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(33656002)(110136005)(478600001)(7696005)(71200400001)(55016003)(38100700002)(86362001)(82960400001)(122000001)(38070700005)(6506007)(52536014)(2906002)(7416002)(41300700001)(186003)(26005)(9686003)(316002)(64756008)(66446008)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(5660300002)(8936002)(4744005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Scuez5bpEnoSM48zaINqVhAFHXn6jUBsSOrONSZq5MJDvM8x64s6pWM8ZHqI?=
 =?us-ascii?Q?yRf3gnTFtalQGrJVo4WRDNHq6fmQly8frOv0fa0sI5o2CRUPKDmftimZT1mi?=
 =?us-ascii?Q?xaFc8CrJMUpGT3DkHS7TrcreHUXLHsn+uxVl5nYWViiqW5TbF3nfIzcl5RKk?=
 =?us-ascii?Q?MGR1EsBGvgRRxbw7ZYlyI6wrTOQq/gQnA4q5EUcHGxNejkgcAV5qyBDIWIOn?=
 =?us-ascii?Q?YIsV6LIIP1VGe0ZiWqUgpPXL+RGD4GvicdEKQfRjWvA+3ip9pwj3FTnY8lWK?=
 =?us-ascii?Q?WSA2QoNjRz7q5p1CW9P+Enbjko6QdvnlT5Zb0oNej/KMZ78VkwLtt4QMdIZB?=
 =?us-ascii?Q?jnLrpuQZqWUjiFM5N1GMVSzzuQ4Q8wAEAZ2Jv9e+Jl4o0OPe9Xjt68v6WZbQ?=
 =?us-ascii?Q?mbMDYuyFgcxTuDjjrhfjQeTX03bToBJKqjk+ZAxlTsgs/G3J8hDAp6dJWtYn?=
 =?us-ascii?Q?UWE5xr8Wwf8vfblBJ3dUaDKzVFz8I6+InT/TMEb5vDNR91chjBARSamC5V2o?=
 =?us-ascii?Q?FxVZWtv86lvUXfKdK6sWQXcSMU7f2IMrHprEqq0qEQU5tjnZhBA0bQQ3TxOT?=
 =?us-ascii?Q?ZuSyAP33oiYHIHuiXEoUQAFuUpC6tAbwcWwoMdwaX9IiLvTswacI/QYxtfsQ?=
 =?us-ascii?Q?lZTlV5vZqA3hm7jE9PtAtFJoocbd4hkAwEzS+TKENR54BQJSqFvT1JC+2eGS?=
 =?us-ascii?Q?l1QeSRv0ExDi02qUzLa8ZX/sqol4ngBIBaAXu0GFdZ3f1qe9SXrTHLxAXq/b?=
 =?us-ascii?Q?MjgG+44mLXMwf+8O6JREbDatpEFH25G1rPiA96t3zHJT/r8lITPD19VuU7nr?=
 =?us-ascii?Q?l6o2IhzPdwEQR3VHfY2VENIOK36qx3ZomvjbyRSkJ06OfYFhaGqC39s6Vgq4?=
 =?us-ascii?Q?ACaiKhylNIrnzyE8XZHVqRMSbG9cS6/HZo7EpSj5ZtSBomrt80c+YwvrmXbo?=
 =?us-ascii?Q?93WVnZtse0UakbyHR6wi8HOZH3iN8KWFcPjQyB3MNUz/QZRz7yehg6E0atgb?=
 =?us-ascii?Q?uq0LgsT+33IFurKdJyiDodswv6z5RxMzr/GTYsE3/KOMMZL1nO+SZkS+wNdq?=
 =?us-ascii?Q?4VzaYHMExD1Wi4QS2i1Ao8+ZasyOuynmSWIM5DFLT7GDvnvr3xKpBEmBwdgG?=
 =?us-ascii?Q?wC4cNtZ2NseGwzxyUKHa9iEzvI3p9KiJUtAT/NVWC/4yI5YgWGJdUbRYCaFX?=
 =?us-ascii?Q?eF1vGSYEov3lMzT7WR/RFbi0QFhFm8yyL7zuI4tO0kelnOAp+WIghP8SsFe8?=
 =?us-ascii?Q?Lv4/v1bf0V08X5JQLDwXMnMJAGNi5b/1+K8BOP8T2MYUWXjIPCt6jEMbdHCd?=
 =?us-ascii?Q?1LrA1VA+ZNio377WadNnETN9JMaXXcDohFZUjD4N8uyxODx1Nl7wujgOUwkI?=
 =?us-ascii?Q?L3GOZo5RfMoZC2eGGfmrifNG+s8ZCIoOAUzoWhoPljpMMUulPZoNQKVtKGmT?=
 =?us-ascii?Q?Np8mCJCofcLSOuJtArK1YiUje7R98Y3v6uAnrkybnROVowT8tikHWf8ricTA?=
 =?us-ascii?Q?wZf9vmzrXYBDbiCh/MgoeFRcoFuUwIYqXMEZCva88w0cQ1sMl8fUIPvMm7WO?=
 =?us-ascii?Q?vn6HDiM/6eH+zqwZhn8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aec68a5-4c47-4b6c-c8a1-08dafaf7ffc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 15:07:08.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jV/J/88AG5kHbUtHzLRbImLcS3DD5pgeeF8EKR+iaKun+tPvxVr324lyRFq2W8s+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1428
X-OriginatorOrg: hpe.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#include "asm-generic/errno.h"
>=20
> Why are you pulling this in?
> If you really need errno the thing to include
> is linux/errno.h
>=20
> checkpatch has a rule to catch such cases:
>=20
> # warn if <asm/foo.h> is #included and <linux/foo.h> is available and inc=
ludes
> # itself <asm/foo.h> (uses RAW line)

It's only looking for asm, not variations like asm-generic.

