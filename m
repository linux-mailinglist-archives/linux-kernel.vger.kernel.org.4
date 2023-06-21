Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1895738CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFURP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFURPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:15:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE9519A8;
        Wed, 21 Jun 2023 10:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW7jp2XbMYW9vSP2vRDd4O1rMrQlCLP8r+iDlpn4ST/FDk/nAET+1kS2PCC/xgGZhw2oFRdsl/gT44qoqzMtTaMzp6Cu1LWEtjXaC8X2mJmd727HBGYxqsJc3+4vfrk7CaCw0p0AivThQC0/Mh6mH4O/CqEAo/cDQ6d76efpKjahIr5S3J46uPN/UzL9InCKHypG/mDrpLfeDiP/b1mo9Ov/sKV4mtDodA23AuTB/NHqSsI9Gsq44LZO4LMusTDsEgG/D9kriDDEamecMrIuPdMjvEbsZg2VACM0VRLhYyZIQHj84MUnJW9WylCSyYXS4s9N6el8Eoj+AFBzwPoCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZBm+M0bggolSwv3g73pGj/yLC3Z9KkSu42VIVxt2tQ=;
 b=bWF+RXn8yHIsCKCCQeCeIiV2RHk5ohnmCAI2oeZHjRdhp8UDapkMgRyV5sRXi7jkr4JCGt5pxKuY5xgKj+eB9QvPGMg2TIOjtIDiBbFGuT1+RMIifZL9Dvxcb5laklomP7POvrdGuCQO+vNoF6O+UdO1/ToxLbyZMdW/+mgl95hX+1mhQjifKIaFrHr6A460bGmSzUwi3DQx6O2TEhv1stFyQIryzPmlf/4cy15L7BpDKDUXHBLVkCOHVyEW1H3NYZzzQ4byPwz1rRUNMNlKZvekUfjnKkp+BvKX0OL6ps7tHRQ713GhuZC7mn2IwvGr7AUeHvzlil6hmf8pl6eUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZBm+M0bggolSwv3g73pGj/yLC3Z9KkSu42VIVxt2tQ=;
 b=pSBfsmuy7P4qvqK2D7yOCNKMM9ooUYo3zyLJuOFPsmAlDrOYBnuA4WKbmXQy7GhJOlD2NScenK0jp+5G9RqL8j6FCCFRK3MtmQHNy+6YtE5UOm8QjeoqkOjUm3tBObiS8YZiavmVWg3Z86hpUW5JCdInDjDjvclDFqxP1jD08so=
Received: from CY8PR22CA0003.namprd22.prod.outlook.com (2603:10b6:930:45::8)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 17:15:19 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::b8) by CY8PR22CA0003.outlook.office365.com
 (2603:10b6:930:45::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 17:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Wed, 21 Jun 2023 17:15:18 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 12:15:17 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 1/1] docs/sp_SP: Add translation of process/researcher-guidelines
