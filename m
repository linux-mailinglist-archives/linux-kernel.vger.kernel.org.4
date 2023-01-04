Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655F65DDA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbjADUYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbjADUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:24:35 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8833D66
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l591eWsR6WTfohEqpuPfQicyV6rkbWBZG7IXJlfYQ2nCiVbQsyzQkl6a+hHC67yFRS8btFp9t+jamAiwMGl1pWkpD9jPcKwZM+NC57e6LH7+HtplEXXlWDY7CPoQAOY8Ztb0B59DGiRcBoj7FKT5exRSygjWU3Yosg9+fnVv/9N0ouNicl1rb4Wr/IrEhjBxPM4IF3mafLx4q/odJGD1HDFbDDarGZasaSOpEN4HmQYOK9U9ctIxlzp+QWgn3UAp1Tb6nsrKjztqnKaZB9xbW/bJyJ27Sq8oG/BJavAwP0v6yBhaC01wWGU6Ci6QL+aLJQGWCWdcmO+fymTzRBDYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRwZtF+tC2PF4emeBcerHZHF+qZDPnhhvyEF+e/f28U=;
 b=VpX9SahFxGbcsvfPKOUCut0eqfDVhv9Hf2yzM2NE18SoR7LH1kwE7V0KJ819MCE2cKuvDde6CDioVEwghA1cOy/xfTga48iAc0XHOzHIeZUPkq0xI95RNmA0+frgJ6wx1Iuc/yi9emN1gpxI0AHYAyOHH9xaU+ep2Ojg2i81oZ/npL4AK3ghmLckQYrNJJVFiC4excvSXggwz6vU1L25/Xyc3htw29y8ZIcXtyxgwxIq/UnexX+L3dT7bLVq86uKmcmZw3Om0p/RzSfCUqPVi2+7i5cb1HbNg4rNEGZpUgZTtffecw/9oXieSbuSbgti42WVIls0B0AbgLomBgYRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRwZtF+tC2PF4emeBcerHZHF+qZDPnhhvyEF+e/f28U=;
 b=nkc8VzdVqdRlp/k0yQiUvM2y12WqxvTW2hM3LiTUaPODYA4oC1bgcifo6csYJytqqsnMZG1Jzw34x0/QbDKctTRd6QRRuvS6i8bEU+qRoj1oZRQ1DeAp2mqe5p9EOrtUibdSxhbfkVM+l+6UpNI4+j/ydXoveNvxbF0zaVTa7uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:24:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::41:6bae:382:4b1a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::41:6bae:382:4b1a%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 20:24:30 +0000
Date:   Wed, 4 Jan 2023 20:24:20 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fan Du <fan.du@intel.com>
Subject: Re: [PATCH] x86/mce: Mask out non-address bits from machine check
 bank
