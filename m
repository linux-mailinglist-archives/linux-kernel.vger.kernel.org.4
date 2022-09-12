Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7865B57C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiILKEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiILKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:04:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BB92AE18;
        Mon, 12 Sep 2022 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977065; x=1694513065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lcU9mvzrERXJgQzmP+PpB42TRXbJalwFcIkIAF9d/kOXWMieI2tQlaON
   M/4B3u8UvkBNxZYB2bFHzgCDQWPdYe4xGKFER5RYIFeqNRcK0WAPi/RnE
   n24dGkS1IEylfwqFqxn29hPqzLG7G8iJs/UHKsrOMmtUdirEk3oOciswE
   yFfTeeflEqjOs00FJDvzZ8RmE1n5mmeHzqC56XLbjiDaTJX7HcJqWdx5Y
   Hgh290Hh3CkDsjmD43ETWb7DWi9VMOZ90GqHfnBjEmHMBM4aOFES65Ion
   ZozR03QMLqGf+exbz2HUrXZPojlQaaZ+4VQq09Q0VNdiWuV9MuEZCJ/pu
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315397144"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:04:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUX1jiM5TpkIH8fVMkIUYfQ77dtmb0OKtdmV6GJMU5QHlAZ/lqMt1Mio/5FRPgoXMKxuxUG9Kbb0KD1vHe46G0i3MNGpz50wcEV7/MaenVxNezWoXMEqhzunV8oWaTHf6GC7AIHnjRulavfrlHADd8ESmGsWuHnp2rtC9TzL+vALOA13qmG/P6vL22wQfoMSKEpfSt9Y59F97E9HWSLlUadLV5l/NfXiaWGXQcYay6XrnZ41JYc1dxCCo4Rttdm2z4zJybao1cCGpeYiBgNb0FjFnw3X4WsF53xh5vBzMe5WJ91OS3TwHyhXpcmB6ihfGFQNNKQy4tIK28zeMM682g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ECGpO42UmDOfjdzbtgGWN3YUy/hchD6BUWqJQaySZzYxRfjo4rZ1G+PiQeWkLJMaiJePBKENZ+QuvzXJ5vHpMvVTDW5Nua4kxHs+4r8cpo3fC+8Aqw+25dyLTP5axLH3EBNhN1oUuwrjcjwk1Q2EfBAM+T9musILvc/DGeuyKRDQ+FJ9UFp0CaDsI0ApanQK2kAqfAgPE90pVksRcDPQaoBdXAvWimc9DL6dk61Hl+owAT0sxNfMUC+lk/h1xyp5E0W4TS4dJP3T8MN7pEYAthQ1jzbaXSEArGO+aftjX7vSh9HblSCzTTNRmedznClu9lFtrlnJvsh+hyfaleyDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QigGMyUxGFlpCaRn6OSlh9eHl+66sWB6R3iNt0yVk7Nh70yXgpavj4GTlyxmm5euS24zSvYvR6qipoNWXJlZOlr5wEcC5oeSr5daKedqYbP4WAaXtieH5QfqlRs11CYfGErdGuQ6qUiVuFNDkcB2HSVtXQRlbLZbBr+9POqcdiw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4067.namprd04.prod.outlook.com (2603:10b6:406:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:04:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:04:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Thread-Topic: [PATCH v13 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Thread-Index: AQHYxoDUrKiPyzGD8kqRF8YWZ8kiQw==
Date:   Mon, 12 Sep 2022 10:04:16 +0000
Message-ID: <PH0PR04MB74165CBFDFD4285B3436C4DE9B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082209eucas1p2747fa09635df54a6c76821585776672f@eucas1p2.samsung.com>
 <20220912082204.51189-4-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4067:EE_
