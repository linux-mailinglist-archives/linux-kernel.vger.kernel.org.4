Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6371568E35C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBGWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBGWTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:19:35 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1913A98;
        Tue,  7 Feb 2023 14:19:34 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 317LL4Fi015234;
        Tue, 7 Feb 2023 14:19:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=yhRMK4pGZw635YhjsQyh7GEdHByDgDeXWTvrhuNUbKE=;
 b=RrPaCQRkkRhGugR2t7taIrXe+8ZQ9iytFFBJFUbzypb5pMMtyxcpzlcuUM4Kw/hqQx8f
 LYvqR49h19btyfUsh48E0844jMhmkc2Ex2CfQuVV8eNshkRzP3cD4jzFkiaq4dFaF3Qf
 /5131rSCgYmY63B7KqHuZ5yhGrsaZ6DGiwoFW1uFI3n13bW0fCJ/5PTBMB3E3YJPU6t8
 vg3nr8HIjICR9//MJRKkZQ82qpNvK31Me1LjHU7fRPkol37B1C5fPHRaJ9NHgsdBjGdr
 aF9EXHIfO4XqJdwm6XCD/YIHAVDnjiVAuVmsTluqkBiv4t0Zw7m3l+jFKYVTpE04DH+O wg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nk2whcm76-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:19:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ4mtOGbTyGgAgpjvi0oqxFUQcc5viB8ssyWncosinRIGo1tOH/uR6srd7C7nFKb3xjq83ZlNxkxZ3wnLX/NK3kC7l9+xgbS5EDedNQ4Z3iK1RrZy9CwXDWTWtplkx9gkyw8FgQmreEx7PCd2RHh8A1ouQYFY+7FWLJE3dKvpGfQxl75fmzEEgRrIkdBPg/pdoWWON/qBVG8xo52+b6p93a0ld93eDBwRHnRqnLNec/g3T+4jvL1BHKdZBcKWGZP9XbpXvNu/dxcqk3zQKFyyPjFgCJsWyKeFkH0fBFum5OPU8jsUIrkgU6QrAAJOrCG2R+b4YG499eOhUUdoedggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhRMK4pGZw635YhjsQyh7GEdHByDgDeXWTvrhuNUbKE=;
 b=K/i3ON8QgiZQX8C4VqlC8J8US08E/CYUdE9O+LYwBGQHrJkQMdlNq2RY9uxVm3KgzelJBavrT9TrckHqr3QCpPUSgjkCgwpzbw5xcynNHmBrJXigPGzjTSx6p031ZNE3fyDOTJdipKmYsm0K14wz9g4Hc/CdVyW027Quj6gWetk9tfl+NqbNA9oXEcBCmsIaPVmmCjWkGlqbsHHEGDTGbLMOaWnip4DG/4lY8rF6/iDrD7V6lxg1D1XK5KMBTaQbJmn8YxdlThib8HBiWnCYUAnw0vdXRQPksCBbUE9YQfMwLTFMZPIo/2VRBCcieFU/jPidfEHFwN1nvI+WiyJjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4521.namprd15.prod.outlook.com (2603:10b6:303:106::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 22:19:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%5]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 22:19:30 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
