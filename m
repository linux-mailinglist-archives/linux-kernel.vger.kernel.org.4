Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2716F4F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjECEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:04:59 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A11FCF;
        Tue,  2 May 2023 21:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683086695; x=1714622695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cIOGpPXVw0Z1/kIHe1Z0XRj+4M+Sw264PHQftdNdae0=;
  b=MimoFZdvEwSi15Qc3VdO72m+vyLKgkI+3whmeNswcEolQW9y5634NVX/
   rTcDDdw7a+VN2xUBUnDumnE9jBaObkyEBwrTjVOgZgkfROiImsh5xMWVr
   4agfgtws6dXGyOG2+hA35H9FjtgQIicUTe9gBbG4TWbzgFnE2lZ2lgvgn
   xP/mSyFOBMtLm7FpSFGPc3/1SMLzMTGaswFiOY+lSS/Mbw/tLjhVCC69y
   26JZON1FwbzSicoWt3KHkCQot+YLUO0lPJp5ZWdVENeBgJTnFuXpo9AIY
   gaoQPRBB893A9yqa49HF9dLoBBkv7htKym63BPFLkEB8voypGFWXe6LlW
   w==;
X-IronPort-AV: E=Sophos;i="5.99,246,1677513600"; 
   d="scan'208";a="229660512"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2023 12:04:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY4uuxxL4d/R4JKuWNCPPOxHjjPmS7fWQJqnkUN/r981SLDQ3fVz5deef5tIUFfUD4unnbikexX7sChZ1NIigWBINzaWaPIL3J0Q+Rex6jWJHyDKosLARYcSlZDlTuPqeJfC/7Q344MGFYwNaZF9sFO9xXPDTOamyhHFbslXRauUpZI8IxJB8NbuZzEhOcxXNaGkdVA1HYa0WYORXqTYtx2VttXj3GIYv7Bp8h3NufmSJjJ8LhpP41RBYiKmgvheByYqpLp+uYhMQeUt0uJs0vLzrmuIlOMxrT6QTbRDExZDVq/jRjUSpairXXNUmpAPrUzuIU4L/TCBGhI+NJDoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTrmQoQL4K9XAGZYaQzV5aWM24eksaXQ4Pmg8PZPTD4=;
 b=V1KsBpSKW6ot3wgeGVJklNETcwY3PjL96iPaQAziSounb/gcK251bYdhO63T7GUSqZq8OJOS/BL72V8k7Lxvipo+odNF9DpJgTGIqHyw5AaIui3+18rpvcfYRK+ZRkWJGG8PwKonCLQ1JNKbP8evjraTBYsRoCBk/Jk+lL/M28c24kgwUYFcFJkhS8OalIkeB29W6O4jZgW9QrTOxfpq3KYp0c/QJ6PBMDOuvAbaWcB39bkMPGVwG54HIkYT8rPgNQCjUd09FB8lTBqZZyDIAbXBZgu7Wfl9tmNk0Y1mmb7GwkLpkavjQ2N2AmEqGxU3A+79baBMNRvalpLAJBRSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTrmQoQL4K9XAGZYaQzV5aWM24eksaXQ4Pmg8PZPTD4=;
 b=nbka2X8Rki8pBZkpWx2Dxok1lpunL5v9coojt90xWysRXlZ4S7lCmrC9e9q3aN62vs6jyjUR9aVQGqTYWa/KFIQbHXybEI21L1cotnzrBUIlfbs9WN7OQWwY/+rJ+xe4NMCocUrRbyc3q3k7Om1b+/AvOwK2yVT2AGFTqkLJDjs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6880.namprd04.prod.outlook.com (2603:10b6:208:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 04:04:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.020; Wed, 3 May 2023
 04:04:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Topic: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Index: AQHZeX1i8rG2HytVkkq4pAqFsLjcxK9G/3mAgAD2XAA=
Date:   Wed, 3 May 2023 04:04:50 +0000
Message-ID: <i426otrfqbck2q5cwgzre52zsiaqviqz4jchszqmvbvgc64cue@a7d3frn6b64x>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
 <clh6gmnivvi5e4o7pzr3mxfale3vlymgepdntkjtvub4cazyvk@myovldb6bcnx>
In-Reply-To: <clh6gmnivvi5e4o7pzr3mxfale3vlymgepdntkjtvub4cazyvk@myovldb6bcnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6880:EE_
x-ms-office365-filtering-correlation-id: 613e3431-8cbf-4aac-93b7-08db4b8b8b13
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1et4aHqkT4nfhBfrbbLKlOFHbzDTX7KKDHDNZM9FdYd3CO28JXlEqxQXnyB6A8zheNoFVBW8Nrbs3ADDErN2pZDDzyg2md4/qEDIZ36MbXihF/LvUBLtiTutDxSJmxPzlXkB9WKNqZMWpHSSuEykFi2tpH2RJ7o0X5mda25T753bNuZCKmvyXxjhF4V2MWj+VUQ9TZU67ao7nnDqsUEKmywShh3KKP4/zeW9gI9LrOosFgkM5UbyeNbGw9SVzYtnBVUzNNgHysp6doTZpwszaULn6DO2ECqNrqlEC6g0UNnqpvv7XHMJr8LXrxRgV5EJvvc8BOwP9z/1CrODAhR9NIRLCk5PAV8eGdJYO1xYBOrWmOpFTzsw+IhoFLzd8amj2Vw2d5SEs0UKI/J8+kL2PZuQg9qqDxgpb69t41+CboVuNSiGywrablO0crLiGyEDgyfSlwqC0zgTTCUvQGrjpw11NhuV/JYXLAfMN83vGBenjfA9WKUjdHLXQUJFN8hL2uPslQr6KSpf4kR5YTpUZUWE2APjBXePfyeX1ZfmxAsAd2XfzqiF/MkoKn+VW47ajZ7n60ifoGtW333tvvkqYCI89x3QzXdIeMTjxQ+lLDSFInMR0mfL3X54qgdDnzhq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(83380400001)(54906003)(9686003)(6512007)(6506007)(38100700002)(2906002)(26005)(44832011)(186003)(122000001)(76116006)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(82960400001)(478600001)(5660300002)(8936002)(8676002)(41300700001)(38070700005)(33716001)(71200400001)(86362001)(6486002)(316002)(6916009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EOD6OyDL311BZkJ6g25fliG+HiaCTSvGuKydoA6TVnEXPYqvJ4o2TzlYTTWc?=
 =?us-ascii?Q?9Qv6rWsEQn25rhhydhD8RVP3jktaYWU4SXnSYJ8+OQPVnJ7QzJ6e42hINbHm?=
 =?us-ascii?Q?3M3+8ZDu90f3pqZ426H6fVjTtoOpNLpmDCjLqabJFJu260TL+b4ygzaVGoUj?=
 =?us-ascii?Q?N/WNHVI/bjhu0zJ84noPCyjZTw2FW7EV2DgiHgg72P7fVw+SQ0y8NRfrWkzt?=
 =?us-ascii?Q?u8gaqPMHxxjKMFbLuhJDlHQjl/+MKYNqukf/37Fj9ZE8BBo/HUavndk8rkI2?=
 =?us-ascii?Q?hH1o/PhbfSKvPeVtHGP6ix5fSPRS+lxvgdB16yGp4qYqtRi0mrEK0QM5TNdL?=
 =?us-ascii?Q?k0epKJGCTsFybLplo0YrBQCUYB1GmXQJUQcKBQnuavc0+NNtORqB0sv2fwcj?=
 =?us-ascii?Q?e9ZNdJZjsrKbj2MiCthQueYNVxYwHzuvTlJOJQ3WKyHlGZDM0lZGre6tIxZH?=
 =?us-ascii?Q?LLGkufwNvK51qkhyxdzLnXLfeElocq0fyt3CIJ936v6PSzyvP6Q+AiYLChb8?=
 =?us-ascii?Q?BrGlb3JJ2F3+v2WAJN+ixIRZ5pPFbeEYxcakLqlxMjfKJQG4WvndrEahZb72?=
 =?us-ascii?Q?mLT4X0A/L355CHzEqFV8ZRIoC6JpJ3oEsJocr2IV9aybrweTxhFmpMEKlO7f?=
 =?us-ascii?Q?zYuU/wU4yOj9omVilj53/maoZbZ8u3qyVJNHv3Q5ZJKdycdfXAxvQEQ2aHZ4?=
 =?us-ascii?Q?dYU7cZuWPncFBdnimDX3KRIQPw983806DWzsE51dI6VAHU6Faq7DhDIIXses?=
 =?us-ascii?Q?9wVvgy1nrVZwVYkeYZyRAS2ditrdikMcNI3csd0WngSLnZv9ANzuOWhs7cuP?=
 =?us-ascii?Q?Ael10GfYFGan9ymdKZ1dtChYSjS2eGXaFI2G9qHictJyjdj+akSxPjZP1bTa?=
 =?us-ascii?Q?nlMiZiRs7Tlc3gpKlTMhq5gD5vE0yXrR+1SLcM3YZEiHWclIU70VmKZ/ID+Q?=
 =?us-ascii?Q?R91aDaGRoS0BbkGvB9KV502FAxSTBAkfYiP2m0JbIFjaWPSXPZMH0iDWczOT?=
 =?us-ascii?Q?wkd1V2MIUNBa0r+szg6xnJ38UcxE6OyohKSabHq7Z7kN0fpT+POT837H7CJQ?=
 =?us-ascii?Q?7xqRuY7ZqkR9CHH1R2sH27pzw5YoOc+5LQOCAsJlqhmdBtMdXt8UomN3GUF6?=
 =?us-ascii?Q?7Qis2hWAC8Wk8/ZkGkmeEqhVE6mpkRZOx8ksmQdgfCXM7bzxafkz/2Aq/m+L?=
 =?us-ascii?Q?zCwS/Em+P1IACbmfCWyX0miRU7ILdPone0mgWuTSqTXIUwtmzU+9kpnsuIfb?=
 =?us-ascii?Q?5WUBj6vZlhXV0gf29dFr7BwGyYdj7e4MbkrF8jk98f6MWAi/U7xeYr14H3Go?=
 =?us-ascii?Q?X4PMGD5VIIbtE4cWM+D9DqXj0XgflTyGpgghorlXPbUohy5Honfao2So7rFF?=
 =?us-ascii?Q?q58wkpCqW62SRP4mHK2UdHAT1vY1iTe6hqPbxIkFdytSfS7GVUoEAFc3VFPQ?=
 =?us-ascii?Q?YKP38KsRoCsnU/GwM58pjGhrmwjiZfDeZXtD1tuuTYYWGJoS6GofYASngbEH?=
 =?us-ascii?Q?9Hd8oP80QYML20oJGz586164MySMHga1HX8ubEz3akb/FGFR7pKLG4bfwXST?=
 =?us-ascii?Q?amZHxojUapK8ON9zUvgrUgN7XorOFHZgWcW9FO5gM/GCX/orsk6ZI7hGe6Fc?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74ADC7857196C149AECC5FE2E5E8767C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TXEVRRNuCkv7LCNCxfzBwYrjjTXnt0sTgqa3f+hzraKl4CISTLoi8aURxqhkx/34L8AQMFRHvDu0RJJX5tXcXU3R6SZhgEYXagd6ZUhe2DYUnrwGdbuJCiHJkDgxePeb4k41YfqYPnmpt0z1FdVWUOVmya9eC9DtMZhLA43v9gYaMdsPsfgd0crmFIgiOmqZgrxNGE9V1lQpfG4NT0zxlESIEt9UmFqTf3nxzu2bB3bfCSAWq0PurUDnn+Lox0Lk+dpjIdZoODGgFFqfI8UVEBLY2zs/YKXO09dWQu8pt34FzX+wuIo3rM8+7Vx6S0y5+F2TxslMH/7mlHAuZeyawwwJFx5bPBl0sZ4Gi2CxVnFaI8tpOyUvuA1/LSRLgIHFGMUXWoW3R4Gi4ennJsSYrx4TkCIS2TYmFHFxSoYs6MdDtZEAquZo0dX/AuQIaWYgt5b7/bw2ST4z8l0RCh+VfD44ye5PfCT/50ZG+4vXWjNeURdx/ZqZ0GdnJJAhBAOFzlH/HiUy4rHCFsQqpo9CgHfyeDunpTY39OqFxzNC0tutmBlJ8hW1YXDVDKFzK3/npNEDNN8n2f2/JHYVvmwor+ZwfV4GZfAQaim9ccFDy3uPm8slCYQLpxpfjclRYtkC+o+Gua8+Dl9xZFTLrn9/YkbnYTtrL+Doiwe3+CCfOuJyBkCI0JbspBt0RPoRaMn7HXsEww3CvcfpPTWBVN71MImvYVZAB/nczUWSvXfil9wSsKYeMtTRBkAiiEs/RK4l9zp+K8Qguz1KfZaNXgrtLQm41eGQRxbwPf6kH+MDnoMJ3gHt78eATjvvWLMNZP8T2fPwtq4VwqccoRGL4WNHEc4ZuZwpAJNIyobiUnU9o5OAAzMIuNjqtjf4I3wqKe6zhRqE238pU5ha7ETvFuwTBwBBwynTmaVV53FzIE8hfAQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613e3431-8cbf-4aac-93b7-08db4b8b8b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 04:04:50.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5uS/HbTeU39l/91slA8qw7m2mez4tBVEdDVdCemM+XnfRR8JMaCxistmBSnsfX+lW1Kf9DaQTtw6cHzBowhRQ05+SUZz1SGrBKdROO/3W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6880
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 02, 2023 / 15:23, Daniel Wagner wrote:
>  > --- a/tests/nvme/035
> > > +++ b/tests/nvme/035
> > > @@ -32,7 +32,7 @@ test_device() {
> > >  	port=3D$(_nvmet_passthru_target_setup "${subsys}")
> > >  	nsdev=3D$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys=
}")
> > > =20
> > > -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> > > +	_xfs_run_fio_verify_io "${nsdev}"
> >=20
> > On the other hand, this change for nvme/035 does not look good. It runs=
 the
> > test on TEST_DEV, which may take very long time without TIMEOUT config.
>=20
> I'll add the nvme_img_size argument here instead (nvme: Make test image s=
ize
> configurable)

If TEST_DEV has the size same as nvme_img_size, xfs log data will consume s=
ome
part of the TEST_DEV, then _xfs_run_fio_verify_io with nvme_img_size will f=
ail.

I think the size argument of _xfs_run_fio_verify_io should be,

   min(size of TEST_DEV, nvm_img_size) - log data size of xfs

But I'm not sure if we can do this calculation correctly.

If the calculation is not possible, it would be the better to leave the har=
d
coded constants (1GB for TEST_DEV size and 900mb as fio I/O size) in this t=
est
case, because nvme/035 is rather unique in the nvme group, which uses TEST_=
DEV.=
