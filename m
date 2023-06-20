Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE9736D86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjFTNks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:40:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8AA9B;
        Tue, 20 Jun 2023 06:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp+6mxOVnSqPTLMz6wnEc81/W5c98pxEDN1fFcU3RYA5DL7xOrXLsKdoloa+4KWgRxyvqJEQ+ePzmBxs2J6Vil56C0T0CvWq79QVu+QKRedbkdUzj0aMrh7ypesjkgANnXBxkUOvfQP0HJxqBWS066/+1Hc+557BeNASgabIXLgDnibIAliaM18mRTxTUb3DsyDVMp51MeuGCLsYYaF6VINtgprFonJFdvx2MQFGlMkkvMxzYLj1+1hvUfUbCnWa72kB4Ky283hJLMZBrzhmN2mDlTtrxgfWLMbM4vSlKGv7HTkRbvvK2lS6lEzvZsJ2XdKFcDM3lqGbGr61+LjAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGOtumjiaGMsyG5PG9ayixa1/1ufy/MGoKeOqouylVE=;
 b=icHXXvLc9AiBEPnxmLssL14WVjF2bnglqkAkJtlStPu2Z9qF+0+jDFZd1lmLHtJkETuEJujxRV6v9KwkQ+znkv+vqcXwwp4SCAuML+Eed5kvguBfBOZsEL43lqNVkjrZF8q5WYF6Owt3w2ybt2tLhmQWiZ5X5/kR2D5WIA549XGUjAWx1TRrEDvhHI5d9yd6ut+V/bD7cCK4BKT+dcxNcjvUE6DZ1gleV4TGdD2MCnvXbOGZ+q0Tnlb5jxn67KlYF7eRUlfHrMiDqVJU28LzjBlQ4cXG09xLMHWO1PlGvDJGgOPOANRbREtV4m8VKjDe+VuFi/M7BL3MTqKS6mNoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGOtumjiaGMsyG5PG9ayixa1/1ufy/MGoKeOqouylVE=;
 b=tGSXEqwMkV0c6R1GP7UPknwi/9LSkbUdkovIWgxCjWILHrvjdG2pJZAH+ONx2eh22ji8Q7wGSezKXZ7Vg0ARiqKtRFKVuOpfZIeUP1C6zLgRJOVhzKIQ8hSuGvwWPTkmPEvhh7zOOzPUDTLvE8hmCTJmuo2ntMDFji4MzZKUeHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) by
 PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 13:40:37 +0000
