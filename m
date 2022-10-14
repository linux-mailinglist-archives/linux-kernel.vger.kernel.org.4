Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A445FF176
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJNPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJNPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:33:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D91D81AE;
        Fri, 14 Oct 2022 08:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKWiDalIDwJGREHCEkNmbUadGjLpD9AV9quzy1m+wGEPpTrHRh6fI811T+BodeWfl1OqZqUALs5E95AzSdoDmcTr+q4WYV4u0Q3rWXhhLTUbBd7C6UP8w+ne6Owk8l/6BN/XYjA2Ns5YM4fhoouiFYgaCpA+JC2bW5IOnamqdHtWivouymBc2f/0q/9CVMjAxVmO5bxvmRDMXiuUYzTtYAVrZ/SdS48Qn4ugLoJQ2tQ+4Wk1Bk67NPDFI7d6pC4lgv54800xEmDMoCtuceDTt3v9gab6pMbqacCkzzbn1l3/DPDQWqD5l4FdZ9KcAx/hPPYHCpPQoEyYDOfv580+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5++sz7sAo2f7tLdttFYHT7e1KwjCod1GyRgOeyRJck=;
 b=mcd3m1Kki5kbHnlJHseDYdjQ+ROTxhSNg6xbDcOFUukK9ik7qFwBPi6xl0bwnLK7ekkQ45ZJjE+Kjb2qdmXJLyE2sVSCMT6Jx8dBZxYHOy9A55Pf+vDIdQitK9HOg/SFzvMNMKcNaebRg7bL86HFzDu5l8oyDxnvV8Lpr2BVef+RCaW4Uk/liUNtJzS6xuo4ZsN3iKcnJONyALaBHQMGcKbPz960fnFBaEDGa6edBMOUl/ZStL1n5wfwiLuJUpaYMVAUJVdwAba4EKGJv4QTdCLfaA5Vv3E0sfwYC5T0vkAdVbA/XnxbNnjpxYsra/E7LoXbY2AAwMirJWWDEcttCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5++sz7sAo2f7tLdttFYHT7e1KwjCod1GyRgOeyRJck=;
 b=NReToDsa1f/Kvgmq0NXUV1RgaAGZxnGrJ61C3JhM/4hXUDozz1DwgkG5S1Unz6yEF95wwVki50DlnMAWy9/Sk/Sq1P1QDLd0QKy4Oh4OlULN1f8TbzUkf5MRriyVkJujbhnl1BIsDm65r9G2DB+sGGJc1Da4LslrMo8/y3KfseE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 15:33:07 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649%7]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 15:33:07 +0000
