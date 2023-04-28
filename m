Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC16F10E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbjD1D5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjD1D5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:57:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1126A6;
        Thu, 27 Apr 2023 20:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682654236; x=1714190236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wYMc2WM7L96K7uSIpybTGY8cITCoYwXUH+K7kGWjDYk=;
  b=Hd7AC1fsfZnLLT9XISGDgmpEtgT1g01i5JKZk1gvyDxrf7+RKQFaX/iY
   5b/NmPHXN6AYU3I3Uc/orZboDlrO9Ifc9tlHMrL2Gl8iawNLkpZGgna0S
   HeiBCeHBlP1kJrCNqAoCvASoUqSQtKyg6IGoP+NAPt7xcRGjTu0FRzugS
   veU8++fRFiZwUQH8rlBw7tRSOJyOSP/yoq1uD8Rxf631WmnxZq8LML2oQ
   a6EVrc35cpM+t75wLhbEyZrHGZnHePHxYkLyo9nuWwiY3lTNV+9+hQCk3
   8gzPBMNmtN4U/5doktkLr2sPdo5Sq9fa2IC8mKVb5oDAw38A1GIDrRqxt
   A==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="227687024"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 11:57:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJeSfhkrLwB5XpDSRQ4mvkaOpPgVzQxMvgTCmSpgHUf7gjJTmfYpFRqVONPosML4jA+OMMIPOsWV9fGSL3NEdEGKDHamOwV+8Awgwh/79MzrfZXviqVGGYMyRrWmckN8zML4x/3Z/y26hO0FpZND2SikUAnvxETO8gBCZ7sY4vz8LfmLLX/j8bOh1ukxPrNrw6S/V3tpGU25/93i8R3ZOHKo4x6BAD359u3tZ51UQZ1P2Sk9m11XAhpeJTxcD9qEDRezWZ+mNu5Oi4kemNlNV+ffl9gIjdzKgll55rwhsW7Bl0MgJ7ig9bLayGxaZ0xF1QUDol7EJAa3oW6VVPGFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9o4a4SISIR0HdH4RZhi7aLDRPkHfk8eh5yFigxWTVA=;
 b=B4INbjJU3GBnV/DlmQ31Ji0ZEBk/2R9/TYiwNtC2qlY84wykrscKW9i5XYgo16H+iM1ZII80tLxy9J3xEK2giUjNeDxS87CHO+OmKJiy+zHGtFEW0818YI66xfyqMEpJvUgxnUl471f54AJwbHj5IVlE/3hTJr9TEk9hcJGGMrH4F2FR5LmBx6i8p2lOzttUehCMjfFuvlHe+FXWqasAf6lkMXRTQrucvB7Ic2hbBt3D8uFyoFMhw723pjmXlAh7OdARvhDyV9ZQwDfTSKY6NeQfN0WRv+B1d8HfWA1puJJmw+RKjOJbr5lZeV+rnfE8LnPzF/vebFUXb23yFNhzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9o4a4SISIR0HdH4RZhi7aLDRPkHfk8eh5yFigxWTVA=;
 b=eiq+cpRoZFoZGTxA0J4oYHc1QdSfZgOjZrPCxb9C962V6cn4HbVMNoBL0DMFbP9p7R6LPYDEJ3IiP/1rBoEasQ9gwub9QfxutXp26hKL8eh5VqaJBH1js3dNAz4Q2QWlEtFZE7lnNpgBLh70ho2gbjxcnjaLOWBcHs9BGAzQ32w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8375.namprd04.prod.outlook.com (2603:10b6:a03:3d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Fri, 28 Apr 2023 03:57:12 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 03:57:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for fio
 jobs
Thread-Topic: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Thread-Index: AQHZeYWCsLKktkO0eEaJ0SLd6XY4VA==
Date:   Fri, 28 Apr 2023 03:57:12 +0000
Message-ID: <l5uvjenah7oso6batcdgvkrzpgw362c55hwxxvkscriy5xj225@o2qtmbvyg52s>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <6aa42bc9-e04e-cfc6-32cf-f1739944070b@suse.de>
 <7qew4jvwfgvpsqlci6dh6r6vjmzrzaphbqzzxqvvpdfadkj3ab@vxvbvh26bvji>
In-Reply-To: <7qew4jvwfgvpsqlci6dh6r6vjmzrzaphbqzzxqvvpdfadkj3ab@vxvbvh26bvji>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8375:EE_
x-ms-office365-filtering-correlation-id: d2799ee1-0ad5-43ad-e862-08db479ca586
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWnksli5U5+IKQqi8Uo6T4Hf4yqPnaRLEKTiKhU31pqQc0BMn2daghLNozdtfCq0Jmx/0QhvV/yGGLyP/YL4z26t65t9+YWr3iL0xr94Dk0Fpo3mFhJQemfL0lVp5Xxe/fjEQTZFXEAI0gVfG84g5d+y8P8zxLvakvj+YcQvN3xxWpZK6v2XUfIswYVkUt5lVmeon+HyUn+f/3+tyEeFyFINVDu4dOMY9IaHwv9vq7HDMj6Dge2uUF318PYc+30OrVFoDdEK/wV4oc7UVqSSuxPcEUvo+M9fdiKWySerNvf3wZXHLOekiddRzOmaRMaaOdXx/oskEHfSzr/K9O7VZFcN72HLq6QG2i5icxQJTzynoKnIEfYwjSuAzRFBkVCzBvUWUD7gOpeTltiiXAjutWK+dROxULhy8v9bpZj8/cZOAL4EqO1KO1pKQTh1DXGzmKfNHqQJGL9joIBqvzWbob09astTHpUfpmeaYS8g+xAzg7wHS/vsq5FvEgT2VgGbA/DprM1EFqFNNozTgxz9TXrTNczPq7DEIPlluEoVzq0HZz2HsKmzNJT7vTCA10alT8CInU0SRxJSBE5VuIBl7g7pOAndDAYQKZyWjYd/a2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(86362001)(33716001)(54906003)(478600001)(71200400001)(6486002)(66946007)(76116006)(8936002)(38100700002)(8676002)(41300700001)(122000001)(66446008)(66556008)(91956017)(82960400001)(316002)(6916009)(4326008)(186003)(83380400001)(64756008)(66476007)(26005)(9686003)(2906002)(6506007)(38070700005)(6512007)(44832011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+uwzLvbmM5S3po29WBW6b8eCqx1SlTxNTavYMlvhYMFOobORGmmf0A5vkhkk?=
 =?us-ascii?Q?5HnLgOOyZ+Am9FYKdyqrnX2XB4ndkXyus3mlVQkQ7nYAaq8TNIVB4umnfF7h?=
 =?us-ascii?Q?jJxt0AtZQGH2wNm8zz29fHokEul7pB3x4cCZVSfK4zRm2qKlHnzDVrp5w6Hi?=
 =?us-ascii?Q?p3kjHlQmyUnzZXT0SpkIAi8uyiDO4FYNgUc0Rq6EDLze6fXHYg4EpwmTMlTJ?=
 =?us-ascii?Q?pk/T/Upp7ajScGQOCzV/xYX7y2Z0oR5sD6sn3gLbk88GmKDV10BDdaWMhu5s?=
 =?us-ascii?Q?WiZ/MzVtiSDbIpPzXtcTIlyiTC4o0B5XiG9vSYOjAmbBstM35bcpUxYK3Jby?=
 =?us-ascii?Q?3gzdyrbNDNuzP5QUrHKDwpTX/d17F7hlr+W6L4G9pa2Hf04O6Xk2Yx1ed/aU?=
 =?us-ascii?Q?SogLgUK6lXv9hRbSjf6SEYNnmtW8N0/Su1a8S6nQkuwQEAvY+zadhpKSsSX6?=
 =?us-ascii?Q?OZXghJL1eY2cy6bj8kvfJ8zxcJ6GzzK4SO0FdMLqVW+KbG88HEoZctTWLXKm?=
 =?us-ascii?Q?BjufXB9XOzObdZMckMhJBTFVT4t0jbg5qP3LRvjYgQoDCRCYSFlFtG6rj9dU?=
 =?us-ascii?Q?1Nwmu4ai5WfpaobrSgwCOx3JALf5bGlpQJIAasFePezJBchIXS9CKBfhn7U4?=
 =?us-ascii?Q?Z5UDZle9CPykL5+F74q4yRxGihIPHJPFJbFpp0DltocshsRwpIb1AighObJ2?=
 =?us-ascii?Q?vAmEMeK2snhfNsnOrCabMGbnvx1RmHa9wjIRQ51H2Uyp0wHdEo2tLPwdPSUm?=
 =?us-ascii?Q?02f1pyXlMEXEwiFQZZVd0H2lA+pnuSjPcFCy5g9M+g5zRtfn/CFfQ7jbBp3w?=
 =?us-ascii?Q?ytGUvmprRFXDqQnzMKNfIoFBl85TkoTJe5I/7vXS/Hm85zRoMQPiMjRKyVX/?=
 =?us-ascii?Q?XuA9kgxnA/eEvDU3UccGpQRm9ciPGtNR9Nxd0ERCTcFQydDaS7EhCtNylPtt?=
 =?us-ascii?Q?ZJtdDXOIsvQT2Tl2gM732fVY4w7azKJL99Mi/u3C2oxbI3iAfMugQQ84lwte?=
 =?us-ascii?Q?bIz8QcZj89XLIIwxsmh6W+9EedCHLpc0UzMZ10TMFU0KVicQS4rDTMDw0qN3?=
 =?us-ascii?Q?YyCSCMW0Wm+3Lzr4fjGkEsEfYlvdbq9kilYq3lWPDXj/qw65zc5uAHVF69AI?=
 =?us-ascii?Q?PQivRd1u+pGc1tQD32LzVV0++0+3VjbngmFbfthdu/eMTHgeKioFKH9evX/6?=
 =?us-ascii?Q?AayiJk5vVVTQMsdKMJd2u9TefC1pme0MtWyLsKHU0j6p2MvOInjs9J980bLb?=
 =?us-ascii?Q?keFFy2OuiTW06Eab37CEI7ODzYBfJwo5Hb74O+e2GoKu8QUnm7tDvU0pXyug?=
 =?us-ascii?Q?n9D3NlQ6EzS4FA2TEd9Svc9WpiWhnmPsO326BxwUdicGP8h502lV/+4Iq4aS?=
 =?us-ascii?Q?6Dgov3qcYF8m9lxzWcUvOAtfeduMZILnfXag8ML15DeJtp3aiwke1gWILLNP?=
 =?us-ascii?Q?M+GRjdD/QcQgyPicN7qFEI0h6bHvnmz3VuAMqFO1IyyyXr4WFwTjeXzs/04g?=
 =?us-ascii?Q?TJy9kMrRsrvb14arKFDVL7sQojkaxugvb8CWJBZ4pv+VCyKw9PHqSCeaOxTD?=
 =?us-ascii?Q?7P+agXVv4PZfVUk2f1C6NgQEyUnQXxqNi5Y0sGsvJF3CoT2IdOgKDVkJG9et?=
 =?us-ascii?Q?GEceAmA0haOZmy4ovBu2ABU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <843E63E576B76E47B19E7FF7BEB36A0D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B+1O4Zzy7qR40ksxO1reLu7cOgFB0yBEgN+TTssRz4iqL8MGJY71mo3uOcXe1ru5pMZwrQGY/9ZKzF6KQw2tfeeSvGrcZfyR25v/W0CAyR0wndiEP9HOsyNsZGVnZxO9AUvor+jjk6ilODdkGqHQWcOR2uCLbb1gPqST8g6f3AdQsU8uEfCg2ObJqFcAwxMDTKjh2qhjOc9yOJEq0E+N9ZQ3cGVeFtgoQve67yk1q/zneUHRPA2axDR9Eg5XWMAcJaRTQ6R8IJxwrm4x+cWQXkZ2TIWmTZ4VOoANaO6IJ0jTb2zvMcHMFXFVyZKQBjmmsl8IOkozmL0vpiMZRkthzgI3eMoKKzD8vVe3YuSpK0nbckUkTbvx6tGW/wgxhoyLkeF/6CldBv7dR8PWxuCybFBB2GSCAbuTlTQaW2FyZcDshjAtdWdRCOwucP8oNyfPtzvgWVw3vo1pv9BU61ib2FhS7SUeMXFN4x/SVFOqwVFpscXngXcaBJMFoU/hQKkkKFhkY6Bh79V+8pVeiXrNX+x5vluSiK9/k6oPxiRY/YV49Uv7fT+vNnM2qJgl4VWKDSYZiYomt92E71UaQSapEZW8jl193bvC5Tr+vOeY3sN2iTQ/NAgydADJLVw661iy7Ogm0q75cQ6YykBy/Yh2+mn/HdENe1jBG3V68flazkdrNReIk2P91LipHBFpCe62xayzlomZMpq36spA58Tmm2NKTLXhL+lvuleUIBfuvtaBPRICz3zhdyNf7keu+TxwhtIW9QwTnn7xLAOvWTZGusbxh4PzTrLL5R3UbZvkDLS/46hyCspKEr7cmbQMDQKttP08aQrNbXqo16FAa8gXP/i/cuXo/YAnun6SLQ/LYWLAvqP4Oo0jJxGnrrUy5N+cKGLv/knbkA7v8E7eFRw5Zmq5FLBBwhD9icEjmnciCjo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2799ee1-0ad5-43ad-e862-08db479ca586
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 03:57:12.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD8bTBKqJeMxSQSleVi4MudW0N1EkOLzyTMe4FeIy7DZcchX9DgAitCMWGONCdAiCHmZhOcqZ7chplA3URZ8V+yb49oTR08TqoWLaHf1nWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8375
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 09:03, Daniel Wagner wrote:
> On Fri, Apr 21, 2023 at 08:33:46AM +0200, Hannes Reinecke wrote:
>  > +_nvme_calc_rand_io_size() {
> > > +	local img_size_mb
> > > +	local io_size_mb
> > > +
> > > +	img_size_mb=3D"$(convert_to_mb "$1")"
> > > +	io_size_mb=3D"$(printf "%d" $((((img_size_mb * 1024 * 1024) / $(npr=
oc) - 1) / 1024)))"
> > > +
> >=20
> > ... ending with ridiculous small io sizes on machines with lots of CPUs=
.
> > Please cap nproc by something sane like 32.
>=20
> Yeah, propably not really good long time strategy. I was wondering if we =
should
> make run_fio() variants smarter and do the size callculation there and no=
t by
> the callee. If we do this, we could make the number of jobs dependend on =
CPUs
> and image size a bit nicer.

The usage of _run_fio_rand_io() look different for each test case. nvme/032
kills the fio process when it is no longer required. Then IO size reduction=
 with
_nvme_calc_io_size() will not reduce runtime of nvme/032. I think nvme/040 =
has
same story, since _nvme_delete_ctrl will stop the fio process with I/O erro=
r.

On the other hand, nvme/045 and nvme/047 may have different usage. I'm not =
sure
if these test case needs I/O with all CPUs. It would be better to have othe=
r
run_fio() variant as Daniel mentioned, so that their runtime will not depen=
d on
number of CPUs.=