x-ms-office365-filtering-correlation-id: cf66d907-ace0-4eee-64d5-08da94a626ed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpYt/diRgcZTiICSx9gKR0uyp6aAnofxnIONq5dg6wM/cW2jsHLs/v7srndVXcA6/QAYoyEUPvZOB+TP24eQa9Y/xXXyGznRboKuoEIf5OFlm60UaTjHuzC/aLypmmgE6pKwv9MSaTZ5sRhhqA70wWd+iJzjGnlmJW2s8pRgexcfVM/fOmAlDFL/7jPbLxd7U67S4gchfkxBdjfEGBJZuJbxzSGKwxt7yAiLzEhjg7+uWnRu5m1t0qWf5Z2aebJepYEfumS83Q0b2VgRStHBQbhO4/z7N9EvKtvlBE/KGqQmgtQOul2X+YJdBFkSHBSypKm9Ps4OC6naiIxhC2cXIyCVyGfAIQSqDA1ByuA1GrtHkireM81sevgHsVMoeMrbVKf4wxgdZ7GamUh8BdYWGrr2SBjMM7PTkKl09QBc2Aydkjgbk4ClE9zzG6SSw1yFjlEL14nRW1xbJLEerrcwPDLIqgB/cGI0MxgcMzbjL78SypcfJ6532E9sHH7rAKAQZzE1Ymoy9MNXFQRflSq+SR9FQAccjizUEjyG0uNk788Wf4PmvKCYillYwfWfAGV01MV0Ev5k3zp7dSmKORvNPoGDqjxqLW26359KUSpO8Qqk4/8k3lrMRPC8vBlYpBbkpiSCA9H2ngTio+BLwTn0VOfb6+QU+zTjOLfQMfjQu/EnpISBBtcDQfX2Obtvo5gnqPIkpjbKFmtxW2VYmYCtVw4Sd6A4TnsIRp30pGxWkTow8BkHYpsv6QQLdI7xgNlEODcgd3bZ9SnQBa4ZnBq+toqkC4vZrVW/U5ZhkFAAHqpmSwwTxFlqTQbRd3JCtkOz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(38100700002)(8676002)(86362001)(122000001)(82960400001)(66556008)(66446008)(66476007)(76116006)(64756008)(91956017)(66946007)(558084003)(38070700005)(33656002)(71200400001)(41300700001)(7696005)(6506007)(478600001)(9686003)(4270600006)(316002)(110136005)(8936002)(54906003)(19618925003)(2906002)(4326008)(55016003)(186003)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4E3EpQ82K8APWE1qtrs+j7C2wg2/h/fH/BnLPSHVrneeIstVwcuVr2RwXM?=
 =?iso-8859-1?Q?WwI+VEJyD90AnHGF6HxnoMyb4JmRoGesLeAqx+nA2hxgC+WCJfo1XyX8E9?=
 =?iso-8859-1?Q?2lkwqfVQWqAxq1hW4I4O4GZNAKxMPdLQOTvqlGkJDo8bdG/7+5ICJW7nsg?=
 =?iso-8859-1?Q?QUkmIcMfusR1OilakbLnyVb530kMmx4SNJXQc22Fy8U9V8+sAH5+DLEBow?=
 =?iso-8859-1?Q?wM8+VvZnZTJjVXGMXQwwuBcfYeUe6R+9F9ffgv4FJXWJNKcYi90nXWJ74x?=
 =?iso-8859-1?Q?cfnoY3D5yKdNNoYNqPULOY6EYZXAJ4lC1hz/FHl/YdbO7WrjOb7dsRLI7g?=
 =?iso-8859-1?Q?Vh/Foq9E7/gd43p/ZI+mGESoYusmWzNopZnns1iXLqJlBECMd3VhDK5+Lv?=
 =?iso-8859-1?Q?OqeHCStSH1IjQvjnOlyHa8lTrEqahjDUDlQyht83ynmQZA8WxNbXUI3EKT?=
 =?iso-8859-1?Q?B17sIOqyvHshdpBc8IwaHTEwJ7kA6B0f0anC5BdL7EVXXp8squC4Ekrpw9?=
 =?iso-8859-1?Q?aR8El8IfWOMTldTivpDYxWSGYZHSeSmSAuklCgRGNPnUXYFNzH6F6xT8NP?=
 =?iso-8859-1?Q?8W86KpmvTERFb62AR6oclyeRn56ZANxROIkcVmp2LR5oYZJyMYr1goMbSZ?=
 =?iso-8859-1?Q?o2fY3sOdecsNSCqukHmcVTL30UciEQ0jXH4KTVcqWbjtFX6xaGguFnJrDR?=
 =?iso-8859-1?Q?mu+rl7FfOXvLyYn85SGQRah4MwnwQHvbk/NQmCbKNbqO110rqNRQHltPkN?=
 =?iso-8859-1?Q?bQjkr8VPDfKnGL1ImBuBJ2S4jLDPCYmbWUJ1U9AWSU0SXEINhyGLguIF3C?=
 =?iso-8859-1?Q?aqVf36Kl28mleCXcIPaYJeFY4ndv55yf4ztdHPJM6PDnRyg9A4ZKiQJdt1?=
 =?iso-8859-1?Q?sIsTNEAjQPTveE6TsJEHC6A1Dz7swi7xnMp8FoxkmUu86T664Ud2kAe70/?=
 =?iso-8859-1?Q?De+dCOfzYnVNWs23AZ1FyKfdPdoJjEVfPfxbqXWY7P+kTG98+NE5mnBwyG?=
 =?iso-8859-1?Q?T1reK4NoJQWoVTbSMF3GLuAw3gIQyofGUkuNsrGBhK5dXnN30pTr3G/gvO?=
 =?iso-8859-1?Q?pAscACeFIalRk3Tbfpdq1FjrhFLzeHiWrd0y8JpXg05bl+2+YxqDJ86fCC?=
 =?iso-8859-1?Q?JPkFTwmV18ilGc0UPmFZOyaV0dcpn8DITG8pPSHXali1O65vP00aQsQt2a?=
 =?iso-8859-1?Q?TqANqLU6PNRYR5TDVpFyQ4/akAmKGYbClHcBbqLCetUEkcut1FeBxr6v47?=
 =?iso-8859-1?Q?xu7+p1r0GBeL+enOz1wGILt4wOQiuFxK/YTv3R6o+5JHuEQdWSI66W7B3a?=
 =?iso-8859-1?Q?zr84F0RMWHg7qjHpx/w9SvcVvncSl/sB6CpsRNvlqliDos4NL+ZMZFj89e?=
 =?iso-8859-1?Q?HPduhCNHkXMYPaeLjm3Ul/RrRAuWYkN1YPQzytj68UUO2arz8SDuewtdSP?=
 =?iso-8859-1?Q?U6fxGaqJWyUo+qJleL3Jufnrx1i9CluOpcytw2TknUOwf/Gnp6grPCSfGG?=
 =?iso-8859-1?Q?u7e3O1GvcYDBFgmngrpzzVYSSPcZQI4Hc+vH7Qj03KnNpEbwkSUWp+JljX?=
 =?iso-8859-1?Q?0kenOujwJN5yodqPrznOw2jvmUyZcbQk5EfifI2iFjpBEl5tIoAL2lIOdK?=
 =?iso-8859-1?Q?cwlXpSO7ygZVn4cKgfiFpxwLMUDg6kj5A4WVCcy7lAQ1tw2hiJBwqaDXu+?=
 =?iso-8859-1?Q?7PTA0m5OXLlnD1DISRHK9JtdqtzYnLc/Gmyr0n2exE+TcCah/B0OuCGsRv?=
 =?iso-8859-1?Q?yOMidcWAfk9vDUeZXPrjaCSfM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf66d907-ace0-4eee-64d5-08da94a626ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:04:16.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPMPSR7RWG01A2j4E5OFj5iDjSZ0KFggDxQtcsED1Q6MDSxJqYDg2XJU+KzsPnRMKjb9fBs4DLE/Gpv6eD66vNOkLYBZM8nqul0CB8wnPiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4067
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
