Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044B263AB28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiK1OiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiK1OiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:38:16 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F250720F49
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNdplfaoxoFSWTGJLqJmSLEw+7gaGTTM4lUkQ2FMw4EpsM1Q9Qjoe+UPxSFved9wM/Ue2MaK/1tjMES6vkSiQEIqwAzL+4hjzGufXJ+VaBnH2lUgldkuTd2F6wSLnUm9dVC2Ta/TtcKO3VBVgnDe6McW5XIWbwi5BZnI2JgpueyNduwk2CPpE7VZGif4cVUZSLojgNFwRJIgJ0xeeDnH9h6tvpna+f7qHsOJGhGKxILOk7G/eWuXf1sHnUnyttfkT9j2ybozwteRBLF/yIa7e5NsQsUuQtud5IsAy4gdoNTSeXCh4srH82J5RCxi/XZCILF8OLhz8Emxo/CAVyBstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfOUms/FXcu+Pe1Fg03tx6JR4AEllCzz9EzKmjhKPQQ=;
 b=HSgQSM9TRyi2jWJaidvUcMiJrdB32c86FeEV1mfmpqxgM3sfurtvaapNrOps+33H24liRIyP5B+P3PY0IcvvGW12tDyYqqoZRmWrOascFtdkEpVu/ve/d2B7ODcvT2+WZ1Grh3Yn+xG5BTz1nHOHoy7dPqc6blRIibSmJ0aoV2AgdJe6pnxuwiiO44T6QftWytA9Yh+e2U5TQiKKZq0EJpXGNibxS8NPYLN8U2b2kL1xLSFLWkNk1EkP+YFMbY5ktPbFZtpD5Ai54QuXkrDizVkdhOIIYkJLNc4cpZIKnPItcAOy4kXTGq26IVGn8+Aphfr+N7+NbhYkrvRcfjsEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfOUms/FXcu+Pe1Fg03tx6JR4AEllCzz9EzKmjhKPQQ=;
 b=AWhFdpcBx3TEYyqFiLBodMdNLooVgVJ0HijInLU8IND9rJExMnH811RRUcmoH2Ij9y29MRDRAmbbegwtG4qb5sNR9q1CuV8Lx92gIyStwtd/xWBcBpgn8b2TrGnO3+R/Yb//kGvJERKObKOl3ruYI5qjAUuHidpCYXEaxxRCDVUpGP2+6BbgZMMDSfGhXuppDhQr4vSm5p8OfbavAHygnomHHHta+q4YAPLK2rp2rwk0lrZdxLAKHTKuFG0lcVabaQ/G7ttdhC2wE344HFKjy5WPF6zX0hAbYAPo/6zstBwsNrxabx4WLwcuSegbWV4ICLjfEx8wE3me/kkH1R7JJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PAXPR04MB9218.eurprd04.prod.outlook.com
 (2603:10a6:102:221::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 14:38:11 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 14:38:11 +0000
Message-ID: <16941b45-0f4f-e7c9-4602-d9acb0c612c3@suse.com>
Date:   Mon, 28 Nov 2022 15:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y4EWqbCTBYEF8LOf@zn.tnic>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y4EWqbCTBYEF8LOf@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: a64eab3d-98b8-4413-c853-08dad14e2c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKRX4MKcXP3vw2kG4gJ6XT1HDs1g1e0fSsgri6HPhsJU2bsnb/bQK+bo2EMZ2uFO+Tpj9h6IsgZqBXqA70NN9MqEqkqYPhkK33mBMQuUkfXgPM8zYZm2mr4bFLLy9BhUcaeTxIiBpaNhI2HEr6acQ7lkLfEHMPKNGHFfA59m5IzBFvvkh0C/mRk5dotl1iX5PFDsAWqVSr8VsJZhC9p/aXJZRu7st1LmPkUacQuP3/lfSpJgOtK0hVNQisjEae0WzldttK5cGEXppOidmVWRBPrz+lhrQmNa+pELtpjJ1UqaOJ4ZLCp7JCSAPySWKd4sxOExEJ9VampHyO+ygqCxyyy6mVYIfYsRoRM31DPzxK1233eIndktnSXsdbiZkjZWWv3ji0UIuO0Uv/6MITj1srCsG4ZI7KnqSMJAXCw+GTZ9crAOWwlBVKLcVpc/uUViQdTbr+Xl1dfZhiJilPxlLxnZ9RK1WZ10IImGZrpBiEBSJRw/wFhALDXoyJDOyirzC9kTWLFrvjBlO6Jy8v4eFF+MDOIqosXh3rKcfS2MMaUMD9f6amB7o5L4J+VUtKIjDhKwIeZ0LOnQcrPmPY5KAhIcZCzqJxamgvJs4lc05lpjJG50U2v+TpBeg0Osu7OTgPWLN6GPM8Vx2iVAXePJJl1P90XRVAP8TLRnicvGT4BkisjhX8LbNOVUdTkCjzGq2BW54avaOcnVanDQUrXv6HxCn+xNHnBoizN4u7B0LwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(4326008)(6666004)(8676002)(7416002)(6506007)(66476007)(66556008)(44832011)(31696002)(66946007)(86362001)(2616005)(6916009)(55236004)(41300700001)(38100700002)(53546011)(8936002)(5660300002)(26005)(36756003)(316002)(186003)(6512007)(31686004)(83380400001)(2906002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUp2TEpvNmhGVUpNZmpWc0ZPcWk0RW0yaldBbnVRRW1vNkZhdUlJMFhOUEly?=
 =?utf-8?B?OE1TcFFDRDBuTXoxb0JMeXoyZTE4YjdFTXVvVkF2SXRQZnMwSlVCSUp4cVRF?=
 =?utf-8?B?c1dsYWJzeWZsMGEwOEdocnVHOFNBQ2JycVBOUk5hZVRzSjRhMDNmZzAyREIx?=
 =?utf-8?B?TDYyU1BsOVFZMkYzcmRlc0prUTk1T3VtWGFCSTVLQTdkbjBNNVczSk8vVGZr?=
 =?utf-8?B?TkIyTWZUK2t5ZEZxWHNkbDB6WEdPTWtaaWF0YUgrMkJSbCtUTFkyeStDQ3FG?=
 =?utf-8?B?Y2w3YStsSldUVi9kaDl4cC9GZWJWZ2UxM2NaT0VSbEU1R0NFbkx1dDJrcy9x?=
 =?utf-8?B?dTlzemJuNkZIdUc3RllCRTJIQkZDYTA1VmkzNjg2aWlGQTdzUnFlNWtBTHhJ?=
 =?utf-8?B?dGtXNlphMm1VV3RCOTRKSjIrUkpnOWhnbGRXUVVuVW15YWVKVS95U1hMTFpD?=
 =?utf-8?B?NTFxY3A5Tms5MzQ4VUlMUVRtbHNFaHNoMXRORVdkZUN0VUl4Qy85QStNZU9o?=
 =?utf-8?B?V1dPUDNwc2p1V0hFbFFlTGRzaENWN1hiY2lJOEVPUGdCU1BaNEM3Z0IvRDRs?=
 =?utf-8?B?M0gzbGRZV1o3c1YvWENNcDkwSGlqT1Z4Yk5FQ0NBeTB0bE1RVXZUblJEcHFo?=
 =?utf-8?B?MExHNTNLbnBvTzNlZGl0cXNGWVF2T0ZsMThMRTdjTytzZU93SHpvczR1anFM?=
 =?utf-8?B?T3pyT3VaUXlwTU4wSTNqUFJ1dG1hMnliZ1Q0c3d4QVZPRTF5QTQyZEUzcmtJ?=
 =?utf-8?B?cmdDR2w5LzBkYytSRURyUDVOK1lyQVNXT3FNdmdKU25XUmJ3SVZHNzZXSHFM?=
 =?utf-8?B?ZHNDaFZ6Q3NTSUN0bEdUZGFwQUFFeTM5ZHQyOFdEU1NUcXF1R2k3YTZqRlpU?=
 =?utf-8?B?N3RTZGJlYjZMNDhLVnd5R25RdmxBd1Y0ZFdTb0E0bHc4QXJaNXpXK3AyUEQ0?=
 =?utf-8?B?TXk0cVNoVndaQWRHRXM4SnVaY24xK0lGK0ZiVWNQL29QdU1BQTFPTW5FOXNR?=
 =?utf-8?B?NGtTaml0c0xya05LUXNIamJ3MFQ0OGR4ZE1zWkVXOEdZcTJCMTdtbjI4ZkV4?=
 =?utf-8?B?djRVR0ZneGtlRkMxTDYxa2xjcGN5cjg4WHVyd1ExWXRnanNieVU3bUlFalZh?=
 =?utf-8?B?ajlqaGYxbFdzT1E1b0NhVDJvczhaSHlWcGkyaWNKZGJBVjI5OExYT3JXdVh2?=
 =?utf-8?B?SzhNWktvdGd2UjVmMDNiWGk2anB6WW5yTERjOVBDaVpoakl0T20yN0cvaWpF?=
 =?utf-8?B?N2lwVmZmeStsL3FHdzdyeEZKTGdhQnhYSlNKenFzTEw2UWdGcE9KNzdRYXR2?=
 =?utf-8?B?UFlNclUvTnpOR1FaWlRFcEc2RFg1WEZOQVE4Tm0xaUp1cmxNUWp0Y200RnZO?=
 =?utf-8?B?L1drUStpZlo1eENZdEZ6b201UVlrbUdBNmJodDZqWWEvcjA4QUdGRTZrYTg5?=
 =?utf-8?B?bDFIVFl0bWtPUjkxb3BMVDNwZThjNEZoWGxZZlJvNUJjeXhuK0dzRk1aM3ds?=
 =?utf-8?B?K1FsQU5uYXgzb1ZMWDJHUHUrSjArM2VsNU53MDJUMldLbHF3NnlwdUMwT0Np?=
 =?utf-8?B?b2hiQUdTZ0gveXR4OHhGb3pFOFdSdDlYRXhDbzhwTzlhOUh3dklySU1SeXVS?=
 =?utf-8?B?RnplcEcvc0pCRVNIbTVrWG1SVWx0S2hwREVmQUY0TG1kc085WllEQWE5S0Jm?=
 =?utf-8?B?cmZLOWlJcUlRZzgyOEZVNGpLMWVWTGIzVHRxaHVsd0dSbUNNdE5TTFhQVUJF?=
 =?utf-8?B?MFNsbXEveG94WVErVmtHZ2VuaUhnS1VIeGVTNkFsU3l3V0N0eU9IMHFTMXox?=
 =?utf-8?B?cktJN1Bwdy80VkduSFozNVpTQVpwZkx4UWhlQkVyNzhKeWFSWWNCL2tOL0xn?=
 =?utf-8?B?U3BGN2ZXdThRMFdMVzdIdndkWW9NaVdxUEdSNmxtMEU1bDRGYkgrb1oxTllQ?=
 =?utf-8?B?S094LzdCamFSbDlrVEM1Q1QzVFIwRlcxWUNaTkdGZnU1M1pvZkhXakc4aXpK?=
 =?utf-8?B?N3B5bjRpWmlmd0FtVUVyU3d6UCtLcXJzMkJrUkpZajIrR0VHMVVrVHBUNHZx?=
 =?utf-8?B?NTMwRDM0ZnFFRDQwMFUwa0lQQlBrV3R5QnorMjJtT205RHBLNUN5QWFPRGFQ?=
 =?utf-8?Q?hX4sIrWafaopi3IV8IBhQvPc5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64eab3d-98b8-4413-c853-08dad14e2c49
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:38:11.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN23A9/wNFXuBIXOImkgYXw/00sKkFEZbUKIU0eUBzZyEUUpcvFW5ElLvsHB2ru/dMl5JPLgfLTXawLcJT7YQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/22 20:25, Borislav Petkov wrote:
> On Tue, Sep 27, 2022 at 10:46:32AM +0200, Petr Pavlu wrote:
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index 35ce1a64068b..eba7709d75ae 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -120,14 +120,12 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>>  
>>  targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
>>  
>> -CMD_RELOCS = arch/x86/tools/relocs
>> -quiet_cmd_relocs = RELOCS  $@
>> -      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
>> -$(obj)/vmlinux.relocs: vmlinux FORCE
>> -	$(call if_changed,relocs)
>> +# vmlinux.relocs is created by the vmlinux postlink step.
>> +vmlinux.relocs: vmlinux
>> +	@true
>>  
>>  vmlinux.bin.all-y := $(obj)/vmlinux.bin
>> -vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
>> +vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += vmlinux.relocs
> 
> Any particular reason why vmlinux.relocs must move out of $(obj)/ where
> it resides now?

It looked slightly cleaner to me that Makefile.postlink generates
vmlinux.relocs at the same directory level where it is executed instead of
stuffing the file into arch/x86/boot/compressed. Makefile.postlink is invoked
in the context where it has no $(obj) variable set and has no immediate
knowledge about arch/x86/boot/compressed. It would also require that
Makefile.postlink makes first sure that this directory exists in the target
build tree as this step is run prior to arch/x86/boot/compressed/Makefile.

Let me know if this move of vmlinux.relocs is ok or if it would be preferred
to preserve its location.

With the move, the patch should be however at least updated to remove
vmlinux.relocs from arch/x86/boot/compressed/.gitignore, which I missed.

Thanks,
Petr
