Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACB6CC04D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjC1NMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjC1NMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:12:32 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C583EA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYkP40/xkjbTaO51134DNBSRXXLV5dCxoukachduhmsO4iBVsV11f1LJ/OlhWv8+omzp+pohLh0wWPleKI8AIobVT2BHENFRsHrOwFj6gxbNxaewpF09a/rW2l+v3MulcBN+SEdygbNsGaMDFHefQAg7MHQqi9BVY9QEEe89Kj8lqEnlbJM8Bq8Mr8yY21KrN5uPLjqeamlr4s4NWvWe1qhfFkKf5pufioYZO5yGFU3ILlPR+2AJIvrqNbZSAbUUAjsqDZUxw8tK2x87De8VY0XiMzgZ4msfQvcgfHzYVjOrgw+7P+HYzMj+tRxh/3HtD0PmUgecCvODyMx5/R0mSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqusIBji0p4iqpVlYJvLk1RLC13ltJdakU8QcW3YChs=;
 b=at8k5qZESbrvsRj/ZSBR4ekdkkS2R2yiOB3BqFT2m5BJIRDHbgwRfJtUMd3a66PVpSaR1xmeKFpKHj9VP7B5tHK5htqw52RAfoHO8tlrKtj6ORw5D9qn8j2L9tnQBFfTXvLTjayhNjZvBpM+GDFWSrXa71Ag4HaKupNhLtQJ9kyP3tAzUSyAcvjB86UVU9GOYVmKXUU/bPcaKc9L3QBjjtbXRvZO6msgoBWfW3y2hymbW5pIovqf5EdlkyL1uB9u3BmGsS/47TsrTLVIANK9940nfkRZxXEN+zBfhJoOGFuFIhPf8YvRu04LS1O5dJtfIOq18uAwTq9GGBDjHcDrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqusIBji0p4iqpVlYJvLk1RLC13ltJdakU8QcW3YChs=;
 b=Q+kH/oBVShXEzKxopJfgFwbaSMJhy0x3KHgxETXaBkS0AEagITXFmWYb5MWbZ+Q4cW4eHnhE80scYq8kTvZOJ7P758mHclkUi/UZekAXB4lfkCecEUO0Mb6Z/m7lY9o3J2U1pFiTBP3PQVdm2JclwEoxQbaHslnFcfd0IbJ6DPY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.7; Tue, 28 Mar
 2023 13:12:14 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6277.006; Tue, 28 Mar 2023
 13:12:14 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZX0LG5qMB8+ZzCUqrEQruwKd8m68PbDKAgAC/CxA=
Date:   Tue, 28 Mar 2023 13:12:13 +0000
Message-ID: <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
 <ZCJEAx/G0x6zokPF@infradead.org>
