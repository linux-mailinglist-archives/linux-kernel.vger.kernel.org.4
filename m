Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5146B02C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCHJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCHJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:23:49 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6C9DE33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:23:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNRaanoVExvRanTbyJ/Cxq7MEde3yupT8ulPLCc5RraxIYECmlAHsX7u/8rTOCvrJ+8gY6u36rUtr+3+KnSgCXsFOiUr/gTZrBKHD57Wv3SgKAFHZ7pUq2qFpnb9IUvV/ek0+OnWZM66NCBVM0PGwxvL1Mys7RwT0KDxPiX1XcwOT3XB/T6c5r0ljZHkQtzccRluY68uRqKbITUUKV9reAnzw38APu7VLVjLe1akV8pmf15tFWyDWxjgkr56GQrs0xpuBslP1RD16sBzT8Hfd6ZiYgJHctJkQyBVSzMD1M/n07qIOoB+VNWCcfBiAFLX0YhJ2N7MUjbpGQZFKZQBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UbsdVcNmDdsgcOd+IbSlF8EjrZdSTAvg5Toz1yqB08=;
 b=aBg9fGWmbrkyklGaDshjrBc4JD0QPG9zaQgRQpoGJPvWgnIXjDyWuBWF4/7YkEo2VSl+DlsvuX2ANI+HJIGm8l+pIgS/McwIAKP1lIx3hxb6ogEPLHiEDW7xUOlVQ68Tu5F2S37+hkcsp5DzYbhHuUAxzsl+sM4oGe6czvI6ClVM5uK8btf6TMsJYQrxr3m+58dn9js5PPRMLBS/gWZbBizOxOyCLox9M3KBWuOMdOH1YE14JLl4oyZcQuFFeSY9FTXVqIT6PKNsi5wQNEFYJ2fqUzwkNftgTI1GUYDHihF8lL6CSPxgvzkeHA/550vho9B3+JZNgEARRSNlThjCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UbsdVcNmDdsgcOd+IbSlF8EjrZdSTAvg5Toz1yqB08=;
 b=EC+T5ZyJHKcqE95rguwDHNp6GTPHgjfaHgKSd0QhxkpAbfI//4beyNWSEohd0UCirqAPwGSNKuyan1+bhs5OmqwxOnlvKN0zDYOJYxkrsDspg8sJLpAQhijdmpXjKUjaAzIT9vxivZ/Ni7ApbQK/z6IlT81i6kAeQLxAuTmQR3w=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYWPR01MB10887.jpnprd01.prod.outlook.com (2603:1096:400:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 09:23:36 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 09:23:36 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 2/3] mfd: da9062: Remove IRQ requirement
Thread-Topic: [PATCH V3 2/3] mfd: da9062: Remove IRQ requirement
Thread-Index: AQHZUOB4QHwnnBTBd02nARr+gUsGAa7wnK5Q
Date:   Wed, 8 Mar 2023 09:23:36 +0000
Message-ID: <OS3PR01MB8460DA642D8701606C19B285C2B49@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230307101813.77267-1-cniedermaier@dh-electronics.com>
 <20230307101813.77267-2-cniedermaier@dh-electronics.com>
