Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9A62403A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiKJKrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:47:14 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2892409C;
        Thu, 10 Nov 2022 02:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668077231; x=1699613231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G1WKGvk1Jum7T7szdapwM0FlIV9qetx7gNwQ2B6UWNk=;
  b=OWme71aEYMCUZiyTAJPWm8l9/65GhL5kjszlcn1eRYqFJtRhMyFyKB+6
   4fwM4KwJRq05m4abpuAAqYbmgfNUUFe8dvqWVdWCdk22hRAHRH5MBD5t4
   qCnjmp+4/8gr4V9s2IEX3TPDz3sOgFouTGLOANqATm2pdQ9RC4BmXFJ6V
   f269g57i+LsqA7b1658Gk85xkAeXR+rpsY+VbjxBFt4eCJn3T7kgVNdg0
   U/L5D7dKpWpgNChKjCApzBosh1E/RYOvvV0n/12yj2FOyc10g7r0fjGHi
   oamX9wMXW53XLLlOkUOX1Vb6dYaZRrcOHCs7TMrUfTaQWt6DCpr/yjYe7
   A==;
X-IronPort-AV: E=Sophos;i="5.96,153,1665417600"; 
   d="scan'208";a="328046940"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 18:47:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtxt6ndGvY5gFs5OZHf+KZiTAlv73L5GS9LcE5i+oB8mOsMyCMqVAx3GEOyCBnU3kGVzgoG4Je5l+m9B/7XLrNC8wmgZWiTIqTDoITKFSimMH+DR2pamZiB4ANXRpCfjRsuk7mgRJYFtHx0s1+LCbVixPMX8Ivf8fooGK9aFs5vOGx5U4Huw+5M3naPyPVnoNAKOtthSyQxenJjFcxUETks3lfVCap6YIU0nQkP/zmSOIHJsqXg3VAQrQx8dvNBO5kE+i3SfmMtTp8OU2zF3brCoEUmAmYzQjDaxwIKbzO11hT/qhroWeQpJyQsl50mbQ8AkgKv/hQ/h+TmIGb8QFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1WKGvk1Jum7T7szdapwM0FlIV9qetx7gNwQ2B6UWNk=;
 b=UQWej937IikSw3bJFgNxDL3HYpM928jrdSB3wfTMzVCE6iWeZRwkL3EevH6D0TWeydUri3qyH4T2B/xiFB1HkENLMYuSKKz7pPjHilSrDpST9qGREjVGGJGTzyl3+idoWHn0LhUkqf3PJ3bO9rzADrm2NjtcQBs6P9wjyQHGfdPaEEW1ygfmPil0ZWsylQ1SLovMcbHI907bPcL16u2fgXOM2m69hM6Bf17YNuKCHGpYAghoS++S84DWOtF3KFpX0D/xfvxFM1F3tsQZvwFNsJRCPi1wg7S02HkDLcd2XYiwdulhsNMIPv5C3h5JtT+OVA2axr3AsBsvqYR82iKmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1WKGvk1Jum7T7szdapwM0FlIV9qetx7gNwQ2B6UWNk=;
 b=jGZN1mQj8M2eWhlAUyI3iWc6vblfC1kgBzIloe6Jdqm4HCCSQldzY1Anx7/oCum41x4Mf1mkhcSUlqn54+eBGfREysTk/kBF653XHaEbv3ZclqQKKj8WfOLgwmtI9HUZ97by68ys0qLmIk4y7cexW8SPoo+sCJ9sCZhzPJjSyJY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB8020.namprd04.prod.outlook.com (2603:10b6:610:f4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Thu, 10 Nov 2022 10:47:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 10:47:06 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 02/16] ufs: core: Probe for ext_iid support
