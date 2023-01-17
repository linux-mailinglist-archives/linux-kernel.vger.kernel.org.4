Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832FD66E129
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjAQOpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjAQOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:45:14 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64113D089;
        Tue, 17 Jan 2023 06:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+PvewrhZZQ5zUGUyd2NZXDTjqb61NRT8rIaAv+LTZGPRIJ2O1LCRwBFKFdCeaGGkAgS5sR4KgcS9DF1YYK+pZuEanKv2rOL4lAt1cPvTz5oAdjU/0UwFtqbWHGqceAElg0bSNcj/9gqm9djslr5AxG/8IwVbvkUNW+9KZbpLxJMMB/L3vX400gVN9CFFoW8en+WCXnEiz9HOPWA0UGr/YLbMKn/3nlBjPfvTBs9ORuKuc0oeaCYIvuveQFdzpmlezzZL79nhKtauU4tbFS4wNY/rIKSCdHxWfBMLAPHQDhv6PdvZULMEylpWbjSh/ROmAXNBWAj9X2gGH2GCF5WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBPdLHflGJpMuEz4fW/xrVddn/bkqtcS6Z9Fjg5XfxM=;
 b=C7pkkUGxWDs5LDgyEqqr2azCrbjdhQRNI9hkAHlVgRk+Aq61ZcrQdnnWLHQNTWvP/L/m2ulQCXKJ0tKeHPUtUv77ZolZrWnKxcaR7+8Lf+EGKa4YzxgVmj9SFs8JYGgXxf4eDXKbkiYYnT9mqFp76uBFCmAkvLg+bBFvFbaJSVgO0a5bgjFFSaMnWpjIlDP2cLeVHQKbuaUwsz8HksXcjKOE42PTX171I+pOHh8ywmh2OGOB70y+Aa+jZYr6QbV9eABJNxwgm3t6UFnbho98TDMlshZKKirVJov2QfG9SeAQrKOaGimapWmm8ns6Mjo6GDQZXtlxsQuCznSoBnxABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBPdLHflGJpMuEz4fW/xrVddn/bkqtcS6Z9Fjg5XfxM=;
 b=W/6ytxpr98W1UzeHm4wNjTjT8H33jWEDGFdYDq7LiNAMuVI14IpSEUJh9+68uFALVDSd8DGXAnY32dNJec/Fhx9acjzaceBJfCAV8Fq5JOdhgaf1WzI3G8B9nUPpxmA3+p1/sgObjdALS/Gib5rzPn1uJXMNA/+/BRh0t3HTvtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 14:45:10 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 14:45:10 +0000
