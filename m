Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7360F061
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiJ0GgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiJ0Gf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:35:56 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCFC96219;
        Wed, 26 Oct 2022 23:35:54 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R2Qg8J008168;
        Thu, 27 Oct 2022 06:35:28 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3kfagp99bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 06:35:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFKH3QzizXbFNj/8L/bMolUo4dmPNN72gxTD4v547yjjxbXPmCPrpB27tVSSf97Ctb9ACGrJ3d80OJwgAciTVhAYu6aN2ISfM6T/fqAxGrLmPT6O35GmMV3hG31uQz7jOvjtmoMQ++sDFqL8AS9RDNbns9C47H+mzDxpOYTQBwd2tR3ljQgS/EPTlqfg4IXlXlW5jDkFHbDKOeg94Pds192VPG8Za2S+r8dOLNyEcCDxvjV/qfRshh48OEvObC2IqDQSqRg/P02//SL9qNISQ+eI8iZAOWXy5lmvNH9cM6UoixscD9ugTHzPrKstvBCZSDMFO2jf4UFkCyYXmheatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAeW8cXaktWlm4dmfORdE34mGfQglStXMJd/p7A4Hkw=;
 b=TM8UIugI0GOd2PSBxENvwxLTk2IBbIUr8ttZT8SjJapyADSVp2BEYNNFrdhiR4rb9i7uEYHFTfCiId/GducmyBRc909VGpvGxlRjxATbjJcyurMTgI2x5Zoqj8CClcTjxmv3WJmvnKjZsA9u7fIQEAady9vsTAF5btDwpdt3jBOGPGHzc7trnukZldMRdL0TP2jqlr2C2kyG5KtwVkZl9VzQHLMP/3+FxJnoDznJk8HOLrYkaM5jA14KWuWxJbYsNp5X8bVqr3AnO2bky34E4fs+Ywj8z+QoEigAOWaOoDTem2tjW40ONBh/jOgCbsURe2XH/hPDM+ZF04XkteWbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAeW8cXaktWlm4dmfORdE34mGfQglStXMJd/p7A4Hkw=;
 b=Ic3hMugLIi6SS4ITMGDz9RZAB0XE/m+0xe8G+LcgeQt/HXMNORh+Utadp2rcL0FOm5Qx4H0CvaqpS0Owf8mdS5yFS61itLkKHOUJhf+2O1QCTCSLQqLg449+K+d65Nd4P/rf14MkB7+Bomd2UgLa+6keddsnbH16tUxtdWr0l9ltrrdGMzV5dTP6llUWhzM16z5rwL6lOwn1Y6hIKzmIb3Cskh+ELOj1ue7ON84fleKTXMgbekkda/XwabI9mZLEiH1bblGN31IhncMxz8nkToUTcFxOMW8SUKW7y1VL4mm3FeIDpZH8TTiGtXzkQVe1IloORb4lKaxocbz7jeJQtQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PR3PR03MB6668.eurprd03.prod.outlook.com (2603:10a6:102:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 06:35:25 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::551e:e1bc:b684:b7bb]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::551e:e1bc:b684:b7bb%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 06:35:25 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Rob Herring <robh@kernel.org>
CC:     "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: Document common device controller
 bindings
Thread-Topic: [PATCH v5 2/2] dt-bindings: Document common device controller
 bindings
Thread-Index: AQHY6WOSCqHza4Axr0GIca6rbfuD964hN1yAgACScwA=
Date:   Thu, 27 Oct 2022 06:35:25 +0000
Message-ID: <Y1omrFVw0FbC3YTc@EPUAKYIW015D>
References: <cover.1666806317.git.oleksii_moisieiev@epam.com>
 <ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com>
 <166682078099.1353934.10574272333105424439.robh@kernel.org>
