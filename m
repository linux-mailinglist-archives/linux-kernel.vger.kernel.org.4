Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C87248ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjFFQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFFQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:22:49 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E76E40;
        Tue,  6 Jun 2023 09:22:48 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356F1eiE030721;
        Tue, 6 Jun 2023 16:22:33 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3r229jsu66-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVxLtCYJM7NNfoFHkuSgjkH/X19CPqiqfoBCRqc+AoZ+7PTmT/qtApPYHL5OSiuRG1LRw29/MFQJrofk6OhJZnB5gNzWS5cnk7AHksmJBQSUUkDG0XLQluPqgUE/9naln5il9axoZRKKAdgBWsSXU3qN22HssfUAeYdyNxHkiyK+PKFBA0jktRG615me75a+Kg38mtGJPSGqoIDP4P9LyEtbO3HNRWKGqwPiMfILbEZuNymSbyDgkjgzcJ5inspHkFbt1u4yUKUKnrtc+r7Ibt7ueuGbAMHT6uPlCT1c6bvEPsitkajCVEU4WAslADi1Ta/ETLjOR03eAdTFjkFhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1vg2H0gwnIiA0XBcxRAHjKtXu/CVSVIZptf9NvQcQY=;
 b=mp4LVV/jSgZZH0WxzhnmlUEXQWzjY8zMQJYffnY5xfgajwPyrpq/RQruQGuJ77CTLVgynNkfSJx8jr/xkpgaNnjV+7kX6QsrDiDb8Is1Hj8r7V3wU9kDym5fkYGZ3rw5G2cy9AU+TYuuamb1/NKnl2oNRIDuSCK36lwwDMlQgP0rLD3I2xuqJPPwY9QeVPvHiy8IJwaTO9fdfLtK0JrBz+LXXkNRFErRWkPf95+p+2WZL1HxSqDgxl8Dv3am5ZDqvI6unl4nXj5f4AGtcR6CLTTK/8VfufBBeIq8Rmdr5xxhrrjhmU59KT9siBhQ2bmqeVZQA7T2wNTcPqAB3WWC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1vg2H0gwnIiA0XBcxRAHjKtXu/CVSVIZptf9NvQcQY=;
 b=Tl4bV4PoqI3268+TbE3SgnKPocjrbjxlrELcaYkJwlcZHY+EKEi2F+GDqZkQKKLFf5I/yFHgIV7JcrY8ie95ECY6LsT2jNKcH9CNlYhYkYcdq+1B0rLZI58YAPT6rZ2sx4mYfIfsJ8hQoy46fgnmYWJtySPh8xC6xlRadwvTxivPDsyXCNrmCCh546co7ybzPUIBJ6lr/8k800ykBBR9jNl96zYVlp3n4Utb7tiLc9vcjgiyHf95wwPA9aNCQ1oKNbmZoDINXpUqD6wwB2PRY69fuFcC/YfjyyprHyc/l8ik3iGjS1wKPiovvuS37RG4pkCpTpihTJBLeZeAG0PuUQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB4PR03MB8708.eurprd03.prod.outlook.com (2603:10a6:10:380::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 16:22:27 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:27 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 1/4] firmware: arm_scmi: Add optional flags to extended
 names helper
Thread-Topic: [PATCH v3 1/4] firmware: arm_scmi: Add optional flags to
 extended names helper
