Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A3721489
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjFDECp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDECm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:02:42 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2117.outbound.protection.outlook.com [40.107.105.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07BD2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 21:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBKrgnZ/iDjMqDjPK0P1ZdF5zKVaPmeHpGogztOFgAqWBlX3+dMkm4s92FPAQJAJJ+5E3qhCxTKfL9+bATTc0FTx4dhl9DImjPTChIM0hYfLGgy1jON5jcmHx5+Ak8H9viXTJNGyL16WK1ikrFwHSCOwIjY62z8N456BrumK1MWAKR+sBCs5Cfp+5zj1mfAAau4j2rnIQrOoLHIKav4lpwkdK9j+TZsya/dovITPWK5Ac5jmNtvPd9SwSt4NyRq44rJtGREtxl+9IeY1VBtQu38NBgDYgPTFe9bqCGKx8UpLASk8kY1FDg9JHshD2hrFyeQ//CX/mWzfXFLHKT7Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJBiBBCdPAwLFgSBJeOVEphju8BCbjOyRBLys3m1Xno=;
 b=ANBdBKoelp1lIt/ShYKOUs0WiVpmD1/n2tvDH3t1w0xejb0zVEhwAWrALxGY+/oXrJtpyhWxxKcKPejFZwqhKhkhwUOCp30hrJiW4zUdTj4UpabryKB0mSCfopovVnIck1ldqW7ZKWgaUYPD9I6tstxvX9bmq8JQ7rTqk2kZaIJhzhjwabHdzpSpCAHCS+06rc0m9Rpjhm620qD/Vu9iAzTRNb786olgOFHmogrs90OlrHP/mpQJITG2Fd9lHw68zoNPRE3cxU7CzQRNFmiiBpsaYRgNlA6uorbBZOyU4HFl5/UZY2+zTmhKYA+LQDx6JljWs26djbM1W+pAw0I0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mbosol.com; dmarc=pass action=none header.from=mbosol.com;
 dkim=pass header.d=mbosol.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mbosol.com;
Received: from DB8P192MB0533.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:16b::17)
 by PAXP192MB1200.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 04:02:36 +0000
