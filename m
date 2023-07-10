Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3774DEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGJUH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjGJUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:07:23 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC71AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1689019596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rgdk/r6XdO85KbntikTSpp20NjxhIyIreyOl5vCo5s=;
        b=G9Vo8ou1TSMv7xNiaJHPst4pDWcvhnR7+5R3r1DLtapm2cncDh5ato5elGCM+37oVnEX+7
        RH4Me9h2ZI+uHjtV6xXEta3PZpT0Dfr0xfk/6K2YFc8hRTy/t0r/m1QfNDE7ZqFH+YuF6H
        ouV8Exc2Z0RVgWoIjnJXybnGWElOpcA=
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-8jGqVniMPqmFV7Sd1jR1Lw-1; Mon, 10 Jul 2023 16:06:35 -0400
X-MC-Unique: 8jGqVniMPqmFV7Sd1jR1Lw-1
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by DM4PR84MB1520.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 20:06:32 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bcb9:9775:e9e1:6ad6]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bcb9:9775:e9e1:6ad6%4]) with mapi id 15.20.6565.019; Mon, 10 Jul 2023
 20:06:32 +0000
From:   "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Eniac" <eniac-xw.zhang@hp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Add suspend quirk for HP mt645 thin client
Thread-Topic: [PATCH] nvme-pci: Add suspend quirk for HP mt645 thin client
Thread-Index: AQHZsDSpW9dmdvvloUauu2B4hhj7FK+vSP4AgAQoq5k=
Date:   Mon, 10 Jul 2023 20:06:32 +0000
Message-ID: <SJ0PR84MB2088ABC543710226BB8889DC8F30A@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230706180653.761247-1-alexandru.gagniuc@hp.com>
 <47378415-b5ac-77ae-3cf9-01030a0c24f0@amd.com>
