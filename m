Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02AF6C5918
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCVVyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCVVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:54:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2094.outbound.protection.outlook.com [40.107.243.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544733CF0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro877nRlI67rCBPHrXMVECaY3Dn7KKwz31vMH6fiDhXqYysiu1Q62tPlphIQ9Zf+FPAp+zekXfHn/Dgdu+wllpaM7QTg0TdCgbo0JAU1N8P0xZP3R+L/mti0mG1skcuClqDt5ALBm4yfKoWKGBiCZWXBbxv/Ea2pMAT7i0Gq+MYUQ5p8mqd5PU9qAiMDsw1gOlRhP5SpO4NmTVtCvzv96aPg4CDUPprDdP/IiCyisrOJDdWXABEAN9weQvThx6IM12YfwpXK+42HOKyJ+GXrc9DF7JHkBSYhGWvTly/yxtun9aXtt7dwxOKABwPwUE5b+db9V3YGXOvbRTVyqQ2I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Nx57JZUIKFE7zPRGD/9h8zVVYkOp9/CQXc6KyHtJtA=;
 b=LdAqj96dta3dLedvVflWT+ptb/FC8xgMOcsmDY6i0JFIxOXfF47ULISelh9soQYAkZbfMbomSLUHHp8ANT+qpQ1YQqTEZR2+9otF5KTUcFfwX5eUSNG+d5PnCP+q+8ecFopQFt4het+88FwR4oNL82kvYQ6GwONXoNIOY0fi3uo84xtve6l90WN3mE4u2XR8OMQYCwIrmBNSYIv7k1+53JykDd8Vx8dLiBlH43O1g8eyuoURZ3lMzqfgvY3BmT4Y2fOLO/JIjtIcgQop/MV+jWOe9b21KZ4gdedt6ex/G1sNfyoC8D17iUeHsGQCftzrOM6JMdayVSifquahqBibaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Nx57JZUIKFE7zPRGD/9h8zVVYkOp9/CQXc6KyHtJtA=;
 b=SXKIk3LnA08j33R0F74g1BGSNaT1TX9t7Iy0bqtsd7R8p6OAQuxBMGRHwBbegAha4tOYFx3PpF5EOIzm3nZeYgtegW/GhlcZeDDhCLh1qnbbdDlP6eQvgq63VpBi4ObVMW5+AaCTaaDFwsygwi/Lpvn/az+6UQGMjBcZ1tFe7HE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1437.namprd21.prod.outlook.com (2603:10b6:208:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.4; Wed, 22 Mar
 2023 21:53:58 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a%5]) with mapi id 15.20.6254.004; Wed, 22 Mar 2023
 21:53:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water mark
 in debugfs
Thread-Topic: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZSsqBAEWh9nqUUUmkQXhDk78K2q8Go2MAgABfLoCAAHbNkA==
Date:   Wed, 22 Mar 2023 21:53:58 +0000
Message-ID: <SA1PR21MB13358B4721F407781725B1F3BF869@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
 <SA1PR21MB1335022D514B2232953D43A9BF869@SA1PR21MB1335.namprd21.prod.outlook.com>
 <BYAPR21MB16887D69A1E3E2622E32224CD7869@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16887D69A1E3E2622E32224CD7869@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ac2d93b9-de41-41a3-a4f7-46e48cd0a71f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-22T08:58:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1437:EE_