Received: from DM4PR12MB5891.namprd12.prod.outlook.com
 ([fe80::64c1:f67c:2ca4:1be1]) by DM4PR12MB5891.namprd12.prod.outlook.com
 ([fe80::64c1:f67c:2ca4:1be1%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:40:37 +0000
Message-ID: <9a00b133-2cc4-2600-c19c-761869b9e40e@amd.com>
Date:   Tue, 20 Jun 2023 08:40:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] docs/sp_SP: Add translation of
 process/researcher-guidelines
Content-Language: en-US
To:     Avadhut Naik <avadhut.naik@amd.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        avadnaik@amd.com
References: <20230619192716.21473-1-avadhut.naik@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230619192716.21473-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To DM4PR12MB5891.namprd12.prod.outlook.com
 (2603:10b6:8:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5891:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f1fc1c-1c71-4a00-7b94-08db7193edec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjSMhks+YdSlt+c5Q1Ujfc0xNW/exxtdSzdGJHQ4xciaiRDbY54gNpckOjA8k+00sQoZ1MbpHwYEM7jCHaV62VZzf5O0v0JTeXzpglzClRz2pUXR9Cy4ZNJioU6MXJyujxlT6NiHje6vxUhlec6PtUQswPJimieYYiOlOYOWhYquaC78m2tsTK25rsQnNKVQ29nR4o1KjoZ0vOWgJ7ajVJ3loAUftrTdclTq73GviMsA2Muyur/FXSs79yzBFSkll7sBKGLjdbvBLLb5UDU5Ao5KPf7g6Vou/dPn/OlWJTFeoFsXFblJyMxW8dItYk1WL9AzTx3Mwrloz2BexQNtec8woNyUicjr7AAnpqnZW1bjdS2hQMw9sfYa/wmHEQYmUJYkiCW17cK3xRC/nTPrbCiqfkXmkgH8K7rqc++pjhSZRV1jX09snd05foiRqsNPbBk6dEMCy4M/kNmGiEkBeYrD6dsZdWVIJBJs9kTjtxie/TIn0eTsLjYmzq6JJFh3bzzmhcwjxXDkzgY3uEmlgTJdQngLW3a3bkEe3VhOEqWQrxYKuJIu1ze+XY/AcyYqZrBZZLstcXrW5nG4Lk10mLeGnYsGeUKr4SeaA23Fb4JVsAsTxpJFip8GYn2PN2Tt3vUKhY/Hvm3N6Qezvsrqkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:es;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5891.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(31686004)(36756003)(44832011)(5660300002)(8936002)(8676002)(41300700001)(66556008)(66476007)(4326008)(38100700002)(31696002)(316002)(86362001)(66946007)(6486002)(966005)(66574015)(6506007)(6512007)(53546011)(186003)(2906002)(478600001)(2616005)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFxcjYxS3p2Q2pZRVAyRGFLc3pUNGFid3R2MVdsaDNTVjZXTmNMcElYdGty?=
 =?utf-8?B?YlRUY042REh5UFptNWJ4L2FYTGx5aGdvemtyQndBdU5ORWgyVXZRa2hKQUl0?=
 =?utf-8?B?eFdsYmhIY3JtcFJ3WlgzbGdSblBUM25RVHY5VURNWjJ2SnNjZmgzQ0hXdTE3?=
 =?utf-8?B?ZkVJY1cyVkppRG5YSzRQcjkxd2VUWlh2MTVERGtOZjVXS214QldnZTJCRDlC?=
 =?utf-8?B?MHdsQldyKzUveDhJa3UrbmRkQmNFa3F0M0Rrc2U1MklFd0dOeXRLK1IyQ3hV?=
 =?utf-8?B?UEZIMm1sOEUyMm1JUTh1NjF6d3N5dGtia3ptVnJKSWNIM1JoTElyOFJBMWl4?=
 =?utf-8?B?cThhYWF0R3p3bGxCTUYvNG1RaTN1NGF3SVNLTWY5VERHdlQrVzgvVHhDZ3hD?=
 =?utf-8?B?Z21WbkR1bkVMTnY4SEErNk81end6OXgzRzZiRWF5L3RjemJpN1UvQWhtWmEr?=
 =?utf-8?B?UVZNTFdFaE9KNzVWaVNCR00vYjJaQkJDelNrOGZ5dnMrRXJJSjlTbXRVM0RP?=
 =?utf-8?B?b3daSTZDZHlKNnhsQjhGYzNLT2VQM290ZTlUVzJCRVVZa1RoQ2lzRXdJZlpR?=
 =?utf-8?B?RFNtZ1lla290aHZnMEdBMTQ5aS9pYktzSWRKaFd5L0xlYUJRVVZKcEFVL21H?=
 =?utf-8?B?RjFCcFRMQUsyTmgyNmNVKzlFYXZOOXRlU3lNdjIrUWhnU3o4b2oyZXRvbXc4?=
 =?utf-8?B?VWFxdzhSWWpsZXhGVTNYTnZDUU9Qak5kcEkvYmgzN1VST08zRGkrT0NrbnlF?=
 =?utf-8?B?bkowbVZVd0UxWU1sSjNrcVpHOU9GQ1BnMU13ZytONFd4cWU0OXFwV1gxck1x?=
 =?utf-8?B?cyt5VE5icDVia3ZBdUszOStTeTlBYWF2Q24vN2Y2Vy9tdkd2RllZK2pESTJU?=
 =?utf-8?B?ZWNhQ2ZsWVk5SUtrVm9GZjl4M2hMSm9iNExOMllFWFZKTm1PcVVZN0ZSUHVB?=
 =?utf-8?B?RHVqaXUyYnZOSFJJbDdadXFRSC96UytWVUZLNmErdllRNXBhS3RBUWpGblI4?=
 =?utf-8?B?S0VmcE5qNG01ajhnNW9BMVVvV254aU51Z0x2YzJsSFZkdEFOdGZKUkdKWGRT?=
 =?utf-8?B?Z0lTWDhyWDUyTFhCQjdMU0pUQzFZUWJZb1ZWSXBOU0R4R1I2ZC9qaVovUFNF?=
 =?utf-8?B?T0l0TGtHR1l0OHRjZWt5UkZVWlJzQ1MwM3QybnN6ZHNEd0lKdDRlZUNzeXFx?=
 =?utf-8?B?cUpxK0psd3VYczJuS0p2VlFLeEIxWmdnUCt2NllLbWdGWG9zMFp5eWJYRGZX?=
 =?utf-8?B?Vk8wcDhuTVFhdWJMNWZQQm1acDM5Rkc3WlJTWDFmaEZPRjVQT1htbjJiczhm?=
 =?utf-8?B?SU1OMFczcmlUVithM3NHZWxqREJYcHVjQXFqbnY4QzE1ZWFwbm42UUxxaWcz?=
 =?utf-8?B?Y3RQZTloZi9PV29IRkg0eWVEbFYwQ2dkZzJqbUZzTy9Wdmg1Vi9idlVXQnFu?=
 =?utf-8?B?RHRGTXF4OHRHSytKNVNaUEV5eVdxVmdNQlljMDBNY0Z3T0RveTJTWDlaaitp?=
 =?utf-8?B?dGlCM3RJWDdHZnpCcCsvdlVYemlQZWIwNHNLOTk3TWNPNCtHb0pyNU5tVkxD?=
 =?utf-8?B?c2VUclc1Zmc3ZG10L3FKa0lJZjloSnVyVUs2UkZhT2ZRRFNuREFIc1djS1BQ?=
 =?utf-8?B?cTlaWWgzZWVwSzFUVFNXcS8xRUZZY2doRjdTcDd2b01NNVJYMmVvaTF6OUVT?=
 =?utf-8?B?d1FuZHJSTmd2Q0FmZTlBVjlQeFVva1VYU1h5UUF6cEVFcThjLzNQQlM4Y0x6?=
 =?utf-8?B?aEdYSDhwOG1sOFZSNzBlRmExaHBpbFY1R2RidVJJYWZPNS9EOXNjM29MSk1v?=
 =?utf-8?B?QUwrbmhvY1g5dVc0WTRzSlllbGdlcmR1emdoc091cFAxUS9LcE5tUFhYWXpa?=
 =?utf-8?B?ZEN3M2dWQUhlMzlpK2Jycm5rVUZxM1hXWUMzcGhKbHlKd2tsTTlJTnd2TEM5?=
 =?utf-8?B?eHhUclhGcjhVOXRIYklMWUJuTExYZzkrNlJzcUJuK3V0bGhmcUF5NEVraDBG?=
 =?utf-8?B?Z0NOUDJ4UzZleCttU08rdFVYdG5JNmdQMDR4cUgxQmRYWkUzc2xEaXNocTg3?=
 =?utf-8?B?WnNveE5DMGFnck43WGl4NTlIWGlMVXVaaTJ1SkN6eDF1YUtPK3hGb2oyc3I4?=
 =?utf-8?B?bkRPRENJMU8zQ1N5Z3NTVmtkV3AxRFdRNUVCZDZDdUZLTlMwK2JoREpnRyt1?=
 =?utf-8?Q?uAOQw3VREncQDywX5WIu5WSlv2g9E4lzX2hS8xOOY5/V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f1fc1c-1c71-4a00-7b94-08db7193edec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5891.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:40:37.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8d0CyhUe+ZS3rp+GUxuxtw6tld4BBGqevHip5GhT/Y7Ag3DeOq4LmOJ3HpV/O9il22PJQkRXprae8g+PJ5KQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 2:27 PM, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> Translate Documentation/process/researcher-guidelines.rst into Spanish
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/process/index.rst      |   1 +
>  .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst
> 
> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
> index 0bdeb1eb4403..ed6851892661 100644
> --- a/Documentation/translations/sp_SP/process/index.rst
> +++ b/Documentation/translations/sp_SP/process/index.rst
> @@ -20,3 +20,4 @@
>     programming-language
>     deprecated
>     adding-syscalls
> +   researcher-guidelines
> diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
> new file mode 100644
> index 000000000000..32d1810733e4
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
> @@ -0,0 +1,152 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Original: :ref:`Documentation/process/researcher-guidelines.rst`
> +:Translator: Avadhut Naik <avadhut.naik@amd.com>
> +
> +.. _sp_researcher_guidelines:
> +
> +Directrices para Investigadores
> +++++++++++++++++++++++++++++++++
> +
> +La comunidad del kernel de Linux da la bienvenida a la investigación
> +transparente sobre el kernel de Linux, las actividades involucradas
> +en su producción, otros subproductos de su desarrollo. Linux se
> +beneficia mucho de este tipo de investigación, y la mayoría de los
> +aspectos de Linux son impulsados por investigación en una forma o otra.

s/una forma o otra/una forma u otra

> +
> +La comunidad agradece mucho si los investigadores pueden compartir
> +los hallazgos preliminares antes de hacer públicos sus resultados,
> +especialmente si tal investigación involucra seguridad. Involucrarse
> +temprano ayuda a mejorar la calidad de investigación y la capacidad
> +de Linux para mejorar a partir de ella. En cualquier caso, se recomienda
> +compartir copias de acceso abierto de la investigación publicada con
> +la comunidad.
> +
> +Este documento busca clarificar lo que la comunidad del kernel de Linux
> +considera practicas aceptables y no aceptables al llevar a cabo
> +investigación de este tipo. Por lo menos, dicha investigación y
> +actividades afines deben seguir las reglas estándar de ética de la
> +investigación. Para más información sobre la ética de la investigación
> +en general, ética en la tecnología y la investigación de las comunidades
> +de desarrolladores en particular, ver:
> +
> +
> +* `Historia de la Ética en la Investigación <https://www.unlv.edu/research/ORI-HSR/history-ethics>`_
> +* `Ética de la IEEE <https://www.ieee.org/about/ethics/index.html>`_
> +* `Perspectivas de Desarrolladores e Investigadores sobre la Ética de los Experimentos en Proyectos de Código Abierto <https://arxiv.org/pdf/2112.13217.pdf>`_
> +
> +La comunidad del kernel de Linux espera que todos los que interactúan con
> +el proyecto están participando en buena fe para mejorar Linux. La
> +investigación sobre cualquier artefacto disponible públicamente (incluido,
> +pero no limitado a código fuente) producido por la comunidad del kernel
> +de Linux es bienvenida, aunque la investigación sobre los desarrolladores
> +debe ser claramente opcional.
> +
> +La investigación pasiva que se basa completamente en fuentes disponibles
> +públicamente, incluidas las publicaciones en listas de correo públicas y
> +las contribuciones a los repositorios públicos, es claramente permitida.
> +Aunque, como con cualquier investigación, todavía se debe seguir la ética
> +estándar.
> +
> +La investigación activa sobre el comportamiento de los desarrolladores,
> +sin embargo, debe hacerse con el acuerdo explícito y la divulgación
> +completa a los desarrolladores individuales involucrados. No se puede
> +interactuar / experimentar con los desarrolladores sin consentimiento;
> +esto también es ética de investigación estándar.
> +
> +Para ayudar a aclarar: enviar parches a los desarrolladores es interactuar
> +con ellos, pero ya han dado su consentimiento para recibir contribuciones
> +en buena fe. No se ha dado consentimiento para enviar parches intencionalmente
> +defectuosos / vulnerables o contribuir con la información engañosa a las
> +discusiones. Dicha comunicación puede ser perjudicial al desarrollador (por
> +ejemplo, agotar el tiempo, el esfuerzo, y la moral) y perjudicial para el
> +proyecto al erosionar la confianza de toda la comunidad de desarrolladores en
> +el colaborador (y la organización del colaborador en conjunto), socavando
> +los esfuerzos para proporcionar reacciones constructivas a los colaboradores
> +y poniendo a los usuarios finales en riesgo de fallas de software.
> +
> +La participación en el desarrollo de Linux en sí mismo por parte de
> +investigadores, como con cualquiera, es bienvenida y alentada. La
> +investigación del código de Linux es una práctica común, especialmente
> +cuando se trata de desarrollar o ejecutar herramientas de análisis que
> +producen resultados procesables.
> +
> +Cuando se interactúa con la comunidad de desarrolladores, enviar un
> +parche ha sido tradicionalmente la mejor manera para hacer un impacto.
> +Linux ya tiene muchos errores conocidos – lo que es mucho más útil es
> +tener soluciones verificadas. Antes de contribuir, lea cuidadosamente
> +la documentación adecuada.
> +
> +* Documentation/process/development-process.rst
> +* Documentation/process/submitting-patches.rst
> +* Documentation/admin-guide/reporting-issues.rst
> +* Documentation/process/security-bugs.rst
> +
> +Entonces envíe un parche (incluyendo un registro de confirmación con
> +todos los detalles enumerados abajo) y haga un seguimiento de cualquier
> +comentario de otros desarrolladores.
> +
> +* ¿Cuál es el problema específico que se ha encontrado?
> +* ¿Como podría llegar al problema en un sistema en ejecución?
> +* ¿Qué efecto tendría encontrar el problema en el sistema?
> +* ¿Como se encontró el problema? Incluya específicamente detalles sobre
> +  cualquier prueba, programas de análisis estáticos o dinámicos, y cualquier
> +  otra herramienta o método utilizado para realizar el trabajo.
> +* ¿En qué versión de Linux se encontró el problema? Se prefiere usar la
> +  versión más reciente o una rama reciente de linux-next (ver
> +  Documentation/process/howto.rst).
> +* ¿Que se cambió para solucionar el problema y por qué se cree es correcto?
> +* ¿Como se probó el cambio para la complicación y el tiempo de ejecución?
> +* ¿Qué confirmación previa corrige este cambio? Esto debería ir en un “Fixes:”
> +  etiqueta como se describe en la documentación.
> +* ¿Quién más ha revisado este parche? Esto debería ir con la adecuada “Reviewed-by”
> +  etiqueta; Vea abajo.
> +
> +For example::

s/For example/Por ejemplo (en inglés, pues es en las listas):

> +
> +  From: Author <author@email>
> +  Subject: [PATCH] drivers/foo_bar: Add missing kfree()
> +
> +  The error path in foo_bar driver does not correctly free the allocated
> +  struct foo_bar_info. This can happen if the attached foo_bar device
> +  rejects the initialization packets sent during foo_bar_probe(). This
> +  would result in a 64 byte slab memory leak once per device attach,
> +  wasting memory resources over time.
> +
> +  This flaw was found using an experimental static analysis tool we are
> +  developing, LeakMagic[1], which reported the following warning when
> +  analyzing the v5.15 kernel release:
> +
> +   path/to/foo_bar.c:187: missing kfree() call?
> +
> +  Add the missing kfree() to the error path. No other references to
> +  this memory exist outside the probe function, so this is the only
> +  place it can be freed.
> +
> +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
> +  11.2 show no new warnings, and LeakMagic no longer warns about this
> +  code path. As we don't have a FooBar device to test with, no runtime
> +  testing was able to be performed.
> +
> +  [1] https://url/to/leakmagic/details
> +
> +  Reported-by: Researcher <researcher@email>
> +  Fixes: aaaabbbbccccdddd ("Introduce support for FooBar")
> +  Signed-off-by: Author <author@email>
> +  Reviewed-by: Reviewer <reviewer@email>
> +
> +Si usted es un colaborador por primera vez, se recomienda que el parche en
> +si sea examinado por otros en privado antes de ser publicado en listas
> +públicas. (Esto es necesario si se le ha dicho explícitamente que sus parches
> +necesitan una revisión interna más cuidadosa.) Se espera que estas personas
> +tengan su etiqueta “Reviewed-by” incluida en el parche resultante. Encontrar
> +otro desarrollador con conocimiento de las contribuciones a Linux, especialmente
> +dentro de su propia organización, y tener su ayuda con las revisiones antes de
> +enviarlas a las listas de correo publico tiende a mejorar significativamente la
> +calidad de los parches resultantes, y reduce así la carga de otros desarrolladores.
> +
> +Si no se puede encontrar a nadie para revisar internamente los parches y necesita
> +ayuda para encontrar a esa persona, o si tiene alguna otra pregunta relacionada
> +con este documento y las expectativas de la comunidad de desarrolladores, por
> +favor contacte con la lista de correo privada Technical Advisory Board:
> +<tech-board@lists.linux-foundation.org>.

Other than that, my Reviewed-By stays :) thanks Avadhut!

Best,
Carlos