In-Reply-To: <20230307101813.77267-2-cniedermaier@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYWPR01MB10887:EE_
x-ms-office365-filtering-correlation-id: 4cf091cc-f174-487e-12f5-08db1fb6cbac
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPJ/k1NfZys8An/U21RYJkr7V7vUWwHDF/wlcSQRuWLdPZDpDvL7YbSwNTMXULxu8nyy0ID+Y3NDeBQrqcPwPbdfyRbDf642oPPpFvclDoaVn9Qd2hxSYNw4ZZJEusIj4m62fGHYa2c19+3VqRupEwwA4O+Ee5XqTBy0BtTWMoTBXqIRleS8c3HWY1JVdXSo+vyhINij8y9njxFvs8+TPZwqF5kftnGk3BJo5n7PHxN8UZhZC5S4tLWjxYB37Cca6gLbBprygptr7/vYlVSfY0gKr9oln9e1B0RIPAp0On0/kq4jr5KExXExhr58kgyuAKh0KoY44fRfsN2I8rg3WW7Bzp5MFzvNdDAkTm1SQpwUobnPamhEXCiRjPTzn6g0048dU2BcjDOOpUefRGo8ZMWR9Zjzru6Dinsk9zIVNcfPdmPZm0kJVuKF2OrUT4NpUg4jQ+Y3yKy4x7I9dK2puzFIpv6QBqSRH7lPNSOqAI50HRC7JfqLHN6zFbUTetUgs0FX4MnCHT4DTbcX+6p6Uy6S85JE+w6WwuibL++Pw4gtzz/Vli/27ckV8mA5AFlRGUolWlQ1nvyo+LuFpM//GRF4iWyJAwsIv0q5/q1bTR+0jAVjrMjcLjvVVgpHycfqxo5akS45F/wvtR0wLaQ5Ve/+uhGEL4U3H1KW1fnIoa+v6hbZSNkN26li3B49g8G+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(26005)(6506007)(53546011)(33656002)(38070700005)(86362001)(122000001)(558084003)(186003)(38100700002)(9686003)(55016003)(66946007)(64756008)(66476007)(66446008)(41300700001)(76116006)(4326008)(8676002)(66556008)(2906002)(52536014)(8936002)(7416002)(5660300002)(71200400001)(7696005)(478600001)(110136005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EskQTUn/39H7/7hOpCqLkUoz4h6xzThzaeui97LIcpUj2bliW9ZJa4hJXnqy?=
 =?us-ascii?Q?6iT80dyE25kubkdTjOSapo2hKFP8npy6hpGWlvjWBac/dpyUGKeW1RyR/qcX?=
 =?us-ascii?Q?ZGoxkqgZHM4/CfJ03pkbkz9IFwfXuLv8SBHjdE7cFRrjG71+29VWUCLIgJJM?=
 =?us-ascii?Q?xARYV88uHZYcHwPRg7nP96idneXqpMT5trYz7jnpXvE2/swQq/RBTHNT7D+F?=
 =?us-ascii?Q?zlIO65k69Dw93D6K7fUfSq2ZZOb69LxFka6e1msN3n3VzhEaI2zPtOxNGSjA?=
 =?us-ascii?Q?8g0qo4yKjJ+xpoicEem5QFpiT/qdSnOcsjsVIVcRlDm+EAtvVehTovyDmQFg?=
 =?us-ascii?Q?ELzGiKNng7GbuQkuZctJX3SLLSqDuSBpc8oX94o9F4bLdBxPmGvt/jDcsyJ6?=
 =?us-ascii?Q?V5g91cICE5U49wOWLUvP9m0LW99o3tE6QmHm1zhAF037iaY9xs26Tvkc2Oe7?=
 =?us-ascii?Q?z+owBoN900p9SnHnKqbSviOP2WRIgoNLnAjjf/wH+MsehzSgad/oozQhFFIF?=
 =?us-ascii?Q?xlqWg8kXQs32cyCDlVd74NLHmUIl/3uqHbGMiPsQ/yATP+k3Uys0zY8OkFj/?=
 =?us-ascii?Q?VXW/+CEy7phIC6sQpbzYemE8636XopCcmrhnlwVZmep7ND0eEbtP2zVvJC+v?=
 =?us-ascii?Q?WD2wIkNQTnOCmJVQUWV81ap8sbGnkt6O6tX2aJoRrmEM2zcTXycx/dn8ZELD?=
 =?us-ascii?Q?J0LUnbj+NBrEkkc22HfBgjKifBWjgrP1pJ962ve7FlJm0WErtp/ugKuLK+qC?=
 =?us-ascii?Q?d25GZn/nT8QTNcAEPLiWwsMyeYlKdBiz/okR4zLfnAg3hKB6DByLPQ0MEWhK?=
 =?us-ascii?Q?XQ5nINTdbLNegyfdYN8MwAhPGg7A74Q0+TO3NEEDHvXPs/3oZ0V2I4Fxsvkj?=
 =?us-ascii?Q?dKs/R/WpAowfsUQ6SvyoV/2zwdhbAXXAPFnJsCn3c/L+RN72KppYv3+7i9bJ?=
 =?us-ascii?Q?yzcYsX3mDz2gIuL+8s2/NuGddCmgs7orGIKWg5SGTeYxkzFAdAztIv50/4Or?=
 =?us-ascii?Q?TKvCpqmYrn73p+0MbaGdv0nojyRSoGQBhHRRH6ym5+ZYvG/hpcQwpPIDhRQN?=
 =?us-ascii?Q?4d1v8VL89vh1dA6H1wXLAi2gGgOHBXFx5UDVutaIaU7cKUU+mQW3cEiOItIX?=
 =?us-ascii?Q?pWbuP/j24lXPb84V1zFWkLj3Ih7Gh34HTML68Fn3CorduMqXZrzkN6E8jEsL?=
 =?us-ascii?Q?HglhgZyaKWELEysYFwQhtyqMcTHfglD1gxoULn1etcqdOwa2mOKfGYcsgxEm?=
 =?us-ascii?Q?zTdE5Qq2XZOUwhtvMEREhj2yQJZXMik0+E+OIspM+oSkvemr7kLs6mLqm05T?=
 =?us-ascii?Q?LYgOBl94D//ZjaKGpzWalCoUw6TlqHE3GOeJhszUVY5KYqGk0rnRuaDNMCrI?=
 =?us-ascii?Q?6MfWtULTtKc2unv9xLMoT7GFAbnbUdmmqOOPrA/19G0FPZ/b+Y115rWqdftV?=
 =?us-ascii?Q?I5UGeTQADG2e4c5RfaD7SkOnl9pEW3uYaMT3MLux7+r80Oa6yQxVDEohnNcm?=
 =?us-ascii?Q?nBOaRO5ePxK2gmXvwhgVGB3hkggxBGI6+JmDNBv5EHWeWzuTqaLXn6lHmcX4?=
 =?us-ascii?Q?SHsUB+aD+Dfzdu4WVxZoF0uhhRA9gAecZxnn760YPebZR866J5pAP5pBM3bQ?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf091cc-f174-487e-12f5-08db1fb6cbac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 09:23:36.4305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhCKPZ078/BDjLzR4u3qTPeiFzjsxCeKFbTLCctg/KibfH4ahSIbevomunnqgIEx80tqS8cpsvLtQ2WTX11m48w0+AB99fs/oaCqIQrrSso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10887
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 10:18, Christoph Niedermaier wrote:
>This patch removes the requirement for an IRQ, because for the core functi=
onality IRQ isn't needed. So this makes the DA9061/62 chip usable for desig=
ns which haven't connected the IRQ pin.
>
>Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

