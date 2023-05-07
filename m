Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DEB6F9CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjEGXbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:31:35 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA44203;
        Sun,  7 May 2023 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683502294; x=1715038294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W+7jyn7Kq8eVjjouF2hbFXkYEDsh+bDf4KWcgsMTkgM=;
  b=Htbt70vvJJT6YqAy9sQhkO2JeNr948+dVYs7Zs6JQ5fnJ4KwuEiJusz9
   dkqGVVf0zOYr++zDmdOCb/QJIU42whUtoXr5cYIGhX6AHOs5O/exjQe8c
   3a1W1YFLsAl1BenB7sUGPOu5gIqgN8EHPgCR4q1+shQRjKetOCrNW/Nf2
   MwWPmDl8oHc+1sFln3hk+zmmKVJMHO+Q/ORwfdnYpa3HqPPif2nvUSZav
   CGrr69De+n0DW0dIoCGdXgaDbfEeylOMYK3XHWS0tKwV1189oogHnr4ZE
   /55g+4Fx7VxJBKnMdupQmDsTrkE/fdKE+6hOtKCsKn4RpH+ciEMQTjMlz
   g==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="230132381"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 07:31:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtpWpWN7igUJOJkcr5Xrmr3F5IGLx4RcuKJq2e0k0IDS7J3NS/TgGSJUwOLovI4uDBAsbXdPhy8vIt7MJ5TdO7dMoa7dBSskulmHxw7xVlpVob1ctbgS5Y7EhbC6fcOlMSdyBo9jC0e4sMTS33z96roS7GX6URFIYjEG271rEZCLmTNARReeiq214lshyCEYMNw6K1CLJDHIHus/lMjQ8pD71lnpF7DP+ghCYt8FF+C2kZRusc9QEPJ/KceCgGdRcQjk0S6JThovkt2lu4utBy+f7wMcJStYxtEuTZBBRmWMb0OeFakO3RA4Fyfv9F+3UZ10g0W1c0+zpS46y74GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXMaKn4U60Muc3gRhQ5ZMNO5vXRnwhd8Jdm3EnmK8fc=;
 b=IAeaJ+zqYsFfGDM1uVoDK5dMFo+dPDTn33HiN40DBG0FO1Y/73w2Sc2nMLXrz+PdiKEPBjr9ULum2zYUz9yJLVIKRYWO/uVn0sB224KT7/UODRJrDDypI77ZIQoKsboT1aXA2GidPmP6AESbH7YEARtZ8pkpBiJTPzvDVx4a1+oiyfEVkoxBBkPhejVcuSso6Ata5SXNZCwfi6gnS5M9rDJnIMEn5rmt5ZSMnxdNFm0Gd09Y6Mywj2KMztscLPmYxo+voma5mi3xckvqZhKNk3Ogd7hwFIwGVXfEfAzZ3aYsm0XwHq+0E8t+jazqYWg5x+ialaSX7n5/zijSWJQoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXMaKn4U60Muc3gRhQ5ZMNO5vXRnwhd8Jdm3EnmK8fc=;
 b=tLISL1fe29r/vBLC+eWEaErjOHCAUhLXwESrXWl38mCJed17mZHg5s9dA/+JyPbuyTEbA6xoO/PpWCjWMbaAP6e2Ihnvdt4rXxyX1HWQOWuFFLUpKP9lEaQfIzizdZQK6clBhCwmqaSyt7iWMntyXY71S3I2ztmw/Wm8shiw81s=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7348.namprd04.prod.outlook.com (2603:10b6:303:64::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Sun, 7 May 2023 23:31:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 23:31:11 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 10/12] nvme/rc: Calculate IO size for random
 fio jobs
Thread-Topic: [PATCH blktests v3 10/12] nvme/rc: Calculate IO size for random
 fio jobs
