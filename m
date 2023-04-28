Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D567E6F10F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbjD1EIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjD1EIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:08:16 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553BF19BB;
        Thu, 27 Apr 2023 21:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682654892; x=1714190892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FgEr9+C3Svsa7wsmSq32IL4QQNw+K4NbchVHKBECISQ=;
  b=ieUplyiL/W4h6QZ9PKB8nR2ZHIIuF4/JZbqe/cCAGAQQ2dqpMjEWhIxl
   +d30BRv507DHaf0LfthzRlO2cA3NRNMizi5ZhVpf6WsN1plVWMgwNhe5l
   +zfXk8lbAAgEcgp3mSq808ooY2X1CbL5lKje5MXFT7+mVV+o956a8woA1
   tctoG2PHp0sPhwULQUoTd45MAqARyRRMl7RBjftB/AQbcwSsR8ihsa4Fu
   kbgDbF+VRgNB4rdR3pEH75f5bEWBuBhCP4glSZpOGFq3sYfd8THmaq6/6
   Zu0yDqHihlHNd8OAFVQ+3K7RUmKJhtAiWLBguX1AehbDXEu1YEQjOZnOq
   A==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="229366894"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 12:08:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH/XZJF4HBzuABlOeLrrojO2C7mP31Zfjr4kfhGEX5VJlQ1dZ2TR1RysKDu6zJ04yMcmBEwt2JRShKyuwbB94hCXoJKItietLt723csSeooYw+lDAGZXkuxTaE3H6aph0xvpWr80qehhV5H1vlNK6h4L2asaGh3PF42ncIbgQyhJ/4UXSrx8moSb52bPpyNIzU69OIWvPLsFYVuNsUeUixFKwAAZF40173GZF6NBcjFhZAupG4IrRe4sepJqnGP5cLxvLidkV2LaiszdqSb/tIlHRhxztEN79oa2Y5uux+kQA+4vq12XSGl5KgUTV6+KnJh8iX/FVdQVtrLQ/lv7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQY0hYyULa+8Umkvx8bGl0q1H5047KrGuyyEWVj+/+0=;
 b=JJB40CGUXc0gK0xJUAivsf17s9nCOefaVDLlUqL+clDyMYqia3ndtjND0qdwO2kIE0HjQ4JReuo0f7njxxW6FYUT1yvtwcDKQbHBqyVzR+FGXO+BpFRBGMDiUM4pc4dEK2ReUPo/Mr4ZwccBtBMNqB5sjwIzndP2eQYpCXcS3kkY/q24uJ+1ROZauJ1ncwYY3pZUUgnA4UVQcVysZrAElamgYViLJ1usmSECwkL4GCGbwhDUYSB2hOFTPmsTvmn5eNWx0I3NhTwIWajNuxS0isnAUx4Yu369Nul5J2T35DvDEuFtBIy9wnK8OaECozb6VXMqzZP24dreUFwMNMqzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQY0hYyULa+8Umkvx8bGl0q1H5047KrGuyyEWVj+/+0=;
 b=D2bZPjoE02sriqRvqtW7hruVCPPjtULEPnEu6GfkObnXD9TfUs/0SPgGUnjLcMQj7dkLuI0lWXpB9wf+lJx+zqgyPgtQi4l0V2loLGC0tv//IiT9ddPW5AhHNLlt9set2kMSKoAPA7nkrMqfg7BfKdfWymH5V4Clfkr/HsRSAug=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6757.namprd04.prod.outlook.com (2603:10b6:610:98::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 04:08:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 04:08:03 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery generation
 counter code to rc
Thread-Topic: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery
 generation counter code to rc
Thread-Index: AQHZeYcHixpAexx2ZUyKnK0fVymnFA==
Date:   Fri, 28 Apr 2023 04:08:03 +0000
Message-ID: <djhuhqaxi4rtwcyl4eqjgz6xg3otzj5v2xmbhyyaxtxlzfkmy6@koj7fnhpotog>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-9-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-9-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6757:EE_
x-ms-office365-filtering-correlation-id: 7ac8ba1e-9a84-46e3-b896-08db479e2a0d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ry8mDijmcXFnHVbv4yZinL9xlGZpmKYsa4zYVZyTyQTrCTB+vb/wFEBA7PRQsWhsUlTiipCBDYg5x59u4cwtnBiUZ1B44V1KbE/7VqKALbN1pxsbxi0bcTSUXSisE6EVlmgQIj/NG6KjGwkW/BDWrON9FJ19eK1eqmTpjlMmLW0x+ZlMX55T3yJG6YFPuwBWR8fTCXVIhji/ZZ82VHLjB6G/EBYsG7eDly/+7+TwC/M6IDlffGj7SNOovJJgiLHxaiFBTKbbeWUtdfLLE49KIjD7xo/T6oEfdDVMwv78O/njq+jaCGpKycB24fHpjkargnfYPa2psq2DE5v9k8nRezCGn5JwQz5YAN/XaCSyY+HkfRjbkktD2UsY7IveFjM2uGgysH4ShW518hqc475EAIjhIDiX1vx6VicgIx2qxw5+Se9Mnl6dzKb2GkNsGbHBCl9vM68zavgsz7pmBtRBtJzz3FzFCz//oKWYuAMR//rfq30HnO1S/uKX9Su+29TVnNQn6+F+Ae3jimG6TorchwEkH5HWSp1GmY9Ou2VplitDxooOXCXmcM/TLAuU9uXigLs6hV3bRp6YtkRRBu/ML4DSmP9jMAFkkbS0YYMYnb4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(26005)(6506007)(316002)(66476007)(64756008)(41300700001)(66446008)(4326008)(91956017)(6916009)(66556008)(66946007)(76116006)(122000001)(82960400001)(71200400001)(83380400001)(6512007)(33716001)(86362001)(186003)(9686003)(6486002)(478600001)(38070700005)(5660300002)(30864003)(2906002)(44832011)(38100700002)(54906003)(8676002)(8936002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CneiAL0a1kBZebOxKtaOfaz+nIU1rudB/MfZAbXMNOeuLStQmZHmeR35m44B?=
 =?us-ascii?Q?EEXjvRgkgHuxGwwfk52hg0Fk6lhCcbjFOJY9DksnSD2OeXXRAiXVku+byGmI?=
 =?us-ascii?Q?nNUz2q2PxWcxhCW0cWWdRI/rq3/lG+z66mUjUsWdWJjl1bgQdBaKGCKabm5Z?=
 =?us-ascii?Q?5lD8/xi3GViJWuVUEHo01nfka5GNpUAB739GJX8Kyy8K/2Ai/ElQOxf2v5mK?=
 =?us-ascii?Q?jc5PvDxHBaDrUP+JIWJj1MLAxmLoFwXoNQsvbPatHQejWfb1jE40r8SZp3rA?=
 =?us-ascii?Q?C9iuISQU/F4WGoM+hhx3uo8ox8bduZFxQfYKxF5C8pfQXC19b2y2/BFkSppV?=
 =?us-ascii?Q?2ATjfmdnD7qjCzGUmYQAGIRAcfAKCyF8mStohqugWBZGGVknEJBOpI3G3F/7?=
 =?us-ascii?Q?I0m/psnOvvBj/JbaLxQxwtVH31YXDwDGAXVq0/AdTRCHAwe0vfK67iS1KpbO?=
 =?us-ascii?Q?JKhThz0DMvyfmGNCMHLjP/YvAEdxFXjdbXVSOJMWuZqK66cBe9JjRd8XHvjl?=
 =?us-ascii?Q?mlhcT53120WH2u1+W0smX6WvEPD1c8O7rSZcRf0EEGGXx5CaHfIUfh9FW0ZR?=
 =?us-ascii?Q?NGn/h9MZc0AJfBqMWIHfJJKq86aD9TpGWNDkEJVXI644vu7hwlCSSFtbVkPL?=
 =?us-ascii?Q?QKxI2WiV2Pnq5zXdTHbaA85wIujvN9M0WK2byZ/N6IiZYIhaaA0BjzXm6Aqg?=
 =?us-ascii?Q?0MbIgEHpDm3xCvkH4UhK8tSDv1iK+PfMky17kVeFGgcuhFO17S1hUty7Ei6x?=
 =?us-ascii?Q?5vikxtipnufYaw9X+IAFxkIGZBA9VEioAmnVFnXbgL/v1qi3TxCYV2Y1hzIm?=
 =?us-ascii?Q?8QtTrcTIepLA01ywYK5aJXL/M4bLhggrHnGppHuwEmx1Lj/hl05n6qZ2wISI?=
 =?us-ascii?Q?E2vLCMk/MjZNo/Gd4Xq5IPlWj/Z0lAFEIYjsTa14FnoEUtmekG32OlguRGJB?=
 =?us-ascii?Q?VpiLh3sWrL3f5neEI8lTUCWqkNlzvtf6DEkCDZaMVYNTejx3iBSJu1R/E2Ad?=
 =?us-ascii?Q?/qWP5nvGZvb02+Dkz5/tXNC/UJzg3HGjGMoLk2WoaZ6+WLokphU+tDjWpTVW?=
 =?us-ascii?Q?GUTMLuIRwy4AwKks/lilVTi3IRwGU4XGQDaaBShAmN6KHVOXqRF4ZZ7i6Bud?=
 =?us-ascii?Q?TixsvGG5GV7ONP1q+cvd+WPuwth+CiwhxLVJDutBdUC0MUk1HvCxs65NQYfz?=
 =?us-ascii?Q?bvEsLkjveuJinQ1rM4y2ftnbBK7HHMeJmCqPwsN7jk8o+OclH9Ftclpkh2xE?=
 =?us-ascii?Q?0jgFAj+ay6G/stcojdjTBT95CAUUiRgSJ31U9ZHMX6IsNEM9LPC/Pa7sHGFt?=
 =?us-ascii?Q?ToFMN5W++jEcqlkHyr8Kt6ltov48wbHgqzvUNGhHDLVl43+KY5A+kLgfwiTL?=
 =?us-ascii?Q?0bOTZ0fE9wkokPwv2JDHuzAcqQftUU3LEXwvmnv211u+QhpYwmflJ1PDiRqx?=
 =?us-ascii?Q?DckR4hR4tt1l3spoh47ZZWIiaOjt5nyUydq7cTIidnoWO3s9bNI49vJLQNrr?=
 =?us-ascii?Q?GmIqJKClrxw/tY6kRgXwagPJRbrTwO7eCxQkEKBjJzhwOq+AnFY67yaRrOoc?=
 =?us-ascii?Q?wml61SPu8jUqH/1vUD4LBW3EvyVPXIu0VT6CTVHIMV58eFsPeThv7LoGo4BD?=
 =?us-ascii?Q?9NAn9TEu9MpzPq2vSTeIufc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AB9CCAB12E49C41A9EEDA057A46C7D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7QmXsqXKBz2X0BZvOIVC6kBoZD+J/ewqsnYvcgE5lDbd1mzvmwxPHlBko/F11CKxX+RBaBwSbY0GPl/8l2Lqt7xYLFajiq0FoCF9hCpgtKdpyE+v957IomW8Y3Pi5IyRtBj2JUtsXgR36l+YNmVcZ5jvwc2EYTrscXJtom35nBZs4vlNQoYe6j/qobW2COUx8zcz+btIDe2jGGDtnsh80kYUMgH+kWjGInj3Xo+2Q3OMaBravMZhGfT8DIJ34PBSKOXwIrBXgAbJW4NW7YHGXyV0cptdIrWcZqPOdBWYqFfwcyPgG/T/Ks44gFZVsyFe74sW4JPBGXxcuJgazK7QhNpCNRkTRTfGhz57tfbOQE/EyQ4byQUFbpq+1VsvA3luXxl4l1tN5vwLLCnIACgEzb0cc0k/JsmG7R6wrygydPluxomuB0ESOmsBvVFcaJcUtfaIM0cjyEuLeQ8lBBF9sR+71E4sDQT9RUc646SFuGI+BlSYO31xqCPMMVQ0vpJTlrmA+sWJ8nsz7HCdKWzpAgXhOd+NvyrvbEPH95UU8LeX9JUKZuNjYMcmP2feqb4rbP2rnOygV1fGd0fiPcRUd6SBpLK+qkZpKUSfC44aq4bpxYl3DxOrbIe2e4QO3EZhnpNCyY9c6AgQROkpwEkn9QL4fFSmg0JAff3wmV3XAf8XeucY/tu93VvO11nys3c65SL5aJLfA8IwotGI5v51OUFYN4+RlDifIjGN9kKBOEJT9RBBFa7iuifIVgLXun2YYaJqcpV0YZV3zsw4Ud4w+77fyymn3CsaQuXkfA90aUdu4QR1OuPhu7T04iEeVil06AzdZwMNNRcV7OslQGDmuhPGhv26D61hzLmXCCZ9PzbMcHM1Ys8JzfcvOcWqa73ywOue51iCILS0tCpJUYTL0bC80GY43PuJFkYZsmQGCWk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac8ba1e-9a84-46e3-b896-08db479e2a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:08:03.8644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY2JGA5YV9sl+F8fk5BxhbN1dpVq8bfWSoo20ygiSuLRhAVKSM645HpwteOrdWvo/bwltPhU69kdCVN8LR/2F4VTHXi3VicXyFjv3guIXT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6757
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> Move the discovery generation counter code to rc so that we can reuse
> it in 002.

