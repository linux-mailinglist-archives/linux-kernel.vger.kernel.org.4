Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E7738A91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjFUQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:12:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1221989;
        Wed, 21 Jun 2023 09:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjgpDszjVrOb42l1KD7Ho4XmMDIquNaBhnc/80VwqfF/QTgLoVxL61q7vtYfQzv4b1biWLSlRUd7Lx3PHh/qbDFIswSmWXw+yC2iYGg5rNQX6lQXfgFay38BQeAVQFk/4Rw2oducfFbP9xFNRXI/IcOfKoqtImr6Wq7qUzCRZK3lMnjHbN0k76QD6dYUHUWmK2qhyA/Vg5oSZSXciqkX9OLSf6wbjIMJII0iZnVPIPY/DD2IllHEKI4mmQlpzyzzr3niRCFNnB4xCH5iffGxluTo3aPUM2eD7/9fcP2HzaxPFIdnBMBfL+IHctTCcb2m8W6JM/ew/yV3eV0QSLyVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqjXXNkiNPR6LZyUhjFOt1foS2Xa9KxGD0Y6lN49KEA=;
 b=IS2mn0lXPliau3TIaXi+FjW1LAO0eiOzmgz8bjz9k/oDvDRNM6TST2DWYzGUvf6cbWoeBLfYOgg/oRNvFvOJEJ/t0Mbk9OkLPhvb5x+w8Qs6PLDEP4kwxG+1+MSf/CPDXyIO9nyw0HQ11oS0XPKZytDt6umFRu+9FakKn486UUNNx4Qt/01OixpG0R91aCfA5Hk2q8+B7pmWlp4ztBbIy92kdu8ggPaAVAtzBhTtYBG/LALwlukrx1gCD3musBYLFPBcKVHL1vWDrDoiNXquatyovdKc7LqahRdY8QMHsib8LFNMUeHxGsYhnCz9PUH31QJoLL35vWYn7CDBZStOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqjXXNkiNPR6LZyUhjFOt1foS2Xa9KxGD0Y6lN49KEA=;
 b=yD/CkMvBY3Ia017wGFLaxoXeJmxdzhlgK+Rx8UdJ3REg36xnWCCeMR6dt8DDs+TOyT9JqeW/4T/gmu42PEoOxS3va29p3ZP4djbuGGgVRCGBeaFOJKzqP9cyiDsSLoF/uYgVaeiWesVTyXEGFcnSoFesGnKzaLFV18bX2giK25w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:12:24 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::ddd3:9069:b6e9:ed8d%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 16:12:24 +0000
Message-ID: <acaf049e-640d-0a57-0e62-75aa55fb3b27@amd.com>
Date:   Wed, 21 Jun 2023 11:12:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH] docs/sp_SP: Add translation of process/researcher-guidelines
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avadhut Naik <avadhut.naik@amd.com>
References: <20230619192716.21473-1-avadhut.naik@amd.com>
 <9a00b133-2cc4-2600-c19c-761869b9e40e@amd.com>
