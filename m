Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46866F5967
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjECNyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:54:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B466180;
        Wed,  3 May 2023 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683122086; x=1714658086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u98MdPFmHxefROFhEzNes3XXBLZ/qTlrnrTInPoO6+8=;
  b=SlaIsswIkS9hgmGoVkIAja/Gl7Vo/rZaIY5A0zZMc3QWuJ/1BjOVOA/d
   2QfJGwoN0gE7ITLqBbDtf4DVnWK7EnXNivN+027yMOVjLjAxgWVKPoHdy
   +zRjgsKuLtUaa4EJhBmrAdI3st5az7p5nS6N/V5quSFjzt7qsUb5Glcxu
   csB69+4s6xWDP6L/Y8MNIno/lWACTnxEMIsENvcysOOZWVhjU+WvYfPC2
   u/4Z+ZJjMIaR5bcCGYalFJBuByyZClf7RSlksgP4yegV1Zqbke2t79aVw
   Lt//nf5jSCavgmfqf29xwsPCKGNXcbO8nyf2W6mUecATHV681s3VQzInO
   g==;
X-IronPort-AV: E=Sophos;i="5.99,247,1677513600"; 
   d="scan'208";a="334234458"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2023 21:54:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiWJeQg3+tc6VcRCr9dznHCxICfF9fj6y1bWCz7aphP1G248BWDVWkA8bQmyp8Ckk7evoF/Pr2pjqgZz+zxb8T3XutMGku9lfmx5bbKx7iR93kutfT3aJrefXLDd6Yt/ewjNjL5y/1SalnUCg+a0SlE4aglgyYu+1A/aAT73HFT9JZurpmXAH5zRwZGuo5LH21qRdHovgFTyx94aoxHHWEXB52UuEscvznU6rMWk0yXcFNi4DX6HwP5RutOYEpALGmA3vZL1gs9YS+gCtsV80QmxOzAKE4v5prDvCMmHfX8GySpZWTV6HAwfeEbH7skxUjulc8U+QFIcGGv/8OR4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJrG2SdCDW825BOCOWmyb75SdDVhWrOLsS0uFbjM2o0=;
 b=VUSrOn+edtYX2qdrs/j7HFsWxVVxk9X8vCfdreWv19YlTC59svfk1hRmikg5gd49DEna7SZ93zfcUOrUpucHBjemkdwKZP4kGd2457TC08sMvt/1o0twgowVv5rbqAD92caqufS9GCvgQZLQRItYK8r2JyV+vqJtybAgBrysZX6J5kNlcz7jzHKso1f23FtNSGqYqUajkqD53ho7vau9tWZR4pff8We8wqshvMBVv38oj+H0zRpM3cicSom18qtsLmWD038XStO9XtbWY/tyzHj4fcKtmiDLLAYUrLu6xcqeWsCz0dxE4eKlnrhwzXbRfZHudzjxXrL+2Y7WUZya/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJrG2SdCDW825BOCOWmyb75SdDVhWrOLsS0uFbjM2o0=;
 b=blfoTIcFq6cywxHy8Dolfh2+86ZTrn3AeQ6AupiUDz94JRaek7Mxq5CHPYJNY7RaoyUBsOHZnTj9HDDhFlyQ2IG0YC91UAZSYF1RbcJwy2csIt0edcp9Ke6RerzQRjxBIJeSrZkXPUATfyhk9BS1WoGiO1T986KJXFFkSrAl8Cg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7392.namprd04.prod.outlook.com (2603:10b6:a03:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 13:54:39 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 13:54:39 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Thread-Topic: [RFC PATCH 00/11] Rust null block driver
Thread-Index: AQHZfbL6Xhz5/nlop0GOn95gYQsxBq9IelAAgAAX4wA=
Date:   Wed, 3 May 2023 13:54:38 +0000
Message-ID: <ZFJnnkdAolHdhCEo@x1-carbon>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <ZFJGWwlRbSS3zFnc@x1-carbon> <87mt2l4lrw.fsf@metaspace.dk>
In-Reply-To: <87mt2l4lrw.fsf@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7392:EE_
x-ms-office365-filtering-correlation-id: e22e40bf-8afd-4d44-47c5-08db4bddeffa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v48mVqPRV3ECQGVcLkoJXH0seOGMfmzTBmFpYkb48kY6/i5FhG+bMBPIzrjZkLJpTWPOHwOUtFTbPeXoQA25ZZgFNmj8THyCSOzm4UVgSC6vSzHbmLSl3C6xfKXGh6LEWRr8urOZc3L871J1dv+8bhq8SdJp0B6OpBvrbIZMnox6/Vs4hIvbmdFu+VZAuLEkdlVt2zZlJkc+kDH7xMF8KklpdyMCebK4vqQzLrddrwrQB4goMmNulvw4f1DzzFTmggzXD5wko85ySibT2WC/tGTxpngTScghlkjudc10sHKoCQcGtZZGDp/3Y3PlInNUFzJipoNNXeLnTr5AsN/XhJ/IbTrP0mUmcQoCBmCsPf4n9+O17DhqCWBfXDJLGdtCF5CC8yGKHRf/yL41nv7UTUbuZkYD3Z57bB7vvk2NRDuM3MI4P3Qz5cyBxhrjTT87WT6GjlH0re3ZhQdWkuMSXmaAGu3QcGZ8KW6vU1pETraaCuEdj3FmeyJph4sfNMrZVbgpmrmxeu0xQOycvHGgV/1aIH+biPy4Grsi7XYGsj5nUaopEyzpugUaWYSukejbmvM+e45ikFcLFKE6oYoqUREFVO/YmtPUHktX2ias1qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(8676002)(966005)(8936002)(41300700001)(82960400001)(71200400001)(38070700005)(66946007)(316002)(64756008)(66446008)(66476007)(66556008)(91956017)(76116006)(86362001)(6916009)(4326008)(122000001)(38100700002)(478600001)(54906003)(6486002)(2906002)(5660300002)(9686003)(6512007)(26005)(6506007)(186003)(7416002)(33716001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kdQ4sk8xyBdGJOXKtp6EIKcMIs5zYkmRDJ4n3d2TBQq6xCAVDpraaFifO4?=
 =?iso-8859-1?Q?2vQD3EFCMeZ1V9jIhMgabmOV58O+Y/4GEKgTXci7uTW/TaS/Dek/VxdenE?=
 =?iso-8859-1?Q?NU0AWu60JQP2ccXEYXikaAWL26sJk+y8waHJqeqUmRYnKLwk5vlTutpJDl?=
 =?iso-8859-1?Q?PxWa/2Bt3gnzXE+n/WORxGiajBcEBFxxsfkuqdQMXjB8bYVHnac0KNEyNv?=
 =?iso-8859-1?Q?hv7oASrMBXr95DLzGI5VhJcI8GhcT6yDMlziHimlj0LQyvViXNqikyUJt3?=
 =?iso-8859-1?Q?UPloOW5e8eN3R4BV2Vdflm/TzEcwB5gNtgLRDKj9UrXm0biyQaL730L0of?=
 =?iso-8859-1?Q?/q0fJHTE+VMq05QEmGLaDblAHstyfpbm66VijJQc8hN1OPahQKXZO84GBW?=
 =?iso-8859-1?Q?3jQzIr3Es24DEGIb3b/cVyzhMyHs99TCf3EjZjf6fwtzJ8d82Z2tVlVvKy?=
 =?iso-8859-1?Q?K2DDxOj0NjMuD7VWSVcSsWjJDyZalBwUDVtKSjX2MskPv1pBYUrnw6jxFO?=
 =?iso-8859-1?Q?dbWNtPq9wnsdZdP2/03npU94z8jpgXL+sQoOGpb+NrvoosOt4r0NJqCGZw?=
 =?iso-8859-1?Q?5CVkiWiMM4Z6GC5YVGkHxqCdpIU2lQRgfuTc+pseVy9UDeWPGt3cAFr4dA?=
 =?iso-8859-1?Q?NXLLPOPnprhVZLj+cID3btpP3Yt6jEUZHK4GRxtH9nwsycZ6gj2mlUycAL?=
 =?iso-8859-1?Q?Y94OonVK2jV8lWNT3RgubABEDci4ecjvHrskx58DPzECltU+EIEAGz9JVz?=
 =?iso-8859-1?Q?7gUIEZ0C1SZ43JWfm0iBzjGjwcKHc0pOo0WfpUutg3zJs1g+YNadGeIdzD?=
 =?iso-8859-1?Q?zRxu+cl4UJGIs1TQwor/5/WZT5yOy6gee4f9rtFfDcRf0jJVA/IpwUIHsV?=
 =?iso-8859-1?Q?mnGFXUFwVTxbzM4JkleBBmfU8gd9c2/doROji1MUshLY6We7MQYkscaqH+?=
 =?iso-8859-1?Q?oqOeVAFd+gsV0ETf12rbwPI3iznNsVmqDAouDO47UKu2slC1ZPIGWhMRlB?=
 =?iso-8859-1?Q?bAjmUkuQDrSzoCcYRP/1ErmBkP8AErymVCj9ty2ydLlqfM5aWffGUSdkmb?=
 =?iso-8859-1?Q?L+UOmVBC2AXc/Qd8FUKU7Ww/wNjTK34ZOVc2c43ZyPKQ4kd1A2MGtp50Ov?=
 =?iso-8859-1?Q?7RCy3sFZIw1/UJnopcvmk0z/xhfQL6ZOPaceaOFgfJGppb6Xtyj5ZfZT5U?=
 =?iso-8859-1?Q?2kW6XwZdd4FgX5n8qyNlTqNlcKy30w40wKzSZ8YqKA1JBvHfBjsCsL8p6S?=
 =?iso-8859-1?Q?YI7Z95fDhMvuYcDu+6Q9Yv5xZo/f30NK8u7neBDgnTdhCr9jQ/KLABfHtd?=
 =?iso-8859-1?Q?afrqqZ/EGJHdVoZpp3fPKKz5M24fttYBW2n6hTo5snNYOF7iQn9wK5imc6?=
 =?iso-8859-1?Q?ZL+fi4syDNzzVH4Gjtwv5HysCm5DtsRMZdAKMjUlAeMF4SBR3kehekA4dN?=
 =?iso-8859-1?Q?Hdo0zpYceucnyyPmJC1TbQbjjSGkk2mk1eC0Pqs75GCzJPRnCcx2odPATZ?=
 =?iso-8859-1?Q?1pFyNrRP8dY/5dtRIvQueSDkWnLbseckMVwMNeMpoi5VXJUY8/1DRlpxSA?=
 =?iso-8859-1?Q?8E0wT3EExoOK5qpdVdRMZ7UAPJFsnsEaUbaVZalCpYBcE0Hhu7BF5fiTwJ?=
 =?iso-8859-1?Q?tcemz1x1BuRIIvatUDf1rUITio+YYfL7S+rebDWmhaNJ56yvqAcQpQXA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <095BA19ED35713458DED616BB387764B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?5M49abLUdsCPiykPIgfMyxBLneoLhQSDmc7LaW8ERd2Tmnlafq9NRU0mLQ?=
 =?iso-8859-1?Q?rsqRdzHjeVeXSixJPM5Cb1uAQoXZIbBG2FpvvgKss1hH3QySFQJUt+ygGQ?=
 =?iso-8859-1?Q?5+YJfmzHap/0NTUPDDb1Msa4CtOOOTkmb7LkkdQcdnd+KOnhiip58T9ihn?=
 =?iso-8859-1?Q?+IvPcoR4IhNWogzQOhPdyZp5P2GPITXX20wFVO3M2OeZrnr+bH3cQ6QvNT?=
 =?iso-8859-1?Q?e0IfBGOZv6xiSsqVF1U0Jmh00cdoDFUVYGLvCl0LtWTV2i8aYS/R6s/vWk?=
 =?iso-8859-1?Q?FuqJChL0/JSorugyMTYwF63F0jjNWd9Cv6J8FyTLXAJm12+NGzlbP8EaJ6?=
 =?iso-8859-1?Q?myRFsE6SE/jaaQF2RWnSySriES3TpF91ihnPNXkojexAvKzuILoNvH9BhF?=
 =?iso-8859-1?Q?0oCser9p1a0g8S8WkvvpQ1cjSBotbTHLid0YJJVLaYXL3V2voCdJTDc3c9?=
 =?iso-8859-1?Q?zr2lls+DkRStkxk2XnIpnooUliaerHVsPh9B1W9WtxfP8gNikqeiV/G74K?=
 =?iso-8859-1?Q?oE2+4j2+KX26xooCczFTK807Fq4g01ifv0DWR5ySQ/BHhV0JXCGj/Ixdg3?=
 =?iso-8859-1?Q?aFm/v3dsJ6gpRxh23jjHwweiU2T95l/mxfw3lAdpmX3Ii9nhb88Biwt1xy?=
 =?iso-8859-1?Q?lCsHk6W5xI1oHvopPpSdyQJgea1oHur71zXFZ2p8c0JqJeFnWo8Ee3N3Sj?=
 =?iso-8859-1?Q?kRCRSUxGEnMSZtsiIZUj1GOj7ewKsOPy+izU01wzLEByZcQnwcQ0bZItf3?=
 =?iso-8859-1?Q?2UEIbOxeVuDRI2NFeRk/bGuXFoTHEAsgbr9c3LAzOA4asSnZF+yrLsLHib?=
 =?iso-8859-1?Q?CpmYhJ0tibdrqTqjDEjBXSTNYJhz73KDtjjfkabr/apri35/Xxl9CxpHE1?=
 =?iso-8859-1?Q?JxWviwl6Z1hVkZJUZyEgEucwDb1Ool4kT2lVDnM6/MmZL0Ehyk5mCPdCJ8?=
 =?iso-8859-1?Q?4NZDq5i+DpHoaanO6b3JgBDjBrHdh/+wKz8EhMQroScPpWjwCywNPti1Rj?=
 =?iso-8859-1?Q?8GAEfEGxXAMFcMZHX+wqAaHjaRVeEfm2bhCsiPP732chUkEjp7PapoZMUy?=
 =?iso-8859-1?Q?NtSkX48i0YNl7pJnlkNDfYbyljA080M6aLzGCDPZGkia+SjZaHwhBo75in?=
 =?iso-8859-1?Q?3WSFRvLPY2KpkMg+OTXzF4iVWoJS8/IZvmrnQQVb7KWHor/HoUo0U4y2Oi?=
 =?iso-8859-1?Q?ZbxtBuf81omDQNuBFbzx8gahnWEBoE1zSDw=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22e40bf-8afd-4d44-47c5-08db4bddeffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 13:54:38.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OlZZrOSjm/awpOYkLBoEJnjK3fS1y6Xyu1PWd7it17hWX/8LPMP3V7B24dJachBe4SWDuqYkF3+Qu6122MGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7392
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 02:29:08PM +0200, Andreas Hindborg wrote:
>=20

(cut)

>=20
> For iodepth_batch_submit=3D1, iodepth_batch_complete=3D1:
> +---------+----------+---------------------+---------------------+
> | jobs/bs | workload |          1          |          6          |
> +---------+----------+---------------------+---------------------+
> |    4k   | randread | 2.97 0.00 (0.9,0.0) | 4.06 0.00 (1.8,0.0) |
> +---------+----------+---------------------+---------------------+
>=20
> For iodepth_batch_submit=3D16, iodepth_batch_complete=3D16:
> +---------+----------+---------------------+---------------------+
> | jobs/bs | workload |          1          |          6          |
> +---------+----------+---------------------+---------------------+
> |    4k   | randread | 4.40 0.00 (1.1,0.0) | 4.87 0.00 (1.8,0.0) |
> +---------+----------+---------------------+---------------------+
>=20
> Above numbers are 60 second runs on bare metal, so not entirely
> comparable with the ones in the cover letter.
>=20
> > You might want to explain your table a bit more.
>=20
> I understand that the table can be difficult to read. It is not easy to
> convey all this information in ASCII email. The numbers in parenthesis
> in the cells _are_ IOPS x 10e6 (read,write). Referring to he second
> table above, for 1 job at 4k bs the Rust driver performed 4.8 percent
> more IOPS than the C driver. The C driver did 1.1M IOPS. I hope this
> clarifies the table, otherwise let me know!

Yes, I can fully understand that it is hard to convey all the information
in a small text table. I do think it is better to have more small tables.
It will be a lot of text, but perhaps one table per "nr jobs" would have
been clearer.

Perhaps you don't need such fine granularity of "nr jobs" either, perhaps
skip some. Same thing can probably be said about block size increments,
you can probably skip some.

It seems like the numbers are very jittery. I assume that this is because
the drive utilization is so low. The IOPS are also very low.
You probably need to increase the QD for these numbers to be consistent.



Perhaps move this text to be just before the table itself:
"In this table each cell shows the relative performance of the Rust
driver to the C driver with the throughput of the C driver in parenthesis:
`rel_read rel_write (read_miops write_miops)`. Ex: the Rust driver performs=
 4.74
percent better than the C driver for fio randread with 2 jobs at 16 KiB
block size."

I think it would be good to print the IOPS for both C and Rust, as you now
only seem to print the C driver IOPS. That way it is also easier to verify
the relative differences. (Not that I think that you are making up numbers,
but you usually see IOPS for both implementations, followed by percentage
diffs.

See e.g. how Jens did it:
https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe@kernel.dk/=
#r


Kind regards,
Niklas=
