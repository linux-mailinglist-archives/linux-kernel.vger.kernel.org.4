Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88856BCD15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCPKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCPKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:45:54 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456E4222EE;
        Thu, 16 Mar 2023 03:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrXTYHIW54hz+1mts7Y1yUZcNtHsJS0lO6O3nhA4sUg/LY01l6WLq0QtwNlyCoPoqwAYqmGMLhwWRw2Z/b4jAdueTOlpJyVAKWuZgfYzCETzxjTEylNtCTSor2s5UGY2NWXSuDdo2TGdGGGfrftSHhjrZhg7RQ//jo9Dxkkee/GPnZJETFiRzQgcaMABAhFre0lvedwHB+QXPyWZLpDHBXJ8GaftFT1m0Z+cg56e4iWwnDLq+FaudIomlUnsW/L+XWDfoCe1YCA0lOjuzkaPKWb/PSoF8xCiKlNiIqNoWonqmb6d72UPZf85yoRAJgPpiSfpp6wWrkOFHC+OGaBxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWyQHfB+TJ0P8zlOXRcmeCpSd9fkh2aCQWaY9+tDynM=;
 b=Uynt+tvxhZvvFq4DTamxzsTHotXQW92Y5AO7V5Cz0Y/vhdNduPqJJwA+RXAjmQmxV15eP5vP/zJlxtqcks7xgwtDiHYW/P+aGgFcMqpTSSi1vO9Se/WcWdXIdB+tvLITJw/9iS60JDXE9b42r52ucUsqXsfk4sp5aynPDdphz8KT4aFo1xy6nWchSslw9JNVEL8b0iZyZjp/2WwQcEF0QqF0ytXabTwcSgturslgynzMfx3ChCzfqUuX5iZcHpifMi6Ni601Mr7ZHh8UMyM3LL7VW6VhLxxGmsoq3ILM66bRHmeWkMJCCAB9bzZZE9P7GrDfu1slw/4StolALjSIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWyQHfB+TJ0P8zlOXRcmeCpSd9fkh2aCQWaY9+tDynM=;
 b=skB1NbA6urfilLlhNWUNYH8+rWAEbVyjMp2yw2EvPvd0mXiqhXnYeDXtYzVhosGFLiajJc2HRLo7zHXgbbSRwqfYRjg+nTdIM0Etj1hFB1iLP6lugMLxD98UmvtT3tuVmlirpHlNISA8ijCNyU4ASHdU+RqFbgvPYSPQdNJw1ac/ZOtWhuSZKX6/ANyaQd2kZvMc2/j7H4+apMhcsyByJw6HxOGEufWqHF2LlHgKi6qXZiz4LW5O1d0flyNietvzTbliYVLJgHAcZz8Fm4F5zVnrOF5YHFhAMOfrxMBvj/ibCZ3OSfp8v/Zsz5z4Ftd8NfGQB5VTjDB3mYr+a2mfuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 10:45:50 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::154e:166d:ec25:531b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::154e:166d:ec25:531b%5]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 10:45:50 +0000
