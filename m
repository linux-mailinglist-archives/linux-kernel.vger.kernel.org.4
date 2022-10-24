Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25460B38D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiJXRJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiJXRJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:09:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DB6D846;
        Mon, 24 Oct 2022 08:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5Z+bKqasqiSNSYIhQ2uF43WpC5Xep+0GOv3ubqjy8DOm2ng6k2yykChiTX3NzSYImMSwPGRnz4vTxbANIPEFCQ++hVhFVdR1pqKc3uQ3yLrdWS6JhszAnU2e7LndDxmEvXu3gsCVxUAFL9AlhxG39hUr9i4GGzugIdAuI5BuW9rrS6vQUlYpXNRW7NKWAs6sKKuKvy9BFJEvjp5XxuJlm5mBG8nRZv94nNx2SvnPVQrXnlp6Wca42tPrm/L5+h99vv0mes+oDYUgs4p3dJAr5LbHswn4bztTX8f7leAlfag/Iq+kYeMbTUS5tcjH+26rj+hymSO1xI3c6Qr/BTP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2mCYqfBBDAugC8cCXLUUYfOmdLBYWlKwlOaB2ClQIY=;
 b=MQZDi6sBdaU+G+5FHHej+GO8jkDpEim8zEBFOtY2aJ2I8fperBkYO30OmrJWaRDPU43ahwtS7ZiLN1i9g1dkJm4GFItj48ys3JpbRiykJ/BTmD0aoGcCyiks4FESY8RD75kTCY+y3ZfMSrQn7OGxwt3FhMMkRkoEK6O1aPZJCYrWzcZChO7xWQFoV4nyCQwuxc+8ILwQgBJGxPhH+73z0DdVpdyMiFGR1AlfGL7XKFNMQ4iNZ9C454liVhWh1vWBH+kOqZQpVskwjIeNSpx5xJSzPJkST9dga262Zi7x/iJJlLSWvJ8H5WHeNtyMmtbUK+pahXrq/vpE/Alwxh5bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2mCYqfBBDAugC8cCXLUUYfOmdLBYWlKwlOaB2ClQIY=;
 b=MS8HptJlbrAekuiB2UJT2ptTTPInXaCOncW0O+C5aT6Shy8325tLNCxWhM9yI1zusYCykXAUm6pNNKsPLhcH3iIoDqsFgh6EZxMzvPo+OmYcOhuhv7ziah9oPqHigpVDeCCfHh5cQTc+GjSCe3Oum6II+Vt30r37cCa/NFC8y28=
Received: from BN9PR03CA0212.namprd03.prod.outlook.com (2603:10b6:408:f8::7)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 24 Oct
 2022 14:55:24 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::bb) by BN9PR03CA0212.outlook.office365.com
 (2603:10b6:408:f8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Mon, 24 Oct 2022 14:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 14:55:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 09:55:22 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 24 Oct 2022 09:55:22 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, <bagasdotme@gmail.com>, <willy@infradead.org>,
        <akiyks@gmail.com>, <miguel.ojeda.sandonis@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v3 1/2] Documentation: Start translations to Spanish
Date:   Mon, 24 Oct 2022 09:55:20 -0500
Message-ID: <20221024145521.69465-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024145521.69465-1-carlos.bilbao@amd.com>
References: <20221024145521.69465-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f180ad9-bc0d-44e8-b1ab-08dab5cfc72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/bvsMLIJFzjGYewMq/PQjeSlmcZi0aPWouIGsLQ0MgtAygFUndsUkbrUe+0vXK5ygQbQXQRzXxqZ6j/JpdjiQC/FTyLv1qCHsdxg5YdfnnnMuQ9pt8cdrM9aLC7ftN1T9VSQSQE4cxnsrxum2EB178C/+YxaOy6Tm8bnLVv/FiWg2cfST5b2J93qwcCeKmnho33icR3JjY0SA6zY4/FYEiRwpx5fL1ffNqFaEMo1T5+qPkJUNSCucWnvdfhs48wM8plgNBZpcWfJTIUCSc7EP0uY9HismwnphbgnOAHls5004z8edjkn3Jek01+Vy1m+EuUNmGb5R740E5t2cpdnFtMEiU1jRpd+AsA/gYwaSBzP1ol0Dhshv1YOCURcfDdPMp/E826TrN7m2m3Dyx8ucN1rvwWjF/onpQH1ubyfpTws1caVWQwUl/ccpzJ8jB8M5g00Chy72BB2KtIPO7HD7Nfb2/oT26rigwtZUu2VBhZcuDZBzn6nmIibvdwbxwx//k7JKGDubRJfrtfyfbzdZYnQedazj6beWEMvBrH7e++xV8027WyuGYyI8BPWyfR8j2YzEnbOveCzyX4Qnh25spTKqPGNnlbchcnAxI3qehp+qBLE/SUfPKyaOvYTuwEy5Idc6EkPH4ebdSsjpYQaZ8VEB0lM4qSoSi2GGCwYFSywcznZvqqX/ZD7zbI3dETSTV4EvR/DLWX0xlJfx2+VxsaR14VdNDowZXlmXuoEDnEKiGoSFPNPHP0TVqCqRv+JC+wtBkLx5se2Y12UEzsRX34qH/Ijly1riH0jlfAn8NBnNpL7UcH7bz3qCSxfT3GiqPG6C01CQdY1XBLhl6cjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(426003)(316002)(2616005)(40460700003)(44832011)(54906003)(70586007)(4326008)(36756003)(8936002)(83380400001)(63350400001)(2906002)(63370400001)(66574015)(86362001)(41300700001)(7696005)(336012)(1076003)(26005)(5660300002)(47076005)(6916009)(40480700001)(8676002)(70206006)(186003)(82310400005)(36860700001)(81166007)(82740400003)(966005)(478600001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 14:55:23.0265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f180ad9-bc0d-44e8-b1ab-08dab5cfc72b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the process of translating kernel documentation to Spanish. Create
directory sp_SP/ instead of es_ES/ (diverging from format of prior
translated directories) since this directory should accept any dialects of
Spanish. Include an index and a disclaimer, following the approach of
prior translations. Add Carlos Bilbao as MAINTAINER of this effort.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/index.rst          |  1 +
 .../translations/sp_SP/disclaimer-sp.rst      |  6 ++
 Documentation/translations/sp_SP/index.rst    | 72 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 4 files changed, 84 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
 create mode 100644 Documentation/translations/sp_SP/index.rst

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index 1175a47d07f0..b826c34791c0 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -12,6 +12,7 @@ Translations
    it_IT/index
    ko_KR/index
    ja_JP/index