In-Reply-To: <166682078099.1353934.10574272333105424439.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PR3PR03MB6668:EE_
x-ms-office365-filtering-correlation-id: 9572d184-c7c2-4e3e-ba8a-08dab7e56e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KiZFwePh5HAq12mjYmNTF6+jVNhU6ofXOXA1f/UmNdBpIw9D+rofJ/gb1aIZY5WX7AM/52y+Of6JpowAIag3rjn4ioCTsMDRh9F9rs0+58QQwut9LTrphr7mr8pKhVm32NmAz5JWbsTaaiDv1Km1gLcc0ogJ3MVI1djV/UneVTSFbrY3AvayE6Ff/tbmXVXNB3SpUtPznRAI/Q+SdIt2eATm5Oh45av7hta1mZNRo9br9occ3mEo25eR7Fe8qUAxPbVupWjE73VhtkPXPGY+W9jwSVkgv7+U3fskG1+mjj6yQkJRKuHId70gMfAK+Si8aVEhIU/l0x9UFp/fQlF9AngrceHNVK9tkcW8asPA9BD1G81eH07sPFml3kcysNxddqMHkmE9b7h1nehX+wrv81BUsa36wGrj054/Zngq0iy/Z42cEwWiPY6gfmbFquJRHqH9GxlTnKXdKEBKn8wCxFnC0G8HCwmlXInH/WzDIYHZxzplAOzHX/8eBySsyFDC8NlFzSmGrlyrjCv07K5o/Qx9i4ZhYge8J5SgQyF6o23GzqdsWwhUW8hfXikR4vstaBfiuFbg48G1/8L7a1TbueRJlmsf2bT7Wsh4g8gq5+JAaW15VQsebreqXlPmsyrJjzcfF9gX3/BGILwuH78NEbVIJzzVZn8bSuVNIu5jZWJwbTe6gw44sd3NZd42bxHn+l8SIj2m7C+v8fxnU/K07ndMoYRxIil5S9SfPOxLq9kbpe+6oDUIiFyM8vhKHnhNmdx9HmfwLrJpMlPEnKrDVA0e8te/jwveDHbgD5C4RHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(83380400001)(38070700005)(86362001)(5660300002)(38100700002)(122000001)(66556008)(66476007)(91956017)(966005)(4326008)(7416002)(2906002)(41300700001)(64756008)(33716001)(76116006)(9686003)(26005)(6512007)(478600001)(6506007)(186003)(8936002)(8676002)(6916009)(54906003)(316002)(66446008)(66946007)(71200400001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bAJsEehA577htcjNL+x6pwswEMYOR8xM7V9M+pp/JBZnXBp44HdX7J+g44aM?=
 =?us-ascii?Q?djXA0i9z35/yC0pUqR8FskB0v8sey3yaGJ0quwJDnZEfj+8kHwmMtU3DuntF?=
 =?us-ascii?Q?nR0jvOv2lgMrLSOTpk6wPsrDQyOp1pNmiN/6isRDreLkyGRBM9/rRyPiHPqG?=
 =?us-ascii?Q?Co9FsLvLu9o1iCkyTZWDKilJDHzTIdb6y01J7KXc5yiyxlJls3w9OPzx/wP2?=
 =?us-ascii?Q?p3w3vkWikiIebptDXZ+kvGrUTSrCOTvO04pLUzzV3b9C436skJgizLPdhONj?=
 =?us-ascii?Q?8J5jiLWa4ABeYdQnrQVeOLYwFLRyOUgABRreI3Z2E0/qUgzyd7dqcg9uNYcF?=
 =?us-ascii?Q?xVpIMD72Vy4BgQOc3yDfU6qIaB/p8BWVB05wCtapFMPKnWlXryNl0b47W41l?=
 =?us-ascii?Q?DslU3MOl1bAIw6YG+SeJZbGOEx7yB2Ytcvbf0uZfF0pJ83q54P/8zQxnDmRd?=
 =?us-ascii?Q?gr68xKMmcOa0urMd+OEYLoLygK+69NxShhKbPlK/r6bLViYCTI/w7kv8j7c7?=
 =?us-ascii?Q?FORgdfIVm1f5UTzmTFMSf85QWfdI6hLtPJOtC+w78rh4PFR407vL30c9u22R?=
 =?us-ascii?Q?DjZwMZNtuI/g/2F4IctmsGK59laFp2GZMOojNk14G+UwAYnV4Zfeqlap/vY0?=
 =?us-ascii?Q?6iAJ572F4XktsILNwoy/bBg9FZAOCj2p12PHUYqetx+G3/ZzWdzlzZl+JmL3?=
 =?us-ascii?Q?traT35PumA0bFNvdmWTMkGn7j2GXkJLMjhTaHuvMMffWHScTJ5guuz76dCfS?=
 =?us-ascii?Q?GNHSQGsGZjGTf4ueaKQhOiWINKrVraIXYCZKtAo3doXMKH+TE1k36M4zs5Eq?=
 =?us-ascii?Q?Bz/FellA/JJYkSGsQFVvKYk3dTFFiH0MXnVMRN63iXNn7GPrqVsCyJeCZrVD?=
 =?us-ascii?Q?pA2VMEEX6XpT9x88CjYAcH7fkT85bCLdMioN9OM6G/I4HuZg8p4nM338xLrG?=
 =?us-ascii?Q?8HCvi3bOUul7/yZRF2T2Tevfa84W/S7biyUoVGACva9WO9FevbPN3u3iIeb/?=
 =?us-ascii?Q?OlaDKv7ko1Y1+6rt4ExxuFI4cAUWunDZa+m4pCHpCKzGaVT3H/Pv2BiXXekw?=
 =?us-ascii?Q?1hzzLAgrYACbeBBrOKvPPaGAWkwCSaDpTNT9JiNMXJ30j7YA3dCANfYU33gh?=
 =?us-ascii?Q?EKR36xz2KLffeDo2XAV2yNmpjap7n2JFFHq1CMjRcgywa4ivrYilCrFjX+m/?=
 =?us-ascii?Q?XCI5uoLpCT5FQW41tfIhr5jDABB4y59VZzHKcMSoG5fKOLGh5594AvuDU5Gu?=
 =?us-ascii?Q?jqCBvEgVgNy2tvS30hXxihg/dinHZN3Qu09TmdqW+lDNkAuriHGRtREgOq3M?=
 =?us-ascii?Q?p4nGk0KEECbTxBR3/ejZ+r7BQlfNr6GmsZAU4bVOxm6m8Rjif/2xZCiYxZdA?=
 =?us-ascii?Q?ERf3z6ChHQlfvVRQb6St+bRQoCAHjA5Fpid7cYghzvGdFUJ7y3Cub8+L+kFa?=
 =?us-ascii?Q?lOo94z6Ndeg/Mjdj6/tEEPicgArHVgdyR/zAGPxM3WahIUvK5FLcf2npnyG7?=
 =?us-ascii?Q?kwdj5dfWFsZJgnH4o8PwsxKmonB4Q5gn2txRjFmCSTD2LLaY+1LuUKIvs528?=
 =?us-ascii?Q?onfcnTU7ewCA9QilhKKWQ5oPj0aNO+flT8rAGXddj7Lx+C5T72rBjuzIwwyk?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4427EB563154243992F5E5F8A10A16D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9572d184-c7c2-4e3e-ba8a-08dab7e56e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:35:25.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2w08iZ+NcqEbScv9gEUp87IE7Rk3lp10Pdm0XcxAe3rN8dbVStXBWyFWyg4p7OtX56RA/es8ozZIW/9L1RZY6PXAXUa3jujwIZSvh4gXUu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6668
X-Proofpoint-ORIG-GUID: 7D4gQdjqKUrTGUcd6Er2-Hz13oROCxms
X-Proofpoint-GUID: 7D4gQdjqKUrTGUcd6Er2-Hz13oROCxms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_02,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=909 spamscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 04:51:15PM -0500, Rob Herring wrote:
> On Wed, 26 Oct 2022 17:51:27 +0000, Oleksii Moisieiev wrote:
> > Introducing of the common device controller bindings for the controller
> > provider and consumer devices. Those bindings are intended to allow
> > divided system on chip into muliple domains, that can be used to
> > configure hardware permissions.
> >=20
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> >  .../feature-domain-controller.yaml            | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/feature-domains/f=
eature-domain-controller.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/f=
eature-domains/feature-domain-controller.example.dtb: foo@0: feature-domain=
-names: ['default', 'unbind'] is too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicet=
ree/bindings/feature-domains/feature-domain-controller.yaml
>=20
> doc reference errors (make refcheckdocs):
>=20
>=20
> See https://urldefense.com/v3/__https://patchwork.ozlabs.org/project/devi=
cetree-bindings/patch/ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.g=
it.oleksii_moisieiev@epam.com/__;!!GF_29dbcQIUBPA!y6dnIrQEa4gr2RDYPf2_Oc7Js=
KHJrAKtl69xg0Jlf-Qri5BP9kBzqIknprWXaikX5y2Yz_UWCW5yYv_9Hw$  [patchwork[.]oz=
labs[.]org]
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.
>=20

Hello,

Thank you for the response. I would recheck and resubmit patch series if th=
ere
will be no additional comments.

Best regards,
Oleksii.=