Thread-Topic: [PATCH v10] module: replace module_layout with module_memory
Thread-Index: AQHZOosWgrFk94mbpUiAn23Fr3awBK7ED1wA
Date:   Tue, 7 Feb 2023 22:19:30 +0000
Message-ID: <8972F26D-34FE-4463-83AD-BBCC6F92C952@fb.com>
References: <20230207002802.2514802-1-song@kernel.org>
In-Reply-To: <20230207002802.2514802-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4521:EE_
x-ms-office365-filtering-correlation-id: 7287fa8d-0855-41a6-07a1-08db09596244
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GzheqEE3HdCHkQ5DAktJCEBQDUJynQXcRtkIo6lSPkeXchqLZpoy5Ky6ozPl9ZMU0lOY40yKJNYoVHQxdt3yBLATyRuv+YzjBXYa1n8R3rNG8uAUEpEQVcbR3OsDXES37Qnn/QT1rBMn4lqmAbH0DjV0uzJfPKWb2kVE8QzfGZMrlMPbHfOka0A3OY01/8Ir48Npf5cMEe8xWFV4VMb3KZL1lPKK4y7guOlLD2ngaUhQdRE74r1O3G8/kM+/2ormkU5/maGYpn7ip0RhguqfSCsomk7r+0VF9Mxw15acQP/dxF4XQ5PLf6FzlmxyzANUsm+O8AqX1fY5mkDQ+qDRckg11XgFAi7lNKLa6Oq2VGQJWtxcqqWXozhWDTzS1B/qo5/J7Xz4tYm3zUdktspd0XCxW/adUnqg8SQkXxigR2BNIImYftt/Ipl/LJy5jN3Oxi11qboohrJv01G9F+B/BnEcAOs5aHrG30IzvYsBWbObWDvmBbCWkeF+CX0EWxOTROs6xkM2maa4MEfSlQaGwgab6mWAARPMwPoQ1JOl+YCfIe21D9qsSXggl/FySJ9wcKhQpSkS7HFf/E9D/tklKCrXjLtc6mMok/OL4em/V/AJsfsA5JftUpakTjly1vDYhZOsbm31TBLZNdwqthLjHmmB3FMeZVE1LI5P9EshavkoZE6z37XVa9H3QIlcK12xSWqA8oklhV/ZBKSLuDRjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(71200400001)(83380400001)(33656002)(2906002)(36756003)(38100700002)(38070700005)(122000001)(54906003)(76116006)(66446008)(478600001)(66556008)(64756008)(66946007)(91956017)(6512007)(66476007)(6916009)(9686003)(53546011)(186003)(6486002)(6506007)(316002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnAsled0Z2/mGoijH+v8q7HuLGdnjPRl2gWyO9AHLu8wbljb7iG/Dxm+hM8c?=
 =?us-ascii?Q?kDU7IsI4OoxieAPIq7ahil4V6Nr3CuqEb65VJi+GNV/Q3KUjyBp6JWiH/kO3?=
 =?us-ascii?Q?B33b5UcHebDDEDqqYQ2CejJyt3EIxiq7sq6rhIOYI5/IoWZFxkrrUF5ssDAT?=
 =?us-ascii?Q?ExifjsynJvjbP/LpgesErbXWmrHeeJtIC36MBKmeeCsQRZGqyQ4Zyu1sgvk2?=
 =?us-ascii?Q?hZ269YsgucZj0euGhiNKi3b91pl7mkQ9MHinwCS145fgdYDZPylS7LzvXfzK?=
 =?us-ascii?Q?Xp0UPssKYGC1nwAIbetVtHsW3CIb47fLO972MlVCUn1aRJ1Zvxf6OZ/puzk2?=
 =?us-ascii?Q?KXUInMTbD+EvfcyHo4TrEPSBW9H2yrpLRRa8aX1uVDoucQo6+ycDaq30tuj4?=
 =?us-ascii?Q?0T5LdDMbUNJAs4snq5F/SgzZ9IWAQdo87VakQreJehfZCQ0pWilZBAx7Aqhr?=
 =?us-ascii?Q?FWGVjKb/f6JOUqwbWSlsyw2V2XO17YW+3n1dD/CfNLPktm/XUOp0RXC1dC47?=
 =?us-ascii?Q?Bd8N9mD+PnCHTmSR+TR7yJxglYBolcTeCOroZZoTwhRrLShP60rtAEt4CKkX?=
 =?us-ascii?Q?3KVVvO+U5Gqjmm9DK//sxVblayL1kAqhBCH5gZCCt6w933otWNAzZXiszkkm?=
 =?us-ascii?Q?14kFl0/wymonT+XAAZNWwkZFEHwNS5zMGM6wTAaBg5ST1y67n9yRphMmaMfc?=
 =?us-ascii?Q?R6mrTt8V9M1OGW6QcdWAiQMf1GmNm9k98lSI1MeCe3IoFyChwmbnrJd3nwtt?=
 =?us-ascii?Q?+ZxMRcxHM9PEbCh6lGvTDacM3cNRRQnjePy6i/h/50DsFbctT45AQQMc6tn7?=
 =?us-ascii?Q?keyFj+Z6XM1V/W7NQhX4y0RtFULpwD89LeYuNhv2NBnBEoxgJdEtDA0IcbJ8?=
 =?us-ascii?Q?fBpAK4mttoZlrhkZc+0rMqIJZC3DWaAp9KClYJ6lQRv3x4blTf6Utx/kOKT3?=
 =?us-ascii?Q?LfbVyvaQcmOLZT0L4ZmeznVhZmIxeHmTitgEk/uyabKjOg4PBUuTCIZXOG2T?=
 =?us-ascii?Q?eCtq1+cIZOlXD4U8Z6XAnvS1sceNnui5Dxn2ieI+SZYSiRpnn6B5Mr8X0YXn?=
 =?us-ascii?Q?xHd45r/jDe3z9+92GvFF19x9XUKG2XZ2+ifequXIg2Xo+1yo0V5uRU/xPolp?=
 =?us-ascii?Q?vpoh6jQQ+oIGW7HGmTrByhkjzQTVsBiHFq68chGbRIFgkipFFI2xYMykaKCH?=
 =?us-ascii?Q?Q61oUQSou3SY9XP34sngv0+oFbqTkYBGbKxy0snQ/ozS4ZvSwIZLdWmC8mXy?=
 =?us-ascii?Q?O7eCUaffrGWZ67AUEaoUvHSgA56TriGtwTgdm0+QccEOGIDbHeca/7ABWf9r?=
 =?us-ascii?Q?k+RH6AsEHC6eXqqXmXUsWaWehtTQSFqsgLzXkD8Qrt6TVkssxIBUA9dMP5MW?=
 =?us-ascii?Q?BfB6tN3NpR3Zw4xQZblwPRGgXRHP0CNwrHav5CD1WKh2P6p3k8+HQ0s5irlZ?=
 =?us-ascii?Q?wxMaAjFusNi7DHyIutIXtw1T+6zlhuNUeY5ySCytdphIiFg7Va8l8QfQoyaG?=
 =?us-ascii?Q?mK5cH9nSAx4Q4a8pl86A1FvWBhcuFGnYaoALwWNYWeNIWASDyQ7rNWp+BEzZ?=
 =?us-ascii?Q?03lPKsEiyORAAOk5raYWbGnzy/XLixWSgvwAwwFlz5gtl601y3hmE2iGGkJ4?=
 =?us-ascii?Q?YVlxbkc13u+U5QicWqIGj/IgIntS72UcWHo01o4Q2hox?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1A97DF26DBCDB4CA27143DC92C2A9C3@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7287fa8d-0855-41a6-07a1-08db09596244
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 22:19:30.7953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f493Mktkb+IXI0ciqf2cl6e9bfEasfk6awFYfBE6MXQKhEeYYidgKH/jGFsUjd6ezHCz/Dymsvfgbjj4BnHPXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4521
X-Proofpoint-GUID: W2fmatTDA3rk1dYnD1ZgSUDsawH4upUZ
X-Proofpoint-ORIG-GUID: W2fmatTDA3rk1dYnD1ZgSUDsawH4upUZ
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

Hi Luis

> On Feb 6, 2023, at 4:28 PM, Song Liu <song@kernel.org> wrote:
> 
> +static void free_mod_mem(struct module *mod)
> +{
> + /* free the memory in the right order to avoid use-after-free */
> + static enum mod_mem_type mod_mem_free_order[MOD_MEM_NUM_TYPES] = {
> + /* first free init sections */
> + MOD_INIT_TEXT,
> + MOD_INIT_DATA,
> + MOD_INIT_RODATA,
> +
> + /* then core sections, except rw data */
> + MOD_TEXT,
> + MOD_RODATA,
> + MOD_RO_AFTER_INIT,
> +
> + /* last, rw data */
> + MOD_DATA,
> + };
> + int i;
> +
> + BUILD_BUG_ON(ARRAY_SIZE(mod_mem_free_order) != MOD_MEM_NUM_TYPES);
> +
> + for (i = 0; i < MOD_MEM_NUM_TYPES; i++) {
> + enum mod_mem_type type = mod_mem_free_order[i];
> + struct module_memory *mod_mem = &mod->mem[type];
> +
> + /* Free lock-classes; relies on the preceding sync_rcu(). */
> + lockdep_free_key_range(mod_mem->base, mod_mem->size);
> + if (mod_mem->size)
> + module_memory_free(mod_mem->base, type);
> + }
> +}

If there are no other comments, would you mind make the following 
change when applying the patch?

Thanks,
Song


diff --git i/kernel/module/main.c w/kernel/module/main.c
index b9617d7e8db2..c598f11e7016 100644
--- i/kernel/module/main.c
+++ w/kernel/module/main.c
@@ -1211,7 +1211,7 @@ static void free_mod_mem(struct module *mod)
		MOD_RODATA,
		MOD_RO_AFTER_INIT,

-		/* last, rw data */
+		/* rw data need to be freed last, as it hosts mod */
		MOD_DATA,
	};
	int i;