Message-ID: <735f9ddc-01b4-f9ab-8d28-6d10630c994d@amd.com>
Date:   Fri, 14 Oct 2022 10:33:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com>
 <20221014142454.871196-2-carlos.bilbao@amd.com>
 <CANiq72=DuRw_0AiC7LtWA7n_0Rpsz3cExXj4YX4zu4o8RxugJA@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72=DuRw_0AiC7LtWA7n_0Rpsz3cExXj4YX4zu4o8RxugJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:610:e6::28) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: bab51b66-be28-4f57-b233-08daadf964cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /R0hkDqtD80budr0jT8W0AfOvqxI3zokVJWBsLnqm2cSC3AHPBqcWlElQe/W6d1rw+ztrXTreT6kDo3fZMrtAm0L0SBkmvj573jm2E3cXj5h1gGBJBjWq7d4JFiXJWcOyFZukEsv9Tp6xgp/OsrzAJAresqS9Aq1kHNiHIwhiov4QQGUo65VEMiGab+/iEbnAEXmMlqtEUqiKKMOc1Ue6TS+SYfboY26EgY00JNvGHVNyIEvi1EAk1Et0RiEamPxoANxGCz4s8rNX6XOgoLL0h9SUVXGvbqEOr91rn5U9dCz5xBBBmMTHXDqS+d3TZxEYKcUsRcWqFNn8KWktzMNb1x/1oQafB8FLXVhH/J3btaS4negH6J/QFmgB9VHW1UWHRNho0uX/UUtNPlNm0qR9HjhwGX7Y4Yqu4DQW5Umvh05jTVT/TbYSM4r4MYIdEIkajIOeQ4EcMHzaWuu2SUtZFHktejkxbi6J8UtfodDeFDhyTpomLAtZggJXoCaDUpAWQDMNJ8XwoQq4lap8rVNdnraRqfQLYQAzarIXxyGjR1ntFt0umKgATBKRqLOpuOv6/WMMlZjU1EJTDA8RdwYCCPxVRdLMS6w8vD9P3lU40yCTVHfpGXIbI7RF0hIsSVYFlnpM1rv0Pr2A1RFSPXuxSApgwrhwAJjFU9AE+yHzYrHpm4nYK10bW7nTOCdKFVf34K2daVVokqnD+3OtprHhB0L3ILYtilVDol/TI0qwjzvk3pUSusNyS8ohD844V4bgo1xZrDEMRc1M5vHDust0+PqbFmODNJlq1Pfq59Bo4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(36756003)(31686004)(26005)(44832011)(31696002)(86362001)(2906002)(38100700002)(66574015)(5660300002)(186003)(2616005)(83380400001)(6506007)(53546011)(6512007)(66556008)(6486002)(66476007)(478600001)(316002)(6916009)(4326008)(8936002)(8676002)(41300700001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRrZWQ2ZkJpc0pmb3BzaXhUNXdQNG9UcUdXWjY5NHc4RSt1RTR2dGV5SUdU?=
 =?utf-8?B?WktnU1VjQStUeEZqbjExTDhSSWdTaUpQaGM0aWV3bTdQSkRFYjNpTVh1blQr?=
 =?utf-8?B?ZnIzekh4Y2lvN3VncmwrZDBpTW5zZzFyWUJSUHFPZ2tJelEyVFV4NDRuU01S?=
 =?utf-8?B?REl0dm0vbTlPYVFQaXp5VnM3SGY5SXFEMEQyZFRuSFRYWFFORlB4OGx2QTNr?=
 =?utf-8?B?TVBWeldzZTZBZlNNSGREVEdadkVsWVlHaGV4L2J4WU9YQ0lveVNWZ21NVDlN?=
 =?utf-8?B?cXVVbnNaVVNYQ1ZuRzlZRktMdy9RZ3dnaWNBZ3p5T3N1MEYvMVZaMy9xdVpI?=
 =?utf-8?B?dmJiMXpVbjljcFBpSlk3SThtNjFyWCtiN3B1ZXpNc3JvdnhhQU9IQkhtWERX?=
 =?utf-8?B?dDhndnVaYjdUTEtnN1hzQzZhOEIzSy9lODRzMU5lbjU3Ti9FSkN3R3lxcm1O?=
 =?utf-8?B?cGdUaFB6Sk1lVUdSTC94T1VSYkpiZlhJZXFXUGVaMmpHcFZFWnEzdHMxTmky?=
 =?utf-8?B?b21ZcUoxcEJOLzlWSno3RHh0TVFVNW9BSGRGVmdSYWlhZmJYWDJCUG82ZFZy?=
 =?utf-8?B?V2lBWkl0SExiT0tjc3I0Z1RCYVBYNzB4OGh6R3Yzd1FBazZuWGtqOUx6dUgy?=
 =?utf-8?B?YnRBU2hFQ09BQ2ZjM08wS3BiUlVXWXplY2pNYjJDMWptdlhmaGQzaDZNNGJY?=
 =?utf-8?B?Tm1oaDRSUUdSYkM3L010c2xYMDJyeXNvRTRhRjZLOWovNlFnZ3lUK0hNMGdv?=
 =?utf-8?B?aWpyTy90OWg0R3M3RVJwTG9ITndGbVJSWkE0UzhOS0ZZY2laYVZMbkl4cyt6?=
 =?utf-8?B?dDdjRG5UQ1ZIVkNEVTdBemtYanlta2k0M3VyYkJCS2NlQU52QnRJV1pqdmpG?=
 =?utf-8?B?dkd4empmeXMzSVZUeUhPSWQrMFZCbE1EbzU4Qi9jcDQ2azJnNmpiUVV4OVZa?=
 =?utf-8?B?VFBwQkJGcXJnSVBEcHZtZCtPTE04N1BNUGZFanBJeFBjaWdFNGZrN0pjcUVS?=
 =?utf-8?B?VW5ONHhnWUhzemlHblJDeFRWMjBkczFkemVoU3FrZGFqODBDNzdsOW0ybUsx?=
 =?utf-8?B?SkpnZStiS2tEVkYxRG1IblRTQmhmMjhISjduMjdzc0NBUFdybTJJTnBaMHRm?=
 =?utf-8?B?QnZtdlgwaVR1VGlRZGxlZW5KN1pSQ01sUkQxWDJ0ZEZvYzNlbTFxQSt1QUd0?=
 =?utf-8?B?U0tTV2JWeE0yQXFwQXBNSko1L1QvWnZmMldrekplV3FKM2pJT0hCaXNIYUFo?=
 =?utf-8?B?YTR1bjJIWnI1SjhEQ2VWZXlxNUhZOEtBY015dzNuT3Q4amkzOU1HdVN6OEkx?=
 =?utf-8?B?bnlrZlBjbHIzbHFhYlY4bVNqd0tSVkozb0NzMzVHeGQ4UmJObmhqV2RsZGFr?=
 =?utf-8?B?eVBoYjFFT1NKZ2t6VWc0YlNFZ2orWWNpb3l3QTVjdVgwOG4xUStQRFo2WXVu?=
 =?utf-8?B?VGZSeEYxa0NEeTZhelRyR0w5MmxhUnFFK2I0WDdlSUhEV1o0ZitCRGpoM0Fp?=
 =?utf-8?B?anArVjM4Q05MRWpHWkpSclpOTkRKZzhUTmJEcE12cW1WV3RBZmNVWjBTa0ha?=
 =?utf-8?B?bEJYblo2elNzcnNGYndQWmNaYkw0MEdiMWZWM2ZPUmxTM2sxNllHY1R1bk1Z?=
 =?utf-8?B?VHpjdTRZS2o4N1BrVU1lTmJ6VGFjZ3J6S1R1VXRRckJUWUtuNGhEK08zT0Yw?=
 =?utf-8?B?WEl5SXQrU0tWV21tSTVZbWxmUmxIcHZOc2RDaVNteVEwNk5KaTZyV2lzZ0Fr?=
 =?utf-8?B?TVkvajBtYjZRWUpId2l5S3E0OE5CaW1Pa3owOWxUbUdtb0hZR3o1NS9laU1p?=
 =?utf-8?B?VHlBclZlaktxeHpPK2VzNTRJU1g0NG14cFRaV3Q4THI2RXZsZGVWZndpVGJD?=
 =?utf-8?B?N3Q1Mkd1OE8yL0JnMEZxdTRoZmkvVHBXUisweWZTQTRORU5EYkFzU0ZjQlRV?=
 =?utf-8?B?azJROEhhbTZuc2M1Q3poVDNiQ0VOaDNHUzRpN1ZnbGR5NWtBcjN2U3pzR2RM?=
 =?utf-8?B?ZGlraFdVQkxoek1oUXBtN1Zvai9TK2tMOXZSSjF1NjVzbjQxTTZPMEc3VjNQ?=
 =?utf-8?B?Y3ROYzBBYUNVYlFrSjQwemphVmtEUTI4RTdpZ3RzbmFXeU5rQjdiRTV3R1hY?=
 =?utf-8?Q?+h8ElwXtIUT9STs9EZrsIP3PK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab51b66-be28-4f57-b233-08daadf964cc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 15:33:07.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQBRmu8seI/yLVM9H6xnhy7T121zWN8KQAb8UYMDGoSMF3fejzHsrn0Yw7W0yg4VbmQLN4BcL7lFtdBWDIoKYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 10:21, Miguel Ojeda wrote:

> Hi Carlos,
>
> Since you Cc'd me, I guess I can give a quick review. :)
Thanks Miguel. You came to mind immediately when thinking about CCing
someone else that's a native speaker.
>
> On Fri, Oct 14, 2022 at 4:40 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>> +=======================
>> +Traducción al español
>> +=======================
> I think these should be as long as the title.
>
>> +La propagación simultanea de la traducción de una modificación en
> "simultánea"
>
>> +esté actualizada con las ultimas modificaciones. Si lo que lee en una
> "últimas"
>
>> +Una traducción no es una * bifurcación * de la documentación oficial, por
> I am not sure if the spaces are needed.
>
>> +ejemplo, nuevas traducciones, actualizaciones, correcciones).
> "...", "etc." or "o"/"y" before  "correcciones"?
>
>> +Las traducciones tratan de ser lo más precisas posible pero no es posible
>> +convertir directamente un idioma a otro. Cada idioma tiene su propia
>> +gramática, y una cultura tras ella, por lo tanto, la traducción de una
>> +oración al inglés se podría modificar para adaptarlo al español. Por esta
> "adaptarla"? (if you are referring to "la traducción" or "una oración")
>
>> +la forma, pero todavía transmiten el mensaje original. A pesar de la gran
>> +difusión del inglés en el idioma hablado, cuando sea posible, expresiones
>> +en inglés serán reemplazadas por las palabras correspondientes en español.
> I think the sentence wants to say it is common (in the community?) to
> use English, but terms will be translated where possible. However, I
> am not sure what "en el idioma hablado" means here.
>
> Also, was this based on the English version or another translation?
> i.e. this sentence does not seem to be in the English one.
Yep, I took this from the Italian translation. They added:

"Nonostante la grande diffusione di inglesismi nella lingua parlata, quando
possibile, questi verranno sostituiti dalle corrispettive parole italiane"

which in English is (more less):

"Despite the popularity of English language in our field, use the
corresponding term in Italian when possible."

I believe the idea is that, even though we inherited English terms, like
"bug", we should try to translate as much as possible and don't fall into
what people sometimes refer to "Spanenglish", mixing both languages.
>
>> +sientan mas cómodos. En principio, estas pequeñas diferencias no deberían
> "más"
>
>> +La documentación del kernel de Linux
>> +====================================
> I think without the last "de" would be more precise, but I have heard
> it this way too.
>
>> +bienvenidas; de modo que, si desea ayudar, únase a la lista de correo de
>> +linux-doc en vger.kernel.org.
> Ditto.
Thanks for your feedback, Miguel. I will wait to see if John has anything
to add before I share updated patches.
>
> Cheers,
> Miguel

Best regards,

Carlos

