Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408745FEE46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJNM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJNM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:59:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004E2E9862;
        Fri, 14 Oct 2022 05:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1jczK0ECigbs0NA9H3oDwY75BtJvZ4vYMlp7wLjjyNMxL9R6Ah38VYyDAAAdJAROqE32QyA7OCzbQZS9DvEVgCcnWGj8jpHXBc1G9pmYsBAVgWsRBWNBLHQD9Fpu/tIi4NMcx+Q370kc0i3cdYpLR+OmYklM39JN8TkwlQTyDmzWe2qcFSd1VSvso38xDpRCbs5BmYo3Gse++lJFh/5qkyL2q8hLQ+4+gqzbHBDwzU5kEaFn3CNbjJzIWdon9+Pt3+jeyE5yUUKUkUwwsY126rbh7DjdwejW81oiUjQZHP/XzQr2XX7w4VIfBHF9CumWE16ahnYo1t1QUnvG3foUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXZFsP/FuYvW6VTSAELhB/uCUbMlXiEW26e4CgRmXyg=;
 b=mX2XqOI49x48pT7/QHBVR+I0qhY3MeLY9pQp0gbmEcq5l6VzdXqhvGzZNC2RUH0Idv+qG+eLrr6cDPbpjmh8boB3DLa+l1nX/Z10Bw4NVYnqmttafNvemwPtcxIH3G2vYWLVGTG8z/kMT8SeDdmOc1Pp0YIqjVIe2GdxFhRh03E0xLK1uZyqyTMRsWTuljNgmMkn7NmqYO9xu7IHwtAtwcSUuEHl4xMQnO/TRHrn8GPJPeh6bCkinHaP9sq9UzBbO+knjifeklyXcodRYj4MzGKmYqDX/Mc+3KUIS3+6uD5m+8M7iamfhHFWwGNa+VoZgCLdusUJp5Zev70UAeMWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXZFsP/FuYvW6VTSAELhB/uCUbMlXiEW26e4CgRmXyg=;
 b=tuTqHi+oe62W53HJ41UhjgoEbFWTznwIvm4RRvZwHo8Ikuowk/JCGcCf7LfLUxYN4GGOORXs+k1T2jhxAdaAG0NStR5UpOWkR4ml3yO3tappFYGoWsD1w2OQz10k45zyIkZt0lf+kNbCgvjkIWtUWI5jztEtdesuJGWU5yOyCU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 12:58:57 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649%7]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 12:58:57 +0000
