Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7F60D2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiJYRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiJYRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:53:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25A8B2EB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR1h3zKSDDZqpEd6MLvXdGG5ilf4QkYl0OxBTCibj5SUuV5HsYmO7q3d+t4sCZQ2QgdsXPfRQIJD9w2GiI3oSBIe//wSHzwjtO7x6rkKvPHD4WWq1E324cRJipXWSQ6PAV4yxxxok0Cl4jjU/VGcTZKCtgRL9rWm247jKxqWaUU6CKmpUW1x/IkCVJYexrvIJ+TIFk+shtXVOH8dsKG/NZcmLb0pJbXiI/eXdc/IPcfUrf05eDT3IeqeHa9iZawnA9dAxXpXKIT/j0OdgQIm5LMrMJjnQ1e3x8g1Mb03U0Df6IfWmVRklbbAZ5VxokoSXR7vsru3+P7qDaRabmpVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fh5zFyFmpH4BDrIbsRVlzgjvQX6YC0+yJvoZmoGYlY=;
 b=oeeUr8Oc5GvPOCNzgRR29e/TAwu3a2ueyzbFbtFwLSC4oNDULd8TqM3icWfSTXQf+Z24jYtzfepoxXcXir0pPxCugJErdTkItHUeveoYEXPSHk1Lx9KzrFNJHRhIEbyjEmgPAX2zdHFlmkWaLYnECrkaQLAvf3o32TJsCi6lt7cQ+TeMBGaeddfzb3vhq75gBYCo3UgjswLo3OV9vSSujQUFETX4UMfCPZQeBMabzToZQv5SNvvdSid7fbD7iJqvDMgP0lbyRzDvKlQhfBXKdB53pb5Wgjwt0XuRZnpEAQMDDN5FqeCDOjI9O7qpxLknzd6MdbXRh4+H20xeW2fYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nathanm.com; dmarc=pass action=none header.from=nathanm.com;
 dkim=pass header.d=nathanm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nathanm.onmicrosoft.com; s=selector2-nathanm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fh5zFyFmpH4BDrIbsRVlzgjvQX6YC0+yJvoZmoGYlY=;
 b=cmDoI0Hj41cIKfOSRk2Pl8Gpcr/fT5BfwmCQ8QaFfIc6wYi1/hzywsQ+EJXX1GXgBPf12F9jl2ueurg1NckVzgCmSi0lMmi+2TLSL4IjN1WCr2n2kh7BPyX2pvONoanKrbtji/HJS7WHYqwWXdere46+jg4tN35Zg8fhygb3eaI=
Received: from BYAPR06MB5573.namprd06.prod.outlook.com (2603:10b6:a03:a8::18)
 by SN4PR0601MB8673.namprd06.prod.outlook.com (2603:10b6:806:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 17:53:49 +0000
Received: from BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497]) by BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 17:53:49 +0000
From:   Nathan Moinvaziri <nathan@nathanm.com>
To:     Andy Shevchenko <andy@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
Thread-Topic: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering
 if chars match
