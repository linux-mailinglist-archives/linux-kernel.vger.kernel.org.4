Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52566F9CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjEGXTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGXTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:19:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9A7681;
        Sun,  7 May 2023 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683501571; x=1715037571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ye59QD1MzKA8X+TM2qiY5YvyIiZGOWL27CDMOkrpRFE=;
  b=K0ab/VtfYrltun3BP3aX4rfBT51lH81EUcw2+ePRNWuVAmxuDOHGfUU1
   TqfsHsiCaTHgW2YB1RKk4JjDgejWiO5twZIvkG4ywLMtYv7Y2fDX81DJz
   bg9+dYpbNvSFsrvQSFbT3crS1UELlkijBCaSRVIHaVPcPBANvLBCdZmC1
   nno8v8e8/TN3vN2CH99keYFpbfhoratOpC2ck2R9iEJeZwXRIgo3Rofkq
   Drb2aaqWmdCLXwrL+gfeujJhaMIE/RRI+H1w5rwVQfmBT5dIgEVX7kVNi
   ++X6jdGxSXAaZH34qVdVRlT7loh6Iyb+nEZSECvyNQhEvM8c3wJevnLfN
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="230131973"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 07:19:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT1vT6Tc6OkT0NoGZN7bPgncAl/vitkJrx6fOE7hGI2ibBHlg/LQ3rx7SAIBmZfW3hdpc2erYzb6bQD+puBB+mntjhhRP4D+OJeRRDk9iXbQhfaiaJlEO8RwB4EB8lbrNzvvQYhpGGpzWvigC4W/A6MCDaeTidw71bXEKpM/9UfNN1PjNA81tIiGx61Vdzn7IOCd9Y0ECwm2gVfQ0pc05BbzflNgiywKufJlg1vVbPHsakJpHzUovm/lJ3GuV0S7/xiwqwe2hfYzHS104jtka+7rYxvD0cqu9JQoo0LNg0pnCB6x9laSDohEVj/L3FKPkjwwi0ncWGfyVEMUjk8XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWpNi5tH0Hg+7XZ/M2nK2VWHAxfbUkIQ2WHwGOu05VU=;
 b=R/XKZUAj+XzYfMW1h2KBAruoKwK+MUc4ocQZFdV+uSiOZpIPFM1qrlzy+vQQZ2y7Gg1wYRz55Ewl69hP8VHrPAe9bffdQ8UBg4ZtkMKnu+erMVSSCT3LkdjXd5Iw6fDdk0MlBQtu4JlCpfgw2aRhUW4Ep++bo9eISkOlvQ8egC44tiDc+GS4dDZq/+o6pLcEwumHdN1V0HLiL5k/vKAPWgyX54Tugdv4uCkxX2Uhy4kuhE311/Mg0IVY8pCHIGkrewOdMDRaN1FUysbVklkwcHO1xZVZ//uiK7V5V8p9WN9Eb2KDNVwI9J2WPUlmhMGHYUtAzMGcG/XMYsq8M1k4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWpNi5tH0Hg+7XZ/M2nK2VWHAxfbUkIQ2WHwGOu05VU=;
 b=Vz1HKyHwSnCmHPCu7jGPyPhzxEc0cbdVD8S7EdEtJleqZtUX7jV5F06euD+3hwJD+3v3Os7uxHWtJLAoCFfu0HG7HBJ/mZuTm/NNjHnVMeKK1fvuNoVLXFWzpZFUq9dG5FEcz5QNSxcT0Di5+WmPq3/LGGFeZopWzYFHqSyI9GQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6703.namprd04.prod.outlook.com (2603:10b6:208:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Sun, 7 May
 2023 23:19:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 23:19:28 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 08/12] nvme/rc: Add minimal test image size
 requirement
Thread-Topic: [PATCH blktests v3 08/12] nvme/rc: Add minimal test image size
 requirement
