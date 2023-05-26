Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8D711E01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjEZCfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjEZCfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:35:09 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30620B2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCBbAbJHmyuT5RvnyfTSGey0Dq404PMvbWj4V6BZhHXsFlo3UfYG4TBnV+NQw++S+iN79bTBtlzOesYecxZllEDK4HGdhGV/s881XcI6ov1JdOrRDrU1qcX6oi5XzUV1ggnG4Alo8yO23UCFUcN5H1FwBsViouOt+uq5EDLhLwicu/JtPaWjQWb6UhaiUj4ZinA82BVFHkWNe3cbQeuHVPOp54mWVJNrBD+hDQLwA3ycVpwHmZJ25MLQ27TuedJEhUBYXLyQZngI0DU2pDBJnppwuBq5TGameFikLT82kk1JsLlGwxDKgIJ0M8C2r1/VZglu76ESu6EL7/JuJPYPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5SuGZR4tJBeAA/nmyOVakIiNoteAfQv7rwfa88PgMA=;
 b=IKKm1MpneqJ2044UmQusoSSN5mRItrOhi4dRODvdYHrVLGSp5X2/ZbSVvthX4Bsah1si5Z8+IaaWnwH1kv+4hi6BD7rXA/yJGTWSALd5gpixieCdDVXZhwdiyb7ZJsTvQRBFuxPvjAUWYvvEtpr0uHAKEBAFoZnfufks68e2ycRCNAG3RI9X3b1y/f83jEEGRFtlGWpTAtrN7kWdhJfRUGsgVmAokp+EQ+N2Pc6mskzDynogI/rw/6FaymY9gfmt7djMX0awe8EJVjIbYXOB5wR2pUT1K/XNFX45ynYisNAzQKXaeSieU/aD8VyJTGB9g9QLxOQ20Ey48Ld0byN99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5SuGZR4tJBeAA/nmyOVakIiNoteAfQv7rwfa88PgMA=;
 b=UmX0UYAKtEtxmrg1xJ+ZtEDmv0ptm9Pxy0hZUnjg4NzEDbj48Ot4fblt3VaUGIYE99eBGaAoL7q/Ah8bW4IE3VW9BDIchMQsdmnFefO/PWhWnYAav2QXThCqgk3SUstxw5OWCzdqhQbN4jIgbX/fHkFiJ/lS0cp+HXkGmrfKUeY=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH7PR21MB3236.namprd21.prod.outlook.com (2603:10b6:510:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.6; Fri, 26 May
 2023 02:35:05 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6455.012; Fri, 26 May 2023
 02:35:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] x86/tdx: Fix one more load_unaligned_zeropad() issue