Thread-Index: AQHZmJMV0Z/bArOidE+HuMEc9wmXMQ==
Date:   Tue, 6 Jun 2023 16:22:27 +0000
Message-ID: <2ad06a5582bb31e16fe2f497e15cb41e8455e863.1686063941.git.oleksii_moisieiev@epam.com>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1686063941.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB4PR03MB8708:EE_
x-ms-office365-filtering-correlation-id: afd4a14b-03eb-4e2b-eb0a-08db66aa381d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQUU2i2Cuuc+r2RgtYqrvSYciZ1Mzb+JPC+dgxtbMbVAo0zGNapQb5DpDz/bNLlMkkX27vG01Pl1Mp1ozUFKNQhVtttGvNFSdjiJF+QjSdMew24ZPfkYP8vwuyg7+bsfclN3Tfr+SIHP0cDRZwQ7qN6Ly0OdROtG0Weg6E8TlYHGdI+Vl2+EDSOuu56GsHTBk1lHnqpmBznPz+w9SYs37Vd8VBI3wxV21veSPGabLkJLwQ89TCcZE4zQtHge6jPboYPoLh3cKxlr/KimwGjIULVjZyHQlq8p54+F7nYt+UiT0CmPRr+EOQGNYZKj7O/MvlFh9Lpwrflj5CbOySdYQY/FvFckquT+F/YPbSS77Xm/ElDNqtAyAdc3ZSjUkeFC3xIFjUGGlUmse9+RPCcO38gCchWYHODaP9OLqnUtLul/mcslMEcX5WB0j3mXQepHLBWlSp81U6swJ56/H1F3o2Aw8AAn1zMwCGA7pkpXEUzAvReP+pildaJDuRck/1CUY5k7vR+5fO/5eUaa/GMiEYsfmPEFAd0Iw76AtP4//JXwHXAknpBTa6D5Icg0zG82fQ5BIvwDodrvmC3/x4ljwwtqKh4TcdrDfyfp9i89BOpJJ3NUVWhessau565MrnVa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(6506007)(26005)(2616005)(83380400001)(186003)(66476007)(66446008)(122000001)(66556008)(66946007)(64756008)(76116006)(2906002)(6486002)(71200400001)(8936002)(38100700002)(7416002)(38070700005)(86362001)(5660300002)(36756003)(54906003)(8676002)(91956017)(478600001)(6916009)(316002)(4326008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BhQsKZ/irtkz66VaWYWXvrBy5XKpi32kpty8+aTbb6D8Ita1JKssKAjnIT?=
 =?iso-8859-1?Q?QblHrmqFYHBUILOniDJ/20r5UdBDzqwgyFODP1FE9JV3uLKI/+iOQ1yrrB?=
 =?iso-8859-1?Q?qyz+pYTLDW9QINoWJKWxOQm57BUqUQLy7eRAwfq8j4R8JmzHkMbSrLWwer?=
 =?iso-8859-1?Q?NA+FH5WpkV+xB5uhqQsRY1JrR8wkhNii1f8dpDag7XS4PahNPJ7sfQC/1Z?=
 =?iso-8859-1?Q?/lt1HexZaZ7dKhmtugiZtC/UZZ2bG//y1koFCiEszQ7V0YAjeTDYb6IwFJ?=
 =?iso-8859-1?Q?ZoGVVzbgSR1blBXayvacGcUMz9PJlxaF2+uBsIQrMy8IjNQ3JcPg3nTvgx?=
 =?iso-8859-1?Q?ALPf2Na2+8LyCPDsGLJDzuxBhJ56OjoeOcl6JLFoag1FBprfjPfb0BB19z?=
 =?iso-8859-1?Q?s5GSXsp2p0vYGcyg8bL6Ikua5QfotSD3jCHtFhxUwqB33q/N8qzUIy8L/O?=
 =?iso-8859-1?Q?NtEVV3IOFqYhmP4YYyutv0sOds6NrnRilkedA+SQ/Z9MF82ciGIaKfIIye?=
 =?iso-8859-1?Q?vsAZScR5QPR63KtfPqop5Qck048Wfhsgd1Cn7SqnmNFiLg0sbkevtGPUV0?=
 =?iso-8859-1?Q?Q47+6foWIKMW4rA/gC7Wy5bViM0qI27G9eLTWOzp7L8RtC+vTvOQ+P8lR9?=
 =?iso-8859-1?Q?MUQT8VpLgb4y3anjViXw5oN45/Zjcr6OB4s2toD20B90ezJbF9vZ11OXYx?=
 =?iso-8859-1?Q?NJy7p1JfZAzTx0H8LHv02XL91UGbf6+jqXuL9W7pYeIX+jFtzDZGZQJWsf?=
 =?iso-8859-1?Q?1sa2fpSJXlNg0Fk3vriEH+bAxLZ5xZ12HPkALfgFosepT5trKc/XaOYpLx?=
 =?iso-8859-1?Q?jFI5lLOjt2LrqxnCG8YM1PveOlQ7stAmpdW9Ulw4Wqireew4nBDElZKHpT?=
 =?iso-8859-1?Q?+9E5OqK+t7g3OGyn5zX85L/tCzCSgUtvTYZ8FsVXNU+jy9uzzGH+dM99Iy?=
 =?iso-8859-1?Q?GOIfkhEaD/XkJMGozil0+uzLZtpdcoWOZDiLGs5/HSc+8TF2I3KNl7EFgM?=
 =?iso-8859-1?Q?ZrSTOl7tv4J7z1uysYt+8+Iwtca30BBlFW7eQNxHG500exNbtHq6oBsAti?=
 =?iso-8859-1?Q?Oa0WLEch4OnaEaG5hCPxiwouSzeSpMUXsJKgoVBdOJ1eqFRqU3edoq/wNB?=
 =?iso-8859-1?Q?A8UB/AsA+5l0IHNiU0VIp7DxI8yWAuprFnHui3lBpf8O/YBQB8KbWe6DWI?=
 =?iso-8859-1?Q?pdCrB1OHL7AIpnuBSZUHDXomNC2YOzohpzEQ5wkdUNphA653MexTURTwQd?=
 =?iso-8859-1?Q?RuORuDrNav670HyzdTqvaXxG5ejQzdvtIqKlm8Gav7wxsbOgmSL4u012wP?=
 =?iso-8859-1?Q?wDSMPFTYkz2TEMMhR1mNxgWlChmdFq6T5RTPgFfjvsrJwAmKqinvGaSKN3?=
 =?iso-8859-1?Q?LzB2ACprwYYyU3pJgqmPsyd/iNivWYIp+FUd0HM51LUEkYn44ll8+zIyHt?=
 =?iso-8859-1?Q?KGHLiHm1XaNssgrAWMfUsgkfKUnOf4/7IaVk1wAGSsoFa10uNy93Ji3ygY?=
 =?iso-8859-1?Q?ko7nb4YbRgCZAsfalr8sz9A8lqmw9ZEinUbb0Wy8Nj9oa3KHgIiJNFvwFf?=
 =?iso-8859-1?Q?iwOGuBA2ZSlJ3gw7a4hZULThY3wb42qTXzeqyJCA8NthWYk5zHgnjRhIgl?=
 =?iso-8859-1?Q?i1dT8ifrnqDUdyAltjxp5v/XuxRu+iOBggS71wZFEoexgzIlG/hnl03w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd4a14b-03eb-4e2b-eb0a-08db66aa381d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 16:22:27.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JY6c3FlgFjevhd22FDSHPqVzXDkFgOLPoaHpt/7W87htxEciffQCNr9pzGaaUELerJg2oGqIEY9Qe5OkTdywMLgd/urpEt9a9cjxlsr1j8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8708