Message-ID: <272c6c52-767f-8b3d-ab37-4bc7d3161fff@amd.com>
Date:   Tue, 17 Jan 2023 08:45:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs/sp_SP: Add process email-clients translation
Content-Language: en-US
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
References: <20230117144230.28626-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230117144230.28626-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:59::14) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: ff561c19-0455-45fc-ab21-08daf8996ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNkS/D7y4gyt0nB0FBsb9mK0dBlQyLig6ZsBj8S/3PLqy1hAlXuOv3pHT1wIVDk3dYN2Ntc+58rspqt5LxpTUNicr1vAY6k6suhCeSkfMAGwO5e0VIoRKpLDZimCvrJDIA5+fVX5KI6n85rVNQorM5+QrlD5kTdUnQP4YHV+Vt5FMVNNetFxK6xHu07lb96RpzKZKsUNbpC4wvxi2LBlhfAxXAkRK81jmg58qQnhZwJNom/BPfmKVymsXK0gHwbGy/O+Nw7B3X0WNCMBCFneH+JApYCSgStio/seWNIfmXUhLCFe1wN4PDyIxuhXSE1lTvKHpx9+EILnR7++lV0NcjwwVXDNMUxE0DUDA2NWI1Za0oQV7qr4jEkyF3lsD4et6Vu/ri4rry8uTA/NaFfLMwHMc6t6vim/w/3ArqtC51fiBEHAsM4v7anguws+ZgYumQd5XdIIMFcjmIRT8gGqU7/4m5woyRGvWIryf1s8+/LGW5nX4bt4s2rhsHSswRW3YJxYehDwuBzAXrZILqCY/7e8gf2tXjRPACDZZS82af7viXWuZiA5mYdYsgbZppl7/VcDpZbsBpYKI6tfO13wLSQ0b5DqLpjzzNtSxLnPGu1Tk01OZmMffMT5T+mLofIX9q1iMcEYBvq9YXqNgT3ugFKIeLRorl+PyeYCHpuUOXhkxEJe6ROBFf7Y7zSYEr32F4pYzQoT8k8HUH373kGGPsR963myZ5zgwMzlFFaPcZhmILOvkB9T1edtjgLR6GUF5itJbLIRmkDOnfD/0Has0tnYrRfbkxd+ju+oIYrUSJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:es;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(31686004)(36756003)(38100700002)(86362001)(6916009)(30864003)(44832011)(8936002)(66556008)(66476007)(66946007)(31696002)(5660300002)(4326008)(2906002)(8676002)(83380400001)(6486002)(966005)(316002)(6666004)(45080400002)(478600001)(41300700001)(66574015)(2616005)(53546011)(26005)(6512007)(6506007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBtM0d0dFFsMHRCUENiMmMwakE0Y2dwU0Zsa0tNaGRtVStXNGZoVVBFc2cx?=
 =?utf-8?B?ZERueTVuWWRVMW5leUtGcUlaeDhQcU54Q3Y3VkFLRXlVTnQ3cVRqZjNxNyt6?=
 =?utf-8?B?UU9sbEtmYkZkSEt3QW1TaUdURWNwVVB5NEdGYytuOXliMWt0NkVoQ3krWklC?=
 =?utf-8?B?S1NmY1lLdW1YTTVRbjNHeSttQ09YcmVpeTdhMWttS3ZObjVndm01cllWZ3FE?=
 =?utf-8?B?NzJpcWZ6OFR2cHl2cVZtTHhQQ2FHT3FReU9wRnhrWHUyK09GbjhiVVJXNkpq?=
 =?utf-8?B?dG1rcmx6aThGNC9PRC9mV1FXaVFNbnJSbERiSXNRckk5SnZDUTJpTjlTeTJP?=
 =?utf-8?B?c3NRMWc5dlo2TkIvaXVzWXFpc3RKcGQ5c0UrenBFVnBZbGsrNlhTZU1KaXlS?=
 =?utf-8?B?MmFMMllReGpRNmtCeGNiUDFKamY2eU5EOVNLS3FSMjRsbTZXcktHQmxTYXVs?=
 =?utf-8?B?N1B4T2dBYXpPZkpyN2l6Q3hSRTltcmhyNUNXcm5VVUdBR3BRTGpibjh3bWZv?=
 =?utf-8?B?cStBdmRCOVp5WWxiM3dRYlI2TjgzWjd3MUdwVExIcDhUaklLNHpQeHZyVFcw?=
 =?utf-8?B?YXIxNVhjOFZqSy9wbGFLWkdRQ01IMmtyN1pjT1NNSGRPNDNlR3FSWkRCTFR6?=
 =?utf-8?B?Z2g3ejk5OEtIUkFIUTlWTE9Yejk5K1FQZG5zV1ZwS1ZHSVA1amtpTGw0VkVQ?=
 =?utf-8?B?M1BYMVJoTFRYdWRqTUlzdWdhZlpTbDhQb2ttY2cvNVpjRzRCeThQRWJmOStm?=
 =?utf-8?B?d01VcnFDVTZZUkJ5T3M2WkMzTGZyV2RBclZ5eU1YZUZ2akFKcFM3TjVlalpK?=
 =?utf-8?B?QU9tbnZVbVFIdGZvWTVKcmRianF4dlJrUjhPQ0w3d205eUk0OFpxT3R6WDRp?=
 =?utf-8?B?eDQ5Q0dFVC9Yc0NGRWh3V2U4MVNQQUNEeVp6MnREQ3N6MHFyaGJvQzRpRTM1?=
 =?utf-8?B?QUw5a0hNMnJpVG1yaWVxbitDeGhTSW5PT0tvZks1R3Y1TUJQMWxzQWhzTFhn?=
 =?utf-8?B?ZXpZQzhucmdVR3NiWkRBc20vWWkxYmFqZTRUR3NxUW9jek1DQVZ3dlhwcGJu?=
 =?utf-8?B?WHlwQkV0ZS94WjBiUDVoQ2lzWnFOY01GOUtoTDNSS0s3eUtrSVV6WlJKSGZO?=
 =?utf-8?B?YmwzT0xlSjZTa0pxTWZQZnBVaW5wR09JTENhaUF5anhJMFZmbjcyWkJSaGZn?=
 =?utf-8?B?Mk5ZRituYmxXUjhreHkxZWZyMXNKVXprKzk2NS8xUDBreW1Obkh4SWF3R2E3?=
 =?utf-8?B?YWVoMTF6b25Kdy9IQ0lOWm9IYTZPMXhsNXhMTUxORHAyNFAwTDdEckxoZlpD?=
 =?utf-8?B?cWswLzFqRkx3ZDBrMXg1ZnI4NlIva3VnaHY3Qk9JSm1HdWtMK2xqZ2FFZWdW?=
 =?utf-8?B?aHJFajF6Rll2NjhNWEtzVlcwb0U4a09lZ240V0hKUUUrZkU1NTF6dEV4TGpi?=
 =?utf-8?B?SzRGQkdPeVdFbytjY0RLdU5udXIwUldQY2hEamZlZi83YlZ1V252MEFmbzA1?=
 =?utf-8?B?SHllaEw5Y1Vxb2NzMkJ3bUNYYkdpN0pZVnd6VmlNcEp6bTk1cXA0cWtNUitK?=
 =?utf-8?B?RklMTXJJNER3VENJaWExdEdmWlBZcGMyalZYMUJkejNtenZ2Ky9aRjhRODFj?=
 =?utf-8?B?U3BOM0dSTWc2a1VHODNYU1lubUtzeU9SZTdSbExObExEcHphNG5VYWRsaG1L?=
 =?utf-8?B?UnB4WjNTYWFDM1AyQm5INWVKYk5nT21SQkRiNW1MZ3krcTZjcU96bmZjWVNr?=
 =?utf-8?B?eWh6Y1k4Z3kzSUVLSFdaWmtENGR3dFNtZVZxcFZnRlR5Z0FjZ2RYbm1uM01k?=
 =?utf-8?B?K2NFMkEyWDZ6L3pyQVhCSDVlRzVZWFZTUzR1cFk5LzQzRHhiZlVWaDdZSFJn?=
 =?utf-8?B?c3BIZmlqZW9tV2xFNWZMaGVFRlcwTEQ3dDR0dG1hOER3WHN3alJWbzg4Z21h?=
 =?utf-8?B?VFFQNnQ5Y01KOVE4S2dPallJTHhKMHVvcW8yR01PYjRTTVJCRHhCZ1BLSnlO?=
 =?utf-8?B?T1dXQmFGUVNUbmNvUk9PMmZwUFZhOUJaSUx4eHBmbVFUUGZPdUkyU0RRcVRm?=
 =?utf-8?B?Q0E0d2NNOGk4M2tXdTFHREQ4MDNxZC9rN2VnUUJKNW9GK2szZzd6TWgzTGph?=
 =?utf-8?Q?XKJtgUqB0LrP/dPeFcB0rl2oi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff561c19-0455-45fc-ab21-08daf8996ee3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 14:45:10.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6apM3sptWO2iSpYhDn8E7reCPRN0ZXgq9eTFvS3ZSQfyUePDda8Ehgzk+h2ZMNIRkoKt+cfi49JgWfgVhS6ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 08:42, Carlos Bilbao wrote:

> Translate the following document into Spanish:
>
> - process/email-clients.rst
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   .../sp_SP/process/email-clients.rst           | 378 ++++++++++++++++++
>   .../translations/sp_SP/process/index.rst      |   1 +
>   2 files changed, 379 insertions(+)
>   create mode 100644 Documentation/translations/sp_SP/process/email-clients.rst
>
> diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
> new file mode 100644
> index 000000000000..cfe92041e91d
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/process/email-clients.rst
> @@ -0,0 +1,378 @@
> +.. include:: ../disclaimer-sp.rst
> +
> +:Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
> +:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
> +
> +.. _sp_email_clients:
> +
> +Información de clientes de correo electrónico para Linux
> +========================================================
> +
> +Git
> +---
> +
> +A día de hoy, la mayoría de los desarrolladores usan ``git send-email`` en
> +lugar de los clientes de correo electrónico normales. La página de manual
> +para esto es bastante buena. En la recepción del correo, los maintainers
> +usan ``git am`` para aplicar los parches.
> +
> +Si es usted nuevo en ``git`` entonces envíese su primer parche. Guárdelo
> +como texto sin formato, incluidos todos los encabezados. Ejecute ``git am raw_email.txt``
> +y luego revise el registro de cambios con ``git log``. Cuando eso funcione,
> +envíe el parche a la(s) lista(s) de correo apropiada(s).
> +
> +Preferencias Generales
> +----------------------
> +
> +Los parches para el kernel de Linux se envían por correo electrónico,
> +preferiblemente como texto en línea en el cuerpo del correo electrónico.
> +Algunos maintainers aceptan archivos adjuntos, pero entonces los archivos
> +adjuntos deben tener tipo de contenido ``text/plain``. Sin embargo, los
> +archivos adjuntos generalmente están mal vistos porque hacen que citar
> +partes del parche sea más difícil durante el proceso de revisión del
> +parche.
> +
> +También se recomienda encarecidamente que utilice texto sin formato en el
> +cuerpo del correo electrónico, para parches y otros correos electrónicos
> +por igual. https://useplaintext.email puede ser útil para obtener
> +información sobre cómo configurar su cliente de correo electrónico
> +preferido, así como una lista de clientes de correo electrónico
> +recomendados si aún no tiene una preferencia.
> +
> +Los clientes de correo electrónico que se utilizan para los parches del
> +kernel Linux deben enviar el texto del parche intacto. Por ejemplo, no
> +deben modificar ni eliminar pestañas o espacios, incluso al principio o al
> +final de las líneas.
> +
> +No envíe parches con ``format=flowed``. Esto puede causar saltos de línea
> +no deseados e inesperados.
> +
> +No deje que su cliente de correo electrónico ajuste automáticamente las
> +palabras por usted. Esto también puede corromper su parche.
> +
> +Los clientes de correo electrónico no deben modificar la codificación del
> +de caracteres del texto. Los parches enviados por correo electrónico deben
> +estar en codificación ASCII o UTF-8 únicamente. Si configura su cliente de
> +correo electrónico para enviar correos electrónicos con codificación UTF-8,
> +evite algunos posibles problemas con los caracteres.
> +
> +Los clientes de correo electrónico deben generar y mantener los
> +encabezados "References:" o "In-Reply-To:"  para que el hilo de correo no
> +se rompa.
> +
> +Copiar y pegar (o cortar y pegar) generalmente no funciona para los
> +parches, porque las tabulaciones se convierten en espacios. Utilizar
> +xclipboard, xclip y/o xcutsel puede funcionar, pero es mejor probarlo usted
> +mismo o simplemente evitar copiar y pegar.
> +
> +No utilice firmas PGP/GPG en el correo que contiene parches.
> +Esto rompe muchos scripts que leen y aplican los parches.
> +(Esto debería ser reparable.)
> +
> +Es una buena idea enviarse un parche a sí mismo, guardar el mensaje
> +recibido, y aplicarlo con éxito con 'patch' antes de enviar el parche a las
> +listas de correo de Linux.
> +
> +Algunas sugerencias para el cliente de correo electrónico (MUA)
> +---------------------------------------------------------------
> +
> +Here are some specific MUA configuration hints for editing and sending
> +patches for the Linux kernel.  These are not meant to be complete
> +software package configuration summaries.


Oops, reviewing once more I noticed I left a paragraph in English here.
My apologies, sending again.


> +
> +Aquí hay algunos consejos específicos de configuración de MUA para editar y
> +enviar parches para el kernel de Linux. Estos no pretenden cubrir todo
> +detalle de configuración de los paquetes de software.
> +
> +Leyenda:
> +
> +- TUI = text-based user interface (interfaz de usuario basada en texto)
> +- GUI = graphical user interface (interfaz de usuario gráfica)
> +
> +Alpine (TUI)
> +************
> +
> +Opciones de configuración:
> +
> +En la sección :menuselection:`Sending Preferences`:
> +
> +- :menuselection: `Do Not Send Flowed Text` debe estar ``enabled``
> +- :menuselection:`Strip Whitespace Before Sending` debe estar ``disabled``
> +
> +Al redactar el mensaje, el cursor debe colocarse donde el parche debería
> +aparecer, y luego presionando :kbd:`CTRL-R` se le permite especificar e
> +archivo de parche a insertar en el mensaje.
> +
> +Claws Mail (GUI)
> +****************
> +
> +Funciona. Algunos usan esto con éxito para los parches.
> +
> +Para insertar un parche haga :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`)
> +o use un editor externo.
> +
> +Si el parche insertado debe editarse en la ventana de composición de Claws
> +"Auto wrapping" en
> +:menuselection:`Configuration-->Preferences-->Compose-->Wrapping` debe
> +permanecer deshabilitado.
> +
> +Evolution (GUI)
> +***************
> +
> +Algunos usan esto con éxito para sus parches.
> +
> +Cuando escriba un correo seleccione: Preformat
> +  desde :menuselection:`Format-->Paragraph Style-->Preformatted` (:kbd:`CTRL-7`)
> +  o en la barra de herramientas
> +
> +Luego haga:
> +:menuselection:`Insert-->Text File...` (:kbd:`ALT-N x`)
> +para insertar el parche.
> +
> +También puede hacer ``diff -Nru old.c new.c | xclip``, seleccione
> +:menuselection:`Preformat`, luego pege con el boton del medio.
> +
> +Kmail (GUI)
> +***********
> +
> +Algunos usan Kmail con éxito para los parches.
> +
> +La configuración predeterminada de no redactar en HTML es adecuada; no haga
> +cambios en esto.
> +
> +Al redactar un correo electrónico, en las opciones, desmarque "word wrap".
> +La única desventaja es que cualquier texto que escriba en el correo
> +electrónico no se ajustará a cada palabra, por lo que tendrá que ajustar
> +manualmente el texto antes del parche. La forma más fácil de evitar esto es
> +redactar su correo electrónico con Word Wrap habilitado, luego guardar
> +como borrador. Una vez que lo vuelva a sacar de sus borradores, estará
> +envuelto por palabras y puede desmarcar "word wrap" sin perder el existente
> +texto.
> +
> +En la parte inferior de su correo electrónico, coloque el delimitador de
> +parche de uso común antes de insertar su parche:  tres guiones (``---``).
> +
> +Luego desde la opción de menu :menuselection:`Message` seleccione
> +:menuselection:`insert file` y busque su parche.
> +De forma adicional, puede personalizar el menú de la barra de herramientas
> +de creación de mensajes y poner el icono :menuselection:`insert file`.
> +
> +Haga que la ventana del editor sea lo suficientemente ancha para que no se
> +envuelva ninguna línea. A partir de KMail 1.13.5 (KDE 4.5.4), KMail
> +aplicará ajuste de texto al enviar el correo electrónico si las líneas se
> +ajustan en la ventana del redactor. Tener ajuste de palabras deshabilitado
> +en el menú Opciones no es suficiente. Por lo tanto, si su parche tiene
> +líneas muy largas, debe hacer que la ventana del redactor sea muy amplia
> +antes de enviar el correo electrónico. Consulte: https://bugs.kde.org/show_bug.cgi?id=174034
> +
> +You can safely GPG sign attachments, but inlined text is preferred for
> +patches so do not GPG sign them.  Signing patches that have been inserted
> +as inlined text will make them tricky to extract from their 7-bit encoding.
> +
> +Puede firmar archivos adjuntos con GPG de forma segura, pero se prefiere el
> +texto en línea para parches, así que no los firme con GPG. Firmar parches
> +que se han insertado como texto en línea hará que sea difícil extraerlos de
> +su codificación de 7 bits.
> +
> +Si es absolutamente necesario enviar parches como archivos adjuntos en
> +lugar de como texto en línea, haga clic con el botón derecho en el archivo
> +adjunto y seleccione :menuselection:`properties`, y luego
> +:menuselection:`Suggest automatic display` para hacer que el archivo
> +adjunto esté en línea para que sea más visible.
> +
> +Al guardar parches que se envían como texto en línea, seleccione el correo
> +electrónico que contiene el parche del panel de la lista de mensajes, haga
> +clic con el botón derecho y seleccione :menuselection:`save as`.  Puede usar
> +todo el correo electrónico sin modificar como un parche de estar bien
> +compuesto. Los correos electrónicos se guardan como lectura y escritura
> +solo para el usuario, por lo que tendrá que cambiarlos para que sean
> +legibles en grupo y en todo el mundo si copia estos en otro lugar.
> +
> +Notas de Lotus (GUI)
> +********************
> +
> +Huya de este.
> +
> +IBM Verse (Web GUI)
> +*******************
> +
> +Vea notas sobre Lotus.
> +
> +Mutt (TUI)
> +**********
> +
> +Muchos desarrolladores de Linux usan ``mutt``, por lo que debe funcionar
> +bastante bien.
> +
> +Mutt no viene con un editor, por lo que cualquier editor que use debe ser
> +utilizado de forma que no haya saltos de línea automáticos. La mayoría de
> +los editores tienen una opción :menuselection:`insert file` que inserta el
> +contenido de un archivo inalterado.
> +
> +Para usar ``vim`` con mutt::
> +
> +  set editor="vi"
> +
> +Si utiliza xclip, escriba el comando::
> +
> +  :set paste
> +
> +antes del boton del medio o shift-insert o use::
> +
> +  :r filename
> +
> +si desea incluir el parche en línea.
> +(a)ttach (adjuntar) funciona bien sin ``set paste``.
> +
> +También puedes generar parches con ``git format-patch`` y luego usar Mutt
> +para enviarlos::
> +
> +    $ mutt -H 0001-some-bug-fix.patch
> +
> +Opciones de configuración:
> +
> +Debería funcionar con la configuración predeterminada.
> +Sin embargo, es una buena idea establecer ``send_charset`` en:
> +
> +  set send_charset="us-ascii:utf-8"
> +
> +Mutt es altamente personalizable. Aquí tiene una configuración mínima para
> +empezar a usar Mutt para enviar parches a través de Gmail::
> +
> +  # .muttrc
> +  # ================  IMAP ====================
> +  set imap_user = 'suusuario@gmail.com'
> +  set imap_pass = 'sucontraseña'
> +  set spoolfile = imaps://imap.gmail.com/INBOX
> +  set folder = imaps://imap.gmail.com/
> +  set record="imaps://imap.gmail.com/[Gmail]/Sent Mail"
> +  set postponed="imaps://imap.gmail.com/[Gmail]/Drafts"
> +  set mbox="imaps://imap.gmail.com/[Gmail]/All Mail"
> +
> +  # ================  SMTP  ====================
> +  set smtp_url = "smtp://username@smtp.gmail.com:587/"
> +  set smtp_pass = $imap_pass
> +  set ssl_force_tls = yes # Requerir conexión encriptada
> +
> +  # ================  Composición  ====================
> +  set editor = `echo \$EDITOR`
> +  set edit_headers = yes  # Ver los encabezados al editar
> +  set charset = UTF-8     # valor de $LANG; also fallback for send_charset
> +  # El remitente, la dirección de correo electrónico y la línea de firma deben coincidir
> +  unset use_domain        # Porque joe@localhost es simplemente vergonzoso
> +  set realname = "SU NOMBRE"
> +  set from = "username@gmail.com"
> +  set use_from = yes
> +
> +Los documentos Mutt tienen mucha más información:
> +
> +    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail
> +
> +    http://www.mutt.org/doc/manual/
> +
> +Pine (TUI)
> +**********
> +
> +Pine ha tenido algunos problemas de truncamiento de espacios en blanco en
> +el pasado, pero estos todo debería estar arreglados ahora.
> +
> +Use alpine (sucesor de pino) si puede.
> +
> +Opciones de configuración:
> +
> +- ``quell-flowed-text`` necesitado para versiones actuales
> +- la opción ``no-strip-whitespace-before-send`` es necesaria
> +
> +
> +Sylpheed (GUI)
> +**************
> +
> +- Funciona bien para insertar texto (o usar archivos adjuntos).
> +- Permite el uso de un editor externo.
> +- Es lento en carpetas grandes.
> +- No realizará la autenticación TLS SMTP en una conexión que no sea SSL.
> +- Tiene una útil barra de reglas en la ventana de redacción.
> +- Agregar direcciones a la libreta de direcciones no las muestra
> +  adecuadamente.
> +
> +Thunderbird (GUI)
> +*****************
> +
> +Thunderbird es un clon de Outlook al que le gusta alterar el texto, pero
> +hay formas para obligarlo a comportarse.
> +
> +Después de hacer las modificaciones, que incluye instalar las extensiones,
> +necesita reiniciar Thunderbird.
> +
> +- Permitir el uso de un editor externo:
> +
> +  Lo más fácil de hacer con Thunderbird y los parches es usar extensiones
> +  que abran su editor externo favorito.
> +
> +  Aquí hay algunas extensiones de ejemplo que son capaces de hacer esto.
> +
> +  - "External Editor Revived"
> +
> +    https://github.com/Frederick888/external-editor-revived
> +
> +    https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/
> +
> +    Requiere instalar un "native messaging host".
> +    Por favor, lea la wiki que se puede encontrar aquí:
> +    https://github.com/Frederick888/external-editor-revived/wiki
> +
> +  - "External Editor"
> +
> +    https://github.com/exteditor/exteditor
> +
> +    Para hacer esto, descargue e instale la extensión, luego abra la ventana
> +    :menuselection:`compose`, agregue un botón para ello usando
> +    :menuselection:`View-->Toolbars-->Customize...`
> +    luego simplemente haga clic en el botón nuevo cuando desee usar el editor
> +    externo.
> +
> +    Tenga en cuenta que "External Editor" requiere que su editor no haga
> +    fork, o en otras palabras, el editor no debe regresar antes de cerrar.
> +    Es posible que deba pasar flags adicionales o cambiar la configuración
> +    de su editor. En particular, si está utilizando gvim, debe pasar la
> +    opción -f a gvim poniendo ``/usr/bin/gvim --nofork"`` (si el binario
> +    está en ``/usr/bin``) al campo del editor de texto en los ajustes
> +    :menuselection:`external editor`. Si está utilizando algún otro editor,
> +    lea su manual para saber cómo hacer esto.
> +
> +Para sacarle algo de sentido al editor interno, haga esto:
> +
> +- Edite sus ajustes de configuración de Thunderbird para que no utilice ``format=flowed``!
> +  Vaya a su ventana principal y busque el botón de su menú desplegable principal.
> +  :menuselection:`Main Menu-->Preferences-->General-->Config Editor...`
> +  para abrir el editor de registro de Thunderbird.
> +
> +  - Seleccione ``mailnews.send_plaintext_flowed`` como ``false``
> +
> +  - Seleccione ``mailnews.wraplength`` de ``72`` a ``0``
> +
> +- ¡No escriba mensajes HTML! Acuda a la ventana principal
> +  :menuselection:`Main Menu-->Account Settings-->youracc@server.something-->Composition & Addressing`!
> +  Ahí puede deshabilitar la opción "Compose messages in HTML format".
> +
> +- ¡Abra mensajes solo como texto sin formato! Acuda a la ventana principal
> +  :menuselection:`Main Menu-->View-->Message Body As-->Plain Text`!
> +
> +TkRat (GUI)
> +***********
> +
> +Funciona.  Utilice "Insert file..." o un editor externo.
> +
> +Gmail (Web GUI)
> +***************
> +
> +No funciona para enviar parches.
> +
> +El cliente web de Gmail convierte las tabulaciones en espacios automáticamente.
> +
> +Al mismo tiempo, envuelve líneas cada 78 caracteres con saltos de línea de
> +estilo CRLF aunque el problema de tab2space se puede resolver con un editor
> +externo.
> +
> +Otro problema es que Gmail codificará en base64 cualquier mensaje que tenga
> +un carácter no ASCII. Eso incluye cosas como nombres europeos.
> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
> index f7e1f3d814f2..ca95cd296ee1 100644
> --- a/Documentation/translations/sp_SP/process/index.rst
> +++ b/Documentation/translations/sp_SP/process/index.rst
> @@ -15,3 +15,4 @@
>      coding-style
>      code-of-conduct
>      kernel-enforcement-statement
> +   email-clients


Thanks,

Carlos

