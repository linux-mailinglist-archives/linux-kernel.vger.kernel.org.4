Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A810D6D8EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDFFmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDFFmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:42:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70E6A65;
        Wed,  5 Apr 2023 22:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL5H4Eln5PUQ24luDM7BTdeRjUSKh8ixdzZpRMR75Qi9vfVyyB/QiaZ/+rmRJnw+eYvL4ZB2ZlSGiPALyu0HQPtwc5hobQRl/PfWmsJEUU24VSLG5fcRtbf6+CkzTmtYJ7JtdrNOqw1BZltGs/UlhOC1Qe7krkl9cqaB6rTEPj5V4aL4DRG0cRibCmN9mF7lPNd6u8b+sbbphY84XCmZ5YmQdV7rubqmjIUqXApNC/y4OwzEgzncZKmFPCNusTATs5aa1Pto0DaJVC8emullpgVo6B9LGtdH+y0xBQzOOS89h1xOrCPcBFmLxDIsYI/jg/9wzRjyqdx7C/5D8bqdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6r+0CCOR254Jzhyxnnk59OR7PMlP8G3vDcJtx6ELCU=;
 b=lVtpfQv1f3W5rXlN1GH2w9wurY+AwuovjOQdWMtTumkYrlIXKl5k/eg7EdCfphGyosph4i7P1t2N2SSUeqvSjbvvgi85hFsw3tQX6/bQV7FZU1Ddp9qiG+ap4Anb6wOGrMgFPXFnlgB24lTAcsdIxrpIOnMeI+8jplPB116W+6hdrCf0BXC9OuFUnEDulql6+BmTQkesowWXKBArWsNH7kTy3P8RXW6oLiUHDtm+QIfntn2na726XIiMqCkYp7V2x8BOeM9LIUeyOPoQZJVKBI2z1NwN45pc7ts8iNrZMqTlqCa6Z+/GqSbMHAq5YQPgR/XgGhM9MegRUjL4Q4vEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6r+0CCOR254Jzhyxnnk59OR7PMlP8G3vDcJtx6ELCU=;
 b=G0tzVNtPxZmtaJm8BXAqY8X6B52kQhm8YVshdfb06qrh2KStI8DbHnnrwJCPa06rJCzdFU8TUnd/wRDyEQfb8i5AAX+Z4JrP4DxfTMEnOZzfiVVCzYK1JbIpaVUld26d4L1T/m4nO4HQWHgj0AUcCLTp8eX90OKb6n182ENLdQaJM9hjyUKbDcpA66L57IiTNS63r15P6oh+0MqgWeo0Z3Evolfl2flKhHQgNDcm6G/8Y0NZga+e2QECPD/WQxPoN3+AHjh+D1AG0ePFBuRvd6VTX+OIqxTyozHPcTQdpWGIpH3mZrjypCzu/dDtnccM+sUdv/yZ9z7P/3kLVsg2rw==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by DB8PR10MB3957.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.14; Thu, 6 Apr
 2023 05:42:51 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 05:42:50 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/9] tty: n_gsm: add open_error counter to gsm_mux
Thread-Topic: [PATCH 5/9] tty: n_gsm: add open_error counter to gsm_mux
Thread-Index: AQHZZ5p2LcMicqjphEaUZsIcVH5ES68dxgrA
Date:   Thu, 6 Apr 2023 05:42:50 +0000
Message-ID: <AS4PR10MB58956955D236587153FDDA47E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-5-daniel.starke@siemens.com>
 <ffacb4a7-7875-445d-a2ab-38c4e595e3bc@linux.intel.com>