X-Proofpoint-GUID: F11GTAlSEEFoV_rky7jqY6gLqbPHG1wb
X-Proofpoint-ORIG-GUID: F11GTAlSEEFoV_rky7jqY6gLqbPHG1wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some recently added SCMI protocols needs an additional flags parameter to
be able to properly configure the command used to query the extended name
of a resource.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c     | 2 +-
 drivers/firmware/arm_scmi/driver.c    | 8 ++++++--
 drivers/firmware/arm_scmi/perf.c      | 3 ++-
 drivers/firmware/arm_scmi/power.c     | 2 +-
 drivers/firmware/arm_scmi/powercap.c  | 2 +-
 drivers/firmware/arm_scmi/protocols.h | 3 ++-
 drivers/firmware/arm_scmi/reset.c     | 3 ++-
 drivers/firmware/arm_scmi/sensors.c   | 2 +-
 drivers/firmware/arm_scmi/voltage.c   | 2 +-
 9 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/=
clock.c
index 96060bf90a24..e6e087686e8c 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -169,7 +169,7 @@ static int scmi_clock_attributes_get(const struct scmi_=
protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x2) {
 		if (SUPPORTS_EXTENDED_NAMES(attributes))
 			ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
-						    clk->name,
+						    NULL, clk->name,
 						    SCMI_MAX_STR_SIZE);
