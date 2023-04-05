Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699F16D7752
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjDEIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbjDEIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:50:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 617A92736;
        Wed,  5 Apr 2023 01:50:14 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id B71A4210DECD;
        Wed,  5 Apr 2023 01:50:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B71A4210DECD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680684613;
        bh=57bX2Yn8I2wf2e2nSid0EfvUv8qculkKdJgSF0wuaDI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iFVxKM2NDuDMdhtMT/d9+4pCUGi1W+d9juefoMlc51Ur6HIxAfXT48Zuzxyrd0me0
         E6N/u4B9cPxr/O9iTE5I1hgsjQnFVMPmZaKvzdNZi0wSda9Ku+bX+rzploONz0qou2
         tSxj70KaD5qziqt+mXesRRb6+njF2ssR33e4y3V4=
Message-ID: <ceece3a9-bbe9-f8d4-f446-c2c8dd285a8e@linux.microsoft.com>
Date:   Wed, 5 Apr 2023 10:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/8] Support ACPI PSP on Hyper-V
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
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
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230402154425.GCZCmi2eiKYO2yYhNs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/2023 5:44 PM, Borislav Petkov wrote:
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
> 

Sorry I broke threading. Meant to post this email:
https://lore.kernel.org/lkml/35f6b321-1668-2b62-cb47-3f3760be2e1d@linux.microsoft.com/#t
as a reply to *this* one.

Jeremi