Message-ID: <ba2d10ed-a1c0-2f35-3ffc-13637c83ed93@suse.com>
Date:   Thu, 16 Mar 2023 11:45:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, josef@oderland.se,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316103236.37102-1-roger.pau@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20230316103236.37102-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: b29bfa12-9dc6-49f8-22b7-08db260b9b9b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LZBbxOiQr+QfOY5d+hUcIFdtxYiHX0kPjRObAQsHbHowH2h8pM7fdbZa5lJyIo/BdlKdGpY5nM7hgo9OOYNZM54dSPeY9+8UdE9uDUdSB5ZVqe+Edazy6tXd55ZHXB2/t58JjPwNf0BUrMSa9GvMRetKucIg6JajFUTXvd++DuFucT1SDsD2+M6vACFPv2gmLVroFN8UwpnQ7UBdRzy5fa2uirxspb8zz0mPdkPb/XNJ/BZwt+y+bvTxT3otX5vsPFiM8BapocMAbKK/S4fQol3IxxFHwp6bbz4/Tu4lzvSXjul1w4zr9uvj4QcSkITwPiXHPeoQWkZ2n13TYWiBdHTGLJtnSvKoE9OO0kBadj9TfN9ga8rp5B9ScL4SfAvsl5JYBCl5fG/Dv0+Hwefc/gj07SZuBD7sanE1PXqdIcs+sCS/mDt8pmQefKhNPR12ULTSaq9TWr7XtvBnCE9uKA911ALWaGYzvUs0NeHhJ7F1RWg5SwHMuVS8etkFPKBJYstHTmIUaaM7qa9Ts9NaH5NQXixSlBy/+KFaK6f1GJVQebR4h/8EOA9vpwQuCuqgKm+DAQYIqyySCgFt0fXAHKpcblWZhXAJrhlaychLDIqf8Bv45HiHz+LDPfDLPI5TFan/GLix9MKEYjk86hsG3YtIIzRwV9ifczGnn36Xal4fAOk/bOpTAlc5vZKzfo0omZGomtbuTFALoRIIwaKZUriHlrG4iwPn7ghJRB7svs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199018)(31686004)(36756003)(5660300002)(41300700001)(7416002)(8936002)(2906002)(31696002)(38100700002)(86362001)(478600001)(66556008)(6486002)(66476007)(6916009)(8676002)(66946007)(4326008)(6506007)(6666004)(2616005)(54906003)(316002)(83380400001)(186003)(6512007)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG81N2xUdU1ibTRpZU1qM0crNUdWSGwrSnhSTlhsM3ZzMERHdERCN0N1YllT?=
 =?utf-8?B?TXJRTzVNd2hTSGx5U1pBcWVaM3FxZjBPbTBlbUFHMGtGTS9Pa3hUUTNTQkd3?=
 =?utf-8?B?WFltVXpCU2hiaEZER2dYSVhOU3Z2RkR0ME05cDQvaWh6QVM0LzRlMFBtNm9D?=
 =?utf-8?B?dlZDbkRpaUxvdUUya1NWQ3hNbU84QUpZdko4R0VTWENreUFBMmpDeGdkMVFj?=
 =?utf-8?B?dmk5cDVzcVZ3b3JZMVl3TWhnMUEyQXVlV0VPWTJUSGVHbUdWL1ZNSjRadDQ5?=
 =?utf-8?B?NS9tOEszQjRRaGpSWWxGVHF6VTFrbklJTWpTT0QwYWE4RWdUUnZ1SUh1cnRS?=
 =?utf-8?B?YlRQRndVeVpGazZCbVNsMlJwRTNZTkZrTWJHSzZiSE1PZGM2aHFJSEh3SkJS?=
 =?utf-8?B?bjRkcFpGbmZKNWdEVHFXSU1NVitXUHdqTExPMzU5RXhhN015ZGgyUzlZUzF3?=
 =?utf-8?B?TmhBR0RScmFDdXA1ejdUYkF5dUs2TzdTeFozRjlXdXVVV21SY0pON05CbVEr?=
 =?utf-8?B?SGF0c0VNTEdtSjdpVDR5SjdUZHFoLytBb2dTbGhHLzh5YjEwUkVQaWhUWGor?=
 =?utf-8?B?UXlYZVQrWUh4TkNGcDRxamlkSUQweTQvTlZSb3gyVWplRElhbEFiT2ZLUzVz?=
 =?utf-8?B?R0dqWGxSZUlVWDM5WmRsKzhDNXRGZUIwNUZyZFdBNGN5YlFuRHFsVUNkMzNO?=
 =?utf-8?B?NTlITmlzRHJmZkpqc3pESDl3cXhQenpVLzVSaldCOUR5ZGszRldZTEpRSjNJ?=
 =?utf-8?B?NWltYkNpYVJtT3VhVFdkc1cvOE5rV0RsbkM1ajN5UStNSnpWZVFkbVBkNlJz?=
 =?utf-8?B?dGdCVGNlV3BBMjM1UFVBV1hOVWdIVy9iRnlWano0eVlJOUpkWnBEK0g1SC83?=
 =?utf-8?B?UDRUR0hPVWh3SUduN3lzVFlJamJKMHJXeVpWckkyQlorNmo2QTRkOXRYVDhY?=
 =?utf-8?B?MzNDWHZkS1VLMUlMSmZmNXFXazhLNUh2NzYwRzJWK0ZGUlg3OVlvV2huMGNz?=
 =?utf-8?B?U29OMVdwbjJYd1ZPTjg1SEF2RW9ETUIvQ3pud25NalR2cE9FN3J2Tm5lcWRG?=
 =?utf-8?B?SStQZDgyRy9GdUdqcW1TRFo1OE43b0lhNVpmYjMxdDJqclA1TjQxWUMxaUM5?=
 =?utf-8?B?VU1uSG5FMkp0dTYyZ2xiaGk1MkRNNXQrVlp2YVRQb1UrVXdWUHpGc1FCUy81?=
 =?utf-8?B?c1U2UHFGWjI4bUozQzdhUVVIY1I3UzhmL2NrakNHN3VBRlhBWksvQ2V4c1Zh?=
 =?utf-8?B?QnhLNmRwa2Q5bUxLZnZSZmFBbWtKcjMyUVNIMkJmRnhrWkZiNE05UnVoZ0RE?=
 =?utf-8?B?bUxsN21oZlJBcVl1MzFqZTE1UzRpbUlTYnBqY0ZKQlpjeFpQTTJtU1NtMWNt?=
 =?utf-8?B?UmUxZzhxMzNINEkyYnE1RVBFbHRBR2o1WHVNSzBkTEc4a200eVBOdHFwUEJx?=
 =?utf-8?B?UTgvTUFEdExuTTA4YWswYTI0d1c3eWJsaUJPUytNMlJPb1ZGNFZzUjNWTlVq?=
 =?utf-8?B?aVNZQTZsd2l6MHd6K0Fkb3BKOHNZOThZZ2ducC90ZFlqem91RzBiUUZkY0Nk?=
 =?utf-8?B?eGlnelFlM1A1Qktpbng1RFB0UTMwNXpSdzNUaUpnWGxlcVY4dUg3NXQwa0hI?=
 =?utf-8?B?NTk2M01SaWlLdy85cFc1VlFZZHc1UUt4TVlKQzk0NE9qQ1ZiMll3VDRuUjVC?=
 =?utf-8?B?Q3hlNWZ2OTd2WHhvRFE1SDlCQ3dEYlUzenQzY3dFcVM5Nm1RdzlpL0NXSzBY?=
 =?utf-8?B?bENwc3pCOUNUYWNNVEtudU5uOUFDSlpHNFg5cVBSOU5TT21vQW0zTkxWZ3hQ?=
 =?utf-8?B?VXYzUEYxQkQzV1pCbXh5YmJ2NC9EcG5FSTExeHlzZGJMT2RLYUVhZUxvN3V5?=
 =?utf-8?B?TUdCSDFaejFzQjU3MXZDaWpqbGtCNW56aXc4WFBJV3RiOTNGZDVXMkxOdmxO?=
 =?utf-8?B?R2pjK3JGWnM0QmlFTWl6OFg0d29zTlQvSUQ0LytPTmJ1SFdnRExKVU1ET2Fx?=
 =?utf-8?B?VEp5cFltdXJObkFqUWNFNjJUSlhhUktEY2xrTzlyNW8yeEx5YzZsb1ZLUmR4?=
 =?utf-8?B?ZHBoTU5XYStPM29pRmE1a2Y3bmpVQVh5Yi8zTjhCZkhzeUlaSTlRNVd3UGYr?=
 =?utf-8?Q?tSxM73erhms2wSBcUDa/X8H4T?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29bfa12-9dc6-49f8-22b7-08db260b9b9b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 10:45:50.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgJQUDv24Mba58slTu27P+HLjvu8qOvnBQJHtbR7mvXxhVq1XlW6V8jLlOBKDgHdosLKjlmNVDX+TIMH+kQRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.2023 11:32, Roger Pau Monne wrote:
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
>  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
>  #endif
>  
> +#ifdef CONFIG_XEN_DOM0

Shouldn't you also check CONFIG_X86 here, seeing the condition for when
pcpu.c would be built? Additionally CONFIG_ACPI may want checking, which
- taken together - would amount to checking CONFIG_XEN_ACPI. (For which
in turn I find odd that it will also be engaged when !DOM0.)

> @@ -381,3 +383,20 @@ static int __init xen_pcpu_init(void)
>  	return ret;
>  }
>  arch_initcall(xen_pcpu_init);
> +
> +bool __init xen_processor_present(uint32_t acpi_id)
> +{
> +	struct pcpu *pcpu;
> +	bool online = false;
> +
> +	mutex_lock(&xen_pcpu_lock);
> +	list_for_each_entry(pcpu, &xen_pcpus, list)
> +		if (pcpu->acpi_id == acpi_id) {
> +			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
> +			break;
> +		}
> +
> +	mutex_unlock(&xen_pcpu_lock);
> +
> +	return online;
> +}

Since it is neither natural nor obvious that this function takes an
ACPI ID as input (could in particular also be an APIC ID), would that
perhaps better be expressed in its name?

Jan
