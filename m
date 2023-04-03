Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22CA6D3D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDCGU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDCGU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:20:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977847695;
        Sun,  2 Apr 2023 23:20:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680502845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i42bYRlR2kxtr0gbsfE9X6XNMmr22amRVlMTmSUpKYo=;
        b=cEqd0YLaWwP/vnr5lIBv03l5pHM2JWrtJsop+GgvwoYVTyymV3kNlAmsZte5gu/34iaKte
        6rXfOtMZj7Jos7sskbeViOFEujeDJWbnh3M0YsFhvDT4jMVwV9YJnElFzK3oDcAsW8D4gx
        OlF/XPzYVXsKzPXeO8e7WJQIq+Rq+2vJVMzDKuikO8bkRsGxsu/7lMi8j/I1uD3KKOh6hs
        90c8jb+p6V1NDuBd7TrwXmg03WSz48u/PkgXTUHnyKuzS3m0EQP5lRYfzhqieDC2nraQdU
        etsJ6LUr4yQUdvF714lABNduwiffcUlOxlBokxI/Ofti/mwiO6/xIwnucemhRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680502845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i42bYRlR2kxtr0gbsfE9X6XNMmr22amRVlMTmSUpKYo=;
        b=RuAt71zBd1H4cTsCQ/ZvDpU8FcnCA3H19MrqzS7AYadaBjM0NZzjhazlHRTK7xQOYbg+XT
        gShlLA/Ge7ObjpDg==
To:     Borislav Petkov <bp@alien8.de>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
In-Reply-To: <20230402154425.GCZCmi2eiKYO2yYhNs@fat_crate.local>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
 <20230322154655.GDZBsi75f6LnQStxSp@fat_crate.local>
 <1d25221c-eaab-0f97-83aa-8b4fbe3a53ed@linux.microsoft.com>
 <20230322181541.GEZBtFzRAMcH9BAzUe@fat_crate.local>
 <ecf005b1-ddb9-da4c-4526-28df4806426c@linux.microsoft.com>
 <20230323152342.GFZBxu/m3u6aFUDY/7@fat_crate.local>
 <105d019c-2249-5dfd-e032-95944ea6dc8c@linux.microsoft.com>
 <20230323163450.GGZBx/qpnclFnMaf7e@fat_crate.local>
 <c8458bfa-0985-f6a5-52a3-ef96c7669fe6@linux.microsoft.com>
 <20230402154425.GCZCmi2eiKYO2yYhNs@fat_crate.local>
Date:   Mon, 03 Apr 2023 08:20:44 +0200
Message-ID: <877cutsczn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02 2023 at 17:44, Borislav Petkov wrote:
> On Fri, Mar 24, 2023 at 06:10:09PM +0100, Jeremi Piotrowski wrote:
>> Since the AMD PSP is a privileged device, there is a desire to not have to trust the
>> ACPI stack,
>
> And yet you do:
>
> +	err = acpi_parse_aspt(&res[0], &pdata);
> +	if (err)
> +		return err;
>
> You don't trust the ACPI stack, and yet you're parsing an ACPI table?!?!
> You have to make up your mind here.
>
> Btw, you still haven't answered my question about doing:
>
> 	devm_request_irq(dev, 9, ..)
>
> where 9 is the default ACPI interrupt.
>
> You can have some silly table tell you what to map or you can simply map
> IRQ 9 and be done with it. In this second case you can *really* not
> trust ACPI because you know which IRQ it is.

The real problem here is that the information provided about the overall
design and requirements is close to zero. All we heard so far is hand
waving about not trusting PCI and ACPI.

Jeremi, can you please describe exactly what the design and constraints
are in understandable and coherent sentences?

Thanks,

        tglx
