Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561196E8ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjDTKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjDTKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:04:30 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A810C6;
        Thu, 20 Apr 2023 03:04:28 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K5lXhg008090;
        Thu, 20 Apr 2023 03:04:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cJaVYTFx3nQK1eGRRD2z29PNxSirSp01zJG5l9gZgPo=;
 b=YTqosB2qQlO8r/fJ3Y6TV4M3UVCPSB7R6o4vlVpBI83Vm5g6kptj56rt230X15XIjOqR
 CKSsFnNtY1u7TL+AmpdNdvlRIozOWa33omR0FfzpJbbT9HwJxv7M8Cp1SwHMM+x6XAE5
 gGRBBZwTSRBjVG8kc9EY5vclvNFbgCI8+EKKK0TkcRJ214o5wG5HjB4FgPr5s+fUDasE
 cQwcLublUhud+FphopJ8f06Bu/Hk+qwgOftTVAkjYBXWWBpo879mqVLqOO6UZFgJ9sE4
 3rKPcGboU2mXqcDINg/Lx+WdaTZ7GfYzUJT67t81WNY7BcEDD9AjJAHrsFcqDw/YzLMo 5w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3q2dncxmrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 03:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsS6BwBW8kZlVnsifUPtzxCpqUlg8dhxsi/jZ827RfjEf4jjHsa3Yw5WMgGciCnqPQi2xMUpknFIROUreAlwsq0PoJZE+ZNpjsndksXPkHgLD7BHUgeidwUr2d3uWW2UEPZRjOGJ5JPESQhvtArnszq2bc99+o7GAAbTppy9B1rSfFv6fgaVG+HCtEakbLEsSxXQSKFcwh6NNiO5XZFlcIEQj8n7wGW35z5mmYSASFy5rPJMvmys8AZnvgsphwWK6n5hC0b/nKXyM3geir1/feO7MZIi/Opl80Qe9YHOKNJw7OA94rVfdIFyM938J71jcndyrOBIEIZsiHqbg2uUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJaVYTFx3nQK1eGRRD2z29PNxSirSp01zJG5l9gZgPo=;
 b=lDurhJFIWdtHNn8+Q7uSUQYwaHSfPjDycgL3c7GmGCRC56v4n8Oykg+0Lk6KELKd1iUWfyI+1QzV4i/r+zbk1iBN3ch1yTn/SS9gIFPK8mfBHUOfWZxA/OXU/u1JGi1yvFhRVS5sEEjdTTeJYWG3Fc1kx/EwXVg6DknraM0sdsxTB2VXc4lrGo/QCRJq0iVUf7kRorEYnMedsy1MshKlpMcX5cxD8xTn5AD9pz1kKbQQAH294j3NsC6+LO2KhiyhJll5x/NTGiW6lgal6pArmPn+uy8m9ezxvvuJlllyxLFSoVwsEb0xzQm6OLHCXDWizRxpWhVl6iqzqKzgCpazOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJaVYTFx3nQK1eGRRD2z29PNxSirSp01zJG5l9gZgPo=;
 b=vV2i8cA9+7Gk3EbWEAcY4ZVz/iyyJrHJBuDzywr5Wcvx5K0yLsGUf9B/YcFhHPrToaChJPlVkR0HVjlfhuqVmOg6QtqYAI4YAvwZW23SyQwW6rR16Wbn3Rb6RnX6WoqeghfXZZV1DVt1aq9yN0xyhS5ZlK3njUXggSQ4eE/hNhk=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SN6PR07MB5215.namprd07.prod.outlook.com (2603:10b6:805:6c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 10:03:58 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::343:e924:8155:ba63]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::343:e924:8155:ba63%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 10:03:58 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Daisy.Barrera@siriusxm.com" <Daisy.Barrera@siriusxm.com>,
        "Cliff.Holden@siriusxm.com" <Cliff.Holden@siriusxm.com>,
        Tony Lindgren <tony@atomide.com>,
        Jean Delvare <jdelvare@suse.de>,
        "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