Thread-Topic: [PATCH 0/2] x86/tdx: Fix one more load_unaligned_zeropad() issue
Thread-Index: AQHZj1yNlxLZILZgE0eQSDdwpa7ZCa9r1INw
Date:   Fri, 26 May 2023 02:35:04 +0000
Message-ID: <SA1PR21MB13352E2075766916B0D675C0BF47A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2fa3e14d-0594-4887-93bf-d12fd697e2a0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-26T02:27:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH7PR21MB3236:EE_
x-ms-office365-filtering-correlation-id: 31173261-6a48-4786-954b-08db5d91d009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BljqAFDe0R2ifq9rLihU11XLAax8gJj7/2LhAAo0gTdf88xd5AeX18JpHdRUDpcIPs97/S+/IwIhZQGc+eQsxexTBFNPEEDppSc9PEb0MQzPZ5crlEUpR9XMQnbioDMI89Yi+s6SWQqSFlPCasEJVoA4AoZImpQ7Aa10um0zjVZLfTUgGXYwIrSOiuQDmLgvzIrC6QGUOw4tqP8cvs3L4xBC0OXA4+TXak/pmhYVNAb/nG38ZY5MTRSEKTL1mJJol7ebk/FOQY69P8Lfdp+iR2BdhUIuzQQErzQKtM6xLHWb3+/BVkjFRPFlpm+T5+PEialIfNyk60afiCj/b2X1ASD8GP0/KZtRqGniA96+XdPsPv/04IUsrF2pR3WCruEyB6DVUxxgQbiQ0dtdCO03eatHk5PDTU3/jRUhi1tiH9aL1zNlvqlgjBmr15eWb6On/xb7ayAV1k86i8+RnkwLhEjI5Yurt7S1TL5aeJDzMbBc2cz1RdDd5pH1+R00oxjWWuusEvFmmvI/iiApCm1u5SBUM9KLG3YSII8vb7eYe3/qYDZSry7iNad5bRi3LiuZO0JdMGtKMe/MMwA1X6r37PnIsYoktP43Tjx7F4tZ04zipCY3FjXyhZ0zXL9PIyNyWei99S6gBmxMEIFwJqjTangRoAEq4vEtLXhnubOzp5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(186003)(786003)(9686003)(33656002)(316002)(6506007)(26005)(7696005)(86362001)(4744005)(71200400001)(2906002)(8936002)(8676002)(55016003)(7416002)(52536014)(5660300002)(41300700001)(82960400001)(478600001)(54906003)(10290500003)(82950400001)(110136005)(38100700002)(122000001)(8990500004)(66476007)(64756008)(4326008)(66446008)(66946007)(76116006)(66556008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V/etnvEp/ZK45a4JZVgJ/EeP/fB8NF+PwBO8n7qm7JyEwpY7Wiu7ruB2NZvM?=
 =?us-ascii?Q?FOO41ILL4Nj7n7sR7fVjEPb3lyHZbIXxAGFId6W9kcNaiSlFfERN51bhA0bt?=
 =?us-ascii?Q?cKnVT2mMfVUiiIsWngEwa78GkutUmOrRnxgX6cwQ1nucNRK4tsNJlCtfoL2Y?=
 =?us-ascii?Q?Z/lkQ2tR08AkkejlwmObO4jGbS/8zEiQQeZ/xJdg5c+EsamYHpkj3xOLhPei?=
 =?us-ascii?Q?JNyfzBiPfMpZEnr2SrAdxsO5PkIB+h2B4nBnizSUPusYkd2mDqPUXx3iDMei?=
 =?us-ascii?Q?CxcGsxYc+nKQCxYyc6jIujiVGnw1VZzRDEpe9D6WDzVjaMinGSd7IasNlAV+?=
 =?us-ascii?Q?k8vuQFF8CfcyiIlee1NBlAs+5V0Aiz+I2Ykn8EJSi8Dk/fQihJTVqzmEVUzV?=
 =?us-ascii?Q?ERAr03kC7vogwdwrn9TwuriTvF/VsQg9+Jr5GksTWWB8rd0uRMMUSSSd4+/u?=
 =?us-ascii?Q?9CEX2c1x3lmC6AuTJEvl2UDm9oOmUVfMbfSgy5f5JwymG9lGhIFSo9Q1bUsa?=
 =?us-ascii?Q?Ct1f7jberiF3yQShJsfAOIj3RdDm5wM+IrRRXz7syA4VcwGyzRtRqYFgVr98?=
 =?us-ascii?Q?mJeyaR3kLbEdRRUs7wwX0C+1xrUfIPEJKq3cS8YzZlDTbLyRvI4a2+d5oAAq?=
 =?us-ascii?Q?nlqcQixUHShYPG+lm62Rb0+trEJIGx8ER3fmPV2K2X0tVuHB2cjR+0GbS+S7?=
 =?us-ascii?Q?qC8dcmo+l9mGjY/3IgRjsyaZgpf5csyqw/Z0TePvYFuWBwCFHAFj0Sk2D392?=
 =?us-ascii?Q?Gl1J+oljxeRHGkjXC83LakZuPZ/pRe5DejhrMaoKUv5R0ZrUrXzwG9kmFtPb?=
 =?us-ascii?Q?zUHwxioO3zNiPuZTmd87ae5C+Kk+gICfbarT9JX+oROs4GESOos7aRkXnjlj?=
 =?us-ascii?Q?3qii1cW7gQ5lQcKfGX88FIGkVmtQMsPE+kkLoEX7Wjn2OWsMkdGM6cEueYOn?=
 =?us-ascii?Q?QVTRtSfc17pn0UtDooFexkqVDLzguvEQjwFQmwyFmFt4EpidGF0biVsa9Akd?=
 =?us-ascii?Q?SUDtZmCmipwLQJfWeLjWpCkZ6DtIlwAZeqUIqaaWHsxlmThLETB3jxXchFKl?=
 =?us-ascii?Q?K2LwN2K5mLVajeCODiu2hWfapWWucAjxQ1w+K6cjQGBBuM6uziA7vOAARrl2?=
 =?us-ascii?Q?ZkIgDeojkJ/ldDgby9ib1meaZX+fMGM5jO36lvfn6Ah7bygZF+E9KazDf9LQ?=
 =?us-ascii?Q?vh7boVcWFoc6an1lqpzm1DMPSuQS4MSN91+M8cvfBJXRtOQaEkJ4el3KQQu5?=
 =?us-ascii?Q?u5oDAAZtTVttGsQ4URldodhJyVTMMqYkd83ojewCu3LKVw/A7xQ71ISc3mMq?=
 =?us-ascii?Q?NXYXiozQLGPLiCSxfkOh1UAZiTWauRG60A8XOmkf+vGNbEvEWeePpPyzyh/f?=
 =?us-ascii?Q?TKgfb4tQv2pmHFno8/zGGWDzkkFlRkaC2lHvWVYo3MaW63PnlNZJi0KEeCGT?=
 =?us-ascii?Q?njb2K0MKsdGH3X+m30CmnFcHfFCg41hObCZZEilPDC3VwJoLZjqw0XwxfQDr?=
 =?us-ascii?Q?5xbolSKsqNGcVNCZ/XSA0kTUus1MdFZeXNJ8MKzC5Ty6UCVi2Nn4lBEMPIE7?=
 =?us-ascii?Q?RgMX8JfIX308YQdDIljsiFK3ifjAAHvm3Zakz79D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31173261-6a48-4786-954b-08db5d91d009
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 02:35:04.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch0HHfqbcMTxFqmINpnfuBPeffCGvlOD08jK5eZIaO2ogQ1zhNpO4ayx6w3Jub3aw3zbFrgMcF6Kf8hk2BIoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Thursday, May 25, 2023 3:59 PM
>  ...
> During review of TDX guests on Hyper-V patchset Dave pointed to the
> potential race between changing page private/shared status and
> load_unaligned_zeropad().
>=20
> Fix the issue.

Hi Kirill, I tested the patches on Hyper-V, and didn't find any issue.

Thanks for the patches! It looks like the patches can address Dave's
concerns. I'll wait for your patches to go in first, and then I'll rebase
my patches.

Thanks,
Dexuan
