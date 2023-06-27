Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D473F9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjF0KPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjF0KO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:14:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CA8F;
        Tue, 27 Jun 2023 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687860832; x=1719396832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NKlfNcs5O2hMwp7wgA5GL2bKRl+6Kvkwb9pgL9KKfIY=;
  b=nhDrWz3uluwmsQKiTnHPqWcpPb5L9grgx94txwfhipt6RFHoW3dB0D5R
   ED7GSJS941kKDc/TdQwOQYYyH36VVofczGjCvwe/9HV4WNJd9IioEQDF8
   7KlwzSKi5tvvCUa8Y2BAsVHWgjjl8Vzm6LReCA95Af5HLh3sQRmEkKBJW
   ySFEdXTFxGdgexX6I6ZqAdXLpBXHdSAuJyF8B+ISHRuV1WgApDnPdugvF
   QZXRa7uYaqwMSTp1Z8alTXSgMsaiBnUxiDXqRRGVJ5Tk12MCOWW61DxUU
   m/HdbkaaUsvo+VI2TuKGuuq6XQT1AKFeH6NbOVQ2OLjkwW3SsxryVWGCh
   g==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="241316763"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 18:13:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYY/a3XHDRkegJXdwRww4baHEvDpzE4AfSs+3OH/Yv5w1+sg4+Gus5vZxrNylvW3jHFGqKP4kDiwZf7vLTzWVSf0VSFBGdV4I6k6IRxv+6Ljb88syxHUsL5Ighp4LEMU+Sf/dpQYEPQEwm12RS5RLkybjWWqeBr0fWQFnBGrXDlxo/bxJH0WjD8AhrzBnLkf4qbHzr3ZFGj5h4dG6Z0bGOokUT6QKAVOma7UX2fMU6NGV1DCTh5fzGSD9Cc2nSDqAbBdmQQO/wE0C2m4SbP7buNxoNfSg+4/yDT8uXiYaaYHfqAGjLqlWmub7feTCgqyKmr3uC1YsH0jqR7Gw1W4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKS+Nj5gSBc4PucfpjbBRW8vq/gXVG7WX/293DPgn2U=;
 b=Hp9R1hqSndKiHVcQs4WC1WCUj6BDXwySDROM6HeHRzdhJdzpc65PJyaQ/uhWZzcDUgjSEr448L7H29d4wtNkmaTRmerEQ7UjxPKOuSkUrWwwO7+l6gWfvp0K0GYq+XX1D/WWbwGruUcXm7NDSPP7nXcosCvbl83l3rHztK+5GOUkPeWDLJmtV711OtnqOz6QT7zFz26sHKpxsug9LmpN3VtO36yh0Y8R7yqmFzSrEQ42ncb4GN7wsmq86x+0w2fyhLqjGGTLUveM8KPdQ7Bc04cwVdwXOWlZ2OD1PbGzW6JBpoP0u+uxL8f7TQk/M4vvtMB1B0unH5a184RBQMhucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKS+Nj5gSBc4PucfpjbBRW8vq/gXVG7WX/293DPgn2U=;
 b=TV5iy12xyDZGommC2gVx1P1QTKzfLWhvbeTNH1dSABTmus00qLIGCcKyGrR2L4ooQr0vEj7aMTI+BdBxWKHs+H1OJmldPWbVG58CX1W9U+/dgBwDWB96PlBHr1yU0o9VXT7aHdrZxNaX9nsw4YRmEzOKIkQ0IEV7M0WPwf6IV4E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7376.namprd04.prod.outlook.com (2603:10b6:a03:295::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 10:13:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 10:13:48 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Thread-Topic: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Thread-Index: AQHZqOAQp/zesDwy002w2k4L06XaGw==
Date:   Tue, 27 Jun 2023 10:13:48 +0000
Message-ID: <6he5owg5e6h4vq5uwhw7jo3cncwrrlgjdxnq6csr5wlopbwk5c@l434fr2edukp>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
In-Reply-To: <20230620132703.20648-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7376:EE_
x-ms-office365-filtering-correlation-id: ba43dee9-c5e7-44d8-d330-08db76f7330e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X3/lAfGgemXRPl2STGPxrtqnZDx2Bf+X9EcM2ALSwVby5g1+FagMx5bj7qiPs/PXUhRaistZolIjG8ZtSTxEOEdCDRhKjt2fkyFPYNgpGSdF5sudDCI/r7DmkK2F84v+slTFcNdWoYxfWj9S5J1jVprHsKZ6Lr+mU6TbtFmvTptV/z69Q6u+e9WobYT4ZXSmwSzw/Mh0ipOkEopZyZXmpStOVYRyln4YwaACogmT3ivonxhbifGHR/baPnKXPc6lB7r/VGz78LZTgQ40O4Q3e0xXz3WFb0eB1dwamib0qP75YzPc8WPSGWGcif0OtYPLhDdavJTA+DhSxoHDRt21XD90Krto27fgbiy42Xg9dCa9+KU2m9nK9Kdur2piKMxZ3MyVjXCCqWJe3PzKqnmwIEzcL6Gis1IB3jCEQd+r+Y5fkgm3pTgP9MIUWhvY64/4PZSQzvvJBrYW3ABJLCRlPLHmwF71S/3hFcPlDok5wcXZgbITqWz+9fs1ugTJV/wW5UigqQC4hCusfwPGRlZHZUogOk9Mr462mlyWlefbEp9MJlbQWD6Yazg+XEq45+RjpUuOF3Su+tSuP1QRQfQr6JZ4+B7LwWH756Zq2Pk286LaCv9w3rHZNkxhDepApwLu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(54906003)(6486002)(478600001)(83380400001)(38070700005)(82960400001)(86362001)(66446008)(66476007)(64756008)(71200400001)(33716001)(9686003)(6506007)(26005)(186003)(66556008)(66946007)(2906002)(6512007)(122000001)(4326008)(6916009)(41300700001)(76116006)(38100700002)(91956017)(316002)(44832011)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TtgPO91U8yQOj4JF+VZSzlGcAqjPMAPUY1sGPgVCS/Qe++Dl55Td+Rmyal14?=
 =?us-ascii?Q?F2ZCpqXDfNsYIz5fv3NkPBTuitoy3kWO1+RVJgvaNVLAsdnDJkblSt2J6GDu?=
 =?us-ascii?Q?qybtdjugzJlaJBthtZjH8tsPwiXCaCKyI5wRd+qY1NnazhJAiKKcaUVy4KJt?=
 =?us-ascii?Q?nIuO+7AMf2QQ1oueQF2aFHhIBjvX4Q0X5eUARDt5hVv3i9OEWqAntnbRjYje?=
 =?us-ascii?Q?OkHFeIDGBKfno5Db0ymHmLUNnvqp6U33A8lRtX7ucZGcIFsTiR5dczFcDOFr?=
 =?us-ascii?Q?fEIfGhDXC6YVhOJ65Tp0oIPSQvYIXByULDGa9WNXAv1Hw4RewD4x84ewpylv?=
 =?us-ascii?Q?+7inUsZlCdpM5aBvqOGZhbq3QV4ZC7Nana2pxIkO1q0S8dWRux33QdbuMKWo?=
 =?us-ascii?Q?AbH+2UCIiqabi0hEzO/kEjs/PEBOrJqQu6Lur+YXT5+F3a10yk/PRF5lGjlO?=
 =?us-ascii?Q?+W2xHjGsTXn6qgwo87YoKPLTdlGLEzJWH7DBDZckibES3XAjIzM1CfZ1BYXj?=
 =?us-ascii?Q?wAzWEAo4oanvX4oVfhe65zgcJLz5FcS+wDIRnOTzsjQZe6qNC8/fPpZhAOJe?=
 =?us-ascii?Q?LLqz3DAyuS9JormZeT8//tF90JD7eotNCeQdv1njTOyn1BWgA9a6YNjMhVfD?=
 =?us-ascii?Q?tEfDAfRnzWnp1SiM5qQy4L6XLNLYe9dv55O9jX5RDKbC4y9H+8ZO6zPgVcrW?=
 =?us-ascii?Q?Ym5e7XN6Ou2G/vNDls3TtBi/jSm3u+JGLkTh4RdzwEes1/WmjVIzVlDuTQJ8?=
 =?us-ascii?Q?fCtywGoZeyrCt0Jz6p0SPDYP+b0IJNt0wessM+FqM98Tkty8dGYFMxlgUfeA?=
 =?us-ascii?Q?IRw35JqiLU0N4+gKNsQFXEP/ojwBHfCrEqbFkKWZ3B1D1Q07cceYaGd79cyi?=
 =?us-ascii?Q?lbI1pzYgC2iQV1rlbVdFJ7neEok6hLQe7BpyaAjsidSlPD7i55VF9PkgSwIH?=
 =?us-ascii?Q?rYN8nWBRzFcNxgFE7CNhzPt3peRgMrRymJKHy4XnZBDkw7NsLQIVHAesfdAw?=
 =?us-ascii?Q?wbcLbLuTDjdQ5hUu2Y6kIhgXj0QgtZWrofzFeiC/AQRV4kgu5DZtgXCcinxd?=
 =?us-ascii?Q?YOlYRFm5gC3OOdJBYVIFcV0SWG7iG61W2OvWweNt5+GS8QXcZOa1VBMBubwv?=
 =?us-ascii?Q?qUUetTzGFJEshSNYQB7lyvJExIJR0BUwg6tSerWZsaGA7zvKZGq2P75HOBOg?=
 =?us-ascii?Q?Vf7OimI71o3ZAh1yAHnQrDxzKopAJCNb5gpDxSiW3cuLxeLIRjReTLvo4HxX?=
 =?us-ascii?Q?VhUhPsPyG5S3rEwcNGBx2tJU/BEwZ5bGEuFKoe6QGvfPMoFyAeSUK4v6KEus?=
 =?us-ascii?Q?LUhC++5Nchy+ct2pkz8amNHwACJL16DRkY90UGKfp1r6wGhiek/3QoXV7Dk3?=
 =?us-ascii?Q?7omRDREhN/ogAXdFep/3EDqCfv/n3BLoRVLplgl5i9Uwel3XYTz9Bzikr9KK?=
 =?us-ascii?Q?MFnpIgr622RbfYVNUrXmBduot9QRsimXaT4L9Sti4Aznaav+7coVCkitZnjX?=
 =?us-ascii?Q?e/uixWjGFXtJPF6vQhjjVIK12DLzdQhbdvWiLV0HyMryogc8Z7BDvK5SfIXG?=
 =?us-ascii?Q?XeihEM8MWBsTDu+B03K5r8dwzGacBeoB8Aa6BqD8yhJV75nDLJGKxvJqBg2n?=
 =?us-ascii?Q?H/cD8KiBt5SxaMpbIaYd1SQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48B068DF7711C842A8A428FB18C89460@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZbL1ekFtHHrBAB2SZIpouC/5JxNnbCb4hKEIYYSxRZA03YMlnAGYvBfT8Jxq?=
 =?us-ascii?Q?SgvSUY3FqlCy/NlLG8GqZOYaGsTJEoVrYSeohYluXZnKrB8CA7VO5AcfOQGL?=
 =?us-ascii?Q?kNXb5nLxJiBAVLXyYaf+M/5m7qqLNHRi0o0FpdG90WQ0FtVqmAmsxcblkvHz?=
 =?us-ascii?Q?8ySg+zcN+KPd36wT0C89qZQNB1VzJVhsSBa4PRESM4eFuUDQpvRpqE2KqsAb?=
 =?us-ascii?Q?fihiGz9d6YSyR2MzPpSyfsgKY2WlVIKkzF+X62eSYo36MURoDCz48cT/MXi2?=
 =?us-ascii?Q?njunTG1xU1Vd7tEdX9xsIORWhQNWumj3UiWujn4wVIx6YfQ150A+OkjbXQdh?=
 =?us-ascii?Q?Lq6pUh/zhSLc/fVwNsgWN5MGQjadhSiHrU6S8xliIdNwoX9/Syjr275p1h41?=
 =?us-ascii?Q?c3rYJbiJhW5kkD3MT2C1nFn/p2qZ/j1B0MdxtTaapzWdn2JSMBirRhKHIAZ3?=
 =?us-ascii?Q?5ANkwmnXI/qpzUZwGy2MTQQvFEBSYPopZo21Lfg2e4/ExuVaes4hH9gFMSs9?=
 =?us-ascii?Q?aWhTGhZPu5fbNN6Va6pY/t2oMCDPeqdxKMKadmuuACJqPbORaZJyVSRow0aG?=
 =?us-ascii?Q?J6VtX+nWi/J3MwDcmDarFbl/LJDyo0tvw0ZGYv7PnT0wZvanaIfCcwtNVh4A?=
 =?us-ascii?Q?NX0W973JwkldOz6Cf5x0VhWAV7aBrxxB9NyCUyHDXNXdlvHzvpf6TZeAyGy5?=
 =?us-ascii?Q?YgYd6TVtTGmAYj98MBYMdexFSeOR8BoSu2fHJ9307rXxlWs0owJ+CM+rsPCG?=
 =?us-ascii?Q?02FAhY/Ol0sM3w2VhhlzRS9UxOB2O6YZUfmCuCoepYzs3fzDe1RvlX1oHC8r?=
 =?us-ascii?Q?2IkjbPxoCXq5YphZU2gO0opldMNFUIcKe1a87AkVkUPuFKLfjIT1vg+bRHZS?=
 =?us-ascii?Q?wSso/JpjfUtFQmId/WUIVknv1fVndEdBNEWdlmq7HOrrnzrp601bgoOJPgM5?=
 =?us-ascii?Q?r/g6kKS32XLYoiOjc0koiQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba43dee9-c5e7-44d8-d330-08db76f7330e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 10:13:48.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZyx8Hbs1TGDUeYQ0T+CzOqEDgQGz8gRrUk7vpEfbkQH/b0IprS/iodDWY/e37m/LXUtFJ1Nlk8OqF3bdrMQwgOcMSxqo+59AiDRHf9YX2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7376
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20, 2023 / 15:27, Daniel Wagner wrote:
> The test monitored the state changes live -> resetting -> connecting ->
> live, to figure out the queue count change was successful.
>=20
> The fc transport is reconnecting very fast and the state transitions
> are not observed by the current approach.
>=20
> So instead trying to monitor the state changes, let's just wait for the
> live state and the correct queue number.
>=20
> As queue count is depending on the number of online CPUs we explicitly
> use 1 and 2 for the max_queue count. This means the queue_count value
> needs to reach either 2 or 3 (admin queue included).
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/048 | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index 81084f0440c2..3dc5169132de 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -42,6 +42,26 @@ nvmf_wait_for_state() {
>  	return 0
>  }
> =20
> +nvmf_wait_for_queue_count() {
> +	local subsys_name=3D"$1"
> +	local queue_count=3D"$2"
> +	local nvmedev
> +
> +	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> +
> +	queue_count_file=3D"/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"

Nit: queue count file is not declared as a local variable.

> +
> +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +
> +	queue_count=3D$((queue_count + 1))
> +	if grep -q "${queue_count}" "${queue_count_file}"; then

Does this check work when the number in queue_count_file has more digits th=
an
queue_count? e.g.) queue_count_file=3D20, queue_count=3D2

> +		return 0
> +	fi
> +
> +	echo "expected queue count ${queue_count} not set"
> +	return 1
> +}
> +
>  set_nvmet_attr_qid_max() {
>  	local nvmet_subsystem=3D"$1"
>  	local qid_max=3D"$2"
> @@ -56,10 +76,7 @@ set_qid_max() {
>  	local qid_max=3D"$3"
> =20
>  	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> -
> -	# Setting qid_max forces a disconnect and the reconntect attempt starts
> -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
> -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
> =20
>  	return 0
>  }
> @@ -77,12 +94,8 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	hostid=3D"$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid=3D"${def_hostid}"
> +	hostnqn=3D"${def_hostnqn}"

I guess it's the better to move this hunk to the 3rd patch. Or we can menti=
on it
in the commit message of this patch.

> =20
>  	truncate -s "${nvme_img_size}" "${file_path}"
> =20
> @@ -103,7 +116,7 @@ test() {
>  			echo FAIL
>  		else
>  			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
> -			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
> +			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
>  		fi
> =20
>  		_nvme_disconnect_subsys "${subsys_name}"
> --=20
> 2.41.0
> =
