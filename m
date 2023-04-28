Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81D96F10F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbjD1EMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjD1EMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:12:13 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422A19BB;
        Thu, 27 Apr 2023 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682655131; x=1714191131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+wNh+FZ6FqNC3lCE9UTkix23TNZPbzD5dDPVArikRjo=;
  b=WdFi4wdaP5DdXns6CHZ6MWv0HUQCmOodulRk/e7hdClwvajjXiL8Re8R
   TIme/AZEn5Ch6ZY2pmrK2pw7O6022loNcd5XUaqSpBBQ8mB1XPkpwkNx1
   UH5CL+P6sX4jo1nwub89sDTfcbzCutTckejUI5wSbZeVdV6tQnD+djT/0
   ZGnmcC0fK8WjlWfIfg+WhZMf4tIUAQ/bQCvuxIudNaPwnU7V+bChtpQxR
   1tzlXtFBjvXe+RVQ4ZmoGTVlkKPLBL84/Rc8Sl2PhW1cs4b4lG8odoaZ4
   fN8bGvfZCrKyAqiJwoAzAS2sAgF6h9Mi8AWJraQ9zDs8bjfwMIAlowmrJ
   w==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="229509862"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 12:12:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+4qVsdkHChWsnW0mMguJKmcXtLMnpPLLT+SNd2eRzSXrV1Xcvq+phqSNGQRoxeyyyb56IDH0g3mC2+9QRN510aofqyquLZFS+ljdp6yp8ga314nv22GA8pXJbYBubTIubAp0NteCXPkGtxyWHQjoDbQjOaTe3y/jLbWT/qtCYx9tZ7iv8qqkI8SnwxMZDqksSIwCJeXN4VM5Pbj97Pi7UT7eCmucyldI7pZCBRgWEogRGIzfWnMnQYsdP4/l/qCz66J2Y0FwEIDUVrHhUa0YQsrwjmYXDdHyab4LHTbM2HVivVrwxwlslNvCEHcV4OjFo+uBAVJ3Yyv1hOViIfMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWM2SNULgHTLsXo2ovi6goowDE+CXbL8K/d6u8fGsQ8=;
 b=bDQJUkJsJHEGJqO/IkJwK4m9uj7DH9V4x1gJB9uqOcZ2IsAMzjTZAi4vQNk6uX5nwETqGlJ6+aS/lC9izzzu2zIbHcUePLQwb4kp460YUnHVBDoItKFJ7LOPBUha+Y44YwfhLIcPsxMudqOgw/53hzzQ/foVaO0PdLcUNngl08nNPuuoeLr2CJc38vHDmZhZAK5v1mp+unTEBCRtdQagf5VB5wym5yB9T2B1YkeyqChVaFspdXnM9tJX5dtq6AhZMhwtzLfQBUqPQI/jje+Chwh2OmQVExihauHFKKcw2HMKiUiB2VYrZ76H2Jn3BfsCiIbZA7YKVkRovt5Y3FWbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWM2SNULgHTLsXo2ovi6goowDE+CXbL8K/d6u8fGsQ8=;
 b=OWbBtADZNOUR3DnaCpN8Yp6zx6PWOlM3Db2vFEh3/iPUIjXlMo5R/t1DJZq3BvTJfcESBCGXcUd5JRYeBy7V5Jbz7Sh5M1ZmU0ryVnerm94wvqsiL4cCAspdw6E26v29lpQronvxrmQwxL7IvqcsGJGxZLBqCcPLhHklfvFgn6w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6771.namprd04.prod.outlook.com (2603:10b6:a03:226::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 04:12:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 04:12:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations
 configurable
Thread-Topic: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations
 configurable
Thread-Index: AQHZeYeYxsiB87D1TEmk+smEBQZfkg==
Date:   Fri, 28 Apr 2023 04:12:06 +0000
Message-ID: <yuwidfmwcg2iue2fm4wqyd2p3vmzo34t6hqr7rvf3d3rkh3ag3@wvpu4f3aqhly>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-10-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-10-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6771:EE_
x-ms-office365-filtering-correlation-id: 7bf06e2e-fb72-4ba9-167e-08db479ebab6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKW0UH6z2wS2eVSyoEVQUQA5GDAqv+lzkSpjbV4GEiLgf/njlYUYzLWqzJt/32DIGX8VBg570aTAyUkeOxlwmLbTzs4P0CItkxTrujFQa1RO+tjl2yYuJ34gbvTPbMVdyVSj9rBHwaTAG7SFVjQI2yDD1afTH6tWTrRvtA3m8hr1sl9jtVMOqphPPpsttkZl1ygFNBPODMOBEMcxt8DRQJhms/9H5/q5mPGeGaO51GHQZZUqkJVZNfu9BgQ81Kitf9XpPwiABhsVIxZkVHj8EdQZ21W/9SepRB6TXMr7zLyZSjkr8MohtQxtNTh4hnrlJLBH4yZ3zYlqyuXzlZz5yWthO/MuOejaGjNKFwAFNsSCTwjtjZvNxjd0K74F1fmotK4QWLwxuJzbYcgeGbhTo9AZFZEHK3rk2mAAvAIicUK27DHmUI9QZUd2XnYSR/71/FPrseLvEtGFOhRoi4pVZCfWT4gUCEtR2N2ebC57j/1NhqjOHBW9FRZSoofcuAG52jg1puB9cU6POHhAfzUntr5Rr3TIsfvU26YVYPI1Ej3qUhW/O5Hksm1sCjYqsWudCCpu30H3eigOl7c8+0zGs1QlQdIlaF+EaklRpn6rPJ+LL0HrB8g4DpkonhZQXek4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(66556008)(91956017)(76116006)(66946007)(2906002)(86362001)(44832011)(66476007)(5660300002)(8676002)(8936002)(71200400001)(316002)(6916009)(4326008)(64756008)(66446008)(41300700001)(54906003)(478600001)(6486002)(186003)(6512007)(26005)(82960400001)(122000001)(6506007)(9686003)(83380400001)(33716001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ik5DEnpicp28yf8xEtSiavx+ShXhK4e/T7U2/yNZtFsBIHUgGpNrcbg2+E3+?=
 =?us-ascii?Q?4RiilDRwxT99PX/1/G5j/EUc+davhr4LqRKhpnAlEGnDty5zEImfoLIy56BD?=
 =?us-ascii?Q?MA9j35hbpHCRvgIZicfrlME4aqf4wsDncimK7z7j05hbc1uPMRCi+hfsvxzE?=
 =?us-ascii?Q?wNV8fDYPlOrM8AuAajnXq41ygRFvcO8vcQQZNPDI6ajlz8hYZxsNbp4C+GaD?=
 =?us-ascii?Q?3RiCrwo1JM2Fx8Sm0HIhcGxPhkLsxy2Z12aDsXQJlPX9szYBMYASJm68zOdC?=
 =?us-ascii?Q?xNT0fIQYyAsVyy74jztjHFwzRrBXmoNT2pe7Unrt0ejDvhVfGEzgXf4rX+18?=
 =?us-ascii?Q?6mH/H9j2X32i7KPyJHOBJA3lEqj0TEg4d9GPQhbzxj6addqX8M49Swftcr4r?=
 =?us-ascii?Q?2nzonNvkwjnKN7+PqyvRqh4HEmhLG9cWljvGlnvJ3J7BF+YfsWs3RDo87rf6?=
 =?us-ascii?Q?AIymfcETiOPyOaSGc/N3PdEOYws5i2W+qjaI0WcNrgOfBTRA9YY/jtzbqItN?=
 =?us-ascii?Q?jh1VIpOTM6HIhiz8vM2nzLixWI6JXm12E8HBJk92TWMB6t4wKofuMrbLOPu9?=
 =?us-ascii?Q?a0nQpzLkfmE2cm+ZwMUdQGGPaQaIBlSTIVrTTLl4wQO53WgpP2+jMokCvS0B?=
 =?us-ascii?Q?xvVaKYOQUoODJnznlxFmBYnRE3e6lZXJed0iXlSeql/sLlJiyqcOk5sAaIlg?=
 =?us-ascii?Q?PmUT2bfqGhbS5Yh19xlHd0wHalRxx3/V791NouhfwQoBfYZ4wyTa21pSoE+J?=
 =?us-ascii?Q?U5OylZU4fESQHFpkX5EmNUxd+k1npMmgvYO5DfFwbDfAxo2DXl1GWVhE4+oA?=
 =?us-ascii?Q?tc9dIYA6tzTBdlWM0UP41vkYdwuRM5RLnyPG4ACqPCuJiiMPLho0NPGO0BFT?=
 =?us-ascii?Q?2+/bm2Pk2mH8yc5OK0mpKePG9gKC6ctjIWOyq75H6KovqTlEo/JZ+qrsGbxj?=
 =?us-ascii?Q?/XD9qzPSxS4v8EhX2jdai6OrZh8HkckHhGF5cYZZvokL3l/i8rtdYkeVUDBu?=
 =?us-ascii?Q?DBlFSPYo7UhPze77aMp7dUC0pJPgRN3pHf2o2rj6p3Hjlk70sTW/Cf0WuiYg?=
 =?us-ascii?Q?WAEObUiSe4eYDq+rSlyHOeqgfgJW/ulIuL8FE0Zh3swzKQ90IdWGis54yGej?=
 =?us-ascii?Q?//pEZk0LFhDFsasw8lD34gpLZsvhYs1VkUVPmfVx64YVb7hkzzHMpQovilQN?=
 =?us-ascii?Q?6Oda2jMgiGbu2Znv6+ajivT+ctOjghkDDUgftD1SJSqLuxlFK4J5SqX4zh2J?=
 =?us-ascii?Q?nQSulyCs4L5xoysbCdt0hxNpljuZPNbAtwq/gFEnNoNu9Er97wIpuq8NRvQW?=
 =?us-ascii?Q?emgRKycKjZvX117LKQpt7LgI4IQpnHOAPKcyxB8Y1DydqfX9FR3sYlJbm/2p?=
 =?us-ascii?Q?OSHTPD330XNjGV7/hgB6bqEJQY9UAuzCb2iJQE5NnjirIpYR/KgT6GoIsnn7?=
 =?us-ascii?Q?zXCRuobTZmQv74ArNo256LEP1gGlX2JUvr8KECrLUYU/84gLHDybwAz5xie0?=
 =?us-ascii?Q?1mvhL/Kr6s4A4ik7yufJrsBBTkE6qnyDPlsABlQot5UudToYfOezIarFmGju?=
 =?us-ascii?Q?w0uBVabIg3VodC+TigaCmvwpbPbFkjPwdsZeGYcd/GS4bllBtWiBAzYJDAsu?=
 =?us-ascii?Q?vnJTYu2ttqO2dBge9tq3G6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FC025F5662CCE469401A0C8674EB9C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h8yHP3Vo6/He1b4lTBjGLvcm8tnCkQYKmSizBWZR0SnwKg8f4V/yQ4daoaUj8p9634pX+ZoYrAm714wWK2H0vHM1ZNd9N2zkKXBA9+DlCqOJEcXEs06BHlpZs8XETp4vB3LVgj2Z6gVSgJ+Kq73QIlDPNSAR18oQixaJMM+SmO/ePp/yEifalqwvBPwwOkgc8fKZfB5lKPDYVTue+wJnJmXVWejPcWeHIZZLoxQqqsSIpQWo1moeyGS7F1Us5smVfbfLeDUa2NJt4BFtqytHrf61QZnn/GSJHL+B0UI61QQ/X/YlX/OdBon+eXypVD9tKURy9ZqZPSAjhB+I+gjMBPxp93F6gBYHTr7MMfLGOH1zEAl943LKa38WUlo7F3VNJ3teiMFkOcvGnPMUIgXKqBQ7m0EzUawGdE4t8cAPX9Z2NsXeTVgtTaB2+fHi1a+5T76ovbzuCM4NKDxobpSGTUlDEV1hcfmcsSqOPCXA88jO11dcDeoO6CRc3kTbTLE0eKQUAwMzVaYv0UH+Vm32pCK3rAO+N6glqnhjSfl9b9JnkYhlftHhO1gqFXyvQBgEhF7v7ANz/WNM2pOKD3CfvMj5rnfj4HABupupf7ON8rbGTw+Dp3w013mOXyrqc+JojWTXYdyDNNnlmcEcC1YH/mHjJ1S3LgmwtvZ8X96QiTgA3E875CxhdERc27jX9NBNXovxzlzZkWxQUleN6HuLfLXXIXBoVeDreIOxPLbZvgkRSdhJZuL7iVHJUbNRSts9N6HuKdohGsgpf/QxkBmKsFODMC3SP9fD+8xSaoHYOI3Mya2FTQSBb+/nMB6qx1y8i1+5+LnYxVjkESs7nHuw94dAf/z2c5rA8SNi0qi7fV5Uoons2kU5qvFLoyhIBAVzwh4m2HE0kFKnLnJhU0liq6JRFmZVY6Rwk6xGZLNw3TI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf06e2e-fb72-4ba9-167e-08db479ebab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:12:06.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKDrUOeFas5qphvGXx7yfNRo6mVTVRssGYAzTZUiG3g4PjUv9ybSQHwaVlL6jr/tqL4ewVHn88/iN6I3wt37qupbYE6vaaPR0yEDaUWdgro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6771
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
> Some tests hard code high values of iterations. This makes them run
> relatively long compared to the other tests. Introduce a new environment
> variable nvme_num_iter to allow tune the runtime.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/002 | 2 +-
>  tests/nvme/016 | 2 +-
>  tests/nvme/017 | 2 +-
>  tests/nvme/rc  | 1 +
>  4 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 6b8484844b4d..c28035483514 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -20,7 +20,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local iterations=3D1000
> +	local iterations=3D"${nvme_num_iter}"
>  	local port
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> =20
> diff --git a/tests/nvme/016 b/tests/nvme/016
> index 4eba30223a08..c0c31a55b190 100755
> --- a/tests/nvme/016
> +++ b/tests/nvme/016
> @@ -17,7 +17,7 @@ test() {
>  	echo "Running ${TEST_NAME}"
> =20
>  	local port
> -	local iterations=3D1000
> +	local iterations=3D"${nvme_num_iter}"
>  	local loop_dev
>  	local subsys_nqn=3D"blktests-subsystem-1"
> =20
> diff --git a/tests/nvme/017 b/tests/nvme/017
> index 0248aee9bc41..e1674508f654 100755
> --- a/tests/nvme/017
> +++ b/tests/nvme/017
> @@ -18,7 +18,7 @@ test() {
> =20
>  	local port
>  	local file_path
> -	local iterations=3D1000
> +	local iterations=3D"${nvme_num_iter}"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
>  	_setup_nvmet
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 2aa34fb0c9b8..bb135502220a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -18,6 +18,7 @@ def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
>  def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
>  nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"350M"}
> +nvme_num_iter=3D${nvme_num_iter:-"100"}

The commit log of tests/nvme/002 says that "Test nvme discovery with many (=
1000)
subsystems so the discovery log page exceeds 4k.". Can we fulfill this test
purpose with the default value 100?

Also, nvme_num_iter will need description in Documentation/running-tests.md=
.

> =20
>  _nvme_requires() {
>  	_have_program nvme
> --=20
> 2.40.0
> =
