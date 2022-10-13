Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1DA5FE20D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiJMSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiJMSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:51:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843C3A17A;
        Thu, 13 Oct 2022 11:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONejJpEfN4Sn4x66Bm0p9iCBZ0Hy9dIF7BfhTV83ue9/pEIvscjXbhWJvvzC50K7fQ59cLoH5FbfAte1tZDGbV/crlBEXAnzWTCyDooAYsnEl2ohu+zZSkia7mjgO31AFfwRC2UsRoSiqlH08uIIxijOuC0ShpfZTKohELLBs0di4jNDCcA7z7gyurL9clMdwkGORgZlFytsX+vjiTvPy00WJDLEWnPIj2e2OEV85b/KMxWyJiYTflC4FW3epqjCgYozNj1orl88i9JAI6AJDzzowoWkH9uzGtZYOS7e4XJ68fzZ7J2lCO9IKnDIhszLO2k9CBY5j1JHB0ZvRFz9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7n6fmBNLhaa9mE2N+Co8OgQsebyGl70EINtqxEFa3c=;
 b=Vx3K7+rjFXdxDnjnzcOKBlsID81CmkM7VXSrr+lykGHtuGcEtiejtjZuVt0HRgpJwv7KTL2D8GILq2BSp56Dmts0hY4dGGkvCk7+9FIdxPr+u2U/m7382zTb5cCx8IRgiQ21DMQT3mMHd55poaOgZ1XynkUpZCGUWtlVM0Jk5x31XJX8pNfIR0+aMPF6LA/7JU7suN2ixzyNFjcmlmUkRi4Ga7IBSYeDm0K7GFrQe3SmD1qsSoF+Y9sxCKmJQZPEDleyea7fBb5WzineWQt065WHSrrWbj107OH80+WFGqXsqWm91QminvFh6idVLg/9bf9gUeRWcSEED78pdVvTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7n6fmBNLhaa9mE2N+Co8OgQsebyGl70EINtqxEFa3c=;
 b=20K2yj4K5XoqB3Q8fPvRTOYKdTLdWGhdtgVveyNrsXXPSL2R8NPW5lGDMu1nBnKYQF8m+koNiZtLTSFP5D1QxTq7KBTDTIUj3lpCGaFhmZIPXrXEPmeZscmbM+WEqS+Sz2j4X/MQWGh85sv0NvY9H1Sz9E0cURiNwTve+PBIxJc=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Thu, 13 Oct
 2022 18:48:18 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::91) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 18:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 18:48:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 13:48:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 13:48:17 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 13 Oct 2022 13:48:17 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <carlos.bilbao@amd.com>, <bilbao@vt.edu>, <ojeda@kernel.org>