Content-Language: en-US
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <9a00b133-2cc4-2600-c19c-761869b9e40e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:805:f2::48) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|BN9PR12MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: cd06912d-5e67-4e99-f18b-08db72724cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aeculow3+/JpmXjl80pgzqlQrjPtff6YYqcFfU/tyxCz4DNzJYvTcYs5831+qqYWwB+xscM1vKKwVYNAXfPZCDErP+CudV/DqIMJHrA5ARnkrUMiTUcNnrOG3tBhmohzJuKQ3cTBkEtIGyEbKUsfRskm1i/8+am3aPUcWddhxN5I3mgr1ADBmtV/o2FWnGCwlCr16kVUFemaqrDIUcnLJFRHz/wpPYZDx5pxICnTGg4T4MkmuBWyrIjDLh01z7qoAjP9Jyg9iT9IjhL7Ka1ZepGe/7yXbO0n4BZbSrLlfcIBSbOHa7s2U9W9V/REIsxt/W45TGnBj+5rWts8vWZby6enCWuIWE4F9VpB8gbg3eLXIHbvMW9cgneIw11pxIZ29wcM3sfWXo+Al6eU/GtssyhYF8WEUmzyYXRHWWQSd0uDY4+yH+NXEQOlN5xyd14Sm0Dm8qfdTkCbuR/I3RdSQ9zYCXkf+coJbn3ohD33k7LFHZ+eoBO25VAwzEE2xdKw9tzoO1sqv0EhcDxLQ+dvwc/5J1k4EuyjHH9Ux5rkTzgHqeCIrnsoOX8/J5VNAsCufy7IUdCCHwRrsdH0EbMPm7GYTAZEyDSnUQmVoUBF5AGt+X0n8E0iaryMVaq6K1xkyQlZHl10ezcn83PnBPOu3BCs+hTfuvrPpZ800bQCs4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:es;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(478600001)(4326008)(26005)(966005)(186003)(53546011)(6506007)(6486002)(6512007)(2906002)(30864003)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(5660300002)(316002)(31696002)(36756003)(66574015)(83380400001)(2616005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHoyakI3aTVMd2REZytBNEFWaFA4cnlSeVU4UmJjYlNQYjZBMFExUFFOMnpG?=
 =?utf-8?B?R1YvdW9xb0VNcnZPSW8zM2Z3NXpzQjRSRk0wTDl2WU1pb1gvalNmYmd0SlM5?=
 =?utf-8?B?cVFvS0o3ODRqWUczaUU0NS90eXlhbE0xelBsbzhFNTNNQ0RhR0dGUXNoZHhY?=
 =?utf-8?B?bzAvTHd3RTdqQ3owZDNmY2tTNjBpbmNzaGU4b0t5MWg3RjdSQ1VqUUtmK05P?=
 =?utf-8?B?d3hWdURUWmRCNjQ5Q0pVOHNwQnNZcmJUUjJSVlJTR2ZyRkZQS0xTdkdMQytP?=
 =?utf-8?B?ejVhdy9KK2dqTXFKSys0L0Y4VHBqRVpVWEFuQVVtYXVkdk1pTUJ5dXc4Rld3?=
 =?utf-8?B?UEdhMjJPYXFQNm1IODFCUkMzRjIybTFBbjduNHI4SUZJczFJTEV5bGRmc1NY?=
 =?utf-8?B?KzFsOGloWkdWYlNYZTBBZllTM3o1L0Y5bGRGZURBZTNOZFhSSml1eEhMWDdn?=
 =?utf-8?B?cjQxS0w4UUU3dEh6NDJrYnpWblpneTVQLytsdzdwdlB5dm5yOHB2ZDN2VzUy?=
 =?utf-8?B?d2VURzNIakNVQ0xBSy82bUdFdVVmL1NEdXhSMUxWTXBKQjhPb2dtcTJ6KzN0?=
 =?utf-8?B?N2FtS21XbW0rb0dkUmdnTTl1dTJ0OG1BQnNMRnY5aTRFRHNGdUJ2dW4vMzBo?=
 =?utf-8?B?NE1mN0drTjFhM3Y1YXRVQ1F4ZEdrSVJjSENtOUJmZnJQQ3J5L3VWWWM2Z1Nt?=
 =?utf-8?B?ZlZxOE9jODcvWmlCMGxETngyZ2g0eitMRHpOQUgvVkI3TzBvTmY0U1BlV1hG?=
 =?utf-8?B?ZERNVXlTRXFGM0pSSDNBRThDcy8wRmtlZ0FKaVJaTGhzUlVwNWZVZHpuSVZP?=
 =?utf-8?B?NnBXUkpMZkZUanFIdkZIa3ByWXNzOFhyUVJHZ1pJQmVtRTBpM0N0djV6WjhY?=
 =?utf-8?B?MFRkdmIvMCtCeXVwVDQ0YmlsRzFwRVQrbEc0aUxhU2U1S2VubGFLTFU4cXRM?=
 =?utf-8?B?bXNBV3hCSVYwU3F5eU4yNmRQcVlzai9nZlRPdEJjRVRaeU0ycjhSWjZyVzZy?=
 =?utf-8?B?dWJudUFvR0FVOHVvR2lOMzN6bHBOM3ZIMlVKNmxhblcvQlB5R1E3UkdBZW9y?=
 =?utf-8?B?amdTK2JpcWt0MW13c0dhcXVKSUl0ZGJ5L0gxSGgrejBXNkgvZmhFTjV6WGZG?=
 =?utf-8?B?eVdrMmRaWGp0V3craXkyVC9ZU2hxWEdVbnh2TDNDVndBYnE3WUxpdzNvcEt2?=
 =?utf-8?B?NXN1V2xZVTJzbmpFc1JQMm1uSUNiQ2pqNS9QWVo2SVF5SjVUR1JLZEIrUE1X?=
 =?utf-8?B?aWRreTNEK2hoc3M1UUtvODdnK29iaW1WTFRYRk1oeDZoMjJvTTdKRHZBZkov?=
 =?utf-8?B?c1lCcVNCWmozOEk4T1pqMVA5dlBBcmZBR1I4aTh5Z25YQmszS3JZK3dsZjRV?=
 =?utf-8?B?VVBQYmxBRGFESEFXVFdSQnBCR3c3SUZseXR6OXpnMFFBazRrdmg5VU1MQ2Jx?=
 =?utf-8?B?K2ttZTNKcVNrTTF6ZHgxRmtnbzFjWCs2bFZsNzlFSG16SVdzUWV4YU9HTHN0?=
 =?utf-8?B?aHp6MTk1ejZycEl2elFDZkZJTXdINE9ObSt6aWQ1aGhaV3hnWEl2ckZpeTZy?=
 =?utf-8?B?Q2hLSVJjRzhhU1AyNmlYeDNQV2FrQmV6dW5jUWpLaEpraERSNEJpcGpqYUw3?=
 =?utf-8?B?cXIvVlpPSnVPUFIrN3M2Rkp1UWJPOGZRbVRrWmxhV3N4Y3Y1SHlXRmpEcEJP?=
 =?utf-8?B?RlZ2QWZRTWFpNlhpdEk5LzdWSVhlRDJiK1FmVXBaU3B6Wk1zSG4vZDNhZVpx?=
 =?utf-8?B?ZklGbGdEWGk4K3RKTDd2akFReUJLTGNRMXYrR2xrb0YxcDR1WnJNSnNhdkRO?=
 =?utf-8?B?OXhyUzlXTXVWZzRpaU00RGlRbUJjWkQ2eDJwbXYrTjRkazZxaUh5Z2hkNHRM?=
 =?utf-8?B?NHJyY2VZbGRzcXFCOEJVOU93eUViU082MS9WNWw1enErbzlNS2pvSkNaa01h?=
 =?utf-8?B?bWJCN1R1Z0g5N0V1aGtoZWJCYzBLcE4xdzBBY3pYdG5keDQ5eWZyOThwbVM4?=
 =?utf-8?B?ejNMbzE0VGxNbE1XVmZ2VWlqYTNFTDdSdzdBY2ZLZUNCOXc2T2hPSjBCaU01?=
 =?utf-8?B?cWpadTVlMnFtM01rUTNkVzgzNHFXYkduclpQVzRjREZReDlMeHdZUUZIL0ZM?=
 =?utf-8?Q?YRvdZEuoBb78eniWUUpsYOuwn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd06912d-5e67-4e99-f18b-08db72724cd3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:12:24.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAeuj6yLEGrQL0RCC6LPmKICOtDafjag+hSyUekmScdetjSAUg8u+Gb5Ujxuurw8GVD+fOhj/ZjendPfLrCP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Thanks for reviewing.

On 6/20/2023 08:40, Carlos Bilbao wrote:
> On 6/19/23 2:27 PM, Avadhut Naik wrote:
>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>
>> Translate Documentation/process/researcher-guidelines.rst into Spanish
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  .../translations/sp_SP/process/index.rst      |   1 +
>>  .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
>>  2 files changed, 153 insertions(+)
>>  create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst
>>
>> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
>> index 0bdeb1eb4403..ed6851892661 100644
>> --- a/Documentation/translations/sp_SP/process/index.rst
>> +++ b/Documentation/translations/sp_SP/process/index.rst
>> @@ -20,3 +20,4 @@
>>     programming-language
>>     deprecated
>>     adding-syscalls
>> +   researcher-guidelines
>> diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
>> new file mode 100644
>> index 000000000000..32d1810733e4
>> --- /dev/null
>> +++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
>> @@ -0,0 +1,152 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +:Original: :ref:`Documentation/process/researcher-guidelines.rst`
>> +:Translator: Avadhut Naik <avadhut.naik@amd.com>
>> +
>> +.. _sp_researcher_guidelines:
>> +
>> +Directrices para Investigadores
>> +++++++++++++++++++++++++++++++++
>> +
>> +La comunidad del kernel de Linux da la bienvenida a la investigación
>> +transparente sobre el kernel de Linux, las actividades involucradas
>> +en su producción, otros subproductos de su desarrollo. Linux se
>> +beneficia mucho de este tipo de investigación, y la mayoría de los
>> +aspectos de Linux son impulsados por investigación en una forma o otra.
> 
> s/una forma o otra/una forma u otra
> 
>> +
>> +La comunidad agradece mucho si los investigadores pueden compartir
>> +los hallazgos preliminares antes de hacer públicos sus resultados,
>> +especialmente si tal investigación involucra seguridad. Involucrarse
>> +temprano ayuda a mejorar la calidad de investigación y la capacidad
>> +de Linux para mejorar a partir de ella. En cualquier caso, se recomienda
>> +compartir copias de acceso abierto de la investigación publicada con
>> +la comunidad.
>> +
>> +Este documento busca clarificar lo que la comunidad del kernel de Linux
>> +considera practicas aceptables y no aceptables al llevar a cabo
>> +investigación de este tipo. Por lo menos, dicha investigación y
>> +actividades afines deben seguir las reglas estándar de ética de la
>> +investigación. Para más información sobre la ética de la investigación
>> +en general, ética en la tecnología y la investigación de las comunidades
>> +de desarrolladores en particular, ver:
>> +
>> +
>> +* `Historia de la Ética en la Investigación <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
>> +* `Ética de la IEEE <https://www.ieee.org/about/ethics/index.html>`_
>> +* `Perspectivas de Desarrolladores e Investigadores sobre la Ética de los Experimentos en Proyectos de Código Abierto <https://arxiv.org/pdf/2112.13217.pdf>`_
>> +
>> +La comunidad del kernel de Linux espera que todos los que interactúan con
>> +el proyecto están participando en buena fe para mejorar Linux. La
>> +investigación sobre cualquier artefacto disponible públicamente (incluido,
>> +pero no limitado a código fuente) producido por la comunidad del kernel
>> +de Linux es bienvenida, aunque la investigación sobre los desarrolladores
>> +debe ser claramente opcional.
>> +
>> +La investigación pasiva que se basa completamente en fuentes disponibles
>> +públicamente, incluidas las publicaciones en listas de correo públicas y
>> +las contribuciones a los repositorios públicos, es claramente permitida.
>> +Aunque, como con cualquier investigación, todavía se debe seguir la ética
>> +estándar.
>> +
>> +La investigación activa sobre el comportamiento de los desarrolladores,
>> +sin embargo, debe hacerse con el acuerdo explícito y la divulgación
>> +completa a los desarrolladores individuales involucrados. No se puede
>> +interactuar / experimentar con los desarrolladores sin consentimiento;
>> +esto también es ética de investigación estándar.
>> +
>> +Para ayudar a aclarar: enviar parches a los desarrolladores es interactuar
>> +con ellos, pero ya han dado su consentimiento para recibir contribuciones
>> +en buena fe. No se ha dado consentimiento para enviar parches intencionalmente
>> +defectuosos / vulnerables o contribuir con la información engañosa a las
>> +discusiones. Dicha comunicación puede ser perjudicial al desarrollador (por
>> +ejemplo, agotar el tiempo, el esfuerzo, y la moral) y perjudicial para el
>> +proyecto al erosionar la confianza de toda la comunidad de desarrolladores en
>> +el colaborador (y la organización del colaborador en conjunto), socavando
>> +los esfuerzos para proporcionar reacciones constructivas a los colaboradores
>> +y poniendo a los usuarios finales en riesgo de fallas de software.
>> +
>> +La participación en el desarrollo de Linux en sí mismo por parte de
>> +investigadores, como con cualquiera, es bienvenida y alentada. La
>> +investigación del código de Linux es una práctica común, especialmente
>> +cuando se trata de desarrollar o ejecutar herramientas de análisis que
>> +producen resultados procesables.
>> +
>> +Cuando se interactúa con la comunidad de desarrolladores, enviar un
>> +parche ha sido tradicionalmente la mejor manera para hacer un impacto.
>> +Linux ya tiene muchos errores conocidos – lo que es mucho más útil es
>> +tener soluciones verificadas. Antes de contribuir, lea cuidadosamente
>> +la documentación adecuada.
>> +
>> +* Documentation/process/development-process.rst
>> +* Documentation/process/submitting-patches.rst
>> +* Documentation/admin-guide/reporting-issues.rst
>> +* Documentation/process/security-bugs.rst
>> +
>> +Entonces envíe un parche (incluyendo un registro de confirmación con
>> +todos los detalles enumerados abajo) y haga un seguimiento de cualquier
>> +comentario de otros desarrolladores.
>> +
>> +* ¿Cuál es el problema específico que se ha encontrado?
>> +* ¿Como podría llegar al problema en un sistema en ejecución?
>> +* ¿Qué efecto tendría encontrar el problema en el sistema?
>> +* ¿Como se encontró el problema? Incluya específicamente detalles sobre
>> +  cualquier prueba, programas de análisis estáticos o dinámicos, y cualquier
>> +  otra herramienta o método utilizado para realizar el trabajo.
>> +* ¿En qué versión de Linux se encontró el problema? Se prefiere usar la
>> +  versión más reciente o una rama reciente de linux-next (ver
>> +  Documentation/process/howto.rst).
>> +* ¿Que se cambió para solucionar el problema y por qué se cree es correcto?
>> +* ¿Como se probó el cambio para la complicación y el tiempo de ejecución?
>> +* ¿Qué confirmación previa corrige este cambio? Esto debería ir en un “Fixes:”
>> +  etiqueta como se describe en la documentación.
>> +* ¿Quién más ha revisado este parche? Esto debería ir con la adecuada “Reviewed-by”
>> +  etiqueta; Vea abajo.
>> +
>> +For example::
> 
> s/For example/Por ejemplo (en inglés, pues es en las listas):
> 
>> +
>> +  From: Author <author@email>
>> +  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
>> +
>> +  The error path in foo_bar driver does not correctly free the allocated
>> +  struct foo_bar_info. This can happen if the attached foo_bar device
>> +  rejects the initialization packets sent during foo_bar_probe(). This
>> +  would result in a 64 byte slab memory leak once per device attach,
>> +  wasting memory resources over time.
>> +
>> +  This flaw was found using an experimental static analysis tool we are
>> +  developing, LeakMagic[1], which reported the following warning when
>> +  analyzing the v5.15 kernel release:
>> +
>> +   path/to/foo_bar.c:187: missing kfree() call?
>> +
>> +  Add the missing kfree() to the error path. No other references to
>> +  this memory exist outside the probe function, so this is the only
>> +  place it can be freed.
>> +
>> +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
>> +  11.2 show no new warnings, and LeakMagic no longer warns about this
>> +  code path. As we don't have a FooBar device to test with, no runtime
>> +  testing was able to be performed.
>> +
>> +  [1] https://url/to/leakmagic/details
>> +
>> +  Reported-by: Researcher <researcher@email>
>> +  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
>> +  Signed-off-by: Author <author@email>
>> +  Reviewed-by: Reviewer <reviewer@email>
>> +
>> +Si usted es un colaborador por primera vez, se recomienda que el parche en
>> +si sea examinado por otros en privado antes de ser publicado en listas
>> +públicas. (Esto es necesario si se le ha dicho explícitamente que sus parches
>> +necesitan una revisión interna más cuidadosa.) Se espera que estas personas
>> +tengan su etiqueta “Reviewed-by” incluida en el parche resultante. Encontrar
>> +otro desarrollador con conocimiento de las contribuciones a Linux, especialmente
>> +dentro de su propia organización, y tener su ayuda con las revisiones antes de
>> +enviarlas a las listas de correo publico tiende a mejorar significativamente la
>> +calidad de los parches resultantes, y reduce así la carga de otros desarrolladores.
>> +
>> +Si no se puede encontrar a nadie para revisar internamente los parches y necesita
>> +ayuda para encontrar a esa persona, o si tiene alguna otra pregunta relacionada
>> +con este documento y las expectativas de la comunidad de desarrolladores, por
>> +favor contacte con la lista de correo privada Technical Advisory Board:
>> +<tech-board@lists.linux-foundation.org>.
> 
> Other than that, my Reviewed-By stays :) thanks Avadhut!
> 
	ACK to all suggestions. Will incorporate and resubmit.

Thanks,
Avadhut Naik

> Best,
> Carlos

-- 
