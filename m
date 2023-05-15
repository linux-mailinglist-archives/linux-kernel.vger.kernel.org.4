Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E7703457
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbjEOQrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbjEOQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DB55B2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:46:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684169216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpj7N2DErNTzd5P5gqMYH/lDieuO5YjYWf4Tm/Z0Acw=;
        b=eHzRUmq2Ncgpa1Nb1PBpLkTED7LFWDAiGxOmJc11skvE5B4zBkb1ST2pDZnqZAMud7kXr4
        9leWcrmrZ5LIZmZBUN+IB8fgClErBNzAf3Ju87F9a+9HBtE+bOLJSPoZP5PL/1Rx0+vzgw
        mGz15yyh6I5XzfGvYpbpUWfvYjvHdlNKpWEqPeIrfAsqJoE9jfOBr3+OQJ8oKHX8f2k6ar
        MM7gIpXIx+BHzamLEcIx2KX3ayzkyQs4Vu5hszAlDoyavzplPdAV3mZkKb6YLV9T22lapl
        v+SeGx6swJ+gPq76c6G+7yOlq+85+gIzOshOXHuAOroKAWqBfgWkwJFDWVQdXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684169216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpj7N2DErNTzd5P5gqMYH/lDieuO5YjYWf4Tm/Z0Acw=;
        b=QDV9ivp7GhYU8ZSDJAetzk+NfDA8x+MCbiy2+tgvX6DeEGrKUJRu2VYbqdVXKztb8wV25I
        TGfYPu5h5tmXwhDA==
To:     Nipun Gupta <nipun.gupta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
In-Reply-To: <8efbbe8f-62f8-4711-d069-44905c841709@amd.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com>
 <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
 <87bkityxk3.ffs@tglx> <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
 <87ednnes6o.ffs@tglx> <182c4d7b-9e91-c00e-43ab-a2c0bd671828@amd.com>
 <875y8xbemu.ffs@tglx> <8efbbe8f-62f8-4711-d069-44905c841709@amd.com>
Date:   Mon, 15 May 2023 18:46:55 +0200
Message-ID: <877ct9a6f4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nipun!

On Mon, May 15 2023 at 18:39, Nipun Gupta wrote:
> On 5/12/2023 11:45 PM, Thomas Gleixner wrote:
>> On Fri, May 12 2023 at 19:50, Nipun Gupta wrote:
>>>
>>> As per your suggestion, we can add Firmware interaction code in the
>>> irq_bus_sync_xx APIs. Another option is to change the
>>> cdx_mcdi_rpc_async() API to atomic synchronous API.
>> 
>> I'm not a great fan of that. Depending on how long this update takes the
>> CPU will busy wait for it to complete with interrupts disabled and locks
>> held.
>
> Agree. we are also inclined towards using irq_bus_sync_xx APIs. This 
> would definitely solve the issue (#1 and #2) for the setup_irq which you 
> mentioned.
>
> For MSI affinity, since GIC-ITS always return IRQ_SET_MASK_OK_DONE, the 
> irq_chip_write_msi_msg does not get called.
>
> msi_domain_set_affinity(...)
>      ret = parent->chip->irq_set_affinity(...);
>      // For GIC ITS it always return IRQ_SET_MASK_OK_DONE
>      if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
>          irq_chip_write_msi_msg(...);
>      }
> Since CDX bus is specific to ARM and uses GIC ITS, it seems we do not 
> need to do anything here. Can you please share your opinion on this?

That makes sense.

Thanks,

        tglx