In-Reply-To: <47378415-b5ac-77ae-3cf9-01030a0c24f0@amd.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|DM4PR84MB1520:EE_
x-ms-office365-filtering-correlation-id: 351ca126-ff3c-47aa-7711-08db818127d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: EDCsITTX6CqJnKZSgf5K1JItUTxLhcqP5FxNCuNHxObxIdYBfd0x4zcdPzG5PHnPDN6XX9kSZ/szbRai9q+zLR6s+FFm5+bNXzhvhsIR883JZFUaB//kzzC0e2FesOoWX/JNfcBxhQM7015roGZ0PFxLYy4mn+SuI++DRyTqIZrTarwjjoXSBYRjIQho+fiDVc1x39xmQFL1UFQZrUnhFwmCc3iMi1w4o/2HzDKa3b+hhUCG5QSn7prHjsxSONIS4YRE53GSZKPFE2rFjn2eim36QBbKh+n6nkxHsXAi15nk0QUqpT0ET5seO9OVlSe607FlNWhui2K5REPkpDdm15pGzLKI7E/j/qWUYFOHr3XGtLTmcFN1YIMx3YLT8fNQBXEMFiJchVC5sXcX9JzuV1gkOQtaLckdF/FG37VcTuwy8BQCrQrh3YWGFQDbysLgD1BcoQPTjnt5dAEarLc8JpcVqQcFxvg+E5PgqaXbw4+m1Q27rjq8x+K2meQ6MTt6XPMfIocKyrKG/Iv7nmllEWq4jqNJPsOXsgUGyFNovRs1nVMEh3OF0bn3HKhelTwbuKHjfzPUiWCQU9TNzU2btgxMq8wEhsYehXOpBZswlToJoh6O55njuycJaRu78cNpYXvfuYIeI4AY/2w/9XEx7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(8676002)(8936002)(5660300002)(83380400001)(41300700001)(316002)(122000001)(91956017)(4326008)(76116006)(15650500001)(52536014)(66476007)(66556008)(66446008)(66946007)(64756008)(38100700002)(82960400001)(2906002)(55016003)(966005)(71200400001)(54906003)(110136005)(26005)(186003)(6506007)(478600001)(53546011)(86362001)(7696005)(33656002)(9686003)(38070700005)(586874003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IwGYNafiN5WdAjl8+9bcU3+AS7jVJPZocCiyNYmB3oowsi14Bz6lJIqwEp?=
 =?iso-8859-1?Q?3Gd0rm6ygK60F6JcXHAL3FNgkFrwuXQd9MJ+9Eb1eRsY+6R7i/PRnoscGs?=
 =?iso-8859-1?Q?Bx1TQmg9o0gXPpERUu4GhVG/1vWYRTWaUGHHVPsgFiX7YVfNE4JcWcReI+?=
 =?iso-8859-1?Q?xu+5oAejs1ZJ2ghDTmqFpXAtgc5KQjaxCBLy/eH9Q75ORUqcKCHpI34il8?=
 =?iso-8859-1?Q?BSPPIai5kg7rmjpCLYFfDsBLokGC7+yRBscGUT8G/C6c6Kwobx+ewoErCr?=
 =?iso-8859-1?Q?ETKjcerbqK/TApf1wvb/pBU6R7SB44lhnDx6C1uX2mJ+RrwzKe2/H7Ww+9?=
 =?iso-8859-1?Q?sKBKKn8bJH2qGug3JqRj0I+OmR+gSmq9Gju+bHQ/uDOJOr8K7syiiAfBST?=
 =?iso-8859-1?Q?33IfGTHhaWUfPNFDnTsV1PTDtEVIUJ1nQ7M4spMNzCTuycIJcr4Y997BhR?=
 =?iso-8859-1?Q?21t0wqQnuDy/naxlxRNpBYn7B+n56f6OiWWy+VshdNAdO7YATGerHQJ+zg?=
 =?iso-8859-1?Q?yH8LqOXUNVdp3zSWQ8YjhDKykPUfRMaPs2c44Ofa1umYQZBJeNHQEBcnem?=
 =?iso-8859-1?Q?8Bbuao+GSqMwK86C04bSmrTCSFprsMhgTtyn/wnXxJ7xy6PzkwQXJWaWx0?=
 =?iso-8859-1?Q?jVq3toT2RvwapjPAv2KGdY9pRJUe/8hv0zaYBgOdmSDFXXnayIP2/QJ7zi?=
 =?iso-8859-1?Q?/IacuX/iIIQzn1MoFbSboS9IS4/0/IoRiJ0C8qNPW7QSYky6Q+IzkHQon5?=
 =?iso-8859-1?Q?ZCtZozDECKYuF/xObin9PBUR8cB2+PHxjv/ZsuEkfYm3mShvIYhQH/XO7k?=
 =?iso-8859-1?Q?xKHZ7ENQsrGHTW98g+xSBKR0aokexW6GMBLwAKXATJvkgcGzZETlITkHwJ?=
 =?iso-8859-1?Q?8lliFbaELM05XMsPqKnEJTEdEPeXVH0cOStHbCEAKVwyruY6gbvfxf7bOs?=
 =?iso-8859-1?Q?V7B4y+CeiBXedU3dqCjr5H/kUU0mpKTd+zD9w83+eN9JiGPA15W31t8kl0?=
 =?iso-8859-1?Q?wrLJERggFh/+gNp11je30ozLkq0d0IKQpTi9tiJvA6HOCCPJvxoFpCHBsa?=
 =?iso-8859-1?Q?shjjWdti1rH0cY21lq8wMl0OkmQNCRlF4XND/3hRU4DOvto6lcESuzpqqY?=
 =?iso-8859-1?Q?oy3J4aTFiJTYMZuSAXsjAxGckj+iKmhkGvIKbSZQ04l9igvRmGFrGAkE4w?=
 =?iso-8859-1?Q?30jkkr2qev9z6fg1bv9DtM0wnp9jbD1YAVnkc/OeC6nlllC2vMD0KUqm/A?=
 =?iso-8859-1?Q?skwFAgR001BIC2T7Bb1ITDLZQoK1t3uuODuQYQakUEzvtGKaPwz9jkO/97?=
 =?iso-8859-1?Q?8XBIqtV0QmfYDA3IBQXMAKwu05dYlr9ZJl/fboqeQ4ZH6f7MYrVvIcvBZf?=
 =?iso-8859-1?Q?56DlgJmTg7PTnNhScUVQAXgMsbDNG2EdcCSz/Mh0mYhKgbBCfvm5nocn76?=
 =?iso-8859-1?Q?2J9Y7UC+RhIxzzoFsdZVwpsnXgmFLZFrO1unoYbMN8KOBIE/vyRVDb+e0x?=
 =?iso-8859-1?Q?XO/8cmAc4/bYtl676kOTgxF+oi+ggk3qTmJFVtjAFWl+SN4/6wkGf+WOOG?=
 =?iso-8859-1?Q?zpRHB1q7LS5m2nLgMHK99VEhfyeLKP2kwYfVVipwyEgTkggxyjUfucOLnH?=
 =?iso-8859-1?Q?7iXEoF5j+EGB9PBGLZVyJ3FsDdM/UX5FRT?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 351ca126-ff3c-47aa-7711-08db818127d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 20:06:32.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwpipGWgVF2dS9I3bI4omns1SHSPHvnIdHe/MzOK3sOymFcTl9FmMd/JsDy4Yp8njSiWxM2iNrehQo2EMQDfwLzMuufoYbmTMBY7mgLoNk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1520
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=0A________________________________________=0AFrom: Limonciello, Mario <=
mario.limonciello@amd.com>=0ASent: Friday, July 7, 2023 11:28 PM=0ATo: Gagn=
iuc, Alexandru; linux-nvme@lists.infradead.org=0ACc: kbusch@kernel.org; axb=
oe@fb.com; hch@lst.de; sagi@grimberg.me; linux-kernel@vger.kernel.org; Zhan=
g, Eniac; stable@vger.kernel.org=0ASubject: Re: [PATCH] nvme-pci: Add suspe=
nd quirk for HP mt645 thin client=0A=0ACAUTION: External Email=0A=0AOn 7/6/=
2023 1:06 PM, Alexandru Gagniuc wrote:=0A> The HP Elite mt645 thin client e=
xhibits resume times of over one=0A> minute when using the normal nvme resu=
me path.=0A=0AIs this the specific product you're referring to?=0A=0Ahttps:=
//www.amd.com/system/files/documents/hp-elite-mt645-g7-mobile-thin-client.p=
df<https://www.amd.com/system/files/documents/hp-elite-mt645-g7-mobile-thin=
-client.pdf>=0A=0A> BIOS has tried to work=0A> around this by setting the "=
StorageD3Enable" ACPI property, but only=0A> if it detected the "Linux-HPI-=
Hybrid-Graphics" _OSI() flag. This flag=0A> does not exist, so the BIOS wor=
karound can't work.=0A>=0A> Instead, just set NVME_QUIRK_SIMPLE_SUSPEND whe=
n running on an mt645.=0A> The DMI_PRODUCT_NAME cannot be used because this=
 string can be changed=0A> in the field. Match against DMI_BOARD_NAME, whic=
h should be immutable.=0AI'm quite confused why this is necessary. =A0If th=
e product link=0AI sent above is correct, this is an AMD Barcelo APU.=0A=0A=
Cezanne and Barcelo report as the exact same X86 model.=0A=0ACezanne will a=
lready always identify as simple=0Asuspend due to bugs that were reported o=
n some other machines.=0AIt's been this way since kernel 6.3-rc1.=0A=0Ae2a5=
6364485e ("ACPI: x86: utils: Add Cezanne to the list for forcing=0AStorageD=
3Enable")=0A[snip]=0A=0AHi Mario,=0A=0AThe product link you posted is corre=
ct. I was not aware of e2a56364485e=0Awhen I developed the fix herein befor=
e v6.3. After some quick testing, I can=0Aconfirm that e2a56364485e solves =
the original issue.=0A=0AWe do not need this patch then.=0A=0AThank you,=0A=
Alex=0A