Thread-Index: AQHZgTpeCZWoBgP2s0yv5rZuYXq2bw==
Date:   Sun, 7 May 2023 23:19:28 +0000
Message-ID: <oxvbdtehbmna3uiz5lifjrzekohdjw4wsrh3ydn4yhtleqbpa4@xxvgmggzq25y>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-9-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-9-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6703:EE_
x-ms-office365-filtering-correlation-id: 2844185f-dfc1-47ea-cec0-08db4f518170
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yt8A5jWdojGSB4/BsM1UdM4FHl9EokMuJ14cce6Nu7dNlmmUqJ/pUQGFw2OrC2CLsqoZRgn7hS6522TJdaIXhrDRIEffQLDlZUasIbBN8tDGdAkj4c58ksn3/cl0lRGp3PWnfzNPv5tBjZHtPzDy+xQeuCb5DoMo8+/GIysR3ABX4b/GPumorPN+iRq2VFGC/r2L4EjeQA5bC+6KJZ5jBhL9oBQlcRhJ/aiHGFvp2972VRPFlGiB7vmPzMX85uuM4ynEUYj5fwofgueDCTWx3p3zWB14MNxEm4eIxXM0wWOJxjXmFZ5mXeHGtfELnzgf9VtFbwxDhojMV3SrvnxhVxX2aDmEwjIferyP6EQtaKKoGBawy6pjq8nYekKLJ3W5RS9EVeSBC6AJ5Dt/U53djPq87U67CTcmAMNUkltIY4ZsyIF3rgJGUWBeHpbjTiYb6HDjVh5HZ6LFunH/Boh0ljI+qPSM3hxoynpR2gIl9CUKUY8Y73WjvBXJstyPvqlBnfOYUjDCJ8XntoCvyOUlrhVM5tooPDB3mjNBfPKrqHDWVuGD6JmtKDoT+y167OPU0bQnyoP6doXS8DnyCKH6wDYGGlQKCU8NV5mS5WStRNykLYkN3HXhB07C++cb6TuT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(6512007)(9686003)(6486002)(83380400001)(122000001)(38100700002)(86362001)(38070700005)(33716001)(82960400001)(186003)(478600001)(2906002)(54906003)(5660300002)(64756008)(66446008)(66476007)(66556008)(6916009)(4326008)(316002)(8936002)(8676002)(41300700001)(91956017)(44832011)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bdWVeM/rw0Wl9TRKjG4gBGkzM55fMHJTYEjRpuIEiA1B/+tBr7UMhB3Cp0Tz?=
 =?us-ascii?Q?1b3CgYXRPcJ/rgr3s2d9CC4y+a8PUDs3saQY3bHDaTR8Nf+9Dcrq6LBmetXH?=
 =?us-ascii?Q?RC5zE1pISt1T09jF111iMcwIiqV86/nEYSBih2yJLJv8lt9rdE1BFB6unST8?=
 =?us-ascii?Q?CVLnKiNYO9k5u5RjNq6XCrB2xqgq8M/JXvYyPhwDo7QMyE0nZnFus11TManl?=
 =?us-ascii?Q?EESFOgjr5vfdHhbOrfOLeJKdzz+wHyZCdJh+8wZFw+oxsMV4KX5iOJRB+/Dz?=
 =?us-ascii?Q?/Zlo+YGwDFVVpyDfgLlz8fu09khlBKcwagc/TNTqdt+KrL2JagOoDJ/9j3cG?=
 =?us-ascii?Q?AEPFJO3Z87JWSrRnbl1tmqzkMTKG8u9NmAKp4szpcBoET+VxpSn+cGIrVHjc?=
 =?us-ascii?Q?UqFysg+UJHAWlt9nQccxkMKenhomVdlJSPgk6T9jrFQI3Q3qhuaOmWE04zbC?=
 =?us-ascii?Q?fJy9nRQ+iCPMuFDNoZqCi+141GONT6a1whJQcs5i9eXBSJ5uzSC67fMOpIxB?=
 =?us-ascii?Q?EyBy9bP0prwY3zgJUMJVh0H/MDQiIT9aOu9AaRRMAr0MXdSCIC8tXPf0KvRs?=
 =?us-ascii?Q?3oQTDwPAbl2veoiJKswo+h9b9saD3jll6N33ODWjY5CEcOiZ38miiuWqd1Hv?=
 =?us-ascii?Q?nUiC/Dd0g7YPv862cfoGLZZEBeut9EJ1LTu3h5QBFkrHRvIbdh3a18mSZcL7?=
 =?us-ascii?Q?5q0c6+hoVJK7LvAuGjCz6Z9R4RD21eIEjKvTj9LuR0mi7xSCYsQ0F2U1H9um?=
 =?us-ascii?Q?6PWHGzw1zedBnxVbXbwGqjrDezjb8bqmWzPVyX8AKogP7OK6l0dgm6sS3KsJ?=
 =?us-ascii?Q?Wh+aLw7p/bi8rHPEhTLL8+dnh+aDX9aa/suAe4aA4b2EMoO8o0JdBZvCi769?=
 =?us-ascii?Q?2CBl76iZzW6RqqGMJ8691XEetEa7+kzQ+E92hXc6EMm9NI5VQCCU5KQuHCYU?=
 =?us-ascii?Q?jYYwGL0rhJeMOcX45R/ZqYY8IlZhyWthi14TdsmnMqCrthloh0szz5WOGTSt?=
 =?us-ascii?Q?G9vsV/PWeFoXpnaQ81WDroR6pLnFwjnDRJgz6R7GOD3FZDUEiJ5Bkp8ojlP7?=
 =?us-ascii?Q?z1h7KR1nfj2ynfPOcSGmMboBY7sA+ZS8kQcKGjsEP3xt7UwO9eztSiA8tDv/?=
 =?us-ascii?Q?EAEKxtTbV05qvAyDyKnNEGnc9r8fjDCoO7nuwCFbF6sT6RzH1uJmVh/QK8ZB?=
 =?us-ascii?Q?ZhpJWcvTOP8MbaZH5GPp3OHuUsQ1OLTqSHKbVRLTT3myABzHgS3QL627F9sZ?=
 =?us-ascii?Q?L+QUv785Rv6SFKYCbGWoy7G8LNV2Y1MSUpfqooG/Q+bcKr18/LMV1JQzMgbg?=
 =?us-ascii?Q?vWrMuLhhTlYaMpxj9sgSn0kS64IBPL1uhuCWFTHV+pSmBybbs6y9x1w0W5LD?=
 =?us-ascii?Q?9dkLdlFbQn+2C4RBDkV8S0HCE7yozWJxzasmShWJXxY5g1f4k7RtF6dHyeoP?=
 =?us-ascii?Q?4uCtRmPsMV1+P6WANbEjTQLyptwXsE0LjV04MRljsuS+6l3TAjccwmwpTz3f?=
 =?us-ascii?Q?CqJ4+cphNz2CMht5jCECQCgGrMOteGpK4xGEhkJB8ta+FGP5pBEPWUw9RThX?=
 =?us-ascii?Q?YSYX6c9qOfsjMEljd7ZjtYXc6VmnYfRe1tlLIEAtZH8+XeeWHNrOYQ9T4kH4?=
 =?us-ascii?Q?alVmh9YKPIoWBIxRRu4gFq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D62B1E459CDA649921C5D41C9577D3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uuOT0su9iftja+LYNcvy1PN7twUWa9uN8RIGLbjmCYOcGFCMkzOPJkfFOuWjhnAvLt9RIg0Wrm2sK4hFkDo2dwiHa+ffm0MQU0vUxSMWSuTg9of4+QTvtu/j3iTOmmD2c7pwPMsKCtvbpcFSKeekd7gPB/+TA/HvXH9ftiDhlqAazImtgN4OPR4UkUVfUqnncW7QWP3P/Qdqq6LyISJ4dSQI25fh7DspkRgPLeBdXOr74Gj8r1zQgvcd+pWv+YrFx1a3CTlYXqMxVHVDacM17oHJMszx/dsYRHOne/JXc8YY0UKSINhyCM8IeUpvB+SEAjUYm2WezCDck8LHNIRnwMevrW53iQf8YMNsIpKwkHdaMRri0sRn0UMIIkNVHKOiT+rBoXXk6N87NgfgnELbJKYRn5qBPGCIU9tHFLYakfcMrn9OmxxzQekTfi4V8DRH7VUsVFIicLlafN9C6aQpEUw222jSv9SiV8ENQmrZtVzJDq1VW9Dj3XSarlI71b1R0vq8d+QKstdovA3mVPcIL5xyVw97uckHzwMESWXoVCSLR9b/d9G0OSjoDbSKvaVyAzPKEaoJ7P3+V4PKRCENOJcb7FWWrzNbndLhExUy4ie4CO8Yy6KcfKfEUSdA7DUk47PttAEGu4b7XatnUN6vSMcbc5eQm4gUVNAMRLThvPUD2J5AUCIiLsWHJgUmNX6Furovu6RaIbSHUxyEcfWtm4d2bVYfgBOcx5PaSlmK4w7OLkx9U05aBQZzlznhApcS7vYLShwE4WeBzYH3Xpw5KL4oRgCGby0VXQjXMyHgKy5292kLgw2rlHnTS8juKWgAe2vhVikQcI0oAVCfzR3OlE4ykyL+++0pI9om7wjwDeiR4Gb4/9UjJYm1r9iNbggA5t18+RAaIiv8hlmb0tRs8HE9mhPl8UITJz2vn5+bnwU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2844185f-dfc1-47ea-cec0-08db4f518170
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 23:19:28.5267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6VSC3GxWztUU7CyRhgCCiEUEObsqRC493SikwIrrwMiT9upmwRLfuqC7daKE1E0lOCsQFaChJTQ5IkhJw43QWFKlDSV0C7+uSdwf4+URaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6703
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: the commit title subject can be "nvme: " since it touches both nvme/rc=
 and
