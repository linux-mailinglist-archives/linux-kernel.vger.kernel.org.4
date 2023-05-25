Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A8711AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjEYX7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEYX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:59:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB09C;
        Thu, 25 May 2023 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685059179; x=1716595179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nmK5SeeBV3U/nrs78nV9d8MNZHSgC6cqkuhUJxPFX1Q=;
  b=XJIBK18Zm1UXZMUlr8FxZCjevqpr1X3c7JcxSaBOpDG8fh5bBKRh4YA0
   sYVMKIuP+/nWsaZVy2KD7Bd+w1s6Ct6djo8qWA3PaKEHeqfwnmx1G4zzz
   HtRi1HdY1VNch0fSxeG+p2fW/S2p7uVBcT0t2PzomRj+0bhugfEM2xgIi
   nchysEM9Qn9z7lpvk9QUeQY8vbpSFvouI8KJ8N+LWzJoSd2engGpEAsIA
   P2JsAz9aTTDtH1X7g1ZWLvkMWvt3+xWd+8HwpUPtikCDuPLpcZOqafcfa
   +tQ82vUS5pLlCEio0YiGJbhAA27aJoiJrXr2MfP1N/4ZGhp1NXG/jM/sS
   g==;
X-IronPort-AV: E=Sophos;i="6.00,192,1681142400"; 
   d="scan'208";a="229833999"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 07:59:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9/2qNyknvGxpwGKxlm0HsbAlK9GrhPYaHhgxX5tBpk/R0Fnw4TqZD4ueBpd3ElBP/mCAL/HNYrLXMf+0BMilOvhKSESuY30upd0MUuaCQsh8RJUB7fCXeJgoL5M6xcPqg8Zhuug5O+BxW7hv5W4Ftaetooa1biejY1iKmszQPChW1azaCe2sQg6AmKNj+0BfBYUQxquYPqEXWyQh6AL2DtQZmSeTvKywNeJJBrfyCH9OSkFGoG4NE5OCuIvOaz6m7AmFPVV7Feg+u7S63mFa7u8dGy1xgJyGJcy5rxDQZBBcKBfxKyU7zmCtr6Ekr3lFGr2PzEOnP3CrGjGEe3Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imWg0nhnVn2rheG4g5c6ebWsb2ZibpYOTFzPYeik1FI=;
 b=jsZov8Z7/hIjNck/bH8471irO1Rxs+9aQHi78no8EeIG7dJR/v20EhYMQA0Cj8lIaeLh4g2/zhbfkkpW8bEXyHVUypHJA1SBUIgYKFbslNwOZdKv1gtcjystoq3twZkfn7g9ZjTx8dnD6+3Kw1JruttfwmjSg7F9DejUE2Gw7/HnpH1qcJW/q5WmvDhtIyvHbbvJvFGfzUSkxA6IO5ruB8vo7Jv5hu17iadADjxZWQK7Z0WEeWSflVy2aAj8aiHyRQJLUvQwQemBc4wwtd9d4FLHOIfG16xmVmNVoAd3Z/pyOb0oVA621TKKvaMIWfvQRTubvvQeGPsxJgT418MyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imWg0nhnVn2rheG4g5c6ebWsb2ZibpYOTFzPYeik1FI=;
 b=YfZUHCXK/mQkqYwgI/RB3yYAuuO2juXD7txcFG52S0R6XsV2vIsrjOq+bVdpToLuafomXUAUApa0nsTv26XmLCHEatk+topCZ7NCr+DW8vTo4Iv1yOvlwDX/2+aH+EXeTkKGQXg7qqocZNsK6Qb6U0fQIiqVkMTaN5/uwTCpaqg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6573.namprd04.prod.outlook.com (2603:10b6:5:209::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17; Thu, 25 May 2023 23:59:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 23:59:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 00/11] nvme testsuite runtime optimization