In-Reply-To: <ZCJEAx/G0x6zokPF@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c645c878-e33f-4df7-aacc-9159c2a6a91b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-28T12:57:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1890:EE_
x-ms-office365-filtering-correlation-id: c8408504-6d16-42e4-0dbe-08db2f8e0c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMXfVyzsQ+Y0QsmYK3FGu3lTyTV7yAFM1H05lDi0edqsMtXyMF7Yz58abB0EvMHA09A3F/Nwb88MoyY0zb5eph5Z38iwZwMMyFyZBM55VXB4eiZWWTC8rYHaGHmiI0XESKn4/Yv/Ly3l6UCrJEgBiEhAyY+cou3srQmBMx3t8M4fWSv1Co2aFGRRwsFqbOOpmlQcwkK69q/T6GiQVVipgM6NW2uW3WIqK4sDr1uTx2laDib+qahaJwEAbAD/3JgqhUZ74ALHtZyfKZYSOTaiUOJI4dtd1NZC2fNE9a7l7d2O/ZErEWrVcQ9Vf6wnzmqzsj+mPxnqo7xFLyUdKQO11t5iKCl8gNpGoA0CzgYl5VS2XaNvGjYe5SdWjw3O6A2pLbLu2UUNKSmOU6HNNGPGpmF1JQ+hRiz3l/htPFPI5JsIUTwc08GpBbWXL4eXO16G8a2oV7dKeO9Z7fMBYaHK7svcPjvD+2ZhOjaQCBswiVzEAIOglP/q8TE6QM7mIenOLEdT04ZnetCDUGXx3FTU0eqSpNMY6ouPOw48mOQbPhXYVng2q4rG4slbkPz3NnVoBSF+8o1IGBdVqVIuqy3stdrxlrrAJuPyVgrCIeEKmYx0w98SQE/l+WIMpMXZ49WXoCB3FwKnwZq+wUmQsieBW3wAYvF/BgBOd2mEl9im8Fs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(478600001)(54906003)(10290500003)(316002)(9686003)(6506007)(26005)(186003)(6916009)(4326008)(66476007)(8676002)(66446008)(64756008)(66946007)(76116006)(66556008)(2906002)(41300700001)(83380400001)(82960400001)(82950400001)(8990500004)(38100700002)(122000001)(38070700005)(86362001)(71200400001)(7696005)(33656002)(55016003)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?chsdtW5lbjIyxihFOqmuBGzFzE4DRa92O0mzJGN8/e9CdhPPjbK55FLsPx7O?=
 =?us-ascii?Q?AzdpjKsl+zcw7NbN4GlPM/r65Imt7+UmxzvmLiRkITXnMEIWQLoS3XlAMyRI?=
 =?us-ascii?Q?NHQbDiWrGRl0D9NF6N34BoHTFGHVoHRI+bkPh+ze7OjsgLgNC/RGHapjHSaj?=
 =?us-ascii?Q?O2LcHWWDYpGtVCIsDKgihci00M8eW5dNweuqONzbMCzXg0YyjZYwhBkpEUUs?=
 =?us-ascii?Q?Wz1DlYrA5PhYbKYTyY8uL/YrtTfsrZ5d0eIXYXxZBaaCN+lLiFFdQoFiUe43?=
 =?us-ascii?Q?Y0Zw1zbVlTW8wksHRUwlWvY2qPW/5NAuDS37F5aqC5Xm9d4vxW+Ml6xvvR9s?=
 =?us-ascii?Q?WrJPUI6peRLpDi9f63j0ELxXQExblERL8hqIbZiK24bNHxke/79lbxo+L45Q?=
 =?us-ascii?Q?JolJ3HwzUN63Jmxj7lqmDVp5YoErxy/N53k+PdGmbFdI5+7a5Z3XYu1R4Nk/?=
 =?us-ascii?Q?9fg4pgptSiYKjCc4jiE8gwYShf/0rbtZPHaFTgTEA56rI4Sh22r+cGeUvRWY?=
 =?us-ascii?Q?1CjcstFMQojwPXDexUitj7eWY2cj88v08L7kn+RybfE2vZ3Da0yr/14J4lb/?=
 =?us-ascii?Q?safcjAf8b3G0CjB2udxLqG9bhzuN5Fc8l0mwkjeILg1RekKY81QvUZwpA0SY?=
 =?us-ascii?Q?bHsFjYVoEhvGNpQDYz/perbtbiBd1cn3hRNa9rkkJ7msoGMTGbFhxSw74eHi?=
 =?us-ascii?Q?9mI+pDLSDNzH3IAdaePutXuRH+IKHb4cBzzr2ewf+A9e+DkRa3C0VD8JMFRN?=
 =?us-ascii?Q?xqQCVV0PGN/+5t77Uv2y8nFUn2fWuvIH8T/nSTLLPkAVNQkwJh24mqF0rJEj?=
 =?us-ascii?Q?qwCREtEpZnTerssprouAkVvO19ThSHCIpUuV88ew2g1OmWBAHPhZ5xzsHltJ?=
 =?us-ascii?Q?dNVH+Aa/BVRUeo+Z1H84VVN1dTUlWw/tDjr5DBM3OPRRpvSxJIcrbkWE2W7n?=
 =?us-ascii?Q?+t46fvhkYH62YGwPQ5r2RCbeRflb1dlpvdm+8TQoaeGF92325RfSB5KGyzOg?=
 =?us-ascii?Q?FBRVRmJUdmbEhHqJPI0Zxz30dTvDE9OBzA5IIPIeG0qYSx+rWILo+faBei0b?=
 =?us-ascii?Q?dvp/yBT0qMaxOhcJzgulvyCApMyKOsoJbQY6LFFaGZ74eDI0sOh18eivQoxl?=
 =?us-ascii?Q?QNJjU4PqXpDTRxCzn2vtpwj2GXOWNEZwZO+2PW0e2p3vuwhjaLtluwVfthhz?=
 =?us-ascii?Q?1u+logFuCg024TKmaQCMFpgpGoj/d09Em1BwdPY80ZRI1fPSmHQpw1yxOLB8?=
 =?us-ascii?Q?GpqQXGXs+qfbIeAuLf0rRawxl3Bh5udWAA0SFphcM8iSP6TBPQamiT1ePgt4?=
 =?us-ascii?Q?yKGMvEC/F0H/aZoDcv0vvn/V4k3iJKPLghtrLWs7UGo/ZRG2JxORa/PLh+fb?=
 =?us-ascii?Q?6nHeSpR7WQe5/UFWUzj+4Qv7rQQjyJRt+XOzWyR2Ks0wvrGJjdrKtWeO8SGH?=
 =?us-ascii?Q?enVjcoaWjz6BRq6CR4ZbMXZE6xBiAkjb7q7jlqr6bzte0Vvd82n6tEi1Lu5G?=
 =?us-ascii?Q?4TiZ8rDGSTQqBxEw8JvEiIV7Nux7ux6jijZ1IbzcrNh4K3smzoqf7bTLPEEH?=
 =?us-ascii?Q?Xz3LrA0wK4YMkOYjaT+kZ8n52Fh1edmf3qXxEsOcadoS0Oo4MhCCPxivBDsL?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8408504-6d16-42e4-0dbe-08db2f8e0c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 13:12:13.9167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NF9HWBuqERTq2cLJ/dYU+9HJ4aDrAw5KrHxhTILs286fjcAGyO3nvlP3StAumSQGtndC15fMM8sfTpxCGIzmQyoVi6oW0d4z67EgLPur+/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org> Sent: Monday, March 27, 2023 6:=
