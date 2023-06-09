Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD22728F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjFIEuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbjFIEuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:50:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DB930E8;
        Thu,  8 Jun 2023 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686286199; x=1717822199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i0tHzC/mCgKQtD17kfVsInC83hzmHLeGNJHEIyEuZ7s=;
  b=k8DEqqBctLOHWJ7wtXfaojXvL/847WjJITpWdSbQyfQJsU8YktU56CaW
   mGGLsB3cDm132+X+lNAIg5f3JM73F1eaZl94Ew5u0qWsKeozxZg3fjhpu
   hTXsSVzMV5e34yMn7g+yhBpprWkXzkVrK7Ew1ie2VuqlPCqIFK4gIjVZ0
   IeUVAiE8VpRq2dsglm9baFqHJGJzSQdC4EPrsL9eopeumdaKJaMqTFqQS
   ZVEURuscc8w5txrwUWjZ4qPJQ54BzHJiTEeswg9tykdKYgPbuF4P/3cqJ
   DWPDVzB/JB6HzLzSDMF4h05fTZcqWcIsDiZ4zZrIJG8QpNz8cXLdhDU0A
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="346111196"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 12:49:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYUhuGc2ugK4OCbRKDNz3v0mFCrKSVzmRsoeUdovz5bDBD6FGBDetUU6QhsSWxYjCpx7ejtjMf1Oqy++VRYvSOMtct2J48Y4io9lg7p0nR8qACKFTqlZRh7MtB0s5RQ984uumPPLSfu6pw5248wEIy1BQrdpuPZDnNCHB0IkfGWnljTqo5Mbx+hKOXIwr6Ia7WWDhm8olftQQKiu1Mad4HI5HBKZNaOds22CiM/KrirSu0eKWxbf/hZ7I6e38pEKKAZDxlPd3DlUpS3YyDqYEITUBFhvLTqkinVERXujpCMnzHzyx5P3cqOcs8vePKXzkpEdvYPHhOqIzuNigOCozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0tHzC/mCgKQtD17kfVsInC83hzmHLeGNJHEIyEuZ7s=;
 b=JtE+R89Zxx0OB1TPYzuxzqYisUEPGCWFNcGnt4LBppO7ZQATEvPiVCWPSfnscdfK9vpGD+oNDsacT5aif5kzx76UJNvt7conRuVzg8f3TO+TwM9Fpa1P/DrgSn9O3K3R0kxGTyMX2tTkX+5ulSq2o/Hay/zUEa9p8rhwGj0AZWp8+zcCt04bRaBgTNqZx9PHBA+6d9cJS2FZBMwgoMMoXShm/FEaLGpRQpR+c2BNMu8VLxsNSwGP3yU2zfatZiX3xFAKrL2uw0BXVYgRrFo6gR0snQYHsnje0SYgehU5/LjfdOssvKmWBYOaHb/OV40YRdSsdR9Jsq3RQT1WxDHXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0tHzC/mCgKQtD17kfVsInC83hzmHLeGNJHEIyEuZ7s=;
 b=fuhAjMQ131JDiGP+kjxtESDDYgOGSqYDb+xg5UTeN1TOnshM6AB6eEmeHesH4GzIDrg9uJLfGxxyKhALFUYXro41EOkIwzzPxQErgwJY28PrHdq7AApXIH03CeTsl4NuRIBVjRTRN2AsXOYq5XGuCg9oEIuGVoFPyh1+T1p+WvY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7617.namprd04.prod.outlook.com (2603:10b6:303:af::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19; Fri, 9 Jun 2023 04:49:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%3]) with mapi id 15.20.6455.028; Fri, 9 Jun 2023
 04:49:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Thread-Topic: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Thread-Index: AQHZmo3WacRzr0/CLUSYU+iLRItmng==
