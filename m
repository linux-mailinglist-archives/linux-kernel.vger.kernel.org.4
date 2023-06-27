Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5C73FA31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjF0K0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjF0K0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:26:03 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397AA3AAF;
        Tue, 27 Jun 2023 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687861473; x=1719397473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K3w7zVWa+TdlBYagDsxZoA0pvWubZFkVo4OSiyDgsEE=;
  b=ArGj6Q2KDeDKegC/lUVoylvhfAcxmx5jrddY7Hk8ONzfdkpRefFav6cS
   E1SDPgsNRO50qnUDyjzk9E+EWtzW2apcB3GAPdtyzeitD1frjbZ5EORV0
   CZ02aB9+Pi/EYJZw+z3u6HzGdrQKrKPl8aV4Vx5JgNEHVCpwEALY7Pc8F
   BEr3v8JXgt7MVtfjHyh5QM+9P/UXVV/E2JS6EYUZJ975NH7dqyBKBURDq
   7tNzJ7cC0f7Xrs/WTaF81fBazN4zAIgao0z6IRghFb5hRl/ekG8fw95To
   I2B31LeHqAGUcrmuopEE2JDex0VFs2tm0yUy3JligPDyziqMgtvQ8AoXL
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="236333225"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 18:24:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odXxVxb4O2LCLE6ZwWko2jxBkBJ5BgVblcTyyReE1Dbl4PZsmTEVfKc47KSbn70vRV47nUrWf8+UQcW45BJMHeNokPAkSz1ooYM20vES2hFy9l+5YvM5VbzMvUNXyWKmOMvmcs1HVHUdG0b1P9VzjV7jnUyN7PVRXjsib35jtrABrCzgiz1OmoWn520FbItVOKNcmeLJqknir1Mq06JnExVDB+SG2CDQ8A0jSfj7DislTGdSSCnOuuZItQhSCJ9urZShgIDTK0bWCnLnLEJ853x6NAzwLfUMviIK/CrTseqLU5doR+UPCCmMrrDLuy0psQJInHzC5um5Kd6tygdfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bUeUqY0Bd45Ri827UHjn64ljHdWDasB72dtOTcW12Q=;
 b=THwT+uftFcAV6VUn5rbvWVO78TEvm6MZ9tvnxKLIiNKn9VkQ+dMnYple6757Yxo2NrNmijQPa6REiXxsAihGA86Jic4a572Gy3nxPlfo8CeEy8LFmQuQJHLydbmsdkOl5RKscI6rOQ1riXfXP8IYi+zRuq57GEwaxj9thC4JB+CO/22xZr3hFW/63SxkexC6fcJ4N6x5hhvIx9QwMYNFVAMC5bYJwR7cdYTgdt3gBpp7RjdOWixeJsVeLzLGRko6ARolMIAuWLvIRNqjuxHD1J3ZqQBFGuvRWe2rugmQGxgi7nZv42hex8Mv97aSe9TnTRbrvrczHqFmGIm5fZyDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bUeUqY0Bd45Ri827UHjn64ljHdWDasB72dtOTcW12Q=;
 b=oE1P2FPTJjLcHivQaLFfR5hI11u2eQv70zgv90TwHAqnvdx4FHs79q8zeLxG47s+GSyIqc3JDcq61RYsUQukLZAjLXNmHDt8zvJgH1rRuUXNjG0E9rRLTKkVNzFd9+gV6kCbJO0rbwa+8vvgCq/SdudqXvZlk+R4tC0YA39bOwg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6518.namprd04.prod.outlook.com (2603:10b6:a03:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 10:24:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 10:24:26 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 3/3] nvme/{041,042,043,044,045}: Use default
 hostnqn and hostid
Thread-Topic: [PATCH blktests v1 3/3] nvme/{041,042,043,044,045}: Use default
 hostnqn and hostid
