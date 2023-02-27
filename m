Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9C6A4B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjB0Tod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjB0ToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:44:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2098.outbound.protection.outlook.com [40.107.20.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374211CF60
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:44:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx5lM/HxCs7Hs4yHcmxmGS/IKmhsZBUsG0K3oiClN7hRNTppI7X9bTaJUObd6j20Qg9iPt3ziXKcQlROWeO3+h15JV+5gqkmsKnctgDdSfoN/icCJ68+aDVnWwqpvnwcZb2SlO6IV5zIxTtOj2Ymwm11c5UBVYeBcFj76NsKbr3XhAyw5iMi9cUmk4VLJtjhZY+NxRXM7Ad+Iwka2Sd23yfiCziOaIc4Mr2PwSxOdSeNq4TXK2EWelK6v/AXVR5hIDloFBoMCItatB9b/Dg09YQkvnciURe3ranYAOXF6Xf1MWRNIeDiEecI4im5Q9OxoT3QUATsLs6aBdxX06uwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsNnwBIzokpbB1L8x0XfVBvhFom7WukvzpKU7dVU6kE=;
 b=lPM6OZMBOeO0STSUpbeWJLp6fNBja/L2T7b7bSrBL8y7hXydEtYyNACsWpMgKbTy7Cv0bqocVPvDtwtl1czM2kY/7co7nYfkr3NO/+AYn/TU0ILZ3N1G4zbGDFnKaFLlAEio7IkSX8//fhLq2F5/5hohyqpwlwdHvqNzWirXkkqpHvCzpqwdQwLJO+z3AhHKGTf3j4QeCETD5oTICon7PtZvryUny7fzModVP+NWS1AOMV4ZG9Q3ru6VNr+eHqOTazqiEjmXG1mdOkOGMxK5rzvZf5yt8prcvxMpBgjnwGvi75bPsCy1Fmq8pGf7osNgMlsgBkP4KxC+1PCZ6T7Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsNnwBIzokpbB1L8x0XfVBvhFom7WukvzpKU7dVU6kE=;
 b=HclzRRMGiz/BDqbCtBZgEfQRS5IOT8W/v7EaD5AGRdUX8fH0h4KqDCockj35nqcU1ugOQBQEImTe9+qrUk+lBvJB7LF5PxQ/SCrdYELPe6b/U6+7D0J0cPzUM/dPS5csE3Km6Z7WwCBhsfXLyJxG+fVw6W6ta3wg1vGV/y9XMt4=
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com (2603:10a6:208:15a::12)
 by PA4PR02MB6717.eurprd02.prod.outlook.com (2603:10a6:102:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:44:05 +0000
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e]) by AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e%5]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:44:05 +0000
From:   Paul Geurts <paul.geurts@prodrive-technologies.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] b53: Add BCM53134 support
Thread-Topic: [PATCH 0/4] b53: Add BCM53134 support
Thread-Index: AQHZDjG+H0UDImx/yECM+X7OgEjnYq7jqq1w
Date:   Mon, 27 Feb 2023 19:44:05 +0000
Message-ID: <AM0PR02MB5524E582C130FB7BCC627F6DBDAF9@AM0PR02MB5524.eurprd02.prod.outlook.com>
References: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20221212135640.3590545-1-paul.geurts@prodrive-technologies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5524:EE_|PA4PR02MB6717:EE_
x-ms-office365-filtering-correlation-id: aa703ffd-8769-4bd4-94bd-08db18fafbf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vv67cNJBoQjiCchLbNHQhu2UOYEJ34EYCoR7Fmg71Iut/9XehiSFf7KYSv2pKsiih+lyHfVXEyJGCTLa3t3NB+DKdmCqKo1HHnBWsn1XvqYzk17jCIIQj9QX20FQc1me3lpEU3i09LZ+ulSKCZOdLt+gH8Kk4KYj0jIZJGCradUJK+a3xgAhc/kaQ0Ql/lgjgQTBCv33EgLta7HWniWh0YgISeGYAy0HlbwHNcX7BdW+VE9c0wm4gkmrvsGLQAUAsKPNMJD+UQL1WUSLtSvfJ4TCCbNboUQ1ztBWeeHJMc947LMNfqXyC0ENzNGyhAfflddDGQqeIQBS4/d5hBNkH5t0GaBGOzV45TeDSowu4qsYyNRnkztDXNuZ61ZkHC2W0891a0QJC54xKEYOnGmCqquqs5Km1bqY0HFmF3DxSB9VPlATONdISPPxcXr+z02wljmMInXNOhDiSnFu9Kj4LoB7q/h5uSDb4A7JkNgtuVLpSQH1DxUHVEJ6qxVzbX7PHsv+nsFKJHzNFV+5fQj5vf2wwGF4e4XjSgfS4fB9xvkmI2AYtF2OeBJYLab6KZjhOgJhlep9h3NzOBSl/Sq0nFLLiJ5Ob0cMgwe0fghLac1jUvk061ta27Hmg6t38PVyBqzJMWAbdD8q+Ke3YLLHa80u+OXC5nuFbL8hlRciyTnQ+yUVO+dY2A06Gqc2tbdGK4C0bxqW9IOIyULCm74J2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5524.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39850400004)(376002)(396003)(451199018)(71200400001)(9686003)(186003)(26005)(6506007)(478600001)(38070700005)(83380400001)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(66946007)(66476007)(66556008)(6916009)(64756008)(76116006)(66446008)(8676002)(44832011)(2906002)(8936002)(52536014)(4744005)(5660300002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7WE9P7xNQurrbjSykBZTqw3Eg6ALYo0fco/FDicwvHZ13BMeySeOedtNB6Gj?=
 =?us-ascii?Q?X+GLTcxGSGwxys02Qi9VL7cIlepBEwrERjtzW+Tsk3fBqs42UrlFw2Wo7JU6?=
 =?us-ascii?Q?F6xWQPs90LLUzMycRIl35NZXF3BLjraVm3GwKXjFy+OjusBKcfUbdC1aTiF/?=
 =?us-ascii?Q?G7Zzayf97twIaXAPSNcm2YK8JVj10/1VTGDVntAi4bM/lGdD8o+OfrevqTUx?=
 =?us-ascii?Q?Erv2Rtw9uG1bq9DHWc9BocrB4XUjTf7CWNRux/EiYwlz4e+Vn+yBST1S2l5U?=
 =?us-ascii?Q?AVpls+VyMgAtaDtzvECudOdxQHcLdy72SJv2WP1k0mR66F34kwRMA8AbVkoG?=
 =?us-ascii?Q?gNEnIJcwVuYwHtCXx1V1/nZe6OHJgH+BRZdavhT9nUj2BM2DTVGBpL8WbH+Z?=
 =?us-ascii?Q?6AqGpGRFHZ2v2wynosywvOQcDnRf3bULVt7WIhtbea9jeQPNdJYaej5Sfd/S?=
 =?us-ascii?Q?zcL2pMMYf+tWovldj7icWay8YMSIN0Lj2f/aPV8TUh3avl0ynqlc0VPkKWYY?=
 =?us-ascii?Q?uBEtw3TIL7dGZ8bjIU8Cc/t7ph/82TZcQ2ViFhTYkuydQukuJF1b/KquQmkT?=
 =?us-ascii?Q?H685nFnNPhTEd4wOpnUeiWDNdysL062j5KsFbYBo4pYeyqXjxmwnH2eexOU4?=
 =?us-ascii?Q?7l1sn175eqdIsrMMDnH9kijYcibN25i3iieaaf3/IUjlco/7VyI7AaS5UV2U?=
 =?us-ascii?Q?lT6gMkKLTBbeXjsR0+PKJen8UF5EjjPIRu7v1XjMLNAIVHQQv919JKAQcyNO?=
 =?us-ascii?Q?9GD0e6N+DZA2+ImP2eMIRKrVnLNAc3YbD4PQngiKQax8OHeHUusnaqpEg92x?=
 =?us-ascii?Q?4xzPUVsjvv2ZzcILVEAT4oK8ZVlELXpzpWIzOYYAnOJMlzjX/3kAr+7dJhZR?=
 =?us-ascii?Q?MF72wkHonwV0aq5GR4tzn9nGso1KNErAmG4g1KXBTEjanIjpq9KtpJV9E0on?=
 =?us-ascii?Q?Aw35in1/3DNSlytQ9ilwD4XCyibrqwndAnPgbMuZRMJQOMWr/OmUXE9u+h1V?=
 =?us-ascii?Q?tXRWY4TQi9Y6KaO4LYydH4rU/QnJ2yL+D7TD+CDc1spmwOWM4yhNoZfWy5XI?=
 =?us-ascii?Q?PKGx3AFbL7tS2ShKGuWWXn2CGShdJvaiqmxBbKAfSixQxKDI6NY3dyBQqfWK?=
 =?us-ascii?Q?4iLUkKthxt6HMNonCmE2OCJZAS09/zmaGFGPDL3mLCxDRd9QIEL7K8y0zKQ1?=
 =?us-ascii?Q?i1gkSjA1GXWmDWlPXjir4JiMW1SwYjrh79bzRFMcan/SmsMQcJPD4Axgszkm?=
 =?us-ascii?Q?qX70HzFxz5Qs8LCXLUQO5qDQj5a1rT4G4siLZXX9dvCv3sivnrjskb0NRnQz?=
 =?us-ascii?Q?RIvZrcQLDW9nTHueoJXq+fVDhQjY3dhMkGoo4dZd8jsVIsGvnsb4SecdxUCs?=
 =?us-ascii?Q?oBSsgpWD0BiUifpoAnX8OWbLOk4lWyIhAGEuiXNxSFi/vQ/880hgIkibAdGW?=
 =?us-ascii?Q?RGJqmXVacx+rKwgoZfMXJdnf586GR9cP/KIQgCUqP/b1zOzb+SWgiG2tk8Qs?=
 =?us-ascii?Q?7SsUCU/cHGrRCa+6+XjZ6BE0vOZpvDbcqVtE3zYUyQqsWLJX5NH9Mvuo13Bg?=
 =?us-ascii?Q?tM0R5gYQ0tYNYTV+UIwz/wFX0vN4lcZR462oNgdpuS3Bu5u9NrYEKOfPky8b?=
 =?us-ascii?Q?2cYaDyaclHK/jCFW/tu6sl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa703ffd-8769-4bd4-94bd-08db18fafbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:44:05.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RO2vG4avsjIGo/70eQh+uUuMGfuMQPGGKskjY+q1G2z3ijzKERozURSWca8Q/tN1rbUwMRD5db0EF8ki5SYFTsl5xF6z8oHaYUv3MglCAwEaPkmX1mdC1BzTlUJvtLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support for the Broadcom BCM53134 managed Ethern=
et switch device, as well as some extra additions.

The additions now only cover the MDIO interface part of the device. The
BCM53134 device is also controllable through the SPI interface, but for now=
 I don't have the hardware available to test this interface. The functional=
ity in the b53_common sources should be the same though.

Paul Geurts (4):
  net: dsa: b53: Add support for Broadcom BCM53134 managed Ethernet
    switch
  dt-bindings: net/dsa/: add brcm,bcm53134 as compatible flag
  net: dsa: b53: fail switch initialization for unsupported switch types
  net: dsa: b53: mdio: Add optional reset gpio

 .../devicetree/bindings/net/dsa/brcm,b53.yaml |  1 +
 drivers/net/dsa/b53/b53_common.c              | 26 ++++++++++++++++++-
 drivers/net/dsa/b53/b53_mdio.c                | 14 +++++++++-
 drivers/net/dsa/b53/b53_priv.h                | 12 +++++++--
 4 files changed, 49 insertions(+), 4 deletions(-)

--
2.30.2

