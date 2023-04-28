Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A996F1109
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbjD1EaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbjD1EaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:30:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853721BFE;
        Thu, 27 Apr 2023 21:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682656200; x=1714192200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dC6eJJO0V8unWpp9g7gMF6ZBeQBDb+OCkATGCHAogvM=;
  b=Nao1rSlFIfs67reMWI+p5RgEQgq2ROcA21DOY9yfSfg8Fq2MTF0DVUoa
   84VK3uLQZzQDnJIHQBzbAH7ZxO99bMcD1AOBH+d+EIcWKavNnijlS/LF6
   8ghgnrtSl2Iu2RuRTHSvx8Br070rYCCc2ydQd+lS1kgVwhNHNUyTNBn0+
   bwZ1oKFPKL6YW4uhx8VEGZzop/8gkf10fS5mfdKskDHZmpiaaiUeh2uWf
   5d6V6qvPI2zHa+99jLj3+9SJBjIltSKBmSE/29bhi2yzV3ck5Dei3e6k8
   2UMxSibmvZOEZIYui4bTFSImJnPqvP+qQWQPnYUK2T+NiJVjHn7TBYtmD
   g==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="229368312"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 12:29:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbnRzQn5CM6+zJ712C3FTueovoeVUj5RSsvNuaOvn6xVYml8rF4TO2O7+nugH6bFCJE89UQKjU/Cib3X8OCkAw69JpFQ5q6OQJH0CwtyNLAP5doD5LZYroTonVqNe/fOpFkUebEPLqcpd/32zdTahKu7lEj8wis7rgXDtchqZ3fi23Om4Tl7ryqLHAYaDN1rtV9kLR/qT9uzYpDO9akMQkZW/bpmQi4qM28reMDpO4jrb7Cy6GDaVf5oLqGD1ebc/4MxKi+LB9tYLQFBu+Mgwq2lQGbs2tPKR9uHvTxffScIJ8A/4BVcWMwplEjdb7oDcSSd93D5l0jCSFWcNAKhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8hTGH//rmQJrGp9RxDm46zxpsihEvAlHzpy2W0qxzE=;
 b=eQFtBYOz52ND3VOHAMj71xPmasoq/MAYNvy1NXCsgFPj63l990oVtN5RzmpAqeYc8+aXYlc8P3Ini6ocolHYBMB8GOIG+JheQKMguP/ssR4PZpvQ4mAeFevj6Asl4QTVLb4V6gcAtGuM1Q/gCLBAaaUqE+pUp8jnwfb2mAbAH/lZYlx72GY/dnJZcL1saVH7dYOYzkNGRH/D0dl9gd8jCWEQzMODaPH3T/cI2Ayh/eL82YdCdgTHlZcM6rWOOMelC0j0gcDqCj5rDTlLww+KjNjZYMnDl4J/kXgVh/AY0p3Z8RPTlMOMkFOXJX9/Ujr6BKq/WoXin1rOPW3XthmVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8hTGH//rmQJrGp9RxDm46zxpsihEvAlHzpy2W0qxzE=;
 b=IyflMNvDAAeLNzlBlCyRQNK6yzmWxtS7klojpvzfDpygOW45s3y74rPMoeXWakcGxQDUEBr6K902sFbbEZ5tjcafXKIsmgGSVr5LMkTsBI+JCruqHsP5lCD54tNn88lmfWw51ugPUfJps1qHhabdgGZX9pcDaW3VzpAkgONbFjU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6954.namprd04.prod.outlook.com (2603:10b6:5:24c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.34; Fri, 28 Apr 2023 04:29:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 04:29:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Thread-Topic: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Thread-Index: AQHZeYoWQ5FGkdz4ZEKIobo1OJOmQg==
Date:   Fri, 28 Apr 2023 04:29:57 +0000
Message-ID: <bnr5gwlxyfixvajlpzm75mfmizgvq4uibb2b4t5tqij3jmkqrl@ialjk5an7nla>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
 <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
 <4ckg7ymu73lfs7zlsby3com6k24qgovkaqky5jmgeoubs7azhh@jtvovyjluekv>
In-Reply-To: <4ckg7ymu73lfs7zlsby3com6k24qgovkaqky5jmgeoubs7azhh@jtvovyjluekv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6954:EE_
x-ms-office365-filtering-correlation-id: 20d82456-1772-456a-7e09-08db47a1393e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ft42HlMSDi09Gee+k2Ct+vUH5NuqKIVHeJc4WnVVIdpo7SVfM9/xbJYVI+afQE3/75+HhYcNPRgJD/BTs3GMiAUd9I8BHiASJi9+dRD1ETkRNNwtwjYmptwIWhJFcdScHf77WEO03Fh94C8luv1X4MmBISgA/NUe+OonXViEr5g59l6RVyqNh0xRgCt7iXKwX7+HIzbFYpCYW2+akOhYBILc0frODmn/YW5cagRyY/Bq/2195fzUsVDuwOoFjdpNKxvR7SndA6lxqiUk3hNH+qxOMPZoHWYVcYTKrtJymDCPR2EUJZut5/5A8GT6qmZ9P5Rn+czmuETj2HhkjyzpvTUCYxSyAL1EmGdpQD4AX8nt8fjvzwEbmlpPFWD5kEiXW6WWYUsR+bvH3PTl6TXBk3PhMu2ZuMjeUo6rCNmf21t7hoS5QptAY90/rFzvWXs2IiEaqzflAHF+wHY78bv0oos7qXTfKmS6QwS8hiAqQ+AUE6fuJQITF5RlRXl3GhRXh5Uehd+gHvtOOEtglJdE6Wl9BA8qU7RkzJzLUNwfw7aHKdRBagwRTPtDlcHTa+bGoAgq0vV5mxFA7ZEgpPVHjNuaX4vDuOxjnYJUiD9JtZIhxYpqp5ySLyUnnGyutczz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186003)(86362001)(478600001)(33716001)(54906003)(38100700002)(71200400001)(2906002)(8936002)(8676002)(5660300002)(76116006)(4326008)(6916009)(66556008)(122000001)(64756008)(44832011)(66446008)(66946007)(66476007)(91956017)(38070700005)(6506007)(26005)(316002)(41300700001)(82960400001)(9686003)(6512007)(6486002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tTFQkMt6M9X5HbtjreM2SWJC/HuqLYcLWzp6W5EmlB5KCQozhfmHlpWcmZZl?=
 =?us-ascii?Q?xTbT74x96iaIlXt3VglCRAuwb94M2IVCIWi5N7TsvcC2STr4UO76MoyCdHZz?=
 =?us-ascii?Q?/1iSDK5vGicrj4bxk6PWHO/pxPukL+yBoruGo1afRS/vqDdfiqs1gLhbd4cj?=
 =?us-ascii?Q?Agxb7+l/BanZTlBf+BCXHegL6kePV8Z8uCdUY9FzQYZ8IopRWQpf8SQMfmz3?=
 =?us-ascii?Q?OTFMDhCdAt7dGFL/PdLLUtPWOCflZe9AarS9rpT9+sceVAEsEHsIf7N3L9qa?=
 =?us-ascii?Q?k23hFxBF43Sd9uQhYk+90B83X+QEXepGOolIA+8E7t/1AcC0LXyqtvK9utEZ?=
 =?us-ascii?Q?QBrmyaRuTkCD+9vuro6As5m3ITfpoCttpMe5T1d+319esj+C7jdv/Wc9ghdv?=
 =?us-ascii?Q?KVVSHUOzAzMc0Fs/Ka/BuAfniFTA9e61JqxHcZeSfusEm7N5FQGegifrBwhy?=
 =?us-ascii?Q?3svwZRpQCB9K2420lsHa/j38pfqL+DoisGo9tpQEZumlZK7sQap8/mB906VL?=
 =?us-ascii?Q?UTGtSazkn71znfrxJqLs2PYfUw8CGKqvosoaDCTx8deHAPaDlqIeWvj1JmOe?=
 =?us-ascii?Q?llHhnJz4WupJKeYDwNdU8FufTxOoZZ/SkTW6jrR8U4el9FcxatDsIxLPEqJA?=
 =?us-ascii?Q?MaDpFsR1b/5YKfO32jQMvUn9NWq4oxT163rvZxBIHdNSxudiFAzcGzU6AUih?=
 =?us-ascii?Q?ENVRzh/bULJ1s79cJbrw+nTFyY0E7nqL4XBdez9ZhvsZE2J5DCCGr7RSg11Z?=
 =?us-ascii?Q?zolh4RULex3G8LS49kzD2iQDJY5HsDU0OnVY+sGtqoimmUZ4o0R1qhwFomRd?=
 =?us-ascii?Q?QS9BYkA/AASWh6tHMy52aCRTA5z4bcE3hf3/wx4cVpqmW9esTBBklsPBhnfI?=
 =?us-ascii?Q?gxtHz4YZYyydBsWNbgZTG6YWBV/n5grixC/yX8AtHSgx/l14YqJKofi8u+7r?=
 =?us-ascii?Q?HcNsCvupEd1I+svV0KmH6YPLN15JzYHAEtVyQrHseFeo5zVxLMEazHEKy3v+?=
 =?us-ascii?Q?OekKP4BBMIq8gg3DL0rchZ3Y96n9r+GvVAEB5Wa/FMJgv4IRB5CVhVlXPThY?=
 =?us-ascii?Q?4UC+mS7dCKyFTEF7h85brXwSVljgsyV3c3cG/Uz28WXms9zCr6maIz8wIFxs?=
 =?us-ascii?Q?U2Pg8SfC1bRAtnvKjdnA2aTAtzcWx0/yNc9c9zUCvv8zdIjETorBvV54739+?=
 =?us-ascii?Q?+3yVURQDc8FUm5GEhOo0OBjV7UNBCKzXZNNYmkY6Rma5gZJsDvMKos6Ef7fk?=
 =?us-ascii?Q?C+vZ5yzp/USxL5t4bW/nVQ8CHQbdNpo1ulyz1kz/JoYnrusMfi94ps4xJev5?=
 =?us-ascii?Q?BKaMY/fwcwnoJZ8ZFrxqNBiR9Lr018lHxBMZfHuwsdt6X9MPWamwDtnOqTix?=
 =?us-ascii?Q?ZVXDeOYTsUKZhjK5UVhoSVpJcWufVr8Y88LQuz+no7+1o5P5HBZtIdXfkyj9?=
 =?us-ascii?Q?quS84oYbGLWQjlTFokPFlBatB7Grg8lihI6/g/CMXal2H2ogfd8pL8OAu0CR?=
 =?us-ascii?Q?oyYvKi8W5N3p5dbGUufNFoUzCIv2tOl4/pKN0U/PR46M5jCNVl8w+qfJYXZC?=
 =?us-ascii?Q?/VLVpbtBYSDIuy+Y81v0itzBanFkg+U94+r4/cfPdxp9AYfU6wuDN44udLTq?=
 =?us-ascii?Q?sxMDdOhgEgom6lzdJLKtiZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93909E577C4E9649AEE5F5E2787F73B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ek16oPd5fzX09z9r1QxFvSF7gVMIp3sE0GHVwRy0gge8rUu59K7y6LovtaV8jKoRecMGGsjf2On4XLJ0rPSs0h4fEP9/vYrgHYV9+SaGOJ3khi238Hcb9dZ1QsB+JnkByI2I7rhwEGGYmyVC9Q8cvEyJ6oGLgPEnW1b5wlGa2+eHZKDNm466uCXqPTfeQy7nMreuGmOa4Ab0YI22KLxznT3TzFgrvet/VbbR7M+h/3JloDqcx9fpopp+eEAOH7VdIc9zVZ/8ap01FfDVaAE5ATPEded/tkb1ZXpPa+2Gd0hlfFK9KitVId63nL+nt6SJoU0CL/BSGysLm8g1cgFdDEYl1qtpwPQQae45/NBZBPqGL8m5hknlqcHiXiaMLgPdTx5YRsX2/eYctPDYTbpR/l9zOUByvJRXC5h7n4ECkWbEIGM2LJ+OY4r4FvmsqccJk9jM9ueaFnQu6p8EUg8cx5ct/sNJ0pbiUcmCULSq6mRYDnSj1LHpKv51H+Vp6yYOemPNzEbR2IgBDyfMLWOEAXqkUjWVbQP60nVfdApf6KmmsLZ1Y0a4faTBuRkWJ3mYZByGT8A988sl7NP9FhAWlE4C3GX/MQPX+zM6/ojqfr7eUHNjy04s/iYCF4/NnqA14d1xO0LdSLIcU8WHr0H4AGtslF80Y/wgbZX6mvPmlF0Ytlns6bVY/KDdwolRwfRCQbs07z3vHdu1hHBPrUJ7kQUGOCD/KwVNsZVereysDHPkfmiKOLHYHA7e3l+OMbK620PA2X8+mcLQjpJBw6/lc+ny+kjS5UQsAVlDxq+EgAom/Ao0kB/mkCcGZVjpbcKPcCHUa6artE0TTaMeqrPvk/6ZXtQ2Pt0CEqk1IE5k8osNDJ20x/TXYnWP3YHX90yl9kwugSY8IwC8+KjAwSpjugMHIUK/qCrO6iYDkxA6lyU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d82456-1772-456a-7e09-08db47a1393e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:29:57.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTyALGVug4UsE2GvdGGCMRco/w7fhqLUj3dIvk/LOsBiQTb4K3u5eUZdDPl0LinwjpH3mj675eOWmb0uMWp+LwI8LcrdNLQC66W0QXkYXkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6954
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 08:57, Daniel Wagner wrote:
> On Fri, Apr 21, 2023 at 08:29:22AM +0200, Hannes Reinecke wrote:
>  > --- a/tests/nvme/040
> > > +++ b/tests/nvme/040
> > > @@ -38,7 +38,8 @@ test() {
> > >   	# start fio job
> > >   	echo "starting background fio"
> > >   	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D1g \
> > > -		--group_reporting --ramp_time=3D5  &> /dev/null &
> > > +		--group_reporting --ramp_time=3D5 \
> > > +		--time_based --runtime=3D1m &> /dev/null &
> > >   	sleep 5
> > >   	# do reset/remove operation
> >=20
> > Wouldn't it be better to let _run_fio_rand_io pick the correct size?
>=20
> Yes, makes sense.

If you do I/O size change for the test cases nvme/032 and nvme/040, could y=
ou
confirm the runtime reduction of the test cases? IIUC, the fio process stop=
s
due to process kill or an I/O error, then I/O size reduction will not chang=
e
runtime of the test cases, I guess.

IMO, --time_based --runtime=3D1m is good to ensure that fio runs long enoug=
h,
even when nvme device size is configured with small size.=