Thread-Index: AQHZgTwBFumNSkqSeESNMf8JH0uC2g==
Date:   Sun, 7 May 2023 23:31:10 +0000
Message-ID: <xqdnjtl5m6idy7kecwpc6nho74twnvcslkvxnyto6aflz54y5p@6rqao2i3ro2r>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-11-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-11-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7348:EE_
x-ms-office365-filtering-correlation-id: b7e5f2f8-304c-4675-068e-08db4f532424
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6wRJ6iE9g08aSJlpK13V4GBr37IftpjkILbZzl9L5K2kzjBr4SY879prqZ5bJbs8sBxqCoPtNbsvNE53JQayPR8OMBVtboLL6GTrkq58zxka96Zdg650CmVmojIGtdYtCZHWStocvy15kiKw8c3rtBkIcQMLYKg0G1F+vPDwfWuK7iTeuU+d77z96aA9r+InNGF9RyrwmHYQSvEudmjwndCL8geoGhfn30mJK+Ov57vV6ER0kSG5qIV9aIdnYCqEQRXVEWCNFrfr7Ju/BPRvIzBOamf4XFCnChMHfm2lzD2K2ZCRLWt4Tlb61lmBeWKcU4rwIx6G8CgPxshxMGHc4qKJj6eWrWgDjq0kjsuWnuuuAsWW7m/HoxPwVQxxCxtNslxqdFSriUIE5u+DvA0GeIe6UY+BM0Zw+U1ZJ9Z7pilMnXusTnIR1+eo/zS4OZEa9ixw4b6FBoOl4sLr/8gEqGzl6d2owtFsj7fs2AR2VMxCqaVDpkHjr2oaKwbqFHeX4Mw+kx2ajAGihNdOSaIS9woCqjz39takkjdCM6Uxut1TclyBydgj5z5X2tB0xvc2baMhKY4Gpi2sqKO1XBsSelmr7288EEecPb2LNNBfe95zGfCeY9P5jBOfdxuoj67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(66556008)(66946007)(76116006)(66476007)(91956017)(66446008)(83380400001)(9686003)(38100700002)(38070700005)(86362001)(82960400001)(122000001)(6512007)(6506007)(54906003)(6486002)(71200400001)(26005)(186003)(478600001)(2906002)(44832011)(8676002)(8936002)(33716001)(316002)(64756008)(4326008)(6916009)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vkqZspudo3k4ovOyfujr9fciAPhFwczxEAfUXLvHqjDOaJ4ch3yiH/6b4li9?=
 =?us-ascii?Q?M5BNQylJFETIatznu2AAR/OBB79+Ga7+6Bhnww1ZUBzzQBrfN2ZtuGMkVPaH?=
 =?us-ascii?Q?yMiNtbQrKP967/8OAnKTmJyZIwaXiLtKkdQG16elwusbdZCg1IwXfX23X2MK?=
 =?us-ascii?Q?dO9TgQ2Szs5d7q5GSJ7nuMPBpIIV5Jr3YSKe7rMq9doJCPPIyWpwzXSa/pIY?=
 =?us-ascii?Q?wd0U/kaZdD4/kLxQqjY6sUdXjTx7wJpg1MgbRGS8wauHgQvnpgMq2i7VhiFB?=
 =?us-ascii?Q?EjJiAkEHEjWmIkdJiGrtj+gIXmbFcw4TUMZlmMPjuJhK9ymRYZP0S713VWh/?=
 =?us-ascii?Q?Nlw9NziWkl2Fx38zepbY2ewkPhSAfNxq7veFdp0JTYj0001tTPNGvsg6+ALA?=
 =?us-ascii?Q?6hFrWo+pONYtDfasbZTZtk85PSMQeiKshg2xNzlO3UsJ9rMLA9Nn5v8DfN9J?=
 =?us-ascii?Q?Wv7VMXPCZXPPkgJzGAqQfjSGsWRFuFa6J1XOBlAizqD/tsE9t7ianA6FdPQi?=
 =?us-ascii?Q?rLcDKe0EFE8JJOnJ9yAHYRo/1/P5i3kkmy9DfUX8yPiOZQbqsrCgBCxr6MyP?=
 =?us-ascii?Q?dxpKRGK2QtG1kKZxyUVIFMlcqWbgdahl9SjQH1nsMD+Jejz53JwCb3Qp6Sk6?=
 =?us-ascii?Q?SB9LeFsnDeYNzLiPPRUJ6BlGXFgQbpICovRVcllfDtXKxCyr9nxvDpI6Lsln?=
 =?us-ascii?Q?SB8ZzcTEKF1HhszeUUKmrcpUYAunFD4yzWmjQhDKO/tsC7h1y89PvUto3DaU?=
 =?us-ascii?Q?v86kIYsXhJX+cOnPLAMq3THBTMRGVTPtnroVFprmgGLRsMyJyjPFqUGfSqXI?=
 =?us-ascii?Q?SjzDBBr8FbdHVIfQUIMs4DqyJ9jC41QET2V61AF+kR6VbrWQlKY+BGnRKqJi?=
 =?us-ascii?Q?47H+ZdlZfHlfkGCJeQvaD4zrRrZVt6Mudq8qfU3WktL0tqGgA18DPWOHW+Pu?=
 =?us-ascii?Q?E8KblyTGVLyXDv4GEjcBhK/FsRZm5mzPioMO1bihkxUxewcP9HgIK6PTiII7?=
 =?us-ascii?Q?m6MDQm+0mEPy3DjqEAnXqH5gAxUJ1paeCDyun98r0ICF7N/tA5zq0/7DQV6y?=
 =?us-ascii?Q?7KvYEE+IQTRzsuO/Uv9WxkQuIMVK9CabroyPXDHrsx5ktAmGOvHym66l8sB5?=
 =?us-ascii?Q?NUVeOZEyQ9CKrXX4VFqOkqgWQbCLNtOxBA4WsJO5SPz+kzh5pDbDpWQVDUJn?=
 =?us-ascii?Q?AaoVSl7nJamK4rXkRFS3H2ojeHmQkhuu3T3VH+sseVw1nSTR75eWzRfUOOGc?=
 =?us-ascii?Q?4vP/zsqo/J3KjEDog7SP8b9vpN9aUyM/dtgM1yscgg+ZzO+A8AlGR6nqcbxW?=
 =?us-ascii?Q?6uFwS+pGn/C6aqXWyiA65NUh2cLfHzJa52ltVoUq6V1yJMaDsmAdDZqnrv+h?=
 =?us-ascii?Q?4Ry4OAAes4Jz17LwwEr7sRVzF0KEXPxPaotGyAQR+Oge3YDFUtlCUedr8SaA?=
 =?us-ascii?Q?rHH0bXiPXDeecBvF7cP33FVqIB9BXogWuuN6CPIAVbAa2jClUkAGw6dtfRmY?=
 =?us-ascii?Q?b50aK1gHesMAdtA+lbYigJ8NRQTA71J7vB2mqpP8nb0NUCsTmyYrs+5+zkwB?=
 =?us-ascii?Q?+vkPWsZ6IF4Et3+IwFvf0b3E8c/35y1WCBrOPYl6LfAA6w2nqp2yjwlJHotv?=
 =?us-ascii?Q?D0JFuafO1jR3C1iCe0Kcr0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44C882011BBA3D41A0054070E19FBA6B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Td7eZlvkIzUT4cPAnzBi7FUVS4z/sguPI/QJnzxmLu7Whr1LcafCpk5X2qew5sRJuiDAfq5Hr/VhVCwVYJzoR2MoKusBA7BBeWFlCNq4XZ8rn17ga7EIVS94Hn6mizkTAit1fdnQBTaAcq3JWBajulIX8Ss9JdTxwb13V6Gct9Dr3rV9eviEfXQ6mRAWTE7JZu3IJ8vLqKzay2NkEqhzdGai2OEVMUasZ++8s6b4zq12IGOkEp1s7482YliCPylbZMN1hX9p6mhQUljjAKYzM21bWuilaM24x0cZYK0HYKoKewDOcOfiRd+pgx3uZ9raxa7qPrZBbNwoBKVrIvTzHHYMbxrESXJXFZi1vR9Z5Rd3ciLBPN0EaLka0ElantZAFZdEdrZBEmmSturTfQLpODNzIxtlAIX/HAXbPpAwGZ+ae4jC1GQ168USYB5qP5RFZChdruc9+3hr5XkC/++Ek9Zv0ep75aCPWnPafsKN28JY4/zhg/DWMW2tCRewd5y9vum8QPOAMZiLgbAbWKHc710lQ/2an5zi232/A9gS3PvMPEIoQBkcdwlfmliNjBjxG0/NpWm5atbn+Un27nBe3GUjjA2UkSxYSfEDtfCvWy9OJ/a508ncaKt758QM01myBj/W+CPjzCcsDUiwvRlMjazexqxqOo/NdZ+sQwZvBJsYwil8KL/TDVmf5o6e9veUvbnlS2uIn+k+dThtDiI2uoJ2plV4L5WxTk52dVjkf4lxrws5fRTfwwUnAUbTdTmozgGGKe+l2T8gSX6ElbEodzMbX2WlpqqqreiAc8zHBks1xFXzya6kiVT1Dq+j0lxu7gBgyv31nAqb+gRfJGeXE9tpAiV7JPHB31pzu5n1UXhi8yl4PHS4n+HEnp8vcFrB00d/dzpr/T0jVlRb4IZJVrlHXzZqSbLQ16fVXg9oadU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e5f2f8-304c-4675-068e-08db4f532424
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 23:31:10.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fa+Gb5UNc1oCstY50/WYgjnKrRZlH0vtS/VoriFT7nDivlE7RzkzHhgZcatAr3D+rIJMqv7GI9Trrn14gN6W0f+rlfXrqPjqYtg5XnY9C7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7348
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit title prefix could be "nvme: ". And please find a question in li=
ne.