=20
 		if (SUPPORTS_RATE_CHANGED_NOTIF(attributes))
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi=
/driver.c
index e7d97b59963b..5be931a07c84 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1438,6 +1438,7 @@ struct scmi_msg_resp_domain_name_get {
  * @ph: A protocol handle reference.
  * @cmd_id: The specific command ID to use.
  * @res_id: The specific resource ID to use.
+ * @flags: A pointer to specific flags to use, if any.
  * @name: A pointer to the preallocated area where the retrieved name will=
 be
  *	  stored as a NULL terminated string.
  * @len: The len in bytes of the @name char array.
@@ -1445,8 +1446,8 @@ struct scmi_msg_resp_domain_name_get {
  * Return: 0 on Succcess
  */
 static int scmi_common_extended_name_get(const struct scmi_protocol_handle=
 *ph,
-					 u8 cmd_id, u32 res_id, char *name,
-					 size_t len)
+					 u8 cmd_id, u32 res_id, u32 *flags,
+					 char *name, size_t len)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -1458,6 +1459,9 @@ static int scmi_common_extended_name_get(const struct=
 scmi_protocol_handle *ph,
 		goto out;
=20
 	put_unaligned_le32(res_id, t->tx.buf);
+	if (flags)
+		put_unaligned_le32(*flags,
+				   (u8 *)t->tx.buf + sizeof(res_id));
 	resp =3D t->rx.buf;
=20
 	ret =3D ph->xops->do_xfer(ph, t);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/p=
erf.c
index ecf5c4de851b..d85d4a0e3605 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -237,7 +237,8 @@ scmi_perf_domain_attributes_get(const struct scmi_proto=
col_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    NULL, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
=20
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/=
power.c
index 356e83631664..077767d6e902 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -133,7 +133,7 @@ scmi_power_domain_attributes_get(const struct scmi_prot=
ocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags)) {
 		ph->hops->extended_name_get(ph, POWER_DOMAIN_NAME_GET,
-					    domain, dom_info->name,
+					    domain, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 	}
=20
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_sc=
mi/powercap.c
index 83b90bde755c..e7ea9210aae1 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -268,7 +268,7 @@ scmi_powercap_domain_attributes_get(const struct scmi_p=
rotocol_handle *ph,
 	 */
 	if (!ret && SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, POWERCAP_DOMAIN_NAME_GET,
-					    domain, dom_info->name,
+					    domain, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
=20
 	return ret;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_s=
cmi/protocols.h
index 78e1a01eb656..b3c6314bb4b8 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -256,7 +256,8 @@ struct scmi_fc_info {
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
-				 u8 cmd_id, u32 res_id, char *name, size_t len);
+				 u8 cmd_id, u32 res_id, u32 *flags, char *name,
+				 size_t len);
 	void *(*iter_response_init)(const struct scmi_protocol_handle *ph,
 				    struct scmi_iterator_ops *ops,
 				    unsigned int max_resources, u8 msg_id,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/=
reset.c
index e9afa8cab730..7217fd7c6afa 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -128,7 +128,8 @@ scmi_reset_domain_attributes_get(const struct scmi_prot=
ocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(attributes))
 		ph->hops->extended_name_get(ph, RESET_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    NULL, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
=20
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scm=
i/sensors.c
index 0b5853fa9d87..9952a7bc6682 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -644,7 +644,7 @@ iter_sens_descr_process_response(const struct scmi_prot=
ocol_handle *ph,
 	if (PROTOCOL_REV_MAJOR(si->version) >=3D 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(attrl))
 		ph->hops->extended_name_get(ph, SENSOR_NAME_GET, s->id,
-					    s->name, SCMI_MAX_STR_SIZE);
+					    NULL, s->name, SCMI_MAX_STR_SIZE);
=20
 	if (s->extended_scalar_attrs) {
 		s->sensor_power =3D le32_to_cpu(sdesc->power);
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scm=
i/voltage.c
index eaa8d944926a..36e2df77738c 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -242,7 +242,7 @@ static int scmi_voltage_descriptors_get(const struct sc=
mi_protocol_handle *ph,
 			if (SUPPORTS_EXTENDED_NAMES(attributes))
 				ph->hops->extended_name_get(ph,
 							VOLTAGE_DOMAIN_NAME_GET,
-							v->id, v->name,
+							v->id, NULL, v->name,
 							SCMI_MAX_STR_SIZE);
 			if (SUPPORTS_ASYNC_LEVEL_SET(attributes))
 				v->async_level_set =3D true;
--=20
2.25.1