Message-ID: <c351e1f6-29ad-2b93-09e4-c7f9d038d112@amd.com>
Date:   Fri, 14 Oct 2022 07:58:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] Documentation: Add HOWTO Spanish translation into rst
 based build system
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu, ojeda@kernel.org
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221013184816.354278-3-carlos.bilbao@amd.com> <Y0kqHBwaYvZwTp9M@debian.me>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Y0kqHBwaYvZwTp9M@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:b0::18) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 925ed633-694a-4161-9d18-08daade3db2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VY43j1/eBAeBRZh43d3Xo8odzIjOAT4gX4IhisvFayDEVar4Tat39IZcOmiJ2tNuBVTfz+tG90wkQ5wZKInV42FGV7pj5kzrWZT9uOjnHjcNp32CTG2qGizY23Bk22+1rHZLJJDcuNx8PNOJlZu+X5uu+Ug9FG6Uc/+RWwzgxWGSbXuN8Vp2vepNk+UN87LvCkEfM9gQMOlzPfrDraGo7o+gfDhhI3Inn+HRDlhWYP+wDfks4VhfXD0j/YTvqI9fPAJ2Jo1EQMMyGFRN9vWqrGq/SOp735bQlJd4mwumGhwvg6sxJsOALP7UUSD0NEA57SXtArGuQ/1qzRx4hyDBXxBvqNtY+trlDDn5wWvm2hpNKIlem+HsWqwCe7XvYiFZXCj2icqGB47BAAQHqWmOXILSKgADqUqAW11LICIaeHIoFNCCYzTBnSQ0GA4NmOQhL3JRa516xSHPpOoZ74O7PBDVwOypXtCBQnwPMtmLGc6zvgR+mYtYI7d5SwDOX4sUBtQVn9aot/bN2lLyTLfNAF2uvQNIekRJPnrQl2UItGMa7KPwdtKH3QvLZ6JpgyWNnO1jdVvZg1ndYHMtS7KbgDsxHELk8orSvr6rH1nCE6L+pZ8qcfJW7Deq+c6b+8uVwA3regsAIUAZaFK1Iy+ZvWj+nY0rBMNMo1zQcKJPgpDBfqM6swJoqFyx1BIMkOZcs7/3ezblQv5wPnPH6E679gNilHEH7y3LUyQIoakXk5hHxL4acTOf6GIk0OztF09zWE2jwHSvDT5+iMdRvBH1Ih/+xfh5lF/cKCLElA/Vw/fT2+4CQDuzxE/A7BD97W/V9l0P+HkZoWtY2qZpadLcjLyjB3643qyh3ygjdn7vsxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:es;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(66476007)(83380400001)(8936002)(8676002)(66946007)(26005)(6916009)(4326008)(66574015)(6666004)(66556008)(53546011)(36756003)(44832011)(6506007)(966005)(6486002)(41300700001)(38100700002)(30864003)(86362001)(2616005)(31686004)(478600001)(2906002)(6512007)(31696002)(316002)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDQvSUJ4ZVhZT2F5UlUwYjBqUDltTW9FNGF4T01EeHFNeHI1ME5mcGlYN0Ni?=
 =?utf-8?B?cWRGMjh6VDVOMjRMR1ZkWWppRWo2OXVIZzgybnRFeXdRbG9POUovbFV6MGk0?=
 =?utf-8?B?Z09JY1JlSEVIcGs1OEtEbHY4ejgxdHNtWkhXSUFnV3p0UlB5VWFvaWhuSTZR?=
 =?utf-8?B?c3hwNTNFOWt2YjVtZnZsc20vOVZSbUMzN0FhcmF5STNPajFDRUNJaktocVVH?=
 =?utf-8?B?cTFwKzNDcHFPY0p5Y0pLY25tK2dWYU5HYy9aRVhXcmRhN2dpK2U1R1dCNUNO?=
 =?utf-8?B?OEVwUTVGaHlVWlEyNS82Zko1NGNLalJlT0QraktPSWwwaG1UeW1zNTBUZkhE?=
 =?utf-8?B?d09JOHVmazZIU2JYRVlVWUY5a0toZUF4V2pUR3lnenRiZVVRMFY0YTNRSU0w?=
 =?utf-8?B?NmVzSitUMDQyaXo5YWRtZ3Y3cHJjaXZQU0E5SkZJN2o3a3oybTlMVkJodUNC?=
 =?utf-8?B?TzZidjZyMjR0ZS9VSXYvcHRzZHdEZFYrR3RwdjlFK0YyNndIanlubWhBSEsv?=
 =?utf-8?B?d1BTaXVhcVRGUm1iOGZaSjdWeTZHTXhSMno2OFJicE1kRTJQTWJ3MHZyUk8v?=
 =?utf-8?B?bnEzWXN3RGRFd1F0cFhucWR3NzBqNE9FdTRJNWhRaHdhMnpGY3BpN1hFVksz?=
 =?utf-8?B?WHR2V0ZBWThTdmFoTC80Y0VxakRWRWhER2xsdVk5aVJFSUpOdDNRZDBQWXlP?=
 =?utf-8?B?OFVsMHhuUWFTU3luRzdxL3pmd1dBUHh1ZVJmS2xYaDR5TENuUkJOWXhnVjRi?=
 =?utf-8?B?WENGSHhudkpIUFhyei9aUmgwcC96TlB4d3BhYmY5UUVVM3U2Qm5FY2dRRktF?=
 =?utf-8?B?Q1E0aHRXNHBHTkN6R3pLTy9CbTVta2g0dVIvZWtBdDlSTEFkTEhnZUJ3dHFi?=
 =?utf-8?B?eWVxNm5ZK3VaWXo1NWc0TGYxYlZ1Y0ZEbVV4djR2empJdG15TEh2b05SZ21F?=
 =?utf-8?B?OUFKa2pVdi9zUy9YUHJZL21TZ0RYMjUvVTE4TjJrZXY4RnVrdWxiR3R0RmhG?=
 =?utf-8?B?VG9Kb3BueUsyS0RtQktiaitCTkplWGxRTTVOL0xmbURpK0RsOTlQeGc5cFVR?=
 =?utf-8?B?MldpRUhlTGwwT2dhRC9WeGJqMlVsUUMrSmJMY0xTWXVKR01lMVVqWWcrUDFR?=
 =?utf-8?B?S3FRSnIwRG9WbVZmdnFJM1phclVoQ2pZVEdOWDJCZGF1NmJZRnl4ZC9HV1NR?=
 =?utf-8?B?N1d0MisyWUZadzdyOG1aMHlKR21mTUdQWHBQUmp6UFBZdmdETmJ6cmVmU01k?=
 =?utf-8?B?SFZ6bjB0Q0RTNmF5LzNWcjRSV0Z1T1NkaEhOZXFxZjkzenR3YUwvMnBMQTFS?=
 =?utf-8?B?YlpYNkdteW90bEs3RVlvTFlpQUJIems0MER1NWIxMCtvYmtLVGtIQnVjeU1l?=
 =?utf-8?B?RFcvcDUxcTI2RFpldEszSS9tWFg5UzVBK21Oc3N3WjV3UXlKY0FUY2J5QmVE?=
 =?utf-8?B?K1BaSDVzTi9ydHRmWTNXNG96b1k3TS9LSjMrYWNWRDlnaG1KSjRIWUNPMGF0?=
 =?utf-8?B?MUZRZ2VORkpMTCtSZHE5YitDRjQ2RXhCcFRVMG9CUVFaMGZWdEZXbkRTbnY5?=
 =?utf-8?B?Mzk3Vk4wTU80Q2JjdGQ3ZkJoQzdRMjlCNlZGdFdtZWl3aVdMVnRFbUQzVTdk?=
 =?utf-8?B?cGlkRUtOQkFuM1FCRWJJdzRkdVJWUDUvem1iai9XOTFzeUJkMllQMGFNUFJQ?=
 =?utf-8?B?SThiQVFXYmh0SjNlOGhyTVZ0dGNuamxoVkEvajlPTjBHRi81SS9pNjBMeVdz?=
 =?utf-8?B?WVdEbGVBTXh0dlFpYjVDRklaWGVtNkNtZlFYbTVwL3VOTlhVY0ZaeW5DMEN4?=
 =?utf-8?B?eWJzeVM2TjVUb2VPYjhSOFVzU1NFV3cwVzZqbFk1aGZCYzIwRFBwVVRmanI4?=
 =?utf-8?B?RmVKb0M0VC9RczhwNFpOdkU4eDk4UHQ3Q3BGbW9rTHhBclpOODNQM2dPeTl5?=
 =?utf-8?B?dGtsbnd5dDVqcGRWa3RNeGtPcXF4aTk4U0w5OTdxTE85QXBvbUs2UUkzek5i?=
 =?utf-8?B?WGNlUyt6bWdDNUpuam1COEF5djJxWkJlUUxPWHZtUGEzUHZhc0xZQTVpQ1c1?=
 =?utf-8?B?cDI0ODF1WENhK2FxY1pDdnlRbUZ2ektBb0Q5N2E4TUkvK2FUTGd5YVJUbXli?=
 =?utf-8?Q?WPHdFo28yiBsJh3WKogk1IEh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ed633-694a-4161-9d18-08daade3db2d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 12:58:57.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5H9GPig3OrmgeVZzai4X1e8j0rTZ5oDxMv/AUaUYer/VkqmXAa+FMtTvEo2CDzlg+Ikz2oLpiL9UeMnlZUjxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 04:21, Bagas Sanjaya wrote:

> ¡Hola Carlos! Gracias for start writing Spanish translations. However,
> the patch can be improved, see below.
Hola Bagas, thanks for your feedback :)
>
> On Thu, Oct 13, 2022 at 01:48:16PM -0500, Carlos Bilbao wrote:
>> This commit adds Spanish translation of HOWTO document into rst based
>> documentation build system.
>>
> Better say "Translate HOWTO document into Spanish".
So, for the commit message here I just replicated what prior folks did,
see:

