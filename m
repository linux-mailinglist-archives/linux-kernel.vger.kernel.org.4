Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124486B02C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCHJXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCHJXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:23:47 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3399CBE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPLadlZhAKWEm9bNB4c5S7Rl9pf8a6raHsbYc0auMXkak1h1+JecRhrcSLW/Y8eLF8zwTkQPfuPxs2A5QGOZF0ja+rlaco+Jk/CrgANBV0hBFc28wlQXUFbC9iejz+cMmy/edr3zfh7+XEBFP0tzI5+vEdkaqKxxtdWH/g+nPmpxeGN/2aSY6syBe//AqOObTymjG5+iPqMTWzzaGD68MXjrYtYpHndhjkjFi1+V56FbBudUb31cVG8EAZHoJJvYIzyzuFIFn3mBLOwhbUm4I9sMUL7SKbOx8Tj3tLPoJpqz87wc92sohSF0VBQpgOcxU0BpemhVHhd4/N2FzLxEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC+tkr0UQP5F0tCkHXurKq+Q5PRcCSQ17Ls0AtfO/1I=;
 b=PqOsIFfLVaRxN1gyHm9BA1Naf+B4tfZrLouTEiF1KZsBaXu0aeP5BwT4aJEUuK+iHnrWwErq7ezJh5krLVhCewUXczHPfx6hIp5GEyQU+zKPzTnvcEmThrSXrDHacJz9NkX5Vw5eNCZeMuApUwHZ3OrznPFAkt1VLkaAcXIICL/RU9ivUGNgDt6lBsXwJCeB5JDbDXjVa1d4w6vAMy7eFPeOka6tJnyfKQN1ece4YVTEZyEyDwcASfW4DakbSR0BYSJUavBUiyZxNjGJLcyXZGenTtvUha34YjQCgtJLFvsSLlA4TYXZzpbS1biC+0dFZRLnAL50oCtNmvXT//BKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC+tkr0UQP5F0tCkHXurKq+Q5PRcCSQ17Ls0AtfO/1I=;
 b=Xj5T39+90H79DfMfM7uzs3Wre5lbxA7V3nwI3Pbkt+r/Lgi+2HQdxEzj+oocFu75C4eBweWnwa/45z1LI2Qd7tMIMzYJukiQ6d/IeeTkhmBEk9FkEfa/mSoGdmofYxVcvdF13IsbfiHvDGP4U4fXqQxTb7kzw0epZw+Upn6m8c8=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYWPR01MB10887.jpnprd01.prod.outlook.com (2603:1096:400:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 09:23:34 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 09:23:32 +0000
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
Subject: RE: [PATCH V3 1/3] mfd: da9062: Use MFD_CELL_OF macro
Thread-Topic: [PATCH V3 1/3] mfd: da9062: Use MFD_CELL_OF macro
Thread-Index: AQHZUN5dUuIgze948EqSyn7xg19uJ67wmqnw
Date:   Wed, 8 Mar 2023 09:23:32 +0000
Message-ID: <OS3PR01MB84607239389E48E47B9E286EC2B49@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230307101813.77267-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20230307101813.77267-1-cniedermaier@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYWPR01MB10887:EE_
x-ms-office365-filtering-correlation-id: 1cd48e52-4811-4764-91ca-08db1fb6c982
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtzEGBN2Stsm5iWZEagrG2RFqCxxlOE2AwfTRMJg3GJWBaY6t5VRupC/4ZGSi7fAuj7c73kzi+wEu2uxWs/yzCJDeoyYvUtc2vfJ3R9oiOexC/E/u7OC5S0LuaTRCiL6glkRMj4TwcSpIRfZV3YGrT6I/Jw/IHSzBCwglPBfxksZhNkRPFDVtGLwwKUK1K4VI2QOXxDM3zLFZRGnbm4UBdspznA1ItQhORVh28w2vhBWinJJZSb7qrgPJUcVsy15z2OeJd+tEOx1NYuAFw3bSCCoOUPw6FK0YxFvTVdTTZkk6IeDhXzsTQDFdiWy46XQDfpQM6w1U5h75R0iINqrcCYuIZXC0ttBV2O/AfAqS+UlRDoA12y3YkF3VaJ7EEXNZRT5SlcNh6ep4Xklg2c5h5+dFxu9dTPUUtkPkHnxoUaxRH1ijJNGQBTZVRjJc2m9Xac4hUT2OJfYcrZRKoBugRvf5gnJMOxaCPnRgOK3Mjtv0EcQq4RSMbdztlphH/6PDR1HpL8aIP4j7uEQYKw2GTY1DAqPObMSNgaQGPbGXAXLZm1oiT+ZSe0Xhflle8vQEkZ0sPAbTabjdhKniJK1ppro1oVHacuRC8tV1XTYRLQpPGgpci4T2ESKRNZB/MxqaH8WW/9CbAtLNvXcvZnG7PFdeLZbeQ9U59IN9ND6UB8xEl3KFtmW4PRWbtbSVtdaFV7Q1jxV7p2dO3bPGcgLSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(26005)(6506007)(53546011)(33656002)(38070700005)(86362001)(122000001)(558084003)(186003)(38100700002)(9686003)(55016003)(66946007)(64756008)(66476007)(66446008)(41300700001)(76116006)(4326008)(8676002)(66556008)(2906002)(52536014)(8936002)(7416002)(5660300002)(71200400001)(7696005)(478600001)(110136005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ubz/dvNmdnU31zS2SpsTc5MMVFgis7KHkLkBYCs5pVvcSZOjb8vUtE2Zn7YH?=
 =?us-ascii?Q?IYmQMa+c5Dm+0gifOvyep4oJkFmzKPYRCcXYHCQJYeOAuXky2+zYchjDsqgW?=
 =?us-ascii?Q?dLvUB5+ZIOsOufR98SLqKicwJei1crGHS0yy9aMJqpddM9E52aDAlck1Pe2L?=
 =?us-ascii?Q?1gAgwGyUttkDGHYEzjnHBKhz9B7VYk9/4TOO2GYSwP2tptZAUd1tlfvicPn+?=
 =?us-ascii?Q?fIcjhB9ZMp1lRCGa0mWHIn2LURM6KZ+XnuWDuL4FD2qEOK3a/GADzAJtl9ii?=
 =?us-ascii?Q?KEbIM/o/vJaRB2rTlZhJ3xWBt1MVx+BoK7mrW8tKjjlair1wHrf5kHv5hJVt?=
 =?us-ascii?Q?03rZ6aL7TlfuJ30ZZcew5SyqR4Fy6/nNuTKSNHVGgLLa2lgteLPhZo/g6osu?=
 =?us-ascii?Q?kV0qJoqze/rVvTyc+nXK5E3YARHHSBWJr6AQNqY9sRUWF2ARU2nAWcNijdQT?=
 =?us-ascii?Q?ZWEDXGhZtZfxOu0N8bupCSqF1S1DitvGcK0PT8XAGyGfwZY2JZFKslHQgmIQ?=
 =?us-ascii?Q?wP/ECAI5T2DbO5IUwa/yXpvcgcvjaLc9+DHaQgVjuQp5VgkIoAD1LbqkxuNf?=
 =?us-ascii?Q?pl7MODpqcGIof1veelE4PmK1ukAArS07SlflI4aFlKyOECjJGE/oXbttSlTy?=
 =?us-ascii?Q?xJlrhq4iHfCyFvUp7G9VOrUVks0fE2AM1xPNxIZ99OYx/o2FBheRRSdaFkSx?=
 =?us-ascii?Q?vwv3O8PPj9L2Q9NaLXwShOY3phAOlzOCwYh/gQ2DSjZcVVsDmtBqMurfbs7q?=
 =?us-ascii?Q?po09Kv/WADylD/hHf6otBKeGNRGQ/NKdOzUq+OgasoF4vg/rjW1D4jy0Vq5X?=
 =?us-ascii?Q?QbNCQC2FSrE6LSuTgmGBh47lUfAYMH8EtxFvEzNedEynP+4Z5A6kVyOq3eoK?=
 =?us-ascii?Q?tElxONJnkhjABP1/mj7w6EFaS0280DEQhPj+ISRlTshD9pE8gC9KyBYAYRPC?=
 =?us-ascii?Q?0MSRMn4Gi7RLPKwSFI2J5rCMaaacJ3+ZctUWme/ADE5c5qdmsKhjoIbL5eSm?=
 =?us-ascii?Q?M8gqza9Gj5EwtZw8qgzdFLanZj/hLQ/cM7kJAJdDbYXDQuSsF1/AvexXAl4N?=
 =?us-ascii?Q?9jNCkrNLlIn6NowPvstCMyRc0tCM9G/IR5+W0Tn4Uv/1/iUttYopmavUFVdx?=
 =?us-ascii?Q?CZch4aw0hWmykdwDoVLdVY9t+b5kH4sQirqHH6N65+Im81PhODCNLcp2b6dl?=
 =?us-ascii?Q?ckbMLpZ35fwojcwMYMxfCpfJPOO3jBR++0Cmjtpv92FZyLVKEpvNad0uTGCi?=
 =?us-ascii?Q?s5w8PmAXUQChRStMcdsnniiIMA/+8+CKBqub1e6Mt92l3LYAQ0SxoC/b9PSj?=
 =?us-ascii?Q?v7SDwaEAGY2wxgpRYUO1tjZWO/L1IJlkkDksR7fUVH0L3JvH9h6HZ7iGhP2O?=
 =?us-ascii?Q?TjxjnwvCSQnphB4X847zgbHLIDW3h4hEO6x3YtzdNo7kpBUK/jy7JVrXFeoU?=
 =?us-ascii?Q?J6VXXn49JhxARWXi0Pa2C0theZACU9D5ay6v2k7MdMncS+hIqFkj9eiUONvX?=
 =?us-ascii?Q?4RPcYBuNS6eki8yp7hwpC+SJ6ykEBhVguNJnZ2q0W2Nkj2lGDZn9l0xuI9/T?=
 =?us-ascii?Q?d6MJGAp8HIUFRVUkSZ4zIQVd7BNpDL2wKc5O7qd8mlQQeHyZlVFqAj+FmXHH?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd48e52-4811-4764-91ca-08db1fb6c982
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 09:23:32.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VVeQxNkQmQBNA65wGWO7uIKpKAN/d3U6TgHvyyn+ytQcqyppHJVALGqb/wX1LQbAaCr0RvhStmW2WoZZbInnXoKR6Yyz/JE7k1tK990Uak=
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
>
>Use MFD_CELL_OF macro helper instead of plain struct properties, which mak=
es the code a bit shorter and to have commonly defined MFD cell attributes.
>
>Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

