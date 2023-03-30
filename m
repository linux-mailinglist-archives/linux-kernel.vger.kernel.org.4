Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A346CFBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjC3Gga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC3Gg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:36:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8045240;
        Wed, 29 Mar 2023 23:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680158186; x=1711694186;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/8n7+BpcPGHdnlADI+gg/U86XZetpfrxzyto9b7z7tU=;
  b=hWFO5XlsKpULCC/09ZvCA6WN3xXtlbbAimuqPEmzb7Ob608Ps2vKY2kg
   jy+1OIDLsvKweLuyPjryXaYtu6R1sR24wXXCXQckZLWnTR7E3J0mXhVUb
   HQeHJWq4ZFXR9KMQ87N+iosMbOG8g5benONOZFTcvxZAjR0c4E6uIeU2G
   b1foTFUoEoaH2VAdcRn3/zHnfgVM3Xx9ZVeFm/Z5WqxRns0Jgro9Hjo0U
   Zn4G7b55o1WKPYtEm9M2RRWz9VGGl6AjK+XGFMSutVUWtw9/8v+qed14p
   G7Db73sD+ab5zASe/RrdK3573zAuIH4uDKVYD46BXFzNpDhC9E0O+j6+J
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="225140536"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 14:36:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEtIlfctw7S6RhnuL6SAWxK2k2ND5VKeBgyymtZgBuh6XLRO6VgspxQ9CXeMSMgX9hsKr6knmSjie3q7ZFq1U8vByDXAoPzfuKZTphJXdwfVJEJ9D0g5/wPJbh9Ar/Jcko+ls63Z1NKkLXYQHdGsrLLHzwoRG5nC8C5F8S2UY624EhtleY+CzAgj1muIzdm43yd+DU2qEmjB8AwIMWrM/wblzNyZ8yLovLAzSQoTxo1bwOBE0YSjr/8hcW07YmIp8ocQsyrUjxQntK/VwSm2v/i2EHcbQQotE9RBIdWSp+yHGO81tdot1GIiJCrqKPXfqAkqcmWkKXj5Pi47xGPAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8n7+BpcPGHdnlADI+gg/U86XZetpfrxzyto9b7z7tU=;
 b=YBz4vhUQgBaMTTBJ1U4oeh1lf7oXjuFRedlrXRJ5Xe5/lp/a+KIav1y1Ns0PqcT3Zz9J7GpntEOLUALCpPvTASWDB4lDU9NZfh/N+HWIs5fmwnjuXr3SoLOlfy0kmjPLeZ7mpkY0NUc5bYV4JZrFUvGIcFKapL34dYRSycnCzKl/ZUSpjh2YA57cxwM358vk9ZD48fCqm1BqTlhz6FlkDebGhXt2qMRtMo12CEuCpym1jCKI5hK/GmQ+8FHpzlL47szvruiUvp1syzIOcSBoPumefGfN4CjAfeExGz8n7cyJFdrspiA6Ok7MFUyX27YJuqrZ2L6QNm+dlaevQsgh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8n7+BpcPGHdnlADI+gg/U86XZetpfrxzyto9b7z7tU=;
 b=VXQO2x0w2paHFVOl60dbjfcoLS3eOnVpk8SQ2G1/tkT6Ac2JWTL0gL/qsYdWvvMmF0w0M05eS9TFMfg9yZc1l118EB6AB8LuaeSBGRUdvRpQv7zRCaZM6uaV0nm+xjVTyym6QuaR26C1ptI+M8fNwOlK0nnZWlSYBtqBlUbQwY0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA2PR04MB7514.namprd04.prod.outlook.com (2603:10b6:806:135::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Thu, 30 Mar 2023 06:36:23 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5ae5:f53c:812b:5ff1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5ae5:f53c:812b:5ff1%7]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 06:36:23 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: RE: [PATCH v1] scsi: core: Cleanup struct ufs_saved_pwr_info