In-Reply-To: <ffacb4a7-7875-445d-a2ab-38c4e595e3bc@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T05:42:49Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=6c2b7a3a-6d88-4abd-9dcb-e006abc17ea0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|DB8PR10MB3957:EE_
x-ms-office365-filtering-correlation-id: 5656857f-8962-44c4-dd2e-08db3661c2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmZQ/dDWiSbSAIoUPAWDvyWFJ3swj7adkMr+tvzYxYbEM+YYWkrBfl9/lrhJRIEYoV1nvpkfKT6g6xir/WaJGShBf6a81KUZfv6VaxpTcqIM335RmsC5kOMeTpoRb4FluSAK4KYDh4d/BAsNLvEqR9nXcsOxC31eY6fm2M7KaF1+oXEilcYzkI+VireeqRcRZj16ksHN4hTeW81MsmisOHoraQiHFANxn9AztN6kDkDFLMpF7GWaJ8m737YI64hobDF26EBDT/4AWYXOuwOk+P+7fYyV7pes/0wKw3qGazD7HpWw2v9T8jiwJgxrW1n0iyrwAtT+alMyGsNqT7JSlMouW3z62uKvtNszgntKdWjfYawTjLbZSLmJn0OIaOwP9JSRImZMjAEgb78ZshwUSSc0Tg0KbxgElKgyoft6B4ruSJqe/piq7SC+w/a07dyv4VQh+geJP2skBTTt+l9LTweArfvcmRC97FkSzjkxrm40rwiYRldY7yHpY5v1icYQGWBxBF7na0pxSZDGr3zsko/mFeQ3P5CkSygui4qezMCKmRbhx8ORGXWkvYz373cOmh5I2lSPyNSGJqPX6RE3hGBuXEuyNsBs5U0sP+Dx4RvDaBny3wp18YP4pvVRD7QX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(2906002)(83380400001)(4744005)(5660300002)(52536014)(8936002)(82960400001)(41300700001)(122000001)(9686003)(38100700002)(186003)(8676002)(4326008)(6916009)(64756008)(66476007)(66946007)(66446008)(76116006)(66556008)(6506007)(7696005)(33656002)(26005)(38070700005)(55016003)(316002)(54906003)(478600001)(86362001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hB2VFdgsSH7H14VjYG/aDfCRu5KNPY/5xec5gLl6naSMrU2k7khjCJRGyI?=
 =?iso-8859-1?Q?IxAJpO9TsNVYwYlKtIPdrkRrNN7iUwFql4czYmodaajKOEdHZIMatOYmjh?=
 =?iso-8859-1?Q?tRptNTXbBNspfeiaeqI5VQLGr9iRwXm7gnRiQXGEurGoi8fB7IAQZ2GCjm?=
 =?iso-8859-1?Q?JxgMDcvE7RIQ4IU3DLp32rwHNiP/+fI7feHB4zQYQkNO+igrPlmUvkKMbR?=
 =?iso-8859-1?Q?hAZj/Unz4OLxLEsGU17O31NKJRjs313xfoh76dtapE7nT9owgN8yKfLc/M?=
 =?iso-8859-1?Q?IFjRgZNLp0RFJ6AXcFvUFQ18OcWqVfQ+EiV4O/bW2nyJWZr7NqmlYXRArm?=
 =?iso-8859-1?Q?KSlyQQQ59Mw5t21O2Yr64dpsVcy9mtpY2U5kiekrVQ6Sz3jra0X3UWnGqo?=
 =?iso-8859-1?Q?hdWxyHZuhoSuZhppzJTUDw0UViVscv1q93i2HEMwjEvAoR0rq06hUA3DBv?=
 =?iso-8859-1?Q?TzSmsV9c3tJcCS7HrlkseVhSgAjwkwepS/CaO7C0POssHndixqvdU5Rrqz?=
 =?iso-8859-1?Q?aeoVXPUmmLiehCYcGkzzH2FEPPNHGwGm7PxJajfpkapGfItwGd5g6/MhGZ?=
 =?iso-8859-1?Q?LytcVQ4hatWa0jTSE90aJdijaVPCPqVf8mf98xCtonE7U1nhh2MjXydPaJ?=
 =?iso-8859-1?Q?/BH0YJuEx8V/7XOs7VbGa+8fiMpSkit5uASNS/6rU2J4kcQ38kJc4YB5JG?=
 =?iso-8859-1?Q?8J8CvgO5/lyW5TN/wZ+ZtqMc4mekXuQfyBZEz1Lk5pVbbG++yam4t2D/cU?=
 =?iso-8859-1?Q?ALjeQe3XSodaRMVvpYeYKdgJvoLp2FVnX+Et9flsT1Ppq5YX2wFO+czzkU?=
 =?iso-8859-1?Q?zUXHl2l8wTZV7vnw1mbLhLtsDyid/lgXV+huMZ6sVf1auCvY3TR54QPHdo?=
 =?iso-8859-1?Q?ajanT0xu4QyyhXWPc+PRGIcyS55Zz1sroOoNg8g2gP6LIPSOyGSVpM1wZu?=
 =?iso-8859-1?Q?QBHEGM5JzuwlBXi8aJk6woiTgtJGXrqyvWtGxT2+4+sBATqpWnTFb41OGj?=
 =?iso-8859-1?Q?yIIP8ZFdq1/yIyIsYhBso0suaAsEDR1BmWmrOO2jv0HrC+oJYbUsrlo6P1?=
 =?iso-8859-1?Q?W4l7l25Ydf7dErWgWZTLx0NoMPC/ZXpjjsiEPXwleDIVtIaI14otY0LT1n?=
 =?iso-8859-1?Q?BvllsNPQgv9ixReAXQTSm/LbZOLzXrnyPVEYLKrBuQ2FLjWKdz+l4uLHgZ?=
 =?iso-8859-1?Q?Ic/wBlqdToGq+1zHqJUHZOxZGnEjqzoat9cgMJvx4uXWeDdIsSZ+FonUPt?=
 =?iso-8859-1?Q?5ysyNzPi51Me2+xpyv9VbnWZR5A+1B7rkfWdODj7P+ZhVEB/RC9JINpffE?=
 =?iso-8859-1?Q?s3EYUL5/BZ+K+vcZAB5mxic1lWhyRr4NfKdnEeqZ+02UtO2oB6OnSzPbF8?=
 =?iso-8859-1?Q?Xc78NQGLVSt6ycKmfzXamPK1mYT02nKj3Fe4if24pG4vKIrihF1Hv67Nmy?=
 =?iso-8859-1?Q?U9y6MQp9k806wN+fpBRRg8P5QzYiY1v2l77ZrkK7VJEDohBQGNOU4zB5L5?=
 =?iso-8859-1?Q?imzKl1oo8U5jVSPUO+SiGV/B+wK8h75kHyImcXjXDsFppYKFu0WiE0Yptd?=
 =?iso-8859-1?Q?RF5+lR4LDbJ+KxinfzbS7xH290vUnGxbLkHYFF30ONTs6lANHP5/D6EsS9?=
 =?iso-8859-1?Q?E/qfhApOugfiYuvYYzoujr8m5aBIf+IOu2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5656857f-8962-44c4-dd2e-08db3661c2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:42:50.8506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOkLW3w+Qax3vAhs5IsBiggd2+/w6qcW2j2RIyRc08weKhOnQq6yXuv9qktXmwUr/6HAU0YMaBsLglClKeZd3//vllkIB4J5Js97DnEzzf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3957
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -1767,6 +1775,7 @@ static void gsm_control_negotiation(struct gsm_mu=
x *gsm, unsigned int cr,
> >  	} else {
> >  		if (debug & DBG_ERRORS)
> >  			pr_info("%s PN in invalid state\n", __func__);
> > +		gsm->open_error++;
> >  	}
>=20
> I'd use the "rollback" pattern here for all these and goto open_failed;
> + do the open_error increment there only once.

True, that would be a more elegant way to handle this. However, it does
more than just adding this counter. Therefore, I would prefer to do this
in a later cleanup.

...
> In general, the changelog could be more verbose about state machine=20
> states, message names which imply that the error is happening during=20
> "opening" phase/state.

I will add a more detailed description.

Best regards,
Daniel Starke