nvme test cases.

On May 03, 2023 / 10:02, Daniel Wagner wrote:
> Some tests need a minimal test image size to work correctly. Thus add a
> helper to check the size and update these tests accordingly.
>=20
> The image minimum is 4M because some of the test have hard coded values.
> All tests which use the xfs fio verification job have a minimum
> requirement of 350M impossed by the xfs filesystem.
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/012 |  1 +
>  tests/nvme/013 |  1 +
>  tests/nvme/029 |  1 -
>  tests/nvme/045 |  2 +-
>  tests/nvme/rc  | 15 +++++++++++++++
>  5 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index ecf44fcb5a51..efe227538c57 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -16,6 +16,7 @@ requires() {
>  	_have_fio
>  	_have_loop
>  	_require_nvme_trtype_is_fabrics
> +	_require_nvme_test_img_size 350m
>  }
> =20
>  test() {
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index e249add46295..14e646a19c47 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -15,6 +15,7 @@ requires() {
>  	_have_xfs
>  	_have_fio
>  	_require_nvme_trtype_is_fabrics
> +	_require_nvme_test_img_size 350m
>  }
> =20
>  test() {
> diff --git a/tests/nvme/029 b/tests/nvme/029
> index 1808b7b0edf1..c6d38b42af70 100755
> --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -14,7 +14,6 @@ requires() {
>  	_nvme_requires
>  	_have_loop
>  	_require_nvme_trtype_is_fabrics
> -	_require_test_dev_size 1M

As I mentioned for the previous patch, this line was added and removed.

>  }
> =20
>  test_user_io()
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 7c51da27b5f1..99012f6bed8f 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -120,7 +120,7 @@ test() {
> =20
>  	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> =20
> -	_run_fio_rand_io --size=3D8m --filename=3D"/dev/${nvmedev}n1"
> +	_run_fio_rand_io --size=3D4m --filename=3D"/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 51dde39c2966..0b4d5f6570d6 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -21,6 +21,7 @@ nvme_img_size=3D${nvme_img_size:-"1G"}
> =20
>  _nvme_requires() {
>  	_have_program nvme
> +	_require_nvme_test_img_size 4m
>  	case ${nvme_trtype} in
>  	loop)
>  		_have_driver nvme-loop
> @@ -94,6 +95,20 @@ _require_test_dev_is_nvme() {
>  	return 0
>  }
> =20
> +_require_nvme_test_img_size() {
> +	local require_sz_mb
> +	local nvme_img_size_mb
> +
> +	require_sz_mb=3D"$(convert_to_mb "$1")"
> +	nvme_img_size_mb=3D"$(convert_to_mb "${nvme_img_size}")"
> +
> +	if (( "${nvme_img_size_mb}" < "$require_sz_mb" )); then

FYI, in bash arithmetic operation (( )), we don't need to add "${}" for
variables. Code below should work.

	if ((nvme_img_size_mb < require_sz_mb)); then

> +		SKIP_REASONS+=3D("nvme_img_size must be at least ${require_sz_mb}m")
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  _require_nvme_trtype() {
>  	local trtype
>  	for trtype in "$@"; do
> --=20
> 2.40.0
> =