Thread-Topic: [PATCH v1] scsi: core: Cleanup struct ufs_saved_pwr_info
Thread-Index: AQHZYqcXWM6l4gkT/0GFvWsIJ7dT/68S3mdw
Date:   Thu, 30 Mar 2023 06:36:23 +0000
Message-ID: <DM6PR04MB65757C7B846CB4F17A12033DFC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230330012918.13748-1-stanley.chu@mediatek.com>
In-Reply-To: <20230330012918.13748-1-stanley.chu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA2PR04MB7514:EE_
x-ms-office365-filtering-correlation-id: 43474f0c-56de-4cad-65a1-08db30e914be
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecEWA3GHEWTyrE0DXolFTQLX5YwJ8lpqdOsuLimimOaSD5KHdnpxP0PyW4ELys8skPcBiQqwxqS9qonXdv2Rmv7H1Jbxs914Ib8evPvynWaH7zzDziYyxOIybgxYAFbTYvWqcweqssPS3Rpz2N5dAL4ic9cTpucLU3cDe3RYJGJltYSJ9voIrdkygGO7qmLnpo2wezJvxQtX7+3w6NK7jMiLDVfT3pGzf0wJuRVe469lwrU6GgNlh1zslBz1NFrlwuOubwkWzjYaWCjwMDwYk5nTRreheIul8zzyO+x+tTut6z7LM+mJChOk6bmFmp21jXz5qPg9Kno3/igB7o8d3kndMsWKt00Zo9ERTGFgrM+zf24be9Fpp/EYs4MjJa651aiCRHBE5MFfC8xgk8WQQDPL6uYlB5RNLQU/jxKCFMK5hhqw3+W+CZqpkNaXKX9MXOa6+4LbX2jrdDDo4FTOS7siEsmg+DRgGPr2vx56FpZ6vUDiil5aedlS1uo4gBTpoBOLa/qKJA0cTrhUb0cTWwvxXed4EHe0gbNb++tosHA+XAsZy7vq2NKHq1tce4QBWGLFWAh0uthIY982mb42D5oC0E+gLENr3fv4QP4XBKNppslN0qstJxkM5PJsgPD7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(66556008)(122000001)(26005)(82960400001)(186003)(38100700002)(5660300002)(8936002)(33656002)(2906002)(76116006)(558084003)(66946007)(478600001)(316002)(110136005)(7696005)(71200400001)(55016003)(86362001)(41300700001)(52536014)(9686003)(6506007)(8676002)(64756008)(66476007)(66446008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imOoz5qpkOf/NuxTUyZC9o/BRzLNZItEvXeATGlI2UM0jwNsOAHYixvIOtOt?=
 =?us-ascii?Q?Q9Q4wkchNcw5bhaBG5DY9kyzkIXyUxUVXFj0hGaM68ktQEuRFH0eWCq9hqOo?=
 =?us-ascii?Q?dqYOTj+mGllSBkcALAQvIKeaWDoTZhQeqamAZ2wkOVpWfK2T6IiyCSPrs7HY?=
 =?us-ascii?Q?OEAN9z2fPoEcPpdnTM07u0BgncQg6Vzvje26IFnkL+3Oh2z77ldVfIMJVdf4?=
 =?us-ascii?Q?Z90/jNOkk+dRkoCbxrtzjG4LquP9JeUsT9ORZ6ESCC61cNUtAZ0yBrCOKmY9?=
 =?us-ascii?Q?qO20oUwQHzGUat1qDbQPaZvCHV7QxglyTsHCe53a5o2xAfpV1oA2lKXtMxQD?=
 =?us-ascii?Q?A9KYZ7OkghExE2taCB0Dxdo3V2XTtUFCURhkSM7vs6SVS07zo0l6q7FQrnP6?=
 =?us-ascii?Q?DE40g7t+r0oBCXnatBeyJhWNO5RzhLhM9T8Enp1c+lPyW3clNRkn4Id/edGE?=
 =?us-ascii?Q?Rxo1wjMwh0hfZ0DF5cp3CGGeG/GEf+vE85CN8kisOWBn4AHjVEIWzGeSECBr?=
 =?us-ascii?Q?kBMJV91Y33QVB6OtkFeiy/YJyEQWN9OMZogpiO8vieOyjRDH7y3l5qHVOsGh?=
 =?us-ascii?Q?R8sdKfz3XRsKcUgCsKTYeQSNMTwaFR3rQzUjnFHFvwYv5wlnM+6Y6F+UiI94?=
 =?us-ascii?Q?bmbvofjevVvdibLnIRhKQ7oGvGdbjxCnmGwgeOahhEY40u1L8BpL2rNWtTOX?=
 =?us-ascii?Q?8HN416SUAmoe4Qei33ICeOS3FYFeL1sIpriKlPkgb9EgBcgsnQrMV5JE/FQ8?=
 =?us-ascii?Q?waiTwsb4ttZpo55Im6Y9MNCWnGrXGHiEFHofYP+NJJYG0FY/6o7/jKOukC51?=
 =?us-ascii?Q?t3IiAZm622Ij0QNyWdIaT/BSwfn/IidXjVwbyQGVncofNGBPKQgOJXxp5kwr?=
 =?us-ascii?Q?stjTX34a07Bxr1RDgw+c1uQjNXIqlS0vDfV/6smGEAgSCpiGidBOzlO2+lBW?=
 =?us-ascii?Q?DUfqDM5O0q/aMFOI7zrnfqEyPPM2Vg8z0W62ydYMspOUtMbIFpzTQA3Bj/Fm?=
 =?us-ascii?Q?N1TvgQds2LrfcVKDAda5fPaKOOtC12G66E3jLHXQ+xA6i93siczJl7dmYGM3?=
 =?us-ascii?Q?9cnLm2mq51jvzJHZfv5+KAhm4G2DAV0LSWjFG+XO449wHz+jT2Oc/evqorBo?=
 =?us-ascii?Q?4hY7OTVKdSJQOns5qMYJ62q/WwmwT+NYJfLSWo2McRZO7DrmGvnm31R+bR6R?=
 =?us-ascii?Q?Ai49NNLtLKo2uZK8RRuhPJPJju4+PeG7HZ/0xX2L7joKpfHaekj46akZlhzo?=
 =?us-ascii?Q?2Az13MFQakBpRY/E5y3I47id2G8vbq6tSuXYGx4QzQsXM9Koszf4y71+zZKi?=
 =?us-ascii?Q?OyLPqCiXI2uvRdn0rGq6q1Wt4JSUJ71r/lOSHp4N0MO3rQ3TrZP1yHfV7YxR?=
 =?us-ascii?Q?FSwLyzBmARR+3OWYvKv2c/NAxjMZM4PV2crSWEZRF4AeVr8xEA9l9qMsxKZm?=
 =?us-ascii?Q?DNAaUvLBgdx8oJxk8oluVlcM21SDkcvU+E62UZHD9OjvojSyUBAdVV5vkiWx?=
 =?us-ascii?Q?d6rVXVbG8OTa9lEKJvgJLFeEHK0Y3Ljow+VdU0bm620D5nUkPObbPQvtZjG3?=
 =?us-ascii?Q?tYFwZS4sgDjPSAEWsgl7d3PBW7SKdF6H/y8RbrUq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?o1eESt3zOLgwuS3yt8HTVmq/pls9h3kCkLvwOLmxz3yVHgrMVTxUWpSa20UR?=
 =?us-ascii?Q?uQqAl0w0Srbml78qvUlpLjlbe7u/7zQ27QLz8xThUaauSx+X76oRkoSnVrtU?=
 =?us-ascii?Q?19umaxxyayixUEy5Qtc5kpoIADS+l9rjO0/QitxrMYhKwxCGE53beMjd0KIQ?=
 =?us-ascii?Q?QJIT1v2i/ZOy8e1UMerK/b8qYooN4iCt9YzjUltslRWDtwIYbAhg6yDnLhFw?=
 =?us-ascii?Q?6xCPtM83qqiMYnmA963ZNcidgrpfJS/8D4wD0pviXHuuibDAwLHpNHmPVcm8?=
 =?us-ascii?Q?EjhJSP8SPGea41krwL6k6+dvE1nb6C82dcoKKwi92shpgJMlwLs2prD/xIp7?=
 =?us-ascii?Q?69vnKivXAVoui97ODpPFhXFJuDU4uLQxriYMSgMTo6KKJx8omvAQU4BUKkYo?=
 =?us-ascii?Q?D2SE6oBFzS99j5Rbrecjk96mQLOGA+WSRWS6jg6zt7XcaNaY0xQK4bt1Q0VM?=
 =?us-ascii?Q?xWR5J/O07usCBp/VUQINxxkk7zq3FSIfxzAJP7oIKcS1CwYyyH17AXJZt68X?=
 =?us-ascii?Q?eVfgp3AaYUTM/OVMP+vKqTz4XIUSq030oIdC9DQuXdX28aww7y5plDDt2r+e?=
 =?us-ascii?Q?PEaQxqwyh04U8YiFMACS2NjezzlgkJbnpRmqnr/tw6sQRA9e6MmYorUMM2Ln?=
 =?us-ascii?Q?bUwlC+9YJz8kw9MiUn1QXQBunCFBwGREPrpeMRPNG6BvMu0SUPYOg8P3d6Z9?=
 =?us-ascii?Q?qphqfJEkaWGyiFdXez+ag9+qxF0DmpTUur2hMN7prFYg47NQVYQfEueNO4gJ?=
 =?us-ascii?Q?CGVfeHMeHAhLq4doqAgwHG6T6mfxs8/KdS9JakWeDaxKqIW5Z7YLcQegGF7Y?=
 =?us-ascii?Q?0bLa0LAjNqrmeCPkT+l9DVgKgQEsbhvGUnBuJoMg+rBB0nHVG+pfytFCFUVP?=
 =?us-ascii?Q?wFzRcYXXYKSwvHAl4aLyyKO0CGJHe288l5/WUvPaxnhcolYGJLoRQ+rmvak3?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43474f0c-56de-4cad-65a1-08db30e914be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 06:36:23.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4WFLswWYp3w+xxLPv+7vlE7d7Qmp7FnA3lgSNTfnoITn5Cal8UKnV30eTzLsYgjEG/hvDUPurzrESnrTQtFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7514
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> The "is_valid" field of the struct ufs_saved_pwr_info is no longer used, =
and
> this struct can be replaced by struct ufs_pa_layer_attr, without any chan=
ges
> to the functionality.
>=20
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