Date:   Fri, 9 Jun 2023 04:49:55 +0000
Message-ID: <p4tetlry6jcie6u5xbdf5gzsgszckogz5h2oin3wqo3b6crhxl@5wz3ryjybgvv>
References: <20230606075443.17437-1-dwagner@suse.de>
In-Reply-To: <20230606075443.17437-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7617:EE_
x-ms-office365-filtering-correlation-id: b9615cad-723e-4de3-8f7e-08db68a4f8b5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcIIfykKAvH5Frao3jtaGb7ORnF0zAftWu7Kxf7WPPWajTPkzmOgnFxvXafnlFcDr0uLEDX0tRVSGc4qiPr0p0vB/AdcfJNqAdbeJ1F4zRjdCSwkXv4EvXqWlbzbz3zhP1vXXD0eC0kj8lnAZ+Crjwa6M/T7svY6aDPx13oyzIWBdV+AgSAapYiak6zgLXxAnslYQCzBU4uK723KZCe079jRR93BQLQm93Sma6G/7tksWBRoPkylm6jBJknfq3hNogwSAVDWsT2Oq4hGO3zDikmxfjImKoHocDb/L1gw3V5840BePoFwLzm7qAXRvsasQC5F0fQpFNIfVKG/W/SMRYIu12Yj7zI9QgRXZHEgZs0qRC+2+6lQFOHeIx+YrN8hOXuKqbiFv11+tVqlUSmRkz5uSeIv+SifcQmcqKeDk94MsmFNVe4gjE6hIp/ZO4f5adL/+qgoPl2uIz7CsZKfK9Ld0gCsFpzMaqCt2PaTGmI3GgX2syBwtMSvdosqCMWTRU7a5ZWz1GJtKqOEUnzZHrzIhsnzzFZKoAZlFw7cMos+fK7tMjXYs9E9HHlsGYdF7HCEkAsV4atKrO4s+4UknB+l6Cwt40863e5+GaGqeFuQFo8MghtofTwjAe1EetiU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(186003)(83380400001)(478600001)(71200400001)(38070700005)(6506007)(6512007)(9686003)(26005)(8936002)(86362001)(66556008)(44832011)(122000001)(64756008)(316002)(91956017)(4326008)(76116006)(6916009)(66476007)(82960400001)(6486002)(66446008)(66946007)(5660300002)(4744005)(2906002)(41300700001)(38100700002)(8676002)(54906003)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CdscvM8aB9f45MXftzf+bKwQqJ3+xi7VHT2Nt0oHndzyhIgAySuGdpHMR7ww?=
 =?us-ascii?Q?gCme8YSr4TaMd/sribXjlX5OtmbKXVz58p8jnv1whqGi7Juiip2vC79OmKMf?=
 =?us-ascii?Q?yu1M+0rbMWvJubN3LI/N4hALhCozYtX9t0CLJR8oReLqmwjKbEC9Z63R7biZ?=
 =?us-ascii?Q?c1l6PsVo5oSkPCji/MsUMzjx+RvbDrjyK6mgJMLccjKuoqY56QMxhOXL9gOi?=
 =?us-ascii?Q?DNfc7zS7JiTdFNjh9ALKSEmzdcYDS+om9y0vMNaVpyza1JhlRvHJEcqZcgfh?=
 =?us-ascii?Q?pXhfhqBEzD0qYgtIWZXkhlmwh2aqTmR1fMmzA3SH8s/YeE9nBNH+NqcQCQfS?=
 =?us-ascii?Q?ct3++K7wO0/WHc9CW+DjMwy3PFw9puqJ5eUMawyvY+7nZzKRQOqtEdRze6RJ?=
 =?us-ascii?Q?kTPHJ/lr+adVoU2faebGspV4r7lW8xi5ALlVwlygB7YJrICtuN46NAoOp5o4?=
 =?us-ascii?Q?msnbzrqYQHGnkDcmb331E4O43T7JI/alcooDOJspJPkbw3wa447xFYMy4vgS?=
 =?us-ascii?Q?CrCq6RsfloQ3SkmUOCPreMrGabdAPrPC606drFWT3r4vdAUyJ7U/PF63u/bN?=
 =?us-ascii?Q?Lj6Gz/rq3Kdyqw3WUeDWNI6FEpfIsQxsc0KhjGDt08EMsVVLRoIoN9IsCAka?=
 =?us-ascii?Q?qDiLcEqViQaBFo+l1/dU9zgRlTEwo4INImyTzAc1GhUiW+fIFYn25XXty7BB?=
 =?us-ascii?Q?ZpveSqahVHEx/Za7adEIV1rvgjFTk7vpOQZwdfnUtKEpIwNRoFMv2r0jKzeU?=
 =?us-ascii?Q?49qTeEppkDEr0u7Sz+7+jv7sEq3WRRqLzau5eNuAIQAQ1pujpVQCRGmIG04D?=
 =?us-ascii?Q?Cu8r0SeAB7ANwwM+N6BaCZEUIw5JBnrbzMAzUGIuyFD/AhHAlq4p8foG7X5t?=
 =?us-ascii?Q?LeMj3RyIp8u8+2Q95LK3mbNnQM4Fei3u18PLqGFRyFlegz8Ydh2G7q4NXyuO?=
 =?us-ascii?Q?2p6T+1Kr8asoKU3+MLWYy/wAENcm/os+E04GbI0QNRlEOpJ0MJTDymqwtpak?=
 =?us-ascii?Q?cwpuBL5wKPrBaCGneD3Ybzyqu38WXrh3h2D2O3JJ6cwntAHS0HjafAPyulBm?=
 =?us-ascii?Q?1+RQjXMqolyehfk2bZB/Ix8SeUwVMKvR2r65qqioS9aTiRZdzViwjRJUP5LG?=
 =?us-ascii?Q?1z33WvEAI34g/F/D+lAsWQH3Fw1OK9tRLc8sF+HLLb0kNQjJbU/kTnviUAYH?=
 =?us-ascii?Q?TtbxTMnCWS+NTKBErKiEgWcshCSaaWV2D1M6T3YbzxwiYaBuZ9zLJ1rNQD5l?=
 =?us-ascii?Q?WnQ800gCRXBihHRTmCBmgbLRqmlJpLZaM23NYpite0+4j7Vy64ti5qIpg4h1?=
 =?us-ascii?Q?bUiqeX0OLSYIzdZrlJV7hp6kVEwL3THVWjYtDwH4JJ/uYXseYIfWrUYsez0x?=
 =?us-ascii?Q?FZVU7s6AfpVZMLPY+9cls9OXHcbOHd9jf88VcyVvMmGDW28U8HFTdVYxLBvk?=
 =?us-ascii?Q?GeUaJ5PgX+5Kn0She/cWdVFHX5AbA/euT+sECUbI0WDrRn/12NhrCnx8mmHu?=
 =?us-ascii?Q?A36BmtgBswOlXWUSTjkfEhuFtN3Cc8eXrxrT/oKJBKL2Lvh7ja7FE9ImWEtd?=
 =?us-ascii?Q?tXd+bkA+I1HifoBOpYWr0/LuHCHkSMXPxmA7URZ6MaBO4FihVBCYqBUSM+wP?=
 =?us-ascii?Q?3+3JVBM8Apl7Txja6WhT6Zk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9C4CE957AC82E4EA7295821B29ADD1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5Z9yR5FrlAajjWhvY48P7L7e6jSQLWQmhUsh6CnOQ9zHLRZJoyM5KJ4LQXrE?=
 =?us-ascii?Q?lwaiX1EOFYiVqufYKTieYqt5+LiwNSin2bH1XTcyQqwF6oKDQUdjaZg2/zJ9?=
 =?us-ascii?Q?TD7dQnJd6avDv3lViyY+ogOzzUSHezQoIdqPg38wOKWXzDLgPXcilBBjVrZG?=
 =?us-ascii?Q?6EldkKVzu0CTCCQF3MCdgI1XvPlIcr8u7qrzRdRum0YvlAN9xdBKv2UH39UY?=
 =?us-ascii?Q?uDEVNfzNZ0oxP2WK+51k4OcMTB9GXxr9eJFWJCms5FEyfDhrg27ZW5kHO4+W?=
 =?us-ascii?Q?SQyWNctWRLUI0FdxENaOyw2jmFhHD6CsywbpZbTwXYrcP2z25e/R/sUBhlHy?=
 =?us-ascii?Q?Nvvm+FEX0dwsv8SrEt8D3HzXFdy9661MJc7U4ZIo8hM0EJLRuH/jJgV+SlzK?=
 =?us-ascii?Q?Hlrl1sfcNJdg8v+SBeWS+kKhdVLbdcuOWvTRylSO6AyQeuD4rNF+wtkpSO/D?=
 =?us-ascii?Q?RGTSlIzGfNiMO8v5TPzEDvX5olGcyfj8M11te4sxe2bU2sWBHWkkTWrB1Pau?=
 =?us-ascii?Q?HGYJAPspmy2YjieYVxqZwhGn4N2Q6pak6TnRNjIRedNtl8Ua+fhX372opIHZ?=
 =?us-ascii?Q?CslDWO7HrgFGRp9Jh/ab53oqgySXxfK83lCpsai6pIpYaDKo8pXZXBDrKf3Q?=
 =?us-ascii?Q?/0QuIDaItZjhBMc83QRBtL7RSVB7603aP0HQvg4Z2EacnX91dP+656BE3NRU?=
 =?us-ascii?Q?XIBSx4YdSd2gK3LRIEVxUbV/rGvvpAgIf/pUxX98ZyjMLfi0tqcolrBP242D?=
 =?us-ascii?Q?W3ys2iUeE61OTcefT7PZpWu00VgfdWPE+ZxZ6ARNpYSmTHzsI/n759lkXPsO?=
 =?us-ascii?Q?h6UwwPCYhIhbS0gYI7EBNbnQMrwwVm13ylxRg6UURFp2OXBKBgJ4UYFHC0Iu?=
 =?us-ascii?Q?Jkv2UgkfPeqwhEMf+MepCrXX0ET9lTy6eir+CDwCvS5m47reyXYF2ggC9XkL?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9615cad-723e-4de3-8f7e-08db68a4f8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 04:49:55.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0ADreryO4GQC1jRao+72jojYfpJsaJwigFSd9iWoCL8Vi86JNuabBYlUm/hF2H3P40OfGgV3O1KDaOqW8ttP8Z4scyijahwfW6pMBVUS1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7617
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 06, 2023 / 09:54, Daniel Wagner wrote:
> The nvmeof-mp are designed to test a NVMe multipathing setup using
> dm_multipath, which was a configuration RHEL shipped. In the meantime,
> RHEL switched also to NVMe native multipathing which is tested with the
> nvme tests.
>=20
> The nvme tests cover all the use cases which are testes by nvmeof-mp
> including the transport failure, see nvme/040.
>=20
> During LSFMM 2023 conference it was decided it is better to drop these
> tests and reduce the maintenance burden on blktests.
>=20
> Cc: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Just have applied. Thanks!=
