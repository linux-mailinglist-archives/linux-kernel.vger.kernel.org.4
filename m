Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A36C3A40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCUTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUTSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:18:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A63E057097
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:17:34 -0700 (PDT)
Received: from [192.168.2.24] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 70AE320FB884;
        Tue, 21 Mar 2023 12:16:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70AE320FB884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679426196;
        bh=+1HBLqwsmdek1oHFS3cETPVSDhtxgzhreGSVp7zvWXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MXTQaVZByTr6OP8kP/qAmoA3P4TDG3lCdC4aMxf9D73VEdxQHgnnCkDopsqannC3h
         lSHhL6/DEj9fLbWvIW5Y/qRlRch2cw/RSLGQp8rIf1iGkjEA0RAVZ6PDIvZAEUvvgF
         Xo/lWy+bkHp/UWij2jvzbfEIkzB0wgG43G3x4Vrg=
Message-ID: <89c227a5-0db6-7cbe-6beb-4035f58f036b@linux.microsoft.com>
Date:   Tue, 21 Mar 2023 20:16:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/8] x86/psp: Add IRQ support
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230320191956.1354602-5-jpiotrowski@linux.microsoft.com>
 <87h6ue9z0p.ffs@tglx>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <87h6ue9z0p.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 11:31, Thomas Gleixner wrote:
> On Mon, Mar 20 2023 at 19:19, Jeremi Piotrowski wrote:
>> The ACPI PSP device provides a mailbox irq that needs to be configured
>> through the ACPI mailbox register first. This requires passing a CPU
>> vector and physical CPU id and then enabling interrupt delivery.
>> Allocate the irq directly from the default irq domain
>> (x86_vector_domain) to get access to the required information. By
>> passing a cpumask through irq_alloc_info the vector is immediately
>> allocated (and not later during activation) and can be retrieved.
> 
> Sorry, but this is a horrible hack which violates _all_ design rules
> for interrupts in one go.
>

Ouch. But I agree and it's not like i was trying to sneak it past you -
I just didn't know how to map the hardware behavior to kernel constructs
any better so was hoping to get some guidance.
 
>  1) What's so special about this PSP device that it requires a vector
>     directly from the vector domain and evades interrupt remapping?
>

The PSP interrupt configuration requires passing an APIC id and interrupt
vector that it will assert. The closest thing I found that provides me with
those was the x86_vector_domain. Here's the link to the ACPI interface, the
relevant info is on pages 13-15 (it's not very detailed, but that's all I
had when implementing this):
https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf

The platform that I have access to for testing does not have interrupt remapping
so it's not something I thought about. I don't know how this thing would behave
with interrupt remapping.
 
>  2) Why is this interrupt enabled _before_ it is actually requested?
> 

In this implementation: so that I can configure everything before setting the
irq number on the platform device. I had a version with an irq domain that I
wasn't happy with, I'll talk about that below.


>  3) Why is this interrupt required to be bound to CPU0 and still exposes
>     a disfunctional and broken affinity setter interface in /proc?> 

It's not required to be bound to CPU0. But yes, with this implementation
smp_affinity does not work (effective_affinity is correct though).

> There is absolutely zero reason and justification to fiddle in the guts
> of the x86 vector configuration data just because it's possible.
> 
> This is clearly a custom MSI implementation and the obvious solution is
> a per device MSI interrupt domain.
> 

This is an interesting suggestion, and it wasn't at all obvious to me that
this maps to an MSI interrupt domain. I'd love to get that to work, let me
ask some follow-up questions:

1) do I need both a standard irq domain and an msi domain?

2) what domain do I take as a parent?

3) i will still need to extract apic id + vector from somewhere. irq_compose_msi_msg
   or irq_write_msi_msg seem like candidates, but then i'd still be relying on knowledge
   about the hierarchy and need to poke at irqd_cfg or read msi_msg.arch_data. Am I missing
   something, do you see a better way?

4) will this actually work considering that the PSP will not actually write to an
   MSI address, and that I can't use all the data contained in an msi_msg?

My first attempt that "worked" used a plain irq domain and can be found here:
https://github.com/jepio/linux/commit/43c9ed6de82a3ae6c3f2d7894b3da049cb1ea4e4

It had this structure:

static struct irq_chip psp_irq_chip = {
	.name = "PSP",
	.irq_enable = psp_irq_enable,
	.irq_disable = psp_irq_disable,
	.irq_set_affinity = psp_irq_set_affinity, // calls psp_configure_irq(data, cpu num)
};

static int psp_irq_domain_map(struct irq_domain *d, unsigned int irq,
	irq_hw_number_t hwirq)
{
	struct psp_irq_domain_data *data = d->host_data;
	// this used a global system vector instead of x86_vector_domain
        // and i needed to program to some cpu otherwise psp_irq_enable fails
	psp_configure_irq(data, 0); 
	irq_set_chip_and_handler(irq, &psp_irq_chip, handle_simple_irq);
	irq_set_chip_data(irq, d->host_data);
	return 0;
}
static const struct irq_domain_ops psp_irq_domain_ops = {
	.map = psp_irq_domain_map,
};

static int psp_init_irq()
{
	// eliding lots of things
	psp_domain = irq_domain_create_linear(NULL, 1, &psp_irq_domain_ops, &psp_irq_data);
	return irq_create_mapping(psp_domain, 0);
}


This version had many flaws: it wasn't hierarchical, it relied on a static
system vector (it was only later that i figured out how to dynamically allocate the
vector), and setting irq affinity didn't actually work (due to lack of mask/unmask
I think).

Jeremi

> Thanks,
> 
>         tglx
> 