+   sp_SP/index
 
 
 .. _translations_disclaimer:
diff --git a/Documentation/translations/sp_SP/disclaimer-sp.rst b/Documentation/translations/sp_SP/disclaimer-sp.rst
new file mode 100644
index 000000000000..a400034e95f9
--- /dev/null
+++ b/Documentation/translations/sp_SP/disclaimer-sp.rst
@@ -0,0 +1,6 @@
+:orphan:
+
+.. warning::
+   Si tiene alguna duda sobre la exactitud del contenido de esta
+   traducción, la única referencia válida es la documentación oficial en
+   inglés.
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
new file mode 100644
index 000000000000..816d45e081e9
--- /dev/null
+++ b/Documentation/translations/sp_SP/index.rst
@@ -0,0 +1,72 @@
+.. _sp_linux_doc:
+
+=====================
+Traducción al español
+=====================
+
+.. raw:: latex
+
+	\kerneldocCJKoff
+
+:maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_disclaimer:
+
+Advertencia
+===========
+
+El objetivo de esta traducción es facilitar la lectura y comprensión para
+aquellos que no entiendan inglés o duden de sus interpretaciones, o
+simplemente para aquellos que prefieran leer en el idioma español. Sin
+embargo, tenga en cuenta que la *única* documentación oficial es la que
+está en inglés: :ref:`linux_doc`
+
+La propagación simultánea de la traducción de una modificación en
+:ref:`linux_doc` es altamente improbable. Los maintainers y colaboradores
+de la traducción intentan mantener sus traducciones al día, en tanto les
+es posible. Por tanto, no existe ninguna garantía de que una traducción
+esté actualizada con las últimas modificaciones. Si lo que lee en una
+traducción no se corresponde con lo que ve en el código fuente, informe
+al maintainer de la traducción y, si puede, consulte la documentación en
+inglés.
+
+Una traducción no es una * bifurcación * de la documentación oficial, por
+lo que los usuarios no encontrarán aquí ninguna información que no sea la
+versión oficial. Cualquier adición, supresión o modificación de los
+contenidos deberá ser realizada anteriormente en los documentos en inglés.
+Posteriormente, y cuando sea posible, dicho cambio debería aplicarse
+también a las traducciones. Los maintainers de las traducciones aceptan
+contribuciones que son puramente de interés relativo a la traducción (por
+ejemplo, nuevas traducciones, actualizaciones, correcciones, etc.).
+
+Las traducciones tratan de ser lo más precisas posible pero no es posible
+convertir directamente un idioma a otro. Cada idioma tiene su propia
+gramática, y una cultura tras ella, por lo tanto, la traducción de una
+oración al inglés se podría modificar para adaptarla al español. Por esta
+razón, cuando lea esta traducción, puede encontrar algunas diferencias en
+la forma, pero todavía transmiten el mensaje original. A pesar de la gran
+difusión del inglés en el idioma hablado, cuando sea posible, expresiones
+en inglés serán reemplazadas por las palabras correspondientes en español.
+
+Si necesita ayuda para comunicarse con la comunidad de Linux pero no se
+siente cómodo escribiendo en inglés, puede pedir ayuda al maintainer para
+obtener una traducción.
+
+Muchos países hablan español, cada uno con su propia cultura, expresiones,
+y diferencias gramaticales en ocasiones significativas. Las traducciones de
+los maintainers pueden utilizar el español con el que dichos maintainers se
+sientan más cómodos. En principio, estas pequeñas diferencias no deberían
+suponer una gran barrera para hablantes de distintas versiones del español,
+pero en caso de duda se puede consultar a los maintainers.
+
+La documentación del kernel Linux
+=================================
+
+Este es el nivel superior de la documentación del kernel en idioma español.
+La traducción es incompleta, y podría encontrar advertencias que indiquen
+la falta de una traducción o de un grupo de traducciones.
+
+En términos más generales, la documentación, como el kernel mismo, están en
+constante desarrollo. Las mejoras en la documentación siempre son
+bienvenidas; de modo que, si desea ayudar, únase a la lista de correo
+linux-doc en vger.kernel.org.
diff --git a/MAINTAINERS b/MAINTAINERS
index 944dc265b64d..b3133f013efb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19150,6 +19150,11 @@ W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
+SPANISH DOCUMENTATION
+M:	Carlos Bilbao <carlos.bilbao@amd.com>
+S:	Maintained
+F:	Documentation/translations/sp_SP/
+
 SPARC + UltraSPARC (sparc/sparc64)
 M:	"David S. Miller" <davem@davemloft.net>
 L:	sparclinux@vger.kernel.org
-- 
2.34.1