Subject: RE: [PATCH v2 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Thread-Topic: [PATCH v2 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Thread-Index: AQHZc2bgk80G8N3jtkOKFQI5HTWTJq8z8loAgAAEliA=
Date:   Thu, 20 Apr 2023 10:03:57 +0000
Message-ID: <BYAPR07MB5381FF909E00820BEF3F8703DD639@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230420090101.80812-1-pawell@cadence.com>
 <20230420090101.80812-3-pawell@cadence.com>
 <7e54e105-574a-4104-8781-2f15c0c4b329@app.fastmail.com>
In-Reply-To: <7e54e105-574a-4104-8781-2f15c0c4b329@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTg1ZTI2OTgtZGY2Mi0xMWVkLWE4NjUtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XGE4NWUyNjlhLWRmNjItMTFlZC1hODY1LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iMzIyMiIgdD0iMTMzMjY0NTg2MzUyOTY3OTUzIiBoPSJoNEx2Qzc1ZS81TDBZMW02L1I0TWExMGpLZVk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|SN6PR07MB5215:EE_
x-ms-office365-filtering-correlation-id: 226cafb1-e42b-4f3e-e5a1-08db41868e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j9e729r8iGumo9r5psRFVWD082xiM2rIStZQR7ilz2BZWbN1mnu3kSWkj9Iq0KTEtsDrFOQFirAPv25vErkwjBXmcMBFiqb2XRSboEBOZIrqkwxuSSZHYXVrFy42ruxE/TUdXFSNByPs7n+DLrRFy8yvQrcZTEN4kNN086AMG3AFiKyMcPR8E+F6W6babbZuve9sUv2ZOIW53kAoc/wf8NIOEvU5EZ/+31v/oyvHCk/S1L9rFaO9cx79/g5WZSZGfqBj7SqOZRyrd1S/kHFyjeegMheo2A9nmly07Lrrbgj+MHdQe0Lm+s7ASHOhLpwbEMo16TXEAi3QkCkVr3eMQ8DgieClVt7ZehGKmYiHNoO+LuuLnYyVi4CaW6qYKqjK2DVH3wgvm5Txu56YHIvh7G5+LgyAc1Ctl4HnqFGf0INM/4ZjWpoEa7ZKgwI5aA5OiDP5yW5mKB5CMhTCwg+hq0vLuDHzlfcHceJg/ALc9+i1HhJ5mofze/Wc34DsAKAU1wuFfTt5DHmXqXpWBH1wH5sGuC0RSapQ5yAvKZzPRqiy/JSXnHZNDIZbJEOKQyi81pS9mYoQKUbe0KGYidZALeYv/jYNiH3xt9YR/6PJVrXOwSzaCwCtYom8q5sjjwst
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(36092001)(451199021)(71200400001)(478600001)(38100700002)(8936002)(8676002)(316002)(4326008)(76116006)(55016003)(66476007)(66556008)(66946007)(66446008)(54906003)(122000001)(110136005)(186003)(2906002)(6506007)(83380400001)(26005)(86362001)(41300700001)(64756008)(9686003)(38070700005)(33656002)(5660300002)(52536014)(7696005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ThwHdoIEsNSHDa40Pyq5bf1mnzUPYgT5uMwRU14fuW7HafvUr5Njgde08mLd?=
 =?us-ascii?Q?UzH4oSgzLsmxifqTDRVqOivd/ig64gT976R1c5OyscJLcXaR7mVnVvN9ZZue?=
 =?us-ascii?Q?qzYgdSM2Rgu4mpPy63R8i2/a71RUe9B8V100+T/fsrfBFTvfMhFlKW0A9nwA?=
 =?us-ascii?Q?TJo8ELe739AC+ZAXgZnkmYAeJWQc4BO+HkgtXrbQmUXBmWfDhPyHU+rxYwUe?=
 =?us-ascii?Q?RF4j9eQpDHTGjbUOV028yITIpZ7hrGjTPuRYn0LP3tdzOjWx60itLPrd2agH?=
 =?us-ascii?Q?Iw/B5XEhZx7uq2nA8sLYVx213Te90Ai/cN1vX7cMrEfLL8tIHTljL/XXmKih?=
 =?us-ascii?Q?5y7XePgFrjgMvvaN9OHFtlS/qpDecyIC+2bxZti2OMPdzJnK3gMDH1BEASxE?=
 =?us-ascii?Q?qLzqtSedNguNXpdyBk0mh0730bytMnD6PyJDf3arkxGSdosyGgBRYwgmKTFd?=
 =?us-ascii?Q?0OVpb78M0lmv+BzUHvBzAhsygw9itXRcPgwHqAcZYIinF/7iYRhwD+YwEdGN?=
 =?us-ascii?Q?XwYq1Lh1jtQFpmyU4eQw/6CThOAuHSgqPiOMxF0rMHeWbXMZw+2kTE9fTtoq?=
 =?us-ascii?Q?x1NINy9NlxVP2lD53wDP6SLCCQEFsxKQFIXTuVoztwIXWK1B1APgkmF1feSb?=
 =?us-ascii?Q?xCS70jaK3v0ljZ7px/W1rLj8E4YXwVQhWEtFYQoJkwdoLsDVJ8Cu3/1htwLG?=
 =?us-ascii?Q?jvPGatk4/yR/SpTrKlZxBAehsv5m6EvOZiVElb0eTc7pz1IDNa5P1cSuczKG?=
 =?us-ascii?Q?MEu8JX1uEfOn4WI8/iBnfR5hJh64z2b51woP1gymwxed0M07W9Fj3fFOZcfP?=
 =?us-ascii?Q?eMqQcTOvj6cmKJ2WqQ3dPW7440qBTG2jTDMNTASt+DPRHX9nxVEK19pRw6i7?=
 =?us-ascii?Q?SgQhvbx6Wjkfw7IaKY9MD+OZlllUvMVxuNsGUABJByeR3gbKrvn1NF0XAwew?=
 =?us-ascii?Q?Lo3JJQPusH2wU9+LwimvaWkncuXur4RzbzGm+HIu0e8Jq/RHQUp4JHcGSlcj?=
 =?us-ascii?Q?6jNpJbfnHN6fVmP5objjvzKg0iw4VnHr9bPgwGjmoWWQxLbkBltKlpKSmwfn?=
 =?us-ascii?Q?/QS/tZgrZbs8Y2mj8lhPIYIelSmJEJqQP+OQCsbwg5B7QOE5SRMcbQxVseBW?=
 =?us-ascii?Q?kQgROczC0HUe9MibrEEKLWLzYlRHYeMU6yI+mdVz/+chsYTNHCP2WUQkxuez?=
 =?us-ascii?Q?R1lc6AcqL9qmbyG4J7xQsvgeUtgsaULgquviqspm3NcTAVtLcoYYf6tmk2DO?=
 =?us-ascii?Q?eDavsJO1sST6cOd8WwrKJjr3wpa952C066w8S5/HhFiAuIE/e9chDOnfX1+N?=
 =?us-ascii?Q?geouaDUPQopNB7TQy/VmUsBaCgpQFwnBBu0vOLg1pTpLlSbKJZZ78D7z/bX3?=
 =?us-ascii?Q?Rbb1EUBIgB9Q6nqqJMNQw2YC8CbCPmVfUNX04u578+koXWDYFVcelkIi+h1F?=
 =?us-ascii?Q?1eM2vU1tHK6Hzr0RA5P0Z5PUBjhi8YnfVaC42+3fp3w+hfuYrvX9bKLkMeK1?=
 =?us-ascii?Q?LJ5yiUSG6mvEWOUV6vhimmeOb+jJmmjTyoTj6sNILLOM8uudqcTye+GtiDLN?=
 =?us-ascii?Q?gqGbjp1Y+F4L5oMSfpAgmLwO7E1H7bnSty2nuK+D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226cafb1-e42b-4f3e-e5a1-08db41868e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 10:03:57.2826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fPO1NrD00DxBhyKLGlkCBR42DVu4L1CjWdh+DA3ol68t8vKqT+5D+Rk4sGA+sFKXiu4YjzR01HuCn+P1XYBR92KW/Lee4vhhe+WxjdKd+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5215
X-Proofpoint-ORIG-GUID: k2ko7r4vuaTVGxt9NUdRUsG4i5PhRgnK
X-Proofpoint-GUID: k2ko7r4vuaTVGxt9NUdRUsG4i5PhRgnK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=7 spamscore=7
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=7 mlxlogscore=115
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Thu, Apr 20, 2023, at 11:00, Pawel Laszczak wrote:
>> This patch introduces the main part of Cadence USBHS driver to Linux
>> kernel.
>
>Not sure why I was on Cc, but I gave it a quick look anyway, looking for
>common issues. I only found a few very minor things that can be improved, =
no
>real problems:

You were detected by get_maintainer.pl script :).=20
I will remove you from cc in next version.

./scripts/get_maintainer.pl patch/0002-usb-cdns2-Add-main-part-of-Cadence-U=
SBHS-driver.patch
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM,co=
mmit_signer:8/13=3D62%,commit_signer:4/6=3D67%)
Pawel Laszczak <pawell@cadence.com> (maintainer:CADENCE USBHS DRIVER,commit=
_signer:1/6=3D17%,added_lines:1/4=3D25%)
Arnd Bergmann <arnd@arndb.de> (commit_signer:5/13=3D38%,authored:5/13=3D38%=
,added_lines:3/47=3D6%,removed_lines:31/47=3D66%,authored:1/6=3D17%,removed=
_lines:2/3=3D67%)
Tony Lindgren <tony@atomide.com> (commit_signer:2/13=3D15%)
Nicolas Ferre <nicolas.ferre@microchip.com> (commit_signer:1/13=3D8%)
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> (commit_signer:1/13=3D=
8%)
Randy Dunlap <rdunlap@infradead.org> (authored:1/13=3D8%)
Jean Delvare <jdelvare@suse.de> (authored:1/13=3D8%)
Biju Das <biju.das.jz@bp.renesas.com> (authored:1/13=3D8%,added_lines:13/47=
=3D28%,commit_signer:1/6=3D17%,authored:1/6=3D17%,added_lines:1/4=3D25%)
Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> (authored:1/13=3D8%)
Neal Liu <neal_liu@aspeedtech.com> (added_lines:13/47=3D28%,commit_signer:1=
/6=3D17%,authored:1/6=3D17%,added_lines:1/4=3D25%)
Herve Codina <herve.codina@bootlin.com> (added_lines:11/47=3D23%,commit_sig=
ner:1/6=3D17%,authored:1/6=3D17%,added_lines:1/4=3D25%)
Linus Walleij <linus.walleij@linaro.org> (removed_lines:11/47=3D23%,authore=
d:1/6=3D17%,removed_lines:1/3=3D33%)
linux-kernel@vger.kernel.org (open list)

Thanks,
Pawel

>
>> +++ b/drivers/usb/gadget/udc/cdns2/Kconfig
>> @@ -0,0 +1,11 @@
>> +config USB_CDNS2_UDC
>> +	tristate "Cadence USBHS Device Controller"
>> +	depends on USB_PCI && ACPI && HAS_DMA
>
>Why the ACPI dependency?
>
>> +	response_pkt =3D (__le16 *)pdev->ep0_preq.request.buf;
>> +	*response_pkt =3D cpu_to_le16(status);
>
>You can simplify this using put_unaligned_le16()
>
>> +
>> +	preq->num_of_trb =3D num_trbs;
>> +
>> +	/*
>> +	 * Memory barrier - cycle bit must be set as the last operation.
>> +	 */
>> +	wmb();
>
>This can probably be the cheaper dma_wmb() if you only serialize between
>accesses to a DMA buffer.
>
>> +static int __maybe_unused cdns2_pci_suspend(struct device *dev) {
>> +	struct cdns2_device *priv_dev =3D dev_get_drvdata(dev);
>> +
>> +	return cdns2_gadget_suspend(priv_dev); }
>> +
>> +static int __maybe_unused cdns2_pci_resume(struct device *dev) {
>> +	struct cdns2_device *priv_dev =3D dev_get_drvdata(dev);
>> +
>> +	return cdns2_gadget_resume(priv_dev, 1); }
>> +
>> +static const struct dev_pm_ops cdns2_pci_pm_ops =3D {
>> +	SET_SYSTEM_SLEEP_PM_OPS(cdns2_pci_suspend, cdns2_pci_resume)
>};
>
>You can use SYSTEM_SLEEP_PM_OPS() instead of
>SET_SYSTEM_SLEEP_PM_OPS() and then remove the __maybe_unused.
>
>       Arnd