I think the core change in this commit is the removal of discovery related
messages from tests/nvme/002.out. It removes the dependency to the iteratio=
n
number constant 1000 in tests/nvme/002, and prepares for the next commit.
If this understanding is correct, I suggest to note it in the commit messag=
e.

>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/002     |    4 +-
>  tests/nvme/002.out | 3004 --------------------------------------------
>  tests/nvme/030     |   22 +-
>  tests/nvme/rc      |   13 +
>  4 files changed, 20 insertions(+), 3023 deletions(-)
>=20
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 6c6ae5fea89b..6b8484844b4d 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -27,12 +27,14 @@ test() {
>  	local loop_dev
>  	loop_dev=3D"$(losetup -f)"
> =20
> +	local genctr=3D1
> +
>  	for ((i =3D 0; i < iterations; i++)); do
>  		_create_nvmet_subsystem "blktests-subsystem-$i" "${loop_dev}"
>  		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
>  	done
> =20
> -	_nvme_discover "${nvme_trtype}" | _filter_discovery
> +	genctr=3D$(_check_genctr "${genctr}" "adding a subsystem to a port")
> =20
>  	for ((i =3D iterations - 1; i >=3D 0; i--)); do
>  		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
> diff --git a/tests/nvme/002.out b/tests/nvme/002.out
> index c33d7d306ed2..98554ddb0ca6 100644
> --- a/tests/nvme/002.out
> +++ b/tests/nvme/002.out
> @@ -1,3006 +1,2 @@
>  Running nvme/002
> -Discovery Log Number of Records 1001, Generation counter X
> -=3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  nqn.2014-08.org.nvmexpress.discovery
> -=3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-0
> -=3D=3D=3D=3D=3DDiscovery Log Entry 2=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-1
> -=3D=3D=3D=3D=3DDiscovery Log Entry 3=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-2
> -=3D=3D=3D=3D=3DDiscovery Log Entry 4=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-3
> -=3D=3D=3D=3D=3DDiscovery Log Entry 5=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-4
> -=3D=3D=3D=3D=3DDiscovery Log Entry 6=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-5
> -=3D=3D=3D=3D=3DDiscovery Log Entry 7=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-6
> -=3D=3D=3D=3D=3DDiscovery Log Entry 8=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-7
> -=3D=3D=3D=3D=3DDiscovery Log Entry 9=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-8
> -=3D=3D=3D=3D=3DDiscovery Log Entry 10=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-9
> -=3D=3D=3D=3D=3DDiscovery Log Entry 11=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-10
> -=3D=3D=3D=3D=3DDiscovery Log Entry 12=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-11
> -=3D=3D=3D=3D=3DDiscovery Log Entry 13=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-12
> -=3D=3D=3D=3D=3DDiscovery Log Entry 14=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-13
> -=3D=3D=3D=3D=3DDiscovery Log Entry 15=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-14
> -=3D=3D=3D=3D=3DDiscovery Log Entry 16=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-15
> -=3D=3D=3D=3D=3DDiscovery Log Entry 17=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-16
> -=3D=3D=3D=3D=3DDiscovery Log Entry 18=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-17
> -=3D=3D=3D=3D=3DDiscovery Log Entry 19=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-18
> -=3D=3D=3D=3D=3DDiscovery Log Entry 20=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-19
> -=3D=3D=3D=3D=3DDiscovery Log Entry 21=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-20
> -=3D=3D=3D=3D=3DDiscovery Log Entry 22=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-21
> -=3D=3D=3D=3D=3DDiscovery Log Entry 23=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-22
> -=3D=3D=3D=3D=3DDiscovery Log Entry 24=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-23
> -=3D=3D=3D=3D=3DDiscovery Log Entry 25=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-24
> -=3D=3D=3D=3D=3DDiscovery Log Entry 26=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-25
> -=3D=3D=3D=3D=3DDiscovery Log Entry 27=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-26
> -=3D=3D=3D=3D=3DDiscovery Log Entry 28=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-27
> -=3D=3D=3D=3D=3DDiscovery Log Entry 29=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-28
> -=3D=3D=3D=3D=3DDiscovery Log Entry 30=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-29
> -=3D=3D=3D=3D=3DDiscovery Log Entry 31=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-30
> -=3D=3D=3D=3D=3DDiscovery Log Entry 32=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-31
> -=3D=3D=3D=3D=3DDiscovery Log Entry 33=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-32
> -=3D=3D=3D=3D=3DDiscovery Log Entry 34=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-33
> -=3D=3D=3D=3D=3DDiscovery Log Entry 35=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-34
> -=3D=3D=3D=3D=3DDiscovery Log Entry 36=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-35
> -=3D=3D=3D=3D=3DDiscovery Log Entry 37=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-36
> -=3D=3D=3D=3D=3DDiscovery Log Entry 38=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-37
> -=3D=3D=3D=3D=3DDiscovery Log Entry 39=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-38
> -=3D=3D=3D=3D=3DDiscovery Log Entry 40=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-39
> -=3D=3D=3D=3D=3DDiscovery Log Entry 41=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-40
> -=3D=3D=3D=3D=3DDiscovery Log Entry 42=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-41
> -=3D=3D=3D=3D=3DDiscovery Log Entry 43=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-42
> -=3D=3D=3D=3D=3DDiscovery Log Entry 44=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-43
> -=3D=3D=3D=3D=3DDiscovery Log Entry 45=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-44
> -=3D=3D=3D=3D=3DDiscovery Log Entry 46=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-45
> -=3D=3D=3D=3D=3DDiscovery Log Entry 47=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-46
> -=3D=3D=3D=3D=3DDiscovery Log Entry 48=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-47
> -=3D=3D=3D=3D=3DDiscovery Log Entry 49=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-48
> -=3D=3D=3D=3D=3DDiscovery Log Entry 50=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-49
> -=3D=3D=3D=3D=3DDiscovery Log Entry 51=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-50
> -=3D=3D=3D=3D=3DDiscovery Log Entry 52=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-51
> -=3D=3D=3D=3D=3DDiscovery Log Entry 53=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-52
> -=3D=3D=3D=3D=3DDiscovery Log Entry 54=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-53
> -=3D=3D=3D=3D=3DDiscovery Log Entry 55=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-54
> -=3D=3D=3D=3D=3DDiscovery Log Entry 56=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-55
> -=3D=3D=3D=3D=3DDiscovery Log Entry 57=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-56
> -=3D=3D=3D=3D=3DDiscovery Log Entry 58=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-57
> -=3D=3D=3D=3D=3DDiscovery Log Entry 59=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-58
> -=3D=3D=3D=3D=3DDiscovery Log Entry 60=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-59
> -=3D=3D=3D=3D=3DDiscovery Log Entry 61=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-60
> -=3D=3D=3D=3D=3DDiscovery Log Entry 62=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-61
> -=3D=3D=3D=3D=3DDiscovery Log Entry 63=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-62
> -=3D=3D=3D=3D=3DDiscovery Log Entry 64=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-63
> -=3D=3D=3D=3D=3DDiscovery Log Entry 65=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-64
> -=3D=3D=3D=3D=3DDiscovery Log Entry 66=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-65
> -=3D=3D=3D=3D=3DDiscovery Log Entry 67=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-66
> -=3D=3D=3D=3D=3DDiscovery Log Entry 68=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-67
> -=3D=3D=3D=3D=3DDiscovery Log Entry 69=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-68
> -=3D=3D=3D=3D=3DDiscovery Log Entry 70=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-69
> -=3D=3D=3D=3D=3DDiscovery Log Entry 71=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-70
> -=3D=3D=3D=3D=3DDiscovery Log Entry 72=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-71
> -=3D=3D=3D=3D=3DDiscovery Log Entry 73=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-72
> -=3D=3D=3D=3D=3DDiscovery Log Entry 74=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-73
> -=3D=3D=3D=3D=3DDiscovery Log Entry 75=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-74
> -=3D=3D=3D=3D=3DDiscovery Log Entry 76=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-75
> -=3D=3D=3D=3D=3DDiscovery Log Entry 77=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-76
> -=3D=3D=3D=3D=3DDiscovery Log Entry 78=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-77
> -=3D=3D=3D=3D=3DDiscovery Log Entry 79=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-78
> -=3D=3D=3D=3D=3DDiscovery Log Entry 80=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-79
> -=3D=3D=3D=3D=3DDiscovery Log Entry 81=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-80
> -=3D=3D=3D=3D=3DDiscovery Log Entry 82=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-81
> -=3D=3D=3D=3D=3DDiscovery Log Entry 83=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-82
> -=3D=3D=3D=3D=3DDiscovery Log Entry 84=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-83
> -=3D=3D=3D=3D=3DDiscovery Log Entry 85=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-84
> -=3D=3D=3D=3D=3DDiscovery Log Entry 86=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-85
> -=3D=3D=3D=3D=3DDiscovery Log Entry 87=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-86
> -=3D=3D=3D=3D=3DDiscovery Log Entry 88=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-87
> -=3D=3D=3D=3D=3DDiscovery Log Entry 89=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-88
> -=3D=3D=3D=3D=3DDiscovery Log Entry 90=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-89
> -=3D=3D=3D=3D=3DDiscovery Log Entry 91=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-90
> -=3D=3D=3D=3D=3DDiscovery Log Entry 92=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-91
> -=3D=3D=3D=3D=3DDiscovery Log Entry 93=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-92
> -=3D=3D=3D=3D=3DDiscovery Log Entry 94=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-93
> -=3D=3D=3D=3D=3DDiscovery Log Entry 95=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-94
> -=3D=3D=3D=3D=3DDiscovery Log Entry 96=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-95
> -=3D=3D=3D=3D=3DDiscovery Log Entry 97=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-96
> -=3D=3D=3D=3D=3DDiscovery Log Entry 98=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-97
> -=3D=3D=3D=3D=3DDiscovery Log Entry 99=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-98
> -=3D=3D=3D=3D=3DDiscovery Log Entry 100=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-99
> -=3D=3D=3D=3D=3DDiscovery Log Entry 101=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-100
> -=3D=3D=3D=3D=3DDiscovery Log Entry 102=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-101
> -=3D=3D=3D=3D=3DDiscovery Log Entry 103=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-102
> -=3D=3D=3D=3D=3DDiscovery Log Entry 104=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-103
> -=3D=3D=3D=3D=3DDiscovery Log Entry 105=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-104
> -=3D=3D=3D=3D=3DDiscovery Log Entry 106=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-105
> -=3D=3D=3D=3D=3DDiscovery Log Entry 107=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-106
> -=3D=3D=3D=3D=3DDiscovery Log Entry 108=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-107
> -=3D=3D=3D=3D=3DDiscovery Log Entry 109=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-108
> -=3D=3D=3D=3D=3DDiscovery Log Entry 110=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-109
> -=3D=3D=3D=3D=3DDiscovery Log Entry 111=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-110
> -=3D=3D=3D=3D=3DDiscovery Log Entry 112=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-111
> -=3D=3D=3D=3D=3DDiscovery Log Entry 113=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-112
> -=3D=3D=3D=3D=3DDiscovery Log Entry 114=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-113
> -=3D=3D=3D=3D=3DDiscovery Log Entry 115=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-114
> -=3D=3D=3D=3D=3DDiscovery Log Entry 116=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-115
> -=3D=3D=3D=3D=3DDiscovery Log Entry 117=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-116
> -=3D=3D=3D=3D=3DDiscovery Log Entry 118=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-117
> -=3D=3D=3D=3D=3DDiscovery Log Entry 119=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-118
> -=3D=3D=3D=3D=3DDiscovery Log Entry 120=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-119
> -=3D=3D=3D=3D=3DDiscovery Log Entry 121=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-120
> -=3D=3D=3D=3D=3DDiscovery Log Entry 122=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-121
> -=3D=3D=3D=3D=3DDiscovery Log Entry 123=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-122
> -=3D=3D=3D=3D=3DDiscovery Log Entry 124=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-123
> -=3D=3D=3D=3D=3DDiscovery Log Entry 125=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-124
> -=3D=3D=3D=3D=3DDiscovery Log Entry 126=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-125
> -=3D=3D=3D=3D=3DDiscovery Log Entry 127=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-126
> -=3D=3D=3D=3D=3DDiscovery Log Entry 128=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-127
> -=3D=3D=3D=3D=3DDiscovery Log Entry 129=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-128
> -=3D=3D=3D=3D=3DDiscovery Log Entry 130=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-129
> -=3D=3D=3D=3D=3DDiscovery Log Entry 131=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-130
> -=3D=3D=3D=3D=3DDiscovery Log Entry 132=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-131
> -=3D=3D=3D=3D=3DDiscovery Log Entry 133=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-132
> -=3D=3D=3D=3D=3DDiscovery Log Entry 134=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-133
> -=3D=3D=3D=3D=3DDiscovery Log Entry 135=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-134
> -=3D=3D=3D=3D=3DDiscovery Log Entry 136=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-135
> -=3D=3D=3D=3D=3DDiscovery Log Entry 137=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-136
> -=3D=3D=3D=3D=3DDiscovery Log Entry 138=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-137
> -=3D=3D=3D=3D=3DDiscovery Log Entry 139=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-138
> -=3D=3D=3D=3D=3DDiscovery Log Entry 140=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-139
> -=3D=3D=3D=3D=3DDiscovery Log Entry 141=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-140
> -=3D=3D=3D=3D=3DDiscovery Log Entry 142=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-141
> -=3D=3D=3D=3D=3DDiscovery Log Entry 143=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-142
> -=3D=3D=3D=3D=3DDiscovery Log Entry 144=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-143
> -=3D=3D=3D=3D=3DDiscovery Log Entry 145=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-144
> -=3D=3D=3D=3D=3DDiscovery Log Entry 146=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-145
> -=3D=3D=3D=3D=3DDiscovery Log Entry 147=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-146
> -=3D=3D=3D=3D=3DDiscovery Log Entry 148=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-147
> -=3D=3D=3D=3D=3DDiscovery Log Entry 149=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-148
> -=3D=3D=3D=3D=3DDiscovery Log Entry 150=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-149
> -=3D=3D=3D=3D=3DDiscovery Log Entry 151=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-150
> -=3D=3D=3D=3D=3DDiscovery Log Entry 152=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-151
> -=3D=3D=3D=3D=3DDiscovery Log Entry 153=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-152
> -=3D=3D=3D=3D=3DDiscovery Log Entry 154=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-153
> -=3D=3D=3D=3D=3DDiscovery Log Entry 155=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-154
> -=3D=3D=3D=3D=3DDiscovery Log Entry 156=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-155
> -=3D=3D=3D=3D=3DDiscovery Log Entry 157=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-156
> -=3D=3D=3D=3D=3DDiscovery Log Entry 158=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-157
> -=3D=3D=3D=3D=3DDiscovery Log Entry 159=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-158
> -=3D=3D=3D=3D=3DDiscovery Log Entry 160=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-159
> -=3D=3D=3D=3D=3DDiscovery Log Entry 161=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-160
> -=3D=3D=3D=3D=3DDiscovery Log Entry 162=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-161
> -=3D=3D=3D=3D=3DDiscovery Log Entry 163=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-162
> -=3D=3D=3D=3D=3DDiscovery Log Entry 164=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-163
> -=3D=3D=3D=3D=3DDiscovery Log Entry 165=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-164
> -=3D=3D=3D=3D=3DDiscovery Log Entry 166=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-165
> -=3D=3D=3D=3D=3DDiscovery Log Entry 167=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-166
> -=3D=3D=3D=3D=3DDiscovery Log Entry 168=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-167
> -=3D=3D=3D=3D=3DDiscovery Log Entry 169=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-168
> -=3D=3D=3D=3D=3DDiscovery Log Entry 170=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-169
> -=3D=3D=3D=3D=3DDiscovery Log Entry 171=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-170
> -=3D=3D=3D=3D=3DDiscovery Log Entry 172=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-171
> -=3D=3D=3D=3D=3DDiscovery Log Entry 173=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-172
> -=3D=3D=3D=3D=3DDiscovery Log Entry 174=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-173
> -=3D=3D=3D=3D=3DDiscovery Log Entry 175=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-174
> -=3D=3D=3D=3D=3DDiscovery Log Entry 176=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-175
> -=3D=3D=3D=3D=3DDiscovery Log Entry 177=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-176
> -=3D=3D=3D=3D=3DDiscovery Log Entry 178=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-177
> -=3D=3D=3D=3D=3DDiscovery Log Entry 179=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-178
> -=3D=3D=3D=3D=3DDiscovery Log Entry 180=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-179
> -=3D=3D=3D=3D=3DDiscovery Log Entry 181=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-180
> -=3D=3D=3D=3D=3DDiscovery Log Entry 182=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-181
> -=3D=3D=3D=3D=3DDiscovery Log Entry 183=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-182
> -=3D=3D=3D=3D=3DDiscovery Log Entry 184=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-183
> -=3D=3D=3D=3D=3DDiscovery Log Entry 185=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-184
> -=3D=3D=3D=3D=3DDiscovery Log Entry 186=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-185
> -=3D=3D=3D=3D=3DDiscovery Log Entry 187=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-186
> -=3D=3D=3D=3D=3DDiscovery Log Entry 188=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-187
> -=3D=3D=3D=3D=3DDiscovery Log Entry 189=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-188
> -=3D=3D=3D=3D=3DDiscovery Log Entry 190=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-189
> -=3D=3D=3D=3D=3DDiscovery Log Entry 191=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-190
> -=3D=3D=3D=3D=3DDiscovery Log Entry 192=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-191
> -=3D=3D=3D=3D=3DDiscovery Log Entry 193=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-192
> -=3D=3D=3D=3D=3DDiscovery Log Entry 194=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-193
> -=3D=3D=3D=3D=3DDiscovery Log Entry 195=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-194
> -=3D=3D=3D=3D=3DDiscovery Log Entry 196=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-195
> -=3D=3D=3D=3D=3DDiscovery Log Entry 197=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-196
> -=3D=3D=3D=3D=3DDiscovery Log Entry 198=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-197
> -=3D=3D=3D=3D=3DDiscovery Log Entry 199=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-198
> -=3D=3D=3D=3D=3DDiscovery Log Entry 200=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-199
> -=3D=3D=3D=3D=3DDiscovery Log Entry 201=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-200
> -=3D=3D=3D=3D=3DDiscovery Log Entry 202=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-201
> -=3D=3D=3D=3D=3DDiscovery Log Entry 203=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-202
> -=3D=3D=3D=3D=3DDiscovery Log Entry 204=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-203
> -=3D=3D=3D=3D=3DDiscovery Log Entry 205=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-204
> -=3D=3D=3D=3D=3DDiscovery Log Entry 206=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-205
> -=3D=3D=3D=3D=3DDiscovery Log Entry 207=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-206
> -=3D=3D=3D=3D=3DDiscovery Log Entry 208=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-207
> -=3D=3D=3D=3D=3DDiscovery Log Entry 209=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-208
> -=3D=3D=3D=3D=3DDiscovery Log Entry 210=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-209
> -=3D=3D=3D=3D=3DDiscovery Log Entry 211=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-210
> -=3D=3D=3D=3D=3DDiscovery Log Entry 212=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-211
> -=3D=3D=3D=3D=3DDiscovery Log Entry 213=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-212
> -=3D=3D=3D=3D=3DDiscovery Log Entry 214=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-213
> -=3D=3D=3D=3D=3DDiscovery Log Entry 215=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-214
> -=3D=3D=3D=3D=3DDiscovery Log Entry 216=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-215
> -=3D=3D=3D=3D=3DDiscovery Log Entry 217=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-216
> -=3D=3D=3D=3D=3DDiscovery Log Entry 218=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-217
> -=3D=3D=3D=3D=3DDiscovery Log Entry 219=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-218
> -=3D=3D=3D=3D=3DDiscovery Log Entry 220=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-219
> -=3D=3D=3D=3D=3DDiscovery Log Entry 221=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-220
> -=3D=3D=3D=3D=3DDiscovery Log Entry 222=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-221
> -=3D=3D=3D=3D=3DDiscovery Log Entry 223=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-222
> -=3D=3D=3D=3D=3DDiscovery Log Entry 224=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-223
> -=3D=3D=3D=3D=3DDiscovery Log Entry 225=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-224
> -=3D=3D=3D=3D=3DDiscovery Log Entry 226=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-225
> -=3D=3D=3D=3D=3DDiscovery Log Entry 227=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-226
> -=3D=3D=3D=3D=3DDiscovery Log Entry 228=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-227
> -=3D=3D=3D=3D=3DDiscovery Log Entry 229=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-228
> -=3D=3D=3D=3D=3DDiscovery Log Entry 230=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-229
> -=3D=3D=3D=3D=3DDiscovery Log Entry 231=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-230
> -=3D=3D=3D=3D=3DDiscovery Log Entry 232=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-231
> -=3D=3D=3D=3D=3DDiscovery Log Entry 233=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-232
> -=3D=3D=3D=3D=3DDiscovery Log Entry 234=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-233
> -=3D=3D=3D=3D=3DDiscovery Log Entry 235=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-234
> -=3D=3D=3D=3D=3DDiscovery Log Entry 236=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-235
> -=3D=3D=3D=3D=3DDiscovery Log Entry 237=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-236
> -=3D=3D=3D=3D=3DDiscovery Log Entry 238=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-237
> -=3D=3D=3D=3D=3DDiscovery Log Entry 239=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-238
> -=3D=3D=3D=3D=3DDiscovery Log Entry 240=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-239
> -=3D=3D=3D=3D=3DDiscovery Log Entry 241=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-240
> -=3D=3D=3D=3D=3DDiscovery Log Entry 242=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-241
> -=3D=3D=3D=3D=3DDiscovery Log Entry 243=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-242
> -=3D=3D=3D=3D=3DDiscovery Log Entry 244=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-243
> -=3D=3D=3D=3D=3DDiscovery Log Entry 245=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-244
> -=3D=3D=3D=3D=3DDiscovery Log Entry 246=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-245
> -=3D=3D=3D=3D=3DDiscovery Log Entry 247=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-246
> -=3D=3D=3D=3D=3DDiscovery Log Entry 248=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-247
> -=3D=3D=3D=3D=3DDiscovery Log Entry 249=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-248
> -=3D=3D=3D=3D=3DDiscovery Log Entry 250=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-249
> -=3D=3D=3D=3D=3DDiscovery Log Entry 251=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-250
> -=3D=3D=3D=3D=3DDiscovery Log Entry 252=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-251
> -=3D=3D=3D=3D=3DDiscovery Log Entry 253=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-252
> -=3D=3D=3D=3D=3DDiscovery Log Entry 254=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-253
> -=3D=3D=3D=3D=3DDiscovery Log Entry 255=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-254
> -=3D=3D=3D=3D=3DDiscovery Log Entry 256=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-255
> -=3D=3D=3D=3D=3DDiscovery Log Entry 257=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-256
> -=3D=3D=3D=3D=3DDiscovery Log Entry 258=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-257
> -=3D=3D=3D=3D=3DDiscovery Log Entry 259=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-258
> -=3D=3D=3D=3D=3DDiscovery Log Entry 260=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-259
> -=3D=3D=3D=3D=3DDiscovery Log Entry 261=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-260
> -=3D=3D=3D=3D=3DDiscovery Log Entry 262=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-261
> -=3D=3D=3D=3D=3DDiscovery Log Entry 263=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-262
> -=3D=3D=3D=3D=3DDiscovery Log Entry 264=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-263
> -=3D=3D=3D=3D=3DDiscovery Log Entry 265=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-264
> -=3D=3D=3D=3D=3DDiscovery Log Entry 266=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-265
> -=3D=3D=3D=3D=3DDiscovery Log Entry 267=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-266
> -=3D=3D=3D=3D=3DDiscovery Log Entry 268=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-267
> -=3D=3D=3D=3D=3DDiscovery Log Entry 269=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-268
> -=3D=3D=3D=3D=3DDiscovery Log Entry 270=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-269
> -=3D=3D=3D=3D=3DDiscovery Log Entry 271=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-270
> -=3D=3D=3D=3D=3DDiscovery Log Entry 272=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-271
> -=3D=3D=3D=3D=3DDiscovery Log Entry 273=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-272
> -=3D=3D=3D=3D=3DDiscovery Log Entry 274=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-273
> -=3D=3D=3D=3D=3DDiscovery Log Entry 275=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-274
> -=3D=3D=3D=3D=3DDiscovery Log Entry 276=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-275
> -=3D=3D=3D=3D=3DDiscovery Log Entry 277=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-276
> -=3D=3D=3D=3D=3DDiscovery Log Entry 278=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-277
> -=3D=3D=3D=3D=3DDiscovery Log Entry 279=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-278
> -=3D=3D=3D=3D=3DDiscovery Log Entry 280=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-279
> -=3D=3D=3D=3D=3DDiscovery Log Entry 281=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-280
> -=3D=3D=3D=3D=3DDiscovery Log Entry 282=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-281
> -=3D=3D=3D=3D=3DDiscovery Log Entry 283=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-282
> -=3D=3D=3D=3D=3DDiscovery Log Entry 284=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-283
> -=3D=3D=3D=3D=3DDiscovery Log Entry 285=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-284
> -=3D=3D=3D=3D=3DDiscovery Log Entry 286=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-285
> -=3D=3D=3D=3D=3DDiscovery Log Entry 287=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-286
> -=3D=3D=3D=3D=3DDiscovery Log Entry 288=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-287
> -=3D=3D=3D=3D=3DDiscovery Log Entry 289=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-288
> -=3D=3D=3D=3D=3DDiscovery Log Entry 290=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-289
> -=3D=3D=3D=3D=3DDiscovery Log Entry 291=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-290
> -=3D=3D=3D=3D=3DDiscovery Log Entry 292=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-291
> -=3D=3D=3D=3D=3DDiscovery Log Entry 293=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-292
> -=3D=3D=3D=3D=3DDiscovery Log Entry 294=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-293
> -=3D=3D=3D=3D=3DDiscovery Log Entry 295=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-294
> -=3D=3D=3D=3D=3DDiscovery Log Entry 296=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-295
> -=3D=3D=3D=3D=3DDiscovery Log Entry 297=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-296
> -=3D=3D=3D=3D=3DDiscovery Log Entry 298=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-297
> -=3D=3D=3D=3D=3DDiscovery Log Entry 299=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-298
> -=3D=3D=3D=3D=3DDiscovery Log Entry 300=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-299
> -=3D=3D=3D=3D=3DDiscovery Log Entry 301=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-300
> -=3D=3D=3D=3D=3DDiscovery Log Entry 302=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-301
> -=3D=3D=3D=3D=3DDiscovery Log Entry 303=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-302
> -=3D=3D=3D=3D=3DDiscovery Log Entry 304=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-303
> -=3D=3D=3D=3D=3DDiscovery Log Entry 305=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-304
> -=3D=3D=3D=3D=3DDiscovery Log Entry 306=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-305
> -=3D=3D=3D=3D=3DDiscovery Log Entry 307=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-306
> -=3D=3D=3D=3D=3DDiscovery Log Entry 308=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-307
> -=3D=3D=3D=3D=3DDiscovery Log Entry 309=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-308
> -=3D=3D=3D=3D=3DDiscovery Log Entry 310=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-309
> -=3D=3D=3D=3D=3DDiscovery Log Entry 311=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-310
> -=3D=3D=3D=3D=3DDiscovery Log Entry 312=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-311
> -=3D=3D=3D=3D=3DDiscovery Log Entry 313=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-312
> -=3D=3D=3D=3D=3DDiscovery Log Entry 314=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-313
> -=3D=3D=3D=3D=3DDiscovery Log Entry 315=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-314
> -=3D=3D=3D=3D=3DDiscovery Log Entry 316=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-315
> -=3D=3D=3D=3D=3DDiscovery Log Entry 317=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-316
> -=3D=3D=3D=3D=3DDiscovery Log Entry 318=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-317
> -=3D=3D=3D=3D=3DDiscovery Log Entry 319=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-318
> -=3D=3D=3D=3D=3DDiscovery Log Entry 320=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-319
> -=3D=3D=3D=3D=3DDiscovery Log Entry 321=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-320
> -=3D=3D=3D=3D=3DDiscovery Log Entry 322=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-321
> -=3D=3D=3D=3D=3DDiscovery Log Entry 323=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-322
> -=3D=3D=3D=3D=3DDiscovery Log Entry 324=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-323
> -=3D=3D=3D=3D=3DDiscovery Log Entry 325=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-324
> -=3D=3D=3D=3D=3DDiscovery Log Entry 326=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-325
> -=3D=3D=3D=3D=3DDiscovery Log Entry 327=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-326
> -=3D=3D=3D=3D=3DDiscovery Log Entry 328=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-327
> -=3D=3D=3D=3D=3DDiscovery Log Entry 329=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-328
> -=3D=3D=3D=3D=3DDiscovery Log Entry 330=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-329
> -=3D=3D=3D=3D=3DDiscovery Log Entry 331=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-330
> -=3D=3D=3D=3D=3DDiscovery Log Entry 332=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-331
> -=3D=3D=3D=3D=3DDiscovery Log Entry 333=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-332
> -=3D=3D=3D=3D=3DDiscovery Log Entry 334=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-333
> -=3D=3D=3D=3D=3DDiscovery Log Entry 335=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-334
> -=3D=3D=3D=3D=3DDiscovery Log Entry 336=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-335
> -=3D=3D=3D=3D=3DDiscovery Log Entry 337=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-336
> -=3D=3D=3D=3D=3DDiscovery Log Entry 338=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-337
> -=3D=3D=3D=3D=3DDiscovery Log Entry 339=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-338
> -=3D=3D=3D=3D=3DDiscovery Log Entry 340=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-339
> -=3D=3D=3D=3D=3DDiscovery Log Entry 341=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-340
> -=3D=3D=3D=3D=3DDiscovery Log Entry 342=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-341
> -=3D=3D=3D=3D=3DDiscovery Log Entry 343=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-342
> -=3D=3D=3D=3D=3DDiscovery Log Entry 344=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-343
> -=3D=3D=3D=3D=3DDiscovery Log Entry 345=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-344
> -=3D=3D=3D=3D=3DDiscovery Log Entry 346=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-345
> -=3D=3D=3D=3D=3DDiscovery Log Entry 347=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-346
> -=3D=3D=3D=3D=3DDiscovery Log Entry 348=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-347
> -=3D=3D=3D=3D=3DDiscovery Log Entry 349=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-348
> -=3D=3D=3D=3D=3DDiscovery Log Entry 350=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-349
> -=3D=3D=3D=3D=3DDiscovery Log Entry 351=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-350
> -=3D=3D=3D=3D=3DDiscovery Log Entry 352=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-351
> -=3D=3D=3D=3D=3DDiscovery Log Entry 353=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-352
> -=3D=3D=3D=3D=3DDiscovery Log Entry 354=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-353
> -=3D=3D=3D=3D=3DDiscovery Log Entry 355=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-354
> -=3D=3D=3D=3D=3DDiscovery Log Entry 356=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-355
> -=3D=3D=3D=3D=3DDiscovery Log Entry 357=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-356
> -=3D=3D=3D=3D=3DDiscovery Log Entry 358=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-357
> -=3D=3D=3D=3D=3DDiscovery Log Entry 359=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-358
> -=3D=3D=3D=3D=3DDiscovery Log Entry 360=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-359
> -=3D=3D=3D=3D=3DDiscovery Log Entry 361=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-360
> -=3D=3D=3D=3D=3DDiscovery Log Entry 362=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-361
> -=3D=3D=3D=3D=3DDiscovery Log Entry 363=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-362
> -=3D=3D=3D=3D=3DDiscovery Log Entry 364=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-363
> -=3D=3D=3D=3D=3DDiscovery Log Entry 365=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-364
> -=3D=3D=3D=3D=3DDiscovery Log Entry 366=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-365
> -=3D=3D=3D=3D=3DDiscovery Log Entry 367=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-366
> -=3D=3D=3D=3D=3DDiscovery Log Entry 368=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-367
> -=3D=3D=3D=3D=3DDiscovery Log Entry 369=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-368
> -=3D=3D=3D=3D=3DDiscovery Log Entry 370=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-369
> -=3D=3D=3D=3D=3DDiscovery Log Entry 371=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-370
> -=3D=3D=3D=3D=3DDiscovery Log Entry 372=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-371
> -=3D=3D=3D=3D=3DDiscovery Log Entry 373=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-372
> -=3D=3D=3D=3D=3DDiscovery Log Entry 374=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-373
> -=3D=3D=3D=3D=3DDiscovery Log Entry 375=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-374
> -=3D=3D=3D=3D=3DDiscovery Log Entry 376=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-375
> -=3D=3D=3D=3D=3DDiscovery Log Entry 377=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-376
> -=3D=3D=3D=3D=3DDiscovery Log Entry 378=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-377
> -=3D=3D=3D=3D=3DDiscovery Log Entry 379=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-378
> -=3D=3D=3D=3D=3DDiscovery Log Entry 380=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-379
> -=3D=3D=3D=3D=3DDiscovery Log Entry 381=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-380
> -=3D=3D=3D=3D=3DDiscovery Log Entry 382=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-381
> -=3D=3D=3D=3D=3DDiscovery Log Entry 383=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-382
> -=3D=3D=3D=3D=3DDiscovery Log Entry 384=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-383
> -=3D=3D=3D=3D=3DDiscovery Log Entry 385=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-384
> -=3D=3D=3D=3D=3DDiscovery Log Entry 386=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-385
> -=3D=3D=3D=3D=3DDiscovery Log Entry 387=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-386
> -=3D=3D=3D=3D=3DDiscovery Log Entry 388=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-387
> -=3D=3D=3D=3D=3DDiscovery Log Entry 389=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-388
> -=3D=3D=3D=3D=3DDiscovery Log Entry 390=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-389
> -=3D=3D=3D=3D=3DDiscovery Log Entry 391=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-390
> -=3D=3D=3D=3D=3DDiscovery Log Entry 392=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-391
> -=3D=3D=3D=3D=3DDiscovery Log Entry 393=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-392
> -=3D=3D=3D=3D=3DDiscovery Log Entry 394=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-393
> -=3D=3D=3D=3D=3DDiscovery Log Entry 395=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-394
> -=3D=3D=3D=3D=3DDiscovery Log Entry 396=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-395
> -=3D=3D=3D=3D=3DDiscovery Log Entry 397=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-396
> -=3D=3D=3D=3D=3DDiscovery Log Entry 398=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-397
> -=3D=3D=3D=3D=3DDiscovery Log Entry 399=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-398
> -=3D=3D=3D=3D=3DDiscovery Log Entry 400=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-399
> -=3D=3D=3D=3D=3DDiscovery Log Entry 401=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-400
> -=3D=3D=3D=3D=3DDiscovery Log Entry 402=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-401
> -=3D=3D=3D=3D=3DDiscovery Log Entry 403=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-402
> -=3D=3D=3D=3D=3DDiscovery Log Entry 404=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-403
> -=3D=3D=3D=3D=3DDiscovery Log Entry 405=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-404
> -=3D=3D=3D=3D=3DDiscovery Log Entry 406=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-405
> -=3D=3D=3D=3D=3DDiscovery Log Entry 407=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-406
> -=3D=3D=3D=3D=3DDiscovery Log Entry 408=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-407
> -=3D=3D=3D=3D=3DDiscovery Log Entry 409=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-408
> -=3D=3D=3D=3D=3DDiscovery Log Entry 410=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-409
> -=3D=3D=3D=3D=3DDiscovery Log Entry 411=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-410
> -=3D=3D=3D=3D=3DDiscovery Log Entry 412=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-411
> -=3D=3D=3D=3D=3DDiscovery Log Entry 413=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-412
> -=3D=3D=3D=3D=3DDiscovery Log Entry 414=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-413
> -=3D=3D=3D=3D=3DDiscovery Log Entry 415=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-414
> -=3D=3D=3D=3D=3DDiscovery Log Entry 416=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-415
> -=3D=3D=3D=3D=3DDiscovery Log Entry 417=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-416
> -=3D=3D=3D=3D=3DDiscovery Log Entry 418=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-417
> -=3D=3D=3D=3D=3DDiscovery Log Entry 419=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-418
> -=3D=3D=3D=3D=3DDiscovery Log Entry 420=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-419
> -=3D=3D=3D=3D=3DDiscovery Log Entry 421=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-420
> -=3D=3D=3D=3D=3DDiscovery Log Entry 422=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-421
> -=3D=3D=3D=3D=3DDiscovery Log Entry 423=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-422
> -=3D=3D=3D=3D=3DDiscovery Log Entry 424=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-423
> -=3D=3D=3D=3D=3DDiscovery Log Entry 425=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-424
> -=3D=3D=3D=3D=3DDiscovery Log Entry 426=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-425
> -=3D=3D=3D=3D=3DDiscovery Log Entry 427=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-426
> -=3D=3D=3D=3D=3DDiscovery Log Entry 428=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-427
> -=3D=3D=3D=3D=3DDiscovery Log Entry 429=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-428
> -=3D=3D=3D=3D=3DDiscovery Log Entry 430=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-429
> -=3D=3D=3D=3D=3DDiscovery Log Entry 431=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-430
> -=3D=3D=3D=3D=3DDiscovery Log Entry 432=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-431
> -=3D=3D=3D=3D=3DDiscovery Log Entry 433=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-432
> -=3D=3D=3D=3D=3DDiscovery Log Entry 434=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-433
> -=3D=3D=3D=3D=3DDiscovery Log Entry 435=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-434
> -=3D=3D=3D=3D=3DDiscovery Log Entry 436=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-435
> -=3D=3D=3D=3D=3DDiscovery Log Entry 437=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-436
> -=3D=3D=3D=3D=3DDiscovery Log Entry 438=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-437
> -=3D=3D=3D=3D=3DDiscovery Log Entry 439=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-438
> -=3D=3D=3D=3D=3DDiscovery Log Entry 440=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-439
> -=3D=3D=3D=3D=3DDiscovery Log Entry 441=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-440
> -=3D=3D=3D=3D=3DDiscovery Log Entry 442=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-441
> -=3D=3D=3D=3D=3DDiscovery Log Entry 443=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-442
> -=3D=3D=3D=3D=3DDiscovery Log Entry 444=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-443
> -=3D=3D=3D=3D=3DDiscovery Log Entry 445=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-444
> -=3D=3D=3D=3D=3DDiscovery Log Entry 446=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-445
> -=3D=3D=3D=3D=3DDiscovery Log Entry 447=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-446
> -=3D=3D=3D=3D=3DDiscovery Log Entry 448=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-447
> -=3D=3D=3D=3D=3DDiscovery Log Entry 449=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-448
> -=3D=3D=3D=3D=3DDiscovery Log Entry 450=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-449
> -=3D=3D=3D=3D=3DDiscovery Log Entry 451=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-450
> -=3D=3D=3D=3D=3DDiscovery Log Entry 452=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-451
> -=3D=3D=3D=3D=3DDiscovery Log Entry 453=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-452
> -=3D=3D=3D=3D=3DDiscovery Log Entry 454=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-453
> -=3D=3D=3D=3D=3DDiscovery Log Entry 455=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-454
> -=3D=3D=3D=3D=3DDiscovery Log Entry 456=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-455
> -=3D=3D=3D=3D=3DDiscovery Log Entry 457=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-456
> -=3D=3D=3D=3D=3DDiscovery Log Entry 458=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-457
> -=3D=3D=3D=3D=3DDiscovery Log Entry 459=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-458
> -=3D=3D=3D=3D=3DDiscovery Log Entry 460=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-459
> -=3D=3D=3D=3D=3DDiscovery Log Entry 461=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-460
> -=3D=3D=3D=3D=3DDiscovery Log Entry 462=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-461
> -=3D=3D=3D=3D=3DDiscovery Log Entry 463=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-462
> -=3D=3D=3D=3D=3DDiscovery Log Entry 464=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-463
> -=3D=3D=3D=3D=3DDiscovery Log Entry 465=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-464
> -=3D=3D=3D=3D=3DDiscovery Log Entry 466=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-465
> -=3D=3D=3D=3D=3DDiscovery Log Entry 467=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-466
> -=3D=3D=3D=3D=3DDiscovery Log Entry 468=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-467
> -=3D=3D=3D=3D=3DDiscovery Log Entry 469=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-468
> -=3D=3D=3D=3D=3DDiscovery Log Entry 470=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-469
> -=3D=3D=3D=3D=3DDiscovery Log Entry 471=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-470
> -=3D=3D=3D=3D=3DDiscovery Log Entry 472=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-471
> -=3D=3D=3D=3D=3DDiscovery Log Entry 473=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-472
> -=3D=3D=3D=3D=3DDiscovery Log Entry 474=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-473
> -=3D=3D=3D=3D=3DDiscovery Log Entry 475=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-474
> -=3D=3D=3D=3D=3DDiscovery Log Entry 476=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-475
> -=3D=3D=3D=3D=3DDiscovery Log Entry 477=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-476
> -=3D=3D=3D=3D=3DDiscovery Log Entry 478=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-477
> -=3D=3D=3D=3D=3DDiscovery Log Entry 479=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-478
> -=3D=3D=3D=3D=3DDiscovery Log Entry 480=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-479
> -=3D=3D=3D=3D=3DDiscovery Log Entry 481=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-480
> -=3D=3D=3D=3D=3DDiscovery Log Entry 482=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-481
> -=3D=3D=3D=3D=3DDiscovery Log Entry 483=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-482
> -=3D=3D=3D=3D=3DDiscovery Log Entry 484=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-483
> -=3D=3D=3D=3D=3DDiscovery Log Entry 485=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-484
> -=3D=3D=3D=3D=3DDiscovery Log Entry 486=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-485
> -=3D=3D=3D=3D=3DDiscovery Log Entry 487=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-486
> -=3D=3D=3D=3D=3DDiscovery Log Entry 488=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-487
> -=3D=3D=3D=3D=3DDiscovery Log Entry 489=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-488
> -=3D=3D=3D=3D=3DDiscovery Log Entry 490=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-489
> -=3D=3D=3D=3D=3DDiscovery Log Entry 491=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-490
> -=3D=3D=3D=3D=3DDiscovery Log Entry 492=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-491
> -=3D=3D=3D=3D=3DDiscovery Log Entry 493=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-492
> -=3D=3D=3D=3D=3DDiscovery Log Entry 494=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-493
> -=3D=3D=3D=3D=3DDiscovery Log Entry 495=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-494
> -=3D=3D=3D=3D=3DDiscovery Log Entry 496=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-495
> -=3D=3D=3D=3D=3DDiscovery Log Entry 497=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-496
> -=3D=3D=3D=3D=3DDiscovery Log Entry 498=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-497
> -=3D=3D=3D=3D=3DDiscovery Log Entry 499=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-498
> -=3D=3D=3D=3D=3DDiscovery Log Entry 500=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-499
> -=3D=3D=3D=3D=3DDiscovery Log Entry 501=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-500
> -=3D=3D=3D=3D=3DDiscovery Log Entry 502=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-501
> -=3D=3D=3D=3D=3DDiscovery Log Entry 503=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-502
> -=3D=3D=3D=3D=3DDiscovery Log Entry 504=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-503
> -=3D=3D=3D=3D=3DDiscovery Log Entry 505=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-504
> -=3D=3D=3D=3D=3DDiscovery Log Entry 506=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-505
> -=3D=3D=3D=3D=3DDiscovery Log Entry 507=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-506
> -=3D=3D=3D=3D=3DDiscovery Log Entry 508=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-507
> -=3D=3D=3D=3D=3DDiscovery Log Entry 509=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-508
> -=3D=3D=3D=3D=3DDiscovery Log Entry 510=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-509
> -=3D=3D=3D=3D=3DDiscovery Log Entry 511=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-510
> -=3D=3D=3D=3D=3DDiscovery Log Entry 512=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-511
> -=3D=3D=3D=3D=3DDiscovery Log Entry 513=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-512
> -=3D=3D=3D=3D=3DDiscovery Log Entry 514=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-513
> -=3D=3D=3D=3D=3DDiscovery Log Entry 515=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-514
> -=3D=3D=3D=3D=3DDiscovery Log Entry 516=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-515
> -=3D=3D=3D=3D=3DDiscovery Log Entry 517=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-516
> -=3D=3D=3D=3D=3DDiscovery Log Entry 518=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-517
> -=3D=3D=3D=3D=3DDiscovery Log Entry 519=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-518
> -=3D=3D=3D=3D=3DDiscovery Log Entry 520=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-519
> -=3D=3D=3D=3D=3DDiscovery Log Entry 521=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-520
> -=3D=3D=3D=3D=3DDiscovery Log Entry 522=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-521
> -=3D=3D=3D=3D=3DDiscovery Log Entry 523=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-522
> -=3D=3D=3D=3D=3DDiscovery Log Entry 524=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-523
> -=3D=3D=3D=3D=3DDiscovery Log Entry 525=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-524
> -=3D=3D=3D=3D=3DDiscovery Log Entry 526=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-525
> -=3D=3D=3D=3D=3DDiscovery Log Entry 527=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-526
> -=3D=3D=3D=3D=3DDiscovery Log Entry 528=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-527
> -=3D=3D=3D=3D=3DDiscovery Log Entry 529=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-528
> -=3D=3D=3D=3D=3DDiscovery Log Entry 530=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-529
> -=3D=3D=3D=3D=3DDiscovery Log Entry 531=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-530
> -=3D=3D=3D=3D=3DDiscovery Log Entry 532=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-531
> -=3D=3D=3D=3D=3DDiscovery Log Entry 533=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-532
> -=3D=3D=3D=3D=3DDiscovery Log Entry 534=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-533
> -=3D=3D=3D=3D=3DDiscovery Log Entry 535=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-534
> -=3D=3D=3D=3D=3DDiscovery Log Entry 536=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-535
> -=3D=3D=3D=3D=3DDiscovery Log Entry 537=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-536
> -=3D=3D=3D=3D=3DDiscovery Log Entry 538=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-537
> -=3D=3D=3D=3D=3DDiscovery Log Entry 539=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-538
> -=3D=3D=3D=3D=3DDiscovery Log Entry 540=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-539
> -=3D=3D=3D=3D=3DDiscovery Log Entry 541=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-540
> -=3D=3D=3D=3D=3DDiscovery Log Entry 542=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-541
> -=3D=3D=3D=3D=3DDiscovery Log Entry 543=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-542
> -=3D=3D=3D=3D=3DDiscovery Log Entry 544=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-543
> -=3D=3D=3D=3D=3DDiscovery Log Entry 545=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-544
> -=3D=3D=3D=3D=3DDiscovery Log Entry 546=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-545
> -=3D=3D=3D=3D=3DDiscovery Log Entry 547=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-546
> -=3D=3D=3D=3D=3DDiscovery Log Entry 548=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-547
> -=3D=3D=3D=3D=3DDiscovery Log Entry 549=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-548
> -=3D=3D=3D=3D=3DDiscovery Log Entry 550=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-549
> -=3D=3D=3D=3D=3DDiscovery Log Entry 551=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-550
> -=3D=3D=3D=3D=3DDiscovery Log Entry 552=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-551
> -=3D=3D=3D=3D=3DDiscovery Log Entry 553=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-552
> -=3D=3D=3D=3D=3DDiscovery Log Entry 554=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-553
> -=3D=3D=3D=3D=3DDiscovery Log Entry 555=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-554
> -=3D=3D=3D=3D=3DDiscovery Log Entry 556=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-555
> -=3D=3D=3D=3D=3DDiscovery Log Entry 557=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-556
> -=3D=3D=3D=3D=3DDiscovery Log Entry 558=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-557
> -=3D=3D=3D=3D=3DDiscovery Log Entry 559=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-558
> -=3D=3D=3D=3D=3DDiscovery Log Entry 560=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-559
> -=3D=3D=3D=3D=3DDiscovery Log Entry 561=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-560
> -=3D=3D=3D=3D=3DDiscovery Log Entry 562=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-561
> -=3D=3D=3D=3D=3DDiscovery Log Entry 563=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-562
> -=3D=3D=3D=3D=3DDiscovery Log Entry 564=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-563
> -=3D=3D=3D=3D=3DDiscovery Log Entry 565=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-564
> -=3D=3D=3D=3D=3DDiscovery Log Entry 566=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-565
> -=3D=3D=3D=3D=3DDiscovery Log Entry 567=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-566
> -=3D=3D=3D=3D=3DDiscovery Log Entry 568=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-567
> -=3D=3D=3D=3D=3DDiscovery Log Entry 569=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-568
> -=3D=3D=3D=3D=3DDiscovery Log Entry 570=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-569
> -=3D=3D=3D=3D=3DDiscovery Log Entry 571=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-570
> -=3D=3D=3D=3D=3DDiscovery Log Entry 572=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-571
> -=3D=3D=3D=3D=3DDiscovery Log Entry 573=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-572
> -=3D=3D=3D=3D=3DDiscovery Log Entry 574=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-573
> -=3D=3D=3D=3D=3DDiscovery Log Entry 575=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-574
> -=3D=3D=3D=3D=3DDiscovery Log Entry 576=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-575
> -=3D=3D=3D=3D=3DDiscovery Log Entry 577=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-576
> -=3D=3D=3D=3D=3DDiscovery Log Entry 578=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-577
> -=3D=3D=3D=3D=3DDiscovery Log Entry 579=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-578
> -=3D=3D=3D=3D=3DDiscovery Log Entry 580=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-579
> -=3D=3D=3D=3D=3DDiscovery Log Entry 581=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-580
> -=3D=3D=3D=3D=3DDiscovery Log Entry 582=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-581
> -=3D=3D=3D=3D=3DDiscovery Log Entry 583=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-582
> -=3D=3D=3D=3D=3DDiscovery Log Entry 584=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-583
> -=3D=3D=3D=3D=3DDiscovery Log Entry 585=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-584
> -=3D=3D=3D=3D=3DDiscovery Log Entry 586=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-585
> -=3D=3D=3D=3D=3DDiscovery Log Entry 587=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-586
> -=3D=3D=3D=3D=3DDiscovery Log Entry 588=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-587
> -=3D=3D=3D=3D=3DDiscovery Log Entry 589=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-588
> -=3D=3D=3D=3D=3DDiscovery Log Entry 590=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-589
> -=3D=3D=3D=3D=3DDiscovery Log Entry 591=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-590
> -=3D=3D=3D=3D=3DDiscovery Log Entry 592=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-591
> -=3D=3D=3D=3D=3DDiscovery Log Entry 593=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-592
> -=3D=3D=3D=3D=3DDiscovery Log Entry 594=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-593
> -=3D=3D=3D=3D=3DDiscovery Log Entry 595=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-594
> -=3D=3D=3D=3D=3DDiscovery Log Entry 596=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-595
> -=3D=3D=3D=3D=3DDiscovery Log Entry 597=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-596
> -=3D=3D=3D=3D=3DDiscovery Log Entry 598=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-597
> -=3D=3D=3D=3D=3DDiscovery Log Entry 599=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-598
> -=3D=3D=3D=3D=3DDiscovery Log Entry 600=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-599
> -=3D=3D=3D=3D=3DDiscovery Log Entry 601=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-600
> -=3D=3D=3D=3D=3DDiscovery Log Entry 602=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-601
> -=3D=3D=3D=3D=3DDiscovery Log Entry 603=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-602
> -=3D=3D=3D=3D=3DDiscovery Log Entry 604=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-603
> -=3D=3D=3D=3D=3DDiscovery Log Entry 605=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-604
> -=3D=3D=3D=3D=3DDiscovery Log Entry 606=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-605
> -=3D=3D=3D=3D=3DDiscovery Log Entry 607=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-606
> -=3D=3D=3D=3D=3DDiscovery Log Entry 608=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-607
> -=3D=3D=3D=3D=3DDiscovery Log Entry 609=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-608
> -=3D=3D=3D=3D=3DDiscovery Log Entry 610=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-609
> -=3D=3D=3D=3D=3DDiscovery Log Entry 611=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-610
> -=3D=3D=3D=3D=3DDiscovery Log Entry 612=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-611
> -=3D=3D=3D=3D=3DDiscovery Log Entry 613=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-612
> -=3D=3D=3D=3D=3DDiscovery Log Entry 614=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-613
> -=3D=3D=3D=3D=3DDiscovery Log Entry 615=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-614
> -=3D=3D=3D=3D=3DDiscovery Log Entry 616=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-615
> -=3D=3D=3D=3D=3DDiscovery Log Entry 617=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-616
> -=3D=3D=3D=3D=3DDiscovery Log Entry 618=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-617
> -=3D=3D=3D=3D=3DDiscovery Log Entry 619=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-618
> -=3D=3D=3D=3D=3DDiscovery Log Entry 620=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-619
> -=3D=3D=3D=3D=3DDiscovery Log Entry 621=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-620
> -=3D=3D=3D=3D=3DDiscovery Log Entry 622=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-621
> -=3D=3D=3D=3D=3DDiscovery Log Entry 623=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-622
> -=3D=3D=3D=3D=3DDiscovery Log Entry 624=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-623
> -=3D=3D=3D=3D=3DDiscovery Log Entry 625=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-624
> -=3D=3D=3D=3D=3DDiscovery Log Entry 626=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-625
> -=3D=3D=3D=3D=3DDiscovery Log Entry 627=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-626
> -=3D=3D=3D=3D=3DDiscovery Log Entry 628=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-627
> -=3D=3D=3D=3D=3DDiscovery Log Entry 629=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-628
> -=3D=3D=3D=3D=3DDiscovery Log Entry 630=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-629
> -=3D=3D=3D=3D=3DDiscovery Log Entry 631=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-630
> -=3D=3D=3D=3D=3DDiscovery Log Entry 632=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-631
> -=3D=3D=3D=3D=3DDiscovery Log Entry 633=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-632
> -=3D=3D=3D=3D=3DDiscovery Log Entry 634=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-633
> -=3D=3D=3D=3D=3DDiscovery Log Entry 635=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-634
> -=3D=3D=3D=3D=3DDiscovery Log Entry 636=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-635
> -=3D=3D=3D=3D=3DDiscovery Log Entry 637=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-636
> -=3D=3D=3D=3D=3DDiscovery Log Entry 638=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-637
> -=3D=3D=3D=3D=3DDiscovery Log Entry 639=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-638
> -=3D=3D=3D=3D=3DDiscovery Log Entry 640=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-639
> -=3D=3D=3D=3D=3DDiscovery Log Entry 641=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-640
> -=3D=3D=3D=3D=3DDiscovery Log Entry 642=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-641
> -=3D=3D=3D=3D=3DDiscovery Log Entry 643=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-642
> -=3D=3D=3D=3D=3DDiscovery Log Entry 644=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-643
> -=3D=3D=3D=3D=3DDiscovery Log Entry 645=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-644
> -=3D=3D=3D=3D=3DDiscovery Log Entry 646=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-645
> -=3D=3D=3D=3D=3DDiscovery Log Entry 647=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-646
> -=3D=3D=3D=3D=3DDiscovery Log Entry 648=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-647
> -=3D=3D=3D=3D=3DDiscovery Log Entry 649=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-648
> -=3D=3D=3D=3D=3DDiscovery Log Entry 650=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-649
> -=3D=3D=3D=3D=3DDiscovery Log Entry 651=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-650
> -=3D=3D=3D=3D=3DDiscovery Log Entry 652=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-651
> -=3D=3D=3D=3D=3DDiscovery Log Entry 653=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-652
> -=3D=3D=3D=3D=3DDiscovery Log Entry 654=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-653
> -=3D=3D=3D=3D=3DDiscovery Log Entry 655=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-654
> -=3D=3D=3D=3D=3DDiscovery Log Entry 656=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-655
> -=3D=3D=3D=3D=3DDiscovery Log Entry 657=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-656
> -=3D=3D=3D=3D=3DDiscovery Log Entry 658=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-657
> -=3D=3D=3D=3D=3DDiscovery Log Entry 659=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-658
> -=3D=3D=3D=3D=3DDiscovery Log Entry 660=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-659
> -=3D=3D=3D=3D=3DDiscovery Log Entry 661=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-660
> -=3D=3D=3D=3D=3DDiscovery Log Entry 662=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-661
> -=3D=3D=3D=3D=3DDiscovery Log Entry 663=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-662
> -=3D=3D=3D=3D=3DDiscovery Log Entry 664=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-663
> -=3D=3D=3D=3D=3DDiscovery Log Entry 665=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-664
> -=3D=3D=3D=3D=3DDiscovery Log Entry 666=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-665
> -=3D=3D=3D=3D=3DDiscovery Log Entry 667=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-666
> -=3D=3D=3D=3D=3DDiscovery Log Entry 668=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-667
> -=3D=3D=3D=3D=3DDiscovery Log Entry 669=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-668
> -=3D=3D=3D=3D=3DDiscovery Log Entry 670=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-669
> -=3D=3D=3D=3D=3DDiscovery Log Entry 671=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-670
> -=3D=3D=3D=3D=3DDiscovery Log Entry 672=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-671
> -=3D=3D=3D=3D=3DDiscovery Log Entry 673=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-672
> -=3D=3D=3D=3D=3DDiscovery Log Entry 674=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-673
> -=3D=3D=3D=3D=3DDiscovery Log Entry 675=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-674
> -=3D=3D=3D=3D=3DDiscovery Log Entry 676=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-675
> -=3D=3D=3D=3D=3DDiscovery Log Entry 677=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-676
> -=3D=3D=3D=3D=3DDiscovery Log Entry 678=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-677
> -=3D=3D=3D=3D=3DDiscovery Log Entry 679=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-678
> -=3D=3D=3D=3D=3DDiscovery Log Entry 680=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-679
> -=3D=3D=3D=3D=3DDiscovery Log Entry 681=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-680
> -=3D=3D=3D=3D=3DDiscovery Log Entry 682=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-681
> -=3D=3D=3D=3D=3DDiscovery Log Entry 683=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-682
> -=3D=3D=3D=3D=3DDiscovery Log Entry 684=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-683
> -=3D=3D=3D=3D=3DDiscovery Log Entry 685=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-684
> -=3D=3D=3D=3D=3DDiscovery Log Entry 686=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-685
> -=3D=3D=3D=3D=3DDiscovery Log Entry 687=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-686
> -=3D=3D=3D=3D=3DDiscovery Log Entry 688=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-687
> -=3D=3D=3D=3D=3DDiscovery Log Entry 689=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-688
> -=3D=3D=3D=3D=3DDiscovery Log Entry 690=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-689
> -=3D=3D=3D=3D=3DDiscovery Log Entry 691=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-690
> -=3D=3D=3D=3D=3DDiscovery Log Entry 692=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-691
> -=3D=3D=3D=3D=3DDiscovery Log Entry 693=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-692
> -=3D=3D=3D=3D=3DDiscovery Log Entry 694=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-693
> -=3D=3D=3D=3D=3DDiscovery Log Entry 695=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-694
> -=3D=3D=3D=3D=3DDiscovery Log Entry 696=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-695
> -=3D=3D=3D=3D=3DDiscovery Log Entry 697=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-696
> -=3D=3D=3D=3D=3DDiscovery Log Entry 698=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-697
> -=3D=3D=3D=3D=3DDiscovery Log Entry 699=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-698
> -=3D=3D=3D=3D=3DDiscovery Log Entry 700=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-699
> -=3D=3D=3D=3D=3DDiscovery Log Entry 701=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-700
> -=3D=3D=3D=3D=3DDiscovery Log Entry 702=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-701
> -=3D=3D=3D=3D=3DDiscovery Log Entry 703=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-702
> -=3D=3D=3D=3D=3DDiscovery Log Entry 704=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-703
> -=3D=3D=3D=3D=3DDiscovery Log Entry 705=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-704
> -=3D=3D=3D=3D=3DDiscovery Log Entry 706=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-705
> -=3D=3D=3D=3D=3DDiscovery Log Entry 707=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-706
> -=3D=3D=3D=3D=3DDiscovery Log Entry 708=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-707
> -=3D=3D=3D=3D=3DDiscovery Log Entry 709=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-708
> -=3D=3D=3D=3D=3DDiscovery Log Entry 710=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-709
> -=3D=3D=3D=3D=3DDiscovery Log Entry 711=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-710
> -=3D=3D=3D=3D=3DDiscovery Log Entry 712=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-711
> -=3D=3D=3D=3D=3DDiscovery Log Entry 713=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-712
> -=3D=3D=3D=3D=3DDiscovery Log Entry 714=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-713
> -=3D=3D=3D=3D=3DDiscovery Log Entry 715=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-714
> -=3D=3D=3D=3D=3DDiscovery Log Entry 716=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-715
> -=3D=3D=3D=3D=3DDiscovery Log Entry 717=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-716
> -=3D=3D=3D=3D=3DDiscovery Log Entry 718=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-717
> -=3D=3D=3D=3D=3DDiscovery Log Entry 719=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-718
> -=3D=3D=3D=3D=3DDiscovery Log Entry 720=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-719
> -=3D=3D=3D=3D=3DDiscovery Log Entry 721=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-720
> -=3D=3D=3D=3D=3DDiscovery Log Entry 722=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-721
> -=3D=3D=3D=3D=3DDiscovery Log Entry 723=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-722
> -=3D=3D=3D=3D=3DDiscovery Log Entry 724=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-723
> -=3D=3D=3D=3D=3DDiscovery Log Entry 725=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-724
> -=3D=3D=3D=3D=3DDiscovery Log Entry 726=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-725
> -=3D=3D=3D=3D=3DDiscovery Log Entry 727=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-726
> -=3D=3D=3D=3D=3DDiscovery Log Entry 728=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-727
> -=3D=3D=3D=3D=3DDiscovery Log Entry 729=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-728
> -=3D=3D=3D=3D=3DDiscovery Log Entry 730=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-729
> -=3D=3D=3D=3D=3DDiscovery Log Entry 731=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-730
> -=3D=3D=3D=3D=3DDiscovery Log Entry 732=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-731
> -=3D=3D=3D=3D=3DDiscovery Log Entry 733=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-732
> -=3D=3D=3D=3D=3DDiscovery Log Entry 734=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-733
> -=3D=3D=3D=3D=3DDiscovery Log Entry 735=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-734
> -=3D=3D=3D=3D=3DDiscovery Log Entry 736=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-735
> -=3D=3D=3D=3D=3DDiscovery Log Entry 737=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-736
> -=3D=3D=3D=3D=3DDiscovery Log Entry 738=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-737
> -=3D=3D=3D=3D=3DDiscovery Log Entry 739=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-738
> -=3D=3D=3D=3D=3DDiscovery Log Entry 740=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-739
> -=3D=3D=3D=3D=3DDiscovery Log Entry 741=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-740
> -=3D=3D=3D=3D=3DDiscovery Log Entry 742=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-741
> -=3D=3D=3D=3D=3DDiscovery Log Entry 743=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-742
> -=3D=3D=3D=3D=3DDiscovery Log Entry 744=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-743
> -=3D=3D=3D=3D=3DDiscovery Log Entry 745=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-744
> -=3D=3D=3D=3D=3DDiscovery Log Entry 746=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-745
> -=3D=3D=3D=3D=3DDiscovery Log Entry 747=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-746
> -=3D=3D=3D=3D=3DDiscovery Log Entry 748=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-747
> -=3D=3D=3D=3D=3DDiscovery Log Entry 749=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-748
> -=3D=3D=3D=3D=3DDiscovery Log Entry 750=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-749
> -=3D=3D=3D=3D=3DDiscovery Log Entry 751=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-750
> -=3D=3D=3D=3D=3DDiscovery Log Entry 752=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-751
> -=3D=3D=3D=3D=3DDiscovery Log Entry 753=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-752
> -=3D=3D=3D=3D=3DDiscovery Log Entry 754=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-753
> -=3D=3D=3D=3D=3DDiscovery Log Entry 755=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-754
> -=3D=3D=3D=3D=3DDiscovery Log Entry 756=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-755
> -=3D=3D=3D=3D=3DDiscovery Log Entry 757=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-756
> -=3D=3D=3D=3D=3DDiscovery Log Entry 758=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-757
> -=3D=3D=3D=3D=3DDiscovery Log Entry 759=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-758
> -=3D=3D=3D=3D=3DDiscovery Log Entry 760=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-759
> -=3D=3D=3D=3D=3DDiscovery Log Entry 761=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-760
> -=3D=3D=3D=3D=3DDiscovery Log Entry 762=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-761
> -=3D=3D=3D=3D=3DDiscovery Log Entry 763=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-762
> -=3D=3D=3D=3D=3DDiscovery Log Entry 764=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-763
> -=3D=3D=3D=3D=3DDiscovery Log Entry 765=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-764
> -=3D=3D=3D=3D=3DDiscovery Log Entry 766=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-765
> -=3D=3D=3D=3D=3DDiscovery Log Entry 767=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-766
> -=3D=3D=3D=3D=3DDiscovery Log Entry 768=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-767
> -=3D=3D=3D=3D=3DDiscovery Log Entry 769=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-768
> -=3D=3D=3D=3D=3DDiscovery Log Entry 770=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-769
> -=3D=3D=3D=3D=3DDiscovery Log Entry 771=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-770
> -=3D=3D=3D=3D=3DDiscovery Log Entry 772=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-771
> -=3D=3D=3D=3D=3DDiscovery Log Entry 773=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-772
> -=3D=3D=3D=3D=3DDiscovery Log Entry 774=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-773
> -=3D=3D=3D=3D=3DDiscovery Log Entry 775=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-774
> -=3D=3D=3D=3D=3DDiscovery Log Entry 776=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-775
> -=3D=3D=3D=3D=3DDiscovery Log Entry 777=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-776
> -=3D=3D=3D=3D=3DDiscovery Log Entry 778=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-777
> -=3D=3D=3D=3D=3DDiscovery Log Entry 779=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-778
> -=3D=3D=3D=3D=3DDiscovery Log Entry 780=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-779
> -=3D=3D=3D=3D=3DDiscovery Log Entry 781=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-780
> -=3D=3D=3D=3D=3DDiscovery Log Entry 782=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-781
> -=3D=3D=3D=3D=3DDiscovery Log Entry 783=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-782
> -=3D=3D=3D=3D=3DDiscovery Log Entry 784=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-783
> -=3D=3D=3D=3D=3DDiscovery Log Entry 785=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-784
> -=3D=3D=3D=3D=3DDiscovery Log Entry 786=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-785
> -=3D=3D=3D=3D=3DDiscovery Log Entry 787=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-786
> -=3D=3D=3D=3D=3DDiscovery Log Entry 788=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-787
> -=3D=3D=3D=3D=3DDiscovery Log Entry 789=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-788
> -=3D=3D=3D=3D=3DDiscovery Log Entry 790=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-789
> -=3D=3D=3D=3D=3DDiscovery Log Entry 791=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-790
> -=3D=3D=3D=3D=3DDiscovery Log Entry 792=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-791
> -=3D=3D=3D=3D=3DDiscovery Log Entry 793=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-792
> -=3D=3D=3D=3D=3DDiscovery Log Entry 794=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-793
> -=3D=3D=3D=3D=3DDiscovery Log Entry 795=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-794
> -=3D=3D=3D=3D=3DDiscovery Log Entry 796=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-795
> -=3D=3D=3D=3D=3DDiscovery Log Entry 797=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-796
> -=3D=3D=3D=3D=3DDiscovery Log Entry 798=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-797
> -=3D=3D=3D=3D=3DDiscovery Log Entry 799=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-798
> -=3D=3D=3D=3D=3DDiscovery Log Entry 800=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-799
> -=3D=3D=3D=3D=3DDiscovery Log Entry 801=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-800
> -=3D=3D=3D=3D=3DDiscovery Log Entry 802=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-801
> -=3D=3D=3D=3D=3DDiscovery Log Entry 803=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-802
> -=3D=3D=3D=3D=3DDiscovery Log Entry 804=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-803
> -=3D=3D=3D=3D=3DDiscovery Log Entry 805=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-804
> -=3D=3D=3D=3D=3DDiscovery Log Entry 806=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-805
> -=3D=3D=3D=3D=3DDiscovery Log Entry 807=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-806
> -=3D=3D=3D=3D=3DDiscovery Log Entry 808=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-807
> -=3D=3D=3D=3D=3DDiscovery Log Entry 809=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-808
> -=3D=3D=3D=3D=3DDiscovery Log Entry 810=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-809
> -=3D=3D=3D=3D=3DDiscovery Log Entry 811=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-810
> -=3D=3D=3D=3D=3DDiscovery Log Entry 812=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-811
> -=3D=3D=3D=3D=3DDiscovery Log Entry 813=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-812
> -=3D=3D=3D=3D=3DDiscovery Log Entry 814=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-813
> -=3D=3D=3D=3D=3DDiscovery Log Entry 815=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-814
> -=3D=3D=3D=3D=3DDiscovery Log Entry 816=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-815
> -=3D=3D=3D=3D=3DDiscovery Log Entry 817=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-816
> -=3D=3D=3D=3D=3DDiscovery Log Entry 818=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-817
> -=3D=3D=3D=3D=3DDiscovery Log Entry 819=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-818
> -=3D=3D=3D=3D=3DDiscovery Log Entry 820=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-819
> -=3D=3D=3D=3D=3DDiscovery Log Entry 821=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-820
> -=3D=3D=3D=3D=3DDiscovery Log Entry 822=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-821
> -=3D=3D=3D=3D=3DDiscovery Log Entry 823=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-822
> -=3D=3D=3D=3D=3DDiscovery Log Entry 824=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-823
> -=3D=3D=3D=3D=3DDiscovery Log Entry 825=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-824
> -=3D=3D=3D=3D=3DDiscovery Log Entry 826=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-825
> -=3D=3D=3D=3D=3DDiscovery Log Entry 827=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-826
> -=3D=3D=3D=3D=3DDiscovery Log Entry 828=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-827
> -=3D=3D=3D=3D=3DDiscovery Log Entry 829=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-828
> -=3D=3D=3D=3D=3DDiscovery Log Entry 830=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-829
> -=3D=3D=3D=3D=3DDiscovery Log Entry 831=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-830
> -=3D=3D=3D=3D=3DDiscovery Log Entry 832=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-831
> -=3D=3D=3D=3D=3DDiscovery Log Entry 833=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-832
> -=3D=3D=3D=3D=3DDiscovery Log Entry 834=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-833
> -=3D=3D=3D=3D=3DDiscovery Log Entry 835=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-834
> -=3D=3D=3D=3D=3DDiscovery Log Entry 836=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-835
> -=3D=3D=3D=3D=3DDiscovery Log Entry 837=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-836
> -=3D=3D=3D=3D=3DDiscovery Log Entry 838=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-837
> -=3D=3D=3D=3D=3DDiscovery Log Entry 839=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-838
> -=3D=3D=3D=3D=3DDiscovery Log Entry 840=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-839
> -=3D=3D=3D=3D=3DDiscovery Log Entry 841=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-840
> -=3D=3D=3D=3D=3DDiscovery Log Entry 842=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-841
> -=3D=3D=3D=3D=3DDiscovery Log Entry 843=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-842
> -=3D=3D=3D=3D=3DDiscovery Log Entry 844=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-843
> -=3D=3D=3D=3D=3DDiscovery Log Entry 845=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-844
> -=3D=3D=3D=3D=3DDiscovery Log Entry 846=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-845
> -=3D=3D=3D=3D=3DDiscovery Log Entry 847=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-846
> -=3D=3D=3D=3D=3DDiscovery Log Entry 848=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-847
> -=3D=3D=3D=3D=3DDiscovery Log Entry 849=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-848
> -=3D=3D=3D=3D=3DDiscovery Log Entry 850=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-849
> -=3D=3D=3D=3D=3DDiscovery Log Entry 851=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-850
> -=3D=3D=3D=3D=3DDiscovery Log Entry 852=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-851
> -=3D=3D=3D=3D=3DDiscovery Log Entry 853=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-852
> -=3D=3D=3D=3D=3DDiscovery Log Entry 854=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-853
> -=3D=3D=3D=3D=3DDiscovery Log Entry 855=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-854
> -=3D=3D=3D=3D=3DDiscovery Log Entry 856=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-855
> -=3D=3D=3D=3D=3DDiscovery Log Entry 857=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-856
> -=3D=3D=3D=3D=3DDiscovery Log Entry 858=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-857
> -=3D=3D=3D=3D=3DDiscovery Log Entry 859=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-858
> -=3D=3D=3D=3D=3DDiscovery Log Entry 860=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-859
> -=3D=3D=3D=3D=3DDiscovery Log Entry 861=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-860
> -=3D=3D=3D=3D=3DDiscovery Log Entry 862=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-861
> -=3D=3D=3D=3D=3DDiscovery Log Entry 863=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-862
> -=3D=3D=3D=3D=3DDiscovery Log Entry 864=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-863
> -=3D=3D=3D=3D=3DDiscovery Log Entry 865=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-864
> -=3D=3D=3D=3D=3DDiscovery Log Entry 866=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-865
> -=3D=3D=3D=3D=3DDiscovery Log Entry 867=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-866
> -=3D=3D=3D=3D=3DDiscovery Log Entry 868=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-867
> -=3D=3D=3D=3D=3DDiscovery Log Entry 869=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-868
> -=3D=3D=3D=3D=3DDiscovery Log Entry 870=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-869
> -=3D=3D=3D=3D=3DDiscovery Log Entry 871=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-870
> -=3D=3D=3D=3D=3DDiscovery Log Entry 872=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-871
> -=3D=3D=3D=3D=3DDiscovery Log Entry 873=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-872
> -=3D=3D=3D=3D=3DDiscovery Log Entry 874=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-873
> -=3D=3D=3D=3D=3DDiscovery Log Entry 875=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-874
> -=3D=3D=3D=3D=3DDiscovery Log Entry 876=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-875
> -=3D=3D=3D=3D=3DDiscovery Log Entry 877=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-876
> -=3D=3D=3D=3D=3DDiscovery Log Entry 878=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-877
> -=3D=3D=3D=3D=3DDiscovery Log Entry 879=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-878
> -=3D=3D=3D=3D=3DDiscovery Log Entry 880=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-879
> -=3D=3D=3D=3D=3DDiscovery Log Entry 881=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-880
> -=3D=3D=3D=3D=3DDiscovery Log Entry 882=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-881
> -=3D=3D=3D=3D=3DDiscovery Log Entry 883=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-882
> -=3D=3D=3D=3D=3DDiscovery Log Entry 884=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-883
> -=3D=3D=3D=3D=3DDiscovery Log Entry 885=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-884
> -=3D=3D=3D=3D=3DDiscovery Log Entry 886=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-885
> -=3D=3D=3D=3D=3DDiscovery Log Entry 887=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-886
> -=3D=3D=3D=3D=3DDiscovery Log Entry 888=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-887
> -=3D=3D=3D=3D=3DDiscovery Log Entry 889=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-888
> -=3D=3D=3D=3D=3DDiscovery Log Entry 890=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-889
> -=3D=3D=3D=3D=3DDiscovery Log Entry 891=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-890
> -=3D=3D=3D=3D=3DDiscovery Log Entry 892=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-891
> -=3D=3D=3D=3D=3DDiscovery Log Entry 893=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-892
> -=3D=3D=3D=3D=3DDiscovery Log Entry 894=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-893
> -=3D=3D=3D=3D=3DDiscovery Log Entry 895=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-894
> -=3D=3D=3D=3D=3DDiscovery Log Entry 896=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-895
> -=3D=3D=3D=3D=3DDiscovery Log Entry 897=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-896
> -=3D=3D=3D=3D=3DDiscovery Log Entry 898=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-897
> -=3D=3D=3D=3D=3DDiscovery Log Entry 899=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-898
> -=3D=3D=3D=3D=3DDiscovery Log Entry 900=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-899
> -=3D=3D=3D=3D=3DDiscovery Log Entry 901=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-900
> -=3D=3D=3D=3D=3DDiscovery Log Entry 902=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-901
> -=3D=3D=3D=3D=3DDiscovery Log Entry 903=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-902
> -=3D=3D=3D=3D=3DDiscovery Log Entry 904=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-903
> -=3D=3D=3D=3D=3DDiscovery Log Entry 905=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-904
> -=3D=3D=3D=3D=3DDiscovery Log Entry 906=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-905
> -=3D=3D=3D=3D=3DDiscovery Log Entry 907=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-906
> -=3D=3D=3D=3D=3DDiscovery Log Entry 908=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-907
> -=3D=3D=3D=3D=3DDiscovery Log Entry 909=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-908
> -=3D=3D=3D=3D=3DDiscovery Log Entry 910=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-909
> -=3D=3D=3D=3D=3DDiscovery Log Entry 911=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-910
> -=3D=3D=3D=3D=3DDiscovery Log Entry 912=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-911
> -=3D=3D=3D=3D=3DDiscovery Log Entry 913=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-912
> -=3D=3D=3D=3D=3DDiscovery Log Entry 914=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-913
> -=3D=3D=3D=3D=3DDiscovery Log Entry 915=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-914
> -=3D=3D=3D=3D=3DDiscovery Log Entry 916=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-915
> -=3D=3D=3D=3D=3DDiscovery Log Entry 917=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-916
> -=3D=3D=3D=3D=3DDiscovery Log Entry 918=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-917
> -=3D=3D=3D=3D=3DDiscovery Log Entry 919=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-918
> -=3D=3D=3D=3D=3DDiscovery Log Entry 920=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-919
> -=3D=3D=3D=3D=3DDiscovery Log Entry 921=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-920
> -=3D=3D=3D=3D=3DDiscovery Log Entry 922=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-921
> -=3D=3D=3D=3D=3DDiscovery Log Entry 923=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-922
> -=3D=3D=3D=3D=3DDiscovery Log Entry 924=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-923
> -=3D=3D=3D=3D=3DDiscovery Log Entry 925=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-924
> -=3D=3D=3D=3D=3DDiscovery Log Entry 926=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-925
> -=3D=3D=3D=3D=3DDiscovery Log Entry 927=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-926
> -=3D=3D=3D=3D=3DDiscovery Log Entry 928=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-927
> -=3D=3D=3D=3D=3DDiscovery Log Entry 929=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-928
> -=3D=3D=3D=3D=3DDiscovery Log Entry 930=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-929
> -=3D=3D=3D=3D=3DDiscovery Log Entry 931=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-930
> -=3D=3D=3D=3D=3DDiscovery Log Entry 932=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-931
> -=3D=3D=3D=3D=3DDiscovery Log Entry 933=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-932
> -=3D=3D=3D=3D=3DDiscovery Log Entry 934=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-933
> -=3D=3D=3D=3D=3DDiscovery Log Entry 935=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-934
> -=3D=3D=3D=3D=3DDiscovery Log Entry 936=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-935
> -=3D=3D=3D=3D=3DDiscovery Log Entry 937=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-936
> -=3D=3D=3D=3D=3DDiscovery Log Entry 938=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-937
> -=3D=3D=3D=3D=3DDiscovery Log Entry 939=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-938
> -=3D=3D=3D=3D=3DDiscovery Log Entry 940=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-939
> -=3D=3D=3D=3D=3DDiscovery Log Entry 941=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-940
> -=3D=3D=3D=3D=3DDiscovery Log Entry 942=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-941
> -=3D=3D=3D=3D=3DDiscovery Log Entry 943=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-942
> -=3D=3D=3D=3D=3DDiscovery Log Entry 944=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-943
> -=3D=3D=3D=3D=3DDiscovery Log Entry 945=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-944
> -=3D=3D=3D=3D=3DDiscovery Log Entry 946=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-945
> -=3D=3D=3D=3D=3DDiscovery Log Entry 947=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-946
> -=3D=3D=3D=3D=3DDiscovery Log Entry 948=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-947
> -=3D=3D=3D=3D=3DDiscovery Log Entry 949=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-948
> -=3D=3D=3D=3D=3DDiscovery Log Entry 950=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-949
> -=3D=3D=3D=3D=3DDiscovery Log Entry 951=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-950
> -=3D=3D=3D=3D=3DDiscovery Log Entry 952=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-951
> -=3D=3D=3D=3D=3DDiscovery Log Entry 953=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-952
> -=3D=3D=3D=3D=3DDiscovery Log Entry 954=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-953
> -=3D=3D=3D=3D=3DDiscovery Log Entry 955=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-954
> -=3D=3D=3D=3D=3DDiscovery Log Entry 956=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-955
> -=3D=3D=3D=3D=3DDiscovery Log Entry 957=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-956
> -=3D=3D=3D=3D=3DDiscovery Log Entry 958=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-957
> -=3D=3D=3D=3D=3DDiscovery Log Entry 959=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-958
> -=3D=3D=3D=3D=3DDiscovery Log Entry 960=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-959
> -=3D=3D=3D=3D=3DDiscovery Log Entry 961=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-960
> -=3D=3D=3D=3D=3DDiscovery Log Entry 962=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-961
> -=3D=3D=3D=3D=3DDiscovery Log Entry 963=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-962
> -=3D=3D=3D=3D=3DDiscovery Log Entry 964=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-963
> -=3D=3D=3D=3D=3DDiscovery Log Entry 965=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-964
> -=3D=3D=3D=3D=3DDiscovery Log Entry 966=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-965
> -=3D=3D=3D=3D=3DDiscovery Log Entry 967=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-966
> -=3D=3D=3D=3D=3DDiscovery Log Entry 968=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-967
> -=3D=3D=3D=3D=3DDiscovery Log Entry 969=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-968
> -=3D=3D=3D=3D=3DDiscovery Log Entry 970=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-969
> -=3D=3D=3D=3D=3DDiscovery Log Entry 971=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-970
> -=3D=3D=3D=3D=3DDiscovery Log Entry 972=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-971
> -=3D=3D=3D=3D=3DDiscovery Log Entry 973=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-972
> -=3D=3D=3D=3D=3DDiscovery Log Entry 974=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-973
> -=3D=3D=3D=3D=3DDiscovery Log Entry 975=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-974
> -=3D=3D=3D=3D=3DDiscovery Log Entry 976=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-975
> -=3D=3D=3D=3D=3DDiscovery Log Entry 977=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-976
> -=3D=3D=3D=3D=3DDiscovery Log Entry 978=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-977
> -=3D=3D=3D=3D=3DDiscovery Log Entry 979=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-978
> -=3D=3D=3D=3D=3DDiscovery Log Entry 980=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-979
> -=3D=3D=3D=3D=3DDiscovery Log Entry 981=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-980
> -=3D=3D=3D=3D=3DDiscovery Log Entry 982=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-981
> -=3D=3D=3D=3D=3DDiscovery Log Entry 983=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-982
> -=3D=3D=3D=3D=3DDiscovery Log Entry 984=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-983
> -=3D=3D=3D=3D=3DDiscovery Log Entry 985=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-984
> -=3D=3D=3D=3D=3DDiscovery Log Entry 986=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-985
> -=3D=3D=3D=3D=3DDiscovery Log Entry 987=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-986
> -=3D=3D=3D=3D=3DDiscovery Log Entry 988=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-987
> -=3D=3D=3D=3D=3DDiscovery Log Entry 989=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-988
> -=3D=3D=3D=3D=3DDiscovery Log Entry 990=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-989
> -=3D=3D=3D=3D=3DDiscovery Log Entry 991=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-990
> -=3D=3D=3D=3D=3DDiscovery Log Entry 992=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-991
> -=3D=3D=3D=3D=3DDiscovery Log Entry 993=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-992
> -=3D=3D=3D=3D=3DDiscovery Log Entry 994=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-993
> -=3D=3D=3D=3D=3DDiscovery Log Entry 995=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-994
> -=3D=3D=3D=3D=3DDiscovery Log Entry 996=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-995
> -=3D=3D=3D=3D=3DDiscovery Log Entry 997=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-996
> -=3D=3D=3D=3D=3DDiscovery Log Entry 998=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-997
> -=3D=3D=3D=3D=3DDiscovery Log Entry 999=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-998
> -=3D=3D=3D=3D=3DDiscovery Log Entry 1000=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-999
>  Test complete
> diff --git a/tests/nvme/030 b/tests/nvme/030
> index 20fef696e565..cfcdcbe6be23 100755
> --- a/tests/nvme/030
> +++ b/tests/nvme/030
> @@ -15,20 +15,6 @@ requires() {
>  	_require_nvme_trtype_is_fabrics
>  }
> =20
> -
> -checkgenctr() {
> -	local last=3D$1
> -	local msg=3D$2
> -	local genctr
> -
> -	genctr=3D$(_discovery_genctr)
> -	if (( "${genctr}" <=3D "${last}" )); then
> -		echo "Generation counter not incremented when ${msg} (${genctr} <=3D $=
{last})"
> -	fi
> -
> -	echo "${genctr}"
> -}
> -
>  test() {
>  	local port
>  	local genctr
> @@ -48,20 +34,20 @@ test() {
>  	_create_nvmet_subsystem "${subsys}2" "$(losetup -f)"
>  	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
> =20
> -	genctr=3D$(checkgenctr "${genctr}" "adding a subsystem to a port")
> +	genctr=3D$(_check_genctr "${genctr}" "adding a subsystem to a port")
> =20
>  	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> =20
> -	genctr=3D$(checkgenctr "${genctr}" "clearing attr_allow_any_host")
> +	genctr=3D$(_check_genctr "${genctr}" "clearing attr_allow_any_host")
> =20
>  	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> =20
> -	genctr=3D$(checkgenctr "${genctr}" "setting attr_allow_any_host")
> +	genctr=3D$(_check_genctr "${genctr}" "setting attr_allow_any_host")
> =20
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
>  	_remove_nvmet_subsystem "${subsys}2"
> =20
> -	genctr=3D$(checkgenctr "${genctr}" "removing a subsystem from a port")
> +	genctr=3D$(_check_genctr "${genctr}" "removing a subsystem from a port"=
)
> =20
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
>  	_remove_nvmet_subsystem "${subsys}1"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 172f510527ed..2aa34fb0c9b8 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -755,6 +755,19 @@ _discovery_genctr() {
>  		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>  }
> =20
> +_check_genctr() {
> +	local last=3D$1
> +	local msg=3D$2
> +	local genctr
> +
> +	genctr=3D$(_discovery_genctr)
> +	if (( "${genctr}" <=3D "${last}" )); then
> +		echo "Generation counter not incremented when ${msg} (${genctr} <=3D $=
{last})"
> +	fi
> +
> +	echo "${genctr}"
> +}
> +
>  declare -A NS_DEV_FAULT_INJECT_SAVE
>  declare -A CTRL_DEV_FAULT_INJECT_SAVE
> =20
> --=20
> 2.40.0
> =