34 PM
>=20
> On Sat, Mar 25, 2023 at 10:53:10AM -0700, Michael Kelley wrote:
> > @@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct device *de=
v, int
> area_index,
> >  	area->index =3D wrap_area_index(mem, index + nslots);
> >  	area->used +=3D nslots;
> >  	spin_unlock_irqrestore(&area->lock, flags);
> > +
> > +	new_used =3D atomic_long_add_return(nslots, &total_used);
> > +	old_hiwater =3D atomic_long_read(&used_hiwater);
> > +	do {
> > +		if (new_used <=3D old_hiwater)
> > +			break;
> > +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, new_us=
ed));
> > +
> >  	return slot_index;
>=20
> Hmm, so we're right in the swiotlb hot path here and add two new global
> atomics?

It's only one global atomic, except when the high water mark needs to be
bumped.  That results in an initial transient of doing the second global
atomic, but then it won't be done unless there's a spike in usage or the
high water mark is manually reset to zero.  Of course, there's a similar
global atomic subtract when the slots are released.

Perhaps this accounting should go under #ifdef CONFIG_DEBUGFS?  Or
even add a swiotlb-specific debugfs config option to cover all the swiotlb
debugfs code.  From Petr Tesarik's earlier comments, it sounds like there
is interest in additional accounting, such as for fragmentation.

>=20
> >  static int io_tlb_used_get(void *data, u64 *val)
> >  {
> > -	*val =3D mem_used(&io_tlb_default_mem);
> > +	*val =3D (u64)atomic_long_read(&total_used);
> >  	return 0;
> >  }
> > +
> > +static int io_tlb_hiwater_get(void *data, u64 *val)
> > +{
> > +	*val =3D (u64)atomic_long_read(&used_hiwater);
>=20
> I can't see how these casts would be needed.

OK.  Will drop the casts in the next version.

Michael