For Japanese:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/translations/ja_JP?h=v6.0&id=f012733894d36ff687862e9cd3b02ee980c61416

For Korean:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/translations/ko_KR/howto.rst?h=v6.0&id=ba42c574fc8b803ec206785b7b91325c05810422

I think I will leave that commit message, it is slightly more informative
than "Translate HOWTO document into Spanish".

>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   Documentation/translations/sp_SP/howto.rst | 619 +++++++++++++++++++++
>>   Documentation/translations/sp_SP/index.rst |   7 +
>>   2 files changed, 626 insertions(+)
>>   create mode 100644 Documentation/translations/sp_SP/howto.rst
>>
>> diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/translations/sp_SP/howto.rst
>> new file mode 100644
>> index 000000000000..4cf8fa6b9f7c
>> --- /dev/null
>> +++ b/Documentation/translations/sp_SP/howto.rst
>> @@ -0,0 +1,619 @@
>> +.. include:: ./disclaimer-sp.rst
>> +
>> +:Original: :ref:`Documentation/process/howto.rst <process_howto>`
>> +:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
>> +
>> +.. _sp_process_howto:
>> +
>> +Cómo participar en el desarrollo del kernel de Linux
>> +====================================================
>> +
>> +Este documento es el principal punto de partida. Contiene instrucciones
>> +sobre cómo convertirse en desarrollador del kernel de Linux y explica cómo
>> +trabajar con el y en su desarrollo. El documento no tratará ningún aspecto
>> +técnico relacionado con la programación del kernel, pero le ayudará
>> +guiándole por el camino correcto.
>> +
>> +Si algo en este documento quedara obsoleto, envíe parches al maintainer de
>> +este archivo, que se encuentra en la parte superior del documento.
>> +
>> +Introducción
>> +------------
>> +¿De modo que quiere descubrir como convertirse en un/a desarrollador/a del
>> +kernel de Linux? Tal vez su jefe le haya dicho, "Escriba un driver de
>> +Linux para este dispositivo." El objetivo de este documento en enseñarle
>> +todo cuanto necesita para conseguir esto, describiendo el proceso por el
>> +que debe pasar, y con indicaciones de como trabajar con la comunidad.
>> +También trata de explicar las razones por las cuales la comunidad trabaja
>> +de la forma en que lo hace.
>> +
>> +El kernel esta principalmente escrito en C, con algunas partes que son
>> +dependientes de la arquitectura en ensamblador. Un buen conocimiento de C
>> +es necesario para desarrollar en el kernel. Lenguaje ensamblador (en
>> +cualquier arquitectura) no es necesario excepto que planee realizar
>> +desarrollo de bajo nivel para dicha arquitectura. Aunque no es un perfecto
>> +sustituto para una educación sólida en C y/o años de experiencia, los
>> +siguientes libros sirven, como mínimo, como referencia:
>> +
>> +- "The C Programming Language" de Kernighan e Ritchie [Prentice Hall]
>> +- "Practical C Programming" de Steve Oualline [O'Reilly]
>> +- "C:  A Reference Manual" de Harbison and Steele [Prentice Hall]
>> +
>> +El kernel está escrito usando GNU C y la cadena de herramientas GNU. Si
>> +bien se adhiere al estándar ISO C89, utiliza una serie de extensiones que
>> +no aparecen en dicho estándar. El kernel usa un C independiente de entorno,
>> +sin depender de la biblioteca C estándar, por lo que algunas partes del
>> +estándar C no son compatibles. Divisiones de long long arbitrarios o
>> +de coma flotante no son permitidas. En ocasiones, puede ser difícil de
>> +entender las suposiciones que el kernel hace respecto a la cadena de
>> +herramientas y las extensiones que usa, y desafortunadamente no hay
>> +referencia definitiva para estos. Consulte las páginas de información de
>> +gcc (`info gcc`) para obtener información al respecto.
>> +
>> +Recuerde que está tratando de aprender a trabajar con una comunidad de
>> +desarrollo existente. Es un grupo diverso de personas, con altos estándares
>> +de codificación, estilo y procedimiento. Estas normas han sido creadas a lo
>> +largo del tiempo en función de lo que se ha encontrado que funciona mejor
>> +para un equipo tan grande y geográficamente disperso. Trate de aprender
>> +tanto como le sea posible acerca de estos estándares antes de tiempo, ya
>> +que están bien documentados; no espere que la gente se adapte a usted o a
>> +su forma de ser de hacer las cosas.
>> +
>> +Cuestiones legales
>> +------------------
>> +El código fuente del kernel de Linux se publica bajo licencia GPL. Por
>> +favor, revise el archivo COPYING, presente en la carpeta principal del
>> +fuente, para detalles de la licencia. Si tiene alguna otra pregunta
>> +sobre licencias, contacte a un abogado, no pregunte en listas de discusión
>> +del kernel de Linux. Las personas en estas listas no son abogadas, y no
>> +debe confiar en sus opiniones en materia legal.
>> +
>> +Para preguntas y respuestas más frecuentes sobre la licencia GPL, consulte:
>> +
>> +	https://www.gnu.org/licenses/gpl-faq.html
>> +
>> +Documentacion
>> +--------------
>> +El código fuente del kernel de Linux tiene una gran variedad de documentos
>> +que son increíblemente valiosos para aprender a interactuar con la
>> +comunidad del kernel. Cuando se agregan nuevas funciones al kernel, se
>> +recomienda que se incluyan nuevos archivos de documentación que expliquen
>> +cómo usar la función. Cuando un cambio en el kernel hace que la interfaz
>> +que el kernel expone espacio de usuario cambie, se recomienda que envíe la
>> +información o un parche en las páginas del manual que expliquen el cambio
>> +a mtk.manpages@gmail.com, y CC la lista linux-api@vger.kernel.org.
>> +
>> +Esta es la lista de archivos que están en el código fuente del kernel y son
>> +de obligada lectura:
>> +
>> +  :ref:`Documentation/admin-guide/README.rst <readme>`
>> +    Este archivo ofrece una breve descripción del kernel de Linux y
>> +    describe lo que es necesario hacer para configurar y compilar el
>> +    kernel. Quienes sean nuevos en el kernel deben comenzar aquí.
>> +
>> +  :ref:`Documentation/process/changes.rst <changes>`
>> +    Este archivo proporciona una lista de los niveles mínimos de varios
>> +    paquetes que son necesarios para construir y ejecutar el kernel
>> +    exitosamente.
>> +
>> +  :ref:`Documentation/process/coding-style.rst <codingstyle>`
>> +    Esto describe el estilo de código del kernel de Linux y algunas de los
>> +    razones detrás de esto. Se espera que todo el código nuevo siga las
>> +    directrices de este documento. La mayoría de los maintainers solo
>> +    aceptarán parches si se siguen estas reglas, y muchas personas solo
>> +    revisan el código si tiene el estilo adecuado.
>> +
>> +  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>> +    Este archivo describe en gran detalle cómo crear con éxito y enviar un
>> +    parche, que incluye (pero no se limita a):
>> +
>> +       - Contenidos del correo electrónico (email)
>> +       - Formato del email
>> +       - A quien se debe enviar
>> +
>> +    Seguir estas reglas no garantiza el éxito (ya que todos los parches son
>> +    sujetos a escrutinio de contenido y estilo), pero en caso de no seguir
>> +    dichas reglas, el fracaso es prácticamente garantizado.
>> +    Otras excelentes descripciones de cómo crear parches correctamente son:
>> +
>> +	"The Perfect Patch"
>> +		https://www.ozlabs.org/~akpm/stuff/tpp.txt
>> +
>> +	"Linux kernel patch submission format"
>> +		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
>> +
>> +  :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
>> +    Este archivo describe la lógica detrás de la decisión consciente de
>> +    no tener una API estable dentro del kernel, incluidas cosas como:
>> +
>> +      - Capas intermedias del subsistema (por compatibilidad?)
>> +      - Portabilidad de drivers entre sistemas operativos
>> +      - Mitigar el cambio rápido dentro del árbol de fuentes del kernel (o
>> +        prevenir cambios rápidos)
>> +
>> +     Este documento es crucial para comprender la filosofía del desarrollo
>> +     de Linux y es muy importante para las personas que se mudan a Linux
>> +     tras desarrollar otros sistemas operativos.
>> +
>> +  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
>> +    Si cree que ha encontrado un problema de seguridad en el kernel de
>> +    Linux, siga los pasos de este documento para ayudar a notificar a los
>> +    desarrolladores del kernel y ayudar a resolver el problema.
>> +
>> +  :ref:`Documentation/process/management-style.rst <managementstyle>`
>> +    Este documento describe cómo operan los maintainers del kernel de Linux
>> +    y los valores compartidos detrás de sus metodologías. Esta es una
>> +    lectura importante para cualquier persona nueva en el desarrollo del
>> +    kernel (o cualquier persona que simplemente sienta curiosidad por
>> +    el campo IT), ya que clarifica muchos conceptos erróneos y confusiones
>> +    comunes sobre el comportamiento único de los maintainers del kernel.
>> +
>> +  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
>> +    Este archivo describe las reglas sobre cómo se suceden las versiones
>> +    del kernel estable, y qué hacer si desea obtener un cambio en una de
>> +    estas publicaciones.
>> +
>> +  :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
>> +    Una lista de documentación externa relativa al desarrollo del kernel.
>> +    Por favor consulte esta lista si no encuentra lo que están buscando
>> +    dentro de la documentación del kernel.
>> +
>> +  :ref:`Documentation/process/applying-patches.rst <applying_patches>`
>> +    Una buena introducción que describe exactamente qué es un parche y cómo
>> +    aplicarlo a las diferentes ramas de desarrollo del kernel.
>> +
>> +El kernel también tiene una gran cantidad de documentos que pueden ser
>> +generados automáticamente desde el propio código fuente o desde
>> +ReStructuredText markups (ReST), como este. Esto incluye un descripción
>> +completa de la API en el kernel y reglas sobre cómo manejar cerrojos
>> +(locking) correctamente.
>> +
>> +Todos estos documentos se pueden generar como PDF o HTML ejecutando::
>> +
>> +	make pdfdocs
>> +	make htmldocs
>> +
>> +respectivamente desde el directorio fuente principal del kernel.
>> +
>> +Los documentos que utilizan el markup ReST se generarán en
>> +Documentation/output. También se pueden generar en formatos LaTeX y ePub
>> +con::
>> +
>> +	make latexdocs
>> +	make epubdocs
>> +
>> +Convertirse en un/a desarrollador/a de kernel
>> +-------------------------------------------
>> +
>> +Si no sabe nada sobre el desarrollo del kernel de Linux, debería consultar
>> +el proyecto Linux KernelNewbies:
>> +
>> +	https://kernelnewbies.org
>> +
>> +Consiste en una útil lista de correo donde puede preguntar casi cualquier
>> +tipo de pregunta básica de desarrollo del kernel (asegúrese de buscar en
>> +los archivos primero, antes de preguntar algo que ya ha sido respondido en
>> +el pasado.) También tiene un canal IRC que puede usar para hacer preguntas
>> +en en tiempo real, y una gran cantidad de documentación útil que es útil
>> +para ir aprendiendo sobre el desarrollo del kernel de Linux.
>> +
>> +El sitio web tiene información básica sobre la organización del código,
>> +subsistemas, y proyectos actuales (tanto dentro como fuera del árbol).
>> +También describe alguna información logística básica, como cómo compilar
>> +un kernel y aplicar un parche.
>> +
>> +Si no sabe por dónde quiere empezar, pero quieres buscar alguna tarea que
>> +comenzar a hacer para unirse a la comunidad de desarrollo del kernel,
>> +acuda al proyecto Linux Kernel Janitor:
>> +
>> +	https://kernelnewbies.org/KernelJanitors
>> +
>> +Es un gran lugar para comenzar. Describe una lista de problemas
>> +relativamente simples que deben limpiarse y corregirse dentro del codigo
>> +fuente del kernel de Linux árbol de fuentes. Trabajando con los
>> +desarrolladores a cargo de este proyecto, aprenderá los conceptos básicos
>> +para incluir su parche en el árbol del kernel de Linux, y posiblemente
>> +descubrir en la dirección en que trabajar a continuación, si no tiene ya
>> +una idea.
>> +
>> +Antes de realizar cualquier modificación real al código del kernel de
>> +Linux, es imperativo entender cómo funciona el código en cuestión. Para
>> +este propósito, nada es mejor que leerlo directamente (lo más complicado
>> +está bien comentado), tal vez incluso con la ayuda de herramientas
>> +especializadas. Una de esas herramientas que se recomienda especialmente
>> +es el proyecto Linux Cross-Reference, que es capaz de presentar el código
>> +fuente en un formato de página web indexada y autorreferencial. Una
>> +excelente puesta al día del repositorio del código del kernel se puede
>> +encontrar en:
>> +
>> +	https://elixir.bootlin.com/
>> +
>> +El proceso de desarrollo
>> +------------------------
>> +
>> +El proceso de desarrollo del kernel de Linux consiste actualmente de
>> +diferentes "branches" (ramas) con muchos distintos subsistemas específicos
>> +a cada una de ellas. Las diferentes ramas son:
>> +
>> +  - El código principal de Linus (mainline tree)
>> +  - Varios árboles estables con múltiples major numbers
>> +  - Subsistemas específicos
>> +  - linux-next, para integración y testing
>> +
>> +Mainline tree (Árbol principal)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +El mainline tree es mantenido por Linus Torvalds, y puede encontrarse en
>> +https://kernel.org o en su repo.  El proceso de desarrollo es el siguiente:
>> +
>> +  - Tan pronto como se lanza un nuevo kernel, se abre una ventana de dos
>> +    semanas, durante este período de tiempo, los maintainers pueden enviar
>> +    grandes modificaciones a Linus, por lo general los parches que ya se
>> +    han incluido en el linux-next durante unas semanas. La forma preferida
>> +    de enviar grandes cambios es usando git (la herramienta de
>> +    administración de codigo fuente del kernel, más información al respecto
>> +    en https://git-scm.com/), pero los parches simples también son validos.
>> +  - Después de dos semanas, se lanza un kernel -rc1 y la atención se centra
>> +    en hacer que el kernel nuevo lo más estable ("solido") posible. La
>> +    mayoría de los parches en este punto debe arreglar una regresión. Los
>> +    errores que siempre han existido no son regresiones, por lo tanto, solo
>> +    envíe este tipo de correcciones si son importantes. Tenga en cuenta que
>> +    se podría aceptar un controlador (o sistema de archivos) completamente
>> +    nuevo después de -rc1 porque no hay riesgo de causar regresiones con
>> +    tal cambio, siempre y cuando el cambio sea autónomo y no afecte áreas
>> +    fuera del código que se está agregando. git se puede usar para enviar
>> +    parches a Linus después de que se lance -rc1, pero los parches también
>> +    deben ser enviado a una lista de correo pública para su revisión.
>> +  - Se lanza un nuevo -rc cada vez que Linus considera que el árbol git
>> +    actual esta en un estado razonablemente sano y adecuado para la prueba.
>> +    La meta es lanzar un nuevo kernel -rc cada semana.
>> +  - El proceso continúa hasta que el kernel se considera "listo", y esto
>> +    puede durar alrededor de 6 semanas.
>> +
>> +Vale la pena mencionar lo que Andrew Morton escribió en las listas de
>> +correo del kernel de Linux, sobre lanzamientos del kernel (traducido):
>> +
>> +	*"Nadie sabe cuándo se publicara un nuevo kernel, porque esto sucede
>> +    de acuerdo con el estado de bugs (error) percibido, no de acuerdo con
>> +    una línea temporal preconcebida."*
>> +
>> +Varios árboles estables con múltiples major numbers
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Los kernels con versiones de 3 partes son kernels estables. Estos contienen
>> +correcciones relativamente pequeñas y críticas para problemas de seguridad
>> +o importantes regresiones descubiertas para una publicación de código.
>> +Cada lanzamiento en una gran serie estable incrementa la tercera parte de
>> +la versión número, manteniendo las dos primeras partes iguales.
>> +
>> +Esta es la rama recomendada para los usuarios que quieren la versión
>> +estable más reciente del kernel, y no están interesados ​​en ayudar a probar
>> +versiones en desarrollo/experimentales.
>> +
>> +Los árboles estables son mantenidos por el equipo "estable"
>> +<stable@vger.kernel.org>, y se liberan (publican) según lo dicten las
>> +necesidades. El período de liberación normal es de aproximadamente dos
>> +semanas, pero puede ser más largo si no hay problemas apremiantes. Un
>> +problema relacionado con la seguridad, en cambio, puede causar un
>> +lanzamiento casi instantáneamente.
>> +
>> +El archivo :ref:`Documentación/proceso/stable-kernel-rules.rst <stable_kernel_rules>`
>> +en el árbol del kernel documenta qué tipos de cambios son aceptables para
>> +el árbol estable y cómo funciona el proceso de lanzamiento.
>> +
>> +Subsistemas específicos
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +Los maintainers de los diversos subsistemas del kernel --- y también muchos
>> +desarrolladores de subsistemas del kernel --- exponen su estado actual de
>> +desarrollo en repositorios fuente. De esta manera, otros pueden ver lo que
>> +está sucediendo en las diferentes áreas del kernel. En áreas donde el
>> +desarrollo es rápido, se le puede pedir a un desarrollador que base sus
>> +envíos en tal árbol del subsistema del kernel, para evitar conflictos entre
>> +este y otros trabajos ya en curso.
>> +
>> +La mayoría de estos repositorios son árboles git, pero también hay otros
>> +SCM en uso, o colas de parches que se publican como series quilt. Las
>> +direcciones de estos repositorios de subsistemas se enumeran en el archivo
>> +MAINTAINERS. Muchos de estos se pueden ver en https://git.kernel.org/.
>> +
>> +Antes de que un parche propuesto se incluya con dicho árbol de subsistemas,
>> +es sujeto a revisión, que ocurre principalmente en las listas de correo
>> +(ver la sección respectiva a continuación). Para varios subsistemas del
>> +kernel, esta revisión se rastrea con la herramienta patchwork. Patchwork
>> +ofrece una interfaz web que muestra publicaciones de parches, cualquier
>> +comentario sobre un parche o revisiones a él, y los maintainers pueden
>> +marcar los parches como en revisión, aceptado, o rechazado. La mayoría de
>> +estos sitios de trabajo de parches se enumeran en
>> +
>> +https://patchwork.kernel.org/.
>> +
>> +linux-next, para integración y testing
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Antes de que las actualizaciones de los árboles de subsistemas se combinen
>> +con el árbol principal, necesitan probar su integración. Para ello, existe
>> +un repositorio especial de pruebas en el que se encuentran casi todos los
>> +árboles de subsistema, actualizado casi a diario:
>> +
>> +	https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
>> +
>> +De esta manera, linux-next ofrece una perspectiva resumida de lo que se
>> +espera que entre en el kernel principal en el próximo período de "merge"
>> +(fusión de codigo). Los testers aventureros son bienvenidos a probar
>> +linux-next en ejecución.
>> +
>> +Reportar bugs
>> +-------------
>> +
>> +El archivo 'Documentación/admin-guide/reporting-issues.rst' en el
>> +directorio principal del kernel describe cómo informar un posible bug del
>> +kernel y detalles sobre qué tipo de información necesitan los
>> +desarrolladores del kernel para ayudar a rastrear la fuente del problema.
>> +
>> +Gestión de informes de bugs
>> +------------------------------
>> +
>> +Una de las mejores formas de poner en práctica sus habilidades de hacking
>> +es arreglando errores reportados por otras personas. No solo ayudará a
>> +hacer el kernel más estable, también aprenderá a solucionar problemas del
>> +mundo real y mejora sus habilidades, y otros desarrolladores se darán
>> +cuenta de tu presencia. La corrección de errores es una de las mejores
>> +formas de ganar méritos entre desarrolladores, porque no a muchas personas
>> +les gusta perder el tiempo arreglando los errores de otras personas.
>> +
>> +Para trabajar en informes de errores ya reportados, busque un subsistema
>> +que le interese. Verifique el archivo MAINTAINERS donde se informan los
>> +errores de ese subsistema; con frecuencia será una lista de correo, rara
>> +vez un rastreador de errores (bugtracker). Busque en los archivos de dicho
>> +lugar para informes recientes y ayude donde lo crea conveniente. También es
>> +posible que desee revisar https://bugzilla.kernel.org para informes de
>> +errores; solo un puñado de subsistemas del kernel lo emplean activamente
>> +para informar o rastrear; sin embargo, todos los errores para todo el kernel
>> +se archivan allí.
>> +
>> +Listas de correo
>> +-----------------
>> +
>> +Como se explica en algunos de los documentos anteriores, la mayoría de
>> +desarrolladores del kernel participan en la lista de correo del kernel de
>> +Linux. Detalles sobre cómo para suscribirse y darse de baja de la lista se
>> +pueden encontrar en:
>> +
>> +	http://vger.kernel.org/vger-lists.html#linux-kernel
>> +
>> +Existen archivos de la lista de correo en la web en muchos lugares
>> +distintos. Utilice un motor de búsqueda para encontrar estos archivos. Por
>> +ejemplo:
>> +
>> +	http://dir.gmane.org/gmane.linux.kernel
>> +
>> +Es muy recomendable que busque en los archivos sobre el tema que desea
>> +tratar, antes de publicarlo en la lista. Un montón de cosas ya discutidas
>> +en detalle solo se registran en los archivos de la lista de correo.
>> +
>> +La mayoría de los subsistemas individuales del kernel también tienen sus
>> +propias lista de correo donde hacen sus esfuerzos de desarrollo. Revise el
>> +archivo MAINTAINERS para obtener referencias de lo que estas listas para
>> +los diferentes grupos.
>> +
>> +Muchas de las listas están alojadas en kernel.org. La información sobre
>> +estas puede ser encontrada en:
>> +
>> +	http://vger.kernel.org/vger-lists.html
>> +
>> +Recuerde mantener buenos hábitos de comportamiento al usar las listas.
>> +Aunque un poco cursi, la siguiente URL tiene algunas pautas simples para
>> +interactuar con la lista (o cualquier lista):
>> +
>> +	http://www.albion.com/netiquette/
>> +
>> +Si varias personas responden a su correo, el CC (lista de destinatarios)
>> +puede hacerse bastante grande. No elimine a nadie de la lista CC: sin una
>> +buena razón, o no responda solo a la dirección de la lista. Acostúmbrese
>> +a recibir correos dos veces, una del remitente y otra de la lista, y no
>> +intente ajustar esto agregando encabezados de correo astutos, a la gente no
>> +le gustará.
>> +
>> +Recuerde mantener intacto el contexto y la atribución de sus respuestas,
>> +mantenga las líneas "El hacker John Kernel escribió ...:" en la parte
>> +superior de su respuesta, y agregue sus declaraciones entre las secciones
>> +individuales citadas en lugar de escribiendo en la parte superior del
>> +correo electrónico.
>> +
>> +Si incluye parches en su correo, asegúrese de que sean texto legible sin
>> +formato como se indica en :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
>> +Los desarrolladores del kernel no quieren lidiar con archivos adjuntos o
>> +parches comprimidos; y pueden querer comentar líneas individuales de su
>> +parche, que funciona sólo de esa manera. Asegúrese de emplear un programa
>> +de correo que no altere los espacios ni los tabuladores. Una buena primera
>> +prueba es enviarse el correo a usted mismo, e intentar aplicar su
>> +propio parche. Si eso no funciona, arregle su programa de correo o
>> +reemplace hasta que funcione.
>> +
>> +Sobretodo, recuerde de ser respetuoso con otros subscriptores.
>> +
>> +Colaborando con la comunidad
>> +----------------------------
>> +
>> +El objetivo de la comunidad del kernel es proporcionar el mejor kernel
>> +posible. Cuando envíe un parche para su aceptación, se revisará en sus
>> +méritos técnicos solamente. Entonces, ¿qué deberías ser?
>> +
>> +  - criticas
>> +  - comentarios
>> +  - peticiones de cambios
>> +  - peticiones de justificaciones
>> +  - silencio
>> +
>> +Recuerde, esto es parte de introducir su parche en el kernel. Tiene que ser
>> +capaz de recibir críticas y comentarios sobre sus parches, evaluar
>> +a nivel técnico y re-elaborar sus parches o proporcionar razonamiento claro
>> +y conciso de por qué no se deben hacer tales cambios. Si no hay respuestas
>> +a su publicación, espere unos días e intente de nuevo, a veces las cosas se
>> +pierden dado el gran volumen.
>> +
>> +¿Qué no debería hacer?
>> +
>> +  - esperar ue su parche se acepte sin preguntas
>> +  - actuar de forma defensiva
>> +  - ignorar comentarios
>> +  - enviar el parche de nuevo, sin haber aplicados los cambios pertinentes
>> +
>> +En una comunidad que busca la mejor solución técnica posible, siempre habrá
>> +diferentes opiniones sobre lo beneficioso que es un parche. Tiene que ser
>> +cooperativo y estar dispuesto a adaptar su idea para que encaje dentro
>> +del kernel, o al menos esté dispuesto a demostrar que su idea vale la pena.
>> +Recuerea, estar equivocado es aceptable siempre y cuando estés dispuesto a
>> +trabajar hacia una solución que sea correcta.
>> +
>> +Es normal que las respuestas a su primer parche sean simplemente una lista
>> +de una docena de cosas que debe corregir. Esto **no** implica que su
>> +parche no será aceptado, y **no** es personal. Simplemente corrija todos
>> +los problemas planteados en su parche, y envié otra vez.
>> +
>> +Diferencias entre la comunidad kernel y las estructuras corporativas
>> +--------------------------------------------------------------------
>> +
>> +La comunidad del kernel funciona de manera diferente a la mayoría de los
>> +entornos de desarrollo tradicionales en empresas. Aquí hay una lista de
>> +cosas que puede intentar hacer para evitar problemas:
>> +
>> +  Cosas buenas que decir respecto a los cambios propuestos:
>> +
>> +    - "Esto arregla múltiples problemas."
>> +    - "Esto elimina 2000 lineas de código."
>> +    - "Aquí hay un parche que explica lo que intento describir."
>> +    - "Lo he testeado en 5 arquitecturas distintas..."
>> +    - "Aquí hay una serie de parches menores que..."
>> +    - "Esto mejora el rendimiento en maquinas típicas..."
>> +
>> +  Cosas negativas que debe evitar decir:
>> +
>> +    - "Lo hicimos asi en AIX/ptx/Solaris, de modo que debe ser bueno..."
>> +    - "LLevo haciendo esto 20 años, de modo que..."
>> +    - "Esto lo necesita mi empresa para ganar dinero"
>> +    - "Esto es para la linea de nuestros productos Enterprise"
>> +    - "Aquí esta el documento de 1000 paginas describiendo mi idea"
>> +    - "Llevo 6 meses trabajando en esto..."
>> +    - "Aquí esta un parche de 5000 lineas que..."
>> +    - "He rescrito todo el desastre actual, y aqui esta..."
>> +    - "Tengo un deadline, y este parche debe aplicarse ahora."
>> +
>> +Otra forma en que la comunidad del kernel es diferente a la mayoría de los
>> +entornos de trabajo tradicionales en ingeniería de software, es la
>> +naturaleza sin rostro de interacción. Una de las ventajas de utilizar el
>> +correo electrónico y el IRC como formas principales de comunicación es la
>> +no discriminación por motivos de género o raza. El entorno de trabajo del
>> +kernel de Linux acepta a mujeres y minorías porque todo lo que eres es una
>> +dirección de correo electrónico. El aspecto internacional también ayuda a
>> +nivelar el campo de juego porque no puede adivinar el género basado en
>> +el nombre de una persona. Un hombre puede llamarse Andrea y una mujer puede
>> +llamarse Pat. La mayoría de las mujeres que han trabajado en el kernel de
>> +Linux y han expresado una opinión han tenido experiencias positivas.
>> +
>> +La barrera del idioma puede causar problemas a algunas personas que no se
>> +sientes cómodas con el inglés. Un buen dominio del idioma puede ser
>> +necesario para transmitir ideas correctamente en las listas de correo, por
>> +lo que le recomendamos que revise sus correos electrónicos para asegurarse
>> +de que tengan sentido en inglés antes de enviarlos.
>> +
>> +Divida sus cambios
>> +---------------------
>> +
>> +La comunidad del kernel de Linux no acepta con gusto grandes fragmentos de
>> +código, sobretodo a la vez. Los cambios deben introducirse correctamente,
>> +discutidos y divididos en pequeñas porciones individuales. Esto es casi
>> +exactamente lo contrario de lo que las empresas están acostumbradas a hacer.
>> +Su propuesta también debe introducirse muy temprano en el proceso de
>> +desarrollo, de modo que pueda recibir comentarios sobre lo que está
>> +haciendo. También deje que la comunidad sienta que está trabajando con
>> +ellos, y no simplemente usándolos como un vertedero para su función. Sin
>> +embargo, no envíe 50 correos electrónicos a una vez a una lista de correo,
>> +su serie de parches debe casi siempre ser más pequeña que eso.
>> +
>> +Las razones para dividir las cosas son las siguientes:
>> +
>> +1) Los cambios pequeños aumentan la probabilidad de que sus parches sean
>> +   aplicados, ya que no requieren mucho tiempo o esfuerzo para verificar su
>> +   exactitud. Un parche de 5 líneas puede ser aplicado por un maintainer
>> +   con apenas una segunda mirada. Sin embargo, un parche de 500 líneas
>> +   puede tardar horas en ser revisado en términos de corrección (el tiempo
>> +   que toma es exponencialmente proporcional al tamaño del parche, o algo
>> +   así).
>> +
>> +   Los parches pequeños también facilitan la depuración cuando algo falla.
>> +   Es mucho más fácil retirar los parches uno por uno que diseccionar un
>> +   parche muy grande después de haber sido aplicado (y roto alguna cosa).
>> +
>> +2) Es importante no solo enviar pequeños parches, sino también reescribir
>> +   y simplificar (o simplemente reordenar) los parches antes de enviarlos.
>> +
>> +Esta es una analogía del desarrollador del kernel Al Viro (traducida):
>> +
>> +	*"Piense en un maestro que califica la tarea de un estudiante de
>> +	matemáticas. El maestro no quiere ver los intentos y errores del
>> +	estudiante antes de que se les ocurriera la solución. Quiere ver la
>> +	respuesta más limpia y elegante. Un buen estudiante lo sabe, y nunca
>> +	presentaría su trabajo intermedio antes de tener la solución final.*
>> +
>> +	* Lo mismo ocurre con el desarrollo del kernel. Los maintainers y
>> +	revisores no quieren ver el proceso de pensamiento detrás de la solución
>> +	al problema que se está resolviendo. Quieren ver un solución simple y
>> +	elegante."*
>> +
>> +Puede resultar un reto mantener el equilibrio entre presentar una solución
>> +elegante y trabajar junto a la comunidad, discutiendo su trabajo inacabado.
>> +Por lo tanto, es bueno comenzar temprano en el proceso para obtener
>> +"feedback" y mejorar su trabajo, pero también mantenga sus cambios en
>> +pequeños trozos que pueden ser aceptados, incluso cuando toda su labor no
>> +está listo para inclusión en un momento dado.
>> +
>> +También tenga en cuenta que no es aceptable enviar parches para su
>> +inclusión que están sin terminar y serán "arreglados más tarde".
>> +
>> +Justifique sus cambios
>> +----------------------
>> +
>> +Además de dividir sus parches, es muy importante que deje a la comunidad de
>> +Linux sabe por qué deberían agregar este cambio. Nuevas características
>> +debe justificarse como necesarias y útiles.
>> +
>> +Documente sus cambios
>> +--------------------
>> +
>> +Cuando envíe sus parches, preste especial atención a lo que dice en el
>> +texto de su correo electrónico. Esta información se convertirá en el
>> +ChangeLog del parche, y se conservará para que todos la vean, todo el
>> +tiempo. Debe describir el parche por completo y contener:
>> +
>> +  - por que los cambios son necesarios
>> +  - el diseño general de su propuesta
>> +  - detalles de implementación
>> +  - resultados de sus experimentos
>> +
>> +Para obtener más detalles sobre cómo debería quedar todo esto, consulte la
>> +sección ChangeLog del documento:
>> +
>> +  "The Perfect Patch"
>> +      https://www.ozlabs.org/~akpm/stuff/tpp.txt
>> +
>> +Todas estas cuestiones son a veces son muy difíciles de conseguir. Puede
>> +llevar años perfeccionar estas prácticas (si es que lo hace). Es un proceso
>> +continuo de mejora que requiere mucha paciencia y determinación. Pero no se
>> +rinda, es posible. Muchos lo han hecho antes, y cada uno tuvo que comenzar
>> +exactamente donde está usted ahora.
>> +
>> +
>> +----------
>> +
>> +Gracias a Paolo Ciarrocchi que permitió que la sección "Development Process"
>> +se basara en el texto que había escrito (https://lwn.net/Articles/94386/),
>> +y a Randy Dunlap y Gerrit Huizenga por algunas de la lista de cosas que
>> +debes y no debes decir. También gracias a Pat Mochel, Hanna Linder, Randy
>> +Dunlap, Kay Sievers, Vojtech Pavlik, Jan Kara, Josh Boyer, Kees Cook,
>> +Andrew Morton, Andi Kleen, Vadim Lobanov, Jesper Juhl, Adrian Bunk,
>> +Keri Harris, Frans Pop, David A. Wheeler, Junio ​​Hamano, Michael Kerrisk y
>> +Alex Shepard por su revisión, comentarios y contribuciones. Sin su ayuda,
>> +este documento no hubiera sido posible.
>> +
>> +Maintainer: Greg Kroah-Hartman <greg@kroah.com>
> kernel test robot have already reported documentation warnings at [1],
> so I have applied the fixup:
Nice, I'll make sure to include this in v2
>
> ---- >8 ----
>
> diff --git a/Documentation/translations/sp_SP/howto.rst b/Documentation/translations/sp_SP/howto.rst
> index 4cf8fa6b9f7c2e..0c072b9a69df30 100644
> --- a/Documentation/translations/sp_SP/howto.rst
> +++ b/Documentation/translations/sp_SP/howto.rst
> @@ -183,7 +183,7 @@ con::
>   	make epubdocs
>   
>   Convertirse en un/a desarrollador/a de kernel
> --------------------------------------------
> +---------------------------------------------
>   
>   Si no sabe nada sobre el desarrollo del kernel de Linux, debería consultar
>   el proyecto Linux KernelNewbies:
> @@ -274,8 +274,8 @@ Vale la pena mencionar lo que Andrew Morton escribió en las listas de
>   correo del kernel de Linux, sobre lanzamientos del kernel (traducido):
>   
>   	*"Nadie sabe cuándo se publicara un nuevo kernel, porque esto sucede
> -    de acuerdo con el estado de bugs (error) percibido, no de acuerdo con
> -    una línea temporal preconcebida."*
> +        de acuerdo con el estado de bugs (error) percibido, no de acuerdo con
> +        una línea temporal preconcebida."*
>   
>   Varios árboles estables con múltiples major numbers
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -556,7 +556,7 @@ Esta es una analogía del desarrollador del kernel Al Viro (traducida):
>   	respuesta más limpia y elegante. Un buen estudiante lo sabe, y nunca
>   	presentaría su trabajo intermedio antes de tener la solución final.*
>   
> -	* Lo mismo ocurre con el desarrollo del kernel. Los maintainers y
> +	*Lo mismo ocurre con el desarrollo del kernel. Los maintainers y
>   	revisores no quieren ver el proceso de pensamiento detrás de la solución
>   	al problema que se está resolviendo. Quieren ver un solución simple y
>   	elegante."*
> @@ -579,7 +579,7 @@ Linux sabe por qué deberían agregar este cambio. Nuevas características
>   debe justificarse como necesarias y útiles.
>   
>   Documente sus cambios
> ---------------------
> +---------------------
>   
>   Cuando envíe sus parches, preste especial atención a lo que dice en el
>   texto de su correo electrónico. Esta información se convertirá en el
>
> Muchas gracias (thanks very much).
Cheers!
>
> [1]: https://lore.kernel.org/linux-doc/202210141348.7UGXRUp8-lkp@intel.com/
