Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9546F2868
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjD3KF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjD3KFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 06:05:25 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C71994;
        Sun, 30 Apr 2023 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682849124; x=1714385124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/+WcGRiE0ZGCVf/IyiQvffQUvgpfUZJCyP4v6+TT1g0=;
  b=FJNtOTUUXc5hgCIdbsEplXqyjttipB7WHMrrSb5Z8ofcrIST1h7NQLwE
   BOoYG7F3GKbhZriHhzA0rvZ5jwMRxfLIgKXzukd18wWPqGZXc0ynEsWYl
   MMCVT13NOm7gFGCVoHOvnttHGGl/gIeaYwSVne2MmplfhvinX3DLnQcM9
   YLjLDV4G+a31Bjskxmt8u/fGz/s+d58Dd/7dsvOkxeoj6bNPaAGFOZMFN
   slFBaScjuLpEOdlJJeC9VvlcE/bpWhEt5QxN14pn1B1J0H2MR3TZAAdQ1
   jQrcloXHmtZK9Gkj8IxG3MDD2X87IneriPUd1JdY3FQ2/lZnKE4B20AM6
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="341633944"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2023 18:05:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US76Cc+tTwrWsyOoQs8NjWkeHLsVIlFwIXyduqnxF6ZRSyrr8FIrvwoVeuBpoOSx6VS90gZGzlGc98YNoWNOA3nNEHvss0gI53TzpxA+UNU8eqv8uzuFCTNmbCZxCnaGR/YuhNjyMhA3UYNV1U1G9qMQU9YJSnf+kXjykdbgo2lB/vxz5Y6/crSjz1g3qaAsxHkvb4bJ/MHbXVI6sSxoVJC2c5RI2iuwtao90mOKUvGCLvzxl8+IAsKe9xX3tI6tGSOFPq/CJbaze4mOULRqjdC/dUbMeY4ezLhomt3Zu7270d9EpES6CP7XOsR8eOdRHhpHz4VwVc4LItqWrOO3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+WcGRiE0ZGCVf/IyiQvffQUvgpfUZJCyP4v6+TT1g0=;
 b=YmGid1Vn3ffSYyN6zcJqOneKxs8hhKxRGZ7TbXrW39i2G+TAaDUWhFCx81a6rvrHheDLqxA85vzfz9BEORSBYfwZf1jwnoUS/+wut9sBi/Qsc3L4Y6nuKI/ksj6SRh7d0iOnJCxWF5eSHvOMUyY4qCrevZCZ5UO+91dDoDh6kpgiIZjpm3LNuMCm2ypQTQQKH0JeiFodE/pJT7vGkxV1MqVZnSptm+4WwKKjqHyV/+AaJU96jckrVPCLrU1Sn5aNxBUNL9gCFwkBwv89A+vuF8L+tILwy6nEeTo2ZYWhjb9mrOG1Pw7TF1d8z25NdYRk0EqTrCtqGl5Tl1rCLEoGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+WcGRiE0ZGCVf/IyiQvffQUvgpfUZJCyP4v6+TT1g0=;
 b=LBZg03FHTe4QQPs9i8oBlQKUUjy2AfiIYSi+iYPXFrFeUA9RG9G1mmw6ZkKFwBxpJkucRcwtJLAJJCL/4yCGyILuzuVytZyoOtS3J87Xzp0JLxpCc4KogSHu5bWVbBSdBQrVbwlhPByavfy+1FrS3YjUwOB2O3pDYwb4YK7OLYA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6298.namprd04.prod.outlook.com (2603:10b6:5:1ef::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.27; Sun, 30 Apr 2023 10:05:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.028; Sun, 30 Apr 2023
 10:05:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Topic: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Index: AQHZe0tFVEwtRfzey0GWUGL193fJOg==
Date:   Sun, 30 Apr 2023 10:05:19 +0000
Message-ID: <cmhxiighi3pelki7nd7v6sz7a3ekusxs6wq5rcxunbpe7wob5m@ei6u4tzgsfyn>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
 <ae4faa38-9d84-c708-8228-223ed7fc68db@nvidia.com>
In-Reply-To: <ae4faa38-9d84-c708-8228-223ed7fc68db@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6298:EE_
x-ms-office365-filtering-correlation-id: 9801a4f6-247b-4e8a-44f0-08db496267ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I0niNI8iw8MZWf1FzrNd19tQSoChAdKKq+ylYPni400KUW4ztWaHVxYt4YnofdMBm4Tw56s4CNDKUbW8DemtA/5NSRd7/aUDGuqPWucQD9l/QNaCAqelMYmhtKVIUqdiB8MDJ1GPEbDr2rVBlR+ZISVHTH23M8wEhX4+qa3uUrGVAw63TgKtH7upKbENEP5W/gOTNEn1B+ctSpzqZkHwGHBcumqK1djLWehTdfoIEI7O6YIZs6/SerI+1B4BphZyRODj8AwX7Nr+a3MLp2DtN/VmCxbQz34vzjzpsttjHCNEYLXKiXQp7fkHV7kVHzHWEtAE0pLbFt8Pb1WJJCWiYGx4BLcscGXhDYxrFT8SROnDP1qMq5TS0jEhA7+nIXevJyfyxzs3ryydjipe0WWpT8jfQbT6eD6YWMB3TDSwQK+qI7FnQGpI8r/HJePBN9HjenMBC+j1zJPM1ee5sEUHwiR8RbWMkkGSF6OFL1xY979QZ3WmmccSG3rGgGV6tD5s0bdk1R+57mMXtZcfVGY2lq7RK80xt6sKa9Yssr4qaKlHnCvCbA3CBG7u9vWXgPVSP9T5x1fo2AnUbe1/XTfTuhI6APt6zSSwmjDgqZoNCrQrDcZuRdN8KPH0N2wZ7WJC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(33716001)(316002)(53546011)(9686003)(6512007)(6506007)(26005)(186003)(41300700001)(83380400001)(66446008)(66476007)(54906003)(64756008)(478600001)(91956017)(66556008)(66946007)(76116006)(4326008)(6486002)(71200400001)(6916009)(38100700002)(4744005)(2906002)(82960400001)(122000001)(38070700005)(86362001)(5660300002)(8936002)(8676002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVwlBzOfcGfWo3On05P3pj7+wx36TKwRnBcD63Ek0axja32xhD0/Kb57sXZM?=
 =?us-ascii?Q?pejfD0s+SP/FzfGW+OdaRXt/2m9u7cx0HUK0gBDMEzbf5i5QpgXd73Le+rrS?=
 =?us-ascii?Q?Dm7OZslMJhmYEKdqRQ83u9U09t5gJUlOWHNoCujGNCHzVrEHf69qzMFjpaLS?=
 =?us-ascii?Q?37uZARVTmogWYrTOhCeLGjukeJJMsPGa4+MLBiI/aYzHxc8hWRpQSYTZfuyu?=
 =?us-ascii?Q?o9TV8D1ppK23CEPYTWf377bzE+Vrwn/FI3llxdpH7cQk7EHWmgb7Xn673n1R?=
 =?us-ascii?Q?gKOAXVrr1en/WJ7590IXaszv0n4qLce/BNi48LxbryuOnqRrcd+9tJtYzG1S?=
 =?us-ascii?Q?x1XLaB9KbMVOTp4pXtiVTsbK6Dkvjinbbn+v1Mjxs3MDHJNsauTvH1KVQ1YQ?=
 =?us-ascii?Q?rmcXgEGMKM8A8T30n7BY2TpG6r2C4uBcwmBAJ8xgbTY1frEy1KvR2qzWWrSo?=
 =?us-ascii?Q?yXwn+7P31RT2JcKtae/rosONpR88HvBYSxdtsgDw47/DROijcU5YL81U5GNe?=
 =?us-ascii?Q?lNaWjgt72QbeQO037vV/47vkcOJXdZQXTmNCEy6wQhscJ9nMACOxdWgdu9eE?=
 =?us-ascii?Q?HTGxLkSzM16FzcNXh88hef0mK/Bnk1hoJ0uLa6JtiqayWW83xNuOqXVWdP0/?=
 =?us-ascii?Q?HeehvMkSI383ddw6gGJqwW7v+KOn8VJyfK2eYcG8JbYkJ9TAQvO2CB6pYg4x?=
 =?us-ascii?Q?wN0LSFQBLoPOI736ronguoPMbGpSx5/pESMfcd1TmPtaowxQHXbSQ8/lU3uF?=
 =?us-ascii?Q?tBFLUjO0jizlECNkDcgNLnNcbZXCN0IZuDy+BquxG1ZCNxzLcfkQeGCwjTsp?=
 =?us-ascii?Q?U5QOarI6ySzvvzOe3ogBzjCehDnztBBM4qoWAF2Sys7uOvYy87NiiHuJJ8n+?=
 =?us-ascii?Q?eYBVveey+Ejzi21q5tQNvMv7yCF/MQPTmnd+wFeltOqHeTLPIeQCvDP+0lav?=
 =?us-ascii?Q?pcRt28n8oB0mz3pnnPyvf4j3XcDDamOznQn9re6rK6Fg3Yh1lnxzrNTJ2/Wl?=
 =?us-ascii?Q?t5D4MUMlLV1XUniq6NyXVawz+VSWlZvjDya7kJKR74YTaPxFczW8hAU4njtn?=
 =?us-ascii?Q?Dp9t8wKbSjnzH36lxLn4LyS1THOd8O4JLLM+5PTNDURwULQMz9kT5OdpjbRi?=
 =?us-ascii?Q?ccUXyVVoYBiC11JqR16VPR98oU5FLNXxblmqA2ZQGcJam1uGJi214nAnYdrB?=
 =?us-ascii?Q?/5wPtfGo0fSlV2Ikn2o2mzSmmXVJuXl+sM3Wb0d221f0GaluZZmeDNEhUrxV?=
 =?us-ascii?Q?junXd8CkZcU+cTDPn4EY8INU7YsAI8Mj8r9TG810DA/FojtHsXB0BJpLua2X?=
 =?us-ascii?Q?85QZ4AwmQm8EL9J/wJJxqs9zsHi7xWkcscsnIxc2/L+qCo6DJLnPcuEQU6lf?=
 =?us-ascii?Q?CxGgXJhMqWFhldE11PbC1yHOrjtVdaE1JW7ThRLj0bwevmASGqIVghgU79TR?=
 =?us-ascii?Q?BnTerl/dSOmZxDUcGTBaL9sQaWmzXYdLezoXwmxvQ+71DuIkdiZA9oE6/BCM?=
 =?us-ascii?Q?BmGXRBrE3FAXwyibH/YkLUQY3yo2DLZbxHEfBdcPYmGxPbvk8iC0UTGRAVrI?=
 =?us-ascii?Q?xWoizbn7Y4HNHXqwFdGwQn7uZ3Nm1hhUy3nho34YHjwMlyxOIQThDn3JwUcP?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDAB7B4C87E9BC4EAF94F93C2D277725@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c35rQwwrw4QzPLVLEfGwDvrBEFaf0Dk/1TELxyIjjnFG7T3Tj9U0mHYm8NtH?=
 =?us-ascii?Q?hD7REWnjbDZ+oAlYqj6DixcBes2F9M2esrxj7EucCwXaI3XmXKuWIvPDVHC2?=
 =?us-ascii?Q?vgWM1HbHk4TTKcEGr8QUIpj80L8F1stRxHFnPm41S9yNDGsTSHrNtBxhvOl3?=
 =?us-ascii?Q?QbqwlHlebQ1AnZuh19f+VW+Q+BXtwQD2CntVpOkKZT3vkYYu69KdB+Hy5QhJ?=
 =?us-ascii?Q?Yk5fIsJidEwMxXmoW1vVbPABXiWUcoM1NE4o5JJKM3xFRav3UNSfVcVGGZSp?=
 =?us-ascii?Q?uQlZ0HavVo8hSMiRnhuEC1eufSE2Q4jeuu8jgP3re7vb3GrwDnzKOb7Kajk1?=
 =?us-ascii?Q?DFsPRcwfJFXVWrZ9ewXvVcxQytCtNnfQjCm9+a1OcernaquUF714GTYIrens?=
 =?us-ascii?Q?m0E9hZAuawQW3MI+L8akrp1UDcWWYAWaU3CIsqvF7Y1g26HSBs9D8+4ceRfj?=
 =?us-ascii?Q?xVESlG/hFAydqF0TiqS9zCG0Fa6gY4EZwCbM21ItENY9cn0ii9+bjgT+4DjW?=
 =?us-ascii?Q?tpDTjiWPaVSOlo4vCva6QwS6l4BimdDBlnmc6BXDu299eqNO3ey5ujeIgglP?=
 =?us-ascii?Q?d1w56CuD+4yfgupjp5mRcwUpENcAgAoZjkfzhj0tQMvAd+VYSGSHTey64ZiA?=
 =?us-ascii?Q?Y4LHX5pUIe+EtKO5exEZQFpmjFWaGU35aw1baKsIO8VFNpzKZ3iTWMCgUYDa?=
 =?us-ascii?Q?/r4SWnuyxVCd09JOkQPgxGgmtxxhPHg3EDTpSVYyzHq/eQAOrYfB4mwOzX4v?=
 =?us-ascii?Q?DC50zJ+biMKJ1woAvDnqwLlQMcbaStN/LnF9GXw0Gz8p1zuBv9bD7FDybQ5i?=
 =?us-ascii?Q?/WgLdaZvDTpQWBAO57Oor+cFW654mrEGbC+Hp9TfQ3lM5WINSFzMCgnn/kSe?=
 =?us-ascii?Q?joOOVuMA/uRbBKoJdUtXsWYE09nhDgPvQisSWnlYE+NwjAzUdnwsnWs9DxjP?=
 =?us-ascii?Q?Kp4DvLOUFUoa3xA0Nux1cA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9801a4f6-247b-4e8a-44f0-08db496267ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 10:05:20.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1wfkms9zsdEA3at5uobtUqL8o7xsYKL8umv0BKWTJCeeq3aTb5YLh1ANWztOkF83Y4gSq95SSMBeDkcgK/Zzl0fTW2YQWyoXWTEV3BupOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2023 / 21:15, Chaitanya Kulkarni wrote:
> On 4/19/23 02:44, Sagi Grimberg wrote:
> >
> >> Before we unload the module we should cleanup the fc resources first,
> >> basically reorder the shutdown sequence to be in reverse order of the
> >> setup path.
> >
> > If this triggers a bug, then I think it is a good idea to have a
> > dedicated test that reproduces it if we are changing the default
> > behavior.
> >
>=20
> +1

Agreed. Patch post for the new test case will be appreciated. Not to forget=
 this
work, I will open a github issue later.=