Received: from DB8P192MB0533.EURP192.PROD.OUTLOOK.COM
 ([fe80::1be:b35d:c2cd:9c89]) by DB8P192MB0533.EURP192.PROD.OUTLOOK.COM
 ([fe80::1be:b35d:c2cd:9c89%4]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 04:02:36 +0000
Message-ID: <b9cef72f-0bcf-5bd6-e828-f11bd822fe33@mbosol.com>
Date:   Sun, 4 Jun 2023 07:02:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch 5/6] x86/smp: Split sending INIT IPI out into a helper
 function
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.889612295@linutronix.de>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@mbosol.com>
In-Reply-To: <20230603200459.889612295@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0246.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::22) To DB8P192MB0533.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:16b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P192MB0533:EE_|PAXP192MB1200:EE_
X-MS-Office365-Filtering-Correlation-Id: f2553e03-57db-49d9-4576-08db64b087e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bmxu7CxFJrTPTv1PGzVCeYlnXEdEs6UlrKQW55+kPjZcCE5akrkhf5FbFaS3PX09muO3gvnyJOjWK5ZU2T9m645ZYarmlI4/Vu/aDs/pFXl2xJgRBRCtcC/DN/SlD3i51/EiXoAv8SjqZMfsSiba9lT+p8Rw3HXRobJ9zgf+zQPLAf2mQ8PP+Upb8DXlilYcL5bpnnr1k3q05irF6i5RsDBgqd61JCA4jPMObRt0+bdRCqoSdPZ1dZhxMleWQBHQtrviIe/5EewtDar6gesz6tcukwR1RLPqQgfarWjGkMPh5M/1EW7rcX9z35pbzjYhElXfpv6nYLQOaPfzf8gb5kEesQOnPwXViKOqoV7VXFcHjlunC6svyJTfYd5pqviUqh1vaYYR1YPdLgHfLcWfCDpiWCFbIdi7LD4eudI7NTYnhkWRTU41V7KuOrWGQjWPT4t3tltOcZZ+amQkZGDIo0yszJLsSzZLZivqfQTMOZrct/U08E0bLOTaqZ7dcV47KzQK3RlKZjuEr8oGMwK/WAbsbnlEAIkYFqp9/N76P/lJnouD9CRJuHZe0apGOLQimFaaV+5PKxxYgo3ulnXLLPBfTILpl6CilPXBmMmBxPMyjw8xx5fgzKwQu/YfscQoqzofNhPBO32GjzxKziUpRBrkFgWqIfdgs2LeCMsdmcO63WP9Skz60rqWr5cHMKGe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P192MB0533.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(376002)(396003)(136003)(346002)(451199021)(83380400001)(316002)(31686004)(31696002)(36756003)(6666004)(478600001)(41300700001)(26005)(6512007)(6506007)(66946007)(66476007)(66556008)(186003)(4326008)(2616005)(38350700002)(86362001)(38100700002)(54906003)(110136005)(2906002)(52116002)(6486002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVxVnYrUmlzQWt6NXVaMHRUWVlvUmJvcjZsdW42cWI0MG9CZkE2bzdwdGVV?=
 =?utf-8?B?K2llU3phNVFVTDJmQTF3d3c2Ymk1L2VoYjlJSHhNaTE5d2tzUWExWDliNDZX?=
 =?utf-8?B?WDdObkpNbys0d2lLQUd1RFNHTkZHM2FUdHJSRTB4bktYUU92WDVIcHdXR3BJ?=
 =?utf-8?B?bjR4TkFGNkZHbDdhQXgvcmlZTzM4alg1ZWF4MGNMeXhKYnBOQkJGVS94alps?=
 =?utf-8?B?Z3FKemk5N28vNmhnN1ZheHc3VXpKV1VaTzRRV2hyMGltcGVFWUwvUmpVS0RL?=
 =?utf-8?B?L3h4dDhYQkFrV3Q3MVhqWVdSTFJVVkNQYlRsNi85czBQa2ZGVzFhb1ZmY2F6?=
 =?utf-8?B?SW5CU05CRUhRK2tOSk5LODJrN1ZIT0ZWS1daanlOYWVCTi9tRVllWDQvS0k0?=
 =?utf-8?B?c25rZkpNbC8xMjNlMUp0UUN6dmVCbGwvNGdrcTNqWlJDL0EzMDF4ZkdZbUxo?=
 =?utf-8?B?MUlwTUVmbGZpdUJtS0tUQUxaTUZlSmVGNWV2NHowS3F0OEtBT0kxSFg5eSta?=
 =?utf-8?B?eUVvQkIrTFdIekY0aVR2N3BBbmZmUDdxbVhvVndjSVRmZEYwMWFiMmhBNVla?=
 =?utf-8?B?VFNwUVV3c0pyQXJ3Uld5YlhscThtZHA2VUpObnEyR1BxTm9IVld1eXFEcUlj?=
 =?utf-8?B?cTBRVlBBNktSaDFqcVMwS2lCZkplR3REYkNCbG1GMWhxM3NlREdNYVNwaTJY?=
 =?utf-8?B?OVgrUm1EN3JlWHRQUURaZ1lJS2dPSjROVEpJMzljUGFmV0RZWG8wdXJ0TU45?=
 =?utf-8?B?YWp5SjZjbEpWZldQR05jU2ZsYURTYzZmeG9ERVdmM2hGS0NNME16azJwTzVz?=
 =?utf-8?B?YjJEVDZOMFNYdTVCb1JrQnZ5bzdVUFRPTFBPNVZmaUJwVENKc2hQcGo3b09K?=
 =?utf-8?B?L2JzMElSVnp4OVhDTU9iRXlRUUNUYXpudVFYOEN2TWUwOUJtQlNkKzJwZHp0?=
 =?utf-8?B?dXpZYWkzRmx3d2VUMmtUTnJMMjZXZFh5dXlHVVVTM2tkUUJSRm5mQUZjZmxz?=
 =?utf-8?B?ZnJxeXh4SUs2ZWUwYVRObFdYOS9WSk11Z1pVc29jcWtxWjd4L09MOVB4L21s?=
 =?utf-8?B?STM4SGxndENQMHRlZjhweC8ySnZmT3BPTmdod2F0bGIySFRBazd4c2dXRnVY?=
 =?utf-8?B?bC9Zb3M3aEtIdGM4RHJNZkcxeEljMnRLcEtnRTk2cTh0cDlveEdMTGhMZHYz?=
 =?utf-8?B?R0VmYTJ1Y1U5YTU5VTZOSC83ZnJ6enNCQlo1M2N5WEF5WjYrRlNGa0l2dHh1?=
 =?utf-8?B?MVl0UU9ZY3hXRURMNDQyeUo5YzU2WmJVU0RLakM5ZGswSDk5NkVzZExOOTMz?=
 =?utf-8?B?ZnNQLzB0NHR0NmZ2Wm1wSU1xTElrTUh1NVNOZndxRUgyL2U2VFRXUGIvS2Fu?=
 =?utf-8?B?UGh3NHhHUnE4TGlLWDErZUlzVVZHUDFkVWhyQnRyUE52cTU3cmFvYnU5ekFv?=
 =?utf-8?B?b0lVbFEzZ1VLK3BGa1dLeTlDWldwbUducmp2eWtrdThFRlBrU1FoL09TWFZF?=
 =?utf-8?B?Y21VQXFndjQxM1BsM0VwN3AzYUdZcnRFL2cvUHJzQXJrUEtRejYzS3JaTGRh?=
 =?utf-8?B?NUdKbW5la0JpcUFKT1JHT2hLN0lBQVd5VlllTXlXSVFTaS9mMjZZQVpUMGFS?=
 =?utf-8?B?a0tScEFPWnlIMkhGWGJZVmt0Nk9XSkVsQnFMMUpqdVRxYnFiWTdpcEFBREhw?=
 =?utf-8?B?bk9ZS3laT1JMYS9Qc2JCMXhDcjFPMnZyTTIzMjY1UTRyUG91SUVENnZuc1ho?=
 =?utf-8?B?RjRXcXNyQTBJUUlmT29DRFpyamFBUjRXMWJiSGZyL1d0MDdmOEVxVzViYjBu?=
 =?utf-8?B?YXN4N1JFU2F5RjJjOTJGTmNHRnRhV0ExQXV0eWhNaDlFNzhvNU1MZjdNT2lB?=
 =?utf-8?B?SmtxSWxzMlNZSDJYTlRXWmFmYXZ4eDNobUJXRHMwdGRqNmJtTGg0QWIyaGVK?=
 =?utf-8?B?UGV4ZU0yTU90dStmN3k5OTE5TFMwZ20yc2V0TVBnK0JUNUhBTWVQVXQyK3JH?=
 =?utf-8?B?OHpjTFhOaUIwQjREdHhkMWZYbVJuUm5JbGRQdzJqWmtjUm1rcWo0TldqYmhP?=
 =?utf-8?B?WEJnMnNHMzA1SVBuWWZzbXpqR3dKZ0xIdGlyN2Q1Ky9BT2h1YWkvbHFyWjdz?=
 =?utf-8?B?VWJwUUoyT1ZpU0lyQnJDY3AxK3dDM2UyNjFON0JYdXcyU0k0c3Nackxhd2VD?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: mbosol.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2553e03-57db-49d9-4576-08db64b087e3
X-MS-Exchange-CrossTenant-AuthSource: DB8P192MB0533.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 04:02:36.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 571b6760-44e0-4aae-b783-84984ac780c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9X/pwm3oyb5ZzBIoankfR7/ontJWNzf/l4+0yBO9gddlC8PnNclG4KDZfgCa9YV13DkMLGnbHhAQWMKoV/NMikhU2JgoJzQzbwupkuQ8enA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3.6.2023 23.07, Thomas Gleixner wrote:
> Putting CPUs into INIT is a safer place during kexec() to park CPUs.
> 
> Split the INIT assert/deassert sequence out so it can be reused.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/smpboot.c |   51 +++++++++++++++++++---------------------------
>   1 file changed, 22 insertions(+), 29 deletions(-)
> 
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -853,47 +853,40 @@ wakeup_secondary_cpu_via_nmi(int apicid,
>   	return (send_status | accept_status);
>   }
>   
> -static int
> -wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
> +static void send_init_sequence(int phys_apicid)
>   {
> -	unsigned long send_status = 0, accept_status = 0;
> -	int maxlvt, num_starts, j;
> -
> -	maxlvt = lapic_get_maxlvt();
> +	int maxlvt = lapic_get_maxlvt();
>   
> -	/*
> -	 * Be paranoid about clearing APIC errors.
> -	 */
> +	/* Be paranoid about clearing APIC errors. */
>   	if (APIC_INTEGRATED(boot_cpu_apic_version)) {
> -		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP.  */
> +		/* Due to the Pentium erratum 3AP.  */
> +		if (maxlvt > 3)
>   			apic_write(APIC_ESR, 0);
>   		apic_read(APIC_ESR);
>   	}
>   
> -	pr_debug("Asserting INIT\n");
> -
> -	/*
> -	 * Turn INIT on target chip
> -	 */
> -	/*
> -	 * Send IPI
> -	 */
> -	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT,
> -		       phys_apicid);
> -
> -	pr_debug("Waiting for send to finish...\n");
> -	send_status = safe_apic_wait_icr_idle();
> +	/* Assert INIT on the target CPU */
> +	apic_icr_write(APIC_INT_LEVELTRIG | APIC_INT_ASSERT | APIC_DM_INIT, phys_apicid);
> +	safe_apic_wait_icr_idle();
>   
>   	udelay(init_udelay);
>   
> -	pr_debug("Deasserting INIT\n");
> -
> -	/* Target chip */
> -	/* Send IPI */
> +	/* Deassert INIT on the target CPU */
>   	apic_icr_write(APIC_INT_LEVELTRIG | APIC_DM_INIT, phys_apicid);
> +	safe_apic_wait_icr_idle();
> +}
> +
> +/*
> + * Wake up AP by INIT, INIT, STARTUP sequence.
> + */
> +static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
> +{
> +	unsigned long send_status = 0, accept_status = 0;
> +	int maxlvt, num_starts, j;
> +
> +	preempt_disable();

This seems like an unbalanced preempt disable..

>   
> -	pr_debug("Waiting for send to finish...\n");
> -	send_status = safe_apic_wait_icr_idle();
> +	send_init_sequence(phys_apicid);
>   
>   	mb();
>   
> 


--Mika