Thread-Index: AQHZqOGMfejaWL3WEUaOrMmB0dz8+A==
Date:   Tue, 27 Jun 2023 10:24:26 +0000
Message-ID: <d7ydoif4dhrlndwks6kv6meys3mrjva4vrwt7tbndr2gytvyof@3bivhzxfg2q4>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-4-dwagner@suse.de>
In-Reply-To: <20230620132703.20648-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6518:EE_
x-ms-office365-filtering-correlation-id: 3ff5e2dd-95f7-4d39-11e2-08db76f8af34
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkO0Jt8npAGk0sTv4iehRB35GMtlXC2AJOEvXl2gstTNiRw6eaHOO4CNWDTeXLhDuuikmwJ7CqjXsi1VEBv1smiXXcz1q9XEpH9JCqTHpyhQuosKXw0WLaPC3CO6lGBl1WrtZJzGz+dA1CHXWWXyow9wf2xIxbsah+WN6EVp2M2EQePpWQ/yb1uUxztXcJjEj0l6hSwXD+hNfb+Mh1DHle2sOoIHbzV085/l+Lj+jKU4jdRJptDWAYtArvaC3kRf7N+V5P71BBQrK1TxDodaW32JTzRK/4xdIiEOpPes4jny+ynm7Y7PVncX0pK/T8wSMwK6Fk9fx8Uo28ROote8O9ii4RF98SmrsnPcZbwAYZUDUvBMvAplh8cSNcZdyjM0aLcbDg1kmO7/Q9fZINUrPLMuoZebM12ZSgunTOKPIZYHvqY6t4wm7wo1Ds67l50v+tlVQDxPsGxXAX3kOjaSCRFtWfVEzLfkFJKhb0I61+34PQx8ioQE3OAD4Mp+10Dxdq2ymG6snqXug2QnASV49F0JAGPULGY/EtxAx9GMCaScAscDRZPxyEMUbqbtpLMxJSp9QMM8O4v1EJ9DyZcyszbSyS5BX7SBBnHW2wLz3UWXBxfuFrwKI/QhpPheth/a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(38100700002)(5660300002)(44832011)(86362001)(33716001)(41300700001)(7416002)(66476007)(6916009)(8936002)(64756008)(91956017)(38070700005)(66446008)(8676002)(66556008)(316002)(66946007)(122000001)(4326008)(76116006)(82960400001)(478600001)(6486002)(2906002)(186003)(6506007)(9686003)(6512007)(71200400001)(26005)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YgBQ4d9OSa8c9p4Wkv3T4GiIfJL95yct+aMRq58PrEJdEz251sHRNQ1s/vZF?=
 =?us-ascii?Q?WgoJBl9rCMOqK5Ubq9uEjuX8sN2UTAidABof5UTVL85ln4Xq+ihMP181OCBj?=
 =?us-ascii?Q?24Jf1zli6r1V8DggPmzjQJMfMeUDCy9vsORv18E6t5nmkrPCVqEJrdN3m6Uo?=
 =?us-ascii?Q?MXVx8PPKGuV/w/smFvupAEc9D4yv/5PbNqKZS1ENp1lX95jEQXAOZEJvJTfJ?=
 =?us-ascii?Q?GAyNFmRehq3SjaQ8HyynPX43GOmyCkrafdx3n2gPMwUG/SEgNua9qD9/o52j?=
 =?us-ascii?Q?Ku9K9R5ytvamRphrh9hgLevsKtN+kZiQAr1inGG4XKIwgBaL7uC6YDHw3VDL?=
 =?us-ascii?Q?xjaTMPiveOjwDWRD6FivfZHjg15HAdwU1Xs0Wm5UeCLV8T2ScPxiyra2In7M?=
 =?us-ascii?Q?2xgNA0Br+oUly20SPmgqQYuQP6qPbGgcrW8SBUG4wggWsAVVyEWQAymMsdYN?=
 =?us-ascii?Q?vlKh0m8d2EBrybIcrEg+paMG6+KWf7G8rLNoohxJvNpRZ7p9jDVM6t8h+cWb?=
 =?us-ascii?Q?K8pVyVx5jV8R2wyWNAX+27yQr4OjeNRoGzVGped6+m7qI3JUi89I8kIUg8N/?=
 =?us-ascii?Q?A5R13fU3D4Qh1JrhJgGT+AC4KrsuqDwqUdMRpO9ZkVA1glkNrjtaceWMWl2m?=
 =?us-ascii?Q?WuRaHTrtJec2nU6nwyG/uXcNs313qOmjBWc+AZxnHwZc04kZbJkR39sCeJTR?=
 =?us-ascii?Q?FLMvTUHSw71+GkcapbE67XS+Lyq14PHSICxEqqKaksbMdANY0JFi2gjGCf3u?=
 =?us-ascii?Q?pnWo2ZT+kKgbbzp3I5sD8cCPGCK1KrgtDvifG+f7ila69EYWhafFIopTu/GO?=
 =?us-ascii?Q?ZqEb1pJkKaAvgjVOeDFDi1ueSDLc+Xe8kZM/V9ewtdYWKuLwsccaGcWOy3z4?=
 =?us-ascii?Q?Oi0UgYa3IqcNbnNgsB3UxdY0nbjVqDXTGFZnLjyWUxl4rlHYrGnW3EXsGkXf?=
 =?us-ascii?Q?ZwocI86ZIgSW811kS2vdrSWiK20nfovbx5J6nBVrFDjTRq7FSpLWKG9YjHPl?=
 =?us-ascii?Q?djzQT6eQx0DrNewk8RLwTZV8uDspYSih6y+aGKAidnDBoCxCnEr97SrIwQaz?=
 =?us-ascii?Q?ZP+j03SGCgSFScUDfVFqZPL3gJHU7ygD1FqNirve79cmK81o6IKFJCUimQR4?=
 =?us-ascii?Q?kvjREsYSkH1yqmdiTOJa19BcWTN0o4Ps1mF+9kuA8vBuUBJY1OWr/mCrhAks?=
 =?us-ascii?Q?OamPIpkX+Rjg+3VN3sIQs3w6z8TlAoefTkzE1ql83ldHQOYS4JX6xyS7jbL9?=
 =?us-ascii?Q?4tqJXp+XSgwyvkAOKL4Yz5RkC2hKTaiIEX7yFlZVHosRxDgG/hFeO/GypSpQ?=
 =?us-ascii?Q?h6+AvLaltTFybzx7+xam0j6cSUSFFxp8WoolVJrN998A6ks0rwCX7WqtT6ez?=
 =?us-ascii?Q?Jdk70aRdpwOZFzjuKw/K3TyRtoqGhvdLdeKxORLrj8rMYj1A6RQUIhtsa4WR?=
 =?us-ascii?Q?vlSTscytgXyc3oM3SkIvOpwfzq/Dfzhg7iuMtOv9SY8LfZqWMDZnOX1osOaZ?=
 =?us-ascii?Q?CSgITDl5462VuVCBl+nFOXZxtHmo4+EAJqMq+tpItHpx0MqbTdI5uvtwx5ub?=
 =?us-ascii?Q?SHzKhuwjcbcTWXRjwcgIj9XLwM8oE3sDAKO1ZX9SRg3s4jbbdCalR9TwIe3A?=
 =?us-ascii?Q?ZYqzuML23+fHBxQD0xpQWpA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15A82B084EEEBB48BC2B5CD2AA2AE7C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wgMMjcY/Ogp6DcqwZrmBeVDwERHuWbEnW7guh5KMBqGtIHurK2ObkyEF2Z8U?=
 =?us-ascii?Q?aC98bKk7Z4hvbd+SD6S2ymUnBeSkpVdKYDmbltZRIjduQOIjBVmhcgXuV4Kj?=
 =?us-ascii?Q?Ihgu4pjWVRyBBV8iUAsKigUlULxZgouvPwa5Z9hZmMtCgvF+7C5NY5VmSIb6?=
 =?us-ascii?Q?2iT26YU8ltm68JDeofJUeSKQf4bxmVw3P4FZnXcHeF+Ul6H8Z3cfFgl5eL8b?=
 =?us-ascii?Q?XgvCXRO/03C1RsDiuHoC9jo5ILNzceDGmtdmungfQOowiyucd0+B9iEroNfJ?=
 =?us-ascii?Q?9m9nzRzw6wKOoqmjA7WzbDMr5UVTbDcXn8hEQf1a7rYGu53P0S+RzoPDdgrY?=
 =?us-ascii?Q?be0Iwfitqk9ZBcN542TZZi6BfbAPjgKODsXUVaICC7eRJ9jJUU+v+Na920gt?=
 =?us-ascii?Q?MS53Fp7l3GVB7gcb+Dirq1fAttK/nAhQI4ZjD2ejrgKbsufwOC/cY6D2b9cC?=
 =?us-ascii?Q?zu+YVhH3ZWOxKdgaCK3mgdybG6A5k7g7zvyzP/2tqyyTwE7PSnh9Jt/jqOnu?=
 =?us-ascii?Q?7XSvhDML4qarvKYim3X120mN7ddPGzKBFN6J7Qlipuw5X3iSVhSDppOdjdIM?=
 =?us-ascii?Q?VuyWUEIVlAyj5iak3i1dvn8CTfaFGPNhwfDwWTpmiNFgoks/JJDEWp3IMmxm?=
 =?us-ascii?Q?RhWeTUBrcIscWmtW53CderZBLuTgzVM2YNx028YDGavyhF84mVDjMGt13VSK?=
 =?us-ascii?Q?xi3ZlpQJhwpj8I7nAE2W2zNi0E2lG9CWWWgFD1GZZ+v1nLplDKTV114Qzaqi?=
 =?us-ascii?Q?47Go5YFbSDDOQ80do+wSNb+fBlSpEqpD9LNO7dNwLkXBLXXX7ngQBbwPNwze?=
 =?us-ascii?Q?/zt70CBxDpAhE1r80yA3B4a5sOLGXwoMtSZ2vC34WM61+cE4gsxiOAxQ9EEe?=
 =?us-ascii?Q?NPlNSn7d+280/TtLmsP3D5Q2SXvzrGYBAkJPDt9LhGTZdSQWZkuJ/Dugiz+z?=
 =?us-ascii?Q?EwetbbCUQAc6XnB6j6J+uw9rxefG+Qr8srR2BIrXFmlSPkPK1/SmBnnP+Rju?=
 =?us-ascii?Q?5rpZ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff5e2dd-95f7-4d39-11e2-08db76f8af34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 10:24:26.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ww0PCR7ohGyWKWtJvfxMTnxw0uRMPJRAqfqy3dRfY2C5GDaVDwT0ygtvsLcdDk2wmoccuLBUDap5sfCAKhyWoRXUhfcBSLr9tifooJMpW/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6518
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
> The host might have enabled the udev/systemd auto connect feature.
> This disturbs the blktests for the fc transport. nvme-cli is able
> to distinguish between the different invocations via the --context
> option. In order to get this working we have to use the default
> hostnqn and hostid and not randon generated IDs for every single

