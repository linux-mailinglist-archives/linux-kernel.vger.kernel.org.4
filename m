Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762C6DFCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDLRan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:30:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2120.outbound.protection.outlook.com [40.107.243.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC05A3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfcBRYqLEOQ8ZrgGdbaj9euKStP5z2z5qhlI8kx10CiR9YZsl784tQ09OnfEl0hn16w8iPhpT1hch2Lg6x3y0XFf+g62MQ/hZcdwKSS+HtMzUZzODjIhIw3Ig4CCFg1xfyKGmk5aJOaAE688+SGJm1FW5EqG3tI5VfHLEddgBuHBuObaMYlgjXhs1TzPymPsolbIaae5dwtpK77fT2bu6YOtgyIGm6SvMH146nngxRweY2WDGVycjeeWHh1IFf0MpsWjGWZloL/NvwD0k0/Oa0N7b9pHezytZM5gDhrcfOfB39IwJiA1ffudWprKpH1dYGSRLrUfTMjzpv0gTEYGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voQFpguS1GQvNw5r26iCA9U4GXeq1HKkqHmT/Po6ik4=;
 b=i2VOCBQwy2QnhB2i8Z2phzNXmZKsUEHiiAEedUOkIXm4LUQm/D0C+0PSRCOXkuqlrad/cFhWf9pv5hdB368eO3N09SPkG2rRD1W6DlUwkk57UEUMD8MjSmv9Q18x7C50nSvgPscMW+ZFHGBfvFRMKEM6upd478CbX4my+tm4iH50nHI+GD5JaLQzSbLY4hvdby2aXYwipy4RmR2u1eDESoPcIWk5WNZ1jSyrBqvdQAYSlVZp3iLMy6QTwR5BoJfrXcYQsr4Gb8eMFZVaxcOkVRoeCnleW+zVilPLNNRBK49PHL1DoFv0IWxlubd7I7ISZgRnZ0LbaFFg74lr9gz0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voQFpguS1GQvNw5r26iCA9U4GXeq1HKkqHmT/Po6ik4=;
 b=hTTRLAW1P9K+l5aXkV+vlxgz4Y5rtXqBsnDbrMXiJ1fTmvGreWuX2Qthqtxd8MuhYa1gh9oVR62jbD8bI59vqiVmxlOAajd07MJxFBiqAUu8J5JdjDmV1RSnjtcd9ztN//HWTKUVGRYckpWDXhobJW/ZiQ3hLmrH4JdO/7RWix4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1467.namprd21.prod.outlook.com (2603:10b6:5:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Wed, 12 Apr
 2023 17:30:37 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.004; Wed, 12 Apr 2023
 17:30:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZZFTgGkCO6sw65k+irtwUSCAKHq8ftkyAgAC5/sCABRYVgIACd8OA
Date:   Wed, 12 Apr 2023 17:30:37 +0000
Message-ID: <BYAPR21MB1688718645F8B19682E93552D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
 <20230407125535.476350d4@meshulam.tesarici.cz>
 <BYAPR21MB168877F6B7BF005B91F9E8CED7969@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230411034137.GB15679@lst.de>
In-Reply-To: <20230411034137.GB15679@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a0591e64-81a2-43ef-9cb8-26b75027a883;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T17:22:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1467:EE_
x-ms-office365-filtering-correlation-id: 44198012-1834-4a7e-051e-08db3b7ba0fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mb51A/Hx7NyYPp7KyooFhVFr4+RNFQXNBHTYMy2MmgZWpVXDEffHCnT6c57KgU/NgLxQ/MVETNgN15A7E7YolNCTAhCL9aCqWKIk3tqHAQfyvbllrFl1MkxrBCsyZkYfZZqVGnzFdETFFjAa7q1L3fVsXHrkIOAtG72q60PQMPvIbUu6UAsmzHuNCjFCzkmIBBeVdA7soUU/34p9NA5q7Yc3X7AnTaTrQRJ8d7x/DBhxu0d9JfkrjAqFDFNLLjHxuNA0xx5Ko8gh4j41ZI48P2S9lLB02pP1tnyh02KF5cXrmbphnMRtDg4ge/hCzJ0fpaTDSmKcBcFI5bPZ+fI12BEBcNn4SwzicbdXweJXeHEPXkar2YtewHtoROvzJph3aF6bCNgIkbpDTpp9Yeb7jhvI3yuXZ4fXdS8Wh/lhgo6JXnS3lB6CNMSc4nWjPKwfULsuQBVM9PTRr86+dq77LJQ0UzwfBQSBhLRTF7z1sSOdJsA+UJlHeyg/LUZIduER9gX0Pjb6672tPK9ERb9VyG6ggGdQsv2Qy5COGYVteEPZlLHqJXZ8LRR2xUdll5YJBT0DQpYLoraAF3J+FAid5neGX3h96L4LdNLu+dw+EtPg6l9J93Zhg5zO8ULsSiGOjjiCoNBKXPmv6ejSTrYI80eTnDtB4S9OHyqwAUPTy50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(33656002)(52536014)(8936002)(5660300002)(122000001)(6916009)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(66556008)(82960400001)(82950400001)(38100700002)(41300700001)(55016003)(8990500004)(2906002)(38070700005)(6506007)(26005)(9686003)(86362001)(7696005)(71200400001)(83380400001)(186003)(786003)(316002)(54906003)(76116006)(10290500003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?mgsdCvAllkFhNjmJT8fmY2vj4AIPpKk9gW7r9iQqK7A7sVg1r+wG0wtgfX?=
 =?iso-8859-2?Q?hHLLTuyTV160IdyDom3ZTSEvmDh+7p0cImHyfjRickjnuwioPPTAcH5YEc?=
 =?iso-8859-2?Q?odmliZrVDijn4JP/Kh4r3XaFyqZMByZUjr5TT6FcYfhBEUjwbftKAgiVfa?=
 =?iso-8859-2?Q?wSswoHVxsg5J91cy3/lV+aAvAg9Tx4Qx3pJjyn4rSQXtplQCfhZg9WXeE4?=
 =?iso-8859-2?Q?5G6AN0nNm+jTmzqQMdf6xPN7Y8kKtcOAN98uC7PS+7e2wjQ3TdDRs2Pxp2?=
 =?iso-8859-2?Q?TOYPnYSVWEcDmBIzIsA3+PIqb1RP0Ujf1+GaUeiRLKAEsdIzqesckdzGSb?=
 =?iso-8859-2?Q?Id0AsFvsowjSTJuaZ/WQtbZskvVDYHRIVpApLEVbWt/AjOyYIb0SqQ/ErU?=
 =?iso-8859-2?Q?LgHN6epQeaCqexZgtG6VCRLRecDQQ5nz26gvgF7eh5qkjOvbJk22E3SLMe?=
 =?iso-8859-2?Q?M5/Il63rsHekEF2HAMTAGFbC+ppMpIjFPDYIXwjd5QaLAomZrWzdKbjSKw?=
 =?iso-8859-2?Q?zjMmOoa1FQXdU2S2s6frnqsVJhdYwctDiBJCfribjJruskNKucNCqoiF4X?=
 =?iso-8859-2?Q?4Knv4RUW2KcNEo3YV1Kks5k6wOSb3OELpaMD6nP9x7tLRBLprOdtjNf7kf?=
 =?iso-8859-2?Q?qR4Cg3tpcYtFxts73W3MvJAsRFJZhiFj0JTxWpFRZqsIwH1UozY1XQC3hS?=
 =?iso-8859-2?Q?NR0HkmTbDxKXiXRr1JLj+h6/W+m4vMwaPCQs1a8kmDXGIasbEH57v9o6v/?=
 =?iso-8859-2?Q?vx1CiIkOTVZmSVXTyLO8ABqLsoELYx1zy0LYWYYJrNmeBTZJ26A3m9kY7m?=
 =?iso-8859-2?Q?ymab2yRxF7fQsK/iakCV7sXPsNIap/XcvhagSfIl0iTV25xWohlFZeVZ76?=
 =?iso-8859-2?Q?9GOAAKK45F0872VpGsgYWrAlX1QFU7kv7NOTFHGK+xMXwU6leYAtW62/Yq?=
 =?iso-8859-2?Q?Av7aVH5RzYUQ/AhQYOyfQyZbozi7HiZj60pH5mZcPdEIGY1X2y3i8/Ipbb?=
 =?iso-8859-2?Q?HnrI2oR7XU1/IIKRM83vP0eRAWhYk2SNbkoFFt4Dr7nmWIi/78bXKVYofz?=
 =?iso-8859-2?Q?zxMuwNrEAp0hMVR+cmch/fpMHKUNQKwCOqbeSrlRb9d6yfGYHNHPEHlOa9?=
 =?iso-8859-2?Q?OGI8xZhP3SAreIRaw6RH9x2K7GTYKdQ6p6i2WTqUjnEq1ti2BcE+9oHAF7?=
 =?iso-8859-2?Q?F/BJQcLD66N3ute2HcCU76YppkikTrcZ0ujWypBNZcR/twPpriyQzxxLbD?=
 =?iso-8859-2?Q?hn6EivQv7QaGBV7NMfTqA9Efi8+/YfHGoLNAnOolzOPjgh5kA8bM76kZ4P?=
 =?iso-8859-2?Q?+YCK6gvGFAQco4Ze5saP42/s8uIh6MKvF9nBUDjcZfK65oKVH8wR/fvg6z?=
 =?iso-8859-2?Q?/Gh6RMh7WwtTznpp147XrgXS6BBDI0cQQweSmmbap+fl5zUCakrpXlOqq9?=
 =?iso-8859-2?Q?Wr1eChjdlgcXVeNZvthq2vB6SWJwPHupx5YSlaNXWE3C5EwjaUNXSq0UPe?=
 =?iso-8859-2?Q?7yVAS80cPQD4+G04+c7f4rIe6+kqsRv0ZdPIlb+2LZiD+AYURBYxjGqbo3?=
 =?iso-8859-2?Q?shmIwiG3A+cVTb2ARbOLJPeWQJr+mPOx/9b4m0R1Bcaj0nPEWXyBxurdVn?=
 =?iso-8859-2?Q?gZYEr9jbqXOBcUhq8LsY8fe181mOxumJmSqBaQAXbG1+JUqT+rU7f7fA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44198012-1834-4a7e-051e-08db3b7ba0fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 17:30:37.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyWbRgxCLYuz/HgQfYNM3Fs20BW3xpA8vgfzdAjx1VBXTeEtnuFw2JZvwBS0zpCiFECSqyWS84kfMVAJbSegBxLkLR8jDDwW9nIZLHMyhoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hch@lst.de <hch@lst.de> Sent: Monday, April 10, 2023 8:42 PM
>=20
> On Fri, Apr 07, 2023 at 10:05:26PM +0000, Michael Kelley (LINUX) wrote:
> > > Yes, this works fine now, but why are total_used and used_hiwater
> > > global variables? If you make them fields in struct io_tlb_mem
> > > (possibly guarded with #ifdef CONFIG_DEBUG_FS), you can get rid of th=
e
> > > check. Of course, in instances other than io_tlb_default_mem these
> > > fields would not be exported to userspace through debugfs, but if rea=
lly
> > > needed, I can at least find them in a crash dump (or read them throug=
h
> > > /proc/kcore).
> > >
> >
> > Got it.
> >
> > Your previously comments mentioned making them fields in struct io_tlb_=
mem,
> > and I missed your point.  :-(   I got focused on fixing the accounting =
for
> > DEBUG_FS so it didn't include the non-default pools, and didn't pick up=
 on the
> > idea of doing the accounting for the non-default pools even though the =
values
> > aren't exposed in /sys.   I'll fix this in the next version.
>=20
> FYI, I agree that per-instance accounting is probably the better way,
> too.

It turns out that restricted pool swiotlb information *is* available in /sy=
s
when CONFIG_DEBUG_FS=3Dy.  There's a call to swiotlb_create_debugfs_files()
in rmem_swiotlb_device_init().  But the /sys info is broken because
io_tlb_used_get() is hardwired to the default pool.

But this is easily fixable. I'll do a two-patch series that fixes this prob=
lem,
and then makes the other changes for the high water mark that we've
been discussing.

Michael