Message-ID: <Y7XgdFOEfHei9xEK@yaz-fattaah>
References: <20230103223416.310026-1-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103223416.310026-1-tony.luck@intel.com>
X-ClientProxiedBy: CH2PR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:610:55::39) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cecaf20-f3fe-46c8-cc3d-08daee91aee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgBSpfttBTlmSzGgvAKFPDkSC6GZ5YXGci8COvNI8KK8oFTmc1FMKOi6h3Z+9zZwqX7Y9QPYsXDBhvWvRvYbPQQy1PQ/KfUjSSeWAQ+6KZxb3ouSULoHil0QsKqhItV30bZKScGfzcWDywx27HhxAwCNcbU/35RQmUBUcW1a2zejdxZBbSxUSbMAkSm+bvOnZXqJuOMR4O0RZi2Kd7WOswTPkCb7efJ/zozzpBHWEWj3TfctdZlcyWd7kcqzilyInCy6qHuyafCYXT9hxlv9xludXJ+OZoBBGqR5UobgdiOSaCMsFmlTXPh9faeJ9LxMCBby1AfRuHK0pk46hhR17jRouO3iIrisytoDWwL6iML3WWofu3KSH4ZD666fSQh+EIxkgme7iJqudGEgPvjUDyBk0wBtsLrn+6329jJwxOz0f7U6RS46cPn7mBnYtaF7gVlHyWmvGfXO55oewhStcD4wbTpshkctnKoxmKEM6izAey7DvMGz7x5iFwn+q+NXP/aRrrmu9Qev2mhmUS5MUgMqmBhRHFWyUqrx5bRSPDjhpi5JKz8Bxq+Af1ZHoPs/qg40zaZet8LwRPi43UwUEvAOAr11F8wo7oq4pkyVd8Pt4DlkqJSSY3E2ex5t7gU6T6n8HhfHl7mjaLy1XPwFDpo7XLKzDIMwb2JzLPnM+ZhuvXLyd4szKGqYMO5H3eS2tudbM5akm7yLHk5ovCRpeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(6506007)(6666004)(478600001)(86362001)(33716001)(38100700002)(6512007)(9686003)(186003)(26005)(83380400001)(6486002)(5660300002)(44832011)(4326008)(66946007)(8676002)(66476007)(66556008)(8936002)(316002)(41300700001)(6916009)(15650500001)(2906002)(54906003)(171953004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRhjh0zlSBOYndH0vG2sXDHt4nocrNplRpJs7Cg+cU+j9BixE09tBrd9SJwG?=
 =?us-ascii?Q?TNqBoxDx/J2NxjmSsInIr/NVKwY+i1LYez8s1uFwgDrGnpVVLdgVihAibvBx?=
 =?us-ascii?Q?gwK6Nqtt1JHyM6dQGSF9lUf4G14CBuYRQtpvpTDJ0jg1z2SYYpmq+0zTDIaG?=
 =?us-ascii?Q?YgBu0aozANBVoBWqzoBYJ3CYWtBndxI3VGb35qpHvoXjpe7V8VSszRzzZCA2?=
 =?us-ascii?Q?A+QwJ8XuE7/bXuXhuuHB399EPY+vYquQGqtufNHXL/h0sfgnBh8ZrrO5hWat?=
 =?us-ascii?Q?u9Vh8GxILKYg8J/ImjRC5hup2E0hvTS7wuO5D8AG5lcVqk/FX2KZdH1QJWWR?=
 =?us-ascii?Q?sYyXs5hACea7XGY9n3aIPUvqvze5/ImNatqsKbB/R31wgVXyCF+/F2dtwIPE?=
 =?us-ascii?Q?c14PeKJ5lgIM4jfYpRQLbZ2ZLG/90BgSrg/Xd2EPLSO4ZYCUNnj9ZqW/mcG4?=
 =?us-ascii?Q?Ty6OoR+3yb9S9saHSkhnsrSkMKy0NXjBfF5l1XOozryrqTckE6bcT3JutPbr?=
 =?us-ascii?Q?lCAjdPvoEogcXRZHmnZudyHQaTew2sEasiSR7/5ggg4DB6tPPSIMERv5pmrB?=
 =?us-ascii?Q?k5S8TZ6mslxzeMG5DAG3XzUkrHRQDWhsQkLfjp88c6q7lgWX68If4Es76bWc?=
 =?us-ascii?Q?DgaZGnHRc1301a7Amj+sTxgiRYTAXArAs1Lksx3tu2YWQ88su3Dv/Dkgde8M?=
 =?us-ascii?Q?fObdmsqCA9gEvGvdgI6/2rKSBYEmVTdill5MbV6/uPDGZy78N4Wu8DK4JRQw?=
 =?us-ascii?Q?fp1iNHbxYbwqZ1tp+fF0MWJI0seIKSRpSBoFDoLO1xS4XMivLKg4IpGPFSAG?=
 =?us-ascii?Q?w2dUVLdy+1dfMpBq1kY7uRkaJwe5VdsCBq3opcyi39xvDapi4wDNbmeGDH9V?=
 =?us-ascii?Q?pBWs6rxKpPUHBio+gtZB0iHxMpRGpK3rOoY+huMJdYVYL+cqqrNqb/hTiYoH?=
 =?us-ascii?Q?ihoeWEX3J5H3Bh2ZDHe2ku2TFkiroFJSJtgA8nSeJtN7T0VfsWp8lZu8e4Id?=
 =?us-ascii?Q?Fra8yiDzDDLPTIlB7ktpNK5dkS41fwxyC/OJ4NtsQAYiwbfOUy/AGUaboc22?=
 =?us-ascii?Q?0r4sO0XzZbIDWSNU+6kooLj2d5nhHcf31sWwTyUTfjF5i1C1y9yB2fPrx5Mt?=
 =?us-ascii?Q?2CTAjzqe8WynbvhXW26VdLP92Rua0zS6vrqGDU3u/+xfFYV5qrQX3IQ6Fbii?=
 =?us-ascii?Q?PtnmsDfowlFc/F1H7wJxiUiKQRGz2u4AgCKGGdbQRTHPbKtQdzSVD8ZYJXss?=
 =?us-ascii?Q?1xZ+tXBqVm77T+Lm9Imayl0XW5wngX0yP2OpN8lYZrTx+I2tQURuSv/RaMwr?=
 =?us-ascii?Q?VddX9b0lMr3DCCjXxYS0S2tb/nd6E3PmEluzQTsBHpxjFDU9/iXUo2QrFi/S?=
 =?us-ascii?Q?jgWtBQbbGbrjf0tFQrGtT33Xyk2ZKj9WojcIOl5XYhkqFwgfPgOKXn6GjoGO?=
 =?us-ascii?Q?7K8q3HZ5ivI4//jNGpNoiKtLS/ZoUEfGBwiDS0CSME+fi2zbkfcoT+g9dkuM?=
 =?us-ascii?Q?JujRNUPBu/Vt/hpcAVNTlvIUXsJrcJo5OKCI4/xnUAZj3KS23tqS2morT0RT?=
 =?us-ascii?Q?vdKW1YgiY+pczYKlnFYIm468aYbu3OM8xM6E4gHb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cecaf20-f3fe-46c8-cc3d-08daee91aee9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 20:24:30.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yY8U1OYTOFODL8hR87k0mu1XVWGXqc2FSKNYgt7bu0Vgm0zfCr0xRs9xM8RRh+vtYodObFhRwU2+2ndIUdwvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:34:16PM -0800, Tony Luck wrote:
> Systems that support various memory encryption schemes (MKTME, TDX, SEV)
> use high order physical address bits to indicate which key should be
> used for a specific memory location.
> 
> When a memory error is reported, some systems may report those key
> bits in the IA32_MCi_ADDR machine check MSR. This is legitimate because
> the Intel SDM has a footnote for the contents of the address register
> that says: "Useful bits in this field depend on the address methodology
> in use when the register state is saved."
> 
> Note: I don't know if any AMD systems include key bits in the reported
> address, if they do, they also need this fix. If not, it is harmless.
>

The following note is in the description of the MCA_ADDR[ErrorAddr] field in
the AMD Processor Programming Reference.

  For physical addresses, the most significant bit is given by
  Core::X86::Cpuid::LongModeInfo[PhysAddrSize].

And I see that x86_phys_bits does get fixed up in early_detect_mem_encrypt().
I'm not sure if key bits are included in the reported address, or if the HW
automatically masks them off. But in any case, I think this patch is valid as
you stated above.

> Add a new #define MCI_ADDR_PHYSADDR for the mask of valid physical
> address bits within the machine check bank address register. Use this
> mask for recoverable machine check handling and in the EDAC driver to
> ignore any key bits that may be present.
> 
> [Credit: fix is based on those proposed by Fan Du and Isaku Yamahata]
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reported-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reported-by: Fan Du <fan.du@intel.com>
> ---
>  arch/x86/include/asm/mce.h     |  3 +++
>  arch/x86/kernel/cpu/mce/core.c | 14 +++++++++-----
>  drivers/edac/skx_common.c      |  2 +-
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 6e986088817d..a8eef87fb12a 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -88,6 +88,9 @@
>  #define  MCI_MISC_ADDR_MEM	3	/* memory address */
>  #define  MCI_MISC_ADDR_GENERIC	7	/* generic */
>  
> +/* MCi_ADDR register defines */
> +#define MCI_ADDR_PHYSADDR	GENMASK(boot_cpu_data.x86_phys_bits - 1, 0)

Should this use GENMASK_ULL in case we're running in 32-bit mode?

> +
>  /* CTL2 register defines */
>  #define MCI_CTL2_CMCI_EN		BIT_ULL(30)
>  #define MCI_CTL2_CMCI_THRESHOLD_MASK	0x7fffULL
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2c8ec5c71712..949705bdb2f3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -579,7 +579,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
>  	    mce->severity != MCE_DEFERRED_SEVERITY)
>  		return NOTIFY_DONE;
>  
> -	pfn = mce->addr >> PAGE_SHIFT;
> +	pfn = (mce->addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
>  	if (!memory_failure(pfn, 0)) {
>  		set_mce_nospec(pfn);
>  		mce->kflags |= MCE_HANDLED_UC;
> @@ -1308,6 +1308,7 @@ static void kill_me_maybe(struct callback_head *cb)
>  {
>  	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
>  	int flags = MF_ACTION_REQUIRED;
> +	unsigned long pfn;
>  	int ret;
>  
>  	p->mce_count = 0;
> @@ -1316,9 +1317,10 @@ static void kill_me_maybe(struct callback_head *cb)
>  	if (!p->mce_ripv)
>  		flags |= MF_MUST_KILL;
>  
> -	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
> +	pfn = (p->mce_addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
> +	ret = memory_failure(pfn, flags);
>  	if (!ret) {
> -		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
> +		set_mce_nospec(pfn);
>  		sync_core();
>  		return;
>  	}
> @@ -1340,11 +1342,13 @@ static void kill_me_maybe(struct callback_head *cb)
>  static void kill_me_never(struct callback_head *cb)
>  {
>  	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
> +	unsigned long pfn;
>  
>  	p->mce_count = 0;
>  	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
> -	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
> -		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
> +	pfn = (p->mce_addr & MCI_ADDR_PHYSADDR) >> PAGE_SHIFT;
> +	if (!memory_failure(pfn, 0))
> +		set_mce_nospec(pfn);
>  }
>  
>  static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
> diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
> index f0f8e98f6efb..806986f03177 100644
> --- a/drivers/edac/skx_common.c
> +++ b/drivers/edac/skx_common.c
> @@ -657,7 +657,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
>  
>  	memset(&res, 0, sizeof(res));
>  	res.mce  = mce;
> -	res.addr = mce->addr;
> +	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
>  
>  	/* Try driver decoder first */
>  	if (!(driver_decode && driver_decode(&res))) {
> -- 

The address decode in the AMD64 EDAC module operates on a non-physical
address, so this update is not needed there. The MCE recovery changes look good
to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