Thread-Topic: [PATCH v4 02/16] ufs: core: Probe for ext_iid support
Thread-Index: AQHY9HOQpOqayFOFs0emAApStvxcaq43+dAQ
Date:   Thu, 10 Nov 2022 10:47:06 +0000
Message-ID: <DM6PR04MB6575B9D5236BA9CE7FA70B30FC019@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <94a483673c3c7e03d8897fffd6e6145027979517.1668022680.git.quic_asutoshd@quicinc.com>
In-Reply-To: <94a483673c3c7e03d8897fffd6e6145027979517.1668022680.git.quic_asutoshd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB8020:EE_
x-ms-office365-filtering-correlation-id: f0bc4245-5529-4df0-1580-08dac308e909
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgYvA30MMwQGs89X4KhY6b78uIi11TZxkROxaE+8BqTnjO3nWt1OvC3EzPR01jyJMXXeZXejxK5J31Mf3xgF9Frzd2w218Wt4FExXLcijYF3dXXnlsbEgXs1NscC/7JzCJ4YtQxH72ZjBChyUfgX9SDPGiUrMaSuFG3/i64K0RU69QLktOCFhHRVDu6pBQjieadvYRYmrOXe2xWIxzyP7/OyoyRPDb7XdpopTEP8gxabNQmt2ZYMyb78nz05dRDwN9eIPdE/ylTJmksLTYmzbltJdQ9jj/Q2nOHDtrpEPA52BWT78l4+gzoGAgrMX7LjVIKfYp44PnjOFxQhP/yKdLwTig2ovD03z+6MxLuy4WoZnGbxpRz5VZuCpIUKyde8T2zGC+FhmAGHbdLD1RgE0WR9ZSx/U98olim9HNHQoxrl8z2OaDmI0IP1vdopox1arRSOrXOLZ+aUd5QllmDu4sZRiO/81+A/e1mF+NjiihFV48AJW8tI3Hn0N85qCxydWDSMCQFnxwWwIz/mtMnqwMOs9BFB0gouFG96jWZXOBOyqr8mxAhV8YPqLBFlE4W5duHdRJbqBmpcSryw+6sessjm8fNHWtMlF4i+CKNX1PsNix8WbERzJ3nuk9JvM7H/vbWTTsZ5epYqthDmIUv+AFG8Y7SJWltwtv2nI/NUqarIFW71HMsGKVN0KK+ewsTM/CzgjCN6LpnbXs1uZQDZ5LVZuyPIktTBFeRZcRBqCQDb9ErLde49+rbOfjZZ5m0XkHkHUY8s1nKmCedh6gJbVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(55016003)(83380400001)(8936002)(41300700001)(7416002)(5660300002)(38070700005)(4744005)(66476007)(66556008)(71200400001)(64756008)(478600001)(52536014)(76116006)(2906002)(66446008)(86362001)(33656002)(8676002)(7696005)(186003)(54906003)(316002)(4326008)(110136005)(6506007)(66946007)(82960400001)(26005)(9686003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j5AIm0jNacgRRAJEhzjNzlXpWxe7o6SCql03ULL+LgPY8R1jBPQA9v0xI6xm?=
 =?us-ascii?Q?DAM2GSzFw5dmwUCFV5NzuNUATR7dwQsrKuMj6G3o5g44yPRVFXeB+ywuEI61?=
 =?us-ascii?Q?D0Sh356o1A5XL9nbPOaCCSWeXh7OHZAf23Ml6XcZdoRLzqVvzCWlATFZtAsB?=
 =?us-ascii?Q?nXf/4d+EmcxZjR/piHaKPG2NkQBg4reY5/8ecEh0ZIcdDqRMviZSqXz8boMj?=
 =?us-ascii?Q?kOVe7ZJh7sWeI24ScTKJDGQweEH9XbeIaOjuSYyupUp8LybK2Q6QnJky81sd?=
 =?us-ascii?Q?b1ZVUHXCNJ5RCHtcnR5MrsstIN5pvEPGqRLaqd/uZ+eMCRYMbq1cPN81owwz?=
 =?us-ascii?Q?h8KKsaKA3u5TXxzoSDOC938nFUhi53i9NEBtrI0pkOtnHy6oW7c316pGnXga?=
 =?us-ascii?Q?oANrG7pU9iudOdSlnf8S9Q4S2tBrI7KyaZOCtiYMdT3/WwhzOtN+0lkIUI5X?=
 =?us-ascii?Q?E7m1qqkxtxF3smStRA/0kmd8JGFgkURvNkDmW/n35FUKPEkEb7r/GZ/9d+Ew?=
 =?us-ascii?Q?uylTl6CxFfk6U/kOKbNk6lgPs5qfsVkynVbwpoZO90GtQLym4k9jpt47f3Fa?=
 =?us-ascii?Q?IjsWggVUUeHaQBkYkeG6ANCajGXx6f+Nk9krxyA9Fgfolmr0K+agAFUuKPsg?=
 =?us-ascii?Q?78M5qvR7YiFrSpkLSAKfYwcw1BLy4mFPaE8wqYr5tXXrkxI1bGGpyMvG79ba?=
 =?us-ascii?Q?+EnXyhJp/cmD354+NuUJsYL51E7EAw03nMvE000WjxQwQlRrFErqGOu83xgP?=
 =?us-ascii?Q?sJbP6qCRd+ShoRpRmc4BddQ/qt4XAxIvsmuKDezAFu3HRQMBgra5DYfEGl7k?=
 =?us-ascii?Q?dPPgm0LybiBCCcZLxx3rd2ukCBpY6YhHlXVmuDDRYh3bY9HVm+tS/wwtP5KP?=
 =?us-ascii?Q?uYYNpI4C1W5caTvVuF9tK+XnyZvkxmKSofiM4Q+p/us2EajhZ5bxJA77OWhm?=
 =?us-ascii?Q?PzokLh+brQ/+etHcZ6KEAecEvcYwHuKlD8Qz0xV5oXdnECWAmv3PzMnKXpMk?=
 =?us-ascii?Q?2jr6GksoW4Xbb3q236pd7LIg5adCBYkcONRRT46r6/SJiDGI0TvW7dHewHs5?=
 =?us-ascii?Q?iywa+jCOq3RBMU1OYGkl+arEsi5PQthdkrN8hPFMxVxjpzzu0uHlNsyCjhpt?=
 =?us-ascii?Q?/w1WUqH4QDBNijbKaLo5/TRsnRVS3lAGOuYe7+AWKIezgoqz/dfGyQwKA1k5?=
 =?us-ascii?Q?lpZX1/gAbhAK/dhDwtJeOUyiPpoyxY8LAmL8M7bkw1FGjjrg/SS7t1Jspdtk?=
 =?us-ascii?Q?6F3StUcVN6mUgXO+T+eZSwJ9P2W5UPupiWuXauWGHPXn+8WwSV9/Ss7EHGFc?=
 =?us-ascii?Q?a5WSigc1S29L5ctYTzwKuW3X48DqWx7+aju2Z76E8R7p/bNO5zHgXNLbIisf?=
 =?us-ascii?Q?FZ1l8cLKAIqWWKG2ADWNLtiV/uO7+Kr7CBNAvNFKWTGJjoUF3m2LoC3kp9xp?=
 =?us-ascii?Q?ZRWwN9/DvEZo5qcNnHhqoCH4FTbSTR3uNfR02/skV014vAev3JPCKv0oeYYs?=
 =?us-ascii?Q?/YJnbDMQfS2ruaGtp19zTb1Gj/aMNcECiPGz7l7xlPetpTyjJ5qwfV/GLvdQ?=
 =?us-ascii?Q?I3nlphRNvugiwP0iWE6ZLWCzojfIQbfd/vEZiCGx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bc4245-5529-4df0-1580-08dac308e909
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 10:47:06.2719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsUl6JiDH3tjvTxiDW1bCsSPAmFw1egKYomOJ/kbzWjiu792Hq6TEwnn6eyn9NhhK/bQgvOJAi3Gt3Y4pZfVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8020
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Task Tag is limited to 8 bits and this restricts the number of active IOs=
 to 255.
> In Multi-circular queue mode, this may not be enough.
> The specification provides EXT_IID which can be used to increase the numb=
er of
> IOs if the UFS device and UFSHC support it.
> This patch adds support to probe for ext_iid support in ufs device and UF=
SHC.
>=20
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