Thread-Index: AdjoEtBynXV7SUtxSVy5+tznV2O0qAANQzQAAAIz3AAAElDFQA==
Date:   Tue, 25 Oct 2022 17:53:49 +0000
Message-ID: <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <Y1embP5sEp/NPxK0@smile.fi.intel.com>
In-Reply-To: <Y1embP5sEp/NPxK0@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nathanm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB5573:EE_|SN4PR0601MB8673:EE_
x-ms-office365-filtering-correlation-id: fb0745eb-28c5-4429-abf7-08dab6b1dee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOWXCzHjiRFXXQt8qwoSThWd+2kuiE+Ri6RaYSddOC8291R03Jg7ADG0TzM/gyDr7/bGrNcat3/BSTq07CN5Lo1Z/YQzNViUSqxvbqgmZ/E5fevNMTegpzphTjj+OfJY/yF8XIKosaMXSfXLi6KrEuEkigp+/8/g8ofbUL+2JFvgRDWgG9p84/cp4tb/YQ3PlbEK7h80YrCLQmJaBc/RrKRymCqU5WaSwkYqWgxG5AmhP1V8kJAWb0B1I0XiobEeWhHAvhJx6PhI0GSjiC2ols8bleFc1ndC3iwLLiJQ94idbvApsG4VR5ViXclL1YbBgO9vezjuEZX9zyeSuvIiGJDI43gpYyTDENBoGXqnoI7IscNIlDfSpWr7IxYNXp1KDCDokbSKkTrojSi603XCcUvHtOFQLGW7q5Qw6JV4aNIQx4McQ2paPvk6nC8VoxoJu7yX3j914ASk8hA0w9V+hySo+euWdTM4IiCM233B/HsPKuJkz6adgMb2ZlSdlPSE8FQ3Xn4Lz4MiYlAOXFhuyLcR92Sjl61Li5jDK9KHAuRWTALhXG4CMHL1ye/DQGtLustu0KaDL7SB8bjrx82f/wflP3mdld1Ey9jwHjdJ+N+ZZdHRHsgY4nsRDup/WZ3NEdGs+NBmURSogAPCaSQSNe/EBaJZKWsKhxmt7l5ZjvawV3e8LW8/rIB88BlssRXmNS20VBtHhjnqXu9cprOdd+8vabl2v3LvWl4uLrfKQn3ZkbFrUUx7c8YucS0shtVO8jUHNLSoSvFU48Sx8K3sP3so351rGEaf87rddc/IN7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB5573.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39830400003)(366004)(396003)(346002)(451199015)(86362001)(33656002)(38070700005)(38100700002)(122000001)(186003)(55016003)(2906002)(53546011)(478600001)(26005)(6506007)(9686003)(83380400001)(7696005)(966005)(52536014)(66946007)(316002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(6916009)(41300700001)(8936002)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fspMc8Bdwy9gNIIBsWUVB3/d/BtUSxeYIqLeERvs/CN9HgTNL2c4YdKIVG+/?=
 =?us-ascii?Q?aqlbi+q4C+d3+JlriTfQm+DcYI/vn/pYQSmBnNNtlXFSlgkAMpzYNUj1znkz?=
 =?us-ascii?Q?J0sAjMOWkusPznjMOj9XyL5vKd590WBxxwiAJI07WbO0aEqddtc+t2gPVgNb?=
 =?us-ascii?Q?bOqCjpfEGP+QpJU3MErvMM2YzMotuPj8dzDYCF7afPjl+WHdrbEXkaaUaViP?=
 =?us-ascii?Q?B5yjHr+Y0+3xjUoZm6+p1UMER7xEaBLZyotkScQS7qSTosu4gP+1P2AFx6EV?=
 =?us-ascii?Q?ieIoEfYfCtXSB6Bm5Sf2OVXYYscJn3bUvQGaQPZr8AvR7eyDxFkaw6xIUycq?=
 =?us-ascii?Q?OPcAFoBu4WgQn1IhJ4J2bHIOjls3RF1l/rBAockY6k9+Pb/Aw87VxW9y3iek?=
 =?us-ascii?Q?gNK2mdclvKW2HFq2oaFUd4xw1a2FdOmvj+0n3etJycPHEDRAbzpvtBix9+UU?=
 =?us-ascii?Q?Pc7qDk3Op+jZggehucSf/L6Hp5xkzEMWw8H/4yGSTafPgQ02+EHX1Xy3ZMlp?=
 =?us-ascii?Q?Sq0QekfSvOF7lAra7zZRfyiUyAj77Rt0qtBFIl9yexnOlC31oH971qcIhYaE?=
 =?us-ascii?Q?jHSEGj7t/scYUDOiyr4hYMOh+OSFJVsF3ZfpIE9mx/fbA/xeeOlHbhVdT5/V?=
 =?us-ascii?Q?lcRT2kidka1z897CMXRVf6WGFFINuz2E9tIdOTBuv7ppKiebzUk/zORO+8KY?=
 =?us-ascii?Q?P44IPZVHGgSMPpWDxyamep0O5LA1ZjtH75wXLiHhm8ctrPwfSlXING1jSvRH?=
 =?us-ascii?Q?Brs1yudVOncU9NWH5uCKUaZyxZsvVOpphG9sGA8NgBNMyq3NFWbVjK3gZFB5?=
 =?us-ascii?Q?wMybvXauRum405EJNUnD80ICrhBEdPDyn7kVHv/LbmlIRCFankrS9PTJAd/n?=
 =?us-ascii?Q?tBPlGJaP6bLZLX1ccfxGlDrdR+wmPV4gnm5EzDsUlZWX4TrqPq0UfuE+UMdJ?=
 =?us-ascii?Q?ZW7JzTTh4j0oEieaUmbDak94rtKn8s2W2HNNovuftyWg4XBcuh2Q33sscU8y?=
 =?us-ascii?Q?tGw28PoN8HEDNf2bVrwZcQOuoFkQhSnsVwLhrKU5hP2/judrMkr7O0nAaoUt?=
 =?us-ascii?Q?Jlo6/s3BAiNh8/m20q95e1xJ/1LZpE6xmjdywVaccZX4m637JTQR0rzdLEbL?=
 =?us-ascii?Q?IZj6DyyUnQ1cI0p9SyaZylxiFdzd9EyhJiEh5aKvcA5Fh4pyBUBFHlRGsAI7?=
 =?us-ascii?Q?mh6IhEcR1z2kBjHcXzjWCGw6IOdsRAb3v+Fxi1LzTpI2c0oghVbP5tviMJDf?=
 =?us-ascii?Q?HR27AwUBl1iNukUdPQGlUe1J+p+w9pf1k2aYMk5IS+aOFDdnz8vCdu49vTrU?=
 =?us-ascii?Q?XATtJqI8XzrTB1vESjSy+TQHs907rrU5muiiW74B11qjKlkJOVS3U/2pmd2p?=
 =?us-ascii?Q?oH00SiFWNRdCAWqhrwdkdzUhB/OCgVMCF30eOKh3LUZvYxe2NGXr4voLz29K?=
 =?us-ascii?Q?nJ6nPdQ5TuC1dRtELMF7svzpwgQr0Ay8Yfu9/Q5CGs38peGFHaajxHDytNvw?=
 =?us-ascii?Q?O5u1lR6xwApTVgKtQCuFj3nubgis16kBTcg0hLZqtVdrRcrAGZ+rEUXkBwG1?=
 =?us-ascii?Q?7oH0IgAvCP6dNvVl+T4hq1Sc3UrMbPHcjc8KQ+u4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nathanm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB5573.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0745eb-28c5-4429-abf7-08dab6b1dee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:53:49.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e74266a-92ff-414a-9879-2149aecc5932
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbRU6BdIt/p0gL8UXlegP1sPaX9KBOgkYV0QGbD39lg7jfxQFN3ORhOB1Oa88CuaDY5bSZy/VyoD1QZYr2DPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0601MB8673
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I appreciate your quick feedback!

I have done as you suggested and published my results this time using Googl=
e benchmark:
https://github.com/nmoinvaz/strcasecmp

After you review it, and if you still think the patch is worthwhile then I =
can fix the other problems you mentioned for the original patch. If you thi=
nk it is not worth it, then I understand.=20

Thanks again,
Nathan

-----Original Message-----
From: Andy Shevchenko <andy@kernel.org>=20
Sent: Tuesday, October 25, 2022 2:04 AM
To: Nathan Moinvaziri <nathan@nathanm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering=
 if chars match

On Tue, Oct 25, 2022 at 11:00:36AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 25, 2022 at 4:46 AM Nathan Moinvaziri <nathan@nathanm.com> wr=
ote:

...

> > When running tests using Quick Benchmark with two matching 256=20
> > character strings these changes result in anywhere between ~6-9x speed =
improvement.
> >
> > * We use unsigned char instead of int similar to strncasecmp.
> > * We only subtract c1 - c2 when they are not equal.

...

> You tell us that this is more preformant, but have not provided the=20
> numbers. Can we see those, please?

So, I have read carefully and see the reference to some QuickBenchmark I ha=
ve no idea about. What I meant here is to have numbers provided by an (open
source) tool (maybe even in-kernel test case) that anybody can test on thei=
r machines. You also missed details about how you run, what the data set ha=
s been used, etc.

> Note, that you basically trash CPU cache lines when characters are not=20
> equal, and before doing that you have a branching. I'm unsure that=20
> your way is more performant than the original one.

--
With Best Regards,
Andy Shevchenko