x-ms-office365-filtering-correlation-id: 60eab73b-ee89-46f4-49b5-08db2b1ff0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZV3AsC6CnqK1ITxtV8CMzF4wDbMhM1D1vVjq6EFliMZj0smjPUnJNMi3ght2Q4kyvWSKVbN5u09NuBcSvkRVErJpD0uA+rjROHTah5WLMhH5hnWorf5EL5DU8HcmWdEQhZuhO7+atXTTEEZ8qjauxIDZD7JJ0CuLwdAm+yKHr4723DWi77eUtahMJigihKCKSLiwZzJZXFo1cRH0RM8+nji61cwT6aqZZnWIhSL0dnQaRe04YeC9GLxtSeZGrmUqluAxpPMJ3Ieq8pRGKYIdQs6xUNnD8eZowLjQBQkDO5ICDqooqXWKSaqd9SbloU8YXxDD2SQ4a7926PGifGQtFwAC1Z8+lo13fr9T63JyGwFIHq87Gsm7udLYI0RE7KvXiOTMbRAtjh+lfnu6iXUcbuR4RT28Wps24wL268+0Eyy1c8uSsQzdOXnKggIPAvSyqy2q13uEYRM6UNHh8aaZnNVCL55Q+Yw4CBgt4LNi6TK7j4MJkeOFn0nlyXwqzeLO2J5+ARVX3C7hySOJOeUakKZboJdBPnI1gCxzWHNzZPA8y6WBKrx+GAyBy3ThiwLwE6N6AlGUE8clASomH/7glEF6R8gMhYuRuTiEpAokuc/xkkF1OlhX0XEROIXhQpITZzzf8Jm1pH/rbKoD+yuLRg/lIWL7q+PkqRAypk05Wg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(55016003)(38100700002)(64756008)(86362001)(316002)(66556008)(186003)(9686003)(6506007)(26005)(71200400001)(83380400001)(5660300002)(4744005)(52536014)(8990500004)(8936002)(41300700001)(122000001)(7696005)(478600001)(10290500003)(82950400001)(110136005)(66446008)(66476007)(76116006)(2906002)(66946007)(8676002)(33656002)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RPj8jz3ExeQAPw1soXNMdNlqtFNT6xcxTHH151UtKTGbpcGTSIIZsiDWfy1u?=
 =?us-ascii?Q?SW2OfSm7DHY43Oau6x8uvCmV7wSpK9CGQGwUDOqAmuOMQfCaVLftgH03ur/U?=
 =?us-ascii?Q?p/3t4smJ4TDpEDOezc48NpafW13F9ea7/31e+vJRikfCb9clSFpQ10fct9rF?=
 =?us-ascii?Q?70rqrxHdCri1LPJ5GKpThtJPyEQzDk8hs7+lwFmjfwg8s9hX1PyRbCyZslsf?=
 =?us-ascii?Q?xtxvckURVjMCBZ2ZLlEmJITVK1RiqOxoBsT2corBEFAYQK1HrPmiEyXhmIkk?=
 =?us-ascii?Q?auAMqLBDTsviZA0LLzrzT4PRv7wjG+dhcX8y1h1F7oCgZDlprXXcCx7nPdWV?=
 =?us-ascii?Q?vnvLEQXuaODnPL7RcrqEqH5v2cbpzPmBNYcz7yLVhXkcbufpzKvbGw7y8OgF?=
 =?us-ascii?Q?Jrqg+RwMSpJGSR0N664WU2WONjdvLOxyddQh2WYW4747ybcrSN9cKXkKVQD/?=
 =?us-ascii?Q?uxL6seFWkZXqwPLk25pVLQPlGW5UeVeTWd05gkrFD5Rim6QWVvYJPQqigELb?=
 =?us-ascii?Q?yk/mO8DdkiWIjqpEmEzq/6GMCHSXhzzGigmQtx1eHevs4FuZcxLkEoie76Qw?=
 =?us-ascii?Q?y7nSp/GNr3yXJDwI7pyCXEz9/+rTytIow0YHg7wy3zXK0zl+Y7T3HdRQnZPk?=
 =?us-ascii?Q?K+RTpgUb8R88dD8qc0O7b/i5rW4fz36Ox96Gx9bGdkIaZGKwry7XycVB1uF2?=
 =?us-ascii?Q?fzXbvfsuI5FKYSzk0KFdDTxfQJ9oD8uZSQRRee8xHiFvuUj2z0s5MYYERRER?=
 =?us-ascii?Q?ojhPC/F4w2cUwTUYZ2qXLTXMlG9Bu5TISMQ87naYhtiq+OCIDQyQZDS0gJCv?=
 =?us-ascii?Q?xyA+x6FO+K0HJ2nKQncPe7BglJBDsArG7MdGWjaWALb3t7YEzmBEBsUaZ7iA?=
 =?us-ascii?Q?YbphOAxKaxKAq1vfigPJP6AYJYxduQl678btmjKhD7b1vuq/bIygknKcChtP?=
 =?us-ascii?Q?NosNDT3eAWOGDJvihxaU3MZNC86pWcyHgQ6xB9P40g97PMzH8Kqx9iAcfXfg?=
 =?us-ascii?Q?9WoJlTjgMXxUHO/Tfe2ebGa6zSeqN2g6K8NSyx1LPAudl4E66Lg/sk+w6NZE?=
 =?us-ascii?Q?Tvo0pGqW9e3HAPPJHRW7bJqzCrRS6UeRlD1k0FaJcKDbERy2R2RUpmrKVilv?=
 =?us-ascii?Q?RWhdVIMNjeKEz/UhDZpMGgdSlP76Sij9wpRr9QXggcbrc1oaMYFdV8n1gXla?=
 =?us-ascii?Q?UzAeAjBPKmeTRfSFsqsk2hcQdRVinOkAHWZptQ280FAIr0F2UtKO4+ju5fiO?=
 =?us-ascii?Q?ujs6Bs1aRsM6Woj/9W45bAdggMz6jrLA/clFO5gCRyC3MrkRTd0MJ12loB11?=
 =?us-ascii?Q?3BVADArp0k5sYiC90IeGG88zFoKSbfdgmDPdrVTomN+Z6XgtnIusNSNLzU2s?=
 =?us-ascii?Q?RhcuTlgExvWlTLYMZJCApvHiveUp2S/NNEm4RhfBSYR5meEGVlDPLsm2+dfL?=
 =?us-ascii?Q?3/GhFa6k2yCe8Mol+j6kA+bjysXMfFEZXpVkg0x0EaJQLXUHlRew8XOLALaV?=
 =?us-ascii?Q?k+C/QQ7yLZ/NjgAiaQvO3bSk+1fWk3XtFbGeT3uYUGQaBd/WETKUmQYGKXHA?=
 =?us-ascii?Q?cg3FpH6f6FOjSOkKjIcrknJhsWPVvu4Rjzd/wczy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eab73b-ee89-46f4-49b5-08db2b1ff0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 21:53:58.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEnI+J8J8RmAbbLbg2YL+f4m919S3BPaZijcK5c/2D4PuewKaGf4BHjtS/2h7spHjkLAnzQHHk9wMcD94MEh7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1437
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Wednesday, March 22, 2023 7:39 AM
> > >  ...
> > > +	new_used =3D atomic_long_add_return(nslots, &total_used);
> > > +	old_hiwater =3D atomic_long_read(&used_hiwater);
> > > +	do {
> > > +		if (new_used <=3D old_hiwater)
> > > +			break;
> > > +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater,
> new_used));
> >
> > Here 'old_hiwater' is not updated in the loop, which looks suspicious t=
o me.
>=20
> Actually, it *is* updated in the loop. The atomic_long_try_cmpxchg()
> function updates old_hiwater to the current value if the exchange
> fails.

Yes, you're correct. Thanks for the explanation!