Date:   Wed, 21 Jun 2023 17:14:57 +0000
Message-ID: <20230621171457.443362-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621171457.443362-1-avadhut.naik@amd.com>
References: <20230621171457.443362-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a5b5c6-0761-4988-21e0-08db727b169f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ePGOXHfjGBNEUyR4JMi4PsGok58JiMhXLwBiN+QhKctR3jnuucwmT0ZpbvKQHta37wVBp+LEFtXw2OOaJrGmuw5r2IBNYxa67Vf+ezAplYHyWudXsta4YCxFnh/IHmRUcmiaMhNbGBBmCw/sxOtNE+PCQUTX02n4/hCfX7oAqR5Rr6b9ogiH18biI3KRXtKiG83GYA83vjrU9mj8/iXt/zE+rrPsqi8WhpULTvqBx0ISd0fgVgnsLVogVkMAVVUi4tvv95Y+A6ZFfORJI0UwYZ61q3/MD3nR+Ux5xyr/IHMpKNvaEuhwj0vjxgIp7iTcxI3B5tA3i5qc7Dx1cGUBkshotxPXofKpXkHxSs++euqJBrpay3Y4m0c5vomRxjt+Y3JL4cOFnSRq4vex8vXI1YLMiGY+QZzL5IhS1seMUworEdwzkCLwPiUD7ZKHrBN99n2HsZ47xD/YrDMjdyKb/87yCxzZFb5ZjSQb6QjSKpNrfsTZjhX8F1eTwSYtByLRfw7kRTj/IkHi3OkKHee4KuqRsgSZmuzCcKO4pU9RCl+wF6uknkNyYwfdsK7wrvh7Go6GNfCl/B5AK3Gi4g/Zcd4HcahTxT1I9l2JQ9W/sTnRVmtsuG7k/pbwmvUYdk/ZpMJKcqImjxsaMtN3Y2l0QeYRk3AZRPv88EthWjZR45LtA+oF6fHROi49hz3JPmJUd6mzKy2AcSji23KepEPYDVGdMFAe6Va6u0AVxV8T6j5SdtK6PBehA0RY/hFUGmBoeUTJaUsD2PAc39wT478n8qL+QhbzC9uSGvsNE/Xrx0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(6916009)(47076005)(356005)(86362001)(44832011)(70206006)(8676002)(41300700001)(70586007)(8936002)(5660300002)(316002)(81166007)(2616005)(426003)(336012)(83380400001)(36860700001)(82740400003)(66574015)(16526019)(26005)(478600001)(1076003)(6666004)(40460700003)(4326008)(966005)(54906003)(36756003)(186003)(7696005)(2906002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:15:18.8034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a5b5c6-0761-4988-21e0-08db727b169f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Translate Documentation/process/researcher-guidelines.rst into Spanish

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |   1 +
 .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 0bdeb1eb4403..ed6851892661 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -20,3 +20,4 @@
    programming-language
    deprecated
    adding-syscalls
+   researcher-guidelines
diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
new file mode 100644
index 000000000000..9d374c70348c
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
@@ -0,0 +1,152 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Original: :ref:`Documentation/process/researcher-guidelines.rst`
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+.. _sp_researcher_guidelines:
+
+Directrices para Investigadores
+++++++++++++++++++++++++++++++++
+
+La comunidad del kernel de Linux da la bienvenida a la investigación
+transparente sobre el kernel de Linux, las actividades involucradas
+en su producción, otros subproductos de su desarrollo. Linux se
+beneficia mucho de este tipo de investigación, y la mayoría de los
+aspectos de Linux son impulsados por investigación en una forma u otra.
+
+La comunidad agradece mucho si los investigadores pueden compartir
+los hallazgos preliminares antes de hacer públicos sus resultados,
+especialmente si tal investigación involucra seguridad. Involucrarse
+temprano ayuda a mejorar la calidad de investigación y la capacidad
+de Linux para mejorar a partir de ella. En cualquier caso, se recomienda
+compartir copias de acceso abierto de la investigación publicada con
+la comunidad.
+
+Este documento busca clarificar lo que la comunidad del kernel de Linux
+considera practicas aceptables y no aceptables al llevar a cabo
+investigación de este tipo. Por lo menos, dicha investigación y
+actividades afines deben seguir las reglas estándar de ética de la
+investigación. Para más información sobre la ética de la investigación
+en general, ética en la tecnología y la investigación de las comunidades
+de desarrolladores en particular, ver:
+
+
+* `Historia de la Ética en la Investigación <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
+* `Ética de la IEEE <https://www.ieee.org/about/ethics/index.html>`_
+* `Perspectivas de Desarrolladores e Investigadores sobre la Ética de los Experimentos en Proyectos de Código Abierto <https://arxiv.org/pdf/2112.13217.pdf>`_
+
+La comunidad del kernel de Linux espera que todos los que interactúan con
+el proyecto están participando en buena fe para mejorar Linux. La
+investigación sobre cualquier artefacto disponible públicamente (incluido,
+pero no limitado a código fuente) producido por la comunidad del kernel
+de Linux es bienvenida, aunque la investigación sobre los desarrolladores
+debe ser claramente opcional.
+
+La investigación pasiva que se basa completamente en fuentes disponibles
+públicamente, incluidas las publicaciones en listas de correo públicas y
+las contribuciones a los repositorios públicos, es claramente permitida.
+Aunque, como con cualquier investigación, todavía se debe seguir la ética
+estándar.
+
+La investigación activa sobre el comportamiento de los desarrolladores,
+sin embargo, debe hacerse con el acuerdo explícito y la divulgación
+completa a los desarrolladores individuales involucrados. No se puede
+interactuar / experimentar con los desarrolladores sin consentimiento;
+esto también es ética de investigación estándar.
+
+Para ayudar a aclarar: enviar parches a los desarrolladores es interactuar
+con ellos, pero ya han dado su consentimiento para recibir contribuciones
+en buena fe. No se ha dado consentimiento para enviar parches intencionalmente
+defectuosos / vulnerables o contribuir con la información engañosa a las
+discusiones. Dicha comunicación puede ser perjudicial al desarrollador (por
+ejemplo, agotar el tiempo, el esfuerzo, y la moral) y perjudicial para el
+proyecto al erosionar la confianza de toda la comunidad de desarrolladores en
+el colaborador (y la organización del colaborador en conjunto), socavando
+los esfuerzos para proporcionar reacciones constructivas a los colaboradores
+y poniendo a los usuarios finales en riesgo de fallas de software.
+
+La participación en el desarrollo de Linux en sí mismo por parte de
+investigadores, como con cualquiera, es bienvenida y alentada. La
+investigación del código de Linux es una práctica común, especialmente
+cuando se trata de desarrollar o ejecutar herramientas de análisis que
+producen resultados procesables.
+
+Cuando se interactúa con la comunidad de desarrolladores, enviar un
+parche ha sido tradicionalmente la mejor manera para hacer un impacto.
+Linux ya tiene muchos errores conocidos – lo que es mucho más útil es
+tener soluciones verificadas. Antes de contribuir, lea cuidadosamente
+la documentación adecuada.
+
+* Documentation/process/development-process.rst
+* Documentation/process/submitting-patches.rst
+* Documentation/admin-guide/reporting-issues.rst
+* Documentation/process/security-bugs.rst
+
+Entonces envíe un parche (incluyendo un registro de confirmación con
+todos los detalles enumerados abajo) y haga un seguimiento de cualquier
+comentario de otros desarrolladores.
+
+* ¿Cuál es el problema específico que se ha encontrado?
+* ¿Como podría llegar al problema en un sistema en ejecución?
+* ¿Qué efecto tendría encontrar el problema en el sistema?
+* ¿Como se encontró el problema? Incluya específicamente detalles sobre
+  cualquier prueba, programas de análisis estáticos o dinámicos, y cualquier
+  otra herramienta o método utilizado para realizar el trabajo.
+* ¿En qué versión de Linux se encontró el problema? Se prefiere usar la
+  versión más reciente o una rama reciente de linux-next (ver
+  Documentation/process/howto.rst).
+* ¿Que se cambió para solucionar el problema y por qué se cree es correcto?
+* ¿Como se probó el cambio para la complicación y el tiempo de ejecución?
+* ¿Qué confirmación previa corrige este cambio? Esto debería ir en un “Fixes:”
+  etiqueta como se describe en la documentación.
+* ¿Quién más ha revisado este parche? Esto debería ir con la adecuada “Reviewed-by”
+  etiqueta; Vea abajo.
+
+Por ejemplo (en inglés, pues es en las listas)::
+
+  From: Author <author@email>
+  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
+
+  The error path in foo_bar driver does not correctly free the allocated
+  struct foo_bar_info. This can happen if the attached foo_bar device
+  rejects the initialization packets sent during foo_bar_probe(). This
+  would result in a 64 byte slab memory leak once per device attach,
+  wasting memory resources over time.
+
+  This flaw was found using an experimental static analysis tool we are
+  developing, LeakMagic[1], which reported the following warning when
+  analyzing the v5.15 kernel release:
+
+   path/to/foo_bar.c:187: missing kfree() call?
+
+  Add the missing kfree() to the error path. No other references to
+  this memory exist outside the probe function, so this is the only
+  place it can be freed.
+
+  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
+  11.2 show no new warnings, and LeakMagic no longer warns about this
+  code path. As we don't have a FooBar device to test with, no runtime
+  testing was able to be performed.
+
+  [1] https://url/to/leakmagic/details
+
+  Reported-by: Researcher <researcher@email>
+  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
+  Signed-off-by: Author <author@email>
+  Reviewed-by: Reviewer <reviewer@email>
+
+Si usted es un colaborador por primera vez, se recomienda que el parche en
+si sea examinado por otros en privado antes de ser publicado en listas
+públicas. (Esto es necesario si se le ha dicho explícitamente que sus parches
+necesitan una revisión interna más cuidadosa.) Se espera que estas personas
+tengan su etiqueta “Reviewed-by” incluida en el parche resultante. Encontrar
+otro desarrollador con conocimiento de las contribuciones a Linux, especialmente
+dentro de su propia organización, y tener su ayuda con las revisiones antes de
+enviarlas a las listas de correo publico tiende a mejorar significativamente la
+calidad de los parches resultantes, y reduce así la carga de otros desarrolladores.
+
+Si no se puede encontrar a nadie para revisar internamente los parches y necesita
+ayuda para encontrar a esa persona, o si tiene alguna otra pregunta relacionada
+con este documento y las expectativas de la comunidad de desarrolladores, por
+favor contacte con la lista de correo privada Technical Advisory Board:
+<tech-board@lists.linux-foundation.org>.
-- 
2.34.1