Nit: s/randon/random/, probably.

Other than that this patch looks good to me.

> run.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/041 | 8 ++------
>  tests/nvme/042 | 8 ++------
>  tests/nvme/043 | 8 ++------
>  tests/nvme/044 | 8 ++------
>  tests/nvme/045 | 8 ++------
>  5 files changed, 10 insertions(+), 30 deletions(-)
>=20
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index 308655dd6090..5b04b99b128e 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -30,12 +30,8 @@ test() {
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> -	hostid=3D"$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid=3D"${def_hostid}"
> +	hostnqn=3D"${def_hostnqn}"
>  	hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>  	if [ -z "$hostkey" ] ; then
>  		echo "nvme gen-dhchap-key failed"
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index fed2efead013..8df5ed37aacc 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -32,12 +32,8 @@ test() {
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> -	hostid=3D"$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid=3D"${def_hostid}"
> +	hostnqn=3D"${def_hostnqn}"
> =20
>  	_setup_nvmet
> =20
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index a030884aa4ed..b591e39d0706 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -33,12 +33,8 @@ test() {
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> -	hostid=3D"$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid=3D"${def_hostid}"
> +	hostnqn=3D"${def_hostnqn}"
> =20
>  	_setup_nvmet
> =20
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index 9928bcc55397..fca0897af27b 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -32,12 +32,8 @@ test() {
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> -	hostid=3D"$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid=3D"${def_hostid}"
> +	hostnqn=3D"${def_hostnqn}"
> =20
>  	hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>  	if [ -z "$hostkey" ] ; then
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 26a55335a92c..eca629a18691 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -36,12 +36,8 @@ test() {
> =20
>  	echo "Running ${TEST_NAME}"
> =20
> -	hostid=3D"$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid=3D"${def_hostid}"
> +	hostnqn=3D"${def_hostnqn}"
> =20
>  	hostkey=3D"$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>  	if [ -z "$hostkey" ] ; then
> --=20
> 2.41.0
> =