Thread-Topic: [PATCH blktests v4 00/11] nvme testsuite runtime optimization
Thread-Index: AQHZj2T0F9RslLxwdkCWzwHoKJpJJA==
Date:   Thu, 25 May 2023 23:59:34 +0000
Message-ID: <5vldctv46u2ozc3zhm2bxju57zbbeo4jhdxgodircy2m7j7rnc@gqt323aeyaa4>
References: <20230511140953.17609-1-dwagner@suse.de>
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6573:EE_
x-ms-office365-filtering-correlation-id: 56a3fff5-0781-4768-45a8-08db5d7c16b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6sE4nWBh25wM/Yy5mq+kTbnqqg7x61fQl4rlPH6lp1M7KedW9SSvQF4lo661PpW/+73DrPUE4piNviT9d50eCD/w5owl+OaUsNxPAjPQS5HOd1xiF2trnBAzsDq3NKeuysL3Bb89gwD4PS3kyd7+9+unAkIea7+1D2B8RuWH+pKMVXrlAjA2w2Ctlj7z8ZqK0KJ7lUzo1beZsbTir5hvPExeMtQ8IqaxS4bFlbM0FeqLz+2SLawDAF7Iq1rEyxvM4eXDtegNa4V4baCire86NTux2s511s9DE30oaded0N+YLSdWuD3VPS7pEp/1h68+Kh69od2hP33cVMsfWrK2zTcoatifEY/yJOp2A76Vupq13pP+FNAN0PmNwkpNy48m0+Spqf83En+CLtraR5z75xY/tXJcziVv/LgmvTdBb5olD3WczqZiOtYym9R9k+L6f/mI+1osx2suxjvJzzxf8U/au3KQ4gmKMfx0NrJAarZfyhVBa3LDNawA9aF4JBKIo9lrIFCB1wEdJcBXMHoCuRnk1vrWU5yQr3cZEauSjzLtrEIaohR8GWR6SKiik2FkZQN8ZecrN0/+ppxAOxHz+z6t4MZod7bZC1hLxjO0hIqZ/sgWfas405/Yoh3pRBd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(66446008)(64756008)(66476007)(91956017)(76116006)(66946007)(86362001)(478600001)(41300700001)(6486002)(83380400001)(66556008)(9686003)(6506007)(6512007)(38100700002)(316002)(71200400001)(26005)(5660300002)(122000001)(38070700005)(33716001)(8936002)(44832011)(6916009)(2906002)(4744005)(8676002)(54906003)(4326008)(82960400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jkRpo48vk2/HzFzUnuEYqqPcsXF1RoRXwDnJfkXRGNQyK6Qc0OQ+QFMujmVf?=
 =?us-ascii?Q?G0FeUB7kHnHikxazP/qsYAVRNqZ7/Dlj6FY1PNTKOpPqRF69WGelrqwvHcWv?=
 =?us-ascii?Q?T9OeFQVKJGX6keS7QcpgiyaCcP4cRpJOPr73ZcgqPUyhBjdE8lgZ4J6GK9L/?=
 =?us-ascii?Q?+/ZJa3cXCXgWXEYe88uAifCbdLxRN8adm97aL/ZGth4+R2xAA+ZJobGE/sqP?=
 =?us-ascii?Q?QG9PqVPXeRziRQ2t9o4hUGiOS7ipcQP7/8lA/wmbQ3NDZdgyy5mCZZvbKPtA?=
 =?us-ascii?Q?kobO1XtO+NxXGBNlMw6KtLg3uQ452Icj4ykEbIX/IxzgUGRKV5Jxcc3Yc6CW?=
 =?us-ascii?Q?+0GHKrlfpwr5/AyGSrefMYaVQCbJGPipK3Rv20ai9au1RikO7KEoOu4cLNhh?=
 =?us-ascii?Q?Pr+Ox/fnZF6SqsvkHk1+qHWHoTpzRuA65FTg4E5xE1NlAjF48vVmZEMG4BK8?=
 =?us-ascii?Q?gsPZCQLL6DJ8ol1/8Cu3mMRkmwzykwH0AMmUm8XVYRJFAlnI2xRCAYBQHkOX?=
 =?us-ascii?Q?/vHCWEQeOG0sitdPzx63+x1cBB9c45Feu2jZ/nWeAGEC09hO65kAiGGGZwjp?=
 =?us-ascii?Q?xdnlebzFt6Rp8qMeGAXJdCE7vFKKUVSSmmUEjV3z/iQIyh4kUg7wKYtnI9co?=
 =?us-ascii?Q?kWl29fERUrtllvmiA+wjlm7h3daqIeDL7nXEBhGR0eX4XTk4kKL138e28o0J?=
 =?us-ascii?Q?zsoExE7yM8YCE1QrePfEvtG6pd9K5BmPrfWgRUKl7PeT+HIeapweoj+0RgeH?=
 =?us-ascii?Q?QzSXI3A4P0hlHiUTn3jf6nJ1Jflq9GZq9pKOlXy+StZ7xHb2oJGjesDVHSmN?=
 =?us-ascii?Q?ZfIPwR3PUl6zgvyyn1w5eON9lFvCVhmdIn+7QDABUjjeU4u14joYTs8hJJDK?=
 =?us-ascii?Q?7JR4Vx/JBSHKYJ6zoRplol350jBM2ox83UhuvxLBsimm68xZ8jbxuj80akME?=
 =?us-ascii?Q?g+gDxPFxYVI/Hnp05C/ZBO6E30OCtAg+C9OqY6YMLRjxYRDz/iqULGAnpAxy?=
 =?us-ascii?Q?LPmGhjPY1Z8S8/HMt0fubz4x+LV/KxGYTa4TjoMmCSVL3KvMfawyNlXWMfYM?=
 =?us-ascii?Q?QUBmI54btPYUM7YSewsEYt9PX+XBTT72Q6FRFMgdVoWSQ+ZIYc4l5YKSmTXB?=
 =?us-ascii?Q?kWrEMXa6+FwR+k8+Q2y1WoaTtFwgdx3/YB8eL/J4qN0odWO9vsMtvKkX4oWc?=
 =?us-ascii?Q?+uhRpR+zzgVdpnn2E4n4DZjC4WgSbORjRfn+TApaSU7Doa3dUpdT2IrIANao?=
 =?us-ascii?Q?P1Rw2WGGkVe4YgIegWrrPIAvJXYri5wY/iazb2LTZgZcAJP9d8CUdcx5zzPF?=
 =?us-ascii?Q?vXsIlwcCIJaCoLfYPlluMyUfbDUgXZMVqhv5RcGVXR6Gr/sDcSb5zl6GIbQT?=
 =?us-ascii?Q?SZx4m4UFQgz7ts8H9qAkWWaKwiFiGPdtDQ4EXaOUS3q0EMQerIyKonmC5VO+?=
 =?us-ascii?Q?qrZlQxhmFase8zh5mftta0QUMi+uyeUcpxgFDlclFAA3+TjJ4W5zH9WXV3ag?=
 =?us-ascii?Q?dA7ItlTKoDBWolD9QhPGqaGeAPt5lG+EHIl0Z5dY5OX1xUT6Ky2nTO87WNct?=
 =?us-ascii?Q?G5bjo1xJ+utSCpxzy5Jw5g61Vb35lX3HQY6gRP8lWOz+xOtNhJAxChqejnMH?=
 =?us-ascii?Q?A7FMdPeIMawfYSSmlj2Zm60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D694096B04ABE64A89ECC439F9C8C266@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jc4tjr+4tNE0ZkxW6Ug/B3ZtkJHB0FT+xNJIOrErv2dhhKbV4LH9/nNN++8/6zz/fOUN5YlKleLNc0RU/EzwILmoz2vGRl7tpqOOKpWlqGw2ChWGCTdCse5cwgf6qCF3JW0V3lscVugClCQV2V8uPbqRQTV9Pjq4Qu52bVTunq5r+gf+GFzO7W2TnpC3dEpde5/LeLWK2qh7Vp5ADqz/KCFWQVQfw2o96+YvaQuR3sJnaws9Ot9ZQoyXNJ/w46PTOHa/TrFgJGbkhnpeFoDvwhyp3GGKqGjskExSFfN1GMzXY9jhFQd8R3szSWZq/wwfFF/CZe8fLoCafYnvrHXt9SuZ2yLFuQgoTFjlB21jbBqRWmlUm2JinOKPBo0hx0JbB8d2cKe/69gmD2xP7k0kdsjfr1SA3EISWdAHK7NNFcdM5XZshfqlKOCq+/kSjlnDGB6jtD4B8SOFgraSYZChsbKdcG7rMgkk9o5O4jo2RwbZLPljNu4aKvbyKn0eQ0Xyonvf4dYUpdkojzNOm6yyZuPjvU70UEdAzWWtSpqFQk6s8ZRkBZbrEopMezPcWVns3khQx0Hph0/1K2/TKEnxnHMQTNLIdISPigeXAmkH7B7Gh95o9Hby6FC81GA11mTJi/i2r+AMaXQ1w3dWcWOmWPN+9D5K459YpvukDTVzPf9GNFHNg94Zlic3nBngxG3pr2ckjDkRrJCcFjPCsfZ/01jPqXobOywcmIDuJ5wltJGnjHyk7v8tAQswkLkkCu68R5tAS3UArQIbAlmDxIK9r8nk2G0RAjmzyjZPhfT2c6N5oS054oEgQC8+dlqMsIh8R9Z8g3rwNaKqM+GCEixe1xg1vPsZG7mZHOHDZEErqypBjAm0aA2c2jEfhIB4D7G2MLrCU+1agErvtUIiHiFSPVHCTQAijKRfYuu1JjV7g/M=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a3fff5-0781-4768-45a8-08db5d7c16b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 23:59:34.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhj8xm9fct/BP8vQlxMYEx0+5fzA/FnpX2wgYzoLSst3mhgtNczvY/GBB2c8Sxvo7ncFz4sVv/A5FD5BxeRobM593TWIbD1VqwNtGbD7PHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6573
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 / 16:09, Daniel Wagner wrote:
> I've updated the series with the comments from the last round. =20
>=20
> changes
> v4:
>   - renamed test
>   - updated commit messages
>   - fixed whitespace damage
>   - fixed ShellCheck reports
>   - dropped 'limit number of random jobs'
>   - fio runtime 'invinity' changed to 1d
>   - fixed typo and updated documentation
>   - added tags

I've applied this v4 series. Thanks!=