On May 03, 2023 / 10:02, Daniel Wagner wrote:
> _nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
> function. The jobs size is the size per job, thus we have to divide
> through the number of CPUs.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/045 |  4 +++-
>  tests/nvme/047 |  6 ++++--
>  tests/nvme/rc  | 10 ++++++++++
>  3 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 99012f6bed8f..f50087cccb6a 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -31,6 +31,7 @@ test() {
>  	local ctrlkey
>  	local new_ctrlkey
>  	local ctrldev
> +	local rand_io_size
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> @@ -120,7 +121,8 @@ test() {
> =20
>  	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> =20
> -	_run_fio_rand_io --size=3D4m --filename=3D"/dev/${nvmedev}n1"
> +	rand_io_size=3D"$(_nvme_calc_rand_io_size 4m)"
> +	_run_fio_rand_io --size=3D"${rand_io_size}" --filename=3D"/dev/${nvmede=
v}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index b5a8d469a983..6a7599bc2e91 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -25,6 +25,7 @@ test() {
>  	local port
>  	local nvmedev
>  	local loop_dev
> +	local rand_io_size
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> @@ -42,7 +43,8 @@ test() {
> =20
>  	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> =20
> -	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
> +	rand_io_size=3D"$(_nvme_calc_rand_io_size 4M)"
> +	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${rand_io_s=
ize}"

Here, _xfs_run_fio_verify_io is replaced with _run_fio_rand_io. May I confi=
rm
that this replacement does not affect this test case? Same question for the=
 hunk
below.

> =20
>  	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
> =20
> @@ -50,7 +52,7 @@ test() {
>  		--nr-write-queues 1 \
>  		--nr-poll-queues 1 || echo FAIL
> =20
> -	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
> +	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${rand_io_s=
ize}"

> =20
>  	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
> =20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 0b4d5f6570d6..268418e5b3e0 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -150,6 +150,16 @@ _test_dev_nvme_nsid() {
>  	cat "${TEST_DEV_SYSFS}/nsid"
>  }
> =20
> +_nvme_calc_rand_io_size() {
> +	local img_size_mb
> +	local io_size_kb
> +
> +	img_size_mb=3D"$(convert_to_mb "$1")"
> +	io_size_kb=3D"$(((img_size_mb * 1024) / $(OMP_THREAD_LIMIT=3D32 nproc))=
)"
> +
> +	echo "${io_size_kb}k"
> +}
> +
>  _nvme_fcloop_add_rport() {
>  	local local_wwnn=3D"$1"
>  	local local_wwpn=3D"$2"
> --=20
> 2.40.0
> =