Subject: [PATCH 1/2] Documentation: Start translations to Spanish
Date:   Thu, 13 Oct 2022 13:48:15 -0500
Message-ID: <20221013184816.354278-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013184816.354278-1-carlos.bilbao@amd.com>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|BL1PR12MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 54598a4d-3097-4793-824b-08daad4b7ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oksUcsdVIUzysBUtZvSXYuKEBDkAkG8s9kUkBJdhvvCw4KnATaUvbb3RgUBbSwPAgzMPZ9QPG/ClUZInQ2u+TNwEKXTklwkfA9FdybtoCgvU2PEELyZ8DgmHHd0d35TYHabvcO3/E43rPQv0Cmxo7vz+zttWCxPqtSKKoqW6mn9kX5HYTGfmJSbbMqKdlaqoD31MCRkQV/tDu/ZZ2a3qeBbwh9JmGXvcCl91f9Y7YmUfrjDqsRwv4LD1WjM0rFfvZP46KQ/TwxUvtpBn4XmsEzKOMVv96V1DwHsdXTHBcDGpE7rmRrGlmWgqTEpN1EXxCaqDlqN0Hc8jm6HucjF/6rx5ZCG5Q43g65hUTSfkzyL4RQW44OGoPSQNH1a1z09BpixbHeGvvMsuWvqpz1sVhtVTlSE/XnEfheI3li0GA8q6X8IiXSbodzp6pRgHisTo4yKO8S8DVjpuBC6EtOtXBfKgP4rbK0OsDU7JQMMkv+vpIN9FuKK30s0OVB7DsLHXOQoWLT8q3x/VjBCQqy51yn8XadC1GeezbS68crxsgMDSe+oP6sXo8QjlKvXn1P75RjhR2ZrTYs6zqNArYTfU4tBridlY6rEssxS4BNQIwF5PCWIxZlUelQS7M9bD2bO0oYvAnGY8ziB9PPymGHL5r5i6nc2tPkUH+MFztUNV57rWSacH7L/zor3ay5gWN/RjFQFkudKquQWvEtLnbaG0FEPlrrvUOZWQGaxRB+0+/5efQl+ifRT9snFqzX8TULafDL3h0EcKTGRT8BsHbSgFNBXo695waghYkXZCLIGUQzYbE2gp8rfPY3J2v9VPZgQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(316002)(82740400003)(40480700001)(426003)(36860700001)(54906003)(6916009)(66574015)(47076005)(8936002)(81166007)(1076003)(26005)(186003)(5660300002)(2616005)(2906002)(8676002)(4326008)(44832011)(70206006)(70586007)(82310400005)(7696005)(336012)(36756003)(356005)(41300700001)(40460700003)(83380400001)(86362001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 18:48:18.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54598a4d-3097-4793-824b-08daad4b7ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the process of translating kernel documentation to Spanish. Create
sp_SP/ and include an index and a disclaimer, following the approach of
prior translations.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/index.rst          |  1 +
 .../translations/sp_SP/disclaimer-sp.rst      |  6 ++
 Documentation/translations/sp_SP/index.rst    | 73 +++++++++++++++++++
 3 files changed, 80 insertions(+)
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
index 000000000000..bf6a24a2399d
--- /dev/null
+++ b/Documentation/translations/sp_SP/index.rst
@@ -0,0 +1,73 @@
+.. _sp_linux_doc:
+
+=======================
+Traducción al español
+=======================
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
+La propagación simultanea de la traducción de una modificación en
+:ref:`linux_doc` es altamente improbable. Los maintainers y colaboradores
+de la traducción intentan mantener sus traducciones al día, en tanto les
+es posible. Por tanto, no existe ninguna garantía de que una traducción
+esté actualizada con las ultimas modificaciones. Si lo que lee en una
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
+ejemplo, nuevas traducciones, actualizaciones, correcciones).
+
+Las traducciones tratan de ser lo más precisas posible pero no es posible
+convertir directamente un idioma a otro. Cada idioma tiene su propia
+gramática, y una cultura tras ella, por lo tanto, la traducción de una
+oración al inglés se podría modificar para adaptarlo al español. Por esta
+razón, cuando lea esta traducción, puede encontrar algunas diferencias en
+la forma, pero todavía transmiten el mensaje original. A pesar de la gran
+difusión del inglés en el idioma hablado, cuando sea posible, estos será
+reemplazado por las palabras correspondientes en español.
+
+Si necesita ayuda para comunicarse con la comunidad de Linux pero no se
+siente cómodo escribiendo en inglés, puede pedir ayuda al maintainer para
+obtener una traducción.
+
+Muchos países hablan español, cada uno con su propia cultura, expresiones,
+y diferencias gramaticales en ocasiones significativas. Las traducciones de
+los maintainers pueden utilizar el español con el que dichos maintainers se
+sientan mas cómodos. En principio, estas pequeñas diferencias no deberían
+suponer una gran barrera para hablantes de distintas versiones del español,
+pero en caso de duda se puede consultar a los maintainers.
+
+La documentación del kernel de Linux
+====================================
+
+Este es el nivel superior de la documentación del kernel en idioma español.
+La traducción es incompleta, y podría encontrar advertencias que indiquen
+la falta de una traducción o de un grupo de traducciones.
+
+En términos más generales, la documentación, como el kernel mismo, están en
+constante desarrollo. Las mejoras en la documentación siempre son
+bienvenidas; de modo que, si desea ayudar, únase a la lista de correo de
+linux-doc en vger.kernel.org.
+
--
2.34.1
